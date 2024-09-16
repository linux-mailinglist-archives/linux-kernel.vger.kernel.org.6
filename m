Return-Path: <linux-kernel+bounces-330376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72C979D46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D355F28215C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B6B148310;
	Mon, 16 Sep 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mw2GZFHm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D013AD2A;
	Mon, 16 Sep 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476816; cv=none; b=tLX3bStxDUHv6BunLjGpllCKJxA9OQIIPwkY46DzdtHfs9WT7oKFkvWD/dY3OHTcQHqtKJjyIGU+Cc6+zQrciQboOPj6iZdIZfdwVb7gBWn/9nci7jgLhHr/hbz9iJ5tcXe1iJjQv2aaaNG/KftSngyCZWcmdXt95roLyRP4ANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476816; c=relaxed/simple;
	bh=agf3oeyUZwHA5yCPkUYoM7WwczxPeDgbJzbwLLz7fCw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WLBllIcHGW9ukUxLKcJJJabYbTmtWLDkSTSndiKIV1QN3oGL9SeqV2W8Tt4ICzkRGvhzBwGsATdWYBo3BjqShSrtpaFKt0b08QLfTA/0eZLCF/JBNy47rgfwfvcQhT5WOt0srgXdBQBOBmQRGITrrZMmRAcEH6OSvXwo6qVg25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mw2GZFHm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726476815; x=1758012815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=agf3oeyUZwHA5yCPkUYoM7WwczxPeDgbJzbwLLz7fCw=;
  b=mw2GZFHmW3DFmyRb8U9Wvj4GRT7IM3Fe0XBhkmpraw4v6VrOkp4VLuvI
   SAoF8fOL4pW8uHN2JRRdKbm0sEZcBUYzM8/4Ltd/+A8jzzdSsjq5LGSIc
   GTa9+6zx7iiQAjv82Mwo4yuOzF3T2qAoT8JhH4xS+SdiHwbzr8O3Rn0yJ
   NQYgqSVWe3yJpLIkRvTZ0yL9Ga2BIvWEN38kH7Fd75QbVFqv5oHZzJery
   Ka2GxfytapYWL+xSxSNBCkeCinAWkf4xy4WP29FyCv/22XLXXMlOz4HA6
   M0pvUB4fOb8Up+pw6ZRO9Djg/AZo2kMXoJP5NYvhFW9De9E0o0++SwGec
   w==;
X-CSE-ConnectionGUID: ud22UtPZTBS6TJ0gR5tqlw==
X-CSE-MsgGUID: 8xch8a0mSs+WNU1z0l0vJA==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="262819277"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 01:53:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 01:53:09 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 01:53:06 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/2] Updates for Atmel SSC DAI
Date: Mon, 16 Sep 2024 11:52:13 +0300
Message-ID: <20240916085214.11083-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set includes two updates for the Atmel SSC DAI driver:
- Address the limitation with the S24_LE format.
- Add stream names for DPCM and future use-cases.

Codrin Ciubotariu (2):
  ASoC: atmel: atmel_ssc_dai: Add stream names
  ASoC: atmel: atmel_ssc_dai: Drop S24_LE support due to single channel
    limitation

 sound/soc/atmel/atmel_ssc_dai.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
-- 
2.34.1


