Return-Path: <linux-kernel+bounces-407572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8744F9C6F07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA55284AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E48200B9B;
	Wed, 13 Nov 2024 12:27:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0C1FF035
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500825; cv=none; b=o9QZQCL4xkLbSxBc9RT86XnGrgV08AQKVZh3FGoA95JZspXzC2x/TLTYA6Hni91aNpjFfU1o+k/Sw7INwQNyGQNzp05cSWJVUlVTSQmELmz79ylnNCaOw72+HNZWxu/PPO6HHthU7CiAq+WW+aUln02+L/1A7OoCTBdIiJX6e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500825; c=relaxed/simple;
	bh=xiNg5znueipvPFwimPHq7hUeF96APnXAhZtTEakQbl8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zf01N2ate7te4E9NDZumgtrYBkS5pvwp7Mh4GUKsIyiImc2CW4pxiS2uhYloybz1a+NqOTMfmRpuEWR9pOVRkPf9c6REyIP7FQS8VlAWvExJmQ/QBQ2SGTB0H8YtD0y/RY2NTUgY7LLu/p5TpNY647wJA+e/eSzckyNrwBUFvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3cb771556so83499725ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731500823; x=1732105623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkcdwbKwC54ksa1xeYHfLKc13WBWF+TVFlXOuA4rNF0=;
        b=IBGIl8QmJITpp8OlnnibnEepkn3SFssCgHBe04HTX1wToA2lRxU6h0lPnd2n7FYBDy
         xu5HF9G8TVJyNr1UiQsVxv1CgECFLYzb/t9rg33HyWmkKXahPDzneKl31Mx0Ib75M4TV
         /G2QEQAMBNZocN+3n4gUQD1yZ3sktRK/26aG/MmMjKFFiA+8p/n7kpk20sFQ/2mcM783
         RHo1HNaZOwndYFI868Vk2T2RMJUNWzjL4GyM8SnU2co5VAC6pEJH3Li7s26BQ75idceX
         Bxz1vLIB9N2DokX2TeMyKt/ixSJAi56S/0U6/dLx6B6kx0Tj7TDc0jLst4p/K7tp9B0J
         lqQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNmce6A27RCzSXAcYR4U+Qqx85vowU6nZ0cO9f0IuLp49lJQ8raLrbSx2DMG3q93dsRJu3MRkJJv4ni4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvpOl6VXKv2xRhqBY+libBQDqonnrfoBTNANsNy62B1fD2PI2
	6yTWsenKlvRBUx7K+5KHzxgmL08rQbiSHD+ZZZyg3w6Vw6QNDy4gtI/5n67Bg1dyHyiKm4YoGBB
	SvVCP0SC0gF+MlZp4epqEQn3g++Z4BvMO325xso3TC6Jf1nwxmuBCNIQ=
X-Google-Smtp-Source: AGHT+IH3YeeJ2wjRzyTxUBU/Fz7blpElgbrjvFEVwsIv4HlOM4uInB40FGzuJCij+kZxQsisXAtEUePo4IU5xrL3FSdx7sDQuG9E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3a6f1a6440dmr210634735ab.15.1731500822810; Wed, 13 Nov 2024
 04:27:02 -0800 (PST)
Date: Wed, 13 Nov 2024 04:27:02 -0800
In-Reply-To: <CAHiZj8j+=3paytYbPMDqof6cVYxSFjjaev1PTc0EUsNz8hXExg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67349b16.050a0220.2a2fcc.000c.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         f1b785f4 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca8df7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d20b5f980000

Note: testing is done by a robot and is best-effort only.

