Return-Path: <linux-kernel+bounces-326704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF4B976BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B11C22930
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFD1B4C26;
	Thu, 12 Sep 2024 14:26:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74BF1B12E8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151165; cv=none; b=TTaH/IKXdJ3mE3kMxU6QRpMrmdg1KHbaCaDbNrD17mImhKa3+7AcT8VGnZKOY6MAa+ulIBdji3CAT1DPx4TV5Q3SczxRK/ZtCzhGA5KQ3ejhQYAa+w3Y+am5RBdTwqG+Iry+wIognCMSWHPzPbIirdAIimb1c1PhIp0HMwnaDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151165; c=relaxed/simple;
	bh=hZ2GDoa9mjyYD/PpL0saqNbmU7dl7CCd9ECYUjAuWi8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wh9jXdCnKCAqe2HGArdYPILCTJ7NH6y1TkioMGx14s67SWXv2z1N71CGipernRBMZFBg036VgCP1eCKJEMgotrAEqYfS0U+KhNNLgKMTz4fAmkxGbtbxtSYZd4740sWpgDXjN4wfhYd1MGRFyA9oVG8Kt8cKaEhlRNVLM5zR8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0862f232fso9028185ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151163; x=1726755963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDZAu1In2JccjtVbwikU0gLButFiD4RsEtk+8A42nic=;
        b=PwjXfzjgpCQPTtHRt/7wcHviCtoN2VQiy6868xIEyEoGy3hv4Twdsq8L3Wvpy/Z+M3
         pDnDSzUg91CcSQkHHyJ0tMYsYcEvOtmMiqShDpjqwS3QG8vNDedK4J1Ct0oxIPjeYbkz
         1SQ7NUQayu5p86wwKWm/MIXa8amIxzoaNaecmQLP6IkHLlIIerqAxWtKcHnYY6gcW1ls
         bqFdBy0diLTcGOjK0w2PBqjJtTIHZnU/hpmIIljQBNqBCBrDRQrgdNFS6ZxwTrnjgvT+
         wA7c4Eu8HuyoQVaRulhnos0RsTjVk+jm9rFuIW3tenkwf2dYuji07WQ2LUTWg9XoyfLd
         w3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXP+yoAbAv2q66FYSMJbXpvFOSrG/36EqLtKN87fh5zRwbxZok495mUTBCF65SsmmIgj4TsTuAwbvWQk4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKAfxYy0z6c1d5lLIv974p09SniaMKRgq8xtSbRrPE5zIFp1h
	VuOEfW5kWwOIIlSTU1uDXMBLAO6Ac61lZGuKv7SEkGGcTjMH0PlytDNJPC+bTvKsiSpJ7bNQne1
	0SQPeFBxEP94+GgwKfYmw+RrMgRTIzMx+KIV//0V7piTMWGwNHmGuJLU=
X-Google-Smtp-Source: AGHT+IEo8D/vdvwbFCX3Oeu5RXtROG6Uj6z/E7BqWUNXjWJQQI39VLm9oD6Cs8NhIbFjIoGn8+LpD+R/1JHMhvl5rx5Myy4taizq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:39a:e984:1caa with SMTP id
 e9e14a558f8ab-3a084962a4fmr31736965ab.21.1726151163030; Thu, 12 Sep 2024
 07:26:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:26:03 -0700
In-Reply-To: <20240912113052.2904-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6ca5d0621ece2dc@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: frederic@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 P5320
 } 3518 jiffies s: 7245 root: 0x0/T


Tested on:

commit:         77f58789 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1533b100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e236c2f9e028b26
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1663e49f980000


