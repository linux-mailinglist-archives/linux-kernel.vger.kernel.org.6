Return-Path: <linux-kernel+bounces-263994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A393DDA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA71F2283F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972B376EC;
	Sat, 27 Jul 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="IHpEi6Zg"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFE2E62D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722064974; cv=none; b=lJgLnp6vXR7v8YiAGCujj7KIytp/XOFWARhmKrEEOXF0uCEwlvhxlOVYfwLenwxNT1tZ/g4ssMejWCM7+g+FW5hn/Z2I8gT4yvoK74nFsW3Ki/GF/CCg0wFGcsjw5toCeisKczulyisDEE2X6p06FPvTig2EgAQhwxiDbX4zHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722064974; c=relaxed/simple;
	bh=/oV/zbGDKKiElb8p0MX0ZIo3k5eYk2ocCAxjwwHUZdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6u/smWso7ILrLMXKTaxPC0F32kLAKXQa7T0oZimKlvzlv7dM+dh4M1gM/Vf3rFfEbWyHjdm3VFrPyeGEelDYw+GVaO+cEtsor+oCEYuCObhoQzpV14arHZHuyIEtaFQ/Qqp73Flksg0fY3wrQUhHYaHU1r9btAB/bba0EvzJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=IHpEi6Zg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so1132495a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1722064973; x=1722669773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yTAe3Oq4Gtwe+aHW5T8I7GOgKOZZg0n4SEdM1OJIAzQ=;
        b=IHpEi6ZgvmbNP/+0k6jCsvUppCxiv6vLbjuNXX+AlDnTra2umoYSgmbc7sPytoVzNV
         0PFr1fQR2OpvzpYnc/OBdrn0DBW/Fm/bjIjyq6/aAnmPv812ml4OxmCMPcl6+zif3F8r
         bwBB13ECvEB44yNHVO9Ayy9AmWuY1R03lx8kehCzlx21DeGcl7mhkRCNpuism2NcWJtx
         i3/ea1NLsFV0Teddm7s1NRxKAOhGs8k8RFBQ3eWElMQnONjdXCwG4HywDsGPhegSfJ/z
         6obymsLmk9u6BH0RjsIZmFKrvoABc1ktqvLRPVXBSVcbNffKddAsIvjKWBjEfR3ubHKQ
         SaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722064973; x=1722669773;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTAe3Oq4Gtwe+aHW5T8I7GOgKOZZg0n4SEdM1OJIAzQ=;
        b=TlLA0uxI7UAtUugWr0Y4l2ucqvGAgyUforkfXzVq5/TRVOYn0cqsPlP5FyRVhAN6Vj
         n4NbyIw7pRYt47lFDMBhY2ZNovDHuhPcQt0Yg617O2lMQSW9IJ6g2/5uXmNOrw5W3fU/
         MvnEjL+kWPFXENubyAlDapmnRVovQwLWYoVi++oR71ECDle2I6FqBRq4HqQakZofiGI/
         HE0cXMPjZ437+AzOBEb5I/Bzg6tU8U42xgCPEcx8i9xVHpVg8kTphIsKnN4+VkVBq9GX
         IAv7qxlaXZwtamS81Ib+fFxZ49zwd7rCjg660k9tCq2pQWbumpls2OnklaJv3Dro8YOH
         Pxaw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQoJWzmawGh/8HzdWKoH/goalHSYPmkAaizwZMPGOpixA9vYMHOZR0zO6YQjKwGt2wuEPG3ZVtLfG8IlnTpR4aNbRRUAGnORd0kgh
X-Gm-Message-State: AOJu0Yw6PIxnj66cEo1UFrp1NCLVzFZmoB0XtjOLvV2jO27edx5bptgu
	BRRz9owdnYLAiB9I6866M7I4P20ebmWj+HSoUtbdjB0QSLi9f2vk9gzgbm9DmsQ=
X-Google-Smtp-Source: AGHT+IHt10QY0pcBbWSUFi/9SgKeB4xClFMu2pDiosx+GuN7h/LiuLO82FiJUhv/WxmBCpUC+YMC+Q==
X-Received: by 2002:a17:90b:4f46:b0:2c9:aea7:614f with SMTP id 98e67ed59e1d1-2cf7e2073c2mr1868283a91.24.1722064972694;
        Sat, 27 Jul 2024 00:22:52 -0700 (PDT)
Received: from localhost.localdomain ([152.58.18.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8769sm6634537a91.42.2024.07.27.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 00:22:52 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH] Fixed: fs: file_table_c: Missing blank line warnings and struct declaration improved
Date: Sat, 27 Jul 2024 12:51:34 +0530
Message-Id: <20240727072134.130962-2-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
References: <linux-fsdevel@vger.kernel.org>
 <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
Reply-To: brauner@kernel.org jack@suse.cz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Fixed-
	WARNING: Missing a blank line after declarations
	WARNING: Missing a blank line after declarations
	Declaration format: improved struct file declaration format

Signed-off-by: Mohit0404 <mohitpawar@mitaoe.ac.in>
---
 fs/file_table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ca7843dde56d..306d57623447 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
 	register_sysctl_init("fs", fs_stat_sysctls);
 	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
 		struct ctl_table_header *hdr;
+
 		hdr = register_sysctl_mount_point("fs/binfmt_misc");
 		kmemleak_not_leak(hdr);
 	}
@@ -383,7 +384,10 @@ EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
 struct file *alloc_file_clone(struct file *base, int flags,
 				const struct file_operations *fops)
 {
-	struct file *f = alloc_file(&base->f_path, flags, fops);
+	struct file *f;
+
+	f = alloc_file(&base->f_path, flags, fops);
+
 	if (!IS_ERR(f)) {
 		path_get(&f->f_path);
 		f->f_mapping = base->f_mapping;
-- 
2.34.1


