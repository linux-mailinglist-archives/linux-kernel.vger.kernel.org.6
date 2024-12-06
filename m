Return-Path: <linux-kernel+bounces-434348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69249E6553
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D9E188555D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FE19413C;
	Fri,  6 Dec 2024 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QFfIgl9H"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271B28FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458460; cv=none; b=S6cFshcJZUt8j0bEPNFJ4eMl0NT2PSSdjztuhgcztlZjOTiq5I27kp4kVn9dY90k/Fa/7t+z9/qbQvOTgo7UxiGdVLuy0H49/YtVULir9PL9MviuXT6kF3EEJ0k31bwhf+K9T6ka6RdqdJpLGr8fcL0OJdglDhZRWErhoBJycNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458460; c=relaxed/simple;
	bh=V7/lKkhMDAzPFuNdlkfXeN81gLMB4rzzuf0y3yjA3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnAu7Ii8S6k5908FLy+ZMJ7j+LqavNtoopTPY3DjaR+BflbZI8hPoDV98UP6hf+y23RxCEJdJlPnwYkuZWOsofYmwTOVdaFiWY2qXtU07BM+8FsUjD8euMxIf4JfuA121FRf+wfDi+CnliW5AJnSecj+i9uz1SAHBJcEVezbUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QFfIgl9H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21583eec308so2794995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458458; x=1734063258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=QFfIgl9HOrD3S8ikmjypLfL7GjnE8SsI42SfWKr1AfkSV8iKuaIDiN4BEcq4u1iXGz
         w4EwQBhVJbCHyS4NuXTORnjsEZBywhNOxtC7YFtwls9GrP09gPUyRz8LIp3kTMqFO5PT
         z/BykIR541RacDYbHq7USnONE/ngns1XfnzY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458458; x=1734063258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IU9gPKZ0cYpxiTpLI8JVzoAjrjZPxFqYWDg1qG91HQ=;
        b=oVSXABIWfg7kzx5q6QIefwCO6hKfp71bfxPZcS9kReFwxbhODHuaRzwMWL4YibV2CL
         RACtD4u0W+6htDX719/xYjKRaasQr1bZOdegHufk72Vajwet59v6W3urnhh4FZVG3P99
         DgyUb5mDNt2W/+HkSuJCuL6GYvHpCacQucaP/mhl/QQ4xrjN3Qld7i7B0ajKM7DDPKxJ
         RpNZYkvl9HAl6qqi9Rt3HaxjPJ15Usy6CBm/ahtTgGmrX3hi24qWKNx0hNkN+nF1V7FW
         f3lyw0VGLsd5RowWsep+24USDH9Ot5bRmY0BBgAab3HS0bHKg5KYjT4fdBQs7zMo115C
         haSw==
X-Forwarded-Encrypted: i=1; AJvYcCVilu1ywGHzcvDy/NvJDogLmqgxhlvhEAWaDVmCN7x3SMxTEZTIi9Gy0pDZ4dZpjUs0eVyHP9CbgOWYDxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTDLyCXmqD6j2pMVQcsnoIgoCgXP1roxPa9dFzaQo7lYvs8vu
	sMxfUzBz2jTwKVEyq/Vrr9REN0zUs9GAIO46d4MqWfsoiQ09ctOowjQJDhG5MQ==
X-Gm-Gg: ASbGncuaP/TZWUFstJbSyt0eCoRp2Kd5Lllpf5JiRHQDhjPQaTzvYPVkYqXB89XoDrA
	dCf6cuHsbVxL/olTLKggxo2bSJD0qYDuyeBvXYKiguE5q1An4N4Z35XXZphJKdJpc7IGUqJzzTZ
	VkoBPSEVjowDV7zcUJKr15rARyVR2wLZ9KzxvVwD2aZpoDXfCauwgg84wQXVusUxwYRQ7XiOiof
	R+8DEK0c5KI8iyPtirWFbQMlNkPrYx28U67cdc7ph75RH6MXm9/m1yAdtkk3InT+RSHSfWZXpEt
	+tyN8U0kGm1xGYo6XfO6Ig==
X-Google-Smtp-Source: AGHT+IGLQ1YPW/GMhrOQCuIQu21lc9n4+a2xgkTaktnhXR5veCtx5oSsXukViRHArRUmvP9dHaYNNg==
X-Received: by 2002:a17:902:e88f:b0:215:9a73:6c4f with SMTP id d9443c01a7336-21614d5365fmr7802885ad.6.1733458458137;
        Thu, 05 Dec 2024 20:14:18 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e8afsm20079925ad.18.2024.12.05.20.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:14:17 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	dillon.varone@amd.com,
	hersenxs.wu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Fri,  6 Dec 2024 04:14:14 +0000
Message-Id: <20241206041414.4013356-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]

BIOS images may fail to load and null checks are added before they are
used.

This fixes 6 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a..0f686e363 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -664,6 +664,9 @@ static enum bp_result get_ss_info_v3_1(
 
 	ss_table_header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!ss_table_header_include)
+		return BP_RESULT_UNSUPPORTED;
+
 	table_size =
 		(le16_to_cpu(ss_table_header_include->sHeader.usStructureSize)
 				- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1031,6 +1034,8 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 
 	header = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 		DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header)
+		return result;
 
 	memset(info, 0, sizeof(struct spread_spectrum_info));
 
@@ -1104,6 +1109,8 @@ static enum bp_result get_ss_info_from_ss_info_table(
 	get_atom_data_table_revision(header, &revision);
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO, DATA_TABLES(SS_Info));
+	if (!tbl)
+		return result;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return result;
@@ -1631,6 +1638,8 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 
 	tbl = GET_IMAGE(ATOM_SPREAD_SPECTRUM_INFO,
 			DATA_TABLES(SS_Info));
+	if (!tbl)
+		return number;
 
 	if (1 != revision.major || 2 > revision.minor)
 		return number;
@@ -1711,6 +1720,8 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V2,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return 0;
 
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize)
 			- sizeof(ATOM_COMMON_TABLE_HEADER))
@@ -1748,6 +1759,9 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_V3_1(
 
 	header_include = GET_IMAGE(ATOM_ASIC_INTERNAL_SS_INFO_V3,
 			DATA_TABLES(ASIC_InternalSS_Info));
+	if (!header_include)
+		return number;
+
 	size = (le16_to_cpu(header_include->sHeader.usStructureSize) -
 			sizeof(ATOM_COMMON_TABLE_HEADER)) /
 					sizeof(ATOM_ASIC_SS_ASSIGNMENT_V3);
-- 
2.39.4


