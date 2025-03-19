Return-Path: <linux-kernel+bounces-567670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B42E4A688D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06EE176B95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A52580FD;
	Wed, 19 Mar 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlE3rIsg"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E21C8637;
	Wed, 19 Mar 2025 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377686; cv=none; b=XMUKPgoF3RYTd5B3UwCTQ1sWpU9gOafIJwGNS6DpQrwMwH+pA6rgzO/YfIgrE6lqMdgRkUWgqFW/j5m8WY40BZKFmQOVmPXIokV4BUXKfvcbv0N8+7dLAVNY9aAESvucVWxg7fLpZOitai2beXKGXxgE8iXXNiE3d+40Ka9luMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377686; c=relaxed/simple;
	bh=VktMu45HLVO/NWd1qA6YTia9Y5dgNUfWig8y5ndhO9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFDNO4U/L8yo+sKVtwfLY9uVD1XPcJ67bIDYxGBdCfrha09Sd8UM5NUCvIPFHP8ngaVWoHpf6CgalR1mHI6TsnUIX3VwKzKMrGuO494G2NoGe9u8VQR314qLVY/b9SudncOEh8FjS8UpWFn+318B2c6zDalZMlHEaTxR/OKYJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlE3rIsg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300f92661fcso7018009a91.3;
        Wed, 19 Mar 2025 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742377684; x=1742982484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO5WZTMo+C5iTCX7S7g0gim47PztvreZd6gINV7Mu5Y=;
        b=YlE3rIsgDoXm2izP6g/B1KateKJtTX9BKpUZfGdSmTHAnONaO1H8eagjVF0wFice0r
         0gl1ekUHOjPZ3NYJuA/dVtFNSrvHnR4GilVZK6Y8dKq+uFreJHQuGQZj3ByUAEhMzFK9
         qdIgSrXC6k3XyNApwWApMLnsogef+wfdqmq8E1RCAw1lpeyU798QovvvirObzifgb3yW
         zk2a6taw4ckzwK97nYUKN2IReW+m1wc6/SzOqb7hDhz+jbX6pN7MM1mmf2nu9xWfP0OC
         T2eVAI8YrGtfJm0jq+qFwcEAqtpLv37HyyYQ5epU5rfh9ijdaTCm4QEQiOjN93LRW3Qf
         efww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742377684; x=1742982484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO5WZTMo+C5iTCX7S7g0gim47PztvreZd6gINV7Mu5Y=;
        b=eN9e/icCVohFnhs7eV78nfOg0X0jGPMZuA0V24h7gCFYdbavALtCdog2igqIhHCHmO
         3CKsuNb6GxF3c8N8BTwszJ9pjKYyEkNJ9TCXOJ0cbs1ngLzsReOP3fYfgkVjH1MUDjPv
         M0CQJYiZNeTK8R0fkMM2t7OznYrETdq0gEh5Bj7eTgSI1Yt6j1JwoqAOWbZyhYCOwQRY
         qCgrOX9CNBLKwLahDAtCZE/PaTRVUKyYGfBx8d4EAa+g0MK3GlnHDq6HzKlhbZxd+a8t
         ZXWOJnu0ahop6xBOYVKdJBXwdIatP5vm0nMuu6b4ysBCrNOh5YqS32puG3JzJqD2wrC4
         Tw2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9nUEKOK9MYP359yca9Oh+ytrDGqEv+lbaQuD8d+618QIU91FCnIHjI0CBRCbH2iJj6iSlrgLJWnpI5sKj@vger.kernel.org, AJvYcCXSsQhbu3A6J5vLJyy3ZmkwkkuG3Ld0vHJK7XXTEHRASTIjMmy0mwoRyin5kzMabNeIIOqbySkZhsk6@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRE3I6lZNICUqsElT+du2yvBe+R7eEv/9v5y1Wm7M2/htz3ve
	+qwQfjahgcxRPw3L+pzaVVTb8wAeQDiHxlzcm0nBEvVKnK2JKmQZyuG0Tg==
X-Gm-Gg: ASbGncucgfiUqcL3dDJobbVLvHUa5NqiSTCugZWQJv7BtL21G49BnFGkFwEiG15Uoe8
	J4XI3YYWehOMQPjgzAKNk6aaMcFxOriHsX5YvlMdmsJS0BJVeMbLQf3Y/FdFznJDzvGlCOUVSd0
	/o9yDvudjDz5nKMCS+T0/Bi3w+JJhE2P/AtxbjvIx2GXlah/0Jkr4Y03mKo6mYb6BYIuW9JlFz7
	4n1a+AhHs8+Wza51igqRAZueUcGGMYbkdCQLV3Nm9hpKxgF1FDXogLqJP6AGq5vpvBP7cFHgXGr
	KxQSJsTpW/HI20TxN8EpRSzXuzZTgJBa9kSvFBsOQZuL13QKAPKh3vYRlnDR2MRxRbA1FzCAElf
	fnyWDtWdQoRISKqUajH2GbZWs65OUaws+k8xBzA==
X-Google-Smtp-Source: AGHT+IHGVpw5pZ4oUibijuz5f/+swAD6+UTqPpA7k0Fjh56CPVAS60cjsY1TImQyPXPs20LFApE6UQ==
X-Received: by 2002:a17:90b:38c9:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-301be204e98mr3374142a91.25.1742377683407;
        Wed, 19 Mar 2025 02:48:03 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf589bccsm1103483a91.11.2025.03.19.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:48:03 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Wed, 19 Mar 2025 18:47:43 +0900
Subject: [PATCH 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 rdid-dummy-ncycles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-snor-rdid-dummy-ncycles-v1-1-fbf64e4c226a@infineon.com>
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
In-Reply-To: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bacem Daassi <Bacem.Daassi@infineon.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742377674; l=1447;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=VktMu45HLVO/NWd1qA6YTia9Y5dgNUfWig8y5ndhO9I=;
 b=XvOo13JqixpDnCoEo8S6z9Y/baIU7177u9z0q4G4EUIT19h8F+RPtZzhwjNCtX37ffHAB1tia
 ObbMUd7FtVbCzagGduowO0iBzKpwbZJSykZW053bB/uxCJ7f8I7fCHN
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

There are infineon flashes [1] that require 8 dummy cycles for the
1-1-1 Read ID command. Since the command is not covered by JESD216
or any other standard, introduce an optional "rdid-dummy-ncycles"
DT property to allow flashes to be correctly identified.

Link: https://www.infineon.com/dgdl/Infineon-CYRS17B512_512_MB_64_MB_SERIAL_NOR_FLASH_SPI_QSPI_3-DataSheet-v07_00-EN.pdf?fileId=8ac78c8c8fc2dd9c01900eee733d45f3 [1]
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 335f8204aa1ebce3d2b4686b2a06d0ea3791667c..25abbe4f5d17f66215fa1af097d14de4a6ef776f 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -63,6 +63,12 @@ properties:
       it can not be detected at runtime. Refer to your chips' datasheet to check
       if this is supported by your chip.
 
+  rdid-dummy-ncycles:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of dummy cycles for the 1-1-1 Read ID command, if not zero.
+      The Read ID command is not covered by JESD216 or any other standard.
+
   broken-flash-reset:
     type: boolean
     description:

-- 
2.34.1


