Return-Path: <linux-kernel+bounces-321310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4226971898
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1F1F238B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09601B6539;
	Mon,  9 Sep 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbKMAASZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0C1B374D;
	Mon,  9 Sep 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882583; cv=none; b=jfrhmyWEYNWmE9SvD5V3/49xi7yvUWWWH8KarYpChPB7+bXpSufON1ADikkzUJEVKGSojswMjl+VyHm7h8yK8X7MRaKiXBOw3giJ3gLQ8nCJtzA4SvEScJSvdzfJ5WzGprfU3ZYJUmZhWX4CXHXcBrBnvSM1CPGTBnOQOLjqaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882583; c=relaxed/simple;
	bh=arZ/aRCI8RjVbmd/qQaYYhDM2KAsOdFW80sGTMcqzcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzvYbUjRb2jIPoCA4SkiJHkqCCUtwW1knnV2+P3T1w43E/Ffcamx11+cmlk7A+I9DO9MvUzlzt8kAttvJKWSL05wpGInmwRiecVCBko95skBiRQ5gO0thquwqmGzCuoQ9mSJJu3PSdF4CLQOmy66s/GE9qBW7LllPGf/UFINgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbKMAASZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d43657255so169877966b.0;
        Mon, 09 Sep 2024 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725882580; x=1726487380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7yMHWrL9ZEdbzgv4FiEIqUx9jdhIAG5hzUCNs4jhJA=;
        b=hbKMAASZbPOSAYqT7tbBW/qK0yXFtLaGcv0VZ6kjzunje6LwaqBNpuxOe4bJDRU9zw
         bQPmElNt6M89RahmIGz4wbpp39a1mjcsRsvCKrLttUIOSCCjG+3MFn7Pp5XvsrB/RV/A
         HQojyhXCT7nAl/8o9/haOc5UXbnhulV7WtlBTVouClzsiW1eDpSLGILlPDVgLUTMn6fh
         gPuBNOXQnRE4Q0EiA19+6jLmLC6K3Q4P1rxqp6VaKkm+EurJZ+kb/hTgYC7ijOHRNypK
         hgEPviCnWvgnpweSHZGpZmnwcuePbwzUfOWLp3mYbT5CQWgQTFOTQciwdqfFMm+oc7pN
         W9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882580; x=1726487380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7yMHWrL9ZEdbzgv4FiEIqUx9jdhIAG5hzUCNs4jhJA=;
        b=giJJrlVg7VbnwagvLx+PlSyanjpPkgPfikK869hYObcrv2MLjRjq39cMGU/FqYVSaZ
         iIh/LxaCwUJr7IUFBwhsyU+99nJfyrQvstYdI94EWJw2Nab8A8CMYmWgwD/MkB+FByIv
         RibJztUcl8f65wD+i3iGYiDCv2Y9ruO/aUpY5o3PdVEjzJQ39isxW14eqM/2vlEexfHr
         ur8O7D1YNQ5l8/0C6xvppN7Q3nZzyDI1vlMBOJha5YxMYzO3n8vBQx/nW22vh6eH7Y7m
         1c6nxuNzhmvQ29OJloA/E1bq2fZmodoh9PDA8HfffCx67UL2u+/TMd7AJzeXBdufs9Yf
         rWgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9BrN8v6qx4Syt4L2QWsEh6V/u4sAwWNz/GHFPkd2k8l7TdtsSESkJV8/Y54/m0mdeTe9afDDZliYw@vger.kernel.org, AJvYcCV/PwhVFiaANu8gzvVByXq17M52FyHlBIpJ8pYThBDcCyLAyno63gF53FY4Jl9WlP7CKv2f1taUJqSoC2JV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6n3PD7Lk86oYQ02pSa0G1hkV7GTPY3S+Wt/5tegD5V3ybN/G6
	VGgVLoThneRWrPy39DNaaCqhEbC3LDniDYLER4Ic/7iMyVBh6322
X-Google-Smtp-Source: AGHT+IExHM2D+8remfomSplOB/lDJJ6KJihVaFo+uM/owHuKgHa7QeZaxVcJWFthdNg6+D0At/ulMg==
X-Received: by 2002:a17:907:72c8:b0:a86:af10:6a47 with SMTP id a640c23a62f3a-a8d2494be05mr550365566b.60.1725882578731;
        Mon, 09 Sep 2024 04:49:38 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835697sm333258566b.16.2024.09.09.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:49:37 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 0/3]  ARM: dts: imx[6qdl|7]-[apalis|colibri]: Update audio card names
Date: Mon,  9 Sep 2024 13:48:59 +0200
Message-Id: <20240909114902.82380-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series update the audio card names for Apalis and Colibri
iMX6/7 to match their specific SoM names, making it shorter (less than
15 characters, as shown in [1]) to fix warnings related to ALSA in
Apalis iMX6 and Colibri iMX6. For Colibri iMX7, also do the change to
make it compliant with the other card names.

[1] Documentation/sound/alsa-configuration.rst

Hiago De Franco (3):
  ARM: dts: imx6qdl-apalis: Update audio card name
  ARM: dts: imx6qdl-colibri: Update audio card name
  ARM: dts: imx7-colibri: Update audio card name

 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.2


