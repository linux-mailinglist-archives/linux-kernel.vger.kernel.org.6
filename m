Return-Path: <linux-kernel+bounces-324891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E448975230
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8F728185D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B7F51C4A;
	Wed, 11 Sep 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FLzd5k13"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AB192B61;
	Wed, 11 Sep 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057774; cv=none; b=mVPIm1XHdqxfwg374fMrOGnV4Sk4at+fBDTeV9qO8ksauiNYXghsLzZDjvW9AgJePW/2rMwkqDM5ZS4Rngh0Lg+9GMSWIL6JdY2fqWCO1VkhlDKHagA6hm9WSFw0qSu72EVZ5bjtmFYTqVr686vy2oAsSa0zVpUhYhOr/5iViao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057774; c=relaxed/simple;
	bh=QvFkFjmTvJ1ESC2x19Ky85o9+VWa1Z7r9DQ/wvoNEY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lf+oL+9jxhtlpZy9+kQ6/7MwFoJ4kO9/T7/ARNKrvvy/RcRKO92Su+ujMFOsaMjp+AC8ub7WtoTAEfqsfohSdvYhx0h/ZrLMUIKSMY8LfMZlvviZ+J7eKpKEb+ZALGppmN8YOeb5qXg74N23fSe/qz+13deCiAgAmnembzVuiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FLzd5k13; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726057772; x=1757593772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QvFkFjmTvJ1ESC2x19Ky85o9+VWa1Z7r9DQ/wvoNEY8=;
  b=FLzd5k13GV4Yp8i/s4zB1sjRQtI2GjO1Pkf0DaYe7c9dGB6jGM3HUdjr
   pU1rfp+e4yy57ZkQjuSv373NyVOQCq5Y7zcCtOhIihLNtDq38REUngcD3
   uu8YR8kagYH4ON+FelwOG428/pNXP6ASiy0Wo8TEithzhOj3K/iKXY8/+
   Vi7PxZl2KKzdkoTII5AHUw9+4nFN/XaOYd/YpEjTmZLPY4PD4ShmoSGTl
   Nj9cnhMYLvpws1DShJvS7zWJvswlb/CWjpYTWKQQElGNrrYo0Db3+zAAa
   Z84KH5q8Jw0ZC1Uz5KqCbELboRk3f2Lp/F+eNASxfU+TNeBnlBqWRKub/
   A==;
X-CSE-ConnectionGUID: 7yc5wvIRQsyrcBgBTvQNrw==
X-CSE-MsgGUID: cheCQQscS76IUrzwlChwnA==
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="262627889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 05:29:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 05:29:14 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 05:29:11 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/3] Improvements for mchp-pdmc
Date: Wed, 11 Sep 2024 15:29:06 +0300
Message-ID: <20240911122909.133399-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set is intended to enhance the functionality and maintainability
of the mchp-pdmc driver:
- Enhances performance by refining maxburst logic.
- Introduces a name for better identification and management.
- Ensures controls remain intact when streams start/finish,
  returning -EBUSY if the controller is busy.

Codrin Ciubotariu (3):
  ASoC: atmel: mchp-pdmc: Improve maxburst calculation for better
    performance
  ASoC: atmel: mchp-pdmc: Add snd_soc_dai_driver name
  ASoC: atmel: mchp-pdmc: Retain Non-Runtime Controls

 sound/soc/atmel/mchp-pdmc.c | 118 +++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 55 deletions(-)


base-commit: 6708132e80a2ced620bde9b9c36e426183544a23
-- 
2.34.1


