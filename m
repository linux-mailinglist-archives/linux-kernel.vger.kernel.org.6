Return-Path: <linux-kernel+bounces-251027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FD392FFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8FFB223AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE83176AD7;
	Fri, 12 Jul 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7eTcqJc"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667D2747D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806342; cv=none; b=G8fzCghhumm8T0lJfvHC4RplfeNCxoU+qVoACjRDQVhJVEfmZYZzNaYhGUmlawNCEwqIuTkljceJGexxVTphccnnlvb+0B4tzfZ/cQg47EZXVzgRXMxqL7QuXyNkSUAV9aRAsgERoiFOP6p07Un0fqX/CdwBt45I0DEearzrwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806342; c=relaxed/simple;
	bh=X13h60Czwbm2ujyxIP806a+AW/lW7IB0AqcSBAamTB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8fGX0Hd9fPOgCdZ5fhNpBFLyFjLMhsldOCi+KtODToeVsZOGq+OE19RWlnbqcLM4xNtgJLiYhdsKONWLhSVX88KhG6PDap2wO0cVdBBg/CeowMIIL6VGWrSrv82Zm29heuco4Yk4qW+1umsWHaZch8762zymbUlfqGSkAG4VO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7eTcqJc; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c66b53232aso1060420eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720806340; x=1721411140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNXQMXtVVY9UI6zu3BBCUXELAve7Ltcp0DjuWc3krBw=;
        b=V7eTcqJcSh5lrOvaKkDcybVRfsWTMArITu+BYJgwKi7wmGwZAjBhPPbJ2SLdNmj0+1
         tvpo+gPS1Q8CHgje0/iLZS+RgWgplC04oyEBCDmNR4MB62Zxz7PY52SrLinXgb3fkiT8
         wkvCTImCgNZg3UxNkA05zMDV05KPMImqK66p9XNEOC1AkoiyB6s8TRUbkleLcajnXq9U
         EXxbWVnUrGXWmgPAB5nC3xvY/rl80u6amE+b6jJZSP0cUSQxjNigaybbPXDEUDHG4Wp9
         K4Kcg97SHTnwtWMtJ5PiDdVZcQfgDS/88hu8bSY51KqA/y0MZS0Qfb9LmaVrLKxjd/gM
         Lc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720806340; x=1721411140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNXQMXtVVY9UI6zu3BBCUXELAve7Ltcp0DjuWc3krBw=;
        b=X8mDaeV+lKF3u/M8ZQgRqB43WdtGN6MBCnv0/Z/ejWeoQ5/qpRM0D6IVc3h0caJr22
         Azb/Rq3gepANOcU3ckMS4j/RCi/XrFroSYIlFaXPFCwukmXMSqA/9V3TXBPZ1Jgs1LrY
         Rl7HuVNioA16SfGA01hBqF9YwFoWpo7o+n0d2LsESk4xk8yMFaazNbF+/PDKwAcsyAoa
         xj50+TkhHsu7aN0Sp+fOTMK34YNkAix57/624wT68iC+T+31kmqAlcUwurinwHY2xI8V
         p8AjYGc9DstVNRaqtjGcPfgZ52HO9IvdwXQzgiCEintZBBHP8wA1e7hR3CWgmQj98qJY
         OfQg==
X-Forwarded-Encrypted: i=1; AJvYcCWqPbZ1aTlOg2fNwJlPaIWwdo4FQjFwxGEeUhP45wFa6rUQjweLnrGauk8yKTEZw3cUiLNerhH603qKkxKd2hGuXyCnBN0BacBGW+Az
X-Gm-Message-State: AOJu0Yx2KUlt0Mc4aVF+yhvKmVmA1ErQf8z8hEWcvWrYsqeAqjaUNTnO
	bV6aPnG+EDpA310xTICmUrrv3TXgS4xc8vP8PrAxq0Gg5CM9AWvd3V2CnYYY
X-Google-Smtp-Source: AGHT+IF9PKjomOSMUJmoLDlemBt+PLgMux6m5VCf86phTvzU1z2v2Giz3TyPGWhJB2bd25AAHSvm3Q==
X-Received: by 2002:a05:6359:5d25:b0:1aa:c73d:5a83 with SMTP id e5c5f4694b2df-1aade04191amr928556155d.1.1720806340226;
        Fri, 12 Jul 2024 10:45:40 -0700 (PDT)
Received: from embed-PC.. ([122.183.46.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d669d5282sm5097810a12.67.2024.07.12.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:45:39 -0700 (PDT)
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
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drm: Fix documentation warning for read_mpcc_state in mpc.h
Date: Fri, 12 Jul 2024 23:15:10 +0530
Message-Id: <20240712174510.70467-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detail description for the read_mpcc_state function in the
mpc_funcs struct to resolve the documentation warning.

A kernel-doc warning was addressed:
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning:
Function parameter or struct member 'read_mpcc_state' not
described in 'mpc_funcs'.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 34a398f23fc6..9e65ecf1d3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -282,6 +282,22 @@ struct mpcc_state {
  * struct mpc_funcs - funcs
  */
 struct mpc_funcs {
+	/**
+	 * @read_mpcc_state:
+	 *
+	 * Reads the state of a given MPCC instance.
+	 *
+	 * Parameters:
+	 *
+	 * - [in/out] mpc - MPC context.
+	 * - [in] mpcc_inst - MPCC Instance whose state is to be read.
+	 * - [out] mpcc_state - MPCC state structure where the state
+	 *                    of the MPCC instance will be stored.
+	 *
+	 * Return:
+	 *
+	 * void
+	 */
 	void (*read_mpcc_state)(
 			struct mpc *mpc,
 			int mpcc_inst,
-- 
2.34.1


