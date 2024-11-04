Return-Path: <linux-kernel+bounces-395478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C329BBE80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F408B2109E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747E1D3195;
	Mon,  4 Nov 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KeWPJWVC"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA518D63C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750652; cv=none; b=b1EQsVBG7Tp9Rj2HkedwV3INl+q3RIMeGIXEbRvzI5XJNUtcc78Axi2Xcu2p/zkrPXMoI54ZVITxk8V5n7WQ422t4VP/BBWMcxXJzIRt4IqmimMBdAphi7zxHcVHaigr0WZPVvu3IyV2S3vFawt/xOs9cUJb/OaxHInSqmH5rFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750652; c=relaxed/simple;
	bh=4XZpNgir9vw2t5UNDyXFv260raUXcPLfPovlq03mVuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLXOWPyQRHj+GJpC3Czln2+RCQAhti6nJhBK6IGpdIzS9Hdk9m1aboYIoGuNw75cllJnbr0KZ736sG2qVAqQedyI5a/ByXnYps7oUzglnOxVt3VNdylptWthylV0ubw/8UI5AGnwfM0xyGWZoEcgzpTwFZb4xTWiyag0yTC92cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KeWPJWVC; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730750646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ylQFc/OOYVM30hSaKoL7NXIWVa/EQ8JYV4MG8zHIVTw=;
	b=KeWPJWVCL6KoWFKRSwndKe/+KUb4jgXv5wPi76Pp7Hdo6ZD+AoE8/2bsMjmhNGaJVBiAMu
	YFoQyW5os3AhA8mS+uR3QReakB1MD2fH1s1WOy1xhhzYHlHeqqGxbyW92jRPxPKyNkzOTU
	xPKVrthdh1P2SHCF+BHTq0TZX+sy7S8=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v2 0/3] drm/etnaviv: Trivial mmu map and ummap cleanups
Date: Tue,  5 Nov 2024 04:03:51 +0800
Message-Id: <20241104200354.656525-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'offset' data member of the 'struct scatterlist' denotes the offset
into a SG entry in bytes. But it seems that nearly all helper functions
we are using will hardcode it to ZERO. Under such a case, it seems that
take the 'offset' into accounts are just intoduce extra overhead. Waste
CPU circles, then is it correct and safe for us do some simplification
now?

v1 -> v2
	* Reword and fix typos and mistakes

v1 Link: https://patchwork.freedesktop.org/series/140589/

Sui Jingfeng (3):
  drm/etnaviv: Drop offset in page manipulation
  drm/etnaviv: Fix the debug log of the etnaviv_iommu_map()
  drm/etnaviv: Improve VA, PA, SIZE alignment checking

 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
2.34.1


