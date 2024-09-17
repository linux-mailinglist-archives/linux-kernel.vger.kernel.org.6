Return-Path: <linux-kernel+bounces-331925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4897B306
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1223283F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4D17ADFF;
	Tue, 17 Sep 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHyPLxAa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFD171E76
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590715; cv=none; b=ltg92c4AX2v2DfmluoxRL99pAzIPtWL6HeQM4Krad3t9qHFRDJWe+ha78Hs2ziKrKGDpAaDrijLW9lkPM0oot1tRI0YomctYIFwsU4lSrDnH1g5ZbxbLP4AC3XETSW3BNsaph7Rkv2TixAbORjYL5D5mqL9CJIGC6d2op+Q7+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590715; c=relaxed/simple;
	bh=jAlOApURL8jPGkv6G7ZA01RQ2aCB/uJHybI/+QzFiyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iX5UTMCE3IvjDHewOR5Fp4yPPoR6xZs3dkFjjzR3o6w8FQK7vEit3AVfjMbFN8g1lgZXBlTS5JB6ktodBJtwoTzOKwbBJ1i1t0TkqBX4fpkSdcT+o+CPjYcZ84Nc2g+o3RismTGc3ABHHcqA/zQ4Ql7d5aL9dqABKgMb6gUOyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHyPLxAa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2055f630934so49669815ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726590713; x=1727195513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d27QiDpZTEWMptlUUQTdMGUQ8QM0KhEAFxduxL82zGo=;
        b=kHyPLxAaWxUHON2zAc16fkjJd9FpGH5GurfOHsvITLlXwuVtRyXycIBjMCtHb4TQQK
         B93MAtFjva6FlugKBu2BXHT5A03Xsz1XIM/uXEMnoaHEVJvr5SOANkWTDSSgZojidptC
         PAgXPgTQ5Ntw9JeNsv+tmwrfDXOhSms3V19MXiMSF6eKkK1w/w8EttTBx171T6k9mP+f
         ixnBa4bxSCeNW9oZ6zNFbNvnDSk9EKsju7OhxSXHGXZS44VtaIzUT624wZArgmYGPknU
         mqmaBvWixsghRoQRiAAD26QcZRzGDe9kNRpFvmWyW6SKJU11HKh/5Rzbm+XxpNnaWp3p
         HdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726590713; x=1727195513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d27QiDpZTEWMptlUUQTdMGUQ8QM0KhEAFxduxL82zGo=;
        b=Zn4e9EuzlfaQNkaj1ohaGR2DBVwLmp8IAHT4GxFYRD9JB3Mr9qMMIcDSI5v3nLk7bs
         TCPAYTXRlELxP93Y3qav+WR7W8c1aTZ6U9n0SIHYE1pZa197IYEtYvRcPuegcXbWD6Hv
         nuk5lT0lUSrMj09xRCBhx+OM8szSuqcdLLQ4kiyzJLsmm/lso3q79avs1NhDrKybh2ln
         ospAv8ZEtJbiRsPe8dNJ8uPvccctsq+aPwKLPBDvTk6w8t1hFX8bx4YoLlTg29zNLpII
         Pa/++NW61Y0LollIvj6COEOBkJ9elesUKiUAPfA/tAMu0wpf/ptMogIMuJBDVmDIxSfv
         zXPA==
X-Forwarded-Encrypted: i=1; AJvYcCU8euJb5ZZwLoywuSexItob1tV3kcrg2VlTetOwOgIkdqLfLEJBJRp2ebgbYdICfLvctmd9++RmoOUOf1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdxj1yaLkF4U+Vb1ofJ49KdJ/YB+0+S8fFZicjmAQaSGNz0Ba
	blb66FAGMQzyzk0kZIUcisDmYJtcsiST6gPoHxtY5/W1W0gXapXltAbcjFQn
X-Google-Smtp-Source: AGHT+IFFlrNfeYfMhMuiPypYqGCnUQvsDDZj3HK01mH9YI++IePCMwELFaevFE/102AniKVZ+sAUMw==
X-Received: by 2002:a17:902:d509:b0:202:28b1:9f34 with SMTP id d9443c01a7336-2076e41cbcamr299882855ad.56.1726590713151;
        Tue, 17 Sep 2024 09:31:53 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946dec8bsm51854065ad.163.2024.09.17.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:31:52 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] drm/amd/display: Fix unnecessary cast warnings from checkpatch
Date: Tue, 17 Sep 2024 22:01:19 +0530
Message-Id: <20240917163119.890276-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses warnings produced by the checkpatch script
related to unnecessary casts that could potentially hide bugs.

The specific warnings are as follows:
- Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:16
- Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:20
- Warning at drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c:30

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 41ecf00ed196..3ab401729f9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -13,11 +13,11 @@
 
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	*dml_ctx = (struct dml2_context *)kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+	*dml_ctx = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
 	if (!(*dml_ctx))
 		return false;
 
-	(*dml_ctx)->v21.dml_init.dml2_instance = (struct dml2_instance *)kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
+	(*dml_ctx)->v21.dml_init.dml2_instance = kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
 
@@ -27,7 +27,7 @@ static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config = &(*dml_ctx)->v21.display_config;
 	(*dml_ctx)->v21.mode_programming.display_config = (*dml_ctx)->v21.mode_support.display_config;
 
-	(*dml_ctx)->v21.mode_programming.programming = (struct dml2_display_cfg_programming *)kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KERNEL);
+	(*dml_ctx)->v21.mode_programming.programming = kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KERNEL);
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
 
-- 
2.34.1


