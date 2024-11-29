Return-Path: <linux-kernel+bounces-424528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB09DB562
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BFAB248A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500119CC2A;
	Thu, 28 Nov 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9dpuNXI"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10600192B83
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788489; cv=none; b=b7ICkLd4VhdLhvc2+a5ON1kNBjc6nKNd8V8qF08ei4sZN//K3XO2QICVeNMY1y/vlofEJj0D1rDIA04CvADHBOJJc+30kQF5DnJwUxCBHSUdsfAZbmtKkt6Gv9g6xkn92cWR/EY5nQIoD8H0BBnmjE68y1uAfp8RecIGaYUV2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788489; c=relaxed/simple;
	bh=Vi+M8i6i5+W3zG2jlza6I1atoCqDhfqIiLe4yucArAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fKKfG8lTLLPfHwbQiaXO7E6IswaBTjfUOFzgwVsSf2LikCjIUfLRduOHqi85PvGUuI5x/O3KyU5c+d7YjtlzVAzJFCIvXjqoSqSJpYaxJQwJwZ1uQR8hddz4unmbUT75aE85tiAWn/r2F5Y/G2VqoGMRO2XLoqD6QWnZAwNVujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9dpuNXI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3824a089b2cso415665f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788485; x=1733393285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD917YCzIiLfihkWvHBTYyujsbKtA1fudHcVy/JAG5Q=;
        b=T9dpuNXIJcXuLUaMI0m34oXRxKuJgkDv5EFOyLRwbma5Hgc/fsoPFmqgKYAtgn/uB6
         lbQhFOP4G+Lb/AoXE8RIS986vP236/ecWG8Yb+VLtdovNox3MSrWniMssuGYRa7BkvVG
         tA/pFwksLdlkEr5ZKO+9cyrqP6i0Poo5++lxOz1F1Mmv3qBVJFg8Lt476LopPSBl7QLN
         l5XAjWmEhsEdhR92tNy9CfMLVW1DIS/uKMynIDZK/KRiixBlhRFD/bu0kXDHx6zKdhku
         EwUlmq+jqupILwlOnYaajXPA7kWU0yJFsXK84nLP6mNPtXgjMktGcYsclCuAK92dD+3w
         oMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788485; x=1733393285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD917YCzIiLfihkWvHBTYyujsbKtA1fudHcVy/JAG5Q=;
        b=hcON0B09lGaULfFns5ndiOyeW1v9Puov/ujBdah0PW/mT+I3mnnQ3xY3iPHO0ROWYk
         KDz+XQq9EpSXYNOjrTKa1uIgPJ8nDih+azp5R/8xzIo7OvMpGEQKNkF7TaM2l6SN42iP
         ENG+aZhFZIoXOjS0bYTxStJI9g/iOcek6jGvcBODCyIUkwJgk6QR0DLpiEPQqm3WiQ3+
         rhEjxUPX1hYJH6CFqVaqV/TEzpMB/VMKVpr5TECZ9N9CJdjVse8GftNkj1d6BIX7FMoA
         V/sgHOybM4Wj+m7TPqZHe0KVoMaOC9VrEsgdkiNMnBHVTklo6DrlWUaLx3Ot4w4Jz+hd
         NXJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRiuENrohjb1RIdPxNuQSNX/iMkH/D88omyinKUT24LSSWAv73c/4QEFK9+Sv1tP/nMA4/vPLihtTAAb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00breUwedCaXiVNORsHMbxRBCOwr5wt6lP/37/nalZRINEbAl
	l0DmD8pX9hhI9W6jbkaJE/jgnHBDAE/CHpGLq+mypa+9uJ52k/PTib23SXz6p+XiTNdlZnv9cET
	HkzY=
X-Gm-Gg: ASbGncv7YAML8kuBqitRvuABxHaqMm5bhAx4PcycxgqG3ZWB1UleTP9k1f4v5MwTuzy
	w8wKquKPX5RVeqzw365fEl513cgzzPdt4xUa9karCDEQnbBSwGNE3x3yeX5eKZmAeK2gg4jCtak
	zFdZOiskwA8DKvsKxxB4f/65+7eLFw9YDUszsq1fbDkbgvVGpOFrZ/7ycq/1BlyjHvEn+cgsDWV
	TVCLT41C06yvH89wMR0gkNU4vTCUPvXjwFcPssBf4tNUmQ4JejHNv/U6nZi/7QSRxUpAiU=
X-Google-Smtp-Source: AGHT+IEXOXzJHITxekdRGfEXqu6+qb+1sk7axWQ6BXVl4VlUNMnkOKZ/CDCXXE4DY7X1z48m+ZO82g==
X-Received: by 2002:a05:6000:18ac:b0:382:4a27:1319 with SMTP id ffacd0b85a97d-385c6eb5840mr5377236f8f.6.1732788485391;
        Thu, 28 Nov 2024 02:08:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a56fsm1230335f8f.62.2024.11.28.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 02:08:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 11:07:54 +0100
Subject: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
In-Reply-To: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6947;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Vi+M8i6i5+W3zG2jlza6I1atoCqDhfqIiLe4yucArAc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSEED2RB8fR1rNewLOzGnHJ5VK7ksrrzcUH1yS26z
 Q/DuHJiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0hBAwAKCRB33NvayMhJ0WuQD/
 9NE2Z6F27I9U27rUDfn1M52ypM5fB9jgJLU+peHuPNt4NKNTMNh4SPq9ehoS3O3/AHute0Ej/pm2Rn
 qUz54nZKe1rV4eNJDRxp8C/4AfkpGsLVmnPYCwHVGCM8VVY/eHwFsiPgSOKX9TCYZFD+SCjjgSdLhu
 UYFCtH3nDbmi9NpXuLk/tnum5h+DUBrQQcRV+ImHH9dS+oaoF2jdJPZXtpWwEXf55tAi37ioGlrhJq
 cMNc3X4w8/CtSEagoq/wYLa+vmLa/5nlh53iiGwymBERjl3o01HaKr26NiDwvvHcZf3SZZVJpr/1Fy
 NkGaaoHJvXg9fwyfGWFQMbqZjbmPnNCfYIx+hv5IzzquoqXW1diibGCuE2t4oo6OyABnM+OoaMP6S2
 V1aVSyp93uHxERZpOtXvtlDvV2zym/GdY2+cZk2gNAleYOf970uW3dGJXqVsmE+PqoiYv0jRxwILRi
 IS+lipVSXo+b//t6LxWjDmoo16RGYDIZoQTuQIJhF/AECpAqqcjk9zAMFrPFKczju1GVnaUoksL4al
 vwqaebQWfV4S88cRVTX8SuN7tBuDeo6QfCu55RsaYXr1zw0Px6qv1O1JrDPwCSUrIsxBvTTm94/TGt
 ixPBYc+B7lnVQxJmf6A6Mlb7XRLfPc09wUiO9nxkThuEQDuEWXC2Gn30FPuA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Pass the freq index to the assert function to make sure
we do not read a freq out of the opp->rates[] table.

Without that the index value is never checked when called from
dev_pm_opp_find_freq_exact_indexed() or
dev_pm_opp_find_freq_ceil/floor_indexed().

Add a specialized version of assert_single_clk() to check for
the index to be used with the generic find functions.

Fixes: 142e17c1c2b4 ("OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs")
Fixes: a5893928bb17 ("OPP: Add dev_pm_opp_find_freq_exact_indexed()")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d4a0030a0228d6282d672e3ffe3aeea27e80822a..8692e8ce05b7c31a725ea3a7928f238c7a1d6f51 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -106,6 +106,14 @@ static bool assert_single_clk(struct opp_table *opp_table)
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/*
+ * Returns true if clock table is large enough to contain the clock index.
+ */
+static bool assert_clk_index(struct opp_table *opp_table, int index)
+{
+	return opp_table->clk_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -524,12 +532,12 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
 		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 				unsigned long opp_key, unsigned long key),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table))
+	if (assert && !assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&opp_table->lock);
@@ -557,7 +565,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key),
-	  bool (*assert)(struct opp_table *opp_table))
+	  bool (*assert)(struct opp_table *opp_table, int index))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -580,7 +588,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
@@ -593,7 +601,7 @@ static struct dev_pm_opp *_find_key_exact(struct device *dev,
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
 				   _compare_ceil, assert);
@@ -602,7 +610,7 @@ static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_ceil,
 			 assert);
@@ -611,7 +619,7 @@ static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
-		bool (*assert)(struct opp_table *opp_table))
+		bool (*assert)(struct opp_table *opp_table, int index))
 {
 	return _find_key(dev, key, index, available, read, _compare_floor,
 			 assert);
@@ -644,7 +652,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		unsigned long freq, bool available)
 {
 	return _find_key_exact(dev, freq, 0, available, _read_freq,
-			       assert_single_clk);
+			       assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
@@ -672,7 +680,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)
 {
-	return _find_key_exact(dev, freq, index, available, _read_freq, NULL);
+	return _find_key_exact(dev, freq, index, available, _read_freq,
+			       assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact_indexed);
 
@@ -680,7 +689,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
 	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq,
-					assert_single_clk);
+					assert_clk_index);
 }
 
 /**
@@ -704,7 +713,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	return _find_key_ceil(dev, freq, 0, true, _read_freq, assert_single_clk);
+	return _find_key_ceil(dev, freq, 0, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -732,7 +741,8 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_ceil_indexed(struct device *dev, unsigned long *freq,
 				  u32 index)
 {
-	return _find_key_ceil(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_ceil(dev, freq, index, true, _read_freq,
+			      assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
 
@@ -757,7 +767,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil_indexed);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	return _find_key_floor(dev, freq, 0, true, _read_freq, assert_single_clk);
+	return _find_key_floor(dev, freq, 0, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
@@ -785,7 +795,7 @@ struct dev_pm_opp *
 dev_pm_opp_find_freq_floor_indexed(struct device *dev, unsigned long *freq,
 				   u32 index)
 {
-	return _find_key_floor(dev, freq, index, true, _read_freq, NULL);
+	return _find_key_floor(dev, freq, index, true, _read_freq, assert_clk_index);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor_indexed);
 

-- 
2.34.1


