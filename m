Return-Path: <linux-kernel+bounces-229586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3656917117
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D424B1C22274
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751417C9FA;
	Tue, 25 Jun 2024 19:27:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212311DDF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343626; cv=none; b=jHydnf1P/Yk79S7EJu9Y43YereixUdos6xg65AVKtsUs8Xb6fVw7UdgE0PPFHB8r9xrK6vjYzPQsBRTl2CQ9hXYEHYqVrOjaEkAtmSHCmXPSCrhefbE0Za9hWJdcf8Dg24+fmbZV7/5Y9Q3f+gXVVGZLlMTE5Gfo/k0vUMPbF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343626; c=relaxed/simple;
	bh=rvuuJ+FckZVc2bHKzZB52GgGSfZj/jiT9M6dmqHduv4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ssy51nfE2QUp6Z5ZIKqpq6yKK+4Ql0I/niJNVA9wlQ39Ts2YyL4hLYoC31XbS5FQzYiFGizIfebkHi/X3vM7OT1+iutdm/XXH46qDrLKKxXTHnrgmkrD3DZrS1c7PlGxRgjm+ivhRyupXFpJ8KvQuiuOUDgsbBXl0p0FPr46vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ec091b556eso837685739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343624; x=1719948424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDBJDA3DaHpPGKGZWhqZy84NPPaAj9/9kDgTn03w5nM=;
        b=T2FG+KaacH6xvLn54frRSawMqAw0Pu7NPVpqVQZ/rJwKDolJB9BQvWBZDtiWDO0Aap
         Euk8tcTE/o853HqA8rR9lcQALLzFP2IDTevPY5R99xBbm7BV0kPUzFUKm+EaF08v/R2a
         qoZ12Px6na4Fs3TdTm9MpYbqx8b0syenDJR4xz6UgDczYWVg0o2Ixt84swPRrd5CeyZ8
         CGEHBCYzdC7ysRkGemnKVKYBqidDk2LLsuBssjN3Kpc2Cpa9YGu3NnI9n1eZ8K+BqJ+J
         4ZYBKwK8AF+GEQi9uyP6Cm8J+lJzLD+Oj68m7ORvcxxjEssYVqy14VgFsyiG0j2egJR3
         EMHg==
X-Gm-Message-State: AOJu0YzuKFwW7pyLJyp7R83RyIwUhMdAubtwjK9432HOlpvgCop1dVb1
	GZ36IJSp05RSOuFiAOLJYKuNsiacYMTr0Yg6Ydh6GiAMyfWWODT9rK2ouJTgv4viKWWhqyoWqV/
	OWi1dnww2N+wtuG0ePhEKHGw26xXzmSAMLT2m8f0+q9MrvnmwUjSWDgY=
X-Google-Smtp-Source: AGHT+IGjgRHflOtNBQ9taRqWes3dWS44GTSrTSUrkz9Ht+CqvDHnw2b/wduWnBQUqct7UBnATNPTqz9UfcBvLPRl3giJpRxVQiWs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8906:b0:4b9:b9a4:848b with SMTP id
 8926c6da1cb9f-4b9efbfe95dmr297316173.3.1719343624328; Tue, 25 Jun 2024
 12:27:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:27:04 -0700
In-Reply-To: <CAMc0M--W=e6YCze2j+dyHKg2LTGYTF0aUTe-bjwZK4GT9USv-w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9a777061bbbe1c7@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
From: syzbot <syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/bcachefs/sb-errors.c:119:36: error: implicit declaration of function 'ch2_sb_field_errors_u64s'; did you mean 'bch2_sb_field_errors_u64s'? [-Werror=implicit-function-declaration]


Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3820d4fff43c7a3
dashboard link: https://syzkaller.appspot.com/bug?extid=a2bc0e838efd7663f4d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10379501980000


