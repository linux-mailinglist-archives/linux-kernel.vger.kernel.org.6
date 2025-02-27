Return-Path: <linux-kernel+bounces-536951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBEA48654
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C6A176338
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD71DDA2D;
	Thu, 27 Feb 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXuWlgTm"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8971B2EF2;
	Thu, 27 Feb 2025 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675974; cv=none; b=e18GUjz2Z+p9UsAxvVfMP2J1Pc9WtqkL9epz7Da7AGe2b601chxLukUS3dQ2wRyxhkegpVE+C084enVJUIjcT5/z/nYQ5XfRJs/ryUJ1GXEdhJgBwIfYOXlNzmv9evx2Q+ucRI9WvZ9wPdJZ88Ocf4NqGrDJnv+G/qshon8XgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675974; c=relaxed/simple;
	bh=DxBxDS7njlYdXtEvqHFAv+PE/paifj80Gj2m8iqU3uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9QOZO3BkZjtdJtB5P/wt5IueZz0ekHTgYxAiKumrYmMeU48reX68gq5zczBivNGbs6BPHlLWd48RleM3OGZRgePmjgr/f/aurCKPMfuRlwXHcR5GY/EUVyXSbVVBLAmGoQ3AKKn94AdJeEy2yzpY3DXwm72XojGjcOxyodLn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXuWlgTm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so783760f8f.2;
        Thu, 27 Feb 2025 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740675971; x=1741280771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ij+1zKEH9Ba/kB5z4KtEJBYfC9RnQvjSfyNgQo+oss=;
        b=YXuWlgTmmI0V6GEjIypk+/P/JRi691edp9vfWgp64FvWXMYmqCx2LTi6HY0viTLdSS
         1A3+Hiv5bOAj8p70Uru/bOkMxOvjwTHeM0YOdoc5fEZnTqv1sVlH2c4QvONxFMWRYQ9y
         COo3Vrf92BhHJj2vKeaDnNrxOzdAzzshele9YPzBBsNK5tOubEX7siA5mx2+AE+4whP6
         Pl5ZP9qMFGJ8iSbbXdNT5rTDB83cm8uAu8w1oHNNplIF28+RYdKvnFsNj12Q7Yy6srcR
         UGZqZFoJwyBHHmG+2tdwA1s6HJjgHC5DLzl9FYIqLe4US4yrdj1vSGn00zsAfdd2L1xg
         XX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675971; x=1741280771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ij+1zKEH9Ba/kB5z4KtEJBYfC9RnQvjSfyNgQo+oss=;
        b=fBdeBdHCE7VruCR/y7CS2y3KV/sdt1w2idi+yCIYSrnZLflw21EibJcgAh7yKZ1BFN
         q2GEyk2PZkUQRlUa7mekQ6aLHu6EnQyEJj1fFkrzZ1eUppvD/3DQVq4WHtBGwtUVwBkd
         EBYTmvyk4xpFDTnOBb/70Tne4VBBwL8WGFDKIqM257c9l1gjP/y9N17hgaNJekMjT+Vc
         w3fbrgPf4XFtxBsq1N27Fj0Z2nPtouMVS1tKvNdDlFb2aZGspx/rlwD/y8NKkCzOkxep
         eEry6U+e3u9OkRIlRfFQDrbRfELu8jXsXoOB60bHdQDWSAeDHN3FdAASWsGboq/b3wDg
         4rgA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0DjNszFKi5dWeFScbF5ayAGMIWCQHNfQkqFfxk9XALtC4tJOx6foQIm8Jhq93Rr+Ki240QmaYBuQ@vger.kernel.org, AJvYcCXaJAZzPh9sXYMd2typ9/pZzQBRrVIU56SbHZlVk/uvu8BnqmXXn2tCiwB4fw6ROKAhEDFbCHWmBawtN8l0@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiBBaAd/jdE4Z2/9tMR4N9rZAPkV5gXDLHTCp8xyIUHtmoGjj
	EP5fstvaqBrcd0k4pYlShufe+q8RuOEPLd7Cretn3DxdkZ3XUF17
X-Gm-Gg: ASbGncv62x1ISR09Zib6CeWnTruvbSJLIN9QLdYkfKmwnWHECiH87ukS5+++fhSTAtX
	byhig8Zykt5W8zkelY/6SzYpmk11qXwsjf5oXcuGI+3A3/W4fZNcLsdjTAnf8HCN9Ivp5g7Au18
	h+nOz2UOBAKSbwvTD4RYIPOcC6T39epfJIJQ/joddsjNJrTlCxElnz2VTrg3TO7Xeki+KiRTCpf
	2YkcxDeoA/UW6037HF8yNMFsDq/DfoCj/n46rrcZ+yWaLXY+sa5d7S1ucwCafJtXSOKXTNrWMiQ
	jP5zZQPO3eB5Yb5LQPyhZpOnb8osv3EpX0fFFLpqjbA+Bcb2Dg9ciKzeSSmzjfd5sfxVaXDFqoN
	GGEek
X-Google-Smtp-Source: AGHT+IFz/HuE+h4ot474pv//qiTEPyaVwEbLVUzle5E5RWvan8sfzGk2Q6TpIzTePER/mMGEQAtPYA==
X-Received: by 2002:a5d:47cf:0:b0:390:e599:5bd0 with SMTP id ffacd0b85a97d-390e59963damr2661178f8f.28.1740675970773;
        Thu, 27 Feb 2025 09:06:10 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dbe7sm2613138f8f.93.2025.02.27.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:06:10 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
X-Google-Original-From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: apalis/colibri-imx6: Add support for v1.2
Date: Thu, 27 Feb 2025 18:04:51 +0100
Message-ID: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/touch controller,
which is EOL, with the TLA2024 ADC and AD7879 touch controller.

Accurately describe the new hardware.

v1.1 of these SoMs is still described by the following DTSI files:
imx6qdl-apalis.dtsi
imx6qdl-colibri.dtsi

The STMPE811 touchscreen controller is no longer disabled by default.
The STMPE811 is self contained within the SoM, therefore, disabling it
is not the correct default behavior.

v1.2 is now supported by a DTSI that modifies v1.1:
imx6qdl-apalis-v1.2.dtsi
imx6qdl-colibri-v1.2.dtsi

For each carrier board using these modules, a new DTS file was added
that includes the v1.1 DTS and modifies it with this v1.2 DTSI.

The original DTS can be used for modules up to and including v1.1.

Ernest Van Hoecke (2):
  ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
  ARM: dts: apalis/colibri-imx6: Add support for v1.2

 arch/arm/boot/dts/nxp/imx/Makefile            |  9 +++
 .../dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts | 11 ++++
 .../nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts   | 11 ++++
 .../nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts   | 11 ++++
 .../dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts  | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts   | 11 ++++
 .../dts/nxp/imx/imx6q-apalis-v1.2-eval.dts    | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts  | 11 ++++
 .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts  | 11 ++++
 .../dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts   | 11 ++++
 .../boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi | 57 +++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |  1 -
 .../dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi     | 57 +++++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |  1 -
 14 files changed, 222 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi

-- 
2.43.0


