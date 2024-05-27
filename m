Return-Path: <linux-kernel+bounces-190629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755418D00A7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63991F2468B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6815EFD5;
	Mon, 27 May 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="us2JMFZf"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAE15F3EF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814612; cv=none; b=gxHRdojeN5Mg3TDhQ1CzH4uXZTWJ4Xi2DaUvoOasGmPQhMX5khv3pw56XbQstKpNwe53gQSV0Ep9aAu8sxWhu6HdyFBowLtT4HIqu07eucUhPXqe+FNYGNOnStg4zeo4dRrqEXcJfMU5JfjUOACBIxMt5dZIAMeF1mxSkJ1ge4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814612; c=relaxed/simple;
	bh=H7pseenH3L02JxfV7omW/31iV86Lwn0PZV9E6T5f71c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seVKHpJCxgLNTEUkqrqanRC7i3M+66vXM0i5Z4ar6NUd/9dcf7Fx+bEGosfiGyo/i7/pqFzLHoug2lX8ViJECSeQ0NLTVpNcqmB5yM9fjZ/vqD8cJrSyOBQdKjE/vGghgBdyyVHJ8z39Mi4FEZNSvBNEuK0La/+4ZCPiqV1gwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=us2JMFZf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso48381155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716814609; x=1717419409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2tGSXM64q5CkEofoukaYDnOH1U7xvQ9rdr6WJfwwYM=;
        b=us2JMFZfcCsrXbXu+DgepLB03hPwvWVNaes8P+gZZvWmtnI2hALbF80CgWNS+SZX++
         Wgj/+fHXbpdhKaiYRUJSAyjlfE8FosBGfqirA775Pdmkoq13AvtUQ+RQTxoi+0PsxHlv
         gu/3zMa9h/UGxDkxxst1e2/m8JRZbE0epJzDQpjJ84B5k1vx5OCjK+TMjfafxSqImOWU
         lVoeYJtVk+LWjBRqLhB2GCpVmNuRVK88jiePIXChPIYMDvD7sqL4fte6MvDHgQduq7EK
         x1niuLBz6N7tXXRl9jU4ADIcWJpleWqhC1lNZ4QBFA8M/4rNRi9OJog7kX4Q9zmv2fDj
         xNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814609; x=1717419409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2tGSXM64q5CkEofoukaYDnOH1U7xvQ9rdr6WJfwwYM=;
        b=sXz+bq9sohUuK/7Xv5pQINPB5ruivWqpHsam8OAdaV3qx3BDYRrXolAhqtBtWYCJL8
         HpFG0St7QcITsgkox5DvcIGSDuaobAx4bTcMSUgUPMwfXTChEk+vkDhB3nLVl7CSKCom
         Y9hA+TtSvGOoppBH5JB2WYEg0LBtzGAfn0zGEWsVQYPqxcmLBg2+Ge2MFGP4Ch7Y9cYl
         s80hufycY7Xb2BupZqtqLFbSslenBu+oPImHMMa6O0nnmBNaQ9R4mKNJBnvNo0a5XiWe
         vRckdKITZce1zueoM6V7t0UfhFowBCfqMeGAccoLZYy6Yro7Q5aHnxfdnyB4SKHxJr05
         nCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7cq4CQt1RpmmLzvJmXYG0w/nHh2iUHzuQcrE0cb/0I1wPdaUE6OUUhP+y2pYeVkTNrgEybjihiNZEW4ehlxbUxl32TkdjPmAAH8lO
X-Gm-Message-State: AOJu0Yyo1DKlDkyhyW+O6N+D9I3DGjP/ITR0KwaPpDW3DhwvvvnzcILu
	d2dmVIZa3VqD34bs7XBt7hm4CgeGuGVdDM7XQd6nLFRBU45FLWqgTspdTBNvs7Q=
X-Google-Smtp-Source: AGHT+IFiFkZN2ztJz4aq4ARQTndSRHhYuJJSLUpwf/uPp1OX4TcFw1jCbi8J6K1zQHHsp2lLkGM7tw==
X-Received: by 2002:a05:600c:6b0e:b0:41b:285:8417 with SMTP id 5b1f17b1804b1-42108a2e796mr66785555e9.40.1716814609554;
        Mon, 27 May 2024 05:56:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f64f98sm138753635e9.24.2024.05.27.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:56:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 May 2024 14:54:55 +0200
Subject: [PATCH v10 05/15] firmware: qcom: scm: make qcom_scm_assign_mem()
 use the TZ allocator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-shm-bridge-v10-5-ce7afaa58d3a@linaro.org>
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
In-Reply-To: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>, 
 Deepti Jaggi <quic_djaggi@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9Erqvqgiad5rjTJsNR0YSbu/CRguRxvgVp+lpYCpIVk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmVIMIKOO9v8eTMGirexp87ho1NlUlhkeO/Hz9j
 WAf+2zXRZeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlSDCAAKCRARpy6gFHHX
 crGMD/0YS7UnmIE3KqMGN3f/lgIUFTePpK9qvRMHBPLj2Dpag/edaQyVnec1ocNJlO8pz/bNR03
 UdWI8Po0hrZN8wLxgwxiAytFfl+Sa/aJ99bbZjwnd7nk9o8icNvkBmE6wtg3OFHSx4rJspet0cf
 tD7cJ93DyEg8nVqzSw4anW94zC0NczKotQmHBvEmXzuITPwUmAsIVjey3it0QaXigk3k1LN4yLj
 pQmOTt0CINtQexASpTZAFvC++O0u708QBAU12SjPXB+9vNWpd/9OHS/P1Sp3ISzJqQP37QH+Ozz
 opcFF0t5siyZ5FgdRvui5YOcoIMdAmy1i4XhIqlAo5+UlhqsOqrAvV218vnNdsJFooB8Mm162Ga
 lqRB/8qrODadaf4jJY/5k2/mkL7jcCOZw9eFJQfnDNN8VMZdry4pcX/nnYDGMwgPV2I/1/xxCm3
 qbbCV1RsuS56M2JZtdWxrbPwwvxPlAdCaRm9nmC7rPuKHPg38FoEglA7uz8iLYLSSSvw7CdUVP0
 L0KLtJGnM6v8AFX0lR0wQ6ka+np8QNJYiU2/rLCL7QWAEXNgTDe2MIICEUkrR/RH05lP3cGml7a
 x6R0LfAwyWSeue/g49j07ahDu21bvrhvd/+tgJ63nVLSILaYCqg0v2LVevZbxkLcYmL99Ifhy3L
 6DqEfDKi8bRUI8Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 1d207c14afc8..ea4d71bb0ad3 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -6,6 +6,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -1019,14 +1020,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	struct qcom_scm_mem_map_info *mem_to_map;
 	phys_addr_t mem_to_map_phys;
 	phys_addr_t dest_phys;
-	dma_addr_t ptr_phys;
+	phys_addr_t ptr_phys;
 	size_t mem_to_map_sz;
 	size_t dest_sz;
 	size_t src_sz;
 	size_t ptr_sz;
 	int next_vm;
 	__le32 *src;
-	void *ptr;
 	int ret, i, b;
 	u64 srcvm_bits = *srcvm;
 
@@ -1036,10 +1036,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
 			ALIGN(dest_sz, SZ_64);
 
-	ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
+	void *ptr __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							ptr_sz, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
+	ptr_phys = qcom_tzmem_to_phys(ptr);
+
 	/* Fill source vmid detail */
 	src = ptr;
 	i = 0;
@@ -1068,7 +1071,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 
 	ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
 				    ptr_phys, src_sz, dest_phys, dest_sz);
-	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);

-- 
2.43.0


