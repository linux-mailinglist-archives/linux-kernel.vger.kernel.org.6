Return-Path: <linux-kernel+bounces-232039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701591A1F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5761F21CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D388132109;
	Thu, 27 Jun 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="CHfv0biw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F44D8C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478590; cv=none; b=hHt0XDwo6sIyMOlxY7SV6Y5WzI1HEnfgNViT9nMSI3ZY5gg1Bak41RqskzvBrtcZxEzvDwGZXvEs2B8slbXidLQwXWrUVgUuGJLGpGrbdFOxVEWl4ClRZw4PKKoZM3tRl+nZL7mgpsqRxs1iQPrVH+1VWVm0y6vfRlFqDxi9W9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478590; c=relaxed/simple;
	bh=Ysmxb0bGLrJuE7schxnLNi16/OfZI0+kM9j6mL2nvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWHAoXfVIpwkZGfARmw8lGkQ2kmZ/2fLMzNCaYkr30zxpyamYTnJGjPMEbajgGXFrTS7BGVhoi7FXokDLOkfnJSYqxi4ZS3FFyhxelrXKYicU95TQtFp1wJwIP9SurA2jscCjpLFQg6HewMhvmMKpaw30GhzI60AVFCdUyrYTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=CHfv0biw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7252bfe773so526127066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1719478587; x=1720083387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HvixEhQUFrS1HxDVCQfyFycypf+BTpTVP+IQrkb2So=;
        b=CHfv0biw4IyaI0C73GrsBwojgsCCfwt9hTsbChOZ/J2NSHuzH8+CqPFZesdmMgG7Xn
         XOa/g8xYf7EitoA8aec/eP7sIfS/GSoPuTOdy5cj7DAMnS4fS42wEHc85v0e6Xg4eUcn
         /0STr/j4Db/ROxHG+gwzoYhp4Kvss4xamMGRhCoopuUBR21YwamVAoyBbK1UjosJxQkX
         +5Y9zlFRtUjwT/o8q5zu6HT9ai9AbBry6BG7SjkPg/PwH+kRxXCnued/w65cfryuFACB
         T1zfpDbuSVbMRvqMHPqzdTzPz5rM0zqbQtcawDlqK+ATmP83JBToBSremvk2lYCaOAQ4
         ZBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478587; x=1720083387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HvixEhQUFrS1HxDVCQfyFycypf+BTpTVP+IQrkb2So=;
        b=nloULKydwpLN158Etzkyfyu2s9R9yQKo/dUs0jZkaKb81lNAFcw7hzV+c6Tiz/jNji
         eA6nen3FEkSzsLeEvjtw7TcYAX3w4rhxshelbG29NGifzGR1q8nrXxc0LyVJ6d4joR8T
         zGApc4YDzu94/KeTf8baZikXHqv67UQrym/SDARWfNi+clu3iV5eVgHl9Ob+jbvaE0ru
         WyvQF86jIag0Ys7Hk2puEk1/nfFwH+EzX4oVk0jvNmrPGdHLXxJ/lnqjyPSERBrGmcq4
         WVKNSwSSw7q1Lx74vQXFZdkuflcgjPRVQd0ZnOkP4AtC6d+zyu7pn/Wj/SPtbFOwViPg
         gSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZBe3hpP3PrW6siuvyeEr4FZiSlSJvmLlYpbFgDDgxCODHEs8d+IzJEsuIHH+LCMkhnLLBIiI6kEFh2l2XKb1WgTFJBCJlY6+HU26
X-Gm-Message-State: AOJu0YyXeugvgO7ecYG4g39LYwmHjrZ0GZkeZBPmeW76XGc9v5rMliUR
	QhKydq52CmhrMCDR+YgB+HBzAXmFukzirR/HN8oH+vnQqUNTQR/Cx74rRtrOxsw=
X-Google-Smtp-Source: AGHT+IE6uMbZoQTog5DVZt5hvrPJ0H5WQahBCj4S4MnHrE6UFTtU1ZUDTZGYKCugAXsTU28FP0GIWg==
X-Received: by 2002:a17:906:9c93:b0:a72:6375:5fa7 with SMTP id a640c23a62f3a-a7263756132mr718335566b.64.1719478587446;
        Thu, 27 Jun 2024 01:56:27 -0700 (PDT)
Received: from phobos.home.arpa (2001-4dd0-53c2-0-0-0-0-13af.ipv6dyn.netcologne.de. [2001:4dd0:53c2::13af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d77964bsm38516166b.130.2024.06.27.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:56:26 -0700 (PDT)
From: Jan Henrik Weinstock <jan@mwa.re>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@mwa.re,
	simon@mwa.re,
	Jan Henrik Weinstock <jan@mwa.re>
Subject: [PATCH] ext4: fix kernel segfault after iterator overflow
Date: Thu, 27 Jun 2024 10:56:01 +0200
Message-ID: <20240627085601.24321-1-jan@mwa.re>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When search_buf gets placed at the end of the virtual address space
        de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
might overflow to zero and a subsequent loop iteration will crash.

Observed on a simulated riscv32 system using 2GB of memory and a rootfs
on MMC.

Signed-off-by: Jan Henrik Weinstock <jan@mwa.re>
---
 fs/ext4/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a630b27a4..030a11412 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1537,7 +1537,8 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 
 	de = (struct ext4_dir_entry_2 *)search_buf;
 	dlimit = search_buf + buf_size;
-	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
+	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN &&
+	       (char *) de >= search_buf) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
 		if (de->name + de->name_len <= dlimit &&
-- 
2.45.2


