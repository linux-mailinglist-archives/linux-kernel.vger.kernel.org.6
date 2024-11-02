Return-Path: <linux-kernel+bounces-393404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB59BA022
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E14E1F2190F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58518A6B5;
	Sat,  2 Nov 2024 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="QsUKEfVq"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8213189F36;
	Sat,  2 Nov 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730552396; cv=none; b=fioekduAu1AO3GMqvII7Ovs7UIfkrV97NH5v4Cmv0y2yxs+TkCaiFE0HNeKdZz/Cru0jt5d1vf7XWiyFcCuG0nn9lGFcaW0xjsw96hibRXSu0UIpyqWS7DIv7+yWIiQFPQBXsr57KdWH42+DQgYm7wM2uWNRY3qLtX7REdY/NX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730552396; c=relaxed/simple;
	bh=A1w/WpP4A1ews/F9trz0Z1j9d0UTUytKp/ywB+GamP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fLMykMc9Ft8F8Ly3CkbW5Sm2oC+y5ydRxV7sGFj0AOejnoBXp8X6uLgSZqPky+6omiGogjEu/8/kkVc83TGzq+JBVT7TP/rFETw7r12NO95EHBqZI3Pe9C943/QSQu0dEUqMVv75e60E/1oiOZlQBiAvsuH+UgO01KehrmcBrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=QsUKEfVq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 39055A0ABF;
	Sat,  2 Nov 2024 13:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=vqPDYISQhDcdF9k7RpAdqWVUZzTmtGJFd83DpIDrdGI=; b=
	QsUKEfVqitrTzYosF/xicaTzE3y+qfLnbl5xZ4ryYgdo0NNSg+dEsDpTzxmFteW3
	xHdM5i2a0WATN0G7fcR3RtdIKaqpo8yN0k139zULhT93JKol7UvtJpHWgu3pftIk
	fEbzzkrq4/OqVbXGCR0kMdsQXnOLYbg9K3QtX2jr3x8H39hJOKaqMR1rivlOptEE
	S/7c0KJvGfQyEeOauruNEsZ6aWznhNdhUi4DcicYei2z9xwbSpE/UzdceBPkxXkL
	RMb7Zz8EG5dzzFRFTA2PIdF/Ojq2YQa2T8/35qpyrZd+upBYAISpU7f5C1hfJ89T
	adVd6KhKuO8ysWx5AbgIIai1CtybyBpoU9/yzDVBHtkXywg5ALomHB+Hufh3ExIg
	p+EjLJgTTKb7v5AOnMWk8FWZJkx6CvaaJU/plYiqmZZ+plISIW1RsIeuB1KHY3zh
	GFo2IujaxRtRPGli8gf0xnKJ7Yhu8e/ZIr8+L1WAEEhUz3dZI72jBrsplHaSbczy
	ELDD5nU6ttQwT9YyHTcffCq8d6EY0UQFtoXIGrwcTWGMqaM6wkNbvZhk32d3ybXO
	qEEx4tu9F7PJDx8zE/sq+NCi//vHBItokfOZ5nvAshVZ1gJa1L4MUTS0CP1vqgpv
	XkIhJmpwanXb9fgpBQBypGSmEx0xfu6qpfyag9A/mZY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Mesih
 Kilinc" <mesihkilinc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 0/3] Add support for codec of F1C100s
Date: Sat, 2 Nov 2024 13:57:09 +0100
Message-ID: <20241102125712.2647325-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730552388;VERSION=7979;MC=637395765;ID=222165;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485566706B

Support for Allwinner F1C100s/200s series audio was
submitted in 2018 as an RFC series, but was not merged,
despite having only minor errors. However, this is
essential for having audio on these SoCs.
This series was forward-ported/rebased to the best of
my abilities, on top of Linus' tree as of now:
commit c2ee9f594da8 ("KVM: selftests: Fix build on on non-x86 architectures")

Link: https://lore.kernel.org/all/cover.1543782328.git.mesihkilinc@gmail.com/

As requested by many, this series will now be split in 2, the DMA and the
ALSA/ASoC codec driver. This is the codec part of the series.
The first part (DMA) can be seen here. This series can be applied and
built without the former, but for working audio you need them both,
plus add it to Device Tree.
Link: https://lore.kernel.org/linux-kernel/20241102093140.2625230-2-csokas.bence@prolan.hu/

Csókás, Bence (1):
  dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec

Mesih Kilinc (2):
  ASoC: sun4i-codec: Add DMA Max Burst field
  ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s

 .../sound/allwinner,sun4i-a10-codec.yaml      |  31 ++
 sound/soc/sunxi/sun4i-codec.c                 | 365 +++++++++++++++++-
 2 files changed, 394 insertions(+), 2 deletions(-)

-- 
2.34.1



