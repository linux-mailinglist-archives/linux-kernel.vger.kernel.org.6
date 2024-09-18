Return-Path: <linux-kernel+bounces-332501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51897BA88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046941F278CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F417C7BF;
	Wed, 18 Sep 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WPPeRgyH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F055175D54
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653996; cv=none; b=cQ2feY0rBfser/BIJKTZQkBFpKKRj88dy5W1ERlOnKOf6JWX0d6qA+ubYtY7nE/rzZUCpg85OY3jGzNtMmeF6E3oR2ntDtukgP05OIF7gqhQbEft6Yotk/XMsd4qPlISbP/ve/2Q8GigpEf9pZmtYXRtJwPU9Q+SIVweLeYDgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653996; c=relaxed/simple;
	bh=ks/I8Rft33hUuiHWwdweAz1/NAcXILGYy4txuTbhcBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5DPRsKUCrMLMBS/WD+x4nJejmdkfW1Z0wHCp+OVB2tOfMsF+m5b0vaqrLK5um2o3SfJamws1BaclRLVv7p5tkbbsGLhIYxIlmQ1Qz0z8gcLoqHSFyg2Jg3ErXuqOMGlqnjYxS5SuGERuivf5VushU1aGBWPsmqL4yA0yn/8C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WPPeRgyH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726653992;
	bh=ks/I8Rft33hUuiHWwdweAz1/NAcXILGYy4txuTbhcBw=;
	h=From:To:Cc:Subject:Date:From;
	b=WPPeRgyHQ5qEqoiD9QZHz4FyvmYBM98QY9ys4ZWshHtJMJeatPcokKbtjC8kF9P/G
	 Z9iTOQsR9C0PcDEkPrl5hRWljwjR8icYagEVqTTf7Vh3j2fNBcslIZJJF4JcMEJPRe
	 xW8rTo7496RGtJ7J0xzmx6wR7Joc25VuwVjiqwNR0JlxzJ+kcBKzLBlZttGthPRoT4
	 ppY+NzUajxGqD4EI3fs68XY4tCUsgtDaqyHsZt/JY2VjK32TgPsG6hHnK5RKffYyQ7
	 VjcJNFMQL5RapLiBf1/ZDto2VpuQ1/1BkyEF7+5uWNoPFscVPn/azWgYY0Rr+UXtQJ
	 cnl87owaem+zw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 482B517E1097;
	Wed, 18 Sep 2024 12:06:32 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/3] soc: mediatek: mtk-cmdq-helper: Various cleanups
Date: Wed, 18 Sep 2024 12:06:17 +0200
Message-ID: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs various cleanups to the MediaTek CMDQ Helper lib,
reducing code duplication and enhancing human readability.

This also avoids double initialization struct cmdq_instruction as,
in some cases, it was stack-initialized to zero and then overwritten
completely anyway a bit later.
I'd expect compilers to be somehow smart about that, but still, while
at it ... why not :-)

Tested on MT8192 Asurada, MT8195 Tomato Chromebooks.

AngeloGioacchino Del Regno (3):
  soc: mediatek: mtk-cmdq: Move mask build and append to function
  soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
  soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration

 drivers/soc/mediatek/mtk-cmdq-helper.c | 241 ++++++++++++-------------
 1 file changed, 112 insertions(+), 129 deletions(-)

-- 
2.46.0


