Return-Path: <linux-kernel+bounces-219282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8490CC58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FD71F21E23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB583148313;
	Tue, 18 Jun 2024 12:38:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12B1474A2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714285; cv=none; b=A4gksRcpFHeWXg54/Rg1nOadS/gkKOTGdl4X4u2csV+aUR/w1KQXL6s/SekZT89bJtuvnpNnWSmw/bMZ3DsVUBYy/VgBf/M4yzriCSe4qbtJHzGbubZRAewOwLO+/tOrDII3LsPpxHjJrGwF3aTLl3gqrcl/YpWoWzeTNtfjDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714285; c=relaxed/simple;
	bh=fGTSPjnQr05i/Qz1njYxsPrj+v0954KqoCdZCgFqtHA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SCai9EtKPSY9aG6ZNUZ0+4aWfh8hf0JpK8MRuV/qj07WXQX5anMcSqAv5kzxuqBG9BKfJGAK5aLN9Bct2D8TlcFatIQC/30m3uONAECy+7Tu2S522knehLLUzgcBJqN5vhCdCKQuvUfDCUzbee+Cg0o85SXBrbNATdCql+tJyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb1d659c76so700695939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714283; x=1719319083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G31n2s5h9TgP7VMBf8zD67R7hIlXkzsxNuS5q3V8lvo=;
        b=c4CsWCV6NlMR8GHgBcM3poSV/gXuBMUaZIot5IM7pcW0Pi5zqw+iW0U0i76VRuHAb6
         8amupRdl2tTs9+v/L2kbrGD3qv7rs1aFRuDWMWHjmN9j7zqE73u58uOkI7DKzQbhV0bQ
         0j2ZcpA0khKXUjiEdwssBHq2nroIdel4RUB8/Vt/GViuhOyCwJoS2WzjGSgT1xIzSxOB
         Xzt/G5IQ+zo261GyY/ZZ2KU3Kho+eTuEr4hbkhhFs6J0K6NlVyv3xSRAeWmm2VKOnF2X
         JCBTHOniFIGdAz62nEZdeFCnxCBS+VIhW+IYbCPVW2e3jJ6rwkQ461soHSh3Qz8HYr3C
         qjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYsL1zZwxhViCFmbvoDYkWLfyygOfnIQRYu34EipcdUlKR50txlLWs6fYQdhaV9fGCo9gnp5ZMYghZ002af5wqeLD2krcYx7eprBdb
X-Gm-Message-State: AOJu0Yx76w/SqOsTrHlYvxnOoFvSvysTTXWOalEH+uJAkcSPb4O2dvHs
	orBArFmmxYXwDIB/PTFhdxg7ETBfgwQi4MJuEV+21odamLCQ69aRKHAV2tPrKiuMPNY3k+6v0Tc
	WzNRIC3ZVt2COw2WfacTNAjA4uMclQe67LlLJczjp7bWwcfkXJ1E50rQ=
X-Google-Smtp-Source: AGHT+IGA6H74RoVlHPgLUYkCnJztGcZO9f+hnXqri2n6cFO/VcQG28o5xOHHsyAQNMpFYDV7m+zXjKie2NoGZTTXIV1cB7FHaquN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3713:b0:4b9:6c10:36c1 with SMTP id
 8926c6da1cb9f-4b96c103c50mr449016173.2.1718714282767; Tue, 18 Jun 2024
 05:38:02 -0700 (PDT)
Date: Tue, 18 Jun 2024 05:38:02 -0700
In-Reply-To: <b82ee1f4-0a09-7976-0b5b-c762f5eb4186@netfilter.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b8b81061b295a04@google.com>
Subject: Re: [syzbot] [netfilter?] net-next test error: WARNING: suspicious
 RCU usage in _destroy_all_sets
From: syzbot <syzbot+cfbe1da5fdfc39efc293@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cfbe1da5fdfc39efc293@syzkaller.appspotmail.com

Tested on:

commit:         0eb94209 netfilter: ipset: Fix suspicious rcu_derefere..
git tree:       git://blackhole.szhk.kfki.hu/nf main
kernel config:  https://syzkaller.appspot.com/x/.config?x=33d942c3f3616a8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cfbe1da5fdfc39efc293
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

