Return-Path: <linux-kernel+bounces-546865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2FA4FFCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEF83B2772
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0D24C67B;
	Wed,  5 Mar 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0Hx4L5Q"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562B248884
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180009; cv=none; b=S2MGqvdsRLc1ChPa8rC5D9MP92pqRuF22XtgHNLexJhWA/KqSXcSy+5jDtJKMqPZwHYWNIrx+YJEz8jwrcvRFaFLu4m1xLoFQn3fgJ2DjdypcOnyE6+E846kLblHKxkszE8aw097S0FNR0HgCMT5cCTZIVfICHVSbt3MN5f5uFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180009; c=relaxed/simple;
	bh=noepNtfKlkYfyEuB8tCbH+R5KF4tmiiJFNlLMXy5mLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gF3gJeIyjKRRiJE0dexO2HYtH8Gx5Z2d+/+SFkyZ6GVdNLmCpGMd4styjLXyFqw7zBU/J6QBQOhHhdRIyjAIzZSH5FdQJSo42wtyAnz3cEq1dFz92kSnFPs3ZaypDQaOoErJdrAAX2MKdnNCKoBCHHfDGfSgxku4QpSaLVmdoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N0Hx4L5Q; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so5709625a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 05:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180005; x=1741784805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g64carhpN86lM7kPnuUc7tjq3kR3ZxlKeoOmJi6Slgs=;
        b=N0Hx4L5QiXadU2KpKAB7vCDQRi9OSLLPVh8eCinEgEPHPSv5e4C8v/CyKpqX8rY5K+
         AZWlCV2I9DCFtQA9GE8lToVv93C10sA90t+HsPbaFfpwJZbOgmAEet4ihhP5pk6yHtxZ
         Ejjg44C09RnH5e0/xrH9vqbxDuGGwLM5+C41m8bm5WwCbKben8p+Gwh95QiNojRV1saf
         U69zB2UgAScGQT59SXmt43sha+3ypseK/N2ROwXEiVGRlAQusLhMX/f23uzxxi7MAiHI
         NAQXLXzPjG23jUB8MfnUJj/Vy0r9YYy2Sywz0RHec7EnV/5gOFJflFkHUHeUJUgwyGem
         dYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180005; x=1741784805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g64carhpN86lM7kPnuUc7tjq3kR3ZxlKeoOmJi6Slgs=;
        b=WZoLNZCSuuiLjiH81YHHuk8MRWaDfsPkkMEh0+RTQDre4zNaFVSu5H2trWw4cSAn+8
         6FZ3sl84mcql3oVS5a/RBYWdR90mdgSycIWgEqEgu//czFrbmPqhiHlzb/dv1BFXXKo+
         rrfo7OKeB61sJcjnnoKDgdRKcA8FOWEcdCwoLXqYdFTeHuSYcmDBt86moR0nTyytppaJ
         A6zsYpgBVzJpMyaOsDilV0vSs9gfYZ1zdQcfY45rH7cEhNcNq7K6TmytKV/rqtlh58Pp
         6UAheJ/OfeXiUS2t2X1fFJI6sesnBy535FuNRydfYhh4kNz6U6rVxffQKw5D/rzf9d+7
         oQrQ==
X-Gm-Message-State: AOJu0YzmmxZLCsj+RKlSumxNdOCgpVSnjmnujgBM1ILfat3jUsGbJo7a
	OLKipvJyZ8/IK3QUlIF2f0JKXSoz2SyjgYVP0CbKG4Heq6qq0jawUzMks5CaN2x15AIOf0qvKdb
	ujIo=
X-Gm-Gg: ASbGncsxJn9fi+1/XXNDggljHjif2ecxxfAskqcnTIHJ5Bnga1qz36tWmaJG80A/pTW
	HrXUVq5hOnv0ya03eM358jmvmoauNb8Qz3OJbfvAU7VnY7EdzIHczB2JyekU7aLL3VhoBkypfk9
	X/dwloap3XCbOj8oxLIfweIFobB96ZJGFBaXBCVRVo2XWrAu5Q6lbfdfOos1n19Ld/SxHiqpspk
	SqRY9tDGeY/ih+YxWVwufWYhY/BfwK/jzlJ97B5ahlXjNf0FcvaMT3FV7//8wWZzaWeIiX6csrW
	6T4MTbpJaWtLQ4cgJjPyz2cpsix2HqjCBWPnrhDh69r1xqjMRm6B2yjJp1tkL4SE7qzHVAVt5Sn
	Q1BtoPIXgeS+c8C1HTDA8Yg==
X-Google-Smtp-Source: AGHT+IHAJQdH7f8KJt+R2ffDvxbc7sUQ+b3jomBMCSiokLRmAxj8briZ+1p+KDuEOOHd7BerJyZSMw==
X-Received: by 2002:a05:6402:5203:b0:5e1:9725:bb3e with SMTP id 4fb4d7f45d1cf-5e59f4869femr3345168a12.28.1741180005006;
        Wed, 05 Mar 2025 05:06:45 -0800 (PST)
Received: from rayden.urgonet (h-98-128-140-123.A175.priv.bahnhof.se. [98.128.140.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5bcd1595bsm65714a12.42.2025.03.05.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:06:44 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Cc: Olivier Masse <olivier.masse@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	azarrabi@qti.qualcomm.com,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Daniel Stone <daniel@fooishbar.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v6 02/10] optee: pass parent device to tee_device_alloc()
Date: Wed,  5 Mar 2025 14:04:08 +0100
Message-ID: <20250305130634.1850178-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305130634.1850178-1-jens.wiklander@linaro.org>
References: <20250305130634.1850178-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probing of the OP-TEE driver, pass the parent device to
tee_device_alloc() so the dma_mask of the new devices can be updated
accordingly.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/ffa_abi.c | 8 ++++----
 drivers/tee/optee/smc_abi.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..4ca1d5161b82 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -914,16 +914,16 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing = true;
 
-	teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
-				  optee);
+	teedev = tee_device_alloc(&optee_ffa_clnt_desc, &ffa_dev->dev,
+				  optee->pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_free_pool;
 	}
 	optee->teedev = teedev;
 
-	teedev = tee_device_alloc(&optee_ffa_supp_desc, NULL, optee->pool,
-				  optee);
+	teedev = tee_device_alloc(&optee_ffa_supp_desc, &ffa_dev->dev,
+				  optee->pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_unreg_teedev;
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index f0c3ac1103bb..165fadd9abc9 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1691,14 +1691,14 @@ static int optee_probe(struct platform_device *pdev)
 	    (sec_caps & OPTEE_SMC_SEC_CAP_RPMB_PROBE))
 		optee->in_kernel_rpmb_routing = true;
 
-	teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
+	teedev = tee_device_alloc(&optee_clnt_desc, &pdev->dev, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_free_optee;
 	}
 	optee->teedev = teedev;
 
-	teedev = tee_device_alloc(&optee_supp_desc, NULL, pool, optee);
+	teedev = tee_device_alloc(&optee_supp_desc, &pdev->dev, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
 		goto err_unreg_teedev;
-- 
2.43.0


