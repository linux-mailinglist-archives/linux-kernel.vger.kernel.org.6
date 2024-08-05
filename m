Return-Path: <linux-kernel+bounces-274277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A879475FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37C31C20864
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C281494D7;
	Mon,  5 Aug 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9Bw+mLS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FA1494A2;
	Mon,  5 Aug 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842712; cv=none; b=TrH+iU6LksuXOuU+e0zjsehzh/tTitAo0BgZ24KR7HXU4QLmfB0hxaVyhzzR2og5e9Hk6D2/ynckz6nh4l/zaGaTw3BTU1tMHPzWhNZWN81NL898xh2eXCtvkrrk2dBBAwoaIMUdH3hiPSbm8fcpDRTiVS4IadtG9XQFFOrXesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842712; c=relaxed/simple;
	bh=gcO6C3O8ozuA/h1Za1yw25VKNlDU1+5FzlxfOTi9bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paRaK8H6JxllVZmnOgzaCkCyXOLZjOX8GAIhpnl5Ok4QJ09Kb4FB7jPPf8G0xdLwlG1C0ce1Iz1bDPRWZL9o/zpdyPq6WbfX/4+xjUJQrlV11lvKfdx65XsDoRxgWJvtFBtvSzcZRPSwABxM3xoQZ6l0T76zzoUcVguhp1UmhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9Bw+mLS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so156339121fa.2;
        Mon, 05 Aug 2024 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842707; x=1723447507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hZP3eknURkHBrxTMIgGtPNgy89bmShMYhzI1mjogNc=;
        b=e9Bw+mLS01R8uCtaEVIcV/PEMfBtAGAWBQ1a1ScK5y2ZZh6omlHHlA3XPCEtMWVaow
         3/ZIKtXgSyluPJ+znwwhaQKo+VB0dudt/t6HOsOR1k/NZWVe0RJlf4DEs9iioAzb6i/c
         zHjHM2dDI1FjUicno27GzA44M/lMwNBDiqfAmD8Bz2rseJdc1RWHqg4IExXfvkYYHWNH
         Rsw9iq6ECkrT/rCwCAS+i8gxhehx8Jz4vTT/grzieU7fRVbv/I3Xu1hWYlLrurMtPZK2
         Gf0Fojq2oJuYn4V7uEBDbelikyGBAFPtsO/Nu9j+5dLz3l6kHh7f/JESjyP90/nAwRjV
         WSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842707; x=1723447507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hZP3eknURkHBrxTMIgGtPNgy89bmShMYhzI1mjogNc=;
        b=T6mw5dzckKJgU0aQD0fwKxU9cjAT80iJkaBLiHGy9U3M1n6A6l2UkgRU17xZcOX/Sn
         0i13f5CJGmXqPDe/FNG9Y4ehgnWlMtuZn5SwOtHsOkb0ihzERyWsT/Jp1z48EFav09TQ
         lj+T6MVCRXhsbRUTFFgH9ScOxgHKpGOM/bB2VRaOik59ITyGhjHQiesnWbnQdgGjzN/Q
         YpOtmIPnMh95Hn0e4g/86q4wFtVJ0qTilpscFyv/FQW5Pi65jvwkFUtBkzXwBadAnWQ3
         2F44A4c3IX6Vb6Dzf4MfFoeISGnhQpo3MqSnfRYSJ99/YV/wT/nBDYaADPYFLmB73K8Q
         a3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHYJgiL2mKyPcGfMTHwLwJDkJmp0fh4e3K5G7r/DVqwzV/z8g5RR0FvBQCwZ2uAXIaUsRjpLhrH1iWOtq8+bpC2hwS2AIDgMEt5TYJ
X-Gm-Message-State: AOJu0YwQtvaUVp/qVhqfGGj0BjiRgGgWgVMQ+LhtaL68lpkd2UnE1BHp
	Z7B2wejuX+sIv4jUl4FY8keCgM8AVgnTGWdVNCukiHsOvlyZ2ijO
X-Google-Smtp-Source: AGHT+IH9dakXDOb3Qt+NqQFLrBPdaBci0IN9+mY/BPPXmmDcdOUj2i9WKI4dr55NyKc6rgrOAEQdDg==
X-Received: by 2002:a2e:81d7:0:b0:2ef:2f53:c300 with SMTP id 38308e7fff4ca-2f15aac582fmr71152561fa.28.1722842706926;
        Mon, 05 Aug 2024 00:25:06 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1db70sm8783927f8f.32.2024.08.05.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:25:06 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:25:04 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: sprd: move/add SPDX license to top of the
 file
Message-ID: <4d41caabb6af5741d92bd5567a04c93a18e2ebe2.1722842067.git.stano.jakubek@gmail.com>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722842066.git.stano.jakubek@gmail.com>

Checkpatch complains about the SPDX-License-Identifier being in the
wrong place. Move it to the top of the file to fix these warnings.
In cases of the license being specified only in text, convert these
to the SPDX-License-Identifier.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi          | 3 +--
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts | 3 +--
 arch/arm64/boot/dts/sprd/sc9836.dtsi          | 3 +--
 arch/arm64/boot/dts/sprd/sc9860.dtsi          | 3 +--
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        | 3 +--
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts     | 3 +--
 arch/arm64/boot/dts/sprd/whale2.dtsi          | 3 +--
 7 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index e15409f55f43..fc4e2b1e160e 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SC2731 PMIC dts file
  *
  * Copyright (C) 2018, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 &adi_bus {
diff --git a/arch/arm64/boot/dts/sprd/sc9836-openphone.dts b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
index e5657c35cd10..b98589ea5ac2 100644
--- a/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
+++ b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Spreadtrum SC9836 openphone board DTS file
  *
  * Copyright (C) 2014, Spreadtrum Communications Inc.
- *
- * This file is licensed under a dual GPLv2 or X11 license.
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index 8bb8a70966d2..bc3fc9fc3d90 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Spreadtrum SC9836 SoC DTS file
  *
  * Copyright (C) 2014, Spreadtrum Communications Inc.
- *
- * This file is licensed under a dual GPLv2 or X11 license.
  */
 
 #include "sharkl64.dtsi"
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 31952d361a8a..d2456d633c39 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SC9860 SoC
  *
  * Copyright (C) 2016, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm64/boot/dts/sprd/sharkl64.dtsi b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
index 69f64e7fce7c..bf58702c4e07 100644
--- a/arch/arm64/boot/dts/sprd/sharkl64.dtsi
+++ b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 /*
  * Spreadtrum Sharkl64 platform DTS file
  *
  * Copyright (C) 2014, Spreadtrum Communications Inc.
- *
- * This file is licensed under a dual GPLv2 or X11 license.
  */
 
 / {
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 1ce3cbbd9668..095b24a31313 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum SP9860g board
  *
  * Copyright (C) 2017, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index a28f995fb3ff..a551e14ce826 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Spreadtrum Whale2 platform peripherals
  *
  * Copyright (C) 2016, Spreadtrum Communications Inc.
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
 #include <dt-bindings/clock/sprd,sc9860-clk.h>
-- 
2.34.1


