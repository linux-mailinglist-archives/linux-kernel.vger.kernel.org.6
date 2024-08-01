Return-Path: <linux-kernel+bounces-270126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3799A943C44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691651C21B54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3F14BF87;
	Thu,  1 Aug 2024 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg1O7d4N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EB1BD4FB;
	Thu,  1 Aug 2024 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471407; cv=none; b=ihmnqszZaV6blMNDzzJ85taN6ky7RKM3LsR843m7YItR+RdJOhK4OXsW94Zf8QG4VvCTWjKxql+sJ4w0DZYMB0cpB3qnzXl81ITgNZqHSonyAqSQmNeoMUy/K5oW8jKNchg8gwBEoVmrjgZOrme2+i4GtccbZ3txOrWgoaYJVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471407; c=relaxed/simple;
	bh=NYNk1E/z8UGKezZc/Rwzh6Vih06UFSdFwRsCJVJAFIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE1VSroV6QcSXCDq5ttyEJR5871Y3SN98+6Fw5LOtKC+GLGI8ZO/oByRg1gYhV8SKV+AWTU68vJb8FQCGOzNN0CSu2u4m9MPp//OC7dX8U3qp+jcvgJJEw+YxdrQRAoqhpvh/bCVvBAqeWDMsjpaRaGh9tcXbOwNN7YyJZJfEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg1O7d4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48829C116B1;
	Thu,  1 Aug 2024 00:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471407;
	bh=NYNk1E/z8UGKezZc/Rwzh6Vih06UFSdFwRsCJVJAFIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vg1O7d4N4/L275YhOob1NoHlqVDNR72Cxw4yHHOiySngNTNNxYblCfjVbjAbIxKx4
	 PtDeoMpaMYckk9ww6rpUchZeSb2NhU/XxLe25Olu7TwQ2qLjJiULJTLeGfwjEg3KeB
	 TeAd3cN0jWZSGVHmXta4ZOST5VvdaWkUQ6fYhuvKJf9Pm1MSzPQ3aowD5Y7cuQssmb
	 mP6q21w8d6PQvYlTPdhi3p6ApfyZ59t/ZWpvYcBQGjtOs5FZEZWaXrxGe/5NYAe8Wt
	 DffjG14MALB3VGt0f93xBPCcTBRAqH7Te3oHfveHG6MQqYlOP7Ud2NIljkZytkDiJT
	 l0Lsjgqtb0InA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	charlene.liu@amd.com,
	Roman.Li@amd.com,
	syed.hassan@amd.com,
	josip.pavic@amd.com,
	ovidiu.bunea@amd.com,
	daniel.miess@amd.com,
	Qingqing.Zhuo@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 088/121] drm/amd/display: Check UnboundedRequestEnabled's value
Date: Wed, 31 Jul 2024 20:00:26 -0400
Message-ID: <20240801000834.3930818-88-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit a7b38c7852093385d0605aa3c8a2efd6edd1edfd ]

CalculateSwathAndDETConfiguration_params_st's UnboundedRequestEnabled
is a pointer (i.e. dml_bool_t *UnboundedRequestEnabled), and thus
if (p->UnboundedRequestEnabled) checks its address, not bool value.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 3e919f5c00ca2..fee1df342f122 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -4282,7 +4282,7 @@ static void CalculateSwathAndDETConfiguration(struct display_mode_lib_scratch_st
 	}
 
 	*p->compbuf_reserved_space_64b = 2 * p->PixelChunkSizeInKByte * 1024 / 64;
-	if (p->UnboundedRequestEnabled) {
+	if (*p->UnboundedRequestEnabled) {
 		*p->compbuf_reserved_space_64b = dml_max(*p->compbuf_reserved_space_64b,
 				(dml_float_t)(p->ROBBufferSizeInKByte * 1024/64)
 				- (dml_float_t)(RoundedUpSwathSizeBytesY[SurfaceDoingUnboundedRequest] * TTUFIFODEPTH / MAXIMUMCOMPRESSION/64));
-- 
2.43.0


