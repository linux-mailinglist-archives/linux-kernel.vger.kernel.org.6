Return-Path: <linux-kernel+bounces-446714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C759F2843
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7272188128E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997A17993;
	Mon, 16 Dec 2024 01:56:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6EE57D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314194; cv=none; b=iDwQGIa35RIHiPvogZdfuF5AxjbnWrORwHNU+AM5gpmYHqojIoJ0Owm6l9j04OBrY3iM40I/LgmdRLnOhedmOOHoijrHmPlsZ4Mpg/R9r27DgsPGHpXsWMbYsF0Mitkcl5EZ1xgq8+Y76A+YIxdfKeOlHkH8IFmiLJGG/ak9Qgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314194; c=relaxed/simple;
	bh=cpSupO2dHRTuC1+MTZE34NkoUF+f5bIb2C4r1kuKX8U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kG+E07Hh8n3p38CE/e4IiA2jmLZy6KP4fYxQMSXi7vQrHAoiBM0yJ7UUg72HJyrAwmzh1/AtfTu4nOyYKb8HkQ6OlHdhSvgqJUpiTKTgq4vqy6TpKbIhcJ88yHKm8/F6150WB/rspqPSjsBc9AIA5PgcH9HWx9zS9C05mlEXxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81684bac0so73636535ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734314192; x=1734918992;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtpUagL4+EAkS80NOkOYrDL4cmYf9YoWCsJSkvWAJMM=;
        b=gcaJgRRBiP/UIf+xPDDBANd+7b9Iqhl3SH5SpxQpeYwvyWGXhK8meO0BAggWCteHbi
         rutBEH7a56vGBWxg/B5pSuUmYz+4tJ7IqrETJlYjEKKIIDdHU60vOYrWwf62ofNM7Zs1
         pLyBRxxWpNlFy3U+icxxmeu0IiVWPhvFqYbf/zJFbptJtIzZgSbjrT5oDWXrZQD5MO1D
         l2jlHrp4go2HlinLR3MESfS4J0K48p1Z4l1cXIB+OY8SMdGwDFBw8b8EN0BKzbTE/OKU
         pksJwvx0NUZCsvU+/EojBofOvrz2+XqmQWnBU8dXQLHLR7q1IOoOv9O9gEUpKGsZ3WkK
         VxFg==
X-Gm-Message-State: AOJu0YwMic6cZq/2OEBaWGOgVF18KfkxrYFGMyAELbLjJ2P61YvhZ+s1
	C7IFR3g8fo6vQuYxU3QdHqgvK0O7LdHQzw1qCQJPvLwa1CG0keojzJsV37DFTWkt3YIicvf8aZT
	xKeObmyfn7T3+5fJtxCdK3UltN4CN9aSRvFhECL5ZVuTZYKrHDpBB7Zc=
X-Google-Smtp-Source: AGHT+IFRrf8aG3PYy9vJKnySzEPZdnbTBeWbND1tI46yAHReBmPFORfklXeznBLonlKUordM+0PsvGcGvhOm/zNUnuhHYrbSH6yN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:3a9:e2f3:8dc4 with SMTP id
 e9e14a558f8ab-3aff8aa28bemr131916705ab.20.1734314192432; Sun, 15 Dec 2024
 17:56:32 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:32 -0800
In-Reply-To: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f88d0.050a0220.37aaf.010e.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
Author: lizhi.xu@windriver.com

User input a too large count 0x40fdef, it will triger a warning in bitmap_parse_user.

#syz test

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..9e989d97bb78 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5224,6 +5224,8 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	struct trace_array *tr = file_inode(filp)->i_private;
 	cpumask_var_t tracing_cpumask_new;
 	int err;
+	if (count == 0 || count << PAGE_SHIFT > MAX_PAGE_ORDER)
+		return -EINVAL;
 
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;

