Return-Path: <linux-kernel+bounces-287785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2D952CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD733B29D40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C81D4140;
	Thu, 15 Aug 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8RIGGWN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020991C7B6D;
	Thu, 15 Aug 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716776; cv=none; b=AA+Dd8xa6W0DXmXyDRTi8R1ouI2rgGigMN46ysfyyxGC5HFMd7vyZnKYMgSesYmGDj+xRhROhTS00A5eSukRSdQa4QLUQ4M3ov78dLBfbjIN0Ab+nO+pyPRKNT+pwMW4sIH7LbVg7pKJmkN2pBY6vDC9ZKCmLFvWhgESz36Y1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716776; c=relaxed/simple;
	bh=a74pClNt7xin86GDlXgjWREE/kSQE8XqjlmQPRaXxQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InSmnzA2vwMMQOSaFYm28Kt20PjDwr1+BpqqZDEZmi0EPMIEHu6B8EK/ue7+oY659g4/63VQNLkrAbLtu0L86FHxza1rfcZetXzblNXWpKw8GSQVH+e27LfzRpWHyidPYIvA160q5psLtMwNdSSjttxKhFSFcY2omy0D0Wr95jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8RIGGWN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01afa11cso897275e87.0;
        Thu, 15 Aug 2024 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716773; x=1724321573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpw4rltW3Qqo3JyX2Tk9MHQu0OGDr+zjBWOY7Dv0SqA=;
        b=Y8RIGGWNhliaF/TPjHN/gxZm8FE0ZeDOmFYyE9XhK2KNws/RaWBCcT0KutEfo0XeDx
         mfEeNufYcRvcSFRUscxlhXwIOSPFcncPRaFM+YUz3MC0VqaupC4jLHMI1kUaj296KfVE
         fE6fYuF9djg1TpEvFxDZt1qyR4lcQGxUe0VWAY4CQk8XL5YmH+DCAZJIoEJ07foxNdbQ
         TGQmaJA9bTs67x4P6yin6bGQfnGfNWX2BllXH0MjTJ8ezap9MAcywG2lqp9nOHuQ0NTU
         /GOxtLL7F+Isok9JrsnrU34olCkJAY2noo5xkk0hp2qg0XIQaPQOjsoTg/LeoHMNBoc9
         ZDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716773; x=1724321573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpw4rltW3Qqo3JyX2Tk9MHQu0OGDr+zjBWOY7Dv0SqA=;
        b=k95Rltfgc7faGIMOnzjv987m3R64pie52CuQDVERttQNjr3vz+k9Te7Ze6ilW0Oloh
         oOMGn0YPKO2sWQ/NDb3wqjn80h9ioEPvgousvOOiRScjXAP9LZTcB4GCu0Oq0HqSvVcn
         7e+DSAwCpXoYqTI8X55EOuJoa9+FHhyGP/iYLGSOCxzzAaVJo195Nv0yUzhMBFvy+rsE
         T4XbSj9Y4kKxqw/yvZgnsqpavmJ6qMpugncnGnJ6uUX4yq+SEXqd+LR2umII+aTjZIRk
         rnDmYR10lsbSs762GxKhlqSYh1yHsf1+F64D4WyhiGjrC7t6Bu5gneHfCqIOtm9x2VSl
         3gjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWOc4mPQIx5S6tq9hUIxM/ZvVFpc6SG1YQmgLCxHMs/jP37kPOCaZlftz8IM1Oz6rQm2clFEhxkwXZrGPyxqAshDMYoWjHcbj4DKcv
X-Gm-Message-State: AOJu0YwAloXuvvwU6SvMzGEG64GC0w/etWz17p8TBzOTwiXRhHzPTMCs
	o1TFL8asmyp/I8RiZ4+TpggoNIRKDhNxVu3Il3EPv7G9zEr/1DTN
X-Google-Smtp-Source: AGHT+IG1COKR6KOR7S/CKPuXUNh7JgrouOWS75okRv/OPZlZH9HEAuukdajO3tzKUMNt3BwOl02ptQ==
X-Received: by 2002:a05:6512:1288:b0:52c:e00c:d3a9 with SMTP id 2adb3069b0e04-532eda64683mr3922224e87.1.1723716772546;
        Thu, 15 Aug 2024 03:12:52 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383969e10sm77308266b.192.2024.08.15.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:12:52 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:12:50 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: sprd: sp9860g-1h10: fix
 constant-charge-voltage-max-microvolt property
Message-ID: <94f68d0a2b56c8a1dcd2a2f027eb6053c91f7796.1723716331.git.stano.jakubek@gmail.com>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723716331.git.stano.jakubek@gmail.com>

This property has hyphens/dashes, not underscores.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 095b24a31313..cd8b1069e387 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -71,7 +71,7 @@ bat: battery {
 		compatible = "simple-battery";
 		charge-full-design-microamp-hours = <1900000>;
 		charge-term-current-microamp = <120000>;
-		constant_charge_voltage_max_microvolt = <4350000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
 		internal-resistance-micro-ohms = <250000>;
 		ocv-capacity-celsius = <20>;
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
-- 
2.34.1


