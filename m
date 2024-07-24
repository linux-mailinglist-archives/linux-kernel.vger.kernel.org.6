Return-Path: <linux-kernel+bounces-260865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81093AFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3431C211AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390E5156898;
	Wed, 24 Jul 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SCduKJlt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F29C155A53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815911; cv=none; b=sHxk9PbWEfxnOoZ01dJQV86ae4zRXNMjk/hrfWqCecbGfgtnDUkSZeYYE8+44N6uQ5C9HWziUYsiQaEgkdiFXzHCUqPCllN+FPUppFHkij3y2iT8iLF/9J24s3bOFnMR1Jv+G0gbIlGSNKIR0hc0Qwe/5bhw43Nc8kSn2hajq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815911; c=relaxed/simple;
	bh=TFq1Rj0XWofaCPyyni4j1/N7qsuqTiMf2WO89l/rlXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjVgLLypqDtkLiROGjUuOdbjQ2TCa3IeebL7u6w31ZeahumhzaZT1txQioFidCuz4EKrN+WGw8AU8yj7IEBmNLnJghga2z18AeG0dPUZWanykybySRYOa/Y3aWoklLNPzllGmMa+1QAbqEVwnEID4O6E8yGnCEtPfK1awBGAU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SCduKJlt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721815908;
	bh=TFq1Rj0XWofaCPyyni4j1/N7qsuqTiMf2WO89l/rlXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCduKJlteMqo9M0bZTDxi3rS9ZEwdrhCR2J+4WWKhazltyn8wz3XkvMGGXf0IMPjj
	 AlsotlPN7LBT8e9/PvxIQxh9Qba9SvvPNQcqtbC0BMQaAh6RPyUePK58K8xknYA5NE
	 V+/sAXhvse3914CWmSQAuaOnumMfbn2vsHIQpNdFuIKYCKhp2PGnaDd4JiJAhEfWy9
	 UlZ730xNAKNm7BrBsDmmxbqWUedr8aZu3m8XV1EdIDtvB8yhKPNYe7T9boP5p85eyG
	 M7JTzK+z8dp5Xn0k1G2n9AeKc9oRS/MeviXLicIB46SEhJOiFOgGuhaCBVf4rMa2lL
	 tprO4HQuRwHFA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7B69837812FA;
	Wed, 24 Jul 2024 10:11:45 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	deborah.brouwer@collabora.com,
	robdclark@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/5] drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
Date: Wed, 24 Jul 2024 15:40:04 +0530
Message-ID: <20240724101015.523535-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724101015.523535-1-vignesh.raman@collabora.com>
References: <20240724101015.523535-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CONFIG_DRM_ANALOGIX_ANX7625 in the arm64 defconfig to get
display driver probed on the mt8183-kukui-jacuzzi-juniper machine.

arch/arm64/configs/defconfig has CONFIG_DRM_ANALOGIX_ANX7625=m,
but drm-ci don't have initrd with modules, so add
CONFIG_DRM_ANALOGIX_ANX7625=y in CI arm64 config.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - No changes

v4:
  - No changes

v5:
  - No changes

v6:
  - No changes

v7:
  - No changes

v8:
  - No changes

---
 drivers/gpu/drm/ci/arm64.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 4140303d6260..66e70ced796f 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -187,6 +187,7 @@ CONFIG_MTK_DEVAPC=y
 CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
 CONFIG_REGULATOR_DA9211=y
+CONFIG_DRM_ANALOGIX_ANX7625=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.43.0


