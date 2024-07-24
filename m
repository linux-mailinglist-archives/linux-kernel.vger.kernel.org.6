Return-Path: <linux-kernel+bounces-261353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F374C93B631
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64441F21E18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FE15ECCA;
	Wed, 24 Jul 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbYvokOO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987F2E639
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843677; cv=none; b=A6zQpDG5EXZLh1mZfCr1lgxI0/X7gJSU7L1eLckmssvj/tabgPX22e4xcOttHYP3pGnzVyzJqhRaFkBxh7+3b2i9bGOkbeAIzUnnajYS8JMm391OcJg862UGxduCd8spGtKL6D4fRfkB2CJaPbf9KOkDUzufzD1Uv2w7aqtJ2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843677; c=relaxed/simple;
	bh=/IWh2c/iGDcV85EwzBtLMmaINhmCLqhakPkzcvy5woE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uylSmSMer/qPnfTl1tqKlvr2PoMgvEf1x+Y9jIOLGN9UCCIT1YeMPwVITk8HJ+iidBnbrHjFaPcG6WEruYb3U2V22yS5mfoQmJvffqf23FxsQxsIjQVFHInM0OrBBcN/WJVXvsrlRHpRPSIeyU04z+zi8RYnU6/pX9y6J41V4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbYvokOO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd9e6189d5so302185ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721843676; x=1722448476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeMvaTqF6nVC8+TTPXCBAeC27R72xrtkyB8OCewfWY4=;
        b=EbYvokOOcq/Ax6C3uJzEi2L+ABIZSGfiGPhZM45arXG/P2g5huTz/5EkDtZb4APdN9
         tqQw46Z7LgharDBmAGGc6Pajm//UR6xSd0lAc8oq6Iz/+26ur2H/WppSXCC4Y1WLjzkT
         ZG653nJyARdpyi6lmKb3dkcXHqHyj7/T/8w4OCrLz9//r79S57V5fOhoBkBQsqbUeHUD
         tixkg4MJiPXNHVcmb7SOhrSqQ7Tbzm97cE5J4t/9z76HnkMoF0gFdKifHkcwuWRH3rLr
         UR3aNJt7bApjf6bynuVY2/zqLEAnOWugpsOzEo00TMQB/u34yD6hGcdeBLcuD2FbNjh2
         Jh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843676; x=1722448476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeMvaTqF6nVC8+TTPXCBAeC27R72xrtkyB8OCewfWY4=;
        b=IJB0y9HCowl0qvTAyxK0avtYw0+h6Jx6tkLepZaEzL4nSq6+4EqOpAbzI5ZpB6V59b
         zF2QaFX+kpc094AMuw5dbBlfPHdSR/CZ+ru/JlSSJIChC+2L2FpmgGn4UB11YwDh6Bk6
         bcymvxPSQhMsNrS8VajqaDXP4y0/Vu6T9sqmWC5BMUtfO7J9Zk7YY2neyrwB8VAW6yut
         Sn8ciAuj4YwMvLCJZ3xXpE7hvKkwy4/d5ii4cVXTg+H6AzA/kJJ57/spHgt55Q6/ZL8Z
         dseNYsyWtP/Z5Du/h+wTgfsTwsngO3exLp7PZk1okx017mGa0EBJywGT4D3ntzMMVkc9
         nFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXu9CAmotPjHih7ZSy7ANzlsw9e/j00YdQ37aW2H7yGyI4qmzfwbY6ENbdMyxvMkxLZ07aq1bv/E2RGUYN2cXYDlsHLsHw5pDd2MZB
X-Gm-Message-State: AOJu0Yy701iIcP7ZHSW8DbHbBTrNBKXD4FlxHciNJaqrfz9SEudnyLrO
	2wNW1JxfPdbwhLcWEIEKXL0hVYd8wUohGtQUaWm8BruAF3QE/sG4
X-Google-Smtp-Source: AGHT+IFUycfF2BPrsXjk1R8U+2PiWCnVeWgqd/XGw1a2IyeonzKrWsGYZ9XXWG1J32fNw6Xkf6/3Sg==
X-Received: by 2002:a17:902:e812:b0:1fd:69d6:856d with SMTP id d9443c01a7336-1fed38607cemr4234205ad.17.1721843674654;
        Wed, 24 Jul 2024 10:54:34 -0700 (PDT)
Received: from embed-PC.. ([122.161.119.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25ac88sm97165815ad.6.2024.07.24.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:54:34 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: airlied@gmail.com,
	daniel@ffwll.ch,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	marcelomspessoto@gmail.com,
	aurabindo.pillai@amd.com,
	adnelson@amd.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drm/amd/display: Fix documentation warning for mpc.h
Date: Wed, 24 Jul 2024 23:24:23 +0530
Message-Id: <20240724175423.18075-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix documentation compile warning by adding description
for program_3dlut_size function.

Remove the following warning:
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1043: warning: Function parameter or struct member 'program_3dlut_size' not described in 'mpc_funcs'

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 40a9b3471208..615c69d966e7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1039,7 +1039,21 @@ struct mpc_funcs {
 	*/
 	void (*program_lut_mode)(struct mpc *mpc, const enum MCM_LUT_ID id, const enum MCM_LUT_XABLE xable,
 			bool lut_bank_a, int mpcc_id);
-	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
+	/**
+	 * @program_3dlut_size:
+	 *
+	 * Program 3D LUT size.
+	 *
+	 * Parameters:
+	 * - [in/out] mpc - MPC context.
+	 * - [in] is_17x17x17 - Boolean Flag.
+	 * - [in] mpcc_id - MPCC physical instance.
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
+	 void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
 };
 
 #endif
-- 
2.34.1


