Return-Path: <linux-kernel+bounces-173967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A088C0864
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73111F225E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17217F5;
	Thu,  9 May 2024 00:24:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BC1843
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214244; cv=none; b=BJF2GZnTNFme4EbR+S2+4lcUkWQPaO6ogYHx2pnbuLRzweBHi4BqLavVX5U2wjpRkBeY+2bFm3aoZfzwgeRpIdM31dDR9iDLMAzPuYBY9pOBIKi1QtnE+I6jOqvm1JvZch69x+kH/TvBDV+SEV5kwbt+JMB005UJkI0bZ67GZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214244; c=relaxed/simple;
	bh=SFvL+wjmuOl95pHnqcSMxn8Bcf6t02SMa67Stfg0Pow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GSEQI86I3kirk9iuTEuEV6VaX5/pGHqspOMrWfWhzyKphb9eV9Rx3bcogPr7BetBXsv3CauoZYNIbso4j67sen0ecVHXlPIzfFfazgJD7jp/BhMJRaVJptxus7W1iL2KLL0XvKG3+DazeqMHFYmRgXDdWVF5rUa/acjXi8/Y1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c771adf01so2538405ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214243; x=1715819043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axCafnH4NmXcFjZ/2Cz83TJW0cEv6Hsi7bOxH3RKX5Q=;
        b=tcsPjDl9hqWpGSHNd1t8g7FoNB59Q2G73KF2U9aePETHD7M4qgVOO2tlbXWpSSONXj
         COYAlKoTBHsOGCaEFsb4NGPOoXuKgmHn5YPT59OSsT827+glbbFU0kJe9QxQfjSZl+RI
         ly1ljxR2Oa55gOf+Q06TqyIQmdI0Iz/oJkxfsVfpPllrIDGhCh6R0uwUygk38vtBGk47
         zcUfxcBacdycrCP2Y5oHyuTCnquc9kIqPjiauAJN0qav/7DzFcfqF4A1ebi9gDZKYImy
         cxIw2/AZVEkLh2cWE2Hf+rZQiJtKLMnm6/aqTadCvxwrBEsq8d88Jwla1q918lJnjTmJ
         iyOw==
X-Forwarded-Encrypted: i=1; AJvYcCXTBqcCq53hKRGmi+U/R/KtfYJVqs5CTwxZrshJDp2hmOYZDSTH9S8ej/fmeXTyPzAFUS4XGE8UjCUGDvFeN2erv2L8GwAt0B0MJCoy
X-Gm-Message-State: AOJu0YyYsD7WCxrBKLnO6m52RIUJh8O5aEqN4yTOTYFzarRFqH9C7opm
	jUcOk6FOEzr1Bs9oysdOYRBeGkG1v0P/RZPGjk+Y8elI9eZ9GXPP4XfJsPweGy9jen4LLTmrUbv
	9Xe8WHlxo2+UuslfhARNrQvpJ/MNSSA9zfQdpDibq+EEagMjVpwdG4+c=
X-Google-Smtp-Source: AGHT+IHVPjwbEUr8poCKFPmvoGW2e5DVr+D4BijFy98e06Wriwo9idXxSUNTaUEiRfdpY1b7htRe00vxnGeH1ROWVM4H0SHlUZiw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:b0:368:efa4:be00 with SMTP id
 e9e14a558f8ab-36caed6ac93mr1920625ab.3.1715214242845; Wed, 08 May 2024
 17:24:02 -0700 (PDT)
Date: Wed, 08 May 2024 17:24:02 -0700
In-Reply-To: <20240508234053.2319-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8a7740617fa6f5c@google.com>
Subject: Re: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg (2)
From: syzbot <syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com

Tested on:

commit:         9221b281 Add linux-next specific files for 20240503
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1428705c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15245350980000

Note: testing is done by a robot and is best-effort only.

