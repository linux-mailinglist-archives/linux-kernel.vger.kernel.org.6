Return-Path: <linux-kernel+bounces-329875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770199796F6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3756728218B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B321C689D;
	Sun, 15 Sep 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VIf2ikBA"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBD14286
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408913; cv=none; b=M8Gbm1q9YfscqpgNyPFHi8YMqi/NDQbhfPUlmh6qU04n7fhtGAAqzJTViagHkUn7mlSzGli4QvJi5y7ICZRQ5NblZhAZeJaMB3zcEO1WKo9fIMjkalXQIfUEoiPKNfnNR0MPV0koTjTEfxmtiELf7SwTbVxMFqLPjp46byM8UYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408913; c=relaxed/simple;
	bh=V7IQH31Ik5N/F0jlqfEHHwtmEetCfORWixue3o5Pzg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLIoGcbJmNG3ET/ubyQ2KSecWgKuNc4UAI8ltFA5YvundFzpf4xtPm8B1lLtFxZ8H/teLFVO1drlX3tX0TPUedUJb7XT1UM0W+Mcnid6/0K8oAOx+2OId/QvfcVjN7zI2QuY5WG9+oe3PUmbx24z6Pug5DAPUNmkZR5c0S/ZUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VIf2ikBA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=i4QciZ0qftqS2o625zh2ldn6URyWZ5o9xpxLHJHHoNQ=; b=VIf2ikBAhNcb2Tyk
	RWHpaEdkeaZMmZilE1zSXRMN803+iTI13vK6xJXXogb+DaJO6Zwcwc7vIg/QEisf+GmqBfEmuwjIA
	o1zMtbn+vTDQyLfZbOJJn0ckRVbbA9c0vAIzxUSG2W395GOmV3f/Ndfy+jSdaosL5SpkYjlDixM1j
	vvNqjV1+0YxnWJdbg/tMEkxhO26ioCZ8u44+qsB8bFkWYqpmujkNdmyDfhnGgP//aeEZElhn9XZ/U
	LRZxCQK3eZcLK5KGcwIuFtIJBZNsQG00YBoqMPb+QWGxkMRW8KHp7sSUzhKsdmRtSE2l57iVp/Ots
	9X/nV4Or4v5J3b5oSQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sppow-005pnU-1Z;
	Sun, 15 Sep 2024 14:01:46 +0000
From: linux@treblig.org
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/amd/display: Remove unused function bios_get_vga_enabled_displays
Date: Sun, 15 Sep 2024 15:01:44 +0100
Message-ID: <20240915140144.36988-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

bios_get_vga_enabled_displays has been unused since
  commit 5a8132b9f606 ("drm/amd/display: remove dead dc vbios code")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 7 -------
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
index adc710fe4a45..8d2cf95ae739 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
@@ -78,10 +78,3 @@ void bios_set_scratch_critical_state(
 	uint32_t critial_state = state ? 1 : 0;
 	REG_UPDATE(BIOS_SCRATCH_6, S6_CRITICAL_STATE, critial_state);
 }
-
-uint32_t bios_get_vga_enabled_displays(
-	struct dc_bios *bios)
-{
-	return REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
index e1b4a40a353d..ab162f2fe577 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
@@ -34,7 +34,6 @@ uint8_t *bios_get_image(struct dc_bios *bp, uint32_t offset,
 bool bios_is_accelerated_mode(struct dc_bios *bios);
 void bios_set_scratch_acc_mode_change(struct dc_bios *bios, uint32_t state);
 void bios_set_scratch_critical_state(struct dc_bios *bios, bool state);
-uint32_t bios_get_vga_enabled_displays(struct dc_bios *bios);
 
 #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offset, sizeof(type)))
 
-- 
2.46.0


