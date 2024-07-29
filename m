Return-Path: <linux-kernel+bounces-265876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04693F725
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A6A1F22700
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAA14E2CC;
	Mon, 29 Jul 2024 14:00:01 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3A14A0B7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261601; cv=none; b=XdnXP0QuBWDoIrh0YM8oyEWpnk13EoIaGx1HoDVdDmE7ebV9D/aadn8q5S1GxkvdEDb017VFX9DzzPmWms9qtHUutv/FcOd9VNv2IrI5kPpCF34YMvYv2OA3kipzSPZ6giTyfOlm060qlcQrIu8Yn0ilqjudXniGCCD4ZSirEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261601; c=relaxed/simple;
	bh=+C5G98ln9+yx+wffTmDJJVxVlUYlMvWGxLtHHJag82s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQAgJci97J8cxt3MGIro7GLnPoxJJ2P3hPKS7Nthz7iCpGVY3JmRNCzcalqGLw9kj3pTu62e3e0ASz/PWQxEkZsAUJ3GxIbNtuMEx7+s9wuUc7zE62nquHIpwxgk6dk3oL1fpmQTPc5l+cU54d3Oly+/XxNJpmpcXA42xLVEDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp81t1722261547tbxomzu2
X-QQ-Originating-IP: KlOB/YbZHQp8ShWuktjn3+RmM/yq6LbsM9i04JshJ8E=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jul 2024 21:59:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1796147500759734024
From: WangYuli <wangyuli@uniontech.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jingwen.Chen2@amd.com,
	suhui@nfschina.com,
	dan.carpenter@linaro.org,
	bokun.zhang@amd.com,
	wangyuli@uniontech.com,
	chongli2@amd.com,
	Luqmaan.Irshad@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	shaoyang@uniontech.com,
	hongao@uniontech.com,
	wenlunpeng <wenlunpeng@uniontech.com>
Subject: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Date: Mon, 29 Jul 2024 21:58:25 +0800
Message-ID: <2BF9FDD63BBFB1AE+20240729135825.890138-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The struct assertion is failed because sparse cannot parse
`#pragma pack(push, 1)` and `#pragma pack(pop)` correctly.
GCC's output is still 1-byte-aligned. No harm to memory layout.

The error can be filtered out by sparse-diff, but sometimes
multiple lines queezed into one, making the sparse-diff thinks
its a new error. I'm trying to aviod this by fixing errors.

Link: https://lore.kernel.org/all/20230620045919.492128-1-suhui@nfschina.com/
Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: wenlunpeng <wenlunpeng@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index fb2b394bb9c5..6e9eeaeb3de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -213,7 +213,7 @@ struct amd_sriov_msg_pf2vf_info {
 	uint32_t gpu_capacity;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 struct amd_sriov_msg_vf2pf_info_header {
 	/* the total structure size in byte */
@@ -273,7 +273,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint32_t mes_info_size;
 	/* reserved */
 	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
-};
+} __packed;
 
 /* mailbox message send from guest to host  */
 enum amd_sriov_mailbox_request_message {
-- 
2.43.4


