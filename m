Return-Path: <linux-kernel+bounces-342438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7F988F14
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8958A1F211AD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FF186287;
	Sat, 28 Sep 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwZ+zTfs"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615F2A1C0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727523401; cv=none; b=lTA+JZE+WSatBGG2MJWmV6vy4vTKuk5SnyPgH8oYFHFXC0rOp5WKsZu2NoD4hjDagTENh+m1C7igO6v7SX7df6upEo+UlfJClhIZaRuAWYBapDPOYxxIYL73ob+lGbzhE7yh45SoUyGdnfCs0/n8wdwA1jVlQp9Fudm4xJlBFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727523401; c=relaxed/simple;
	bh=I7r0OeNRYq7UEJ9WJscMDhm3+wDQOwmMd4aQSvLc2sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mAao4OncBPnAWUYJezHLwJIrFYyt+WhPJlZdrPdvkUEybMIXhQ+uXZ7LhrQB7pkvvh0lQGfovTWQzP3G2lA6jaqfJzDXdCy6S8Qi4f0PXf9+73evBsypXsbAiU2jl/PL/0sEQcHIl9hCU4oGIH0iR+G2xtfPgTzVtzKC7xICdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwZ+zTfs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso2283048a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727523399; x=1728128199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zs7gCtqY1hbtoA4ZCdcRbSkJC2v2a700bLuubXnIOkI=;
        b=NwZ+zTfs8DYpgxVDsFl7enPQVTfC4tMhDOKAtSyczyy9D1xjMkoIaO44pgqWq3JAa9
         dZ1cnyb0FO2R/31QY61aUlJIpaI4AexxrPMEdPIbEy77Dohwqtx9gQd/rniUZ+c4a/WZ
         /E+8QASyAsAS6JAi5gGSBOXbgispMMtqwCGNtRt1zfP2viUI3wSBxXV/pMZx+V/yKjVA
         QMWiPUBLeXJBJji1wsp336nr/Qpu3uylXnZKTi+7aWI0cvfyFwSUqGj6d3YfXMsCQ4Q9
         OC7VrtGDFwRxA3aTtlsLfKoSZw6vtJQ3Peit/716nGl1ncKBOe+rdYgngdVxd8Bh4L9P
         zz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727523399; x=1728128199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs7gCtqY1hbtoA4ZCdcRbSkJC2v2a700bLuubXnIOkI=;
        b=YcdbBulQkh4FZ86OKvuoFD7ofjdPQ6ez4yjHFkcX5X4WNA70YytqiQ7xUvLoAK1qwG
         AQ6lNCNduvc7mlaGp9QCguqaMtHr47NwiEBcW38zoCc3LXRH194C9Eq1GJ40PyKd3FSa
         ep0oHJyUdDp3/h5mRZgz9CJVa1CXpixaHboNZ+oa5ZmUj/5A387KfY9Hf4zbII1qqVe/
         fJOsX2UltIi712p4DNdlaKjOfh0OdhW+RQ8NQyiO7Cy4tIFyg3DaTL72DYqzS1sZeGqf
         0ROK/+s03hruJNEfFqFYPT+nFcJMmN9YpeZKcSBPNqlWxpq3DX3TSimaIARcBpA7OzG/
         RMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs+CNKm8qxghb2rqXT0wTnO5+2wbqt3uhgC/v0GsRXgjrT2op63teDOLUR8PZal75Bo98TcIWzbWqjtJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcKgeRQJwCy5upKUjCqcohlLAP6dSJ9ZWbGbyxGh84VXfpF/O
	9M5EmTSgQm48aE/irBPsO6W5HiZdJ3jD62ysrTjneSkFHZWUwFmP
X-Google-Smtp-Source: AGHT+IEi2FzbvOuIK1FQQmV397I3vlvQXzbrRvDu4QC1gN5XfsT66lR1V2Wc/XxOFntGtfk2YqUI3Q==
X-Received: by 2002:a17:903:186:b0:208:d6da:a22b with SMTP id d9443c01a7336-20b36cdb4e0mr101418725ad.23.1727523398864;
        Sat, 28 Sep 2024 04:36:38 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264986eesm2969573b3a.38.2024.09.28.04.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 04:36:38 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sat, 28 Sep 2024 19:36:08 +0800
Message-Id: <20240928113608.1438087-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
leads to undefined behavior. To prevent this, cast 1 to u32 before
performing the shift, ensuring well-defined behavior.

This change explicitly avoids any potential overflow by ensuring that
the shift occurs on an unsigned 32-bit integer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Build test only.

 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..ea0b2290e2d1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -523,7 +523,7 @@ static struct latched_seq clear_seq = {
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
-- 
2.34.1


