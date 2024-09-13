Return-Path: <linux-kernel+bounces-328990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CA978BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194E72890BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70818660E;
	Fri, 13 Sep 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GZvzxVyY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA24156F42
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269645; cv=none; b=kJzGbbI6inkYMtiGYeL1DORGR+fKCStuDU2xHV3h8IetP1K/2+DUoy+fJZ2JLEKxBgyXgQi5J7oQ+aW2AFEekHvb2oL6Bj/hti/HSwMRdNVTS2BrBiqFvbkzxSi+j5iIYGnKuCAgTWkyytpIv9jzGqI6eFmZrZ7jI9KPPmkFiaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269645; c=relaxed/simple;
	bh=uC7TJ50a7SgbOtivAxR2KdbHsbIyQdSdr5oMF9F4ufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWWRuxOYKu477rNsauaYr7xxk8zTbssD9BYeayB7v2pPYSya4uhAqekyNu+h8ZCaZMUC63Ikc4hWXK4Rla92MXWBo8u4cvMU/+BZo1SIHzYqpjVPh5RQodx+bNRBV8Qxq+DLeS2yU0XfhSZ+2+JS2kPXnsxonWcwkchz59OT9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GZvzxVyY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45812fdcd0aso33505501cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269642; x=1726874442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=GZvzxVyYJXhxL5uhKbC4ps8nFJjYktP+SieYEpMXdAGofqEfy2y7pPRlXWnbu7lFbJ
         xZ7QRWQNe/RMeYES2A9XjgNUWmkjv7KiBFLp0qtXxEnfIcRNAV3jek5iSxIYLxdfK7YK
         hn40XYogjjCMch9KFraj/wJwYvwszGT9vFOSV8rZaGDrvo/1yzX3pdFJq7SwhntR5Xzh
         MmLGJshLfNi8vMfQcn+n3bL6wkI4i9WlHNrGyq59y843OPXdhXWlAMUr43L8spiwh6cI
         LI6ltVCT0uvBGXswcTU4KEcRUZPz5ZEN06iQeZXSgYoGrRPWmEAiXswsSKbBiG1Y2Hi/
         F+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269642; x=1726874442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Rs9Vcw1DZn6LrVte9jSPxFRjikUDDX06xvoSnqYrw=;
        b=suMANMY+PhA0FWl6opC0iUxdhZp1Bvti0BAXBR1k6v5YooPRQyjSCJ1vLgi5vKr5ay
         FY/B3zU7alY4ibH2la90hXzuNba77M9+4tPxnLO4m828NRu48iwyTZQkp3nuX25R3pmA
         IG7B5zBZOxfk3XQA4XVW/vnSwMYCSDU9EyXSl7434+uWaDyDReor44w2aQi3bIefCWCU
         m09t8N6+biVj9DNLRrgVOsboo4F2rjx0D2RVp0BHpTr9F6m+y9OiFFmvRKy9g+8IWbMb
         vSlZtrE9Pb48S6Ljb5EMqqx/VQh70k+qme8tiLTv7q/N7PXT7RvJAWKXyObA+TbxZfwe
         Lxlg==
X-Gm-Message-State: AOJu0YxW9iaFfVxArV1cVD6aeJJ9KkN6X2UIchdfYNcTXB/PlNs+XkWz
	Y0IcUOFeBbq/d2d7jHS/uDE2zvvgDczelIhBLF3/rz1AgptuwtnA6uBsxjrhIG0=
X-Google-Smtp-Source: AGHT+IFp0i6BEsm6qcRfgkhhKwCvAWwpyUz8Me8bMXheogGSHuS5iPPX0ul01QpecBqdsilzODu7fQ==
X-Received: by 2002:a05:622a:418c:b0:44f:f271:af63 with SMTP id d75a77b69052e-4583c7adbcamr268220821cf.21.1726269642488;
        Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 1/4] tpm: fix signed/unsigned bug when checking event logs
Date: Fri, 13 Sep 2024 19:19:51 -0400
Message-ID: <20240913231954.20081-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913231954.20081-1-gourry@gourry.net>
References: <20240913231954.20081-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A prior bugfix that fixes a signed/unsigned error causes
another signed unsigned error.

A situation where log_tbl->size is invalid can cause the
size passed to memblock_reserve to become negative.

log_size from the main event log is an unsigned int, and
the code reduces to the following

u64 value = (int)unsigned_value;

This results in sign extension, and the value sent to
memblock_reserve becomes effectively negative.

Fixes: be59d57f9806 ("efi/tpm: Fix sanity check of unsigned tbl_size being less than zero")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index e8d69bd548f3..9c3613e6af15 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,7 +40,8 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	int tbl_size;
+	unsigned int tbl_size;
+	int final_tbl_size;
 	int ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
@@ -80,26 +81,26 @@ int __init efi_tpm_eventlog_init(void)
 		goto out;
 	}
 
-	tbl_size = 0;
+	final_tbl_size = 0;
 	if (final_tbl->nr_events != 0) {
 		void *events = (void *)efi.tpm_final_log
 				+ sizeof(final_tbl->version)
 				+ sizeof(final_tbl->nr_events);
 
-		tbl_size = tpm2_calc_event_log_size(events,
-						    final_tbl->nr_events,
-						    log_tbl->log);
+		final_tbl_size = tpm2_calc_event_log_size(events,
+							  final_tbl->nr_events,
+							  log_tbl->log);
 	}
 
-	if (tbl_size < 0) {
+	if (final_tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
 		ret = -EINVAL;
 		goto out_calc;
 	}
 
 	memblock_reserve(efi.tpm_final_log,
-			 tbl_size + sizeof(*final_tbl));
-	efi_tpm_final_log_size = tbl_size;
+			 final_tbl_size + sizeof(*final_tbl));
+	efi_tpm_final_log_size = final_tbl_size;
 
 out_calc:
 	early_memunmap(final_tbl, sizeof(*final_tbl));
-- 
2.43.0


