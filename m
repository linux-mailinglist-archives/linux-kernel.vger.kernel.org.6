Return-Path: <linux-kernel+bounces-242260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C104F92856E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC86B213D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A40146015;
	Fri,  5 Jul 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZjiJKBI"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF262143759
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172968; cv=none; b=fiC6Juh+IM5LIUiRxc5e/7hGiyTnIdests+OtKud5CP7P3fLWvlcLn+RQPUxW7uSWSina3e3Qcgl6H7BuSLGlk6pZsFVL5v2nyAh1gmmb4hScpFk1Ln3SAQdTz8OYiIdiHk2TsLpHZHw/1OMDuZlntWYHjknUkZQFm9sJ4y3s1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172968; c=relaxed/simple;
	bh=FV7Hb3Zi3h+YeAbjXib05YhdBZnagBJwJlVNV3BIqiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJJcNF71CKFqsYGSvLlYLB3N4MWEQYdL8rH8dGBeUPT1V+uq3tWGzegoIq7np9cT3KrBnNlwWpfTOuvFcoUGVEXI4fFasptEtj3iVgh/EKUC6Sq4gdVM9j296RXaPTEc/Y6JUjQPVPbpbITiy0RmPl/H4UoE75xmn9aHkJbTeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZjiJKBI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d561d685e7so936770b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172966; x=1720777766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
        b=AZjiJKBI/zHC6WyFM9ocaThVuVR9glwZYusWfwe1VNJZ+rEhKKj3BMILti8uta/q65
         CV+ft+mKg4msiROeqbPYDmct8NRlnF8KM/Mx2uxqZ+gFhEx4c+IXRvJ/GZ1WmrF391ld
         yOY1J2THJD8vSFs+/58Zdf3KytUV5I/+e/vlEKQUaPjeLwDrDeu4TUXff5r0+hPBNIa9
         CwpQKM+H7ftftxEJxYTL3lwK4XJ6RX3Ejzd2kw+i9vQa699PrhR7lqYdi8CsKs3L6aeq
         rAlZU5zrqZuG2ngzUPyegri9m41N0gpxMyT+cqHhbLolAK3Kxdf0SH6izoNP4qRnPI6V
         e1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172966; x=1720777766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
        b=v/PM+hWwZDPNtaie0TCd4F+RHDLRLKvVawISkGDtYN1J9XbWgMEWN5VzwlYY6kfyuz
         dkOWd0ouwTbkX5AqROcRV+t7/DE2IdE5HA7yFQvrCIypPPr6++Qiwpk7Ix+w83WCTAaD
         6qFhjbEzYQ0sF2atF0J/PJ6jOWimCH+lVLxZ3Pau8yeY15yn+uF7WEnSUIFZRO3wuQRP
         aRlYb6DzzDpprd5sDdJ+NtFqqkmbdkYSlbb8A6oO/aePSrvB9djck3rwi9KHn2a2Dy8e
         u+cbTybds8nefc+H9ZxZMTV6AnXJOCQXSWN1sgGxXsHGyMbUbYP/pTgabqGCURKcN6pG
         ijhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpK9eID5FqNl/2hw8KMWY8rCt6daTwfBUNY0GWilKqGQmnD4XWwhwD1w36QNbSZ1bWrfLgtpCFPlnI3OKI7WlLzm+rNPUSyZJbsRcK
X-Gm-Message-State: AOJu0YwOoa1C/FNWIUvMD9pkjEtarNCN6ZiiQmhzT5Ysby6M/d8axICt
	gPizPv5ZQ9gFw6mhGQDv14FDxzOT5V2kYQCQ68GaAwy9QulAJvNbCWl4ZWziNzQ=
X-Google-Smtp-Source: AGHT+IFN9rzfbXK0Hc+NZ/fUS4V4FYR9VVi4H2M9XrZqKKDeZJ2LhGYv5DE6m7N7j5k2QDzd/2OZ3w==
X-Received: by 2002:a05:6808:1902:b0:3d6:2bb8:82ab with SMTP id 5614622812f47-3d914da9af7mr5291414b6e.36.1720172965642;
        Fri, 05 Jul 2024 02:49:25 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1cd7:818f:d731:f6bd:8194:7763])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b143b9409sm107313b3a.124.2024.07.05.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:49:25 -0700 (PDT)
From: Akshay Behl <akshaybehl231@gmail.com>
To: 
Cc: Akshay Behl <akshaybehl231@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Docs improvement in /dc/inc/hw/mpc.h
Date: Fri,  5 Jul 2024 15:18:58 +0530
Message-Id: <20240705094857.352270-1-akshaybehl231@gmail.com>
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

- After making the required changes

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


