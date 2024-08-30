Return-Path: <linux-kernel+bounces-308861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561899662D1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8998B1C23480
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D141AD5D9;
	Fri, 30 Aug 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lJu7PwFm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E6199FC1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024209; cv=none; b=HNTcDNWMcXn4IwGWvWvxPCzLoW2D70jUJhgLy9F4qsfNvxPcXVFD/RTjtQuupONgSMLb5YwiBUCAFErVLqMvKAhvHBxuBXBhH2tO8FGtRF6Xit5a9lmz1oCjG9ucJsyeHLq86l9Sqw9Q3hQKSp2E8iBVeOL5sFZ7guBfYC7jLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024209; c=relaxed/simple;
	bh=JovN/q1rCM8s8I0KqmQeIxeWvruT6E9Yj4kMIRceKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJycxZhoQoxYuM4XqTsOK69S5Qg4lup0fQlL79ZB+BJCyjQN2MLA5b43Yet4wJAKgjWMyYFUqCqcbzrjSUDGm6du/IQdfqjEfg3pm6A2Ko1RVSx4knMRLr2K3iPFLJtzYf0li3W6A+by48EJUUl6CoDeVevFZ5K0++b3BAtqu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lJu7PwFm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf7f4a1334so8027156d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725024207; x=1725629007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTgw4zeKGXQ1BnSya5EmmUz/kqtWZMgtCFIviz8ICC4=;
        b=lJu7PwFmYW8c2DFI48YMauxL8f7qE2p55o3IOHgpMRAQAIMbmV6bVaS37JeArrMkWj
         sOrWDLlSZHfSKCqokogRsNsDYrJukBWOCiiG1b7UILay9tmEWctYJcr/nuvme4XoVWPE
         UVrpncG3rXtZVMzFr2yBHvajBrxOR26B0JUCXqapuJPGpusc4KeajxQp7FPncnU6I4BO
         vDj+S6s3psIzq4YzNHRvLuac6NnkZ+jVe5Mcvy4AE7NJSzF94pkdMJSxvZ0IxOrhZVGi
         1BzkTUrf7PpF4dSN4QQ41gqaXsOffB/wRVK1utU9S1SxVWxqoXd9duZ8jBnQW+boqjPb
         EX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725024207; x=1725629007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTgw4zeKGXQ1BnSya5EmmUz/kqtWZMgtCFIviz8ICC4=;
        b=N6wXD+H7/Ctcg9yHTJgapf6pNf2q2kmgKjopVDhk/0FAbUz30b1kuY5VgZITtUY2S5
         avMS+o89Ggn8Lcf9PptWvG5wtd5sLfvcwuHZDtfvpAg688wkvp/eYCrOWuVpHszkzd6V
         fBTScc9YppZncRQhAuROhe1gu0aWZRPtMQIy/Gn6Mn2tbu/ebR+s0QZEzuq1W890TUgq
         hNH0WF4HU6cL4JMkmH0Hy0gT8Tf0X1/W36LrZ1bD+qwAjoY9q8n03depev6O120NBE37
         eDsFtFp/uBOFG/4wkR0QEl8qidPEFxMFVyG0jsqE5muBuqjO/mhNsT+NUjkLnkFn7C/Y
         UKuQ==
X-Gm-Message-State: AOJu0YyLlTvNVnMz7AkjD+H70HlyUrr+BZkqs8la1K2ewIGx8l74x6gQ
	cuKUmGp2DXf1yIzKJ1+m9CSOK/IA0kweGMeFk09ErKlSUSEsE9dBouoAYUfe3ek=
X-Google-Smtp-Source: AGHT+IFgmKjMD5PnWPuZ2ZPMTG0mC0q4bT3k2BC7Djoy8PoEcdxeAoEtHZSZ5DAP23yCelxr+ewTCQ==
X-Received: by 2002:a05:6214:5b88:b0:6c3:33b1:20d0 with SMTP id 6a1803df08f44-6c33e6a7f5bmr70648506d6.53.1725024207070;
        Fri, 30 Aug 2024 06:23:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c44619sm14485066d6.74.2024.08.30.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:23:26 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org
Subject: [PATCH 2/2] tpm: do not ignore memblock_reserve return value
Date: Fri, 30 Aug 2024 09:23:03 -0400
Message-ID: <20240830132303.6665-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830132303.6665-1-gourry@gourry.net>
References: <20240830132303.6665-1-gourry@gourry.net>
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
 drivers/firmware/efi/tpm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 9c3613e6af15..b6939a6d44d9 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
 	}
 
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
-	memblock_reserve(efi.tpm_log, tbl_size);
+	if (memblock_reserve(efi.tpm_log, tbl_size)) {
+		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
+		       efi.tpm_log, tbl_size);
+		goto out;
+	}
 
 	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
 		pr_info("TPM Final Events table not present\n");
-- 
2.43.0


