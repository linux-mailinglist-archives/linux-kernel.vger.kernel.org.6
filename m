Return-Path: <linux-kernel+bounces-169877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB98BCED1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F8D1C23AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC078C6C;
	Mon,  6 May 2024 13:18:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CE763F9
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001515; cv=none; b=HV+X+DMkDUzAdVeWR06lg6Ru4d65s9qYFhCuQKflMQVCIeamGwN1jFCN2H571LhkqGTRZimJfljpJM/E+ZKy2xjGjSAemYv7PWLCxRGKpsBgBjjg60ktXcMr5rrtYPzRuZrRRXMutKBuqZ2Ty8yl6d7OMvzRVmMK0EuxFSoU7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001515; c=relaxed/simple;
	bh=xMKAHgLWffPEg/68jPEYeY/o4qLcUtR75HNtHwrSP5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U59h+S9HhBwZYRVCT3Xn9E8QkoLMSaLnTJ3wkEUDARegQNo+ckMvML+2uB3IMmTyRrdxBfC/ZmJGLBrlZu5LqFM1aSrUtxGH2VYsVtT47knVkPTYMNBUh6wUyNLUHi5p4+1D17YLoR+P4OeWi6it33AS3ySUAbBMo0WjGbmWddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so153146639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001513; x=1715606313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TxmHB0vl67W1+zyEJ27WmnVys+63ysAGw/jZhHVYa4=;
        b=e/MoteuZhU1I2ovQfsFuAnQQ2Om+Gm9C8lf4YFIvHC9krbvAVnmzcmi8cYcgUQm6nC
         kqDNPHSG0Xc/s1Q0iFZc9GStB8rqXR9R3dpipNLNqzvLWk0rUZUVLIpxqetDwesCuUDe
         DOMCgzP31ks6hJH/paWz0Sy4yM52GO0z0d/vRJRCJNChWGtc+2fHAcn/tXUT3AnkagxH
         AyUiS87Xu+kYFLqGV4GvHqkXr37I5A2qcgfAlgNhy8tODW92yDcnWW7TYOIQnKaBvvLL
         k8bNvOEs10saaMjEgbDU374StR+LlcWAZb4wXDKjPt8848tel1WfWjXj2mLMDbvlx/lS
         a3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWsUdnMyiV6/NtNyM0XMlwVQm7fR0PqvxdtN2TWFId+6I9gR/usfWCw4DbL9FTZITz6xoXS63NCeel2HEh5dKA9WbfqeiM3F8yTvc9E
X-Gm-Message-State: AOJu0Yzx0LFbytw/LUjG8HY5wA7olWWrhqWicKAd7x7A/KitKeafxA0j
	ogmkK4YOIG5d6dMkkfO1jLh92JfkS0nis0roKKzd0MybBhzds+SX754F7mO8Do/dwsWnHtURlII
	cvtabvbANOcxIanj65ULnMVTKD6aQYlcyAetcNM7PL4tzIw6SmlHjLEc=
X-Google-Smtp-Source: AGHT+IHGkWCaHpJLl9dzq0QN3kR9qdOorczrF9G3kwxMgooiBGozHiWJRAmpHqOhax011rNPJQiAoVBofoiRpuhW7X96ozD4h239
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8516:b0:488:8715:313 with SMTP id
 is22-20020a056638851600b0048887150313mr249593jab.0.1715001513193; Mon, 06 May
 2024 06:18:33 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc4600617c8e744@google.com>
Subject: [syzbot] Monthly nilfs report (May 2024)
From: syzbot <syzbot+listf1bffba7342098843795@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 3 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 127     Yes   KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048
<2> 3       No    INFO: task hung in nilfs_segctor_thread (2)
                  https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
<3> 1       No    possible deadlock in nilfs_dirty_inode (3)
                  https://syzkaller.appspot.com/bug?extid=ca73f5a22aec76875d85

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

