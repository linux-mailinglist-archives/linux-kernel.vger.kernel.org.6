Return-Path: <linux-kernel+bounces-525960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7DA3F7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AEB864291
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3398212D8A;
	Fri, 21 Feb 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dEZFdnjO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A662116E5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149847; cv=none; b=gZMAMiwD89FYJbcMMago6e2MSXTJWcVNpgLJVrkeHCmXbPdgpP5EkLsD1bhQ80DRgKdF8M4/J03WTqr3O01sum/T/xhGzpd+yRzrFFmHECCbSXxdlzsknjrakPONHARUfqPdGuydcd7yInSUaZavCMuR1F9xl87xHzRD3XAaOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149847; c=relaxed/simple;
	bh=o9zHYBZOjWU+lYENxdkNUmWAHWMdM0ccAzzowc3/Wqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev5dQJ7QzfmT9NvIMTKv7IX3NFsqLc3CF4CebaRZBh1XtGI7gQvxtTN/yA8STldGf0UnkuFPjomKAZUEYKcyBSergwjvjlobHH84xUcYMOexyf/rBJN0W4OCChsDqhSZiAzmfSAChTmgw1QkiCHJW7zOpwlokNt+uEalD7uabPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dEZFdnjO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4397dff185fso19028665e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740149844; x=1740754644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL25umXnpXBBzwUoMnOj2fRLliDIrDaDucRmmKK49J0=;
        b=dEZFdnjOpgB62yknVjbYccKccJW7GSRFADDP8PtBHj9BVXeOZ1u0UelbYwgYH+RzPQ
         /VHH+mz8/HedQ5rlf2l24hixzYdCibvSRG73x+/swjhD9NYmHFOnIgMVqmWTOzO0qz0c
         zD/KTBdklsLzDB8lrovOLrPhO6QcH5mqWHx5IJy3OwcMmtIK8UAcRqAl7AkVrx1f42EX
         XBJkrcZimnn1rlYmecCSbHK6FxFtTuXwhZ+d0BqoOx1GMlSvMJYnuffPZwoReYIbHI8d
         /wSOprw1eND6kOc4uynF4QD2pzpjAJtry9hHxTi6sjJqr7icXrwJVWxwj+UMABm/HNi0
         CTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149844; x=1740754644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL25umXnpXBBzwUoMnOj2fRLliDIrDaDucRmmKK49J0=;
        b=c4gv62kV3RP96GtdsTTr091Q4eEUlfxnsDOlEnKJC2E7/YBRLTdKep7a7SGG2yf1OS
         dLH4FqFB9W1sdnIYz/zrMlicwt1CySwSwp0ZJPLiwyMJIZUFAgaxm3bwSN0umQT9YkMa
         HmrBU5WSG95+0/ZeCIid3YpKM9Ntf8weW0KVfQr0OMlzv0zz9iiaX4+g04fmjKJRGYLU
         8buYxfp2goEkpz8OhO2ODOqcDYG7EopekE2BGrcqyVIEGkm1f69qS4n5ojxXGCKrG8kz
         axnvGmAjNeK+AwNenS4KKqZ+ih+XeIfpSGgxi0IGJ0ZLaaVSAyNXIkcOOioljlcNZFAb
         W06g==
X-Forwarded-Encrypted: i=1; AJvYcCXZKkJs+5s5JOLUXbTL0JmOF9H4IVrkp5Hh9quTL1r99JczscN1LwPXiBeLp4uXZzowfEMtJhPutFaG1Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmfuBkTQPAzODd+9A9fxfykWNB7BAubTDcDw/U/nlpqvBIbTN
	OUU7+Z9IqJTIcyppKAjeTEhlExSepaw7oA+fXf0jEjqqqX53nfCGlp6VSlJOU68=
X-Gm-Gg: ASbGnctqRPs/smGOIny4wnxK6CMG+l3p0IuWzlCYdPgg4cy6ai5Cril+u1oMMkVu7y/
	MySZaPE96vIplk6Kt/+jms+8E5NWRWkrFJn/MkkQJKubN317aC3Ov/lfymhsM8SFAbITT/bocPR
	e+ZE0llUXVuK8YmKLf4AizH1c9iBblJccdaLe+5tkdjZcGFW6malW9asBdYPHkLH3UutvQRCvij
	awiHWiatbyIliaGmHWUs/8+AzFgWSL8bNBVhPOcuuOB/sYArA8MQS7b++7OlQoGQLUVtkqvwL8b
	2DOMLu8vsUr0hQ==
X-Google-Smtp-Source: AGHT+IEUAirr8QCvcHPxcSxcdTz/htKaV3QDGHz78tljhwlnJaYoBkEeV24i5MRcuIDBul2oYPovkA==
X-Received: by 2002:a05:600c:4e8d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-439ae189b90mr35989955e9.0.1740149844345;
        Fri, 21 Feb 2025 06:57:24 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce740sm19898235e9.4.2025.02.21.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:23 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	alex@ghiti.fr,
	Anup Patel <apatel@ventanamicro.com>,
	corbet@lwn.net,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 3/8] riscv: Fix check_unaligned_access_all_cpus
Date: Fri, 21 Feb 2025 15:57:22 +0100
Message-ID: <20250221145718.115076-13-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221145718.115076-10-ajones@ventanamicro.com>
References: <20250221145718.115076-10-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_vector_unaligned_access_emulated_all_cpus(), like its name
suggests, will return true when all cpus emulate unaligned vector
accesses. If the function returned false it may have been because
vector isn't supported at all (!has_vector()) or because at least
one cpu doesn't emulate unaligned vector accesses. Since false may
be returned for two cases, checking for it isn't sufficient when
attempting to determine if we should proceed with the vector speed
check. Move the !has_vector() functionality to
check_unaligned_access_all_cpus() in order for
check_vector_unaligned_access_emulated_all_cpus() to return false
for a single case.

Fixes: e7c9d66e313b ("RISC-V: Report vector unaligned access speed hwprobe")
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c       |  6 ------
 arch/riscv/kernel/unaligned_access_speed.c | 11 +++++++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index aacbd9d7196e..4354c87c0376 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -609,12 +609,6 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
-	if (!has_vector()) {
-		for_each_online_cpu(cpu)
-			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
-		return false;
-	}
-
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 161964cf2abc..02b485dc4bc4 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -403,13 +403,16 @@ static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __alway
 
 static int __init check_unaligned_access_all_cpus(void)
 {
-	bool all_cpus_emulated, all_cpus_vec_unsupported;
+	bool all_cpus_emulated;
+	int cpu;
 
 	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
-	all_cpus_vec_unsupported = check_vector_unaligned_access_emulated_all_cpus();
 
-	if (!all_cpus_vec_unsupported &&
-	    IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
+	if (!has_vector()) {
+		for_each_online_cpu(cpu)
+			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_MISALIGNED_VECTOR_UNSUPPORTED;
+	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
+		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
 		kthread_run(vec_check_unaligned_access_speed_all_cpus,
 			    NULL, "vec_check_unaligned_access_speed_all_cpus");
 	}
-- 
2.48.1


