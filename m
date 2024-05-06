Return-Path: <linux-kernel+bounces-169585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E898BCAD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B88C1F21482
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF614386D;
	Mon,  6 May 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKQvp8pw"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C4143744;
	Mon,  6 May 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988243; cv=none; b=BsRgnLD/gu29+7Yd7DzuwEppt0qfbRdja+FPcDVUVqpIWsuLMis8bDlJrnPHRkGbzlZivIVQ0GSF/C3H6m6CSFW1zQ5EEaUXM2NVAujgYiSMy1yK+sKkkLOBH+fTJR9wkwPDOPaL8HpdinWCQAzq9jG0seaGrCDZ8ozqKfsibYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988243; c=relaxed/simple;
	bh=QMB2BQUFw504Si0nPhgwd4U1cGB1jsKPa2V0a7oyVXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVzNMg75bzb1excL95nXeJoqzgbZqUPTLrRRwWU0TbGd0rlcUSobumK8V9INEGsq7THMVtVrS4X10l25di78B0gufVHlx5J2fnBlxErZoWnZk5TYseo1GkQNi2eI0kKsbZ8gotuVmJ1hokRYCvZ7dXoraJCTgU3aCmSZRikUL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKQvp8pw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a599a298990so422221766b.2;
        Mon, 06 May 2024 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988240; x=1715593040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPJZwHx34N3Ow7z49nFpdVnJJVNFy+nT0MarnQ8cM+A=;
        b=DKQvp8pwAbFihVaXDFtwLkdHtNxOfJ6iLt3RPZUgUNzhBWp92CAN29BSjGrXAgFW+f
         g6GzWGIakP/Kfmwy3zrCsPnGR3fcnOe8tqgtcBMb21pxE+3BM8ePO/SJ+3QHaCKoKo79
         DMVKJr220hOnsch9mNz9g4m6wcPjDyXEbDIEKKC0NaDDFS8LElwQ0fNueZwmJb/v4Djq
         laIC6qk1Crf4xcYJ0SVhjxzk08BjwuH61p3AuEVTf3TXU2IcdKW4YRTC0SWvsuZmuiQ2
         CqczN8XWrJ53xwj0FjxmPJP7KEbR4UOHjaW5scRNdxcNfN+0/fr9VNgxlO99QiDOIrEz
         SVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988240; x=1715593040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPJZwHx34N3Ow7z49nFpdVnJJVNFy+nT0MarnQ8cM+A=;
        b=l7XblEr6Q616ZzmG5OmxA7KuS2wL2ycPqM8UjrS+D/pXQ3pBxcReapfM3Md7dYjq3F
         llurOKy4NxZKajXoLQlKbGzr9slYs7f5QeqUSi8ad2/3S6NDDOxR4XtoGafj2dMSHFAU
         +noS2y44m3WN6qvFC33eQZedpqFlJx40QOHGw+mBfL9SWygy+ljB37Aq/qH1gt59bxqC
         5gkT4TF9JEOLLQkfCAopwnurAW9nx+4ShNFuKmMW7p+pRKgI74hSBe7KisJFfBjIP8Jl
         unqwev81c+xSa4VeNgv6xYINPQjaKPEejOfs7ZGhOAPq8RHD+3gA1N/iX09UuBOBqYBv
         td2w==
X-Forwarded-Encrypted: i=1; AJvYcCVFsSHqaDJEQmMMNblw/gtyx5gjGtRAt2siTN0SEyHnKcbHW/dmnRKnjaya79YsUKgGQo8gAGWI6C5cSqu52uorVxS44s5gyoQeDq+lPHnaOCa0qSnC72nR6la2t8A2m1Se0ypOCcxYIA==
X-Gm-Message-State: AOJu0Yyxtd56p5LF/AJ3rcrau4yeuFLouo4FszejMJok13T8XUjwkz2O
	q84DQVyQJ7fd0o7K2S0Lw0LqFGD97fqJglwqSxohWmLvri+WNcMv
X-Google-Smtp-Source: AGHT+IFaEDRcX/eXmw7esyfzzdC59VSTAyURsII4QqC2jC9dS3tj96yWHX5rUfe+NF44OcXPw3e8+w==
X-Received: by 2002:a50:bb42:0:b0:570:3b4:53ff with SMTP id y60-20020a50bb42000000b0057003b453ffmr6300213ede.6.1714988239866;
        Mon, 06 May 2024 02:37:19 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:19 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:34 +0400
Subject: [PATCH v4 3/6] arm64: dts: rockchip: add passive GPU cooling on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-3-271023ddfd40@gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
In-Reply-To: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=1255;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=QMB2BQUFw504Si0nPhgwd4U1cGB1jsKPa2V0a7oyVXA=;
 b=kOJ0Ccq6KM+zlPF5AmBsuM09NjiaXHs7BkcQ43+BtvNRKJFT8LEz+ydboCdWRkGjp1pcFJNgq
 YfaX5AKGTxsAeKGf08Q0SYC6Lt+B7TVrNrDrlkoUuC7CKxfBqCVafZX
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

As the GPU support on RK3588 has been merged upstream, along with OPP
values, add a corresponding cooling map for passive cooling using the GPU.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index ef06c1f742e8..57c2d998ae75 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -2487,17 +2487,29 @@ center_crit: center-crit {
 		};
 
 		gpu_thermal: gpu-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsadc 5>;
 
 			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				gpu_crit: gpu-crit {
 					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		npu_thermal: npu-thermal {

-- 
2.45.0


