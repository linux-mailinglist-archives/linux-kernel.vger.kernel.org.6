Return-Path: <linux-kernel+bounces-573583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E7A6D976
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F116E6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378C25E473;
	Mon, 24 Mar 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1UhLS/x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393E25E469
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817090; cv=none; b=ArOUoONvLja9WS5x02jEDEcCX1OdWzAfZ84oP787B/JzH/sFz61ZQ5xJSiwR1rnhFyUDbFIgrE+66TrWVk27evIGkcQoGqFMFh+tgBeCg2zS58Nsy/JDJtoq1QDGfPBuNo+TfQoR9M6bt+GBRiynxaJibNILnb7ppQC3Hf0de0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817090; c=relaxed/simple;
	bh=Dy7B9nXl0EbAUVXNcpgz5sajCgBRVXHbTi7mIRjd1+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqSj20rgP8HpuD95NHjyLLBLBDIZPEcddD3e7YYbH/0MjKwkhI9GiGgnyiBEWkiSULw8ozwLSR/xNsavpRV6T5XbnLIzYE0thZpA579UoRKVi3It8wCw9342RrvpqfEOjn6Nx+arbyVqwmA+8X80OTKnU/kWs9dQZerolSazL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1UhLS/x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PMn1004178
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ugx4av2Bblczqdq51yvv9QisQbSYAgbAPKVnJleCLeo=; b=K1UhLS/xNiOL7V2P
	PFkHXjk1UizCYXAx4s69AHyIz31h3+yfXvSR7KH575j88qPTfOuGFmw0hOtWQF8J
	1WGGDzv+HE41neBfpM14sRqm9H3CU5SRb1PhK6v+tNdw6oOP6/H4N+BlLDHGy0Vq
	loSvmhj4U4HAcA5HtblJ2d8kFH6O2cAtMpGv4xC7H7QV30yFfWFUToiRfz4UuZ9C
	2Eu5rmRsNP4CP36UAthN+UzBRoHGOt2mCLrzodQU2GDUIi0m79/zwnyRT3Cb24mR
	CJmSYpXckGyqlDB1cdPyKaoJm88e+LrBzFogiu8MmjNbkvvUuLwTTJsRT+UhsDWD
	oN8zAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8m82a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5bb68b386so941828985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817086; x=1743421886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugx4av2Bblczqdq51yvv9QisQbSYAgbAPKVnJleCLeo=;
        b=Nuh2jhHSebtOkOhBInLo6i4L8vUtE73NjqC9bYOkussaas5B0B7AI79Sfci3C8U9b6
         Nr4+KGrh8jsBxtwmqU9YrelSfqlpIOqkUJ3otwOTyYG5eCtZ5kfEBVrC8Mj43xXtxEML
         SL4U0PX6LWW6rw6L7d2jOelHuPfCRbDu2NbfwXYQl9t05U4JhzI7YXegAId70dZhdZZe
         ZnG9zx235eU+7MnatL1kR5Kp2TPauXx0bgfnOjJ0dlJkKIfr/JHy82qSn2Kdw7r7PoIq
         BU6Mrk59Lz1uXzFdJZK4qnJt4RsLSRkn0IOWJ92xq5y2LwqUKrZD5Fj5XU+CajaWI7B/
         uGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu1kSa3TQvp0wDld6EO2cv0SktsfKx66046mtj3FRpVkoerl/f4Ohi/XpwAdiO9/Q7OBE02c3RiU+40L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKm2O5wlnA91nV1kPpPatj24+GMK8i7+LexEojs21jFoGWLO2
	Hqpeft2lnTa/TRd4a8OoK/7LlOnknFD0NURohP+8lQLIGvYusjxWfJ02IGJ7WJVPopbUMgVlgVT
	40RCxhKmexQdZvIeESqdP5nIYo0Nb+HkrWe95N601qt1zFS/pMjJNsjgCC4HGYEZfDU3EdFE=
X-Gm-Gg: ASbGncseZf0vf8kzlZjnisUdkdaIZXx9GHVMGD0lZxVyhaQF8jUA/+U68joG+s/nhRQ
	drSZ4C3vLxwDpHuaT5Nr+iO9C022Ft71Hy8LeokCGipQtBBzmoF9UtbSC0ESTiBIRaD0KYcZoly
	q55elNvQfjTFh3/nLs3p28Ytv/aDSY3JX/mcVgPCYLL/YowQJODML8nHIN4vu92Q7deOczzlW9a
	SUAjO8bNQ7f4YPCJ5Qo6Ae/FHZBdRYFXUnEJ+XrJvr04gpCgKQ9c580rNiaYGnA+zEqABQKLtsc
	WsXwgdD7h5m3oOq3vW2SLflVIHOAKcGaouCRPEfC1240+3hsK4NEThpGgv7rsjuv0kusAkUX2Q2
	dnrl7erMu+FZ3ANswLUb0aOy4+dw/
X-Received: by 2002:a05:620a:2b8e:b0:7c5:5e05:df33 with SMTP id af79cd13be357-7c5ba2377f6mr2072067685a.51.1742817086320;
        Mon, 24 Mar 2025 04:51:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEicGBX/5hLAGO9Iyhau01EJG34YeIhPqVZ7hlJC4o9+RBOb5j7V9FtWs3qaK82XBHpl6bH/Q==
X-Received: by 2002:a05:620a:2b8e:b0:7c5:5e05:df33 with SMTP id af79cd13be357-7c5ba2377f6mr2072061185a.51.1742817085742;
        Mon, 24 Mar 2025 04:51:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbb51sm1142907e87.135.2025.03.24.04.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:51:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 13:51:19 +0200
Subject: [PATCH RESEND RFC v4 1/6] drm/display: dp: implement new access
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-drm-rework-dpcd-access-v4-1-e80ff89593df@oss.qualcomm.com>
References: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
In-Reply-To: <20250324-drm-rework-dpcd-access-v4-0-e80ff89593df@oss.qualcomm.com>
To: Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QM+eu1I8aF02p2Or2gRwLpTXBfv2/4RXGbOyoJVHkoQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/pDd3Mji6tPN97p4WSJyO36VhjVqecu2fVg2g5fBZFij
 qnHrDg7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRGQs4GPqnZ6lkP7+jExai
 kBuqJpyrKc2W0rgpN3LTdr/NSwWVBC3ttnv/37NZO33dBK2c4pQzUlXvi2TDFutZhAcHOVaVKgk
 nufQxzDH99edqvO/GZfEnE0187rMYeW/890xO1Sp4/7dfdWwpS21X+Bfod9eHz+NaJC4XNf9Y92
 WHixPWn1Yzms8b8brveIRc+5m7R05Mn7W1eaLShPXCzvP5mNUSS/7Wyb1fZCN7WH536t53X9XML
 Ce2i5tZPE9IEr/uYn/8YHbDslrpb5HC75nvBQR9/xz0weO+xJL1EeFbcgQ3ztgx/3+c4YPHxbfU
 zyY58KcHmpwK+3F/1UzOUzxOWwwTr5gKbg96Fxf773ovAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: OhBtd1pMFGGVbfeJMlwHA01J_btSQZ7N
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67e1473f cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=Mcyz43guUpAUgyxYx7EA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OhBtd1pMFGGVbfeJMlwHA01J_btSQZ7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240086

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Existing DPCD access functions return an error code or the number of
bytes being read / write in case of partial access. However a lot of
drivers either (incorrectly) ignore partial access or mishandle error
codes. In other cases this results in a boilerplate code which compares
returned value with the size.

Implement new set of DPCD access helpers, which ignore partial access,
always return 0 or an error code.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
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
index 5ae4241959f24e2c1fb581d7c7d770485d603099..21e22289d1caebe616b57a304061b12592ad41ea 100644
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
+ * drm_dp_dpcd_read_byte() instead.
  */
 static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
 					unsigned int offset, u8 *valuep)
@@ -549,7 +608,8 @@ static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
  * @value: value to write to the register
  *
  * Returns the number of bytes transferred (1) on success, or a negative
- * error code on failure.
+ * error code on failure. In most of the cases you should be using
+ * drm_dp_dpcd_write_byte() instead.
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


