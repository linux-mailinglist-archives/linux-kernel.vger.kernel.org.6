Return-Path: <linux-kernel+bounces-304208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57C961BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CA91C23134
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633D47F5F;
	Wed, 28 Aug 2024 02:09:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29541A8F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810945; cv=none; b=agc3Z+u0p591JJlLVE0B6LHbCtEsOEPTTlS55rUNGB9Dmuq4XM2DtcLCD+L6wrODqGkwA97JnTURb/24SHKhoeL5ENED2Sqwl1hpXu3hzEor5a9118t33EIj2XPnY8EFxKOl/X/Fo+dVGVDPC/1LKePt4KClaSXpqY43TPGqi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810945; c=relaxed/simple;
	bh=JTAgtH1FK4QFJ+PT2KPuTpjXRpXLH/Dr4z5LJGN/NTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MJR3CvuxYmQFg2bvTMpq1JmF7ZSGPqDEOtvCU1tKRscNcFijmm4psNPQ2JwEIUtJ+fe0byYr5prRhXGnBrOv94IzsonstHEEz5j3YWmsC5xKtJX2hqmTVt8VbjSoP2IpnNhCwAxL7FRhmX6cJCZhvlvufp7K5j1WOlwA8OaWM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f99189f5fso683260639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724810943; x=1725415743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oElMfIFCafP5iISSwnztMt9g5uHWynMraVT0HFC/h38=;
        b=uU08q4l4QlcEL/MYiGR/8ZJJh0bvzOTFBqLsVHd0nrFX7z/MEd1IG4Wzo8TkynHxcG
         abIr0bRdiEpo7G27muGFcm52EpXlrFLUs0XFP2THLN5VIRE04JQJdx2ogVKPyzbx1HrP
         sVRPjtZYvC6dVC8P4cs5Pml3/sxvpOCVxeCjkbDSvPcsfqDXSsu6+jwv8Lrq0Fsve2Pf
         lXaPfjyVUMiV12CXc83phPakqC2UGrzhbMC+wv8jQKF7vEvdDHssH8ZIjB6f8g8rlO8N
         HjewQDkNDZ8EIGc466Am0KuBJMCFNde6X/4x8wUWu1EBS/DIwmyrQS+1q6vpY+3KUy2B
         5QRw==
X-Forwarded-Encrypted: i=1; AJvYcCUvjCGknGxzdBJUhN12fijJtc+1IoxkO5E5vdsB9tbr5N1pc8su7r+x6uob3QUAgR23RSSunrqFBUiKJ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOa9YZelhNMJ+ZyS75/9u5C75QQ4xHZCmJ/9xFKW6miXjHfAD
	qfmISGyg7SWhjzMeCZbyPrEyLkWzehuWafzEWxlb4n3yWCIlP+7eXL09cPG9ygzwxdV2OGUK7nq
	EKV15USfm99yfuQ5IiLIPBGj2hHY68R7/+s9tgLscrcmYYe6Lcku2FvM=
X-Google-Smtp-Source: AGHT+IGQugPbogG3CqxiNvn+4mImP5pvpk0ROFp/+Mh6vXyrgJ6SdaerED6fc8HvIQnEcELCfWB2ZLL5As+idjymTkAYIwzGDoYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14ce:b0:4c0:a8a5:81df with SMTP id
 8926c6da1cb9f-4cec4f93cddmr18478173.4.1724810943180; Tue, 27 Aug 2024
 19:09:03 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:09:03 -0700
In-Reply-To: <tencent_85866689832EDE6ED8CC92A7DD46FD12E406@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092bfa90620b4d71d@google.com>
Subject: Re: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in ethnl_act_cable_test_tdr

================================================
WARNING: lock held when returning to user space!
6.11.0-rc4-syzkaller-00681-ge5899b60f52a-dirty #0 Not tainted
------------------------------------------------
syz.0.15/6073 is leaving the kernel with locks still held!
1 lock held by syz.0.15/6073:
 #0: ffffffff8fc84c08 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_act_cable_test_tdr+0x3d2/0x10c0 net/ethtool/cabletest.c:341


Tested on:

commit:         e5899b60 Merge branch '100GbE' of git://git.kernel.org..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c0c7a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16325a43980000


