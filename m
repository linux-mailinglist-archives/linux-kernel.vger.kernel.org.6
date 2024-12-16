Return-Path: <linux-kernel+bounces-446658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF19F27A7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529991886148
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90909BA49;
	Mon, 16 Dec 2024 00:55:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C1323D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734310540; cv=none; b=sA8XvXPU1qlmgdaE462GdDc3trT4+2NGRQaaoJpKbfVFRIQ0+r2dKN5lmuPHchNL3VNA+jQw4hM+HSu82EuSIADNiVIkWFl5UxTBkfD2I8GfUYrESnHcJnBJcm57Wr+ZeL/ri0EQGS4htm+FvgJIpaQgt+BxocdB9PA6Ly/Fwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734310540; c=relaxed/simple;
	bh=M5zkbHOH0pjT2Wk0Sqvf6Y4HF8My1HjzpvwNs+nt8sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J1vunjeSFrQkHwGV1zAlwPtQHbYf55T0OkpQZhsiN1S9yuA6ydx7Hu2UHW3vzn4mkD8eyhG/qw9DEPVUcQRHZ24bUELbN9OGDc7NE3hxGnzmWEfJeaB10Wc8hhPg1GeuaUFbabS37hIZIbmeLfxHEz7kvLWY+RqXAnTfI8LX5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so36072295ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734310538; x=1734915338;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TyPTg29gCznr30gAWH83+Dq4brap8KWMDwmlkDrkrA8=;
        b=fLcZzHfDOaUa+MfSLGrBaH2rf0GZdjXFher3joJn/Ke7rEGL02HhUY9S+CZWlbJ8fx
         aEU9crSp4mSIWpdugEm3V1jrG2wyH1jt0BOnyzzSeXX/tMTVxeqsZTxtij7C0Nrvi3qn
         RFUGOsCqwmpXc9Vh/1yzNSw/vaHgl8tSVqOu/2qq5m0jGmvvHWDgt8IKphpnZxRuaU29
         /a0FJwR86k9j32S+ReDjo3KfeRK8JeAnIG+ows1UteS2pahS/3Z8Rc277wUkQDrC985U
         HF08Nk5lcPuvh8maQjhmDPdQIIeIcC21N1ogZxQOWaWQH+bK1A0ko60KKdEQUzlLGgwr
         bLow==
X-Gm-Message-State: AOJu0Yy+4pfY7tORysSczoRe/yUsv5owUYV3ctoq5q94Uk/CUEbjaeHR
	5/47p38yF0duIeI8fEOPvJmHQamYUBZGJYAMM2qM8cnt6gPME0J4poYf5wikmPcpGcOMakp9hOp
	DrSF4I5wUdhPDrNsJQ4iI1p2Bx35ZDGkuKLO0Fx2Z42h1/bRfZw5dcIw=
X-Google-Smtp-Source: AGHT+IGnvGBZQI8ERNdQHHrFt45mAGGa/4eO0Vc9wu36l2XVH6qiyTwG/idsquTJPdQeC4EmxfNpMLTuGo3SkJv8zO3vqEb8nRKj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:3a8:1195:f216 with SMTP id
 e9e14a558f8ab-3aff7668d77mr106596545ab.10.1734310537868; Sun, 15 Dec 2024
 16:55:37 -0800 (PST)
Date: Sun, 15 Dec 2024 16:55:37 -0800
In-Reply-To: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f7a89.050a0220.37aaf.010b.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
Author: lizhi.xu@windriver.com

If either a zero count or a large one is provided, will triger a warning in bitmap_parse_user.

#syz test

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..9e989d97bb78 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5224,6 +5224,8 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = file_inode(filp)->i_private;
 	cpumask_var_t tracing_cpumask_new;
 	int err;
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;

