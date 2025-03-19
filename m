Return-Path: <linux-kernel+bounces-568436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADFA69566
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D793B90F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C031E9B02;
	Wed, 19 Mar 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ice+6CcS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200441EF378;
	Wed, 19 Mar 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403003; cv=none; b=o+6myqA/3YNfHZU2BU11klPyEifwKQZ1MuZy60eMaozgCThBfdLbjTPkraNCPrsEdDrzHNClzZOkf0TivbvQfPBdaf+paIABNdV8G4P6zHYN0TWEbJ5V6Oy552QUraLmGJENAp820Vhwu5yYD9aH4D/+DGJf52fRs3t8GcdGV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403003; c=relaxed/simple;
	bh=t7ANTDBR075H8RBppIiRK9+hZDXy+IIalMi4npH/zVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcdmZAe/tJDa/xtTDqKALaoC+Wby6VbdmzAeJ4iH2vp/zqQnGXCmBlWB1II0eQ9JJMcjlzQDuH+Cl2/4BYLDsYitSaCnYqdrBwYBpmdE762o4SBQLDbED51b/GI/c8Wvsh6rnzY44QpFmERtt7aEFfaAUMBEBQe3IStrFEXdqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ice+6CcS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso21921405ad.0;
        Wed, 19 Mar 2025 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403001; x=1743007801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynDxjrYa7FoAeUzjxX8ebcosN+KRAaBz3z6tbCcoZ00=;
        b=Ice+6CcS+YoVo2lIzVPvYzl0HLfdbl6DQ9Oief/S5GR3b0YxUb1qtGfkBG4KeuTmJO
         uEREpK/FGknUviRe2TLdSvpjid1vs52i6G0HEgknPhSW+Af+l+9LlIEV3m4g2bgmUTj3
         FZGmoWsSBTDHdomV9w/w2DSJ5omPLIN8rz0mK+8jkbnyEY2qlFUCtejNyxkST15d3FD7
         qgk/leTRC1f16LCGmD0xR7BFkWFvCfB1tzqEgIemvFQFhbazmtNfmIgRq2Z0cNbRIzRP
         N3XkoEa62YA5ckDAwkUhQq2PkoMAGT2DiqedTX2GL3c/yO2o1J5JPXU5aofqgXWJkZAM
         Hr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403001; x=1743007801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynDxjrYa7FoAeUzjxX8ebcosN+KRAaBz3z6tbCcoZ00=;
        b=aBY4RDUZpU9XHpvLR7rs4h57zDlO0c9JrqCY/N2foutemnnci4eZvu5okgqeThCf4G
         LXrhtzIT2owGJNubn7VO8TFlQSGljvRF66IgT77TK+iBTd9MpUeJv4ybe5Tm90pObTTX
         rqouRmST1ogwTheOedA8o9gOo/vrvGM9cyDsDnWYl+ljnc3EUiVb0aadunvBePGYmQ0c
         cRY/q6rLQgKiS+lykuGkY87R6suy3fPmDnL6PlfkR4Sl7TKsL5rfDm3Frb4ODESvYI9c
         to4gC2ZE22sbILPKJLFv1yL+U+5Dr6w8AJigH4ZhucJWc6UC5nSraAKNCAbQagjJPKoY
         UWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyshwbTLiFRoYQChTpq+BgueB3wrKHe41VLL5ctQ0XiNGGlrVps92RRAeBArbtwoh6qwctBDjMDNc6XRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrlkeZ+XSOEyBfNrV3CbyPFbCxwPIlm7pqD3UeiUTcwp273wK
	s3ydOiLKClyf1AP41U+RgrQ0nJTlwW99YhBieKeSSMFNHz00FVc5h+ucYw==
X-Gm-Gg: ASbGncuhDuZFt9pMdGfxgDdPjh0txuNWxcVSb6TU+4GpTjG0netR+O+elidCdIM7PrD
	9NCrtEA7MY7iEB0DXo2xqhzJVrO7n32BrAvfEARAFUlu0RijIpUr0LUvvdZUOsLq6O0jabn85cO
	i+iALANRu5Esh4o+vS1eQFKuzhcVyuzQd9JZSzDUiyxke5/CGJXUOCECKlxP7JgAXMT5yJ4Vd+F
	Rghg/GavuD3ltbEjf0c+HLTSYtkLO/ULNP3adif2WOSJzkIaXOVES86b3crLcIzi2hGgi+K92x/
	W7z/hF7Y46S2y06aJPo3y34IjYj52GC04A7bulzGGP5q84+/Z5EEFMEbBg2lfYHDiwRBd0y3QZ4
	hVSQ5Fc1twZA7bTXMuK5eKA==
X-Google-Smtp-Source: AGHT+IEPzE9naIMttqXOLhoUWRFXUcJblI/+wc2t76fDOdhnGHN6yVS446XwCmDa/8Wd9X7f1CLOGQ==
X-Received: by 2002:a17:90a:d2cb:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-301d426aa83mr318882a91.3.1742403001305;
        Wed, 19 Mar 2025 09:50:01 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:00 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:25 +0800
Subject: [PATCH v4 4/8] ARM: dts: aspeed: catalina: Add fan controller
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-4-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=1019;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=t7ANTDBR075H8RBppIiRK9+hZDXy+IIalMi4npH/zVg=;
 b=DZjKoG8cTWZG6sPj/bGcrkU6N6K8GsHjDI6C31PtF0z67BiheTqcD5gV1mBny5NXifJpwOO9T
 sFU33e0hGu0C7S0SK2ayEIL1wcZ+3oY5Xc/XwUq5BOtwgsp4dM0E/tX
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the MAX31790 fan controllers on the Power
Distribution Board (PDB). These nodes enable fan speed control and
monitoring, improving thermal management and system reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index db999408e397..0b513829f2de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -526,6 +526,15 @@ i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x2>;
+
+			pwm@21{
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+			pwm@27{
+				compatible = "maxim,max31790";
+				reg = <0x27>;
+			};
 		};
 		i2c1mux0ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


