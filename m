Return-Path: <linux-kernel+bounces-304033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A59618EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CCC283CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D71D415D;
	Tue, 27 Aug 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSbW/oxx"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0B1D363A;
	Tue, 27 Aug 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792488; cv=none; b=QlB7lckYfCXMcqM2tdiWvZc9I3BmFfWNf50zxlcmfv/QlIhOY2szL5MoHin3b2cTWhD37kpncF1CTplstxzl1b4svCdNQObVJcBXfakSzRZIfCCuPvhz51DR/mPdvmUlF+w7DPHi8ThXlJNrZuYt3ylALbmfk+I9rR6qBwjYtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792488; c=relaxed/simple;
	bh=ZUQNvjzepWA4pCK8RLWIXzlmS349ucRwrxxaYBZS3Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCUddjInOg20OfSM+TZJ8/391PvzbOHrDRNzxLACVmmLO0p8jUNt64C+N1nM+nquISyBGeDJMHJpFv4sPEmVVDaQutekVHDxuXBVwxFLVr0vvB9htWU+v5onG34z/cWIRqq7awDFLmKMPlsN4dYikevpnfePHyCbq3Didw2S8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSbW/oxx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334c018913so5727716e87.0;
        Tue, 27 Aug 2024 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792485; x=1725397285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=557eQ0nrkCY+/ANVkKP3VQXQ7163oT4FiuaAuauOfKc=;
        b=LSbW/oxxKGfHF5ZV6yAZN3qWQfZBTr2DKmnwnmqQ/Ocp6Fmda81hiKMmtoR52ZAPb5
         TIbcBQ9s38JChrDaCSVjiSOUZDullkabtL5OEx5egSyNxRe/Kw4piZFFbcrI0TjLTA4N
         D0qANFDQygN3g5DjT9U9mUc5ZBF7TYnsnAlTamieXrdOnTkjpp9NebkobQsithPeYnu1
         uNGxpwQb1h1UpSmC9VaBc39vi8IH1BNzeIXpitk5MSx1Bx/aIgH8r0u9WYyfX3jd7OyH
         seHe/fy5xIVEotQfoIaDw0y1swzGau5W5wsxxtldRiFEr+eSBgSJlSrbeDEbO8+k8XtM
         PDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792485; x=1725397285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=557eQ0nrkCY+/ANVkKP3VQXQ7163oT4FiuaAuauOfKc=;
        b=Cc7UoEy8b/jUvvN3pg1fscTLsVATCxjotIYiVZknzpxM3cNz6DdfdqcCtIpcqMf550
         bleVPaf6/vdc4XbhuFBvk87eUXnYD1VAgBbdDYgHB5u3WN8GLNnUt4AsU7c96mCOxa9g
         cb4zLiAiqJehrYIFWuBE6o/nDjJyG/He8IDSkLHAtbt7Z5J/dr0a+IDIMT5jD9snNmJe
         1PaiM+G4pQ41jhSt652KxUyS+/kgikQ7uHted0gELH66EucrYHjx3+YPl4YMb+gjJoHC
         nkIirsajvVMWzEIEAJLggD/pzvDozrugn45FTIRMRYl4QPfiTKXrGcD+MCocYjncvDhq
         DVGA==
X-Forwarded-Encrypted: i=1; AJvYcCUY/xawb3/jRGKC2roczxsP9voRTxpZ2VL3NX20BBr66aKNkOLWsiQ1TXEMi6Oa71hdLlAHLAAdfU011js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcKaQkelfgjNjNIq8BE+/h9MfM4TxY/aVR9xAWijdErEbp12o
	2WqudE8CEWVWf0jL4Z0EE+w6PBZ3Qcw8L9PuNrWel/BFPjanzHR4n7XDvVxLouQ=
X-Google-Smtp-Source: AGHT+IElOZVXVj/FlEZ3fbmtBkOLSrsihpcHyRreC5BIEGKSLXXKFN04zZD8UqjwCA5j+FE4FKXBkA==
X-Received: by 2002:a05:6512:3da9:b0:52e:f950:31f5 with SMTP id 2adb3069b0e04-53438832e67mr10098468e87.18.1724792484028;
        Tue, 27 Aug 2024 14:01:24 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-82.rib.o2.cz. [85.193.33.82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c3114sm1405835a12.13.2024.08.27.14.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:01:22 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Tue, 27 Aug 2024 23:00:44 +0200
Subject: [PATCH v2 2/3] Use regulators for pio on NanoPi NEO Plus2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-nanopi-neo-plus2-regfix-v2-2-497684ec82c7@gmail.com>
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724792480; l=958;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=ZUQNvjzepWA4pCK8RLWIXzlmS349ucRwrxxaYBZS3Do=;
 b=OhH9WG6Wv6Z7PRWzl1EICmfw7GOLJF8ftG+PLNKrN978hxBL+u9qLUob7ALa9BomlnNZ/FhFT
 BEERtDUuzqqBHX0a/5HrQR62Z6mGP4Wyw9rbExnS+yHEhGYtAGdeoVt
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Pin controllers pio and r_pio will have proper regulators assigned.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index dee4cd82636b..526443bb736c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -171,6 +171,18 @@ &ohci3 {
 	status = "okay";
 };
 
+&pio {
+	vcc-pa-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pd-supply = <&reg_gmac_2v5>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc3v3>;
+};
+
+&r_pio {
+	vcc-pl-supply = <&reg_vcc3v3>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;

-- 
2.39.2


