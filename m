Return-Path: <linux-kernel+bounces-534675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C511AA469CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EF9166468
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176F23373B;
	Wed, 26 Feb 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="aCkMFOAD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCB22D4E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594685; cv=pass; b=KdL/9j0ObNfda/W7kfxYDStprmzSm7tmVA877enS2cZJqsqX9G/EPw/za3ZTsiWZomxot9YmeaJmQxoHKShHRFszUAFIr1lKAnpn9GtJnsET5vVcezZAfEckJ76/786iys19Yp1EGlQkwKUP9n6DDtTLwCgKjZs6CR73Kdv9R0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594685; c=relaxed/simple;
	bh=RjIrj3LifxHD27NQaLEt/qFK5V8hezbJ/nCngSDulE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHKww10olC+UvxqQ8Utkafy5fb9lEdouq3UMyAcrOZOjOyo+ePcEvqR1AQrLdNJieq+y7H0/oud23/GzbLM8EsycJW66y1XM/1+Gc2n9qC6W5SqOPzlC0QiwSE0OLVdF1M+ugCXJk3n5t1+emLYyByw/vqB989b3syWWsxLua6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=aCkMFOAD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740594670; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UfqdIUbD87c+2aSgp3POmh2n5CDc8YAs4cWidwB5gI1Xpake3xl8pUJEbOiGE3by7fUsImKXixxylZsm+xZ2uNfHr+6PbgBgWLxjdmZitVkwPoNqUQ0/eYk+Z+ad/bEFda47P1eBHnC2rR0OjaWxI1HeoOkMAAd0PLWqXBXAb/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740594670; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hIkp+NnTJPxQcX2Rdgo+vdaGlwKLBcPZ5PRXpnJscic=; 
	b=CelpxNQM/bvC8RQSCMgl//1krTGtg0WP7yMt6QgsmqpD1RuMfHROE82kFOPnoayqX9cEzqFpcHkvwjNcq1ZdVvJQoTW9VWyAY6yzVQw8K61uwychMrUU0UmxxnF7XnVm6+CXTs7M7+PBfnVFBwF0oLvNxr4W9TsiBSR0AXdluwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740594670;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hIkp+NnTJPxQcX2Rdgo+vdaGlwKLBcPZ5PRXpnJscic=;
	b=aCkMFOAD+KcvdKOxRNiKB9myydk1CLwklPIhBNBaKu7p0rF7qqz/MIcWXm9aTVVP
	3N7uTc1aGY1sQEqAOrM6AIHjDBbtbuSbVezwXpiS3q8CI9s5SaACf5gYjG4lajmlEPh
	2hfVPwNxSz9fGl1EOicGVDF0Lq7Kr1dFdK1cNxwM=
Received: by mx.zohomail.com with SMTPS id 1740594668431951.5175651775419;
	Wed, 26 Feb 2025 10:31:08 -0800 (PST)
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
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [RFC PATCH 4/4] drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature flag on Bifrost models
Date: Wed, 26 Feb 2025 15:30:43 -0300
Message-ID: <20250226183043.140773-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Mali Bifrost MMU support AArch64 4kB page tables. This feature is in
panfrost based the HW_FEATURE_AARCH64_MMU feature flag.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_features.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
index 7ed0cd3ea2d4..52f9d69f6db9 100644
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


