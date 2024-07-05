Return-Path: <linux-kernel+bounces-242256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38185928565
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23FB282D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E71D14883F;
	Fri,  5 Jul 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHeZThlS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A421474C9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172701; cv=none; b=uNMl5yO8wb6bxsBB5nhaN7WWaZ90DuACMug8498mJOKCYC0OSVgj2mfLP3JrgMV0U0msJ1yc/XOlQDKC58HpzAgWIHaNaIAySs7zYBg5mnElF5EAwJViLvSNqPJbyEgBeC27lVtn8NDeNFxYFIYxTVCU4N2yxPgl68PsKWMTvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172701; c=relaxed/simple;
	bh=FV7Hb3Zi3h+YeAbjXib05YhdBZnagBJwJlVNV3BIqiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbly0lWFjnQzX6wdd0A6h0n2Eurb2r5nZl9qaHwChzQ3aggkx+0vnPy4G4jr7a/TT0qs0FNlqfPBJ5rr+hmZLHML+5uBRzTrXrbqjrkKOTPyxOOilhIj4dDmcszWVUsNRnOWlNO8vUMVYdQ/wETXmgGw5wJIYyz8xDraVXcBXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHeZThlS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb1c918860so16530715ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172699; x=1720777499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
        b=JHeZThlSV8cMnK5zFVObYZSs+MiJuyJrLb0RxHLXOMICY4aW7GiGpMt6eXmRA4FUsK
         p3flrgTCY2vanIl6UWJIVwR5+3tY+8v05kBe1KB3EzKVa8PACPq70/l7IELjjRCPMgQT
         sCmWbkVMONJPc5qFrSPMGWsoxleoLedrRjkTvJbqDxzgDFm9Yz0ueVUQb75hoQ5VLRKe
         3jdiAJkwFJAB0tIZe7nixsHsdunfof2MJzQYratT/uYZg8Pewss2Lp+3VVKhlVSEFXd4
         Z/rYgDvK5KZIlzBJW1qTwExRkr7LwyGIO0qMFCTGBY3pi7KEmVA9v0CvI82ofjphPtAR
         msPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172699; x=1720777499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbMZKC8DIqM8ieSD0r5HNg9/jzslem7r4bfvqOdWMpA=;
        b=QgB0jLG2sIBk5p0y9QPhgai21bfN13122oJ0NpqA0aWUJugzo8L6pl8XRYzBdWpiSv
         2Ddmn1xSfMGOSk/oz9C0sSJYeqO8ZNtWdx/Us7BVdUSjEs4xm8+CtIMCjOy483ltnIgL
         98pe+jInaV1Hzj79IuwsCWOQuJQQHADWC/s6N8N9iEk5CRx2RODdVObHCuDgbVtCBmAA
         PtY4uNBPFnUwCZkCaEjck+jqva+XJeWNWtkn12gq5OChgHIHgHOAL27RUhIRNuXIUwVX
         Hme4I7s/ROw7QSltVxzutidapdO0ZYpnhwS9RbJ2yWlzRCikc8oYQdcr4CwzZezqPutu
         tJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD56dnNLOkHqXJ8lZPiDOWCfvrEmzDNy+PIjgHd1+9x71NaW0MJCO3nWCKvJuBayDGxzSltq5pt+fVv5qGmprqqBelwLTAMePaZW73
X-Gm-Message-State: AOJu0Yy0qv5mSQYzqq8hAMeCXL7eoEZzOGCTW4+2QwAAODEJvEfwyAM8
	SEAPLMysbAB3r4eB1OnyxJDocHx2fef3dyP+j9svMqEzQmcq/NqGN0CVt/RtiGc=
X-Google-Smtp-Source: AGHT+IFIOsO9JRujFXsVZsOxpIb8GSdE6GdOogexRlOCDz74s6RB/DEiJp4bpjlHZiMAjnGmY8T55Q==
X-Received: by 2002:a17:902:ce8a:b0:1fb:3263:2e60 with SMTP id d9443c01a7336-1fb37046126mr53036475ad.13.1720172698820;
        Fri, 05 Jul 2024 02:44:58 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1cd7:818f:d731:f6bd:8194:7763])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256df35sm13570682b3a.64.2024.07.05.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:44:58 -0700 (PDT)
From: Akshay Behl <akshaybehl231@gmail.com>
To: 
Cc: Akshay Behl <akshaybehl231@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Docs improvement in /dc/inc/hw/mpc.h
Date: Fri,  5 Jul 2024 15:13:44 +0530
Message-Id: <20240705094342.351894-1-akshaybehl231@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e17781fa-438d-4806-ae45-eb1239759f43@amd.com>
References: <e17781fa-438d-4806-ae45-eb1239759f43@amd.com>
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


