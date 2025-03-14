Return-Path: <linux-kernel+bounces-560724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5559A608BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B2519C3F02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE318A922;
	Fri, 14 Mar 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9ZB6mEM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653971624D9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932021; cv=none; b=WGO8zM4KkXe79TxTHtGyJq6f2he0/T6uTcBHYIPTEwOArgdo+/ljE/KcekZYlR+AS9p66Z2rIYkxCsDBkkt7y8iYGuczHu3GqySxxod5DkKFTcGV72iGIUbQ2OCpdSGY/seRozROGZU8Z3GHZSULerXiGa+kooOda+/i6UTLFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932021; c=relaxed/simple;
	bh=KL01593/zSX4Xb5hwQBCHJDAckIJ37QdEuF5jXeWgJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICG2fL3WDp4dizFZXd/IqYPyiP461tb7Z3mzDR27GEVTsgQFaVdt+7EQnX5V/6jojqcpLYaEA1cQF3RI/JgaPDKX3nzSnOIGceH2sR2Ph3lWwmZxKd1VicilByAA63/JCr/Ce3z4WGxEKR52uJYD+SAoEmVA9Zxd5dZdRu/fgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9ZB6mEM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E2ei8j008320
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YD6Z7HGd6RWZSqIPuwEoc3ezQjdyPxL3+GL3fga18Fk=; b=F9ZB6mEMvQNwJykH
	MrOciWlfhPF8gc6CrJXLfBq6ksxP5I8HK9A04+R9PUhWfPJwCVv8BL0flzdy29AI
	eMEcparMp0Y8s3nwWzXN2Qz/07jcVo9fw40wbZ79dkOHIpPJXZKBLwh0EPiDKdkB
	mF7Gagr/+b3kLvLCU9PcpLZkLyNrIwovXGZN2QhD9SZj71u/ABBGyJst4jmag2kg
	Gs/9yzmzKr3kq5EeXX0YuHMn2IU4FEJlmWQAqpbweVhZHwKeKCIFBhCtLU/b+mWI
	/NiV+EIbFm87IQZvcBnmfGw09vKbyX2bP7W7iXYV840EQmKLmwa34xMDrEED99SE
	siG8LA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg8bw3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:00:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e1b8065ed4so39447046d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932017; x=1742536817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD6Z7HGd6RWZSqIPuwEoc3ezQjdyPxL3+GL3fga18Fk=;
        b=U8+VF3rndr4af6z5uu7b6qj4lAPn9uenHnke5r3PLf8BlM9Qg4zgvzn4DZXSu0hE9t
         ev/BmyKQ5dTO3FqziDm+O8fNIw7TIaey7cNZz5TvpTzPPLy915AR/AH8J0A5XPuPcGZ7
         DCoUoJjAo07JclMIZd1T+7ZYHUeGQluwmX4Ecv4u/n/7UXQaVL1enLIaxK3J70GbmgAq
         OmGMiqKnIFdm0eC83Y90Peh+14km+SY5YZbraxMR92av/cU3gXxvsaoaHSQ+Xh+lbgfh
         q4p17XSJr9GczEtWM+ePZi+pEzD6FCEI4M0Rgmeyd+qD4vhHEKQOQ0dD0f+ryJ9KKnQA
         7S5g==
X-Forwarded-Encrypted: i=1; AJvYcCWwTPh7yKWRq6yYK+ccoFII1K/+1RWb0MMr3QmNf1nBYH/sf5WodnYrtsuBZvNtaJGys++DuQvonKT8ZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztI54buKBr9BHiDRLHyuqrZ6N84yjwYUEbwyPotGWqVezS00j/
	vk4kU72M5XMmeQi++jKPsaLh3smlVsvI4xeyv7Iw9EFDDTRmiSmWj65529VTab3cJQAW74vTXMK
	MGrrI4ovkbqqY/5wXYhZ2Bn8Ts0QXcYPPg9mN2WB3SzQG592Z0FtJiCHTTjl7e8k=
X-Gm-Gg: ASbGncujhoLRZJQS9CL/KPY+/ua8F8+d/R0Ho3vlh+ewGlBqzqt0lRXFZ5jY3C/QLhL
	6Q/KnnG0jP6NrCj7Si5IYslxzwKE1aKw2aFd3Aj0pizgHu38Dfe8ndZ7CynptLgfzPMd7TumKJL
	inFVYVmLlU5Uhh8LwRPZxfBJZJHcqPAMIFetn7lhrms4Ve40fOzFkUI789p3iy8sSff32bILXNw
	E96sVV8iAZfzwMR8wDcRHvDhUflLkdfsIeH+AnaTWmiSU6qRC1gtCnqHM10r7Bj3XO5hTG/Gi2/
	gLCI6qDd5lU6GZJ4xz6ZoXmR0dg+C5FhmhYuSn9A5+Stwm4fPCnOusLb67tDTJa9RENKPINh1aO
	zo2ND3fqiovjz/89t8ZG1/zkOqsT4
X-Received: by 2002:a05:6214:27e5:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6eaeab0fbbfmr16506316d6.45.1741932017328;
        Thu, 13 Mar 2025 23:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELJcylmUiJ4JEURtcZ0pb2cGp+YTibCxqJbDGjU39ccIquuLoPHTNuJjmGgKfn3GK+0NkRrQ==
X-Received: by 2002:a05:6214:27e5:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6eaeab0fbbfmr16506016d6.45.1741932016982;
        Thu, 13 Mar 2025 23:00:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88332dsm416136e87.181.2025.03.13.23.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:00:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 07:59:47 +0200
Subject: [PATCH RFC v4 6/6] drm/display: dp-tunnel: use new DCPD access
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-drm-rework-dpcd-access-v4-6-e86ef6fc6d76@oss.qualcomm.com>
References: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
In-Reply-To: <20250314-drm-rework-dpcd-access-v4-0-e86ef6fc6d76@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08XZFN6uPDdiX1R7XmfB1vXISASqSFYGN569O
 I6KV6qdI3WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PF2QAKCRCLPIo+Aiko
 1eM5B/9jhOE9nI9V6mDRKubJu0/SPcbZoi/lHs71XyG/da3UMGC32Qt16u66xFuLg4inRbB79MC
 lZllWHwPgl1Q5/YeMrd7mbZ4SMoiH9evqV5y0/FTvifqU6zwgcpJ6ZCMWGixnm3Ezlb0aiz5nI9
 XYnzCZ3lNXvh8AkwMZMgXNfGOA71gEm/MhhXwmgqXHN48nVlgfkYc1J84RrrNot9sLmiQgfQHzR
 F4KZYvVt5YGhuR97yx5BeXuJOeT2S6L6rAfmV5RybP6JJdi6id/B10zo5H3f/e3tm+QFyIddeuv
 fYEScrVe2IVsan3JCnn6Al2YeCZugz0rJLJveu4Idywf2rlt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d3c5f2 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=VzZmvmfVK_LU_xpdqU4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: O0IZLgAIxoIMlqn2ctTKMS9gqkoDmB1U
X-Proofpoint-ORIG-GUID: O0IZLgAIxoIMlqn2ctTKMS9gqkoDmB1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140045

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


