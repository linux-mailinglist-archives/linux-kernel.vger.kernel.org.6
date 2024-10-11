Return-Path: <linux-kernel+bounces-361352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4699A71F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CB4284EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89519343B;
	Fri, 11 Oct 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOzhcHGI"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0218E02D;
	Fri, 11 Oct 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659145; cv=none; b=fonNIII1uPS55fPeKc4DmzMyQDtQVC8Hu3AtggWUNOoHAczpSPMbHGr1X/9lLXlY71Y5K6H/mpdVw55E2Qt5Z15Cu+9oRW4hC1duAVmbADF5A1SxGwB2QnoZoxa/qRoP0Kcd8MYyVxWp+4dLgd6R6hsOfoB5YKoo3Gpoc7uNeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659145; c=relaxed/simple;
	bh=S7hC2uywjAi3J2LiD/sEewm3zShuQTHXN6TAUI1rcwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c3FSFKNECJmImzT2rA+VVAkUjxHMymrS14YCdRVZPgYJkSTsSwNbFWCuKg5ENhxgf8xnK2YilFfd+JT+uyDDp9gQTiduABAijnnpcCOLTsbmilQXJqqDuDXUbBGH1Lmuj0cP25CutOn+NBjceUQJRi01G894xr/QRogTsBokWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOzhcHGI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99422c796eso349064466b.3;
        Fri, 11 Oct 2024 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659142; x=1729263942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLi2DAw+2fMekfQEPfo5D7B5LkOQMf8QQR4y0YqqiDg=;
        b=LOzhcHGIVLnWkKa3REnlQzmocSqyE+z6aGsb8OHN5Po8Q3k1Va5X/KG2wcPCPfceBf
         GmjlBeWIhbKvjfODyA5Hdynd2GBKS/jGKfkl/ACPIHOgBixBc0C2lSTNa7XEj12/MvFw
         VWVBXYByvgHbL9MuEMGHRtZMy/hSoh43hIKTT3wDq4F0kZCnDDTWKt5zghfvPBrL/Ljs
         Pr5zIl2n83NxDow2D/nFIF9rwl/FddUn/k7pORioPWB2oz6+BKWYSsk1sst+TZLMuhL8
         0ubiYQT36/R7Al5hnRY1+1Mw3uW6y3BflQIFBDzq+RFn+HUfNKRCpXdNJriPxDDmmGw3
         qmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659142; x=1729263942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLi2DAw+2fMekfQEPfo5D7B5LkOQMf8QQR4y0YqqiDg=;
        b=dMqVvsNzPEHk78qGsMZC/5+7HKz7MuDryQAk150hBLSXkrnmr51F+iq8nFFk28kZud
         9bK4AQzQOoflD3EBgV8Qhjb103ogM0KBW2eYfuF/Naj+PljHk+2HiXUxJXTeXmWwzMxN
         QzUj7t37hDK5hDlT+m6VSfXbXvwdwTBcavKZbL3Tot4q/Jjfj8APMso4A/kA1JTNq+Yw
         dPS7yksT/XBJ/JAzD4PkqqSpXQKQn0sH/CjRmlwwhasIsxC5JY/RBMiyjrQO+kWOnPQX
         FAe8pz8ET4XbSQGkMrZSt05/GuTQ2EOmEk8F2r2a+7wKAtqpzPxzwS39882peQuGhaJY
         gq2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJp9BHNrrWbLXBVzKmDFDiY0kBW4v0Yd7aEWfxnCdC7+5ORtABpYC349mv8NPr8JE0Xft1cuAVn2hzrTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkh8tl22JOvBuSNzCz1+mw9nR0w6w/w9vAd/L1pJT9+w10XSIV
	vetzS6tbPjel1YYdm3yC9CGfeRBHvw3nFp6ZJe3pJCTfyXUWDNPm
X-Google-Smtp-Source: AGHT+IHR8U61EsX5VMeZ4KH4278MjiC8lHiSwSBRd4SFpOrYz9cno9dfpAt6fts9S5Z6KeqeIRXxaQ==
X-Received: by 2002:a17:907:1c81:b0:a99:374e:f3cb with SMTP id a640c23a62f3a-a99b95bc034mr235078566b.46.1728659141728;
        Fri, 11 Oct 2024 08:05:41 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:05:41 -0700 (PDT)
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
Subject: [PATCH v3 0/6] configure imx8 dsp DT node for rproc usage
Date: Fri, 11 Oct 2024 11:04:33 -0400
Message-Id: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
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


