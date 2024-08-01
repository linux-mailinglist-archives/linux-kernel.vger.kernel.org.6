Return-Path: <linux-kernel+bounces-270328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60774943EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0CC1F210BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216701BC685;
	Thu,  1 Aug 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK1DfqLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B11BC66D;
	Thu,  1 Aug 2024 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472464; cv=none; b=MdQeS7YQrHHISzRqp+8tfSi0DOYXJjrf2tM29jdJPtRwF3hHitjA7wy6GjrrIPCXnoO0tLrdN6Ca2GE4gIbN2Rf9uO8qr81rsADpDIpgKMmBp2zse7+emBmWTjGARr1zXw0f1m+m5paOSsKhiNKDxr7pxhIf1b59zrahEOxDeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472464; c=relaxed/simple;
	bh=5NEfmVVjlkY3mavNY+kw3Xm+FexL9xrhk51HFDeBN0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBWQq+JwVolGosXlsrZ21qNuwDh6bB0IrbkJp/gs2x8jcekTYLUf5cjKskKsna7bmw23eSmkxRuyBEJHuMYyOzBIjHa+4tIzUTfFuHofpyfKau8GyA53Mh/WurUn7f8jDhH/a7UR3K0pAvYTPzwEMHw/Z1oGsw5jGR/I8duQvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK1DfqLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64297C116B1;
	Thu,  1 Aug 2024 00:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472464;
	bh=5NEfmVVjlkY3mavNY+kw3Xm+FexL9xrhk51HFDeBN0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IK1DfqLIOQIRSxThXVk8ULsU8jfQBHzb+j1BrnqkciktMIEqPXjkyErhLkc5gpRej
	 9nfmJ7AgffwSYcpW05by8D2grOfWl0smrL+O0fXUiZssVrlSVaZkxHv7w77QOS3MqE
	 V8MOfPhMVr1SsvkLv56AajjJmA6gRiztRIMMSBVzw/wZkG/RQ35LqlZac3OyhbeD1J
	 Ck4/XKte9KvNTT3YwEayzbfEA4tkdsZxw596AqdcddBgDnHk570EsEusPD1qcekjOb
	 fvmwoVmpA/eBUz7G9Nqw593SOncZrV9hx9Uno9Ev1HaNwBQuLatxvJu1BoD6CdmOG7
	 F/ag8w7LLpzMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	jesse.zhang@amd.com,
	sunran001@208suo.com,
	alexious@zju.edu.cn,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 19/47] drm/amdgpu/pm: Check input value for CUSTOM profile mode setting on legacy SOCs
Date: Wed, 31 Jul 2024 20:31:09 -0400
Message-ID: <20240801003256.3937416-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit df0a9bd92fbbd3fcafcb2bce6463c9228a3e6868 ]

Check the input value for CUSTOM profile mode setting on legacy
SOCs. Otherwise we may use uninitalized value of input[]

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9bfc465d08fb0..6ce2719f13530 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5596,7 +5596,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 299b5c838bf70..0c611a01f5348 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4098,9 +4098,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4162,6 +4164,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
-- 
2.43.0


