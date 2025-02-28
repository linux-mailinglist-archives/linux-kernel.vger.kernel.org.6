Return-Path: <linux-kernel+bounces-537766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF50A49060
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D280E16D9A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C21B85EC;
	Fri, 28 Feb 2025 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/nAEhyZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F391B6547;
	Fri, 28 Feb 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717163; cv=none; b=DvqRqIIzsRaKPiJJnw0IG0jwUo5MylmC9j46czmW/1VZviq3j16JlgDKz3ugSykQhKixnZRUQSPMZkDgUfXX+bszbsKGCWsOZm7Rguc3J3Ht+HaXq5agd4eYEjCPWcw5UGYyJ4k5r9ew9HUvVqaJU1oxRhdDKNGR1Kh4r/Wk7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717163; c=relaxed/simple;
	bh=oCtYD6WrFTqNAI1VrGeNu5viopS22BzTCxA/dheRKnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L20J0Eog/DAzQKdlGjUwenUDY2zlU4IIbJTj5VSyFR7/NDuccWCUbl+NAnBiA/AUKAKO5dOLpsgcArNJOPsZuLbz9OxvqeUTf4VHRj0Vd3KZDY+sp8PXGyL9xkmae66T0fFIgibgEkzsJO5d37Vc2mXoHt+ktRnIZacW8wPp1yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/nAEhyZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e83d65e5so30856345ad.1;
        Thu, 27 Feb 2025 20:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717162; x=1741321962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xF0/ITvO5WMYcIVP2X8KXWndD7+120RKVLBcHZ5P1k=;
        b=V/nAEhyZETlhbGCVbxWt+NepFSzAAJYa4HnPyDSdf9na+YTDBxICQHoHYFt84BmZpC
         ISf8rvzYAXiWsx7WBkErEj7x5esYvflvcT7Pmn1pKCsfc8Iq4F4GTf1DXgxSrMUeFzPD
         VWw9i8AA2dczPo1pxw5MCuliB3F+1qBxQif7Dr2QuZygMwjX3xnNkAJsECwBWjC5QnoQ
         59gKHrygJDw3+7xpY9HwcJIZFsj8Km5JiPNhX/uVjW23rAFx12LmqvtuZ3fRpSH460ot
         tN+TLGSWZqTI5vwQG4Jy1ohlEV053CKkYBwc3RwHC/GIyg+WPhcKbh81PWabec8T8rrn
         ndeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717162; x=1741321962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xF0/ITvO5WMYcIVP2X8KXWndD7+120RKVLBcHZ5P1k=;
        b=f9xbiUg3chsFoDLjv361k8/JV57UzQDd1YHrGQzN/TeT2JojS1iAuAWgDOF/2ZUyY6
         GLNRDhjEJvvDuWvdk8zJVzUEUAqunJRdlkXQ4e5o38QB2cTxFUMn85X1/1j+FfLjT5Wi
         CaThliSLyWaGepeFs1X2hRaTUVgTXQhQuDWJCXXndBigMSPSroyP60TUbSW/FVMuBB5L
         uDqRePGrABmwtb2lCOsuYP00tpbs/EuEi4Vuk88+48PE2s8U1pA8G/ZTEijQU/rnwXJv
         SXI7KrZahQKFKx4CcO9Fq4gCWm/6xHNtdwzTXymMbhlcap7GpI48UCWVi7hOkcUTHxXa
         K/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVDkU0Iy1oK08Dy6Xh8SozUEb0NUl1xpqDanOn5Gah/tMmNvw5fwcBYKZ4WVbphY1PeX7gyx7pRpwBddJt8@vger.kernel.org, AJvYcCVbmUjlEYwWQBT+2CgWcE1eCdLUqCnoxZcMJEZrUcwWMXHRJHXIhos491GCfEArL+HnN6gpv9CdWSvy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9uxon2PiO/NHxF3YSn96xrXM6XLYhB06xsUzad1FkGZCUkiu
	Br2HDKO2kx6hwyiABiVQqbvsoEPEHFHUSFF10gO9uyaB1DoMgsmFy+8tcA==
X-Gm-Gg: ASbGncv+JPtg428RquQ6jj82VPoRiY5ngZW1XflOMoKsVJA5lis18bcuFuHqOSRm2R2
	EeWgXOW3Ua3mPbZFd0hFDsBx89rby91+VzPE8C3Nm8V9ouE9ifpvTJ5SSv1YhpbgacgSuD9OkWj
	RL6prL363fRYScFqlib5WZi1ZHHCUz8D8oRTYgGmFyjuqB390J4dmpb0aUgrMKYVkaks8/8Ref1
	Dh1zDK0bI1whnCJuIJtb9ARmqRLmboucHCQFn/hZp47+Yoi+qfCspcCIYGsxmenb9l4lG6EkB4Y
	sXjxIlPWw1Gn+Cu+Q2QdcseCBkIU
X-Google-Smtp-Source: AGHT+IEmut3mjvd9t7e4uQ5c++69AVnSEKUizaMEaksq0QUSCwyJe+y8zLL9BrDMTMpqMp62yCDG+Q==
X-Received: by 2002:a05:6a21:48d:b0:1ee:69aa:b665 with SMTP id adf61e73a8af0-1f2f4dfc296mr3428809637.29.1740717161789;
        Thu, 27 Feb 2025 20:32:41 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm2738204b3a.132.2025.02.27.20.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:32:41 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:32:13 +0800
Subject: [PATCH RESEND v2 2/5] arm64: dts: apple: t7000: Add backlight
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-2-69e450bc4bfb@gmail.com>
References: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=oCtYD6WrFTqNAI1VrGeNu5viopS22BzTCxA/dheRKnA=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTxgX2wM5nSlNR8mZr4uHhX/RA6TbIYprmAXx
 +RyoS0oVaiJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E8YAAKCRABygi3psUI
 JFzzD/9wvCup7jCFw3YaxVVUGBWHeHFXw8aHYaVftpKBX9756i4oc4jGoRVu0aQArSTOVGUlN13
 2UrxX7m54s69ymovtRGKp3bWk4CwB5jQd/Q+IRV0Llp4nJ/zR4xZvWrjB7yfkoptDGREscYloRX
 6eU97W3OjuQLxg/DSV0Ezowe4fYqpHcN02kUtKqbFIdwCuIqKYahWEHnhUHBSPewjcUrJzErjdh
 rDqSNswanKlbnIeoyHAlYILzr84ACRCpRTdJti5ZgoiTzRlkGhVDzSygCAdDTRHRNf72aClegft
 GDd1CqZv8yB2Q03PfUZEZlluX1o6l6PbQRIPA5ezMETfhR+O5k0pbiHLjSjORlIklUTIofP9too
 MV4D11gZsZ/wq+9YszMPKcTvEp5Xx8u6ApzL96bMTPpyZv5ATZMH13fNoYaotc7ilCRmyc69Jlz
 z2U/7pZQVwEAyc4TBfhZ7irPDpbBKWUHvC26d8QasHeoTPV443/aCYcRsv98K7EezbrQva777fO
 59heovbpJTbgg8H8zmxR7VadzJQgMLoMS8Cdkwd97/du/OILDRTjuaXlLFSfmzWcBmuoGGtP01e
 lE5m3e6BwYC7C10IQU1aljtmjL5F0svjawTCtLtv3u6IQGIalgTnNVgzOxDpllav20EVWWUQdUi
 tXENaa+yKQcDkog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A8 SoC, and enable it for:

- iPhone 6
- iPhone 6 Plus
- iPad mini 4
- iPod touch 6

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi          | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
index 8984c9ec6cc8e3c86281a3da719edb56c5bb7f5a..7b58aa648b53dadafb3a01d9ae1e01afa6cd5869 100644
--- a/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000-handheld.dtsi
@@ -22,6 +22,10 @@ framebuffer0: framebuffer@0 {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index 32cac8c30e62d657079dbf32aece8af0fd9cef38..85a34dc7bc01088167d33d7b7e1cdb78161c46d8 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -155,6 +155,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200010 {
+			compatible = "apple,t7000-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200010 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@20e300000 {
 			compatible = "apple,t7000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0e300000 0x0 0x100000>;

-- 
2.48.1


