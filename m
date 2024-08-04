Return-Path: <linux-kernel+bounces-273887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE409946F35
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564121F217E2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229541A87;
	Sun,  4 Aug 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="MAAaukYp"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE228377
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722780284; cv=none; b=Ys9vjo1S5G7BysCAhADEvOiZq1SoXnVnk3EHmBfxvMRWpH1NNdKRM28d+CAiFrRiP9GMZMY9RP/xpRH2PsOENdtqjSORM2S4Qg1sMzcspPb6m16paGJn/AM7+DZRF4RVhVd7RbVXRYeGNJmaAGpKU115Rzi2pEBRA81zRIl/AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722780284; c=relaxed/simple;
	bh=zH6zcpfQzEPY42kyNiFsf91oqYp3C8QfOhOqkV9IZaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/sx7CrS2oKw2TlewJRAh+Zy6wMrFMItG5IAjLXzGRPrKPOBa94YFWJGpsL6/xdqcNXL3V7O1CPcnb3wH2qazOntX30kFsxfWjAhKFbPl7FKuIYZGy/nbn1Rdn2P4xWZBVQ7TBs7uc3l455A6lqcd7VuVpKwsjqhxgpk+4ytL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=MAAaukYp; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1722779896;
	bh=zH6zcpfQzEPY42kyNiFsf91oqYp3C8QfOhOqkV9IZaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MAAaukYpINGq93j7et+GA+DZ0I+lLcKwSxb6j8XbwvpWLajTt1SStkn2NQGMXkTSV
	 V42gC57n+/J8HXR7LhT54MhcpRMV/3NrFjjB0ZxU9bhc9MFRfUP/9r6ASN6hoFB+oS
	 1Ccr6W+sTam+c7TlZQeUWdS+uyZK58FLQ/U14BcgKv0YA6sAFB/Y7gJSQc/GtV1n32
	 zXHgkr8AQ+OP9aixMvod7zpglO7c8rVnHfjdlzkETOON3KMECfZVqLbmNRjrkzwD+X
	 HEmszSwgkveKSBSYxV+4UHnIqMsPim9AsrAx673fTkP+cyS8SDqdVuQQ6a53yWhjzw
	 ZxReSFxHnP8UQ==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 88D4820793;
	Sun,  4 Aug 2024 15:58:16 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH 0/3] drm/amd: some trivial fixes
Date: Sun,  4 Aug 2024 15:56:26 +0200
Message-ID: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Nothing serious here, just some bits I noticed when reading code.

Tobias Jakobi (3):
  drm/amd: Make amd_ip_funcs static for SDMA v5.0
  drm/amd: Make amd_ip_funcs static for SDMA v5.2
  drm/amdgpu/swsmu: fix SMU11 typos (memlk -> memclk)

 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.h                  | 1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h                  | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 6 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.44.2


