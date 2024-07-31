Return-Path: <linux-kernel+bounces-268493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DD942544
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2686283747
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AD208D1;
	Wed, 31 Jul 2024 04:11:34 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A01BDC8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399094; cv=none; b=A6YeFzPcHFNBrc2SVXxTABlMgt/GHzLZrfkuuV4qU62OyZjbMq0Cbagj/6QeJE8LwOvfmo9ntUEKIYLhVdJ4BV2Iq4w4fgWwlkmqHxtLH7xKVqm159LgBSbjGBAmFsWoOpob7ZTB7pMK7rvxKXc/fnemEW17iAuQhoeHvZNp5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399094; c=relaxed/simple;
	bh=QSWfUuEQxC/rN9Y5i1QssYyrDxoIL7UVywZgzUI0gnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWvKLhjlVWYNO15071D7bl9D50skvZBrHSV3CC0d1LZ58ZXcQ8ZYo4Ul2HpqaGIW+xxvQ2H+B9SEXLZz2bw1cSoKhTrW2LwN8jHvunGpZdAp6CF1XkiGWi35l3i4ZxrIlV/PIbSFM+CHUM6klSSHLJqPQl3PZdA5wxbZJi6I0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz14t1722399046t8cj53
X-QQ-Originating-IP: YfBrOmRzqW2rVkujMiT2lCl0fnRmfKRUSfKubBNGB0g=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jul 2024 12:10:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8046675919235854722
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
Subject: [PATCH v3] drm/amd/amdgpu: Properly tune the size of struct
Date: Wed, 31 Jul 2024 12:10:40 +0800
Message-ID: <3BC6F04B763EF430+20240731041040.43863-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The struct assertion is failed because sparse cannot parse
`#pragma pack(push, 1)` and `#pragma pack(pop)` correctly.
GCC's output is still 1-byte-aligned. No harm to memory layout.

The error can be filtered out by sparse-diff, but sometimes
multiple lines queezed into one, making the sparse-diff thinks
its a new error. I'm trying to aviod this by fixing errors.

Link: https://lore.kernel.org/all/20230620045919.492128-1-suhui@nfschina.com/
Link: https://lore.kernel.org/all/93d10611-9fbb-4242-87b8-5860b2606042@suswa.mountain/
Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: wenlunpeng <wenlunpeng@uniontech.com>
Reported-by: Su Hui <suhui@nfschina.com>
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


