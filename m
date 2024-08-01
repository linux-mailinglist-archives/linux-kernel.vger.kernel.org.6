Return-Path: <linux-kernel+bounces-270368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA1943F26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883541F22D19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826961E021B;
	Thu,  1 Aug 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKWGc+ve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59281E0204;
	Thu,  1 Aug 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472650; cv=none; b=uFMnOYUbYtk9dh967S5qGCEwn0GpKqpylvhjpVwazylJydawpeDNZnn0ha3LXjBYo1G1QNPv3eZLRUva5dGokC2Pe4Ie/L9hJh2yU2T98Mnz/ZN7ar8mgZvK2D36WMhUsgVu+K2iwWEp6SYiFTm4yjzPI7i0ifoJKoCMVlj+3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472650; c=relaxed/simple;
	bh=0e3kUQWfO5rovM/j7DUwV+br2dxpTo2g/vOKB6meS0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1kstAQjxZ7j6N0Fl3SwKPNJdOqmjMRxGTK8MblklwB7LbeteEA9cU8817MOAjtbR/XW+ZdQ0J+VJgVqkywi8kHnp7T4g8UAI9+XXNTP9JgsnOe5iaHHV6e1b9xzK4i7E4IO0LkG3MYZEQN/0tdtQY5xErh9mVkq++12JbxxNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKWGc+ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC661C116B1;
	Thu,  1 Aug 2024 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472650;
	bh=0e3kUQWfO5rovM/j7DUwV+br2dxpTo2g/vOKB6meS0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKWGc+veMlJlBLjXavLsttAZ2eBuzqXDfbp6PKruhGj5YEneKfFvA7DZygFsAIrNJ
	 voR33PufDf5lJa7bEfmrQ21i6WbQjxBixePwelP7D4t/I9I32pBzFQVe0pLHTgVh6O
	 lFqFZlMeb6aBeGVqihJmZTwUjzzu5+Fs5qtD6BaWxSMrZubYdSE9tQT7CM8pGTs4gr
	 UPYwEGQWit4PAMH7MyQ7nJh/wfkctfOVpD3KEbPXq3IqgTnwRId80HByMV+QoT/r89
	 W1SkLBlqskUgW5kydauDm4spTLbKNNrUaCp/8TzSnvtThOysCi+8HcfSiTIf2VfswU
	 H7dVziPCJljMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 10/38] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
Date: Wed, 31 Jul 2024 20:35:16 -0400
Message-ID: <20240801003643.3938534-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit c6077aa66fa230d12f37fef01161ef080d13b726 ]

[Why]
For subtraction, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change variable type to int32_t.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index a7c92c64490c5..a5de27908914c 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -58,7 +58,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -114,7 +114,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
-- 
2.43.0


