Return-Path: <linux-kernel+bounces-374701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FC9A6EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C1C281183
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475561CBEA3;
	Mon, 21 Oct 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guqj88CE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77371CB532;
	Mon, 21 Oct 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525981; cv=none; b=Mk/kpMvbGIUegqD8erDftlqNcrO9HCsTxA0TYRGsJ9zbW3y9lYEs83TFo0mxJllUSmCaQ+jW62BEoHyrY7bXo+8p1xrDh80rbvNg9r96BGsoyjUZdO0FgqCqrOCgf3pv+LgPh9ScTekmnHe+xzverCHME215rhItuTiuz4Ukres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525981; c=relaxed/simple;
	bh=wmxVX9fcZuDtfkzm0ip9rDTLU/O3snfpBq3znQ/y7PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VecVE64KT3bwZ69cthHDDFVbesGtVayf9QBqsGftOT2jmqJeW0y15dxYNlUX/KS9uptc8GJZ4Ou4SjjK4uQ1aXy0hrAuRj6uSTPfMkIhU94jArmzgPBj9w2Vcc9Lj2WTA8B7qm8UzGxOFJjLVm2qhDmczz3HaJgrnVkntFB6PpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guqj88CE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so5587277a12.1;
        Mon, 21 Oct 2024 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525978; x=1730130778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O214AEf+5QWb64FzF1gmY40U1SdIzfACVup4P8JOMY=;
        b=guqj88CErHA0LLieVU1azO/Zhwj7LCQQHx1IdXu/LU+6zlBOvRD6bTXWWzv4xR2xq0
         Q5v71Qk5q1VnGiI5TThU/yWBv1rWptwaMUoBBgaqA68l5qSYxAFFr90SGFG4V8ytsYZP
         9kfHkLX69yvWTCl3mqLUL3zZmKzL8h3BNRgHrPVkfNX+9MpBm3296kSDvlG2uu7N1anS
         M4rhoQ1mtRgMXzNBNTgepzZ4hEoqqzmOr5yjqNyLiQo1+cSEGad8Im57YkAV7Ezv9VlF
         m7RLvOw23NLt7fE9AfpbNPSE49N7jztka42i3aWAjdYLhItqKxArxOagjdDg/PKlhyC9
         AmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525978; x=1730130778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O214AEf+5QWb64FzF1gmY40U1SdIzfACVup4P8JOMY=;
        b=IS6+m6f5xe1PMeUCIJQvYWWcgUZBiLM4fHfA+Mcgbww/cTbzSSutc6sNGgWibA1gNd
         12Gi1waNZevMtvpd63hDLjqszm+WhjV1pzD/GhSt0wUUcRja28+PhzbSWTvh7azUctDO
         7kvw4qtUIwJSMpZR0M9+rzgwm/ok89vrl1IJfqnzVJmz2u/+7AqrwGjidpimbJDKUhZC
         TiYYIKffo550VSBrDCOlLl+gx4B4U2s10/OxZ/3RXoER5+ue+q+/v/OZPkZI+gVFevtC
         kbQbHWJ/Sk/KMNbnk79cM6dCIA+qM45B6VJwQvhXx15ZYaDpAriFIgYvD6lBXdvsyJhW
         Sxag==
X-Forwarded-Encrypted: i=1; AJvYcCXE9wOmAmB01t0EyyMYfogNp/9BbPg8AG1is5Go87SCAhzBn18H6V9do2xOX0f1yBEqbL710++ggsum0u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37pAvhpUMk3qjrlq79T+bEnduZcVhUd0SFWm6zhaPG/CIUg4v
	Tm7RU73b5WRRP2+tRhp0604JL6i+hMKEWNfjAGy5XwgULKgAQu8G
X-Google-Smtp-Source: AGHT+IHtQDbhUtozFKhbPGAeSjBWR702lhB9UgQf3G3sRaGWb7ObgCxPw9zhhC5M7xJ1P/JX6p1l/Q==
X-Received: by 2002:a17:907:1a50:b0:a9a:673f:4dcc with SMTP id a640c23a62f3a-a9a69a7b277mr754959866b.22.1729525977697;
        Mon, 21 Oct 2024 08:52:57 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:52:57 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] configure imx8 dsp DT node for rproc usage
Date: Mon, 21 Oct 2024 11:52:15 -0400
Message-Id: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
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
Additionally, fix number of power domains from the fsl,dsp.yaml binding.

---
Changes in v4:
- Added Krzysztof's and Frank's R-b's.

- Wrapped DT commit messages to 75 chars.

- Placed 'mbox-names' after 'mboxes' property in 'vpu_dsp' DT node.

- Link to v3: https://lore.kernel.org/lkml/20241011150439.4027-1-laurentiumihalcea111@gmail.com/

Changes in v3:
- Moved handling of IRQSTR_DSP PD to fiwmare side. Now QXP has 2
mandatory PDs, while QM has 4.

- Dropped the optional PDs. All PDs are now mandatory.

- Dropped Linux implementation details from the binding's commit
message.

- Renamed reserved memory nodes to generic "memory".

- Split QXP board and soc DT changes into dif. patches.

- Dropped comments about SOF and rewrote the commit message of the
patch that modifies the 'dsp' node from 'imx8-ss-audio.dtsi'. Hopefully,
should be more clear why the change is done.

- Squashed arm,mhuv2 binding changes.

- Link to v2: https://lore.kernel.org/lkml/20240925232008.205802-1-laurentiumihalcea111@gmail.com/

Changes in v2:
- Modify subject of commit changing fsl,dsp.yaml to state that the change
is for fsl,dsp.yaml

- Fix issue with arm,mhuv2 binding found by Rob's bot caused by the
changes to fsl,dsp binding

- Improve formatting of commit messages

- Link to v1: https://lore.kernel.org/lkml/20240918182117.86221-1-laurentiumihalcea111@gmail.com
---

Laurentiu Mihalcea (6):
  dt-bindings: dsp: fsl,dsp: fix power domain count
  arm64: dts: imx8-ss-audio: configure dsp node for rproc usage
  arm64: dts: imx8qxp-mek: add dsp rproc-related mem regions
  arm64: dts: imx8qm: drop dsp node from audio_subsys bus
  arm64: dts: imx8qm: add node for VPU dsp
  arm64: dts: imx8qm-mek: enable dsp node for rproc usage

 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 31 +++++++++++++++----
 .../bindings/mailbox/arm,mhuv2.yaml           |  2 +-
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 19 +++++-------
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 27 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     | 28 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 21 ++++++++++++-
 6 files changed, 109 insertions(+), 19 deletions(-)

-- 
2.34.1


