Return-Path: <linux-kernel+bounces-299835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B695DAA3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737791F21D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6318622;
	Sat, 24 Aug 2024 02:26:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D215E97
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466364; cv=none; b=PYMndmrVQDRwoz1v2MZrOA1WwOAr65yJw4LeJpeuoLa5HZD3QNArM+D/2ekMQ1Mq/fqsIBe1w5392q7PkD5cPjUsVc6LqiqXz3CsijBnoooaWYP6FuoIa7Z3GDvVbPP8Pd6H+NpNwsSBNGvO3Vbh7y3CYQIHtFRn60sX8fEQ0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466364; c=relaxed/simple;
	bh=pf43LWO3+Kb/HWsDc+DeGrAo/WYzky3uVEBuTQKXSDk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oTbKFzwNu8o9ZT+30qRkMvsvhXboJWN7l9Ct38MAdAN1RwkWkvyDJ5EX3ASQwdTzxBZcTWPGHQIMxj2dkJ6BtVJ4NnfhlPtw+WVIDeeac0mNJCKCdlwKolJl0OgG7xnl0bi+Mt1vn4kAA/VkOa663CiibkoN5cwE6Z+F/+GSjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8edd7370so270732839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466362; x=1725071162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2LTXzmu52uw9BAjpBl8CxvQ7dxegVw6BeKFVVBxDDI=;
        b=MZ/YLhn5BgKfxS74EbP1ZzO2vl3gB6Ic0i3gn5+VREs/swVWSIJ30iyFUEfI2z9pXw
         j1RN6wVTjUh/4bq1K9DPegod9/s8zH4YGeVW83MB/uGgoBSk1d5jkgiArASw4CCvMIOz
         tZnITe5DWAFp3MsEZZ8WbOu0f3MhSrM59CkJkNEeMqD0YpNNe5T2seJ5GEUxr9kGcNt0
         J1KJ24abUoYNBa1sbpniAeZ2tkX4phKlLy0pAE8URtkI1QiNzpMDOwt25qx0mMSeUpgL
         TFUXtg1UKPAaPzBdvNlfFLWqXDaQd1/g9WV/IIJtfyJ9oCG8GXNHdL8hj7smT2TXtPpL
         f4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUSbbaHWSRTeK3USr132TN7Q7RTEU0Bf+feN9w8oFjFCTF5o208rN0ZOyFEvwo0V5XczSvajDU/R2DFKZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesY7LKVrkU4bA/MWJ/lIRsFw8StnfPVJ2e4GvHkCIrn7qorY1
	Fd/n7MKHo/Be6EeWXakzSVkzFIbrVEJwJ3EWuuayNW7ErvpgIbJaH2eh0GvvFo5QjS7jqbIobda
	3WK1Z5Vb4BJFJ4sCn15GxiqOu7b0glMoqIZ7/FakOm5Uoq82EYC5yMdE=
X-Google-Smtp-Source: AGHT+IHxVyhGrhfUnDx/pd3dim7/HHtOrUyyYwuDlq4vNcbDiV8iZUh21NBsGzEU4soDJdnD6Z0sw4kCKGLcHrSR1rvA8YscJwot
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2382:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4ce82b31682mr259719173.4.1724466362247; Fri, 23 Aug 2024
 19:26:02 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:26:02 -0700
In-Reply-To: <tencent_6A26ED06CF0C782A6ECC2CC56E209458EA0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2ff4c0620649cb5@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbFreeBits
From: syzbot <syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Tested-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com

Tested on:

commit:         60f0560f Merge tag 'nfs-for-6.11-2' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1159e82b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=3c010e21296f33a5dc16
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12dc9bd5980000

Note: testing is done by a robot and is best-effort only.

