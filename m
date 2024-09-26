Return-Path: <linux-kernel+bounces-340015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395D986D56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE10F1F21E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3951891B9;
	Thu, 26 Sep 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE9gSUX9"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6518E361;
	Thu, 26 Sep 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334848; cv=none; b=IkK2OP6a1B9RWIocHTllEor044pMQoHTzKNY8u9qs0ntiqSEGD/Gjy0e33C580AwePt3L04jUex4kvNDfQ0bEMxLZtEEjT1W3tNUhXVOVhUSSwdQEWbzFbgDOq28EKv98DHaGFM01d/Me57v/nxOzxGAXc5knQEOuL3yAp4hej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334848; c=relaxed/simple;
	bh=qaMH6FaJbXf8/AYkvzmXmlQFjLNDwqytNJsNdQ+mCJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfB45ZkWN1LkTsRR+N49dSm0bPYT/37tryU+r91aRenHbZsmheIWtVc9sY6mj6K799OI4owKakF5UWy0e4Gnigee81i5/pm6tMBfbYkSfpitQhx7iDxBnOmSgjTEt9mFn3aVNgkXMVU6XEO7aiDsGp8FQSxu0NzyaFnyfgWBC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aE9gSUX9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db12af2f31so494469a12.1;
        Thu, 26 Sep 2024 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727334846; x=1727939646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wqNgLmR1bM1/a/0TAZ5xKqQL+eMXK/MrnC0321nbcw=;
        b=aE9gSUX9cJGAcl4SS00bgHZMOLd5jeb5ZC5s32PwCEqqQbcA8YX+UQWVX5Ook28CEc
         hBA5ocoQND5UTS4L7CPAW2UDxO3nQd8GDn6uCY7ElwsBsTKMAmNHysJCd0p4xo9/YT5+
         nz5yqqL3wYEItTxGaKq1Z3XParDE29b/fhOhnFQL740IytGGvBzZ+BdSIA5H721BGAY4
         L94OR83+mFYiGHnuIjraD7/sBy/ORj7ddCtMOgFKoV1vWPAtX3A3znVW2P6cDPqstso0
         gODyEKojDpLuVhGmrzPxqEgmjy0O7NwqkteA64c4+SSDpSdANQXALyCJeQD9zxxmFvyX
         C0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334846; x=1727939646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wqNgLmR1bM1/a/0TAZ5xKqQL+eMXK/MrnC0321nbcw=;
        b=HvR+oYDhDPFS7QbbzNeDCwn/APXfjI4M3Zc2WEbMtmAU3Sfe0Yb5cXjEN288I7q4L8
         aDjvLe3ZikjVhgvX9WYNM6E/PFhtfv0f3hbkXTVY6kn6hZo4GNuZ+4z4/2CJ3bETpukJ
         Vk061HFMFcYCWvUDus6JsnY417EKbsLJswQHehViIMCg5hPxUxScqrBnnpokkXffQ9LM
         uazEJbWWhCB4mFNEm5+Nj10/Al7RmWOAaSA2yeyygagZRVMeTzecVIOGuIAD6fLWUDYz
         DK7s99ovYP5Lq0jezbBsOqgsCmWymWKbO7TIJO862AJsvDYUo6zAObMyl1cIrXZFpImX
         j2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWuYw2XnUA9RVLtukRpp0uBFwdg2xnrmageiVW9o+1OhSO1nCpYEZg+ZgMTZdxOT+XW8aYb7+STn+C8Ga8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGZBmx2g2aNL4zS/C2+r5vc2wLsOkaG1K4gMx6y8P0Q1jeEnQ
	rzrJ8kG3fsll3AgM1T+gWuPkOKxod8j0QmdeiNe3xOdvmZjeYIqb
X-Google-Smtp-Source: AGHT+IEYh2nSeTe3zzqNKgrGHJ8e1eBlUTzjOxox29YM4mDjEZtFBluu5eUVailqsjPHSPvycM1crQ==
X-Received: by 2002:a17:90a:ac0b:b0:2e0:7d60:759 with SMTP id 98e67ed59e1d1-2e07d601129mr4556109a91.3.1727334846421;
        Thu, 26 Sep 2024 00:14:06 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d3e79sm2662906a91.27.2024.09.26.00.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:14:06 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:45 +0800
Subject: [PATCH v2 2/3] ARM: dts: aspeed: catalina: enable mac2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-catalina-evt-dvt-system-modify-v2-2-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727334839; l=915;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=qaMH6FaJbXf8/AYkvzmXmlQFjLNDwqytNJsNdQ+mCJU=;
 b=LT7B9O51Oo5351FhK5Gq2MJ/NY/CsMS2TDO8OVLZZnlDQyp+JUBozi9NtlUZuUGqrQpj9BWuq
 BQ/7y3jWNd/B9ziuufKoyt+3WwXv0xUuWtjcXBy30v3UYSvITTFguPF
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Enable mac2 in advance for DVT HW schematic.

- EVT system:
  - eth0 (mac2): no NCSI
  - eth1 (mac3): with NCSI

- DVT system:
  - eth0 (mac2): with NCSI
  - eth1 (mac3): with NCSI

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index eac6e33e98f4..9502d483e738 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -153,6 +153,13 @@ &uart5 {
 	status = "okay";
 };
 
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	use-ncsi;
+};
+
 &mac3 {
 	status = "okay";
 	pinctrl-names = "default";

-- 
2.31.1


