Return-Path: <linux-kernel+bounces-568304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C1A69382
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB93AD104
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1AB1D7E5C;
	Wed, 19 Mar 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9hbaBie"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2691CAA8A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398233; cv=none; b=UD1gEbl3EKlmYn68AUeOu4LJJEUFf0okGcMurR1OaEwpVRLowCbfx3UVm8rkfNGeOzzYN4BFSpF+hHCf1/CV1gEMeY01hJxoTMB2xPoJqu/in/6cy7KB1Zl2PphfO3TtZLUKLcgYTQL6gYKom0KvIANZbBcQV+Um6J82xT3ZkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398233; c=relaxed/simple;
	bh=03nXe96Gz68DXY2H0Ujds8952wDZmWtW9nwe7BZ34Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otgfWOgXHUoia3q3Ppe4mvpQ3Lg42x8IZwfDEHFAQ7kB46tdIZaM7Phw95SySbTS8hTH4lmb8+AwwfjMVyL0KiHyaEQOzxeXryOjqKrWYQsr9LlXMw9x06NaIiGg8cCBkzPOC2Fzv9BrCd0Oilyop0KnTGoqJnwJz4jID3k9Hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9hbaBie; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so6457125e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742398230; x=1743003030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwjbmevRcW4yMfkA4dX1AKUxaSG8vNc+QBgPKteOh5Q=;
        b=b9hbaBieY6xkd24eowA06DhvK10O67DQdqezVgbHDd+/Kj1B5+9tBgw9jK5mN179F9
         kx7MLSV0TS87JFRaaNAWdBEn9DxzjB5rrMMplxKKCTX7F7f6Uh6kd/ky1Iwr+5KTwspo
         jBmjuFm48pYN7xfgaz5e6+emtoVepUWesYYrFKtSQwVTI7blnXQ1xHpEtxja8sHOajNg
         eogcGTgkNeUX00hyf6X10yF6Qxj8NBosoHTZ1fuEnd+LRI8tVuKD7zh3vf7S6DAe1kyc
         9w2+2wSYHiseokhx36iiCmicFKjshzGkRVJeSm8M0cWNgax45YqBjZ1M0Detes+SEhD2
         tg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398230; x=1743003030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwjbmevRcW4yMfkA4dX1AKUxaSG8vNc+QBgPKteOh5Q=;
        b=maLIFcy0mTOavcYRznMsJtrkvabFtGiZmA6FRsu8ftiEgfH7b9l1UflAnVev5LLvam
         87SneTU/GILVnGLbyELa/8LPmT80fqjZeWVX2YqN6lT63fK5D7fOpKC4TtQ4ANVOFp8z
         /fNDwJCk7w7H7WWc5DYcUcQbdaF1SDBQEY6MbxjLe2OijnYbF3D/M0XsbAcD50BJtV4J
         UsA201d6XhNACMIey8XkRYd2t8jPenqpbrcwUM1uneFV52jsCDUqkrcXp+GJ+agZTxAO
         zdFN6UdrzrdXkFZza4+xdJUekAnZDGD5LGo9coukw3xWrq9CKDDaAVydVzMX07YSNKHI
         0Nbw==
X-Forwarded-Encrypted: i=1; AJvYcCVqWiZ0BAv+x7Yfn6ctWxIR1QbhNuIKMBVLLNLIj9q2G25PBQfVlRbzl5UJPmuIQxaL/+L9nov8YaQjYXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyl4pBJ8z+VcoyLM5RSi9yYlQSlZ4AAgo7BhfuQ7b+8G2B5sns
	AiV5hJ/HCPC0VV6689stsl1IjCxx81fkB67UqlqE/Q57bT+2fLDI7OW/FfcTwdc=
X-Gm-Gg: ASbGnct5iB4Q+O7sthCuCsslC+dcCkPhyQVcM46I4neWOLWwWZk3F9yER8aGCoo+V6v
	/lUviLAgTrIDll11734oA8qcbPQtnBfZngLFBl0dKIMeV/oRUuIUSFeZjhsjMYVe/JCdUzVAqT6
	Nupwm2fXKZVP9aGDPLvm33ENYNPNfzuwkRPtURIAj/vGCMz9jvj1CmtLd+by+SAf+q5WJzwgUKr
	RpJOqVuTpTTuW4RENUCFvBfNWMqh/fGQNEAy7OvHEcIG5Dg5+mHHCJh36fHylmt2gHAw3TtoWrl
	gjqBCn8P5eVdfPZivNLXoIdWx0u/Hh3EXbJxcdHAbGBTCBwrmGc/e0APX2CLfk3JQfJ4CjHJtX5
	W/vxwybDqaKA=
X-Google-Smtp-Source: AGHT+IGMbhvAoKZ5MZTSGuKQwWBy+XHvI6tDwhUHbcw9eJrBgGY8SFOMgUHG77gsUcqyh9kE5lpXWA==
X-Received: by 2002:a05:600c:5856:b0:43b:bfa7:c7d with SMTP id 5b1f17b1804b1-43d3b95f76fmr61386045e9.2.1742398229831;
        Wed, 19 Mar 2025 08:30:29 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([212.105.145.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdaca8sm22590635e9.28.2025.03.19.08.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:30:29 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 19 Mar 2025 15:30:18 +0000
Subject: [PATCH v2 1/7] scsi: ufs: exynos: ensure pre_link() executes
 before exynos_ufs_phy_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-exynos-ufs-stability-fixes-v2-1-96722cc2ba1b@linaro.org>
References: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
In-Reply-To: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanho Park <chanho61.park@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Biggers <ebiggers@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 willmcvicker@google.com, kernel-team@android.com, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=03nXe96Gz68DXY2H0Ujds8952wDZmWtW9nwe7BZ34Ws=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn2uMQZlA3NYaC9iaL3h/pGHUSlEutMRvCD5thM
 9WKscPfzzGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9rjEAAKCRDO6LjWAjRy
 ugjPD/97aGZqjPkj2/fwPbyQRgsv1vpdcmhpXOfwtWmb1QyfOW6/ACBPRX1BjM4Fb32yZ7mz8hW
 qS5ca003v2iZhlO/pxyOsaJswTIzUNpY+/X51cAEjIOA3eizjndOKzl5Sa/+pmuXvoW0MU2D64Z
 0fDE2rkK6C63xBtMv9vSyeGWP0xMGtjrXH28QjH7O7OUgpBpAlQIlDY2W+3ywbWDpvBLPObLiki
 f4RVMFgRf1mT43lig0UDqf4IKyDyAQClKCXMF7Ml7QKnYjorn0i5eFd/MjJGhXkOyxRcsBqsw8v
 UlR92f8uBwlQDtgiV2odpELxZUNQyspLFbzlzx1nXCS3J7tBuwmnyfipWMKB5d1UwL4Ccaj4yMa
 PsVfbR33+4w6vVl0q/0GCouG4KaeM9Ps6fgUpUh5t/C0RHhKTDQeru7yf2LKcTLOoy1L2mrvsLA
 XKBSjaQkfMctqQlBP6o8k9iViVBtn0ulX9Ug4dGcjyXzpOZl2QAuIAKvLFTK55Vem54BuYf+mL0
 1O00+Y3F/x6U3qLelrsYoQtxfVD/X7Tmh4nxSPO5iMorpfIwCHe+aIrkjFL/VJWRDvzZP8nmkjv
 fgC4v4xpypP3/70b6R/Pii7WMujV8WGTIpmoTrbE9XvBnkcEwQdB3o0Iu8VZouSWkgm2P5J/9cl
 LX5cV3J9ueEAxVw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Ensure clocks are enabled before configuring unipro. Additionally move the
pre_link() hook before the exynos_ufs_phy_init() calls. This means the
register write sequence  more closely resembles the ordering of the
downstream driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index d7539cda97da5023ec8a2852ff3f5191642ffd37..0c8c2e41e851cdbefc80a66d87273b7e8fcf9d4d 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1049,9 +1049,14 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 	exynos_ufs_config_intr(ufs, DFES_DEF_L4_ERRS, UNIPRO_L4);
 	exynos_ufs_set_unipro_pclk_div(ufs);
 
+	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
+
 	/* unipro */
 	exynos_ufs_config_unipro(ufs);
 
+	if (ufs->drv_data->pre_link)
+		ufs->drv_data->pre_link(ufs);
+
 	/* m-phy */
 	exynos_ufs_phy_init(ufs);
 	if (!(ufs->opts & EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR)) {
@@ -1059,11 +1064,6 @@ static int exynos_ufs_pre_link(struct ufs_hba *hba)
 		exynos_ufs_config_phy_cap_attr(ufs);
 	}
 
-	exynos_ufs_setup_clocks(hba, true, PRE_CHANGE);
-
-	if (ufs->drv_data->pre_link)
-		ufs->drv_data->pre_link(ufs);
-
 	return 0;
 }
 

-- 
2.49.0.rc1.451.g8f38331e32-goog


