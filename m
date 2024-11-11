Return-Path: <linux-kernel+bounces-404538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86C9C44E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DF7284DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96A81A9B33;
	Mon, 11 Nov 2024 18:18:17 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C31AB51E;
	Mon, 11 Nov 2024 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349097; cv=none; b=tH8Vgxhk5Pi4cyCqDu3z25wPIK4+27XEK+d/2fbSeB6wcGU4Mvgoz2u1pJwguLF1iRuGsSL7sFuRGWLaZT+sztk4k5XNGMzq880fmWGjdE/cCATsYHv05Myr71I8ajaBxmCMX+qi8UBkozJynzBNPaGcfvLtmINEm9FvldgXtWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349097; c=relaxed/simple;
	bh=K91dOhOmskhPTGyTEdB1NS0r2O6vcuoC9unnmwrJeXE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWX5oJYEPiYDwIzKclY5Tx4wpDDRJRZ1AkHR7gCS2VTXCGmHQ/fuqpe7VcEKkP6Ini/3Rd2lS6TkX/x4/jQjFWsFyavoAAZ/jfm5QuXR6+kPH4JfED74wf+qZd6QUG6IXBaiLUdWsDg/j8MyzFn8myH8Rjn4ftW7lX7SdBhMPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a68480164so711879166b.3;
        Mon, 11 Nov 2024 10:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349094; x=1731953894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIW7DyS2WH6Cyrvm/ebpRPiFw91e/Lrg2SI8ILkhrNY=;
        b=tXvuXM49qGAsyjwXTlriu3gia/MN+2bIHrB/6AthrpWuqrRvYcmcYOoKhuHfDw3Z78
         jqtVc+m+7NyUF1uO9xmoQXzuyde2GA9xyqhKr7EDgRxKOX5zJ0kTqYDPLUIJrF6oylBf
         7z1cJb7g48C+nYcnmGoxQKgaf0Qoznip+se/GG0AA7PXrSDLhtTzvS0ZN9UkUJRzJsAd
         CpwlB3C/Sl1Ahyd+3fyUSfGgkuISiFAze/wztsY9bhaSh6LqiqGBuOEpt/fATEMCWCoQ
         ql+WxYA6ZXTn40+kRbqyw0yTCIi6x6RFTrOVi0WIx3jMpYfb6rcwlGO3e7j2dFoEc6Jt
         a+LA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmYP6rqSYx+JGS2Lco3b0e4S0dH7p3mdcv8q88zehzScdfz82UKw1skX8WHwV3IGRdgU1vKGjXzJ5@vger.kernel.org, AJvYcCXVZt4+FLaCBOLZ3GxL4FwkdV/up7xujReagiZmxGchpTpK63Ns34Tc2YcAqxNmPMDlT+rDWhq6QbVIi8r9@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeewf4LHtwTBkL3Xwx3gLO+OXpugaixZDHo5ImvAv+1JCa7yz
	oG/f+Y9qVmn9C2DeQsZ8EvOMQNw9ldBUoWyGPSrlfti7bSb/NGQy
X-Google-Smtp-Source: AGHT+IErIzWT0CMgys4ztmmaJblBGh0zeoh24ympSdB4fT+d0iex40LKQpmMSIi+f5EOJn7E8Pss8w==
X-Received: by 2002:a17:907:a4b:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a9ef001915amr1385377366b.37.1731349093673;
        Mon, 11 Nov 2024 10:18:13 -0800 (PST)
Received: from localhost.localdomain ([193.142.191.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b64sm617868466b.39.2024.11.11.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:18:13 -0800 (PST)
From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
Date: Mon, 11 Nov 2024 19:17:27 +0100
Message-ID: <20241111181807.13211-4-tszucs@linux.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111181807.13211-1-tszucs@linux.com>
References: <20241111181807.13211-1-tszucs@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable UART lines on Radxa ROCK 3 Model B M.2 Key E.

Signed-off-by: Tamás Szűcs <tszucs@linux.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index b7527ba418f7..61d4ba2d312a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -732,7 +732,7 @@ &uart8 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart8m0_xfer &uart8m0_ctsn &uart8m0_rtsn>;
 	uart-has-rtscts;
-	status = "disabled";
+	status = "okay";
 };
 
 &usb_host0_ehci {
-- 
2.45.2


