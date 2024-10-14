Return-Path: <linux-kernel+bounces-363939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98599C8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1731D28AB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA301A3AA6;
	Mon, 14 Oct 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhBknwcJ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58DE19CD16
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904929; cv=none; b=GSdhJkMesLC3DX9KzmWg9VQJBf6O0X0yZD9dSpBO2djoJXsRKU5pTg1FgKd9wFaCuVUORJL0zfYygsUpAZ2JTdup94DZJMYpSz2Rj45wBUOARQA6nqIPFULVI+fKw34FxzHMz5bflVGKu2CJO148hpJjJNcP90d7jj8ocz5CBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904929; c=relaxed/simple;
	bh=huuKwES/cF9ed1PG1Dp6LLcM8G3XLbe2d1p8Txn3uKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaRtMozlneNnN65e6ldXqtZR3tQ5d3IHL39UFvhNVoeW59mOY5ygPMl9rlVRV5D9QayjJYSAmnZxWHRfE5QspgwU0Bhqw3PmhKWVdP/D9reWC7hgHbvcRbBo0POegStLgAqyT5ieyWH77G12QrRzqoocpELcXHEaCL6gSvQBgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EhBknwcJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3603124f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728904925; x=1729509725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olZ5gRgNTPPzNeZAbmY0eEAkkRdL9Boc1GfiFZ+n8vE=;
        b=EhBknwcJx3vFkmaX6GTAhIwTFp0QGtrF9BsTbsp16XoMXq681sQDAYS+hexA0UB5+D
         C2R2NzfvuiPLFHJhAichMlGWuytD+fwUYD9JP/cYWVmT9mSsoNX2FfVKc1EVGWQDHnPp
         iqYUS8q8cioHf4fWin5u6rtJCiw/T+EbLn3aP3rwXSADNd4m9RBozex0DnjQjXLo7Tdx
         8PVVNwN+TgIRuO+79qIdCNLlVsDgWXYhCrFOPKIQTvYihaSq9V8DuWvEQ1j5Pxwvu/7X
         LGpL1w5Yu5vmvk/BVBQDwahJOa5GcmSwTZL2UPG0zmju9L/6ev3uYGase4aVLsWkqK8L
         zIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904925; x=1729509725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olZ5gRgNTPPzNeZAbmY0eEAkkRdL9Boc1GfiFZ+n8vE=;
        b=h1N2FOGxM5d8LeQU//w4V+T4/N8CUpItxcI75FiHKDMHrsBpEnoJQmh3oa52gokBHs
         BuCr+hQp5aG+TUJO+hs6hj4Y72iaZRHnVpCRvlX1H7SWVQIb5wefGSgmfiU5E97Tk22R
         hvbHp9zNOsRfJnWxHyGfjM7Dt9MvZShcZvfzd2n5U6EiucK+E43aeHCY/dAQV7wN9G9n
         CslwcwqHInbUnqBGZ7lYlilpg4GulUnpe6P1kNRshimZUjEHelizdxu+AepN91FLGV1f
         AbaU7Zy3OpADd6Rbat7IJ+ix2KQBdgv3nUYO63ZWdaRVltyGclTTGC7ExRZpn7th3QTV
         9ucg==
X-Forwarded-Encrypted: i=1; AJvYcCVc2VUU8HmJNaI71nHZA4fkZnWckjqjZAxtWKkPSrqEGjoyNlDooCmYVN5Ty9mSvJvtvOMX+9+I6AB9Jz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/66mK18RqN3WrIMvSSXSInc+kQxARZW7AuEO1+5LeqKq0IWDq
	eW9vZmDK07Hn9vQ9Vg/DAfZo225M4/mKRm3xlNizdXI+j2/CSG4nRQfgqGgGTCo=
X-Google-Smtp-Source: AGHT+IGiC89HONHqf/hzy8YyXylx/pE0yi8XqZDGzJs001OKJryNysL6JrtDDTUdjNon4ZWTw00p8w==
X-Received: by 2002:a5d:688c:0:b0:37d:46fa:d1d7 with SMTP id ffacd0b85a97d-37d601fc3c2mr6330831f8f.57.1728904924842;
        Mon, 14 Oct 2024 04:22:04 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8666sm11098702f8f.22.2024.10.14.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:22:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 14 Oct 2024 14:21:48 +0300
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100-slim7x: Drop
 orientation-switch from USB SS[0-1] QMP PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-x1e80100-dts-drop-orientation-switch-v1-1-26afa6d4afd9@linaro.org>
References: <20241014-x1e80100-dts-drop-orientation-switch-v1-0-26afa6d4afd9@linaro.org>
In-Reply-To: <20241014-x1e80100-dts-drop-orientation-switch-v1-0-26afa6d4afd9@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=huuKwES/cF9ed1PG1Dp6LLcM8G3XLbe2d1p8Txn3uKE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnDP7XXopuTGjM+skPFe7jrek5RkLqaEhJnd3iP
 h/72wpJ/1SJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwz+1wAKCRAbX0TJAJUV
 Vg7lEACcCeIl2kFX9Q7qsQzvdF1cyYmGZosHNM421+ogp3DVZ3FYMVWGE07Guv7WthDpFcgZoJs
 g67/hb0obGEm0gd/qnH5dKquyIkSgfMC2cdLssOMQUrgevu3S9awpE1dCUzKxqPVIwTYlttN//g
 c0CkGkqb4Vvq1vWJ3HCAo3x6FGz4hNA9MKD93pX+0Ftt8O8lSF+TPWCpF/AkQkkD3FLVK6HCc0B
 vhhQeo1RKP4iWHr/qr1ttF4TXMwGMTLe4Y+2Us632GRTp2gKEMYo+DQReRp8u51dNfSUhTbA8FF
 sWsNNtr074ARUxGDUUwckcmD11ENx/gl4C6kAt9M099Yu+K467XW16UKmzU+9pIfsFTydW+mU7e
 UWwtSrp7kvVVcRtHhsfrOsmfiECB1ltKP3CBUYg4Cv3R79NnOpj4iyrY9OvrPmWHJE5qA0JoKho
 k3GKC+UeeIsKNsZ0sFvEbYAlj6tzT/0zT4YfWe8P6G29Rpe+xd4pcwHdpXj9ZmKWEjbby8XpBBa
 CePrL7yMjf4YWxodiRPvVrnbXDECyU/qqhO08tWmDW1X2/E2DhddyUV4sLf0YN9B8nzKvgf7+8W
 /2r9lVnGmiGvCGwonWjwAWaegoDkJ1MX4ZorGVhE9AfGNoaED+IkgU45pp3Cd/edjG6tQorg0Oj
 oqMUNbuWOcAB/Mg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The orientation-switch is already set in the x1e80100 SoC dtsi,
so drop from Slim 7X dts.

Fixes: 45247fe17db2 ("arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 1f292cd4a71305e81edcd1aa87f100881ad9dedd..257907df5a649d5208bc9ca6c02f65f38b848da4 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -909,8 +909,6 @@ &usb_1_ss0_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 
@@ -943,8 +941,6 @@ &usb_1_ss1_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 

-- 
2.34.1


