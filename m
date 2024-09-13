Return-Path: <linux-kernel+bounces-328991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC70978BCB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E11F2892DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151AB188923;
	Fri, 13 Sep 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="orcj1T0v"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B2183CCC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269646; cv=none; b=ZkwgVQSyHLH7CbdY/vnzfpp0f+/4vbXVlqx/PscPt/s/Z1Wet/ThzS++xVigDGyylY10qi7h005ISuycJPZ/nN3cBn7om65YlKkFO2O1rtiIKTPcZkcOBmPUrBEwULimZe8xIIxKNWMq2ynVO6uIcjX1EhM2+wAJ/ZkctrZCF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269646; c=relaxed/simple;
	bh=wpENg5K7Akr//dxuFB0ettmRrYVh6xPRVyKwVZ5+LdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLWM6b4KH0HV5qQMqZE0d+VATq8wdz0s3z8miWqnadqNkK5qIxC1ZGGcXwh4US/lzGzl1EzwwD64JRNh7NRV/TJO7feH+lf1HBw9oQn9HkA/4Tafxb2wZglom5xw7uAYEEBdtZdIq7t95KHyZGAWXmu07eFqQ3lW/mxnjHxgRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=orcj1T0v; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-45832b2784bso21699001cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269644; x=1726874444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK/BpjWFhfY+uS5/8x0nkKgbHvfXWYi9NIxTZR2LU/o=;
        b=orcj1T0vmMbUesoQIcl2Od9wP3R3KjRLueA0eSxs9CO4ysG8kYwDMQ68XUc5rv9uKq
         HoAFaJGoYH1ZxhVJ7dJ3heo4doLDIwn+Cjklxemasaa+rEH/ReO5+llq8EOX66yDYMiE
         Rx6VUtnqGvn84MJBRhXxelBdgaFOJ5kRFfiYuALPQDzVNIRCBJ2XeJ+unn2NzSb+9jRW
         ndbEO/A0pFYVyVUUVvDcCCkTjiYKxjLMVolX5N397NgakHQB1PlkDHxoQPaZd6tevix1
         hO6+gH79RNPpB/rJqS8du0WQFDufJgWapzqJehPVEkeY2j18KcUWP9mw12NgRZ7sbT1h
         UfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269644; x=1726874444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK/BpjWFhfY+uS5/8x0nkKgbHvfXWYi9NIxTZR2LU/o=;
        b=QzMtWl8lIOnORGgcCaDb5MJmnTRS4AiB87kG5x9PEKbiY9MVN+P1TA0VOdt2sjkIcG
         J4uNonx2OaRWII3aK4OUI3QX2xPMW/Ywpjc9uBSHYKcqLwdKqaPFcm3Gv+aRMo5e5KWU
         DEpqQtJhPS7GnGOT3Ncq5T9+9/ph/eBPG8XPg8aWIebOUk4bRFi6SO3zd7cXx6SP8uSr
         eRhx5P0LSeDnsry7qdXJYfLivP549V/VLwMOYK2nkSVxePl/413F6ovTErc2tgEZRCjm
         xU776cgj9XbMOuv/ZxGl6C0qc3ge24kWGcytTMKmg8L5gnzFfPEJrSAk1+CxiZ4GWX6C
         8EQg==
X-Gm-Message-State: AOJu0YxatuIaofh+wyflt12oATf+bcqPSAEF0bSQZ5A9jCS6AkykV8Kt
	eAktgoFRZgNChLbMmueYG0+PVNguvicRr6+2s+Lw8W5YKt8H90GNNQTUnFOKKmg=
X-Google-Smtp-Source: AGHT+IHU5jGSje/03tzXLhSjKsNALxLWzuMQn7LkdG77pbKLrDkPmNHZPN14O+1c5KiHQTAmeDwWnQ==
X-Received: by 2002:ac8:5fc2:0:b0:456:802c:a67f with SMTP id d75a77b69052e-458602a9264mr127611441cf.3.1726269643753;
        Fri, 13 Sep 2024 16:20:43 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:43 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 2/4] tpm: do not ignore memblock_reserve return value
Date: Fri, 13 Sep 2024 19:19:52 -0400
Message-ID: <20240913231954.20081-3-gourry@gourry.net>
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

tpm code currently ignores a relevant failure case silently.
Add an error to make this failure non-silent.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/firmware/efi/tpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 9c3613e6af15..b0cc2cc11d7e 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -61,7 +61,12 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
+	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+		pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
+		       efi.tpm_log, tbl_size);
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
-- 
2.43.0


