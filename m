Return-Path: <linux-kernel+bounces-410387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB649CDAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B161EB2500A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B918C018;
	Fri, 15 Nov 2024 08:47:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF27346D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660425; cv=none; b=QA9NinYBU5iF0pKH31eNMPBQPiMr2Xrq99p/uEWAHcEAi8OoDKSQlH1gIRJ0+Qk9CLByB4hl3tNhqWgzgQaemFGOXBJx77SjvGsu3szAtQkMDbXrtkd22TQEW0cEHGsmKWjMSTskY+c9U9egyMoZGwaBDIR7XNEANUH4fs+0wvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660425; c=relaxed/simple;
	bh=8000m+3Gyl2pBXIGHIAh5VRI/r1CiJUgzMOkzd8OrmU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tZJlzmg621ZtsnCx2rXWba7CswZbm8Qh+AIPbgLsAef+9aACn0OgsuZdfYb2hKVJJabYtkrfBmXX85uPhpCagBLUX0Gutpjbvjc8z4ZpsljUZdk0EkgbeFTjrEKNoRFl3Ll/y369xQsLFGHQzsNJb72o1OtK8G1vSSiA4fjA3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83acaa1f819so160615439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660423; x=1732265223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZuSKYrr0Gbbg53xQHJrLY+qp9HHwk9HESzx2ioHzSU=;
        b=JsaGLYtqSe+jqKDguqmofbwMFwqAqqGBpCi6lEkdkaf7CX+99atghDXY7Et8tFHi0i
         VHsMPmKd15FvLGSctKs6BzdCfyqKSlqb4AGirvb1hwWb1hnE8prPDYo+z7HkkQUiasDL
         C5c7lHLaWKMaK2qCtwVm5F3xt8D10YeUtHQxutc0mgnzErQQ02bB89lYTQF5hrgafE1L
         gOUFP54dypK+IhghCzfZ3H2+c6VK66WAOW8Ve2JDIKsUctYrGndE211nmah2Hjz0pW4Z
         F8HKNohuBTLIkxV6UsKaiX53HXEPR74XMkQKc1BleDAn/L15W0NmHtKDRP/zGf+F6EAp
         gRZQ==
X-Gm-Message-State: AOJu0YziAyhWdpYh2zUIqA83/iDHRxTTC9SbAiYJRYN2EwMOOvUjME/a
	exLUOCD3+egwZeBJv3Cq4LOZX6yYKg8QRzWVlPjG+/Ipbt4ygyRGqZQ+hGuvF4YrpKW+N2BWTot
	ftK4dffGQsBdmyqypYAr0ISS3xZZXzCZD/mT3ohHD7U4vuSooMHl326I=
X-Google-Smtp-Source: AGHT+IHfYepQ5noG5kCXXEBLmb/afgIkDB5p2EdEJgRkEkHNbPvxq8iBfuK9N/J49QHxZrTleKjlV6nnPPIPpgOKN+N4yXCh+HjR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d04:b0:3a6:f82f:37c2 with SMTP id
 e9e14a558f8ab-3a747ff8e96mr20143265ab.5.1731660423362; Fri, 15 Nov 2024
 00:47:03 -0800 (PST)
Date: Fri, 15 Nov 2024 00:47:03 -0800
In-Reply-To: <20241115082628.3568444-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67370a87.050a0220.1324f8.00a3.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in pick_link
From: syzbot <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Tested-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com

Tested on:

commit:         cfaaa7d0 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ea9130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=73d8fc29ec7cba8286fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140931a7980000

Note: testing is done by a robot and is best-effort only.

