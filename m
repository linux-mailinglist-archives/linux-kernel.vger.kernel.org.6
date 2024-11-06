Return-Path: <linux-kernel+bounces-398784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912619BF60A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35861C23005
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545320966D;
	Wed,  6 Nov 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu7fwz4C"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC5207A16;
	Wed,  6 Nov 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919950; cv=none; b=Qsm26lmXFeroR3anoqe5BOZm68X8NMwvR9zdiXjvPgYcmAKWX1eR8GsYNzOiHDCM2fJ0cUYpUTtOC1q+rJVt3URpI5Mfb613d1PQ6leo+mGIe3uoi5KLI8IPl9uKAnIEiV1bnxhSQPDd7AP/0F7Z5gWz2Jju2W5kTRUJ51BQ0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919950; c=relaxed/simple;
	bh=Kg7Lms0u6Z+3VI96RSLRU1K0rLdKSK7aBILVEcBlDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOx0T+SbmpPLl96Ji2kaiQ9qrMgE4SdhN5Pe4mJfzdm9xlGjq9xRvrCtrGGrfCdliCGWZTmzCmEg3jdZI4FRBfDr54ewzV5QCRCkTbcIGwGNe2TukGh/dxF76Wakn9+Oev1MAifrRUmDStqH4rgyzQ4Nu+wWSOUQkiWOZh41o9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu7fwz4C; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a68480164so11166566b.3;
        Wed, 06 Nov 2024 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730919947; x=1731524747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+5NR2U5/34qqCFR+0XtXIXJvL9i/r1BxuGabzfLAIY=;
        b=Tu7fwz4CwALkNtI9lu5sVfly4tEmCN07jQO3+zST97tTn3+TzIZXY51VDu0gBbJRWR
         Uwb0ZtGFdxXWvWimOklCxtyhTdUQvO8gYNe36ycX0UvShfr/8SMA3IJlt0nrk8h16qR+
         LDXxX6TVpdA6Cx11qMeAQ7HE+1ozqF3e9/yvlSIRp4WrJdLQDu19vISpbHxuZVXUWUtI
         5RX2jnszcYiIiXKbXWkas/4DWUfaiNh4WRGOn8A0zslncWZJgZZjJlClQaqI/nLEPWRp
         VyijQ8i89yVPggLw14QWCOkqnqKsfzW6H9yWepFeHICGoYfvwxGd9lobZ1jelm3wLe9S
         B/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919947; x=1731524747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+5NR2U5/34qqCFR+0XtXIXJvL9i/r1BxuGabzfLAIY=;
        b=hXu3PqhM4MlGgHB2s11eLAIjGzfSGwxJjUbHtnxbJOz03TBoQeA3wmBz4yFbvhZAOz
         Syp6CMypM9Ze8PyEXsQMMXWxm5Er1pCi1ciYe/KuK9SsYHt7Xkrraz8JgXc4umMTIQBa
         DBLHTJPu7YIhDaXzuCr+P2WduWSGXuyNnhhGxAXbsJHPOrUffrUhtLHFpnFZBOt/Ck7C
         77QVSc+pweejZwElyY3n8cof1Vuw/ZgW69xFvgBAkz5ohgzlXtNE2NkDKlHqC9g+xJT/
         CN+5BEBXDrSHJrGQdbJqgRLJ1ugzsqt+i7jZ2042X3IPYxrHgUou5+rWVwKgQPc1/jIJ
         myAA==
X-Forwarded-Encrypted: i=1; AJvYcCU6rAfDE27bgCqJtvern/YZNmOimsa6LAqMOIsvKgFk8ISMpGreksg/0WXsjfOG1fwyyrlE+0IwsqU9Mmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCFRybLjTELfXm54F2em1R5I7hzKVg7N3NC5EX0/yGfG+/pfG
	/Fat3dNuwZ6R/JPzGxHckQPZR/3Lz4vCx4e4P0hyg81eiZVD/So2OZrBog==
X-Google-Smtp-Source: AGHT+IHMS38+uM800veYM3G4kYpXl0kTf038ie9RlOC8+llx9LpFwQI7AVl4zPEa8IaSkRK5Oel25A==
X-Received: by 2002:a17:907:e8b:b0:a9a:714:4399 with SMTP id a640c23a62f3a-a9de6167a45mr4002316566b.51.1730919947162;
        Wed, 06 Nov 2024 11:05:47 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d6620sm321092166b.54.2024.11.06.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:05:46 -0800 (PST)
Date: Wed, 6 Nov 2024 20:05:45 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: sprd: sc2731: move fuel-gauge
 monitored-battery to device DTS
Message-ID: <2959aa8567afbef17337829072adce01158f00bb.1730918663.git.stano.jakubek@gmail.com>
References: <cover.1730918663.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730918663.git.stano.jakubek@gmail.com>

The monitored-battery property is a property of the board, not the PMIC.
Move this property to the DTS of its only user, sp9860g-1h10.
While at it, disable the fuel-gauge node by default and enable it only
for its users, as it requires board-specific properties to work correctly.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
- none

Note that the 'sprd,calib-resistance-micro-ohms' property isn't specified
as I do not have the board or any other source of information about it.

If the SPRD folks could chime in here, that'd be great.

 arch/arm64/boot/dts/sprd/sc2731.dtsi      | 4 ++--
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 12136e68dada..2d27427c41a2 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -94,17 +94,17 @@ pmic_adc: adc@480 {
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
-		fuel-gauge@a00 {
+		pmic_fgu: fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
 			io-channel-names = "bat-temp", "charge-vol";
-			monitored-battery = <&bat>;
 			nvmem-cell-names = "fgu_calib";
 			nvmem-cells = <&fgu_calib>;
 			interrupt-parent = <&sc2731_pmic>;
 			interrupts = <4>;
+			status = "disabled";
 		};
 
 		vibrator@ec8 {
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 94af7700f3e2..b1fa817ece1e 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -84,6 +84,11 @@ bat: battery {
 	};
 };
 
+&pmic_fgu {
+	monitored-battery = <&bat>;
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.0


