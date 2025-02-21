Return-Path: <linux-kernel+bounces-525655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C21A3F2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488A019C72EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2D0207E1E;
	Fri, 21 Feb 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bU1EGT5d"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EB204F64
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136526; cv=none; b=UDONp+uLCNirPQTB+XoP4KqhyAduAFkM0P3Bu0g1LZ639KqlfAL2ljnDufa/9YoAxAWQnN+aB/Ae41rQuWLM2o8IAErIrgkXemszDFCpgXmTSdrzKRe7EMksDFpAH1pXOwD2qjIVIYGb0R7Ji5AXoXK4nBzjb6HoTR2uzpW7jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136526; c=relaxed/simple;
	bh=JC8s15lbIpk2LxEdMFhsWVRfCPianxn0zv+SiCNeII0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHyxFOt8a3O64KswsI5zM7B4EqxjFLT1JK3B2yoFwT5v5MBiW7T1n6YzDsF31x3oOqjXVy0uFaenrKdvGHwYUGfkwkEnr5DGPQo4xpAbT8uHVcBDXume87F7ZmofeCg2yE+Mi3oTTquSDZdrL8D5A3qhS9CFNunHBfdH/KEy10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bU1EGT5d; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbb12bea54so379876666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1740136523; x=1740741323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJsIzieDT+LZAQoeBL2lnvHU2BlH382x+Tm2WYroiw=;
        b=bU1EGT5dRXR7rAXDy0hbukoc7ZAH/H167WwNOvMfp6nbNzTbEC/Jhgnu+yPA1xqtHh
         wHJVsG6eIJtfDQIJGNs4cMol7znIQ6JW5sZ7jMMB0KHO5psKAW16+4EF+eutZsRJ/ZnE
         Td57+oZQCeLevAfY9GROgCqp3YJBz9SA3DmdlBplISLZkN1HO8dEBs1p2eMt9YpGkeG1
         xEFG2dWcrDaQ5B6S0ZZMCP6lKDN/6fkZyWL1xsk9PKgjkI3+NNebnfiPq4NRYUKN2P/9
         6jN3P70LrfF/uvui20SyHecJC8ROGr8O4Z97yMaz1KKS3aksE4RzWH2mNzJdwm4Unvzn
         Igyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136523; x=1740741323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKJsIzieDT+LZAQoeBL2lnvHU2BlH382x+Tm2WYroiw=;
        b=bRbE3ikoOUQLq5v93n0Xb0lgKQQTTUReL5AV2XdmSiHT/5hScp/oen0Fy33CC89d86
         X4tDQOkcT3rD0PfGMODV0ErNe1TTRETLwfEL55R9Fjqb7vkN39Md4PrF80Tj9dasE2zu
         rb/F5oNPU1ZuOhBUdxBsdBLYGwf/Q2xPDmfonLOidI73g+uavec3Va+SudvJapLZdbgF
         rixCO4YauUZvWQ3v5RvhFoCEAg4cgtR/xkb9dc8zYR3nur18yzrbOi5rsbCxa45Xw7au
         8iqCMRKZ8YTDIEMMIuSL0n4nXxJElO76xVzM8GW/4BJPdvS4kCd5XxgkUN+A3MM/z6T6
         18/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULUKuBvxjiU1q2+u03hHMls1cP65aYF5cTsVo2tPi5O0EVHrc+ZmobhnmkS3otERI2WPLw3vtc2uUfLt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EuiVgjsaLP762VuhbHRXtAPs6dFb8cEagsszDSQYCr1YNLF5
	RMlMr14F0v3F6fZVvJ4Sg+n805jA2/WFT5OI9ikJVbQnWk7wLFLLOCUpxTFEgi4=
X-Gm-Gg: ASbGncti9Zp1HMXCPnLki/Ngd+oNjlch9cqqWPjuSxrP5yloviNrNdrPbMjdSVIpjLl
	mZ7zWrZWhPzIOaw1lW8qgT9yNnYdPMmiO8cbQwkACMxCtx2miBFjxn2cOQXZNmZJGkYWwGxrvqZ
	QQ1ltsYNbhQR9GIc1c8soHJsX5HpbymP4XBE/1Rhz0DogUCb3KqUtBP/vd5kojvZIQK6FB1+jo4
	I5WD92PDm4SilaAwH5NrnXwLOBYXG8jMP8XrCZT542Ag3pE6ZmuBdCx9dF/LSix3WQwgZYmh1Rt
	0XWBAG0rS3gHgBOaNUp8Sr1sXufJKMaaquXYcROOWyZkrOSputOaHXvp3iH8TcZPGrWrGfQlkwY
	qyAvBLdbi16ScG4hrE4XiAeGV
X-Google-Smtp-Source: AGHT+IHfwheDAfyvVJBq8JCrmMPG7NAd/4D9fIvfDegRQukqwTY8Il/imHtsusJZsDueYJwmDU3mJg==
X-Received: by 2002:a17:907:7715:b0:abb:e7ed:d603 with SMTP id a640c23a62f3a-abc099b83d5mr286093766b.9.1740136521119;
        Fri, 21 Feb 2025 03:15:21 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbd5502c53sm499291166b.159.2025.02.21.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:15:20 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] efi/cper: Fix cper_arm_ctx_info alignment
Date: Fri, 21 Feb 2025 12:15:16 +0100
Message-ID: <20250221111516.1468261-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the UEFI Common Platform Error Record appendix, the
processor context information structure is a variable length structure,
but "is padded with zeros if the size is not a multiple of 16 bytes".

Currently this isn't honoured, causing all but the first structure to
be garbage when printed. Thus align the size to be a multiple of 16.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..f0a63d09d3c4 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -311,7 +311,7 @@ void cper_print_proc_arm(const char *pfx,
 	ctx_info = (struct cper_arm_ctx_info *)err_info;
 	max_ctx_type = ARRAY_SIZE(arm_reg_ctx_strs) - 1;
 	for (i = 0; i < proc->context_info_num; i++) {
-		int size = sizeof(*ctx_info) + ctx_info->size;
+		int size = ALIGN(sizeof(*ctx_info) + ctx_info->size, 16);
 
 		printk("%sContext info structure %d:\n", pfx, i);
 		if (len < size) {
-- 
2.48.1


