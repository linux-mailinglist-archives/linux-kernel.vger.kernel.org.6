Return-Path: <linux-kernel+bounces-540120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B565A4ADF1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667E816CC29
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAF61EA7DE;
	Sat,  1 Mar 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDYaYJ/d"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1011E5B7F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740861599; cv=none; b=p00PoaY1IRbjNhJaK9LBHtQz22E7AjU+5h4cadLDb7aPTpiYMR/J0NLLhaX0tEe3by4cUfJF3CPcSKBcvhmsnRxxAYQCR9rahgIpLJBfSZVRueSgTkvQ4OFCL17RMlmyGGdpWKcmOlvHRBuWUxmQQ98ON5hRdJdEzvPT4GCszF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740861599; c=relaxed/simple;
	bh=Kupghql56DHqM4wDv/45qSyGLZpGi6n/Mw9iPxFwqBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqFHQppuuOEr2CtoBj2OL0tHxIeitrlOOiaZYmff//yvMhn/rIlQzdVLbcypdzsrj7XToiSgNv4aZLt00M4EaT1YHWOgd75nJlfPX8/HLzUOFA83OFUb021h39VFISlWUlQnEiysYgzVR3w5wTx2enGKVYMjChVF4uI8mVJ96RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDYaYJ/d; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30762598511so34167141fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740861594; x=1741466394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prwwE+c5zF3NGDDHmnHDLmDlz64Yk+sfoALNwvHB5U0=;
        b=oDYaYJ/dQKrIvjTdBBJdikuFASFqHXzP7WHoItvqf4H6efAF7+wXXv+QY207SqI/ut
         Oi6saHON7bD85zHAI7QVpimH1LrERdoa81fGAEAxj95WhL5Pta3/0LGeBjjUbIayUOEC
         /u3f/79Ay7y7kqheDahbmG8HSc/YifPXvKv0EfKnwzJ02HVttFyMoWukxsjZZCQgg9G0
         op2pKECT6S4yOo3rmE/6Mqb4wCm0X4heYiE9QbUyGT5fPiiGy2dGq/t8SNcXa9Ahas1B
         yNg/lFJS7KzAc1dUPT6Lsvv+MmXK64NjHFg6u7PTVxUdV06qXrtk0kVgvuk8Z8BsMRaf
         UDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740861594; x=1741466394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prwwE+c5zF3NGDDHmnHDLmDlz64Yk+sfoALNwvHB5U0=;
        b=ayqmE/VvviEnM4AkJI4zVRefd9gJG5uoRZrv4THVmsVUWT+i2+kZyuDQoVD0GoqVMM
         RL4SGmRDqWfCNPQ0kT1L8AHmqPnA/rnBiDD//mJ5nrE7sC6cNzGTMVWBL939IV/RtHmH
         gEGoghwpi70C+wHNI928TY24ZkYC6wSCQLbaCBhna2HzUd3A/BYY9qWMCtQz3WjFwlPS
         QkKC1BC7eFnevBY4ISkH0nQ5pbaq1raNb3Bkl9ers2hVclQQ3oVVlRCAXWBbcNIa8Mbl
         oEqrhgHm1gabX+SbVeL1qcPVneYGPTuJnOvp8EEj4gEfUyvqrdi09gWKZMdIGSoeioHy
         J/5g==
X-Forwarded-Encrypted: i=1; AJvYcCWAtYGM/Cm24MmHCt+x6EK6aFTcMOqQHZKYxKswIekhr3mE4I/Wbg56XOEjOXFfvq172ef/nTOd9IN+pUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaqleowWCANk6jYGfJeaY7umQfQw6yzxS067N5tZy4Lio2YsN
	PhFhskER8pu0uufnff40t7XN6U9TK/GQoAS2c8YHCWKyJLQUBbkQaplPIVAGxpY=
X-Gm-Gg: ASbGncsv0WP4DE+5RN2jNhXSn8/6SBRNDfwM8F0yi2h7VvGoplWcwRk5SqMLSW8oNye
	ha95Y7k6tfs/Bd2cQWze9SK7z+4KxbrU1Qmql+amHoWVuHv9DsrF+3xS/XHVeGiLUMnS9hKJHVo
	Af+asYHRtb1Z5Rc1eXjRwbSf4u/ulBphK/snfjPSKNKlDzqu7WHNTJ6cJTenbUYPR1NvnZPzEzQ
	JRyMKRmXEKtKIo0JQdleCL9VQlKpEi0U/AVnmmjxQ//ci2NKzOxX151j+f6gW1OHpppxRVUUmUM
	643EFwkE3pz8rStqjDcCm7mO75il7agOy73005I5unSouMlCl7zl
X-Google-Smtp-Source: AGHT+IEuvF8KFQFe3gJyuFuReZZU6Aw/XZrbRP7EpyU1MXgi1OJs+mGi96QLs0563QV+zudKiUKmlg==
X-Received: by 2002:a05:651c:54d:b0:300:5c57:526b with SMTP id 38308e7fff4ca-30b93230016mr31794761fa.11.1740861594338;
        Sat, 01 Mar 2025 12:39:54 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b931524efsm6668921fa.60.2025.03.01.12.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 12:39:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 22:39:38 +0200
Subject: [PATCH RFC v2 3/7] drm/display: dp: use new DCPD access helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-drm-rework-dpcd-access-v2-3-4d92602fc7cd@linaro.org>
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
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27759;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Kupghql56DHqM4wDv/45qSyGLZpGi6n/Mw9iPxFwqBk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ/rhgv64TVo/bvZXTskLz9+g7vkrf2ehTEBygZbqcheGN
 47y1xI7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRchb2vwImp+rsayZOeXdn
 mtyEh27b8jZ1zRLofpA9866Hd9UsRwV/MdUPezyfSn369nr7rcCbTqzHO+YXNXDt8+eyltQKLTo
 hEDdzUdeJp9+vdAsEtqjbNHhr/Es/etkl9Hqte4fuJlG2azsPX5p4d8fFf4yHZy8UnSGx0mrzn0
 Me2jXue0M1vjZZfNO+Nr9LvF4v/UZezyGHA3wCkTPTbyjIqLftuc5YEnbwYkB8TtA7jXwFjxbR1
 Wcef58qu+tEqqwYk7yUKWOYHctexi/KrWHHEx78m3De78/Xv8duKXeHG9u9cbVe4GxUukXlxlan
 xs/J2vuDf1j93Znw9rw3U6dZyR2u9/VF0ZGJUuxZa+wEAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Switch drm_dp_helper.c to use new set of DPCD read / write helpers.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 296 +++++++++++++-------------------
 1 file changed, 116 insertions(+), 180 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 410be0be233ad94702af423262a7d98e21afbfeb..e2439c8a7fefe116b04aaa689b557e2387b05540 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -327,7 +327,7 @@ static int __read_delay(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SI
 	if (offset < DP_RECEIVER_CAP_SIZE) {
 		rd_interval = dpcd[offset];
 	} else {
-		if (drm_dp_dpcd_readb(aux, offset, &rd_interval) != 1) {
+		if (drm_dp_dpcd_read_byte(aux, offset, &rd_interval) < 0) {
 			drm_dbg_kms(aux->drm_dev, "%s: failed rd interval read\n",
 				    aux->name);
 			/* arbitrary default delay */
@@ -358,7 +358,7 @@ int drm_dp_128b132b_read_aux_rd_interval(struct drm_dp_aux *aux)
 	int unit;
 	u8 val;
 
-	if (drm_dp_dpcd_readb(aux, DP_128B132B_TRAINING_AUX_RD_INTERVAL, &val) != 1) {
+	if (drm_dp_dpcd_read_byte(aux, DP_128B132B_TRAINING_AUX_RD_INTERVAL, &val) < 0) {
 		drm_err(aux->drm_dev, "%s: failed rd interval read\n",
 			aux->name);
 		/* default to max */
@@ -807,30 +807,20 @@ int drm_dp_dpcd_read_phy_link_status(struct drm_dp_aux *aux,
 {
 	int ret;
 
-	if (dp_phy == DP_PHY_DPRX) {
-		ret = drm_dp_dpcd_read(aux,
-				       DP_LANE0_1_STATUS,
-				       link_status,
-				       DP_LINK_STATUS_SIZE);
-
-		if (ret < 0)
-			return ret;
+	if (dp_phy == DP_PHY_DPRX)
+		return drm_dp_dpcd_read_data(aux,
+					     DP_LANE0_1_STATUS,
+					     link_status,
+					     DP_LINK_STATUS_SIZE);
 
-		WARN_ON(ret != DP_LINK_STATUS_SIZE);
-
-		return 0;
-	}
-
-	ret = drm_dp_dpcd_read(aux,
-			       DP_LANE0_1_STATUS_PHY_REPEATER(dp_phy),
-			       link_status,
-			       DP_LINK_STATUS_SIZE - 1);
+	ret = drm_dp_dpcd_read_data(aux,
+				    DP_LANE0_1_STATUS_PHY_REPEATER(dp_phy),
+				    link_status,
+				    DP_LINK_STATUS_SIZE - 1);
 
 	if (ret < 0)
 		return ret;
 
-	WARN_ON(ret != DP_LINK_STATUS_SIZE - 1);
-
 	/* Convert the LTTPR to the sink PHY link status layout */
 	memmove(&link_status[DP_SINK_STATUS - DP_LANE0_1_STATUS + 1],
 		&link_status[DP_SINK_STATUS - DP_LANE0_1_STATUS],
@@ -846,7 +836,7 @@ static int read_payload_update_status(struct drm_dp_aux *aux)
 	int ret;
 	u8 status;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
 	if (ret < 0)
 		return ret;
 
@@ -873,21 +863,21 @@ int drm_dp_dpcd_write_payload(struct drm_dp_aux *aux,
 	int ret;
 	int retries = 0;
 
-	drm_dp_dpcd_writeb(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS,
-			   DP_PAYLOAD_TABLE_UPDATED);
+	drm_dp_dpcd_write_byte(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS,
+			       DP_PAYLOAD_TABLE_UPDATED);
 
 	payload_alloc[0] = vcpid;
 	payload_alloc[1] = start_time_slot;
 	payload_alloc[2] = time_slot_count;
 
-	ret = drm_dp_dpcd_write(aux, DP_PAYLOAD_ALLOCATE_SET, payload_alloc, 3);
-	if (ret != 3) {
+	ret = drm_dp_dpcd_write_data(aux, DP_PAYLOAD_ALLOCATE_SET, payload_alloc, 3);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "failed to write payload allocation %d\n", ret);
 		goto fail;
 	}
 
 retry:
-	ret = drm_dp_dpcd_readb(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
 	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "failed to read payload table status %d\n", ret);
 		goto fail;
@@ -1043,15 +1033,15 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
 {
 	u8 link_edid_read = 0, auto_test_req = 0, test_resp = 0;
 
-	if (drm_dp_dpcd_read(aux, DP_DEVICE_SERVICE_IRQ_VECTOR,
-			     &auto_test_req, 1) < 1) {
+	if (drm_dp_dpcd_read_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR,
+				  &auto_test_req) < 0) {
 		drm_err(aux->drm_dev, "%s: DPCD failed read at register 0x%x\n",
 			aux->name, DP_DEVICE_SERVICE_IRQ_VECTOR);
 		return false;
 	}
 	auto_test_req &= DP_AUTOMATED_TEST_REQUEST;
 
-	if (drm_dp_dpcd_read(aux, DP_TEST_REQUEST, &link_edid_read, 1) < 1) {
+	if (drm_dp_dpcd_read_byte(aux, DP_TEST_REQUEST, &link_edid_read) < 0) {
 		drm_err(aux->drm_dev, "%s: DPCD failed read at register 0x%x\n",
 			aux->name, DP_TEST_REQUEST);
 		return false;
@@ -1064,23 +1054,23 @@ bool drm_dp_send_real_edid_checksum(struct drm_dp_aux *aux,
 		return false;
 	}
 
-	if (drm_dp_dpcd_write(aux, DP_DEVICE_SERVICE_IRQ_VECTOR,
-			      &auto_test_req, 1) < 1) {
+	if (drm_dp_dpcd_write_byte(aux, DP_DEVICE_SERVICE_IRQ_VECTOR,
+				   auto_test_req) < 0) {
 		drm_err(aux->drm_dev, "%s: DPCD failed write at register 0x%x\n",
 			aux->name, DP_DEVICE_SERVICE_IRQ_VECTOR);
 		return false;
 	}
 
 	/* send back checksum for the last edid extension block data */
-	if (drm_dp_dpcd_write(aux, DP_TEST_EDID_CHECKSUM,
-			      &real_edid_checksum, 1) < 1) {
+	if (drm_dp_dpcd_write_byte(aux, DP_TEST_EDID_CHECKSUM,
+				   real_edid_checksum) < 0) {
 		drm_err(aux->drm_dev, "%s: DPCD failed write at register 0x%x\n",
 			aux->name, DP_TEST_EDID_CHECKSUM);
 		return false;
 	}
 
 	test_resp |= DP_TEST_EDID_CHECKSUM_WRITE;
-	if (drm_dp_dpcd_write(aux, DP_TEST_RESPONSE, &test_resp, 1) < 1) {
+	if (drm_dp_dpcd_write_byte(aux, DP_TEST_RESPONSE, test_resp) < 0) {
 		drm_err(aux->drm_dev, "%s: DPCD failed write at register 0x%x\n",
 			aux->name, DP_TEST_RESPONSE);
 		return false;
@@ -1117,12 +1107,10 @@ static int drm_dp_read_extended_dpcd_caps(struct drm_dp_aux *aux,
 	      DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT))
 		return 0;
 
-	ret = drm_dp_dpcd_read(aux, DP_DP13_DPCD_REV, &dpcd_ext,
-			       sizeof(dpcd_ext));
+	ret = drm_dp_dpcd_read_data(aux, DP_DP13_DPCD_REV, &dpcd_ext,
+				    sizeof(dpcd_ext));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(dpcd_ext))
-		return -EIO;
 
 	if (dpcd[DP_DPCD_REV] > dpcd_ext[DP_DPCD_REV]) {
 		drm_dbg_kms(aux->drm_dev,
@@ -1159,10 +1147,10 @@ int drm_dp_read_dpcd_caps(struct drm_dp_aux *aux,
 {
 	int ret;
 
-	ret = drm_dp_dpcd_read(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
+	ret = drm_dp_dpcd_read_data(aux, DP_DPCD_REV, dpcd, DP_RECEIVER_CAP_SIZE);
 	if (ret < 0)
 		return ret;
-	if (ret != DP_RECEIVER_CAP_SIZE || dpcd[DP_DPCD_REV] == 0)
+	if (dpcd[DP_DPCD_REV] == 0)
 		return -EIO;
 
 	ret = drm_dp_read_extended_dpcd_caps(aux, dpcd);
@@ -1212,11 +1200,9 @@ int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
 	if (dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE)
 		len *= 4;
 
-	ret = drm_dp_dpcd_read(aux, DP_DOWNSTREAM_PORT_0, downstream_ports, len);
+	ret = drm_dp_dpcd_read_data(aux, DP_DOWNSTREAM_PORT_0, downstream_ports, len);
 	if (ret < 0)
 		return ret;
-	if (ret != len)
-		return -EIO;
 
 	drm_dbg_kms(aux->drm_dev, "%s: DPCD DFP: %*ph\n", aux->name, len, downstream_ports);
 
@@ -1573,7 +1559,7 @@ EXPORT_SYMBOL(drm_dp_downstream_mode);
  */
 int drm_dp_downstream_id(struct drm_dp_aux *aux, char id[6])
 {
-	return drm_dp_dpcd_read(aux, DP_BRANCH_ID, id, 6);
+	return drm_dp_dpcd_read_data(aux, DP_BRANCH_ID, id, 6);
 }
 EXPORT_SYMBOL(drm_dp_downstream_id);
 
@@ -1638,13 +1624,13 @@ void drm_dp_downstream_debug(struct seq_file *m,
 	drm_dp_downstream_id(aux, id);
 	seq_printf(m, "\t\tID: %s\n", id);
 
-	len = drm_dp_dpcd_read(aux, DP_BRANCH_HW_REV, &rev[0], 1);
-	if (len > 0)
+	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_HW_REV, &rev[0], 1);
+	if (!len)
 		seq_printf(m, "\t\tHW: %d.%d\n",
 			   (rev[0] & 0xf0) >> 4, rev[0] & 0xf);
 
-	len = drm_dp_dpcd_read(aux, DP_BRANCH_SW_REV, rev, 2);
-	if (len > 0)
+	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_SW_REV, rev, 2);
+	if (!len)
 		seq_printf(m, "\t\tSW: %d.%d\n", rev[0], rev[1]);
 
 	if (detailed_cap_info) {
@@ -1782,11 +1768,9 @@ int drm_dp_read_sink_count(struct drm_dp_aux *aux)
 	u8 count;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_SINK_COUNT, &count);
+	ret = drm_dp_dpcd_read_byte(aux, DP_SINK_COUNT, &count);
 	if (ret < 0)
 		return ret;
-	if (ret != 1)
-		return -EIO;
 
 	return DP_GET_SINK_COUNT(count);
 }
@@ -2175,13 +2159,13 @@ static int drm_dp_aux_get_crc(struct drm_dp_aux *aux, u8 *crc)
 	u8 buf, count;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_TEST_SINK, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_TEST_SINK, &buf);
 	if (ret < 0)
 		return ret;
 
 	WARN_ON(!(buf & DP_TEST_SINK_START));
 
-	ret = drm_dp_dpcd_readb(aux, DP_TEST_SINK_MISC, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_TEST_SINK_MISC, &buf);
 	if (ret < 0)
 		return ret;
 
@@ -2195,11 +2179,7 @@ static int drm_dp_aux_get_crc(struct drm_dp_aux *aux, u8 *crc)
 	 * At DP_TEST_CRC_R_CR, there's 6 bytes containing CRC data, 2 bytes
 	 * per component (RGB or CrYCb).
 	 */
-	ret = drm_dp_dpcd_read(aux, DP_TEST_CRC_R_CR, crc, 6);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_read_data(aux, DP_TEST_CRC_R_CR, crc, 6);
 }
 
 static void drm_dp_aux_crc_work(struct work_struct *work)
@@ -2398,11 +2378,11 @@ int drm_dp_start_crc(struct drm_dp_aux *aux, struct drm_crtc *crtc)
 	u8 buf;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_TEST_SINK, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_TEST_SINK, &buf);
 	if (ret < 0)
 		return ret;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_TEST_SINK, buf | DP_TEST_SINK_START);
+	ret = drm_dp_dpcd_write_byte(aux, DP_TEST_SINK, buf | DP_TEST_SINK_START);
 	if (ret < 0)
 		return ret;
 
@@ -2425,11 +2405,11 @@ int drm_dp_stop_crc(struct drm_dp_aux *aux)
 	u8 buf;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_TEST_SINK, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_TEST_SINK, &buf);
 	if (ret < 0)
 		return ret;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_TEST_SINK, buf & ~DP_TEST_SINK_START);
+	ret = drm_dp_dpcd_write_byte(aux, DP_TEST_SINK, buf & ~DP_TEST_SINK_START);
 	if (ret < 0)
 		return ret;
 
@@ -2515,11 +2495,7 @@ drm_dp_get_quirks(const struct drm_dp_dpcd_ident *ident, bool is_branch)
 static int drm_dp_read_ident(struct drm_dp_aux *aux, unsigned int offset,
 			     struct drm_dp_dpcd_ident *ident)
 {
-	int ret;
-
-	ret = drm_dp_dpcd_read(aux, offset, ident, sizeof(*ident));
-
-	return ret < 0 ? ret : 0;
+	return drm_dp_dpcd_read_data(aux, offset, ident, sizeof(*ident));
 }
 
 static void drm_dp_dump_desc(struct drm_dp_aux *aux,
@@ -2777,13 +2753,11 @@ static int drm_dp_read_lttpr_regs(struct drm_dp_aux *aux,
 	int ret;
 
 	for (offset = 0; offset < buf_size; offset += block_size) {
-		ret = drm_dp_dpcd_read(aux,
-				       address + offset,
-				       &buf[offset], block_size);
+		ret = drm_dp_dpcd_read_data(aux,
+					    address + offset,
+					    &buf[offset], block_size);
 		if (ret < 0)
 			return ret;
-
-		WARN_ON(ret != block_size);
 	}
 
 	return 0;
@@ -2998,12 +2972,12 @@ int drm_dp_get_phy_test_pattern(struct drm_dp_aux *aux,
 	int err;
 	u8 rate, lanes;
 
-	err = drm_dp_dpcd_readb(aux, DP_TEST_LINK_RATE, &rate);
+	err = drm_dp_dpcd_read_byte(aux, DP_TEST_LINK_RATE, &rate);
 	if (err < 0)
 		return err;
 	data->link_rate = drm_dp_bw_code_to_link_rate(rate);
 
-	err = drm_dp_dpcd_readb(aux, DP_TEST_LANE_COUNT, &lanes);
+	err = drm_dp_dpcd_read_byte(aux, DP_TEST_LANE_COUNT, &lanes);
 	if (err < 0)
 		return err;
 	data->num_lanes = lanes & DP_MAX_LANE_COUNT_MASK;
@@ -3011,22 +2985,22 @@ int drm_dp_get_phy_test_pattern(struct drm_dp_aux *aux,
 	if (lanes & DP_ENHANCED_FRAME_CAP)
 		data->enhanced_frame_cap = true;
 
-	err = drm_dp_dpcd_readb(aux, DP_PHY_TEST_PATTERN, &data->phy_pattern);
+	err = drm_dp_dpcd_read_byte(aux, DP_PHY_TEST_PATTERN, &data->phy_pattern);
 	if (err < 0)
 		return err;
 
 	switch (data->phy_pattern) {
 	case DP_PHY_TEST_PATTERN_80BIT_CUSTOM:
-		err = drm_dp_dpcd_read(aux, DP_TEST_80BIT_CUSTOM_PATTERN_7_0,
-				       &data->custom80, sizeof(data->custom80));
+		err = drm_dp_dpcd_read_data(aux, DP_TEST_80BIT_CUSTOM_PATTERN_7_0,
+					    &data->custom80, sizeof(data->custom80));
 		if (err < 0)
 			return err;
 
 		break;
 	case DP_PHY_TEST_PATTERN_CP2520:
-		err = drm_dp_dpcd_read(aux, DP_TEST_HBR2_SCRAMBLER_RESET,
-				       &data->hbr2_reset,
-				       sizeof(data->hbr2_reset));
+		err = drm_dp_dpcd_read_data(aux, DP_TEST_HBR2_SCRAMBLER_RESET,
+					    &data->hbr2_reset,
+					    sizeof(data->hbr2_reset));
 		if (err < 0)
 			return err;
 	}
@@ -3053,15 +3027,15 @@ int drm_dp_set_phy_test_pattern(struct drm_dp_aux *aux,
 	if (dp_rev < 0x12) {
 		test_pattern = (test_pattern << 2) &
 			       DP_LINK_QUAL_PATTERN_11_MASK;
-		err = drm_dp_dpcd_writeb(aux, DP_TRAINING_PATTERN_SET,
-					 test_pattern);
+		err = drm_dp_dpcd_write_byte(aux, DP_TRAINING_PATTERN_SET,
+					     test_pattern);
 		if (err < 0)
 			return err;
 	} else {
 		for (i = 0; i < data->num_lanes; i++) {
-			err = drm_dp_dpcd_writeb(aux,
-						 DP_LINK_QUAL_LANE0_SET + i,
-						 test_pattern);
+			err = drm_dp_dpcd_write_byte(aux,
+						     DP_LINK_QUAL_LANE0_SET + i,
+						     test_pattern);
 			if (err < 0)
 				return err;
 		}
@@ -3268,8 +3242,8 @@ bool drm_dp_as_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_C
 	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_13)
 		return false;
 
-	if (drm_dp_dpcd_readb(aux, DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1,
-			      &rx_feature) != 1) {
+	if (drm_dp_dpcd_read_byte(aux, DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1,
+				  &rx_feature) < 0) {
 		drm_dbg_dp(aux->drm_dev,
 			   "Failed to read DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1\n");
 		return false;
@@ -3293,7 +3267,7 @@ bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_
 	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_13)
 		return false;
 
-	if (drm_dp_dpcd_readb(aux, DP_DPRX_FEATURE_ENUMERATION_LIST, &rx_feature) != 1) {
+	if (drm_dp_dpcd_read_byte(aux, DP_DPRX_FEATURE_ENUMERATION_LIST, &rx_feature) < 0) {
 		drm_dbg_dp(aux->drm_dev, "failed to read DP_DPRX_FEATURE_ENUMERATION_LIST\n");
 		return false;
 	}
@@ -3424,16 +3398,13 @@ EXPORT_SYMBOL(drm_dp_get_pcon_max_frl_bw);
  */
 int drm_dp_pcon_frl_prepare(struct drm_dp_aux *aux, bool enable_frl_ready_hpd)
 {
-	int ret;
 	u8 buf = DP_PCON_ENABLE_SOURCE_CTL_MODE |
 		 DP_PCON_ENABLE_LINK_FRL_MODE;
 
 	if (enable_frl_ready_hpd)
 		buf |= DP_PCON_ENABLE_HPD_READY;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
-
-	return ret;
+	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_prepare);
 
@@ -3448,7 +3419,7 @@ bool drm_dp_pcon_is_frl_ready(struct drm_dp_aux *aux)
 	int ret;
 	u8 buf;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PCON_HDMI_TX_LINK_STATUS, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_TX_LINK_STATUS, &buf);
 	if (ret < 0)
 		return false;
 
@@ -3477,7 +3448,7 @@ int drm_dp_pcon_frl_configure_1(struct drm_dp_aux *aux, int max_frl_gbps,
 	int ret;
 	u8 buf;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PCON_HDMI_LINK_CONFIG_1, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, &buf);
 	if (ret < 0)
 		return ret;
 
@@ -3512,11 +3483,7 @@ int drm_dp_pcon_frl_configure_1(struct drm_dp_aux *aux, int max_frl_gbps,
 		return -EINVAL;
 	}
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_configure_1);
 
@@ -3542,7 +3509,7 @@ int drm_dp_pcon_frl_configure_2(struct drm_dp_aux *aux, int max_frl_mask,
 	else
 		buf &= ~DP_PCON_FRL_LINK_TRAIN_EXTENDED;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_2, buf);
+	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_2, buf);
 	if (ret < 0)
 		return ret;
 
@@ -3558,13 +3525,7 @@ EXPORT_SYMBOL(drm_dp_pcon_frl_configure_2);
  */
 int drm_dp_pcon_reset_frl_config(struct drm_dp_aux *aux)
 {
-	int ret;
-
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, 0x0);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, 0x0);
 }
 EXPORT_SYMBOL(drm_dp_pcon_reset_frl_config);
 
@@ -3579,7 +3540,7 @@ int drm_dp_pcon_frl_enable(struct drm_dp_aux *aux)
 	int ret;
 	u8 buf = 0;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PCON_HDMI_LINK_CONFIG_1, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, &buf);
 	if (ret < 0)
 		return ret;
 	if (!(buf & DP_PCON_ENABLE_SOURCE_CTL_MODE)) {
@@ -3588,11 +3549,7 @@ int drm_dp_pcon_frl_enable(struct drm_dp_aux *aux)
 		return -EINVAL;
 	}
 	buf |= DP_PCON_ENABLE_HDMI_LINK;
-	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_write_byte(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
 }
 EXPORT_SYMBOL(drm_dp_pcon_frl_enable);
 
@@ -3607,7 +3564,7 @@ bool drm_dp_pcon_hdmi_link_active(struct drm_dp_aux *aux)
 	u8 buf;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PCON_HDMI_TX_LINK_STATUS, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_TX_LINK_STATUS, &buf);
 	if (ret < 0)
 		return false;
 
@@ -3632,7 +3589,7 @@ int drm_dp_pcon_hdmi_link_mode(struct drm_dp_aux *aux, u8 *frl_trained_mask)
 	int mode;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PCON_HDMI_POST_FRL_STATUS, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_POST_FRL_STATUS, &buf);
 	if (ret < 0)
 		return ret;
 
@@ -3661,7 +3618,7 @@ void drm_dp_pcon_hdmi_frl_link_error_count(struct drm_dp_aux *aux,
 	struct drm_hdmi_info *hdmi = &connector->display_info.hdmi;
 
 	for (i = 0; i < hdmi->max_lanes; i++) {
-		if (drm_dp_dpcd_readb(aux, DP_PCON_HDMI_ERROR_STATUS_LN0 + i, &buf) < 0)
+		if (drm_dp_dpcd_read_byte(aux, DP_PCON_HDMI_ERROR_STATUS_LN0 + i, &buf) < 0)
 			return;
 
 		error_count = buf & DP_PCON_HDMI_ERROR_COUNT_MASK;
@@ -3796,7 +3753,7 @@ int drm_dp_pcon_configure_dsc_enc(struct drm_dp_aux *aux, u8 pps_buf_config)
 	u8 buf;
 	int ret;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, &buf);
 	if (ret < 0)
 		return ret;
 
@@ -3807,11 +3764,7 @@ int drm_dp_pcon_configure_dsc_enc(struct drm_dp_aux *aux, u8 pps_buf_config)
 		buf |= pps_buf_config << 2;
 	}
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_write_byte(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, buf);
 }
 
 /**
@@ -3823,13 +3776,7 @@ int drm_dp_pcon_configure_dsc_enc(struct drm_dp_aux *aux, u8 pps_buf_config)
  */
 int drm_dp_pcon_pps_default(struct drm_dp_aux *aux)
 {
-	int ret;
-
-	ret = drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_DISABLED);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_DISABLED);
 }
 EXPORT_SYMBOL(drm_dp_pcon_pps_default);
 
@@ -3845,15 +3792,11 @@ int drm_dp_pcon_pps_override_buf(struct drm_dp_aux *aux, u8 pps_buf[128])
 {
 	int ret;
 
-	ret = drm_dp_dpcd_write(aux, DP_PCON_HDMI_PPS_OVERRIDE_BASE, &pps_buf, 128);
+	ret = drm_dp_dpcd_write_data(aux, DP_PCON_HDMI_PPS_OVERRIDE_BASE, &pps_buf, 128);
 	if (ret < 0)
 		return ret;
 
-	ret = drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_EN_BUFFER);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_EN_BUFFER);
 }
 EXPORT_SYMBOL(drm_dp_pcon_pps_override_buf);
 
@@ -3870,21 +3813,17 @@ int drm_dp_pcon_pps_override_param(struct drm_dp_aux *aux, u8 pps_param[6])
 {
 	int ret;
 
-	ret = drm_dp_dpcd_write(aux, DP_PCON_HDMI_PPS_OVRD_SLICE_HEIGHT, &pps_param[0], 2);
-	if (ret < 0)
-		return ret;
-	ret = drm_dp_dpcd_write(aux, DP_PCON_HDMI_PPS_OVRD_SLICE_WIDTH, &pps_param[2], 2);
+	ret = drm_dp_dpcd_write_data(aux, DP_PCON_HDMI_PPS_OVRD_SLICE_HEIGHT, &pps_param[0], 2);
 	if (ret < 0)
 		return ret;
-	ret = drm_dp_dpcd_write(aux, DP_PCON_HDMI_PPS_OVRD_BPP, &pps_param[4], 2);
+	ret = drm_dp_dpcd_write_data(aux, DP_PCON_HDMI_PPS_OVRD_SLICE_WIDTH, &pps_param[2], 2);
 	if (ret < 0)
 		return ret;
-
-	ret = drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_EN_BUFFER);
+	ret = drm_dp_dpcd_write_data(aux, DP_PCON_HDMI_PPS_OVRD_BPP, &pps_param[4], 2);
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	return drm_dp_pcon_configure_dsc_enc(aux, DP_PCON_ENC_PPS_OVERRIDE_EN_BUFFER);
 }
 EXPORT_SYMBOL(drm_dp_pcon_pps_override_param);
 
@@ -3900,7 +3839,7 @@ int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc)
 	int ret;
 	u8 buf;
 
-	ret = drm_dp_dpcd_readb(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, &buf);
+	ret = drm_dp_dpcd_read_byte(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, &buf);
 	if (ret < 0)
 		return ret;
 
@@ -3909,11 +3848,7 @@ int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc)
 	else
 		buf &= ~DP_CONVERSION_RGB_YCBCR_MASK;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, buf);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return drm_dp_dpcd_write_byte(aux, DP_PROTOCOL_CONVERTER_CONTROL_2, buf);
 }
 EXPORT_SYMBOL(drm_dp_pcon_convert_rgb_to_ycbcr);
 
@@ -3945,12 +3880,12 @@ int drm_edp_backlight_set_level(struct drm_dp_aux *aux, const struct drm_edp_bac
 		buf[0] = level;
 	}
 
-	ret = drm_dp_dpcd_write(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, sizeof(buf));
-	if (ret != sizeof(buf)) {
+	ret = drm_dp_dpcd_write_data(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, sizeof(buf));
+	if (ret < 0) {
 		drm_err(aux->drm_dev,
 			"%s: Failed to write aux backlight level: %d\n",
 			aux->name, ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	return 0;
@@ -3968,22 +3903,22 @@ drm_edp_backlight_set_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
 	if (!bl->aux_enable)
 		return 0;
 
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &buf);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_DISPLAY_CONTROL_REGISTER, &buf);
+	if (ret < 0) {
 		drm_err(aux->drm_dev, "%s: Failed to read eDP display control register: %d\n",
 			aux->name, ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 	if (enable)
 		buf |= DP_EDP_BACKLIGHT_ENABLE;
 	else
 		buf &= ~DP_EDP_BACKLIGHT_ENABLE;
 
-	ret = drm_dp_dpcd_writeb(aux, DP_EDP_DISPLAY_CONTROL_REGISTER, buf);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_write_byte(aux, DP_EDP_DISPLAY_CONTROL_REGISTER, buf);
+	if (ret < 0) {
 		drm_err(aux->drm_dev, "%s: Failed to write eDP display control register: %d\n",
 			aux->name, ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	return 0;
@@ -4019,15 +3954,16 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
 		dpcd_buf = DP_EDP_BACKLIGHT_CONTROL_MODE_PWM;
 
 	if (bl->pwmgen_bit_count) {
-		ret = drm_dp_dpcd_writeb(aux, DP_EDP_PWMGEN_BIT_COUNT, bl->pwmgen_bit_count);
-		if (ret != 1)
+		ret = drm_dp_dpcd_write_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, bl->pwmgen_bit_count);
+		if (ret < 0)
 			drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux pwmgen bit count: %d\n",
 				    aux->name, ret);
 	}
 
 	if (bl->pwm_freq_pre_divider) {
-		ret = drm_dp_dpcd_writeb(aux, DP_EDP_BACKLIGHT_FREQ_SET, bl->pwm_freq_pre_divider);
-		if (ret != 1)
+		ret = drm_dp_dpcd_write_byte(aux, DP_EDP_BACKLIGHT_FREQ_SET,
+					     bl->pwm_freq_pre_divider);
+		if (ret < 0)
 			drm_dbg_kms(aux->drm_dev,
 				    "%s: Failed to write aux backlight frequency: %d\n",
 				    aux->name, ret);
@@ -4035,8 +3971,8 @@ int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backli
 			dpcd_buf |= DP_EDP_BACKLIGHT_FREQ_AUX_SET_ENABLE;
 	}
 
-	ret = drm_dp_dpcd_writeb(aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, dpcd_buf);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_write_byte(aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, dpcd_buf);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux backlight mode: %d\n",
 			    aux->name, ret);
 		return ret < 0 ? ret : -EIO;
@@ -4091,8 +4027,8 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 	if (!bl->aux_set)
 		return 0;
 
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT, &pn);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, &pn);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap: %d\n",
 			    aux->name, ret);
 		return -ENODEV;
@@ -4125,14 +4061,14 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 	 * - FxP is within 25% of desired value.
 	 *   Note: 25% is arbitrary value and may need some tweak.
 	 */
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
 			    aux->name, ret);
 		return 0;
 	}
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
 			    aux->name, ret);
 		return 0;
@@ -4157,8 +4093,8 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 			break;
 	}
 
-	ret = drm_dp_dpcd_writeb(aux, DP_EDP_PWMGEN_BIT_COUNT, pn);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_write_byte(aux, DP_EDP_PWMGEN_BIT_COUNT, pn);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to write aux pwmgen bit count: %d\n",
 			    aux->name, ret);
 		return 0;
@@ -4183,8 +4119,8 @@ drm_edp_backlight_probe_state(struct drm_dp_aux *aux, struct drm_edp_backlight_i
 	u8 buf[2];
 	u8 mode_reg;
 
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &mode_reg);
-	if (ret != 1) {
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER, &mode_reg);
+	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to read backlight mode: %d\n",
 			    aux->name, ret);
 		return ret < 0 ? ret : -EIO;
@@ -4197,11 +4133,11 @@ drm_edp_backlight_probe_state(struct drm_dp_aux *aux, struct drm_edp_backlight_i
 	if (*current_mode == DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD) {
 		int size = 1 + bl->lsb_reg_used;
 
-		ret = drm_dp_dpcd_read(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, size);
-		if (ret != size) {
+		ret = drm_dp_dpcd_read_data(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, size);
+		if (ret < 0) {
 			drm_dbg_kms(aux->drm_dev, "%s: Failed to read backlight level: %d\n",
 				    aux->name, ret);
-			return ret < 0 ? ret : -EIO;
+			return ret;
 		}
 
 		if (bl->lsb_reg_used)
@@ -4346,8 +4282,8 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
 	if (!panel || !panel->dev || !aux)
 		return -EINVAL;
 
-	ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
-			       EDP_DISPLAY_CTL_CAP_SIZE);
+	ret = drm_dp_dpcd_read_data(aux, DP_EDP_DPCD_REV, edp_dpcd,
+				    EDP_DISPLAY_CTL_CAP_SIZE);
 	if (ret < 0)
 		return ret;
 

-- 
2.39.5


