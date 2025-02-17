Return-Path: <linux-kernel+bounces-517294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F6A37EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B705D3AD866
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFD72163B9;
	Mon, 17 Feb 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhSF2S0m"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481B212B3A;
	Mon, 17 Feb 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786036; cv=none; b=S9scDuVO74uyu1STWe9ppvufgt+zWxdEa1qZpL0yOpAtkx/o5bJjd2zUkfBB1tP3UOocV+ep3My08/GhXBsld5fWleENuJOrZQ4IVAKaQVzRspJwU/x8twqVIuSibgOOuvH9Z8ALTDs8JwvWpY9efUYhjZRL/s9LB7GN80sm60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786036; c=relaxed/simple;
	bh=gQmGV+kn9fXoyJgSNZ5yNLGTOGnhxeIlafZzMM8kSJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiwxjN0FdlH2aZq5hZaC07qtDCf77JUDJkIcvSh0Cm9+h09z+yCKl+ycUkKvDBw3GPYUYW4MqkoxXhxfO+oBTke1jF6oqkfMoIhTDNjIVmOrgjLX7ZDtp2nkM1q511t9ZPBO7Yd9yNp6hdksfkheoUmNSsMXTT/NSnlpFsJx220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhSF2S0m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4396a24118dso26333625e9.0;
        Mon, 17 Feb 2025 01:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786033; x=1740390833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvYjEMSsQkQBSc5nAfPUda644OnnC5/ncK3yD6+VkrU=;
        b=HhSF2S0mVAa9ipjtJXVJ7g6OVjg/JFs48ycC8QTFuP+LRmHUYch2AjJdJOljvyLXoA
         keB7+LpExcJE4MAFeOQ3ZPF4Vl1CFlKqVhK/SmzBqkk0iieuGg2C740MhJn1XF1mJ8d0
         XTNagg5y9aro3T9B6dHfduVLjDN548ru+1s/7q4WX9pt/D8nh1NCd3cAce6vEumVyif1
         HEKpGjx7tYOUVxzJrWh7/VkAPPanrwbzamlIIrgYR4oEnAd/zpzK3njrWvGh6Wfrw+Z+
         JoRKx2FrAvQM16fs1eWT1VAhCb3GzsXulbIo68esBiFcbzj6hx+1EUm/CO3luVAOTwhe
         /wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786033; x=1740390833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvYjEMSsQkQBSc5nAfPUda644OnnC5/ncK3yD6+VkrU=;
        b=MJ+dB4qNmkHPRv0w2o0F3J1tV3jfXiTOaWAZ+PXHYqa/VXycmBXmQMmWZ1UuCORuI+
         6Fp8LhW3xjyCx+XismNcPnZgLBxOzH2dhOZwL1e/ZAdw/8n0+7PCAnLPjp/WS1wY2aw2
         7Xao0IR6nYqOkAWZuDwP4DDa30PkoUnGJZUeCN/B9ChM+d7cCvYOXitwEczREz+N1Kny
         BRyx0hBDBVPmzwADAc/tLGAAUUDSf1AQPSswCRpROHNEZs50k65vTnVei6K3SQXzKVJU
         eQsnKbtCz22OwXG4I+pAhwXtSsbzajBCmyR4fAg03I22tdeluwWOeUw+h/iM+y94Ywsg
         rpfg==
X-Forwarded-Encrypted: i=1; AJvYcCW07O9zzTlyQcIBV1Ibtr7ovXZaYJV/KaPZBerdF7fEwANqwNP+uQqS3EpxLmODZu6H9d1NFHOFZyfxG2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOhaJhxbag2xNkfjfuGSJ/O6E90g8k7e26v5T81LTjXhIcPC0
	al4aW4+Tx76cTGauPbJO2pTNDFS2oEHKHTbu+6D54RKBgOspqokh
X-Gm-Gg: ASbGncs3XFiBQztqlv8cuptXc1Osw1GsyYtFcxcz2OfhehmU8K+Lzn945r02WuuXXhJ
	qtHUrtzkLM4oceirAG21KEQ1+Cc/EhMTsAo49qaE3cGjxFCpjxD2hd4Pxya5ZN5UM4MCqShAxQs
	1etw2WLMS8iD6IuDM8xj3WjcHTS+urhvWqEGJ1SijS2t+l0DXEndPznFBQKeb+NwA35QthzY2xE
	/L8RE1Md9r6HTyNlaGomSVlde89aRtd9Am636VBNe4vdQUO2XQreab6mYzA7M3qEfB+961fkB+R
	oVoNou+uXSZs3162
X-Google-Smtp-Source: AGHT+IEVl4GpzgQ45gGVZiMJl31oCUggGlRZvE8AqWl93V+B3xcv35Ou1jGbrhoUWP+6dZJA3C4Onw==
X-Received: by 2002:a05:600c:5247:b0:439:5f38:7ca with SMTP id 5b1f17b1804b1-4396e70c718mr67407475e9.20.1739786033270;
        Mon, 17 Feb 2025 01:53:53 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43989087517sm13265865e9.8.2025.02.17.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:53:52 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jun Lei <jun.lei@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake "oustanding" -> "outstanding"
Date: Mon, 17 Feb 2025 09:53:25 +0000
Message-ID: <20250217095325.392152-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in max_oustanding_when_urgent_expected,
fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 87e53f59cb9f..243d02050e01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5058,7 +5058,7 @@ static void CalculateExtraLatency(
 	double HostVMInefficiencyFactorPrefetch,
 	unsigned int HostVMMinPageSize,
 	enum dml2_qos_param_type qos_type,
-	bool max_oustanding_when_urgent_expected,
+	bool max_outstanding_when_urgent_expected,
 	unsigned int max_outstanding_requests,
 	unsigned int request_size_bytes_luma[],
 	unsigned int request_size_bytes_chroma[],
@@ -5106,7 +5106,7 @@ static void CalculateExtraLatency(
 	if (qos_type == dml2_qos_param_type_dcn4x) {
 		*ExtraLatency_sr = dchub_arb_to_ret_delay / DCFCLK;
 		*ExtraLatency = *ExtraLatency_sr;
-		if (max_oustanding_when_urgent_expected)
+		if (max_outstanding_when_urgent_expected)
 			*ExtraLatency = *ExtraLatency + (ROBBufferSizeInKByte * 1024 - max_outstanding_requests * max_request_size_bytes) / ReturnBW;
 	} else {
 		*ExtraLatency_sr = dchub_arb_to_ret_delay / DCFCLK + RoundTripPingLatencyCycles / FabricClock + ReorderingBytes / ReturnBW;
@@ -5121,7 +5121,7 @@ static void CalculateExtraLatency(
 	dml2_printf("DML::%s: qos_type=%u\n", __func__, qos_type);
 	dml2_printf("DML::%s: hostvm_mode=%u\n", __func__, hostvm_mode);
 	dml2_printf("DML::%s: Tex_trips=%u\n", __func__, Tex_trips);
-	dml2_printf("DML::%s: max_oustanding_when_urgent_expected=%u\n", __func__, max_oustanding_when_urgent_expected);
+	dml2_printf("DML::%s: max_outstanding_when_urgent_expected=%u\n", __func__, max_outstanding_when_urgent_expected);
 	dml2_printf("DML::%s: FabricClock=%f\n", __func__, FabricClock);
 	dml2_printf("DML::%s: DCFCLK=%f\n", __func__, DCFCLK);
 	dml2_printf("DML::%s: ReturnBW=%f\n", __func__, ReturnBW);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index dfe54112a9c6..4e502f0a6d20 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1571,7 +1571,7 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	unsigned int *DSTYAfterScaler;
 	bool UnboundedRequestEnabled;
 	unsigned int CompressedBufferSizeInkByte;
-	bool max_oustanding_when_urgent_expected;
+	bool max_outstanding_when_urgent_expected;
 	unsigned int max_outstanding_requests;
 	unsigned int max_request_size_bytes;
 	unsigned int *meta_row_height_l;
-- 
2.47.2


