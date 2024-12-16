Return-Path: <linux-kernel+bounces-446913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDD9F2ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823A71681B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E841CDA19;
	Mon, 16 Dec 2024 07:20:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D61B87F6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333643; cv=none; b=ZQVtlxgduRFKSNhg2H0cGV4qE1gNZ8ki90Y2nH4xbkzRR1LGMJWGrKNunYUDj2Aypubypo0ue+aiRBUnZcmdewMcC0BNTlV53CpuD/6aSwa0BnOv18/cIOxjEbhJhXy6v5/QNzrxH98mje6xzHYS+zfYWFoI2reJMMyn5CfEEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333643; c=relaxed/simple;
	bh=1+n9MFuy442kEZNesADgTlNOCnFVj5EOeX3STxDA5K8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rBjhwGDcGzRlsMy62TomR8hoITSgDhklWfN+tx63T75gTNQAvnp/w0a9u/LDnTSYz8eqVV9zw4z8iWTR2Yt7XJGQLIL9d2djl5iKdQRAC9fUqbIROZmybVFke5gpZsG+/oo/asrk0G3APPO2RZOLlQ0KzVhlGo37+iUlk2NZbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so40123865ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333639; x=1734938439;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPewfZLSQKSD/zqScvtQojTowwsPkSIhne4fOZaMto4=;
        b=we5Ww/kTlbEKPeAkEuctvdqBaKKy3SOclWH3FlJcFVFLMDqdGBRMsrJ7cpoR6aW6c8
         YyoTyrKUH4KUtC0J4Fd5YJHjOLcYT//JV9ySdtMqecxl5KfIj7ynB8dxIhl/3OOtwRRL
         tfZgi67tcFNKoK771AnDMWHunmUGjoJc3ekFrjsJVtq7BvmXzpvPEeu0ky3A+il1GoIC
         SjSskhRFsOin/qU83jeoS8w9vXP7RbAbMT3DR6mdnGydYwnad8BIqSzV/iArX+OQaBX2
         rA4Yt/EPvAWpKXLZVVGzFakujPbijt4V6o//twNR+ig27gYObq1N/LC65I1Ktd3X+67X
         zvHQ==
X-Gm-Message-State: AOJu0YxcxquFT6G6YJbLJK61y45zZvSq7uuX9xs81IUlAwLtOY9/PzCS
	oy1Mve+T4XFfEJ9CzL+tczP5fRWwiHCm1W4oK1CyZudMAWMO7v/t835tuXoyz2+atQJRYFmK22a
	3P7ZbgtN/k7vVHhk57zcyKbWyw6oDl89FI43IX9hl2LLc4Tn1IpZv7Ws=
X-Google-Smtp-Source: AGHT+IEeolcJxXJJMCsUknvwWRNENroF+FQ//S2ajtxc0Y74lqUWVO83lpwNWIhhDF4whwg4jX+GkPt2WHRNJV54FVREHHwbLhfr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:3a7:4eee:b7b9 with SMTP id
 e9e14a558f8ab-3aff6219ff1mr119270475ab.13.1734333639785; Sun, 15 Dec 2024
 23:20:39 -0800 (PST)
Date: Sun, 15 Dec 2024 23:20:39 -0800
In-Reply-To: <675f4ea7.050a0220.37aaf.0105.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fd4c7.050a0220.37aaf.0118.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
From: syzbot <syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [tomoyo?] WARNING in tomoyo_write_control
Author: lizhi.xu@windriver.com

User input a too large avail length 0xfffffdeful.

#syz test

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 5c7b059a332a..65458b4059ab 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2654,6 +2654,8 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 	if (!head->write)
 		return -EINVAL;
+	if (avail_len << PAGE_SHIFT > MAX_PAGE_ORDER)
+		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
 	cp0 = head->write_buf;

