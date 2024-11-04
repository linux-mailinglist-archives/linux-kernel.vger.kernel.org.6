Return-Path: <linux-kernel+bounces-394134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018409BAAF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992E11F21D00
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3787E178CF6;
	Mon,  4 Nov 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VjAoKVAF"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA0166F31
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 02:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687964; cv=none; b=h0R7XJMv9SaB4YJuxCLj0Ow6bl0s0R12F1sLhSvDqt9uZfmjcQ07PGOPUxaYm6ggnT0VQtjImgUYU+uH2+GWk3P2GXKHwdVon+Hn94CmuZnZaFm1mQnr8DemUYf9rV2y6Hl/hb3GCeHjXcbCn2mXV5jwzYzaTNBP71kg9v294GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687964; c=relaxed/simple;
	bh=9et7jrBA0psgcAcdVF5xhaFrXhhFY3tRc5oQNeusDmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUb7wE8mdeJq5t+sPYzQ9Bvt9ufOkOtvnkPbzqRRuMNIeUjSrP+rDHBhlv0VA+bV1si4SYqjCPdnoBa06K2qdQP1wRURG+/vSDC3ErO/85CGC615P1r8Nom6ABTlQTdGlQ7EZiXZM0+r0yRTieY8k04BTPAr4wJLtqnFbjbC7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VjAoKVAF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kouaRfpsvazCBSZp/X3VOpgJoYZZCVaGqrCQ+5fUK4Y=; b=VjAoKVAFngA3UIxV
	ZZoW/ehZpWKyYaYRBvE0uhp+HcXIKYn5ORIqffd0mKMHd7oucjwkq2oie/39p6yRLQHSAEQlWIOT4
	QZ07D9ctZq2kkJmKgKafQwPUgBuVleWze+PzmKJTdWH4bxX6H2zNLkfHoOOWRWttlP6nz4fsXaRzq
	x6FfK9jwO1c3iQO4tPsEeizc5xzXaucyjNLSRlPbAwYM3gTjihW2wZNdYlWFJzH4pXtcECyvOVfXP
	hYMnfFkDwgxDKRU2xolqrtdS8/5sWrHSv+zs+foaeaAs1hFNVxbcKku74I9fuGbNwUQu8KXQa4lbR
	+IMLJ0SPSasKaF9Rhw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7mzu-00FECw-08;
	Mon, 04 Nov 2024 02:39:18 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	chaitanya.dhere@amd.com,
	jun.lei@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/5] drm/amd/display: Remove unused dc_stream_warmup_writeback
Date: Mon,  4 Nov 2024 02:38:50 +0000
Message-ID: <20241104023852.492497-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104023852.492497-1-linux@treblig.org>
References: <20241104023852.492497-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dc_stream_warmup_writeback() is unused since it was added in 2019 by
commit 6a652f6d127d ("drm/amd/display: Add warmup escape call support")

Remove it.

Note there is a dcn30 version that's called directly which is kept.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 11 -----------
 drivers/gpu/drm/amd/display/dc/dc_stream.h      |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9a406d74c0dd..a05f8d7c4367 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -612,17 +612,6 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	return true;
 }
 
-bool dc_stream_warmup_writeback(struct dc *dc,
-		int num_dwb,
-		struct dc_writeback_info *wb_info)
-{
-	dc_exit_ips_for_hw_access(dc);
-
-	if (dc->hwss.mmhubbub_warmup)
-		return dc->hwss.mmhubbub_warmup(dc, num_dwb, wb_info);
-	else
-		return false;
-}
 uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 {
 	uint8_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 14ea47eda0c8..602e77560373 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -444,10 +444,6 @@ enum dc_status dc_stream_add_dsc_to_resource(struct dc *dc,
 		struct dc_state *state,
 		struct dc_stream_state *stream);
 
-bool dc_stream_warmup_writeback(struct dc *dc,
-		int num_dwb,
-		struct dc_writeback_info *wb_info);
-
 bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream);
 
 bool dc_stream_set_dynamic_metadata(struct dc *dc,
-- 
2.47.0


