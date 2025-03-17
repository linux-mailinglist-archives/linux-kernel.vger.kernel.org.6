Return-Path: <linux-kernel+bounces-564175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77AA64F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600213B40F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3B23C380;
	Mon, 17 Mar 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="cjignGL0"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFA239082
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215401; cv=pass; b=Iia+K6Q3nWEojHVJtPrCHiASglYbEPz6frn5LhmJR5Cgh7/SPeE2mk/U3D/3VxvAilLJua0y4TjAMN0rQc4nDNVe9zBa2PhxiAioZ33/tHTHCdfEcOGISjGaqEelIFEDJiKel+BLQH2RhcoIaKnMj1rGOndrwbdcPDBXusE03BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215401; c=relaxed/simple;
	bh=ESiJcoBzb+xFeDK3kkBTj2SlNTfO7UtIXKeHKhMg2xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iecq9UggDf+7cUMSf/qZSd5AHi2OZ98Edj99prnpkEIGPM8WycZfVp5r0fK4wkyfqbf9fAuBc9mRqBZ+Jiybxyxg+BrC+j5pnbcHNgz+DI2jZqqu+oj6ixzqywRIvIxbQy4s6TVQh7dOVMswck39yQSb9j15nfBoS1KUFPNfkvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=cjignGL0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742215377; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z2uaNei1DnqkPtysqGUjnh98Id3/Pz8G0Zlp9+65bZh/otSoeiYl32+lAQkyVVjEjNO2ySk8GeC7zVY1EuNfEPPmByfGq10kmCd6vGButV0PLMPZ2kkn5BoehC8+nf/uWprb7aqo30KgoKXZgvJqgix9c+oA9YmGQjMdpNIx5es=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742215377; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ko5u8UGR6vLGK2T6EY0xPz43YUrrXiIQoaCjRcfxpk=; 
	b=iRDg9+5sX2TsWL4xHZhjIPU088eKdTS+kslXyd2K6NKudB+eUTDfY8x2SF6ibClFaOQmNwQhAghh79pB3yFwOipjj/EZBEVnaPnICzZBMhoQnMQEmz6u1HE8dCPVBLpU2DZtipoMx7VZGaDBFcd/cswmCMtK/IIBny3cMZQEvQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742215377;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8ko5u8UGR6vLGK2T6EY0xPz43YUrrXiIQoaCjRcfxpk=;
	b=cjignGL0Jd7KZ4g2yyUxoulq2lTePZIiLtue5v235G5/WTLRlTKJbEUPmdJpkXHn
	RGhpAaSVpr+BB2Cx+U4s7P0cynMGMsej3QPCWRxctaFZh5/9LOexAGzHKLt7h09xaTJ
	l2ypwqVX5yGrS2ebsiVb4hhoVdt3jYDzkDHere5c=
Received: by mx.zohomail.com with SMTPS id 174221537515980.8227895254746;
	Mon, 17 Mar 2025 05:42:55 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v3 3/6] drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature flag on Bifrost models
Date: Mon, 17 Mar 2025 09:40:41 -0300
Message-ID: <20250317124044.16257-4-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
References: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Set this feature flag on all Mali Bifrost platforms as the MMU supports
AARCH64 4K page table format.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_features.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
index 7ed0cd3ea2d4c..52f9d69f6db9d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_features.h
+++ b/drivers/gpu/drm/panfrost/panfrost_features.h
@@ -54,6 +54,7 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_THREAD_GROUP_SPLIT) | \
 	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
 	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
+	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
 	BIT_ULL(HW_FEATURE_COHERENCY_REG))
 
 #define hw_features_g72 (\
@@ -64,6 +65,7 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_FLUSH_REDUCTION) | \
 	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
 	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
+	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
 	BIT_ULL(HW_FEATURE_COHERENCY_REG))
 
 #define hw_features_g51 hw_features_g72
@@ -77,6 +79,7 @@ enum panfrost_hw_feature {
 	BIT_ULL(HW_FEATURE_PROTECTED_MODE) | \
 	BIT_ULL(HW_FEATURE_PROTECTED_DEBUG_MODE) | \
 	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
+	BIT_ULL(HW_FEATURE_AARCH64_MMU) | \
 	BIT_ULL(HW_FEATURE_COHERENCY_REG))
 
 #define hw_features_g76 (\
-- 
2.47.2


