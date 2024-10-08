Return-Path: <linux-kernel+bounces-354906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E0994460
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4CBB2305F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA718E342;
	Tue,  8 Oct 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="juekqoKn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9A518C35E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379949; cv=none; b=DOGoW9UUbTYyrSJ7J/F76psrqjgaXozWkQu+6J1HHq25Gs8x2FXYg/ebOywPIap9ECULKyuYOxX7RDRvuB5CIwSGhh0URaZfWXpy1Klf/SkqoGFudJpiUQdkrC97HWQCKm9SsdIkCzwZcqzaaG10VReHtD5AB3dWBTFMPfiFANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379949; c=relaxed/simple;
	bh=HPEnd6JAQnIjP10NZU8CZCrm6mNCa9dhz9UrqrI5cRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqKEmdVwxqwW3pRfs+9yU3Sk9k6yrqeKwtX8/XshGixDKsFLj7XWcZ3obZnGmECXGCRmYz6LnuN1UCLybqZBYzOTnA5x50QrvQE9PE7OvVpb80vaJAS49C86AX444i7gm0oJ7MjJh+egIsRUJe1KqtBJ3NxCK9Hh26cLEKTAuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=juekqoKn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728379945;
	bh=HPEnd6JAQnIjP10NZU8CZCrm6mNCa9dhz9UrqrI5cRc=;
	h=From:To:Cc:Subject:Date:From;
	b=juekqoKnoOg06UxSpktYZj4iIPllNyx/OYz696QBawWxFCerBChQegtfCH8cRib8n
	 86ZrUM+lrAJD0u/uwHBlYdK/kAIIzlt8Deti5m0vZkidA/2dvXyftngm9ibb8N/8yb
	 OmlY7Vy8cnJi4rI9KSm4kthWBV5K9sObOKs7LASD3J+lZffHs8dBQLm+zCQOQlMTSW
	 fN85AUkVW+TiX0FaQu6dZvLFKgJaNHP3rAhocucT/DA2huj+f/YT7gIcT2YXPmj129
	 NS+omApiExc0Af79AXjtM9RyVW2q+U8n6j3XjOeMSGs0vz5pq/sh0Q55wCeju6lrl6
	 NsKaLm9ZekT3w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CEE8417E0F7B;
	Tue,  8 Oct 2024 11:32:24 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 0/2] soc: mediatek: mtk-cmdq-helper: Various cleanups
Date: Tue,  8 Oct 2024 11:32:18 +0200
Message-ID: <20241008093220.39734-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Dropped patch marking very likely/unlikely branches
 - Removed useless .mask=0 assignment in patch 2/2.

This series performs various cleanups to the MediaTek CMDQ Helper lib,
reducing code duplication and enhancing human readability.

This also avoids double initialization struct cmdq_instruction as,
in some cases, it was stack-initialized to zero and then overwritten
completely anyway a bit later.
I'd expect compilers to be somehow smart about that, but still, while
at it ... why not :-)

Tested on MT8192 Asurada, MT8195 Tomato Chromebooks.

AngeloGioacchino Del Regno (2):
  soc: mediatek: mtk-cmdq: Move mask build and append to function
  soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration

 drivers/soc/mediatek/mtk-cmdq-helper.c | 230 ++++++++++++-------------
 1 file changed, 106 insertions(+), 124 deletions(-)

-- 
2.46.1


