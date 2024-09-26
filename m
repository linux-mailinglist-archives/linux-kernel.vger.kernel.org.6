Return-Path: <linux-kernel+bounces-339999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA83C986D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7417B288818
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD218DF93;
	Thu, 26 Sep 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0/L28SH"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE18DF92;
	Thu, 26 Sep 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333885; cv=none; b=scHBXoW0DhUyloEwhGEFpAW6TT3n+8CVGX0sUOChVkf8iCRg9D1q82FE9jlEoc3vb0HE8F/9V6yc2vcj9DnQgMwce6bvlFgxweHC9tAtbPwkxG2upCqhv5zjt1b96WdFkQibsIFk8OS1l8P5DtmPzHvgL1/YJQvshXruaON2Vyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333885; c=relaxed/simple;
	bh=qaMH6FaJbXf8/AYkvzmXmlQFjLNDwqytNJsNdQ+mCJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwlsObItpmTTHFApA9HfzO2+Qkhsg62gfBEUYx+KaMCJRd8hZJFFMSv7NVVYghX+CK+gDCZgY2b/Z9bugtWvLj23hWoItA54DomSfK4wMadEwz+wQS8sqmHwM2ndi4iu057anauGohRp/Iw09jvQ3rb1alYRdMKDnrY9i9F6sEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0/L28SH; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e0719668e8so327859b6e.0;
        Wed, 25 Sep 2024 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727333883; x=1727938683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wqNgLmR1bM1/a/0TAZ5xKqQL+eMXK/MrnC0321nbcw=;
        b=K0/L28SHomfLoWU9dVIaX/12pIYBxhqBnDaFIGJTEUMlHyJ9uDOIyYgj50mMp1Ka31
         GXZwCRmhfoecijx4Y4GuMcIlyB9oLlhOrBMaewaJQicFehRJMB/nzuqOfz+VlkU7ntxF
         Txb+tr6yHdn42J2uR38D4acQT5TNKY7k89rYFFIHPYDmR+NZCGh5PEsqm0pxg9YPkYXn
         FsfZtHK0w3wgZT2FS42My2fe8bwxX7tOj5XSKPFjQs9t05XBzu9uxZd2ymsTnTgZHk0V
         Wiup7tuXnnH+Fe0rjSQBBgIDK7ejtHDHwtwF+Spf6yYAZ941FDu47N8PhzFd2/BfmFkC
         1b/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333883; x=1727938683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wqNgLmR1bM1/a/0TAZ5xKqQL+eMXK/MrnC0321nbcw=;
        b=G1CR3yKBmtxd5ymaZyUf+Vi+g6Uz1myigTRzbqCJpPUbCm05rntBbz8b9G5eGw4V+n
         ZgH7fsBNiwPjVcJCP4zjB/Tj2SpIDv6rIbvNm8SC39cdc88UtKNthNdZDi3TCGCIX534
         NYPqXp9m1TntI351op24VjGLVA1h7uwXEQDbPpUPi6xN1/WFKUBH0HIGgP8QGF3WAHZn
         G+jjPh1yeUeT7eDzRLO+eRQtstfe5nhoM18gr1f12ueQAiZgxt4JfhhC9g945WfJvBs4
         CwwQCH4g/2MDv5hRCbxh+qd+Bc81SwNqyDKDoRB61HxMo4RPHT9O1DUG798GUtH2NIty
         vePQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6bWqhl7KXaJbesFYMFiPkXyR/3dPoxE0bvWYlzX6c/z42CShIHU+CiN4ay6qggJh6r0pCYX8fcDBhzJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkfdo40ofkslCBfwTbeYCqRJdC9x5bxXtUQm9jSwH8nGUbf+Q4
	WU/SeQ4n9GssNvtzdUnMC8BmIOws+Uh+ojVl3oephw7troEtwfBu
X-Google-Smtp-Source: AGHT+IExtwRMKap/ki+jTEt1XhAoqr5vFbhXHJHkwUvFGy3JawIk4nM3xDeUv7NErMswLHooOsOyJQ==
X-Received: by 2002:a05:6808:3a07:b0:3e2:9e2b:fef9 with SMTP id 5614622812f47-3e29e2c3ebamr3133374b6e.36.1727333882943;
        Wed, 25 Sep 2024 23:58:02 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c51112sm3656709a12.42.2024.09.25.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:58:02 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 14:55:32 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: enable mac2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-catalina-evt-dvt-system-modify-v1-2-84a27b47040b@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727333875; l=915;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=qaMH6FaJbXf8/AYkvzmXmlQFjLNDwqytNJsNdQ+mCJU=;
 b=kjsqTRVWOKnSyltW1Rdtux/0g6qedqZ2QR9TRaEN8qReI9izCabFeXpEG2aisGkdnbmAlXZKJ
 qDtXN5TTrZQCLNDgJuliAyApV4dtVpJOofdCN1wrbaIXuph23xYpf2B
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


