Return-Path: <linux-kernel+bounces-540118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BBCA4ADE7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C3D3ADDD4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350171E98FF;
	Sat,  1 Mar 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWNQjeLG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C281E7C11
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740861593; cv=none; b=i6ddGfpxQB+W7FmPlmV1bJKtMjkoPb94p1Ee5hMqyL/T8UMKJrL24AcJoXQ71QcIwf6c7UHdj4JP27puQFP6gYWhSstxaEY+uudQO3KeE2gbs/qxttQxOTD+8o/H2DPATB557o22qf2aWFRxoCHJHMJq1f/26CmQqQXVw7CghGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740861593; c=relaxed/simple;
	bh=NgOVGdCmTC+8UjqfiO/VMFR2mESsUZ4pRU644XqkABc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZoSC/K7XoKqVYFfNelwl/kC/gZM0+CtZ4FAY6SQBMzqlpHQsFV5V/xO1F+W2ENhMQ51HfJ8HatsO29/1ypFokj4WEgHRtoePrxCbxjaKlpJVHQ2/YpZpf5I8wpw8B81d8vovYNtbRKPJjGRAvc/Vb5mGb3ZZKhAMZEPVI83Esw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BWNQjeLG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a59so36770181fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 12:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740861589; x=1741466389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcEPpUecbQnXiS5K2IATdiHhzAIF4FnvVg3Y9Uy8iSM=;
        b=BWNQjeLGHWe7hS6a59HRs2Gz8jWeG5dMl9np3DJTSCs6yDmeNPxfGdMQVOvdNIjwuU
         JNz94qZWzEbDMDWVMDwECa62B0kfODjIFzN0QYpjOgIc6orsdvN3xCtv3ndQB5LVrgGX
         CvVokB2G0VaoDtHrm+nK5sUMIf8llO9j/mYzL3gkE/B9H2P5bvuE0zYMlSSSE6yMywQw
         QA8q1W4r+2mX+J2HBDrnihul7g/IAXxmPUPG9Vxh/YfQsgEZJ0j5ItmAZdXh3f9onF/w
         4Qp9+8X9zvFHccmBGSdofyM9/L1aBz5mBWUQK0vtyGyASMK95bPZzjcie9I+dG5Rq937
         BOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740861589; x=1741466389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcEPpUecbQnXiS5K2IATdiHhzAIF4FnvVg3Y9Uy8iSM=;
        b=BHZgpl38kRWl53reTHRGjBsGCgaDM1XVXLQvgNSUSX3Sl6JB3jTb1/2sDencY9BPvf
         uNFGluafvyMYGgWy59qzjQTX9zYkDcybcLJq8ylob/68/LLZRGPN57N9Tg0+kjRgHg+l
         3iKIaijqxob2xwg8zAGEYEyTrUAvhCOyu+Jrozq7Lo/FAfVALMKifUSo7CPtlwKL8PIQ
         UMLOlh5Whk0DzzDzHAZZxMDRyC2X/i9lroLqcabG/TzxcgHiVvq5ZoCHuWE4PZ4G6gJA
         uulxciD6c/hU6cp2HiNl2g/Qs7q9RImU3vFr/BdmqTK4D35Ya6bZxX13wZ1pVAeFV3Br
         3uaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHEc0yr4v3EHm6FK4sr95uUGDU1Z6ZaJ/raXp5PXqqWEFINn2k/n0Hd3LJHXPWekD2PtSIvIwfry0mnrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXNSKW+6nD4O1FzunAA4LupUkk6BXJnDU6TqBdhjRf+Qq11R3
	7pQIpScxR3w9ycoUwMeu2C4egy+0qHCaAj4VBWqNLXzk113pZNlM5PZydfp65RI=
X-Gm-Gg: ASbGncv8IRPnhptZH6jt5VV9X+yxMP4Le0rRjDGEioi065OcZ2mPsnxlz32iRE6rJ2H
	CaqmyH7Hw3XVeaqlWkUZlbF7ga7MrDwAWnE/gcwjg73m8jYcz5/W/Ml8Zb3DDC30X9CFnhciTkP
	JPMrI7IFtMGYNa9byxL15W9X9WliqyYPicH34zA8iAlOFq4qmrRmGsEQmD6wNQFFPXi4+pshwvb
	vRi9O1z97n20EUreMQj/3UFoBIYFDwlDHk7c66u4pubTkOkz8hLJnKLhg0DEMEJBPvqYjGvRJjl
	IfqD3TjBOfrGSXsTQnx4zhq/ZJ8AUW4blEgGiY7WgC3pAA1UsESr
X-Google-Smtp-Source: AGHT+IFbIBFxy1B6SY0xD2HgvbsOY0hx7R3yAueDBbzal97DNmUgO5PzUJvmVDdNOItvYmjbpnMuQw==
X-Received: by 2002:a05:651c:503:b0:30b:b28d:f0a7 with SMTP id 38308e7fff4ca-30bb28df324mr1085351fa.18.1740861589428;
        Sat, 01 Mar 2025 12:39:49 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b931524efsm6668921fa.60.2025.03.01.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 12:39:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 22:39:36 +0200
Subject: [PATCH RFC v2 1/7] drm/display: dp: implement new access helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-drm-rework-dpcd-access-v2-1-4d92602fc7cd@linaro.org>
References: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
In-Reply-To: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
To: Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6615;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=NgOVGdCmTC+8UjqfiO/VMFR2mESsUZ4pRU644XqkABc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnw3CPwOBSZDyus3kp03MXdqlegNWQAa4zwNzmJ
 0cZIAcuGLOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8NwjwAKCRCLPIo+Aiko
 1aRvB/99tG7xDSt1Yr4yCrGCTSBYNU9Ye0p7gfAblguluBCoNXaduaIX+1zoQzVkeZ+GVrzK/Xc
 4pdDdnxddbCt3Vm6yoKmAVR0v5tgM5iCnS9Tgt8b22zgZCPf3GFQyDpHWSPNpaOAcCxPYntqFUq
 AfWvGTmt7fszWiM1wFvlZJ6cZtMJuLhaCth1m64pfwIOJQzTfSphoJyIKTq4Zvgdc8g5ZKkXeEQ
 tfRrv3yAPq0duIxh/WY3hAcuFRkupFNc5D4HaDIr9I7Fp4FBhV2FeaCrTPmDkpa5M2vu6s0d27E
 1EkuVR1kj5ocWPst+uTg+zoz7U6QawXu8BwJMs/N1+znS1Xq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Existing DPCD access functions return an error code or the number of
bytes being read / write in case of partial access. However a lot of
drivers either (incorrectly) ignore partial access or mishandle error
codes. In other cases this results in a boilerplate code which compares
returned value with the size.

Implement new set of DPCD access helpers, which ignore partial access,
always return 0 or an error code.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c |  4 ++
 include/drm/display/drm_dp_helper.h     | 92 ++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index dbce1c3f49691fc687fee2404b723c73d533f23d..e43a8f4a252dae22eeaae1f4ca94da064303033d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -704,6 +704,8 @@ EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
  * function returns -EPROTO. Errors from the underlying AUX channel transfer
  * function, with the exception of -EBUSY (which causes the transaction to
  * be retried), are propagated to the caller.
+ *
+ * In most of the cases you want to use drm_dp_dpcd_read_data() instead.
  */
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size)
@@ -752,6 +754,8 @@ EXPORT_SYMBOL(drm_dp_dpcd_read);
  * function returns -EPROTO. Errors from the underlying AUX channel transfer
  * function, with the exception of -EBUSY (which causes the transaction to
  * be retried), are propagated to the caller.
+ *
+ * In most of the cases you want to use drm_dp_dpcd_write_data() instead.
  */
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size)
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5ae4241959f24e2c1fb581d7c7d770485d603099..c5be44d72c9a04474f6c795e03bf02bf08f5eaef 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -527,6 +527,64 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size);
 
+/**
+ * drm_dp_dpcd_read_data() - read a series of bytes from the DPCD
+ * @aux: DisplayPort AUX channel (SST or MST)
+ * @offset: address of the (first) register to read
+ * @buffer: buffer to store the register values
+ * @size: number of bytes in @buffer
+ *
+ * Returns zero (0) on success, or a negative error
+ * code on failure. -EIO is returned if the request was NAKed by the sink or
+ * if the retry count was exceeded. If not all bytes were transferred, this
+ * function returns -EPROTO. Errors from the underlying AUX channel transfer
+ * function, with the exception of -EBUSY (which causes the transaction to
+ * be retried), are propagated to the caller.
+ */
+static inline int drm_dp_dpcd_read_data(struct drm_dp_aux *aux,
+					unsigned int offset,
+					void *buffer, size_t size)
+{
+	int ret;
+
+	ret = drm_dp_dpcd_read(aux, offset, buffer, size);
+	if (ret < 0)
+		return ret;
+	if (ret < size)
+		return -EPROTO;
+
+	return 0;
+}
+
+/**
+ * drm_dp_dpcd_write_data() - write a series of bytes to the DPCD
+ * @aux: DisplayPort AUX channel (SST or MST)
+ * @offset: address of the (first) register to write
+ * @buffer: buffer containing the values to write
+ * @size: number of bytes in @buffer
+ *
+ * Returns zero (0) on success, or a negative error
+ * code on failure. -EIO is returned if the request was NAKed by the sink or
+ * if the retry count was exceeded. If not all bytes were transferred, this
+ * function returns -EPROTO. Errors from the underlying AUX channel transfer
+ * function, with the exception of -EBUSY (which causes the transaction to
+ * be retried), are propagated to the caller.
+ */
+static inline int drm_dp_dpcd_write_data(struct drm_dp_aux *aux,
+					 unsigned int offset,
+					 void *buffer, size_t size)
+{
+	int ret;
+
+	ret = drm_dp_dpcd_write(aux, offset, buffer, size);
+	if (ret < 0)
+		return ret;
+	if (ret < size)
+		return -EPROTO;
+
+	return 0;
+}
+
 /**
  * drm_dp_dpcd_readb() - read a single byte from the DPCD
  * @aux: DisplayPort AUX channel
@@ -534,7 +592,8 @@ ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
  * @valuep: location where the value of the register will be stored
  *
  * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure.
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_read_byte() instead
  */
 static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
 					unsigned int offset, u8 *valuep)
@@ -549,7 +608,8 @@ static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
  * @value: value to write to the register
  *
  * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure.
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_write_byte() instead
  */
 static inline ssize_t drm_dp_dpcd_writeb(struct drm_dp_aux *aux,
 					 unsigned int offset, u8 value)
@@ -557,6 +617,34 @@ static inline ssize_t drm_dp_dpcd_writeb(struct drm_dp_aux *aux,
 	return drm_dp_dpcd_write(aux, offset, &value, 1);
 }
 
+/**
+ * drm_dp_dpcd_read_byte() - read a single byte from the DPCD
+ * @aux: DisplayPort AUX channel
+ * @offset: address of the register to read
+ * @valuep: location where the value of the register will be stored
+ *
+ * Returns zero (0) on success, or a negative error code on failure.
+ */
+static inline int drm_dp_dpcd_read_byte(struct drm_dp_aux *aux,
+					unsigned int offset, u8 *valuep)
+{
+	return drm_dp_dpcd_read_data(aux, offset, valuep, 1);
+}
+
+/**
+ * drm_dp_dpcd_write_byte() - write a single byte to the DPCD
+ * @aux: DisplayPort AUX channel
+ * @offset: address of the register to write
+ * @value: value to write to the register
+ *
+ * Returns zero (0) on success, or a negative error code on failure.
+ */
+static inline int drm_dp_dpcd_write_byte(struct drm_dp_aux *aux,
+					 unsigned int offset, u8 value)
+{
+	return drm_dp_dpcd_write_data(aux, offset, &value, 1);
+}
+
 int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 			  u8 dpcd[DP_RECEIVER_CAP_SIZE]);
 

-- 
2.39.5


