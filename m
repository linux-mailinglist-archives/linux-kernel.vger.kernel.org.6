Return-Path: <linux-kernel+bounces-345891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8C98BC90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E5D2884E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642471C3F32;
	Tue,  1 Oct 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddN+6VgQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE721C3305;
	Tue,  1 Oct 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786748; cv=none; b=Gl66In1zzZhNvryzDBq2ew1ZwV3MkwGZlskkXzwP2BCPoivWDB5VSHs/fOaHt4ILd+GPexSi2QS3ozdaond9Vf24H/NoqpnZkW4fIhLzOQFr2+MCkos9trCliV82Oks3/2Dt24gHrgL/8EApnnujsv/M/YMnHVLdufXepzOgQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786748; c=relaxed/simple;
	bh=vIJP//LDwqp9d1ES2JWxaeW61nA8Y5L2wZyNrUb4Jxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENo9tjDLpaaCOUeTtWtmkeEjowE2Fg2zxN+4kzknMMoNLeseKApSSngK5Y6v156dpD1b5Y4GnWw3JNEbpdWKNH3iLZLqp5XWhiPRgmeCf+yk4Jd82t6b2DZSoxnHAAco275QDdaNZ1V9Dy/VLK8VLHbgcr/N4KIGeXSsrgh+6Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddN+6VgQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so4394066a91.2;
        Tue, 01 Oct 2024 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727786747; x=1728391547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lgFxHwlPgcqQWOe6Kh3f55RJmwv7Nk1Xd/rGvKcrl8=;
        b=ddN+6VgQ4SmHAR/OIOid+eAkUZNYXVy7CZlWZPiLRYTXoe7JsecaI1KMq534McYze+
         YrIY6IHvBcXWHc5yivhrZVwEU6H0Ll55C2lxfjliKK8tbX4h1pD5uvJA7Ijn0tHPxJ3q
         Fn5SoV83df/4DL+7zdart/BrDSPf3KcK5RHi+swY9WBerEnyPkrhhWXklhHcHx0QFgv+
         GsudBgPyJ2Ty+Imubz3BEt7qy+eCjxWFlhof/rXkmG8v7DN3DaivWMa/LHfaWiNWw80K
         n74ky4EeJYWggKeLv6NzQUT+1TB0F3LfjTg3hhwmahruLDM/IMGqkcCGZJW1P3/1jNh5
         41TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786747; x=1728391547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lgFxHwlPgcqQWOe6Kh3f55RJmwv7Nk1Xd/rGvKcrl8=;
        b=sDkLBvW2CB+tMDLg399OIfPxsNgxnkAjSo9WVDMF7i5Sf2Tdi6Ko/KNrq1cvwRbi4a
         fUBLDWloA0Dk8iYceni6hRvTJ56ctvCoo5FL/rzHO7jW229Ew+16AWFABDtTk+GfYdyR
         h6Gai12k4w/GxhMJ7iDobRktC781Ml73oIJGKuqaD7BTwiJ839JAWPTwL5HVx6aTkep9
         Z7PylCDMW8SIsbvPRclkbgznl3eXYaaahoIuFByXwDfH2XzBkToFkd0ky+ow0a1eRHaZ
         4AnVcnJyXjS1Uikym5ov0MoDlYwuNFWtzBdQoPxzD9B6WW+aIaXLTORdWbFzHRV3b7WM
         ICCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXXotXtbWBW5N1j2hjSKyaX/5aG0zUvMMezOeNIRMjHGSAkQhnvyJjkiA8bvwIGjO8XooJWasRVjdO@vger.kernel.org, AJvYcCXwDOKwj3d/yd5By/8pef7s9Ync/dq0CVdX+Fi1YoDgLtpRWShFkN3g8sViu8T+EVylROTuk5Lzy1AMBpnp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lqF4OYQCrXyd6D/OJwwMGG6tyTxZ1cZUGl4bWMGpN7Xe/BCr
	REnOqKFSQHtWXJNJKTAgHBkg2RPwBQuQKkrxfLWZyeSP9oyMOzP5
X-Google-Smtp-Source: AGHT+IGzSrL30VOUfoLyClRDdPoMyMLBNdWGQn7nW9CpSugHO/Cg/vDjbiv7uwVw9+a1echxGAVagQ==
X-Received: by 2002:a17:90a:ad98:b0:2d8:d098:4f31 with SMTP id 98e67ed59e1d1-2e0b8a20263mr17797001a91.17.1727786746876;
        Tue, 01 Oct 2024 05:45:46 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1704bdsm13629171a91.5.2024.10.01.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:45:46 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: imx8mm-verdin: Update tla2024 adc compatible
Date: Tue,  1 Oct 2024 09:45:04 -0300
Message-Id: <20241001124505.73857-3-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001124505.73857-1-jpaulo.silvagoncalves@gmail.com>
References: <20241001124505.73857-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
new compatible was introduced for TLA2024 ADC. Update the device tree to
use the correct compatible for the Verdin-iMX8MM hardware.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 5fa395914191..49562ec7969b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -484,7 +484,7 @@ rtc_i2c: rtc@32 {
 	};
 
 	adc@49 {
-		compatible = "ti,ads1015";
+		compatible = "ti,tla2024";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


