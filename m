Return-Path: <linux-kernel+bounces-231879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA82919FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B2B2442A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA06C4643B;
	Thu, 27 Jun 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkZA0FIR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815F50284;
	Thu, 27 Jun 2024 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471630; cv=none; b=cCxtBR9BaQZrKFY9gnD/iov5gKwos4+aAMMHgG/Pc2WCwAKjjjXOsdErIFRAdh6/YirFV1wHkTsaW1mv0VS8jn5npcp0qhxfWlCcDEQn+f7ViIL38Ml+It+PrI/UBsYHJI7ufW01kr6j6hVvQqtf6W3EqTGZRAdOkTnGupe9RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471630; c=relaxed/simple;
	bh=cRSCItG3u0/0B9Sy49+1YFsNwk8YK7pT+XKN22ApIS8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gxmco3OSjCM66KE+2VmWNKX1Py221YHwAhqLVQrcFSu4IzHx47Qn6d34w6SzyVdQPSWS2wnd7/1z0RjVJLfhmbGnF9qVh2LNccdzfckxF+NkXXqbdj4qNm2B2tXWb3QZTT1EgdzPidmNbDaz2t/juSncjV4EoHupcweN2sP3Z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkZA0FIR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa244db0b2so39367915ad.3;
        Thu, 27 Jun 2024 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719471628; x=1720076428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOmTqjVkRHQxfRmStHQPSM5D9RFozJWPKk5wjb7WZYo=;
        b=HkZA0FIRqwRavS5Vy+ET41duGdu91PCiTJ5oL9pc5A8KMShm4lXzOCAtfTtusBDdUE
         iBPNXAOQIaKNH9okdbbyM+hO7IDvuSs4hi7Wl4p5fZCMKu/cwgUfxYHHD4GgmKVLu5Nm
         Yf/G0ZOiZGAR/n2CE8lAtJ5kH25tC8O0VlkRDZnthG/wTWkWYiJ4FKKs2SMrAMCIYndv
         Cqpi8b6jPqBHIfJXW9XmI6594ssJB1qGLk02g8AlcO8wrW7uXiDyGuS/YuNOqk5rQCjL
         0QyT7ZCVooV8jqryw4+7jimvdHqB76dkViNIK0QKtzdO2KwJTIEufpaysaItqPcxQ3E4
         NiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471628; x=1720076428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOmTqjVkRHQxfRmStHQPSM5D9RFozJWPKk5wjb7WZYo=;
        b=Y4fyeRproBh8cyn7cj+iQPuO9R3JZjY1OWVps8KWM5LiSrR/Z4OVD3E7Waw+Wdw2c7
         CvAcGuW/6CmlNhcWW2BfuKNeZGAWNdbrigTpFjavrDSwk9PPeqaAjmcfvryciC7FLGZN
         470Rz+UaT3O2HRVH9HYyfP04lCjvFpfVgvwb5FX7m4NjKOPB8YpDGySELmsCTsq9KMyU
         T+cU+jJeqxSQNBdsUf974sIQ3MtudCzJhQFrcbhc4FnoQM8HUJQa8+TE9ePKwCkvQ4MF
         tgeAwQcI27HpT5TgRsXugJMZGBtKXZL7a9BE6+k8R8xy92WfJLpc+dkh2ZZvPWwEwhIn
         9NJA==
X-Forwarded-Encrypted: i=1; AJvYcCVC7j+iSSOFlCfpMy43Z3f13NxZcrZCH7TsZNfSgN23P0LIvIAwJNrAxBcWET9gTolWOU5KM3rMrOQKCCx4eHyi4NGUKy1vM1Zgiox9Rk7rdwzVYyvQadVDOc4Q0YhCgGorfQEJvm/prg==
X-Gm-Message-State: AOJu0Yzr0FlPn8gB1UGTlKSkysaHSRnfthjKF66L0L/w/y3OAg4r5QjF
	bpfFU1phQpgvnrSiz12vqEEQkYQ3YxXiVeyf2LNNLIMKPLNHcq1+
X-Google-Smtp-Source: AGHT+IHuq2KBDjCkeD9/vorD5v6rBDJnyOHsVWTzHXkPod42z8BY6fxj1j5BMEPxjygAKr4Ijqxy5A==
X-Received: by 2002:a17:902:ea08:b0:1f9:c52f:d9b5 with SMTP id d9443c01a7336-1fa15944ecbmr150184135ad.66.1719471627892;
        Thu, 27 Jun 2024 00:00:27 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e306-713d-05da-7754-dfb7-477a.emome-ip6.hinet.net. [2001:b400:e306:713d:5da:7754:dfb7:477a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac997ed1sm5962145ad.211.2024.06.27.00.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:00:27 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	amithash@meta.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] ARM: dts: aspeed: Harma: add sgpio name
Date: Thu, 27 Jun 2024 15:00:05 +0800
Message-Id: <20240627070013.2509150-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power-chassis-control and power-chassis-power
for phosphor-power

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8fb30029e46c..0c4bf165d0b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -520,13 +520,14 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
-			"rtc-battery-voltage-read-enable","","","",
+			"rtc-battery-voltage-read-enable","",
+			"power-chassis-good","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-- 
2.25.1


