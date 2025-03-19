Return-Path: <linux-kernel+bounces-568434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE1A69564
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111D23B7ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87001E8354;
	Wed, 19 Mar 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK6N3Rf7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53001E3DCD;
	Wed, 19 Mar 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402998; cv=none; b=o49o5djWyQMeIJ+DMWraUeB0f1t4dHdlSANDXn7X9a6ZvaECZiSC5saxzHU/XHCfjhDZvwuc60L5PRoO8dYGNxCspS0l3O7oqdDh7yy3+nKs1dBgydQRzwejRGRbQztOegh1xJaGtWpJMzVtyWbcyc76ZmXO2RgkmdRjyoRJPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402998; c=relaxed/simple;
	bh=zCunrY7p7KNDC0DPGI2jLsy48dXqjOJ/Du+Sxdf5cv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FDhC6IWJfYLzRU75lauDmKR9ESjiWaPs56+E0nGBkM328cHatLP+ExI86UNEKzLFXQThlREKMMIZAOOQCs5WCo4FhzCoRvmM+NzraZdMj42xBJPhou8cE3vOu+9da40taWdj1aI+p46NDi07xOOeCylp5ipAC+q+KhRUEVzGwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK6N3Rf7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so2210562a91.1;
        Wed, 19 Mar 2025 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402996; x=1743007796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKG4u8A4SwXbQSgAOY6y+lFBx/PwI+3PG5TQ/aiiLzs=;
        b=OK6N3Rf71XK1e3Xkje5u15zOUMLEyBp0JQME6rTMw+SMy6G+kykbCnjwXCPkeDbtSf
         DVzf07tfldzWmg17t+NEDxIth6H6OAJ1tidKSrtruPuNyXlR+uLKS6DlXRe1t+5Xte1+
         kwCfTnDu7LKjCddXzWbxu3e9g4Fg0yxwHMwvo7yeFmKr6KZ8hueMoegmOMPMtNk7s0O0
         MsNSSjSykNiF2xL1HkWs6AMiNKw59RvQNxGzOTJq8KI+BE7H3hVss15R+d+a7xf/1gwE
         fdshBzxlwGRILfVspL/OZOD2BDWSm4EFU58PmRKUpDeHh6oYp6RwE7ynpHRq7Dwy/z5q
         SjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402996; x=1743007796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKG4u8A4SwXbQSgAOY6y+lFBx/PwI+3PG5TQ/aiiLzs=;
        b=Uq7Hfiw0E9jN0hwu0C+a2G+2k2ddChVnePemM5hPqyg60K6wytcV65unaTjp7gBxE2
         ehj1G9YEraqB4k6nHjk6iT/lh859wGlhrSlF5OAJce9xdw1gpTGx5ZkKeyFO8kvxNIC6
         cag+VCrrAwBQzkfICSiQppjkXw6Rol1du8AnL2d4V7iwOGKP5muBu/AlZHr6SpKAWGl6
         DCya5Y4x26MvPupG4gonLXx5g56IzP9T9I799PsT05qPoMyORcmDvTgRNcWwRimryxH+
         fW5rxyI4UjcpQoR+/TC8QVAGRRNCNqSNUNw5ZlG5ONBNp/fVdlKLEBRff3yjNg4nENK+
         0c7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBqK2BI3Y8cq7V5Vt7zlpj8iV2QNq7UJDmYuBKp72KcskENf2pwupS1ap3ySoK6B+uXl6W9MhdgLfocAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPW6zTKRlt8S21+0sDmqUxd9AcyLSbqNb5K8DdMmUU3szMmwtF
	ErjJAGmBjE45Lxnly+gjBOm6PuY5NlJlrnyCNLxtrWugI7MxfH/I
X-Gm-Gg: ASbGnctHTVXPSy1OFLxkF/IAnVit/+WCZ0gMMBBjyCHqvycynYZptooGuauR/4kzwUc
	xhYc6vEAJGcjFUk+xyeHRVyZCVupSz+6x01ZEQZx44nn/EYaxeeaVyZrYg7nC4gGTLerrsym4xS
	48ZNoYNlghw5/+xKBvtxlAdIi3u+5YcddWqAyCpMfm3vsw75kWR6+Ewx8/FHg3oLnUTAfHOWJg+
	kVI2PQgS74A2e5WAKW32OLCVvcHoOcYzhY68BH+xw4yVIIiEv9kD0G6KgXUmF764yFuc1l6Qlii
	nRJ+qVva/dGjJ98zY+anSqH5JV1of0Q303w7/9PXREaBUSDbY62WOg3gx63zWbm2Qtjo7ZMUWjz
	nC/+esBF4p/XkIVI9bsH0CA==
X-Google-Smtp-Source: AGHT+IHXOOKStoICqG32yq4k+0zjuAzQYQG0OOTXhcrihQzKdjTydmDVvm5dRZt9HcYJZxFVF2KMew==
X-Received: by 2002:a17:90b:3b85:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-301d4347069mr260059a91.16.1742402996048;
        Wed, 19 Mar 2025 09:49:56 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:55 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:23 +0800
Subject: [PATCH v4 2/8] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-2-7c34b8139014@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=zCunrY7p7KNDC0DPGI2jLsy48dXqjOJ/Du+Sxdf5cv4=;
 b=9D0KNCjX8ehQysgIdjsN16NEt0i08PbfBxhgEMOjbhQ+DTyazPtj/x3cGXMaPtIG56s+SGB6y
 7DEKQ5ZIodiCYC2wfTjMv7QnfQvCsYrZHHlrymllNEmwjsOTT53W2fh
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a remote thermal sensor node for the Front IO board in the Catalina
platform device tree. This sensor enables monitoring of the inlet
temperature.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 75c3906d9654..b9a7654325f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -604,6 +604,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

-- 
2.31.1


