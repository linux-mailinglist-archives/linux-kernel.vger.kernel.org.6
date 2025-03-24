Return-Path: <linux-kernel+bounces-573588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D21C9A6D987
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4323A7E27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872E725EFB1;
	Mon, 24 Mar 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lesReW/G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812C25E839
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817103; cv=none; b=U1fpbsA1/W74tMnwhrnkkWWfJHk9vGFLq5mT2sXK9zai3Jp0XOo/RP4slSbpB/qSDSs1rMDyTEFPyKsjno7THYf828sYJsiVU7bLPF6vT5VQc5l8zeiS8EIbNJV+ShDiBanOF//A0y7+UKC66rWK8cR9O+zc7e/jF+HWYrx+KXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817103; c=relaxed/simple;
	bh=KL01593/zSX4Xb5hwQBCHJDAckIJ37QdEuF5jXeWgJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBuXvtprLQ+aXLL3K5rI1gpdAFDbMLcm5AOd4xy9O64ZAZoS1ALSbOkkCPphzSQsHWuOhdQFK9/wXLN274KupMpw/fxxaKVswMD+wdI1L1qeCpwfw3TwjdUEoZ8+ksTwcb2G0HeV7kNrkDVYygWsUcpV7JDLPSVhM4iySBcxHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lesReW/G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PLYw025897
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YD6Z7HGd6RWZSqIPuwEoc3ezQjdyPxL3+GL3fga18Fk=; b=lesReW/Gzw5a8xd4
	ITlAGQ179NbwwM/fJU8n2uIWinuxJCLYaguL04F/jS6lKDcSYIQA6fjo6fwgIDe6
	kx995Jl+2N7DgArTAk0nrAreGEua5AIN3i4mka4LBAKasd38zCe6DEzKgX1IPQno
	IQ1W+HFdhwzy5cwh412aJr5dhUy+3evc22QrXyYORdUOYhFHrqcj/OmEQbT67H12
	v3bkI5mjGpLJFSV9bD/4zToGx1feZisbrD3U58VUeaTQFcafq8WXc/mbB6C1BVn7
	MqaTdIwSoBSGYXja8rcfkhK5ueaDPo3CuFMx9v/pLSq62D0oNkXMrJTwwOrXLsb0
	sI+2cQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnmeya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:51:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e90788e2a7so68333356d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817100; x=1743421900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD6Z7HGd6RWZSqIPuwEoc3ezQjdyPxL3+GL3fga18Fk=;
        b=dQpqGPBy2cXDe2V3yzBUQZ9T9lkCetO3vIoEFYDFeDtcbGWRcwtb9In/odhpTx8iCr
         pPsmYSjsiXT6QYkm4+lOVLsbfdHlKwu46htU2/AWdjtIGcRyDrbZogYh8Ynbrh/+8+pq
         xBC2hn2+Hn3l7gT+dsR7ARVCywdyO0atARwdVPSRENkevzvYgN9cnCzie61PpqlOA31R
         9SpCKYQhrbAqFYZpJelrWUUhfB6s7MwrvZp6rlzjdTpBjDMB5HF+EIrILC8+T2v9+RNz
         bUSvZwy/uWILGmy3U3tS24mN2ulDzlACyknJQ6h1xGEI3EDDXLyaouto6SdcZQ5vJq2F
         EE5g==
X-Forwarded-Encrypted: i=1; AJvYcCXIPNSI0J7E3+js5YUarp+PI3tct5E4gGjI09O4QliGc2uTl9LIUdQ5u6A4i6ZIjkR6KQQfRhwMpRyOF7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDc2NtnPepioNkc9ViXdtdX2DH+FstZvmyyESaUHNIM8yswsk
	w1B4pTU2axK9Ltn4q9X6xncJELyYcy3DeALemfcBlzcbPReXfgH9jAPKI+/cJe4NxToImKVL6gO
	o5IHWYZwd/yfPWJ6BhtzBRvJLoSmcVX+R5pHoerAcOV44lMoV0XwYidA8QMUxT88=
X-Gm-Gg: ASbGncushuCkG8h6kdQnd8ROxg8DnZ3pLizApf0tdHFPhLbzr++ynhIS55QCqf877sB
	b2mmDZXvy3PSY2RfJc7fq3enMPBoZqxboM+HOnBqJi9zdbADz6Fc+iRVqu8aBGOduDCDkR8VXH1
	Fmnbm4SieayGMYAcCxyIklsMaDjFbMqwVr9Z4wuh2AKxlYfZtxnXQLFYjQEHASB/nUet79tJP0O
	oeOWHEs8dxpExbD6jGg5yQVo2KJ05nIYCn+9qWzNHcNo8htN1L9Y+dQHcqRGUDHa7pNjMOkMRCk
	G6pFd42KT6DSV9L49Yl6OuAKeSEMZ4z+5+mkNOB/UJ0jWLitAsHL66v/12GrkOos2N5d/ktSeBV
	UmHKeZpM3MGwJaLbP23iuQolRKEKc
X-Received: by 2002:a05:6214:2408:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6eb348dfa3fmr187175796d6.3.1742817099939;
        Mon, 24 Mar 2025 04:51:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmawuV3JgSxVBLzn2qNmfJsuUxjZIasSrpRm6a1OEJUGECsX3BLHE1O+Fe92iEBRpjZk2Jqw==
X-Received: by 2002:a05:6214:2408:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6eb348dfa3fmr187175436d6.3.1742817099430;
        Mon, 24 Mar 2025 04:51:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbb51sm1142907e87.135.2025.03.24.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:51:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 13:51:24 +0200
Subject: [PATCH RESEND RFC v4 6/6] drm/display: dp-tunnel: use new DCPD
 access helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-drm-rework-dpcd-access-v4-6-e80ff89593df@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4082;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AezDpTs9i2rYRC6AeDwZvqAV87zlWZZG2GdTd51PPFs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn4Uc4yRx7UjQy4QoSBPimBiYSX0cYz5pOoTHW8
 T5Aj4w+ex2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ+FHOAAKCRCLPIo+Aiko
 1dnkB/42iRt7GC5HMjISCT/tx8pOtl6nF26GjoU3BUm+tsmaqk+5Or4zLXk0YFcQ+kx24+8XVgp
 iyWPBHf4BKfhe3W80sJkdG67oQGkgocD7rnnLFRjp0sYfK/Wq4YvnyBY+bJWXeNhSEGm4hgBYWM
 DZvSFSEBp4sabKUzUItFVso95hmDF3tAX3993AxS3nqKMwuxeoDsTIUewQmjfYLb9TwXeelh+MK
 PZFzqaOgNvBjVbEUlra0twpSTIEfoWvlZIpoKy650Xwy2F4PGZXpg4T3AYXvLjvRYUZo9tobPUa
 m86Ix6Hmv4m8oXfo9wUiZFiGRErzzLjGcmCggw1VbvJ+7NFB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e1474c cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VzZmvmfVK_LU_xpdqU4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NXvrfQR8ZfMIFW8neunwcGCLYeXYgH6k
X-Proofpoint-GUID: NXvrfQR8ZfMIFW8neunwcGCLYeXYgH6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240086

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Switch drm_dp_tunnel.c to use new set of DPCD read / write helpers.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index 90fe07a89260e21e78f2db7f57a90602be921a11..076edf1610480275c62395334ab0536befa42f15 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -222,7 +222,7 @@ static int read_tunnel_regs(struct drm_dp_aux *aux, struct drm_dp_tunnel_regs *r
 	while ((len = next_reg_area(&offset))) {
 		int address = DP_TUNNELING_BASE + offset;
 
-		if (drm_dp_dpcd_read(aux, address, tunnel_reg_ptr(regs, address), len) < 0)
+		if (drm_dp_dpcd_read_data(aux, address, tunnel_reg_ptr(regs, address), len) < 0)
 			return -EIO;
 
 		offset += len;
@@ -913,7 +913,7 @@ static int set_bw_alloc_mode(struct drm_dp_tunnel *tunnel, bool enable)
 	u8 mask = DP_DISPLAY_DRIVER_BW_ALLOCATION_MODE_ENABLE | DP_UNMASK_BW_ALLOCATION_IRQ;
 	u8 val;
 
-	if (drm_dp_dpcd_readb(tunnel->aux, DP_DPTX_BW_ALLOCATION_MODE_CONTROL, &val) < 0)
+	if (drm_dp_dpcd_read_byte(tunnel->aux, DP_DPTX_BW_ALLOCATION_MODE_CONTROL, &val) < 0)
 		goto out_err;
 
 	if (enable)
@@ -921,7 +921,7 @@ static int set_bw_alloc_mode(struct drm_dp_tunnel *tunnel, bool enable)
 	else
 		val &= ~mask;
 
-	if (drm_dp_dpcd_writeb(tunnel->aux, DP_DPTX_BW_ALLOCATION_MODE_CONTROL, val) < 0)
+	if (drm_dp_dpcd_write_byte(tunnel->aux, DP_DPTX_BW_ALLOCATION_MODE_CONTROL, val) < 0)
 		goto out_err;
 
 	tunnel->bw_alloc_enabled = enable;
@@ -1039,7 +1039,7 @@ static int clear_bw_req_state(struct drm_dp_aux *aux)
 {
 	u8 bw_req_mask = DP_BW_REQUEST_SUCCEEDED | DP_BW_REQUEST_FAILED;
 
-	if (drm_dp_dpcd_writeb(aux, DP_TUNNELING_STATUS, bw_req_mask) < 0)
+	if (drm_dp_dpcd_write_byte(aux, DP_TUNNELING_STATUS, bw_req_mask) < 0)
 		return -EIO;
 
 	return 0;
@@ -1052,7 +1052,7 @@ static int bw_req_complete(struct drm_dp_aux *aux, bool *status_changed)
 	u8 val;
 	int err;
 
-	if (drm_dp_dpcd_readb(aux, DP_TUNNELING_STATUS, &val) < 0)
+	if (drm_dp_dpcd_read_byte(aux, DP_TUNNELING_STATUS, &val) < 0)
 		return -EIO;
 
 	*status_changed = val & status_change_mask;
@@ -1095,7 +1095,7 @@ static int allocate_tunnel_bw(struct drm_dp_tunnel *tunnel, int bw)
 	if (err)
 		goto out;
 
-	if (drm_dp_dpcd_writeb(tunnel->aux, DP_REQUEST_BW, request_bw) < 0) {
+	if (drm_dp_dpcd_write_byte(tunnel->aux, DP_REQUEST_BW, request_bw) < 0) {
 		err = -EIO;
 		goto out;
 	}
@@ -1196,13 +1196,13 @@ static int check_and_clear_status_change(struct drm_dp_tunnel *tunnel)
 	u8 mask = DP_BW_ALLOCATION_CAPABILITY_CHANGED | DP_ESTIMATED_BW_CHANGED;
 	u8 val;
 
-	if (drm_dp_dpcd_readb(tunnel->aux, DP_TUNNELING_STATUS, &val) < 0)
+	if (drm_dp_dpcd_read_byte(tunnel->aux, DP_TUNNELING_STATUS, &val) < 0)
 		goto out_err;
 
 	val &= mask;
 
 	if (val) {
-		if (drm_dp_dpcd_writeb(tunnel->aux, DP_TUNNELING_STATUS, val) < 0)
+		if (drm_dp_dpcd_write_byte(tunnel->aux, DP_TUNNELING_STATUS, val) < 0)
 			goto out_err;
 
 		return 1;
@@ -1215,7 +1215,7 @@ static int check_and_clear_status_change(struct drm_dp_tunnel *tunnel)
 	 * Check for estimated BW changes explicitly to account for lost
 	 * BW change notifications.
 	 */
-	if (drm_dp_dpcd_readb(tunnel->aux, DP_ESTIMATED_BW, &val) < 0)
+	if (drm_dp_dpcd_read_byte(tunnel->aux, DP_ESTIMATED_BW, &val) < 0)
 		goto out_err;
 
 	if (val * tunnel->bw_granularity != tunnel->estimated_bw)
@@ -1300,7 +1300,7 @@ int drm_dp_tunnel_handle_irq(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_aux *a
 {
 	u8 val;
 
-	if (drm_dp_dpcd_readb(aux, DP_TUNNELING_STATUS, &val) < 0)
+	if (drm_dp_dpcd_read_byte(aux, DP_TUNNELING_STATUS, &val) < 0)
 		return -EIO;
 
 	if (val & (DP_BW_REQUEST_SUCCEEDED | DP_BW_REQUEST_FAILED))

-- 
2.39.5


