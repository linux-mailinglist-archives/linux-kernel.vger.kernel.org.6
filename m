Return-Path: <linux-kernel+bounces-215220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2730908FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B771C1C22B68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF34316D9CF;
	Fri, 14 Jun 2024 16:18:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3216D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381886; cv=none; b=FSLzrSI6759d7mjzXd85ktPYDCh9Lnms0tGNZcawzwUO0qgnKxw5M453maPwGeZLKvaytqqnyS9Q5gZxU6bKqLQR3GIPzcJfHU0hyjNwejJW+LfoQ34zVBGVztU3EsXUxMHNvg3x9qtlh2IHoCCwZTSKrg9NPamOdcxfJIn15Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381886; c=relaxed/simple;
	bh=k2rX1sGAzRLLcsSbTagcuZYrp3EpVKtgxQIopbhRJs8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OEX1B//dz1T1fJmfMNm5QUw6AotY7sFeU6D5lBXfpwFL7pNEpKYvMofSxGb8ELn8E89y2Gap2oBjWU1YDitkRF6Ij6SMwwkHXJuxN26DdXVTshkzsWOCpgNa7aF/j1K+ZsJbDBSElo2PPtSLIeVh8xyxoWBBBCVe3HiGaZvFTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebeebdc580so96892439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381884; x=1718986684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGoN0m1iTucOXtjke0ncEJnnrAPBlXJ70PprLdh+wbI=;
        b=YvAoWrukqCecIjhb0iqarDkieQqQy6ytjVE5VkjxQFnSaI0pdOUL8gTwWFPsg2LnrA
         9m1NMOEqduIQR/I3/dEFI5k26FnhNPkJfWP5NPgRhyvZLXQIwC8V03opbBde1vJPav9J
         zchUbIzwMQSNe9rpvcYivRtFeNkgEBamzPmcnnU7Ui4HYhKNI+RGEUNuVc4cuIjjoygg
         Ow/7jkG9ER0KR4NfzoSYKLgobeDNImq0ke6R/CEZT7MBbsqwQLYPSQQPsZHHp7bIHD7S
         FqibiaH/pNKaE+6UJVJc9IzgSDFDTcnnXgcBw4N8DuOXnqcyAjIHG0u3ew1KLWSk/YMw
         QAVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAULyl48JHzL8to/biyuao38B4/gKFwFbsrOnkHsLH13Gwefw1ip1JUwuKnWlRUMk19rGE0dSxcVHiUn80SjENkzo3fKtG1QW3gpgV
X-Gm-Message-State: AOJu0Yyq5EBwObCdcCcF2OdfawBjkTerZcOu2TqlXiifZrWz7oMaOdd8
	n6wzvGxa5+yveqdGNiMdUGPzx7U1q10ZOCSH+BGA8IGOa5t+v91ShQ7TY0xv5ss1E/O8Siak/T0
	7YVn7E9mgaIN3L3J7LAPBcuGZ3PQvv4T//P75g9KtGQ70yAOrwqm4ehM=
X-Google-Smtp-Source: AGHT+IGhzLD1XcV3ejk8zkw0+64ic7JKIJ42YMF77eoj27g4fw0gCyw7No0lHJmuuLUmWowjFPP8RpyqtqtwmyhtcUYGRSeuzvsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4b96c103ff0mr25393173.1.1718381883922; Fri, 14 Jun 2024
 09:18:03 -0700 (PDT)
Date: Fri, 14 Jun 2024 09:18:03 -0700
In-Reply-To: <4fc95571-7815-458f-9d34-5109b1be7399@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7ad34061adbf5d8@google.com>
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com

Tested on:

commit:         8d0a686e mm: add swappiness= arg to memory.reclaim
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=14d4e154980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fba40c4590d687b
dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

