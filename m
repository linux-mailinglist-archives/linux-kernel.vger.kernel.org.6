Return-Path: <linux-kernel+bounces-525069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137CA3EA69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C0189DB5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86E11D54E2;
	Fri, 21 Feb 2025 01:56:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BE1D5176
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102964; cv=none; b=UFC7gVXlBgAAXMSBcisvIK4kJjAWNtmybPt53PyGsJxrJny7RFqZncibKmAYGfjb8Nmg0bxxfHcclrEWiojTYHiPz/6KB4/LAV0F3gYeyJ1Qqg9UKPx/LRugBG3w7K9yPvnWk5GideuxiMEhZcuI+VjMIPhABf9KFWEb+YA0QtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102964; c=relaxed/simple;
	bh=STh2YX78ZDfbtml6qKHxT2VcEbA9Z2JC+Vv+w7Wr0sw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iTxhsfZbkrjvKS4bojw6yu7DNyd45v+erEP3ijj/1dU6VnQXg7++0nuZXu3auf/idOJeborAYi0hMcFZHyE4Y1HCQRGifIjsfB2wV/NmaayoppyuQpitt7Ku8AncOU2Er3S2P9S73o/6mOOAjn43GFPv7sfLuZ4wXXtfxxs4yNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d18700311dso12827735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102962; x=1740707762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b84CgfzTwpXM7kKlKOzBct9rr+AuHUtJOlB9n8IuyOk=;
        b=Rf89J/1FA6QWw2Ar+It+TPzPka4iL+dBQcRmS19sfnMAWsUz1Af/TLWWoCKso/K2HQ
         sbc7Tp+fv8uNAa2ugfdfi9th2QoFXuj1iUtZNFQiJHIBAH1xsIxLML7o7FvBk+TKJcMq
         Ulx+irc/9vlE4LoY6j1rCFnudNdgPVgwsgDvcK+sY3B0D04402TmxGrPz/w9tmyK2nvC
         jHqhmEJqAwY7PTntCL6BfMIiz7YPg75wuYwidYYIZHN1c+HWyHPGoNhPpXs8hGW2pyMF
         NqCMXohUtuan3xTLY/cKCWdHtwoQbvuXX3cl+ygCLyca318vvjbUGyBz6vFWCT0TqhlG
         3D6w==
X-Gm-Message-State: AOJu0YyoIcsBSU+oDvjGLHH1NPwJ69etwp/mtHWR1TMEk0pv4S0PRhuG
	GbmA+zy0FjfeSjmuPkOBfe2DYlca5nSmawhV6Fo5agQ7CeQIUowoH9xYLTuHbtD6Z45TIA5V2yw
	NgjasHm2QYkn0kgFZsh3DqDXaHv0dTZuHN/dK82utVHozgAAvPXjkDPY=
X-Google-Smtp-Source: AGHT+IF0CFsgsyYN18dBK+qbkaWFXCosy+NQcOG/OZWwTRBzVM2TyMloIZszv+UIXtCYp4jOxkahp2H0GeZ8QOnx0ReaLfKaVT+/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d18:b0:3d2:b4b8:bf54 with SMTP id
 e9e14a558f8ab-3d2cae6b78amr14105595ab.7.1740102962019; Thu, 20 Feb 2025
 17:56:02 -0800 (PST)
Date: Thu, 20 Feb 2025 17:56:02 -0800
In-Reply-To: <20250221014507.1829800-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7dd31.050a0220.14d86d.0306.GAE@google.com>
Subject: Re: [syzbot] [pm?] possible deadlock in lock_system_sleep
From: syzbot <syzbot+ace60642828c074eb913@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/params.c:586:13: error: invalid use of void expression
kernel/params.c:612:5: error: conflicting types for 'kernel_param_trylock'; have 'int(struct module *)'


Tested on:

commit:         319fc77f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=61cbf5ac8a063ad4
dashboard link: https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11503ae4580000


