Return-Path: <linux-kernel+bounces-349647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCD498F995
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0678BB2276D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221F1CBE88;
	Thu,  3 Oct 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIdhtD35"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6631C9B71;
	Thu,  3 Oct 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993378; cv=none; b=PSSvhcMGVVbjwmakeMM27C8oH1mh5ZZx1oxFY/H2NA5aGu5xoG0YZIvmmqt1BCNhOb2C+it/8fRC+m0vmtZP8DoeVcEmcq1bVoMdghWIlOntLYkLrl8OdlIqznk9SnUbje9BX9gDNUooJR5wtvJ37fg/ctPJzASdEmxQbuhVJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993378; c=relaxed/simple;
	bh=nGMoh6Z1AQ6HWirLsh+efHjjQLtoQbYlIzBND2ZZT2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPKHW8drGF1woeTe1GGFa/YxFiEq8y5dCWzxndlhXLYT2fWomVQsrXdoyjNj48vWuAwBtFm6c6yYRlVN7PoklaIfEEPgmzllUunJZdl/TdLYnOFg9nY6uTsJTdGTwNjrqdgL1x3JfciIqYnQXFRwyBxeSnfaPkIrQHqFRgMMXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIdhtD35; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so1132809a91.3;
        Thu, 03 Oct 2024 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993376; x=1728598176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYeKVSjj/M+0Y8NVg4VNPwsLsD4H+mGoWOhJZrOrALg=;
        b=HIdhtD35nDdJFR9k3ww0W2zNQsiQIx+5D1ufPTAFMxGfHSEYsfPweqvQfUUIfeu5Gq
         e1NUBcdcSba08pvVbGTDVpMlwmC5MEpDBFKllt2n2Qhw0OkrjUiGXdM6IgKZ8hZnTLrd
         mk06oaaQ0eLdNPjk0HnANmKblNau/fjVRmFXaTN3ZpRNoG04avFpsAsjDnOmIOW/Lecp
         4/tPHoGI3DeSQQwgI5CophHE579lsPWF8yGrPaHJ4nMdSpEK97ASacLAlxc7PBMVfl1x
         RD+9N/ku37K9T7ZeDtaSpe9L1KahQHbTuFaebnpb1mggKXNPHC60ZDKDJDvZyoICy7a2
         2aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993376; x=1728598176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYeKVSjj/M+0Y8NVg4VNPwsLsD4H+mGoWOhJZrOrALg=;
        b=xONe6HhqUvLGGyQXDsZBJ0YBlw7ShjzfNNrHV0RI2XjJOZbSavzI+Y1ApG0dJ/FHMd
         K6ncFs4NqC34//uutvbtNCuRIvUCoSsIo04oaJMOsUD4fLeEBDMLEzwA68lwK4NkcCk5
         jHaY1YcMVFvZyPXyAD5X9CBgOVVumR5HTH74UUmuIFy86lX0KK6wFFec4WbqH36iZpBs
         5Gks0ImAfCOHhyKYphzcEcvsOBIfnTFXRrdqeLDufDv9jq769fIvAGiGEBpojdpOjw4z
         +5iDSgqYuh4kUwiSKjTwcmp4uc3CxdNFqZo+Lvx3gYLsDJvk6iW481rAlEWZLKG+gMUm
         uT3w==
X-Forwarded-Encrypted: i=1; AJvYcCVMSoUzhZ078N3TW1sb2KcXJCg7VhIp/mlOSNfSdwVYg/07vSVa54lPQr7BoZ9fSwaADRBhl6WfFs4B7cec@vger.kernel.org, AJvYcCWJcgNnY0IlP7Ur5/sN4suHbFfP7Zhmqb25tWo5WHmqHDgiFbEMi/jbNosEMy5JcqJfjk1rA7PoLLI4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmg+GUI3O8R0Xva9G84ujKSSLPJvmjmZLDgGN6U8lIeaaWyah1
	uX08J8SuTZlDqUgFvymKx/QahhgSRqXJnYgXYPfY/9ljx+nD/PZV
X-Google-Smtp-Source: AGHT+IHgQhlhZEF3QRY9kIpHNomYsn2gr1JFjF4DaJP/+ZRLA7Zrur0rNNxBzFUR6bA7nFxvxcRnZQ==
X-Received: by 2002:a17:90b:3806:b0:2e0:80e8:a31a with SMTP id 98e67ed59e1d1-2e1e636f5c3mr598048a91.35.1727993376503;
        Thu, 03 Oct 2024 15:09:36 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d211asm5976a91.14.2024.10.03.15.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:09:35 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
Date: Thu,  3 Oct 2024 15:08:19 -0700
Message-ID: <20241003220820.1345048-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241003220820.1345048-1-CFSworks@gmail.com>
References: <20241003220820.1345048-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series (EX3510-B0 and EX3510-B1) of residential gateways based
on BCM4906, a stripped-down version of the BCM4908 SoC. Although Zyxel's
marketing materials call this a "series," the EX3510-B1 appears to be a
very minor revision of the EX3510-B0, with only changes that are
transparent to software. As far as Linux is concerned, this "series"
effectively represents a single model.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
index 07892cbdd23c..4999568225f1 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
@@ -34,6 +34,7 @@ properties:
           - enum:
               - netgear,r8000p
               - tplink,archer-c2300-v1
+              - zyxel,ex3510b
           - const: brcm,bcm4906
           - const: brcm,bcm4908
           - const: brcm,bcmbca
-- 
2.44.2


