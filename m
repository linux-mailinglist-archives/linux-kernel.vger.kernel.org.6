Return-Path: <linux-kernel+bounces-220863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFD90E858
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332C4B21A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FC685626;
	Wed, 19 Jun 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dodw+hqE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CC78C91
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793041; cv=none; b=exGO3C/MJCI+m7poTeGR0BV+Wg6xYmA2IfKJCofk7kVz42Paar9vbRLTzON9O/Tb5i1ET8P2NUdTKA4T3AZHGnFf1cyH2eQ7yXohvp4qHEbqKd5QiRJcnubE2slLQxQWG9OzbhGfDp6IpJMilFecchjpbd6ezHTYmmeFyQVl2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793041; c=relaxed/simple;
	bh=uWBOfNWDaWysr82LJvlFXwnZM9j18ErxE9+uXo17HHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPXNrYGcHZ6QULD6HHd0EMB57XU83wzYw8qhVxvUatsKdM0F7aVGS9Nx7fz4nCuqgZUqUYOPtVkCVr+oRc3dc0V2B/m6eGywdaoc68JKCSiW2s40VYhMPzJTtNHdKEodiSRhKVQUC1SFJWDLVQOoP7HEU/RYSCG9jpfAfkBCFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dodw+hqE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718793037;
	bh=uWBOfNWDaWysr82LJvlFXwnZM9j18ErxE9+uXo17HHg=;
	h=From:To:Cc:Subject:Date:From;
	b=Dodw+hqEZzT7cQGDj+ZKzi81LYGZmNbHRAUVFDkKHPFhX8AvrHsAG7xno1PwqwMh4
	 bABg1RI2g/mGDF/B6or+yCyyLUD9ZkSupn3PTWKIWcpt61nGKUxt/afREBfO9Dc5c0
	 hbpxLKXvauPcpfUmnBRWKkpYkvIL2BXCI89DcPXRZduGgcI6r8KWki5u+NMN4t5FR/
	 ssGl7SijzWzdg1MzipnnqLfHLoTR4s6TsXyzQoZKEXcOP6Kc2PjN13eBUyMj9QvkTt
	 fOP0LWOrvrlKAH4lQIQ9TeUyoFW2IwrU3cS45Yw+uOgpSzlY5CL/vkVAX3Tla2tWDr
	 rFdiqUDps0A0A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4299B3780F7F;
	Wed, 19 Jun 2024 10:30:37 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	fshao@chromium.org,
	kernel@collabora.com
Subject: [PATCH] soc: mediatek: mtk-mutex: Add MDP_TCC0 mod to MT8188 mutex table
Date: Wed, 19 Jun 2024 12:30:34 +0200
Message-ID: <20240619103034.110377-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8188's MDP3 is able to use MDP_TCC0, this mutex_mod bit does
actually exist and it's the same as MT8195: add it to the table.

Fixes: 26bb17dae6fa ("soc: mediatek: mtk-mutex: Add support for MT8188 VPPSYS")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index b5af1fb5847e..01b129caf1eb 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -524,6 +524,7 @@ static const unsigned int mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_PAD0] = MT8195_MUTEX_MOD_MDP_PAD0,
 	[MUTEX_MOD_IDX_MDP_PAD2] = MT8195_MUTEX_MOD_MDP_PAD2,
 	[MUTEX_MOD_IDX_MDP_PAD3] = MT8195_MUTEX_MOD_MDP_PAD3,
+	[MUTEX_MOD_IDX_MDP_TCC0] = MT8195_MUTEX_MOD_MDP_TCC0,
 	[MUTEX_MOD_IDX_MDP_WROT0] = MT8195_MUTEX_MOD_MDP_WROT0,
 	[MUTEX_MOD_IDX_MDP_WROT2] = MT8195_MUTEX_MOD_MDP_WROT2,
 	[MUTEX_MOD_IDX_MDP_WROT3] = MT8195_MUTEX_MOD_MDP_WROT3,
-- 
2.45.2


