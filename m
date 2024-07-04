Return-Path: <linux-kernel+bounces-241546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DA927C6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388311F24635
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8C47A62;
	Thu,  4 Jul 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM+6T6Da"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B346447;
	Thu,  4 Jul 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114970; cv=none; b=gWueDAxqJOuwqHszXcHeTfICsiiHtYsQMZtjcITwUN53DO4Ekf+oaUebKkpjFp5d9wnvwQAXeBW7Y6CUZGctHKFDlg0IKpN9FB9XTNW4boOtWUOxg7z4g1vPM9wwu3qV6hoR3vpTm79jrSQT7G8ndkfadTAI6jT9A+jdegekrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114970; c=relaxed/simple;
	bh=B8/wTrWGfYTi4a470J4qHvN+BJlaqWxEwvi2IHEsF8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmXnIQM4QUZXTFnmY2JDeFmwacnlVgxiKQuLy1/DwiTbg2Tl34ALITSX5XPNTWohmKL6OnAvCeWXQYuBLC2i77HGE4yXMBtqLwVty1fVkgTZtUGnJ0GV43bk3LMdc/Q0uTYCLoY00VlfPTBMtUAGcOhnQN3mel4+2rcZvv4unQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM+6T6Da; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367963ea053so668425f8f.2;
        Thu, 04 Jul 2024 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114966; x=1720719766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vtZ/w5zNW89im8HqRZwOomQ2OX/mj8N4Kk6rmuQv3s=;
        b=cM+6T6DaYL5mXpLdd2ZcjXs2VelKcQDBxTifTBq9P0tvxkpL+cAZIWePovWmR65xHo
         3vDm62uugPcjJxznVIvUnEjQSVqT3xKFieMhJrpGroCrBuAoioIMgHspwLG2asmqywGG
         kdyt/QH2x1MySjk6J+DW90vbYop/2nQer8rd5OI8kSLD9Epevt9iRaATHa88wiLzbu6I
         +uZEwt8HsKX2NHLubST3cAXvzlM+sl6Rrpisyg0qSxZPdgPLmhKXNG0HzdJQxdIqeY+X
         pqIxLFpVsqzlfs+8y4IoatuJWg8s8ZM/L8Q7BWGBaeOl3rcLBpGbkJ+N9e+rcrFRe9b0
         RUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114966; x=1720719766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vtZ/w5zNW89im8HqRZwOomQ2OX/mj8N4Kk6rmuQv3s=;
        b=OSSbRMSUC12tzNYBPMd/cf++1cXZUC/B/xX3HxVxy2WTC1RHxBgQdr1zxJ4pUEZceW
         CpAYw3RKquh0fihh5+d4XtyYudsDbrrcDUjqlGpYGdCghNHwwS0QsWERoUlLZkCQjmfL
         wDLxFqqNqGBHhn9xNZvpZzCjuPEYjXrOfF+udVEqBGj4HwhrgItrzLCFXwIUHTmeypH6
         jaLKhb5SclKleCNta2I2xjm8Ib1ijhJN61jj+MooZGky9QYJ03np9oIpdKHs/r0op3zK
         MpogN7ViFPlc1JUrQKS4r6Uio6OQ/4cK4b4o4NpmRjLA/V3bPiWJfmGqY468Db6S2GsK
         LgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOEYDkqINKKMdcPVEHMJD0lvtSq+DBClUSyNKS4DhA3RHUgC+KoZuh5Q4jSu9EmB0S6zJlEpQSbLgJ3CwtfCerex+SBkmOJxpzf6yZ
X-Gm-Message-State: AOJu0YytS0mb3iTlpxYiMyEwoPFVfaLecU5U+IxK+IKkmL2XJZTW6fyF
	pHIUDkr+yvdGMFC3HCmOncuqQyMytc3QeOBlJjtIetAzJVRC7UZO9siqAQ==
X-Google-Smtp-Source: AGHT+IGwpA/Ri2KHPLe1mfcS2CB7JJKPp3dCeWWL3NpPfWiKB2u2gHJTCgiK5unDKILf/5mIRxG7aw==
X-Received: by 2002:adf:eccf:0:b0:367:92e3:9171 with SMTP id ffacd0b85a97d-3679dd26d28mr2500477f8f.19.1720114966421;
        Thu, 04 Jul 2024 10:42:46 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367938a6e97sm4693217f8f.109.2024.07.04.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:42:46 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:42:44 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: sprd: move/add SPDX license to top of the
 file
Message-ID: <e57dd67200e5a4d2399eaf04df0705f30014cc5f.1720112081.git.stano.jakubek@gmail.com>
References: <cover.1720112081.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720112081.git.stano.jakubek@gmail.com>

Checkpatch complains about the SPDX-License-Identifier being in the
wrong place. Move it to the top of the file to fix these warnings.
In cases of the license being specified only in text, convert these
to the SPDX-License-Identifier.

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


