Return-Path: <linux-kernel+bounces-339394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F306986491
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A2728AFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B31BC2A;
	Wed, 25 Sep 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmf6h5/C"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753622318;
	Wed, 25 Sep 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280884; cv=none; b=Qy+4vOCaC4xRRH2ixBzL185fpG4wPu0HGDcCsleF+nhpsilGMmjenZXs7/IT/AvA1Fu7phivgwHqkyjokxcnrexTSN5z59sUFFsd3IqekG6N3oCyoZCbUQBWXHaupXRocaj6JDo+hX3MxrS55PTqXGmbOsNYumpQBV7yXLPv+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280884; c=relaxed/simple;
	bh=VA0gCrIbBTqb656pezMbaZxORbnmX0I0+u+9FbGdz4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=txoR8eqvJe0gqbkf0PYlh8x4Rk0CwUak6pmZ1js/4G/LKKBv45bhfz90S2AFt1gFzD4opbjJ9wJ4UQR5ixKUXHN2MdKElWAikOMBuamxYhQjPh5bGBa6pA5QVtJ3Zl5aWr8stJA4x6GLTLAoSbx0RAh/cMEp3l/s0gq67nQ5goE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmf6h5/C; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo4025964a12.1;
        Wed, 25 Sep 2024 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727280882; x=1727885682; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP4J0pryPbVBBnumAwQFmk6UF6SPysj+qL/32bK7f6o=;
        b=Nmf6h5/CM6aoCrJBJirYbIQfVwcvgiTtw7W2+I8seug6CZO5KxYPw94gvniZkoZbDD
         seKC2fYXhB9SiaOqXbjUJK265UVzEb+I7NRj0laXmxuYQgiSGUI7CBpk/lkOh+bcPgV4
         752T6yEU9Y34AUtPkU7m5ntZWDiTWIjxJKtGDfd9qjo3ZZpvQh1zBf8lnf5NGh22NrAS
         /I6MjDnrfpv8zP6p+NIcNtRLt9hIG1csrhmGlbgGz9WvAcs2u0xVyAemmKGEXTIhFfVA
         zb2Dr2NX3ZLG/g3BM4Zy84u3wkNO/qWk0iFpkCkK2u+pPhjSyJXXX49YUZwIVXD1kk5a
         ARTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727280882; x=1727885682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP4J0pryPbVBBnumAwQFmk6UF6SPysj+qL/32bK7f6o=;
        b=eFxDehMon7pcEwY+hXZQ5cbPYJrPfMKLpLUJp9tGfx6QCyx/zmUReRe64OInToGLEB
         F1yeHAhu2EeB0in4aWcsKLcw4f/II6WFuvqvw5Kg24vljWvOxlwqBTQQd0ta/pWrXQfS
         3Zvk+NLhX/BNYT4ewTFaGY3GQG2Y5LZ/72SWyeVYZdtL+Mo+DLIkYWIYfCIOyt1IvFX9
         7W48pTWhUB2rynBXPv8FzIw6hVqMD3BeCjw1ftDjPCOhatM6Nxt5fS81OZMor+h9GlP8
         6/p81BEN6dE5Ayz2Agw3DOti5nn1Ufa2+O97nJcXIU9EnFlQJ0Zc6xLN4d9Chj9f9GOW
         ASdg==
X-Forwarded-Encrypted: i=1; AJvYcCX3rNTusGC1yEgvZ5Xp1uPxwYRuY7kEDnNQeGBQCyEzVpE5YoY2hwYG0NbIaS5vXkPpeQDSAOYU9ELEniM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVWXnNrqbMaXgFBCaVvRnVg5T5xPLn7SliOclQAen8V34eZwj
	tGEUwCjJkLevceozBwve7Ir5lmWuxziHpNzq0M7BhFB5t1X9PMeQ
X-Google-Smtp-Source: AGHT+IEY9kFOHXQPcg+9v2yJZSFeIgArFJv1Hfml/Xpp4JSru9yEwacU4phD7hjsrxp8tcG7A9c5OQ==
X-Received: by 2002:a17:90a:c90b:b0:2d8:d094:9725 with SMTP id 98e67ed59e1d1-2e06acbc27amr3571722a91.0.1727280882149;
        Wed, 25 Sep 2024 09:14:42 -0700 (PDT)
Received: from Emma ([2401:4900:1c94:7b93:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06cd08f0fsm1715086a91.0.2024.09.25.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:14:41 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:14:38 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup <anupnewsmail@gmail.com>
Subject: [PATCH] arm: dts: broadcom: Add missing required fields
Message-ID: <ZvQ27pvrnEYA8BB9@Emma>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Added below mentioned required fields
  1. interrupt-controller
  2. #interrupt-cells
in the bcm2711.dtsi file for the
interrupt-controller@40000000 block as defined in the
bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
This issue was noticed while compiling the dtb file
for broadcom/bcm2711-rpi-4-b.dts file.
After including the above fields in the dtsi file
interrupt-conntroller error was resolved.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..313b1046d74f 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -51,6 +51,8 @@ soc {
 		local_intc: interrupt-controller@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
 			reg = <0x40000000 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 
 		gicv2: interrupt-controller@40041000 {
-- 
2.43.0


