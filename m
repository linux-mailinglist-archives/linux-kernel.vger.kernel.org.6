Return-Path: <linux-kernel+bounces-319454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E773396FCBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B494B23A13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA91E1333;
	Fri,  6 Sep 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="alTob8Lr"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D49A1DCB34
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654507; cv=none; b=JfA3xCGENO2/OgxWunFGqT8NnC2077PfDzmlvBWYTTUPidJW/tWdUNC9j13nrrjlDbD60XaWmXxHNBZWaGQcXzmjW3zGocxepGC7MzfkVVuM5BV3TdF7vREYfYVGyaKERi2ulekM3SEAozT33y9TcdE/7BOwS7eZBri8SEglfdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654507; c=relaxed/simple;
	bh=hMwki+dcsbLSJG/zbiuWzszPS/hNwanGor9EwaxpvVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiIHaojcu+L5wo7bFmeiWh0NuiKkdnG5f8Dgeeew5PKhXVxEecfDEB8Llojd2dxDeZOVV/9rUug1IDd95vJIUr2lLwWwkXb84UVf3S7j3b/8+N03o2x/Suff1riRF7B67dL1IAdVJD/UZjtuD2aEYcpgEF6o+yzGsb+0hP+WJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=alTob8Lr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9a30a045cso19832385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725654504; x=1726259304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eknZRfIStyWrln5IWKBJNYWwEsPBbo1CU0FqbBLiCHg=;
        b=alTob8LrRLGNsjFWOtknaYxPevfLDoKpYubg2FnaILkfKWoLYLD4A2MT3fWXwmFJkg
         KeaRTGZrh9ETOwhzAArn1+sDI197UIjoCCsZ5IHQEP/R51PIWT3T8TId5Zzgcmq2XI8c
         pWfFLDBCoOVuZsj9HlrkRK2rHom8ENqmn1LIZ6SlQDof+4k7MFp0ynW9BSjk9qUjOQ+E
         xxHGMaza39GK6JBKUh2Ye2drrehyMBdSQhfaZ3EWvfXM86oiZbxbdvqDvkL0ptGWHINV
         qPujfIbVYVLmAi2jIrkaTvuY4YtEwYbbRbHzn2K93W499g1scnz+Tu9ZVt0z3daPs+CP
         9FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654504; x=1726259304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eknZRfIStyWrln5IWKBJNYWwEsPBbo1CU0FqbBLiCHg=;
        b=XGBtmpOb01cYZSt9tHp6FOlzRXiFMqQESnCjUJJWdeYmT3MSwBaqBnISWHwUz6s7uR
         7OaZMoOlpoJWwtSMDX2XFi5RCvtxXXtJ0VuJ48Ru5LGdNA7odDEWlBppoxrfNHf1K1G0
         rKvfY3JX3Y3a+2sgbVGH0KQUMzwIuLMmAXmS+DTJezCWt7YuXaVEhm6j1krMF+A5JNLS
         nD+ocNCHRNEZAgz5zPEKv1BqfiUrK9rmxqc4LlPazFCwp/ogjrMdsOAx8Q2N28e0ZPbW
         OmKCfAymi0mhb9+dknP/ilKsTIOQW8NT1LE2qvURhyjFCGY2YaRWaP+hvxZZXuij/7xq
         E6gA==
X-Gm-Message-State: AOJu0YyH54eBC10sKEMEeCcSJ+ER0UINlFDuGfeKj7ZIchz+NcAVX6x7
	54y0pANEMkUAERUxy8dw8VsZjRH9QBd0ak1y0zJncL41eD8MzS99umYzOcLQREw=
X-Google-Smtp-Source: AGHT+IHqdgv3zHpFAbavJQlusxa0A7QBFhgVKAX0yRe62fA02oH9vdiDW+r2y09yybfljROV4ERQzg==
X-Received: by 2002:a05:620a:2495:b0:79f:90:7d50 with SMTP id af79cd13be357-7a997340551mr595628685a.32.1725654504388;
        Fri, 06 Sep 2024 13:28:24 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef1e653sm200519485a.5.2024.09.06.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 13:28:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH 4/6] tpm: sanity check the log version before using it
Date: Fri,  6 Sep 2024 16:27:43 -0400
Message-ID: <20240906202745.11159-5-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906202745.11159-1-gourry@gourry.net>
References: <20240906202745.11159-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the log version is not sane (0 or >2), don't attempt to use
the rest of the log values for anything to avoid potential corruption.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 6e03eed0dc6f..9a080887a3e0 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -60,6 +60,15 @@ int __init efi_tpm_eventlog_init(void)
 		return -ENOMEM;
 	}
 
+	if (!log_tbl->version ||
+	    log_tbl->version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_err(FW_BUG "TPM Events table version invalid (%x)\n",
+		       log_tbl->version);
+		early_memunmap(log_tbl, sizeof(*log_tbl));
+		efi.tpm_log = EFI_INVALID_TABLE_ADDR;
+		return -EINVAL;
+	}
+
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	if (memblock_reserve(efi.tpm_log, tbl_size)) {
 		pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
-- 
2.43.0


