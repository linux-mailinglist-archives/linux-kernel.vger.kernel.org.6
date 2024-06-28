Return-Path: <linux-kernel+bounces-233810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 920EC91BDB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22B11C22C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21C158219;
	Fri, 28 Jun 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uu58518w"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F215356B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575180; cv=none; b=JheAZSDTNU+EVeRTLHOjmsNiwWMtWuOCUVaNdupZTLzhJXQm+F4TdG2BMVfLwIB4f2Nndp8Q681RGAHSgRXUF76ETiSCsm2ZORiGnv1QrKadqGlo9CX5grmBreL5eYPUjptIbih0USbAOwKtAFW81vK8IlwEAuxOsJzzqoICaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575180; c=relaxed/simple;
	bh=hHHgBVyTFPrXFKNO1WIxKzgSQAzSoyDktUjq0O4p8xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nWXDGjmJhj6glN7ns+q6BCnB/UksN5xlpoivDcr0MWKNyQbSAa3Juq7QqHSNvO9P1KnKhf+j88gHAqGmBjznCMiYO6ljEHhIAQbU8Q5NjPZNzv1arWVH6Arg2oGUFjUzbBwJx3/WaySUlyUYGpM/+vWVYq4UsjTTK/UMap9F/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uu58518w; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso3997285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575177; x=1720179977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdkWxGqkeTxNpF5y9bzC5FsO8WLu7OXUf3lFpoSXqjo=;
        b=uu58518w4JshcRtgSKN790ekM3d2mSLNW3VWRXJUlNXhQov37GrU3zC/GysOhhvjCD
         FrhU2nWTioRtCz6M9Q8kJgnLPtCM1tZ9JJe0jcAIO+1f6EAzBF39kzTa9qgvX32eF+IO
         e0FGUPvPIyQYeauR7CfMGq51DuFQ/gzx8OXbJGJuP4npnbOdmV4FQv/XAk14cryqw5HI
         S0SnkvtGbMv8vfRS+3n3YiNIH+GYJqjc+dL2QT96sFE2QhMyEq07rz3ynYNzf5vcAbsi
         eFrMpEgEEmBaVRt1+ub73mGqsgJIod76Hn5/3jTvlXzDeNH8PrpLkzWtsAM3vJ191aHv
         y92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575177; x=1720179977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdkWxGqkeTxNpF5y9bzC5FsO8WLu7OXUf3lFpoSXqjo=;
        b=skYZSa2AtMgOIQmu+NfJofxIgtBaD+gfdWYFzoEDBv6K6kgAuz5cHAvIYzFDpIhhuU
         pz2JnqrH7+DnQmW278J6nc6r1VIaGCd7VkSn+m+cp/8cwqduZSBXqDlZQuzsa6Ku9Wkm
         wYKdOFAqyflk4sh5oDTJK2Jz4MXH86YQWBK/C6NWEpsjL/VBEYH7o/FIsGH/O4htiGP4
         +yHvSo44cHSpcCg1ZppvxqTk170t+NgsVqQzdCX16ez+NTNollYQ/zguULhvBhPkRogH
         19DpD/r2VfBiQd5xAcoLrxM9m/QTlczX4cs3q0+Vdj3w4MRfGY0CxHx1AmPjLr/Snhdj
         IfmA==
X-Gm-Message-State: AOJu0Yw0cC1PDQ6pAq2p0yHacSRqWIRr1/6nBwiIEiQOCovhI2LlwMBh
	bdDmId23lrSL7hhC+M96zueFnOULxJJscpX8FChF/ec3nkkN4YTzNaTU960pi+I=
X-Google-Smtp-Source: AGHT+IEDsDd8hZ4X2baaApk+xrmIwModpVB4wFarHOh7tb6zecGXmlvkgQ7IlFTc7P6CAM5VwPd6jQ==
X-Received: by 2002:a05:600c:5118:b0:424:a56d:83a with SMTP id 5b1f17b1804b1-424a56d08fbmr78294215e9.0.1719575177163;
        Fri, 28 Jun 2024 04:46:17 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:16 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] misc: fastrpc: Fix DSP capabilities request
Date: Fri, 28 Jun 2024 12:44:56 +0100
Message-Id: <20240628114501.14310-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=KeCAEHnS23lE51AdVj5TAaXEZY6ywQEeJjqF6bxCBIM=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9qop85OUzqD5DCIyF33nzKsv1GcvPzD5jN htkzM3nGymJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV NxhVCAC1/WL3R4l6cOJ/88a/kVE+yO3PXzBR6tTp5xvamPMljUrVMLpEkM5VgQjWphJaEf/bm/a BJvITKq2yyDZARMl0p9/4DpfonCO98tmglMVcBeeGCQ5HzKxzltbw3XIa4u/jnDiKf8kqFfZpSq yj+8dage+pJEKYL85G6BTCPynds1g+7yEx5WDLyO1b3JLCKTGaqTPTWhV4uSVE2xMxZeNg4hWAV qVxyquRIDD+YG+bOiyuhLQb/rMjicW+hEhra9bIVHWmXBKBkmgpqh8eYmFL3J7YUGj6MZmEuyeN sNBmUnBrWEbO7GDx09xqfSd0cOPiJ7EeeM+hWv4R4037JVkU
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

The DSP capability request call expects 2 arguments. First is the
information about the total number of attributes to be copied from
DSP and second is the information about the buffer where the DSP
needs to copy the information. The current design is passing the
information about the size to be copied from DSP which would be
considered as a bad argument to the call by DSP causing a failure
suggesting the same. The second argument carries the information
about the buffer where the DSP needs to copy the capability
information and the size to be copied. As the first entry of
capability attribute is getting skipped, same should also be
considered while sending the information to DSP. Add changes to
pass proper arguments to DSP.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..82ce4f58d70f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1693,14 +1693,19 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 {
 	struct fastrpc_invoke_args args[2] = { 0 };
 
-	/* Capability filled in userspace */
+	/*
+	 * Capability filled in userspace. This carries the information
+	 * about the remoteproc support which is fetched from the remoteproc
+	 * sysfs node by userspace.
+	 */
 	dsp_attr_buf[0] = 0;
+	dsp_attr_buf_len -= 1;
 
 	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
 	args[0].length = sizeof(dsp_attr_buf_len);
 	args[0].fd = -1;
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
-	args[1].length = dsp_attr_buf_len;
+	args[1].length = dsp_attr_buf_len * sizeof(u32);
 	args[1].fd = -1;
 	fl->pd = USER_PD;
 
@@ -1730,7 +1735,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	if (!dsp_attributes)
 		return -ENOMEM;
 
-	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
+	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
 	if (err == DSP_UNSUPPORTED_API) {
 		dev_info(&cctx->rpdev->dev,
 			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
-- 
2.25.1


