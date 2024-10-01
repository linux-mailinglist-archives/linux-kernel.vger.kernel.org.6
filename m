Return-Path: <linux-kernel+bounces-345784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5F98BB19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5971C231D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526D1C1AB4;
	Tue,  1 Oct 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haHPx4e4"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49419AD48
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782278; cv=none; b=CUsGFRw7vgVVhauzP42KAE49hMC4rgNMcVa060pCBqTatvCFQVt81c1n/Af5ljH32ptoZycB1YVUZPTpfNbQCMkNT+mjgrfoyo7JSDhtFpw4P0hE+pKFD6E93L1pAB1W9iNiap8wlu1lCZWW9jpDvulptBUmE4kwoy+cFEV9u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782278; c=relaxed/simple;
	bh=xNq7dd0QQAzKdyjPQjXshn7HgVAnKT5ZeUNDrPDm3cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzOls/lc/BOCzatYXnMDHoL9Xaz6NUULK5DZvmEFAV0mI1QJAaowBgY+gC2JXV4tIjALaEl9yDTTvvUbQRs5In2sb8vWvdxQTzFmmnf/dIdwAwGKeqz2KNj0JlUNSIhV0eoyASFAdWGUNSmjFcJha4ho/zXO4pLO++0ihkMj2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=haHPx4e4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71b0722f221so4169214b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782276; x=1728387076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkw5ZjTULYmnDhqzTqOvsBoCEBWuQcvkFtFk7rwLDX0=;
        b=haHPx4e4tas7WGpON8puSDU2FPzsO3z3it630Ua8bijGgwqhy/pADeyjvipMyU45LG
         eNswpYijDBDST0fQ0P5HsH3UW9xhcotGUHgt74OLkguH9neX7dQgRnUVcjJqntLfDnBH
         bSv63yKLr/fOuKzql9vAEzjg8CkZL7e8Mxc30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782276; x=1728387076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dkw5ZjTULYmnDhqzTqOvsBoCEBWuQcvkFtFk7rwLDX0=;
        b=kbfTIgynGPGoJLh3gVT/1BropBYhfJgYmb51xjVSltV8fNrpDZGIanvVF/QryhKr0B
         RZ8vAYSRYKdNp61vlJLyhrGD3b2EUC61nwz2kXJj6qGNUBolru2QttfHI62xmKrtdMV9
         AQjZXpiVMcjnTpgwT5Rg14NpmV4+wy3OrU1S19ZSYZwzK/hTvdjIQe8FmfdkZmwYkwfn
         /bxJFpcqMQGBP7lMAE2sO1EWgcYWEfIjbClH+M4I0Qwj2huXn5T0qoChyjQFuX2MWlyI
         W1ePJNGfm6D7iFAXxhohxvdN+vd3pZ8UNL412+R8K2bKgwEaTkvVBRaYQVlfhilZAO9q
         l/fg==
X-Forwarded-Encrypted: i=1; AJvYcCVRiyIexlSixaAqbG7t+R5JDIW3hsrrC5QXVCC/0FlzYk0WsIfF0GKcSCkKOu1QcIorzIKKuxxB0IdddV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mNFn9eBvO9D+NfsIaboeMDngX7F0dJjrqzL/fHyHSuFNqcfC
	JqmBao6nGDN/fhWLU7hoHrHr9QnaJ6bt95dz/BJDZ7R0Pm9xZ5Kqx+q4s44VPQ==
X-Google-Smtp-Source: AGHT+IEFyHAzeCxiNj5YqUp1sXh7ztXqQKl/I/N9BtpUPW8sRSj4zlFPq+dVnC9EwBiPLWiMyOrcxA==
X-Received: by 2002:a05:6a21:3305:b0:1cf:2513:8a01 with SMTP id adf61e73a8af0-1d4fa6cfb88mr19356853637.26.1727782276389;
        Tue, 01 Oct 2024 04:31:16 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:15 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Bin Liu <bin.liu@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Xia Jiang <xia.jiang@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/8] MT8188 DT and binding fixes
Date: Tue,  1 Oct 2024 19:27:18 +0800
Message-ID: <20241001113052.3124869-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is split from a previous series[*] to focus on few fixes and
improvements around MediaTek MT8188 device tree and associated bindings,
and addressed comments and carried tags from the previous series.

[*]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium.org/
[v1]: https://lore.kernel.org/all/20240925110044.3678055-1-fshao@chromium.org/

Regards,
Fei

Changes in v2:
- new patch to MediaTek jpeg and vcodec bindings
- new patch to move MT8188 SPI NOR cell properties
- revise commit message of vdec power domain changes

Fei Shao (8):
  dt-bindings: power: mediatek: Add another nested power-domain layer
  dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
  dt-bindings: media: mediatek,jpeg: Relax IOMMU max item count
  dt-bindings: media: mediatek,vcodec: Revise description
  arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
  arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
  arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
  arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties

 .../media/mediatek,vcodec-subdev-decoder.yaml | 100 +++++++++++-------
 .../bindings/media/mediatek-jpeg-decoder.yaml |   3 +-
 .../bindings/media/mediatek-jpeg-encoder.yaml |   2 +-
 .../bindings/pci/mediatek-pcie-gen3.yaml      |   5 +-
 .../power/mediatek,power-controller.yaml      |   4 +
 arch/arm64/boot/dts/mediatek/mt8188-evb.dts   |   2 -
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  33 +++---
 7 files changed, 88 insertions(+), 61 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


