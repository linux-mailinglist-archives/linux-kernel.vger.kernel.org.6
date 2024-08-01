Return-Path: <linux-kernel+bounces-271558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BB945004
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E1E1C25B00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCA1BB698;
	Thu,  1 Aug 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/lF5WkQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914ED1BB680;
	Thu,  1 Aug 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528244; cv=none; b=Hw2QpwFYHSa55H9kLfKz7vE9pU+cuckY2+HR8TAz8ikcL5PCQK/lvYa/7G3oq2Mc10d/+axpmwys+WmRGiu4c07iah0NHw8jOKrkOREMUVEvs2FN/TLa3aMiKCBIKSCknQe2KAUYTmlwaMqcw3FzodQ5c2g8jUcqwtpzPVpEf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528244; c=relaxed/simple;
	bh=XVOpdeV6CRQwS3cUnfTnIgJDQsEPBmE0H1hjYjSE0OM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDwYBz1UdxfKrhGyleDU8xh3lr91gHTv8D9VgW1jbLUnpHqbNfCCvkUlUHOIqpX+N57xU3tRUAPOx0SIgW1jT2ws3YQU3Iqb9s7IJ35EmCf7EXJVn8B1tahTS/xMOcvLm9g0ZpSHkRjv+WZnhmJWSgl5tWYU6GEi/NjVPR4+Ps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/lF5WkQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a263f6439eso4236350a12.3;
        Thu, 01 Aug 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528243; x=1723133043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmQLM6kfiLLNztCoNImQmMNq24bv1cMMrdxlIFr9qpY=;
        b=Z/lF5WkQbBXJXQubenf8bhY8cYrYjU761qfpJnJCdKIflqPtHBSC6w0ICiK84e/F2G
         GkFVMbflyH8LzftPs2G6TwvAnlhKDR6w/SM7q6PUYNvdzclmaXwwoC7hHGBf6ezbvNj2
         Dx4YqgqG62tZVXgmdhaAvhflC09TyJlWoS9BRKJ1YgtdlhCBRKdDaE+qM9UPqZejnNod
         ugTqxIKH7QDt43R9u4MO/gvD018gmc/NQlh/kK6133b6iOmV3X9w7TXbOagjBHfTuEN8
         Cjht4mnLSgQnGY07w/BRwi1SG+UTEjcjlLAbRcAFWekCBsil4f26oNrsl9lpn1X9/Ewy
         KVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528243; x=1723133043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmQLM6kfiLLNztCoNImQmMNq24bv1cMMrdxlIFr9qpY=;
        b=qSXGUSkNQoDbwGUXmYASiQS1C4Eyrpg0GnP+BMT3N1uHP6Sc//HyFNPkvAJ2V9ogMb
         fm5qCkw5ewX4PbATRsJHdH9HNNYApBX0hvGhcgVqkAxacCfnKPdtCdya3VGglgzZlfFK
         HjiUPixj/YjbVe//sPa6c5HcCSZe4T2uQ7TKWhgZZatUVV90FfshrPojTeHnZIncqWQJ
         ikaBleLRbkvBkvKBe7pB0JtohWie6/mRJXxr/KW+KMPFLJxseqe4ZZXm0FdZstumAurX
         cxh+hNoz2YwocSjbolFCPe68vzNUxLQQoEGvzM0oBPzyAigp6OMdZH1vgMyOiXw629/i
         6rPg==
X-Forwarded-Encrypted: i=1; AJvYcCW96gjx8JrOx7fa1noDXuH/jAa4BfuL9QW3QRdxSFwrorheQ0D8p7dAS6GYjRUn5A++esCm0dv+y0F2n91U4A0Y4UBNfXhF7LMrCpQfmzazttgqnX+zS/s5BWnVN8XoM40sHs3BPEJrTg==
X-Gm-Message-State: AOJu0Yw4cG8oXst0uqz6hv7JzXDMycg+xOkz31oLiZST+J9cT+FQ55OH
	R1Cgm9169bfCNVmOS00zJOgbBo/YPjo+lWsAbK9qd/FiVeFodPVmJyWYBA==
X-Google-Smtp-Source: AGHT+IGacSfUc+jZigXDS3pnYcE+ooJgAO1Jg6x2FCMXCSrqHjkRPminlU51RhY9nQJp/KUM382d4g==
X-Received: by 2002:a17:90a:fa85:b0:2cd:410a:b010 with SMTP id 98e67ed59e1d1-2cff93c59fdmr795183a91.2.1722528242665;
        Thu, 01 Aug 2024 09:04:02 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:04:02 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] ARM: dts: aspeed: Harma: add temperature device
Date: Fri,  2 Aug 2024 00:01:32 +0800
Message-Id: <20240801160136.1281291-9-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add temperature deivce in i2c0 and i2c2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index f55ffe9c4d89..0455475fbcff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -221,6 +221,11 @@ power-sensor@45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c1 {
@@ -271,6 +276,11 @@ power-sensor@45 {
 		reg = <0x45>;
 		shunt-resistor = <1000>;
 	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
 };
 
 &i2c3 {
-- 
2.25.1


