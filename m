Return-Path: <linux-kernel+bounces-569931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F25A6A9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB204675D6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA161EB183;
	Thu, 20 Mar 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSRP/mG6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C81E9915;
	Thu, 20 Mar 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484276; cv=none; b=lFnscZATGEVFzrgtJM/+RNkkaMRne/y141RQhruVxThvwNGZ7WxtwDkmw6LnD2/bP87m9/hk4mV1SmcDIFXTZIz5Lr7XiXbP5gCSdIhAuNtDsRLNMlu9m/jITWxKhMoSKK4IkCbYy1V3FlI1HC4lY5nvez78ur1HczmDQERgiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484276; c=relaxed/simple;
	bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oawmFkcPY1o69z7WvUEjGiK/vmyoA9Qzo1xZPcK8P73RLUYQgcnBawF7AE1THf2b1/eeRiG4/JSKwR2/FuDgMbJWZcRK3lxglkG+6ynzEUYHdyeuWrdcCpZ08CchraWXLpxbvgfjQoe3W9OxnsBQ8wdzfUasD9J3xjrHy8t9kOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSRP/mG6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a7065ff8so28667705ad.0;
        Thu, 20 Mar 2025 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484274; x=1743089074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=fSRP/mG6KVnv/ec+9rr1Yk+JhY4zRcCPqW6uvteaixhupR3ayRDhynfPV2GrKgWmmz
         41N8Wb3hpHqw9utkN32ZqItjggu8HhTNvLgV9q8LQ0wMq2xLcP66ZDY/sK6pzpys2Qc3
         F7ROw7zOy3sLE6Xq7wsoIweT63m4T9nktC0ZK3Hnq13rR2eMoEY1bYJLroL/SyjlVEqx
         Sp7OLAyOvZCflOWmWbHmsqmUs6ZMDWbipbOg/+XQAbrE55SKxXQlclhcA9w0dQ5XChdI
         JO/nKKckecPxMAcXhy9v3KB2kyaVc5XqXRRq/2H0CkAfXUqHIfNxtYo+L/vijlLC0xlA
         sw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484274; x=1743089074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=vFCqTyFDCs6ttzrevB3KZUsrCQPElxvPQt9PrSDh9mHim9r76Utad+UShcDbt6TTd3
         HNuhd9W4nX3Cf0qsyAI81jUm4aQ0BlFwLPZ/ZDk7UgIuG4bnUtCCVnNN1qJQq5yblmPr
         Krh9JXR8u7om34lcbNK/6hMYKo2RUad3Yl2mq7rRiMll9uGKTsnPmSI0y9Xe7fMV+Jxv
         DJsTC7/oc8HsD98esxJj7srauz2BEnTG3UoTipsdrmueRVmrwBZB6KkmiBNt+KZTxe+L
         QpHFp0Xs7TmdOcKfg/ZkH9U3zEHOYp320iZuhsd2HbSwfwGHe9cK/+fHI8KT5OUgflBU
         8C+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZWYhjTui1akzTkDO8bjHDiyd0xaM11ygy64vOpA0DGb5ZnhxFGbTX4gKVTQgEM0lKQXjOeBP03L4jnsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOs8zp7SGgJC9MBedp9RCK14FR2aYTyLJJKkzEES1HRGyQuNhT
	e0AQaImZVzy+jHRTLFO4jfTqz+amyBcSIfVHY0aXalY0HCMgCBMy
X-Gm-Gg: ASbGncsKThbOzv+ws+//Y5j4Zrr2ME976aWdKlRFEzuP0q6xdb//OTvnX2n9ITfRuEK
	JrRPCoJ9suXV1tz4U7wh8JkZLEzqqv8EJcSjpujPMLDUeWbnRQCnL6C22fW+rwQ7l7Y5Ef9dmf9
	Q6RSwWmVjY90hMv7QYRvhi0gaB+hDrDmFp8XtNYqCE109Z1cF3AcazKeh2/8GLI+fflbDIpClot
	QhzIydv2daBdZK8tpHl70EV/0jdDrx9iSe3Rel422YEqwPszJPUnw5cPaHAVDM0vSAWj1helEFW
	KC7J5lDtXjwRiUom4G1NXC31tUihQyGWpUm8bKOeMxZprQrDifME13bq6PvgtDIzUPQ6zhg/vyj
	oNM5jjMntLkoc//WTp1Yhxply3CQThohm
X-Google-Smtp-Source: AGHT+IE5GPeE0Om0AY9fiRC5tRfnAcMPwqRX9hgQMpQNbBBAF9NyfQrMJYuDiGjFwNp2dwrDmszp2w==
X-Received: by 2002:a17:902:c40a:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-2264981d956mr117068525ad.4.1742484273966;
        Thu, 20 Mar 2025 08:24:33 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:33 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:52 +0800
Subject: [PATCH v5 02/10] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-2-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
 b=/XN3QQM8+yPF6MUoJ8BkER6tXXOOmxvF1ngqIsnV8HshnT7+U5Qx3O9tBvAjElM3CeqsBdvhQ
 tNVb5huq7oWCNJUZrqPv9olH4g3qakgYuRJiGu5KgpgYker+N8TZZtV
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
index d5d99a945ee4..307af99e833c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -544,6 +544,12 @@ temperature-sensor@4b {
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


