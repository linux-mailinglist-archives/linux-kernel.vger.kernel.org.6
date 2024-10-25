Return-Path: <linux-kernel+bounces-382165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACB9B0A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9C9B230E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F21E00BF;
	Fri, 25 Oct 2024 16:50:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8014170A31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875006; cv=none; b=JyOliF4TGtgndQbW8UL8qFMDp/KoVa4P8m7wE5BkBvsxwcasieA2a9L7XiOmoDcOi/ZnDlaFgx/ca87CoxM+zyxMCzXlPPvNnFfm5JfNaNRcoZPlVRiDPSCOAd8Vi7yzSBqCp8YP6RBo/BaGjp5qWGUIgudCFjkEuwGi2fPjjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875006; c=relaxed/simple;
	bh=Ht4xAWAtcJpdHAcAKQItIdrdxVyqv+NmaPVhTr6acNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fz6rXvhU5jZ1OEYW8iAgPyn8xqaDsMNIAxuHgmjOg+7HNSYYNG7zWAHUaZym6DaFd+i8bvSrnxSfTvrq48BLok0DKnfdKsNE8yX2LyI/gSTUlUIOiNXNVuaqsQS4v5ip5pkT0nf9wAkm6ctdE5qSPabaveBGqD9YHHAdhbJpVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso20288645ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875004; x=1730479804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG5Wk3DRkUN39otpxN6Vj6j9fCX230jxgb1Gx+yrumg=;
        b=QXKYHjeEjKbNAZepe7cS2z44Z9XdBxDtmb1x9Hz0HerAAvriSao1R5Px2wsiDmZySc
         obPqagNj/ydb7rwgW0IRf+GNIPmwDHQVbe9p2aQmUvzoZc5PAY06qpnIzmheDNXeZjtR
         PK8oYJaWB5ndkz0A0foIuq9sothK5GQymeZrL2iAmKCA9FOInsf72PV0Gd+AFluDF5Ej
         CScu0Xlb+wNyTKFdIHWDXhWmnZSGJDjqEDOmFhnj/db+7rXqhzcoDu0n2SqoH10fBovt
         Um2VMYV8WBvJrB0KF3wv29IRgGFwo5eCCh1SWV15bwJ7k4MvqZgJeSCClHjxBqKmKtky
         xNug==
X-Gm-Message-State: AOJu0YzzufUdAozW3X7iQn8rzfu/VNi7rhbPTgprJlbmCbnMxnU+v7K5
	DdOO23GUOSr1dhLXJWrxbo8qY6zItMNLZ6sxMN2/yRwU3bt5Q98L/s7CYvgCllgqn5gnzc+PtqL
	7+IFy0wQTF9j38tQQTwwjxn+84SHVdaU16RxxS+eHlFpBsFMdm3D+OIY=
X-Google-Smtp-Source: AGHT+IF7Jv46O0j/93tfQ70u/HRhD74UFlryonQfnQsCJQyWLLteXhtNf9RCg3uFzyfulmwN51XIX4ge2lzvfnwPwH7FhoWi3RY+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:3a3:be8a:8717 with SMTP id
 e9e14a558f8ab-3a4de7b8c56mr71588545ab.15.1729875003793; Fri, 25 Oct 2024
 09:50:03 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:50:03 -0700
In-Reply-To: <20241025163019.14018-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bcc3b.050a0220.455e8.022b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zoo868e@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Tested-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17968230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1231b287980000

Note: testing is done by a robot and is best-effort only.

