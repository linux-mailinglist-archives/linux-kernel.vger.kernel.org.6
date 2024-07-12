Return-Path: <linux-kernel+bounces-250906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530C92FE67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3345B1C21C58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5817557C;
	Fri, 12 Jul 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvO5c4c9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D81741D3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801440; cv=none; b=ewDMLyeeBHJixThmvrmk7rB0UqiCtet3E+21hp/8FcTlzCr4v+twA8SFamcNOEbEuOIMfnhqiMMW8DgBwt6RdIlS9vBLL2p8wzBkLtDoZ9MZYIfCdSag9ovG2DEv7cTf8PzmszI98Av8CS+BU+7DFGms9DmLepzXWIIGRtj6uLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801440; c=relaxed/simple;
	bh=ShhMsfhi+E7zGYGephLcWRruAeKJf2yYsvgYn+xHb4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVlujS2uO4bkSyhogPu92biaE98CJV//KWnNrtCvB7GzUJl++hXd36wz8cMCoYjsB6q7H6rzljErqnLAXBvzLX3GmTtvwfFRNL6A0OOKYhyraB2ONjM02eczYbUB1E7oOzpckHRwSRTa27v7qE0n3bdEfXFzt8N72rMlMOI62gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvO5c4c9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367a081d1cdso1169969f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720801437; x=1721406237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hn+GixGy3/wqCNmbaVUdcuRjiIfqGnrOXg+l5ek8FFw=;
        b=PvO5c4c974slrcffEiSZ1NedOc9gIaaDjCoGat6vLW17OgrlKRC9RvWvczJ8giTgEI
         rWigGvkfXwMwoxeY6jDDTt1YcIr1X3TFJS3axhRq5bofsApDXLM7kx37c12Ahx/2Pi2Q
         3gfMtVxUrKQRra11bAloxU9HLFbjHZhIJoW21OIT9C63SppUeWxucbtGnF7ddiRslIsH
         4vCULKLawWeW5J2aeFc4bw/qNpUP8p9iaNiGpxIOlbL8K8mErsI1VDyADOc3WiVz3Eu7
         NjlpKBYOLBTe0buu1H7Y28PzKYqzG4pwkuYNyZpcS2G86+nBHo3LO+ZIfbbg9ifYkFp0
         jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801437; x=1721406237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hn+GixGy3/wqCNmbaVUdcuRjiIfqGnrOXg+l5ek8FFw=;
        b=F8H7FFbtH0AhW9DeBkIZf85iU0rNiYkeWpRPGnOUL0VzjyUZKAiFVPte/e4iJdDUF8
         30PJ8RPw7MyduPgyR35QKTi68+QBAyFx5cHyE52cx9Py2MUfosQS8Ahfs+9oI+EdjCjG
         nVehgMaF8xTCLTW1a80+3peJwg137CaAyJDDFER3YBj6hl1Waligj4E7toMvT24zF/kP
         3Y1ruFH2oUlmtVACgz6+USOWDuYTOrz6dIy4/EQkTWu3aP5nJqkxQXJWIhoKrvxUKnO+
         CHxTW0xoumVv1C24om8TJJFrYdl5GeVEI8nMLt4lN6Md2xOW8P276TnO7RM/O79dBuV6
         YGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWeWhnoT5dSRZJr6vEiGYP358E22qWf13OM3uOGN2LbEY5EWYVicDUHGdydVxBZiJV50NQKxfJ2traQKG1iocWJF/2sBcG+Cx2bNUpQ
X-Gm-Message-State: AOJu0Yz6QhtsylIWEzrswF+/Befinv5S31ea0VJCVriHmDrn53kyLhbd
	geHDejJJsu147VWki5ofj1ZlAZ9un+gDROXossLTv7+GXshlzA+1
X-Google-Smtp-Source: AGHT+IFXRaZUXZvr3FGsTkx2MEPXnjbLliZ4mKa0YckpBF5gChle14p/17QJAUoUUg7mT8NHlqYVcw==
X-Received: by 2002:a5d:60c5:0:b0:367:4dbb:ed4e with SMTP id ffacd0b85a97d-367ce5de7c8mr8005771f8f.0.1720801437223;
        Fri, 12 Jul 2024 09:23:57 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde848e7sm10458852f8f.44.2024.07.12.09.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:23:56 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: harry.wentland@amd.com
Cc: Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/amd/display: Implement bounds check for stream encoder creation
Date: Fri, 12 Jul 2024 18:23:53 +0200
Message-ID: <20240712162353.10220-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The same pattern fixed by commit 15dba12c5659 ("drm/amd/display:
Implement bounds check for stream encoder creation in DCN301") was used
in other create_stream_encoder() functions.

Apply the same fix.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index f35cc307830b..c8a538a6ea76 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1029,7 +1029,7 @@ static struct stream_encoder *dcn30_stream_encoder_create(enum engine_id eng_id,
 	vpg = dcn30_vpg_create(ctx, vpg_inst);
 	afmt = dcn30_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 5791b5cc2875..a12d880da586 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -407,7 +407,7 @@ static struct stream_encoder *dcn302_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn302_vpg_create(ctx, vpg_inst);
 	afmt = dcn302_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 8bc1bcaeaa47..75481c6d99b5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -394,7 +394,7 @@ static struct stream_encoder *dcn303_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn303_vpg_create(ctx, vpg_inst);
 	afmt = dcn303_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index d4c3e2754f51..3fd172788581 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1237,7 +1237,7 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index ff50f43e4c00..83ad7a7d3fd7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1293,7 +1293,7 @@ static struct stream_encoder *dcn314_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 4ce0f4bf1d9b..cd6471eb01b2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1236,7 +1236,7 @@ static struct stream_encoder *dcn315_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 5fd52c5fcee4..1f40e150a478 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1231,7 +1231,7 @@ static struct stream_encoder *dcn316_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index abd76345d1e4..39cef0018dae 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1216,7 +1216,7 @@ static struct stream_encoder *dcn32_stream_encoder_create(
 	vpg = dcn32_vpg_create(ctx, vpg_inst);
 	afmt = dcn32_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index e4b360d89b3b..1ed1c93f8e72 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1200,7 +1200,7 @@ static struct stream_encoder *dcn321_stream_encoder_create(
 	vpg = dcn321_vpg_create(ctx, vpg_inst);
 	afmt = dcn321_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 2df8a742516c..ed1c9cd1c30c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1280,7 +1280,7 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index ddf9560ab772..35dbb8641ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1260,7 +1260,7 @@ static struct stream_encoder *dcn35_stream_encoder_create(
 	vpg = dcn31_vpg_create(ctx, vpg_inst);
 	afmt = dcn31_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
-- 
2.45.2


