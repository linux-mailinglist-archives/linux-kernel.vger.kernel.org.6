Return-Path: <linux-kernel+bounces-242292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A693928649
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA81B21724
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA9144D0F;
	Fri,  5 Jul 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw15iaPA"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DE13A252
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173764; cv=none; b=Uu1H5QlhyqZZybg4bBXg4j+s88lMRQG3cpm8hG3iaFdYNhYEfFuk5OfwIwDzpGSe5T8W96BJFM6a56ReGOxl8fS1S0oViMjEk7fES7MizE3UVEsp8pwhTYN2LlxXT77MLrW98ZkjsjMIuPke3EBvSpv3YvwcfyWEScKymB9a9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173764; c=relaxed/simple;
	bh=VpEC18WUS2pi0rbhY63paAhDgl3ajWS7nUpdMUcN5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1hQF0LnB4XZ81sI4gQ9wIG3h/RYlOnjbsovAe0n9KPdbz+a7803h7RfSApF1dTrE+2xVIhpvQpWSLpxs4WsDTOOUsUnWI+JJABgNsi3JisVAmSBTvamjsGd8zHMtCOmHpDDa1BRxhh8fTMD0nXXxqgeH7qzS2J0CPKizYGz74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw15iaPA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af81e8439so1150734b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720173763; x=1720778563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueZlpVq6cMGd2O6TPcbGvjQRFl2p51IxcfO3kFZ+XLY=;
        b=mw15iaPA9g7ch1C2jBPaGKIALZag5FR8vYq2HVysmCsCGVi0fawZHj8bg5ggm0FI9j
         OwGHBSvkaeHIRgZF+/ScqeAg+mhHmWLBqzejbWy5ItzAIOveDtJJ8Ed4p79QRtxzx3mf
         wF5zrPdxtdKZWRo8+E3wzHL06DMYJM+2yMSK4e3Jccu4opcwtQnKuNYGH0wNzs2qVsNm
         dd868SWn8HOujCB/d1APdrhTgNp/NVeEXPuNmMH61Twkmoq7OO/AqVMwnmsR3kNzMpzu
         m/VsACAoqffyyQTmxvX5A4lNFQ8pz00z9J2ny6XQ9aY5GE0y9xyEEpGY4JPmxhGgcHTJ
         NW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720173763; x=1720778563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueZlpVq6cMGd2O6TPcbGvjQRFl2p51IxcfO3kFZ+XLY=;
        b=dnYhuEXJPHViGfHL+oA3bK5tnSsCs0XImcgntIvS3zn9BjP23TWqROkntviAO2XE8P
         Jwio8LHrdMXotrVBLDRR6BcRiji8Yoc3vyfB/k4/Z7FZQHWUyAnhvYaoQJf9DTIeqaTw
         o1RRKsIiAGWQWoG94X7rmFZyRtePFOLZ4J0hVf6UKW2ZIsU7h/dogZYGQRZ01t3eU0Fo
         S+8NPspb4fNDOVd1sfpY+MNvzrVTyewRPgf4EiNypIq/D5/kvEG4jVfmdxiNpGIEhD/o
         VOR5HyUN2lwfWQjzuZyVvopeWPwkRX/6oR7htn+bFV7+g698Tdi5G9oclJ2cGunExIqP
         4WFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwLKkA6gwql/T5qWA9tACuaDlvoI1YC30TlxmaxVseR2ZS9NuHYxKZm7xEZ8TFBNXensbl71jA/IgEYAhykVbLSPMhZdsK6lDdMV1P
X-Gm-Message-State: AOJu0Yy9/stl017+uayxLBKRnN7Qly9V+0fSskPJK3OljapjSHZrmHxw
	vCht9dzKI44bU/Rl7KQSwLewnoPT4kibxivjDhPThpIj/Tqh2R4q
X-Google-Smtp-Source: AGHT+IGth6g00ULdqwjQ5OsB/b6tcPIphe8A+dcZteytrm1KA6ipJ415LiZeDcSQljJ2azzErnFegA==
X-Received: by 2002:a05:6a00:846:b0:705:b0aa:a6bf with SMTP id d2e1a72fcca58-70b00914f13mr4569613b3a.2.1720173762453;
        Fri, 05 Jul 2024 03:02:42 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1cd7:818f:d731:f6bd:8194:7763])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804c835absm13623750b3a.220.2024.07.05.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:02:42 -0700 (PDT)
From: Akshay Behl <akshaybehl231@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch
Cc: Akshay Behl <akshaybehl231@gmail.com>,
	Xinhui.Pan@amd.com,
	Rodrigo.Siqueira@amd.com,
	sunpeng.li@amd.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Docs improvement in /dc/inc/hw/mpc.h
Date: Fri,  5 Jul 2024 15:31:26 +0530
Message-Id: <20240705100125.353231-1-akshaybehl231@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704092039.31264-1-akshaybehl231@gmail.com>
References: <20240704092039.31264-1-akshaybehl231@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After making the required changes

This patch fixes some of the warnings while building kernel Docs:
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'read_mpcc_state' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'mpc_init_single_inst' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'get_mpcc_for_dpp_from_secondary' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'get_mpcc_for_dpp' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'wait_for_idle' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function parameter or struct member 'assert_mpcc_idle_before_connect' not described in 'mpc_funcs'

by adding descriptions to these struct members

Signed-off-by: Akshay Behl <akshaybehl231@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 84 ++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 34a398f23fc6..d2bea0a9699d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -282,6 +282,21 @@ struct mpcc_state {
  * struct mpc_funcs - funcs
  */
 struct mpc_funcs {
+	/**
+	 * @read_mpcc_state:
+	 *
+	 * Read current state of a specified MPCC instance
+	 *
+	 * Parameters:
+	 *
+	 * - [in/out] mpc  - MPC context.
+	 * - [in] mpcc_inst - integer representing specific MPC instance
+	 * - [in/out] mpcc_state - MPCC state struct where read information will be stored
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*read_mpcc_state)(
 			struct mpc *mpc,
 			int mpcc_inst,
@@ -352,6 +367,21 @@ struct mpc_funcs {
 	 * void
 	 */
 	void (*mpc_init)(struct mpc *mpc);
+
+	/**
+	 * @mpc_init_single_inst:
+	 *
+	 * Reset the MPCC HW status of a single MPCC physical instance.
+	 *
+	 * Parameters:
+	 *
+	 * - [in/out] mpc - MPC context.
+	 * - [in] mpcc_id - The MPCC physical instance to use for blending.
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*mpc_init_single_inst)(
 			struct mpc *mpc,
 			unsigned int mpcc_id);
@@ -448,17 +478,69 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			struct mpc_tree *tree,
 			struct mpcc *mpcc);
-
+	/**
+	 * @get_mpcc_for_dpp_from_secondary:
+	 *
+	 * Retrieve a specified MPCC struct from the 'secondary' MPC tree using the provided DPP id.
+	 *
+	 * Parameters:
+	 * - [in/out] tree - MPC tree structure that will be searched.
+	 * - [in]     dpp_id - DPP input for the MPCC.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that matched the input params
+	 */
 	struct mpcc* (*get_mpcc_for_dpp_from_secondary)(
 			struct mpc_tree *tree,
 			int dpp_id);
 
+	/**
+	 * @get_mpcc_for_dpp:
+	 *
+	 * Retrieve a specified MPCC struct from the MPC tree using the provided DPP id.
+	 *
+	 * Parameters:
+	 * - [in/out] tree - MPC tree structure that will be searched.
+	 * - [in]     dpp_id - DPP input for the MPCC.
+	 *
+	 * Return:
+	 *
+	 * struct mpcc* - MPCC that matched the input params
+	 */
+
 	struct mpcc* (*get_mpcc_for_dpp)(
 			struct mpc_tree *tree,
 			int dpp_id);
 
+	/**
+	 * @wait_for_idle:
+	 *
+	 * Wait for a specific MPCC instance to become idle
+	 *
+	 * Parameters:
+	 * - [in/out] mpc  - MPC context.
+	 * - [in]     id - ID of the MPCC instance to wait for
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*wait_for_idle)(struct mpc *mpc, int id);
 
+	/**
+	 * @assert_mpcc_idle_before_connect:
+	 *
+	 * Assert that the specific MPCC instance is ideal before attempting to connect.
+	 *
+	 * Parameters:
+	 * - [in/out] mpc  - MPC context.
+	 * - [in]     mpcc_id - ID of the MPCC instance to check for
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*assert_mpcc_idle_before_connect)(struct mpc *mpc, int mpcc_id);
 
 	void (*init_mpcc_list_from_hw)(
-- 
2.34.1


