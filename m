Return-Path: <linux-kernel+bounces-332869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7857B97C00D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7801C20DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597B1C9EDC;
	Wed, 18 Sep 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrNLp0Q7"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAB1C9EA4;
	Wed, 18 Sep 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683729; cv=none; b=ImIfrAb0mILfQ8eVnllNTZIFk4eQZaRDNL8DJLXI4dzXLvt7h4RPX2iTHz/zLXHPxtfT6KvH+MbYBqlns1/E3BWITFQDCYS/CXSmlGNQ5+4Fd21OXyU277fClTDSIGaS0EZoDMc8uU0IpbF/Hxpo5RTEnzp8WkQuyKOX4XkqJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683729; c=relaxed/simple;
	bh=ZCEvC14dHvRX3SiUMZUkZsBt1TWr1h40Lkd4LFAyjDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WWL5yZvnMU3TICRnUtRxwP6YwliAMqsTDcF6UMlM5/85E6d+MG2GFgcBT5Gaah0vCfSfUhtnC3oD297XiP+CowlLnkwHPyOoJ48lJqVbQRAjjNppVFAj7joE4T3/M1PFck2k9mpXj3xsxGIlVTUV0eE7YBgqFp8HSqkrIq+Tm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrNLp0Q7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso453459666b.3;
        Wed, 18 Sep 2024 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683726; x=1727288526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0St+mf41FzHYmfPmGgZlICoo2J/GNAjbeqG7W+7glo=;
        b=BrNLp0Q7xke18tlcSCoKx6xScGubxdkNtGYGa6a8V7PKnCDnOq7zsU0NubZOPuBDjQ
         dSYLkdT599RUA+FciyYhaS6bJXcG9imsvsz3Ldv02iSSM2fg4lFe4LFWMEOq0c3UiWNg
         YuynYS+la3Q4/3aUFhcgpVq1NC5xL+sjzO9uo/ilwy3inppT9ijqsGuH3F+0umth5GIl
         2XDH7K8XHALSQanNUlGogHI6zoryfShD57+rRjkdzLNEjLckfe+eAVn6+yvMxsqVlXEm
         3XYf4ibz3A1nPfGFHYKp/GMzL2wRv/J/auDXQ0bkn12d+mgH6S88SE+0yN5Urm6kvGVJ
         mrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683726; x=1727288526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0St+mf41FzHYmfPmGgZlICoo2J/GNAjbeqG7W+7glo=;
        b=AzJbBbsBO9bRBO9zw73LlgcX8ElN11tiI+uJ/Knra0mMTfOf29/MGcpXawcfA6vXUV
         GoJD6EyYVhXeWl1yc3CilwJnfxFtNJSpA4rji4RwDjsVP10VgS2l77gMaHoxy26VJ+dw
         yN+InsuLvQ/TlVmXh/OOGSchy3Rl3ULVb+gVgsjLmZFPnUfNJrPE1hXLV3wnAXwHtyQL
         o/y6cGSG4/x8zg5BNQUKzV9AE96MZY7hz7ZJvds4/QWqYxBXgHvuoF3j8Pgtw7s9JM9s
         YmYbibDkKxSJEVizr6giIe9ZmXsVS4SmPMZEfaf8OiBJQOEUVBovWcxadH30AQ+OZFVs
         rfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSDDXa8pRuvT3oVZxd/cLGFDOuJZv2xWwTGjPGUcu0Ui8nQ6tF4365i5NfGYFdgNicVUiLtZBENnKXOTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaG4RgeYqGMClJ0Km4gRVtM0mV7fs9y7RTWtPnGDpa/PG31fMF
	VgW1J/Douq6z0mVre9BAQ1f3r2JgMNUSa3N679AKnuG/CH3r1TDa
X-Google-Smtp-Source: AGHT+IFcsPhxvDQ2x+qawg1vcMGzEqmsNX+WtUVNw78yM/hR/+LRU17B4sTsN9bo4xFMqBwOF2WrKA==
X-Received: by 2002:a05:6402:51c6:b0:5c2:5df4:5a4c with SMTP id 4fb4d7f45d1cf-5c41e2af39dmr27187758a12.33.1726683726085;
        Wed, 18 Sep 2024 11:22:06 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:05 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] configure imx8 dsp DT node for rproc usage
Date: Wed, 18 Sep 2024 14:21:12 -0400
Message-Id: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Configure/add imx8 dsp DT node for rproc usage.
Additionally, fix number of power domains from the
fsl,dsp.yaml binding.

Laurentiu Mihalcea (5):
  dt-bindings: dsp: fix power domain count
  arm64: dts: imx8qxp: configure dsp node for rproc usage
  arm64: dts: imx8qm: drop dsp node from audio_subsys bus
  arm64: dts: imx8qm: add node for VPU dsp
  arm64: dts: imx8qm: enable dsp node for rproc usage

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 27 ++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 29 +++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 ++++-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++
 6 files changed, 147 insertions(+), 25 deletions(-)

-- 
2.34.1


