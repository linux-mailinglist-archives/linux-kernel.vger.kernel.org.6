Return-Path: <linux-kernel+bounces-270315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B21943E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD8E28329F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDD1A38DD;
	Thu,  1 Aug 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztt1NNI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF3132122;
	Thu,  1 Aug 2024 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472402; cv=none; b=NF1g0IclHvkT+Ym404GfKvDfw/j2XmkZGvm8axrU08TpKmc37A+9hAXKtA0OqYIC4Z4s+HFTub/myofDrNplQCusL0S72hKNd0cwPJGPnx4MBgxdfKuRFaVE7GNwfBD3q5ab1xO67M5RqC4Fus4maPjhpt65B+fKvW7aa5e+p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472402; c=relaxed/simple;
	bh=Ki+ZXbgsnh2RvI/4PA0J/WRL9bQIComw4qWqRNm3UUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8zEx1AsA6uahO0cfBnVeStNd6zQpZE8LociTFxotuXCH4z2sJOTKskQYXoxQVMCVcCKPuAuUF/ixJSgH/VMQAXYkiQPdPhoPyiLIRXA+rnTl9OdP/nnvaj7Q63NQmWLdpSgZfqFXx4ltuuwYveBLgRqwfb1NGP435lGVPQ0yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztt1NNI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3774EC4AF0C;
	Thu,  1 Aug 2024 00:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472402;
	bh=Ki+ZXbgsnh2RvI/4PA0J/WRL9bQIComw4qWqRNm3UUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ztt1NNI0YwCCPhsj8P+2yKz0OiIVzj7A9kcHHhAmadhD2FIAw6Y2Ijtd9InjSa2UI
	 M6lqg/eedALBvwjHurrXDlFfCfk/GkKtosSVMqu9waZ92lmHUWOv8KfGGWNDEF3hU7
	 GPdDjqk7r/5WKfUTVvND9za8Pwxpaa++AqU7cWo7qybu6LuctCtC4u8+92LNRKPG1y
	 Vd+0lEbzoBZ26KMVrKYtafOMX8OaZnEbWzD9tjKgN9BotqzhtdAiFHd3J5LGUeDwA1
	 E8xosqM+4hDkaPsiVhvMiB4gzxequpa4fF0bZ0hziwLSCni7DUQYLs+hMu3TH2ifcz
	 uxVn4w8CPqTEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Zhigang.Luo@amd.com,
	Hawking.Zhang@amd.com,
	victor.skvortsov@amd.com,
	victorchengchi.lu@amd.com,
	Yunxiang.Li@amd.com,
	Vignesh.Chander@amd.com,
	surbhi.kakarya@amd.com,
	danijel.slivka@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 06/47] drm/amdgpu: fix uninitialized scalar variable warning
Date: Wed, 31 Jul 2024 20:30:56 -0400
Message-ID: <20240801003256.3937416-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 9a5f15d2a29d06ce5bd50919da7221cda92afb69 ]

Clear warning that uses uninitialized value fw_size.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b508126a9738f..8d9bdec2b700b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -410,6 +410,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	uint64_t retired_page;
 	uint32_t bp_idx, bp_cnt;
 
+	memset(&bp, 0, sizeof(bp));
+
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-- 
2.43.0


