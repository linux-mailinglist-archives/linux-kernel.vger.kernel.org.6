Return-Path: <linux-kernel+bounces-368494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD49A106B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFABA1F218EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1202101A3;
	Wed, 16 Oct 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPFoh6GK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4D2071F7;
	Wed, 16 Oct 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098886; cv=none; b=FWKGjzoaiXEm+Ii+SySE+Zz8QQEHLK7A4jh8mLmPS4tKH2bBhDV8KoUMMI9hr+elipfOQQA5PokA37tEisYGV7A2DBF2kVJbjyiLHlwRwM7yat+vSc7aDbpQMDhQORRvX3Y8SFBYZM1kX9agb8/oJ5NcYUWNe9eKz8sKv0NHubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098886; c=relaxed/simple;
	bh=ctDkucdWT727QtcfyvLrsVsVaz0RIVej0zjiiwqdDwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KYrZGyJ4B6szZRptSg2TvqpnQNZIGzhCgZUTo7aXHrnwnhQf6pLoJ2zHMnhvSmuB4d0T7MvqEMuhC+Noufxo6tsR1WW4yzawjY4dfAFeLwzCZ9RqXgGT4F8+AQztzy+Frj9IqoRtrfv5+xRqchdNfRmQ7wpmRe2uLPi5jHBLtOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPFoh6GK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4409374f8f.2;
        Wed, 16 Oct 2024 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729098883; x=1729703683; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cKyyxmh29uZru7LtXOcW6LXWnEiHiFSzv7EPvI7QDuY=;
        b=bPFoh6GKuR/uvdCNnNxfwZSgF5IUSy37ruXvg/kX7u3mfzmYW+Ahko58TLLrNbkQ1m
         tN2blYokm0SNFvcODCmHHqR4HETVjAQqR+/ogyYVgmf/o1S6aNflnS5dLjVKfz2IBo/S
         xJOKLTxG1hsaFgpcBiMDw3e+rqYhpiKUCFzSgEQFqLTdrLoDdRye9qTBI66+ZMm4Gzd/
         ggQ9yp8TYAYD0P9OuK9MZPbQG52ZPiEZVAOkWyQzY3bqS4kLotwSrX3GYH/k3AztSs0D
         +1mEoF4jYUKXPoUwi1ZKV4uPepajeCRIwUhtbi6Fk5XyBTtQWdqK0/wdmxpMxJTzToV/
         lc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098883; x=1729703683;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKyyxmh29uZru7LtXOcW6LXWnEiHiFSzv7EPvI7QDuY=;
        b=PrXT0ckfqwRCnazfFMBASuroDVbHfyuAwR9EuFCpcIsOYY/zx0og/b1SpoQcKOyxdU
         TXaioDP7BKVjxXiu0GUH+K2AHirMYO71tnKELKEYAil8ml00+AGYDR+GSvfIzrWuQVPN
         bgbEExJHH0zuB+DnlIiUxWKDnxXodkGtktM94rSmsy3taGg/XXwD8ToTlMT+at8GsMsL
         Lq5Zfal3ASxtkbrtSO7miUsUeD/ACaFWTcaXMOVqUT3+oUgUGVBbNGbEbwO8axfCc1m2
         g8feMzuS6j3mY/uTPpKE+T90nSYhfmsEsqTmTQ4oEC6oWPX47LanyE5NT72YShKNYJvp
         feUA==
X-Forwarded-Encrypted: i=1; AJvYcCX62rs+oO1YZ4C+mRLvac7+yKzJ7/CLUdVKjqQWX0iXxm/thXYuFHFXCJTxVVv6vKWRmF5YRv3VOVAPtUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MJSjeQqg0KsctbJ3tBQX7dEx+2Yx3lHJ/6mlXIFtvoPpkrFR
	Fgl1/f9cxpYwLn06cWA+UkgTQvaDf71EWV//AP6fzR0NJxasqzbB
X-Google-Smtp-Source: AGHT+IGpFMwl7ooBJDy7Lt63ObX+cUQ1b9e03G3lB5JTkgyGuQuk0jg7mzz4yqOk14jHzJlb03Jh1Q==
X-Received: by 2002:adf:e5cd:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-37d55262ac5mr12698802f8f.40.1729098882411;
        Wed, 16 Oct 2024 10:14:42 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7238-7970-7b90-44f4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7238:7970:7b90:44f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90547sm4814423f8f.49.2024.10.16.10.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:14:41 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 16 Oct 2024 19:14:05 +0200
Subject: [PATCH RESEND] arm: dts: nxp: lpc: lpc32xx: drop 'clocks' form rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-lpc32xx-drop-rtc-clock-v1-1-5b271804d3e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFz0D2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3ZyCZGOjigrdlKL8At2ikmTd5Jz85GxdY6PE5DSLNCNTA0NDJaD
 mgqLUtMwKsMHRSkGuwa5+LkqxtbUAkkEoDXAAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729098880; l=1659;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ctDkucdWT727QtcfyvLrsVsVaz0RIVej0zjiiwqdDwk=;
 b=6T6r4rkPmqFp2TzLoGDwE6fCV3G4I26YlQXmOFtxS7ya40XV/MiFh+2PWQcTJ+OPjAlylpFlp
 XDDA6VmF9AtCo+7OsczvpSovlKKEK+4LV+Y7WquD7gi7rYLO2n9oyEn
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The RTC does not provide a controllable clock signal (it uses a fixed
32768 Hz crystal, the input clock of the SoC). Remove the 'clocks'
property to better describe the device and avoid errors when checking
the dts against the nxp,lpc3220-rtc binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This patch used to belong to a series that converted the affected RTC
into dtschema[1] (effectively moving it to trivial-rtc), and dropped
the signal clock as it uses a fixed 32768 Hz crystal.

The rest of that series was merged, but I did not get any feedback for
this one. I sent a little reminder ~2 months later that might have gone
unnoticed too, and as a few more months passed since then, I opted for a
resend with the single pending patch. It is of course not urgent, but
still relevant.

Link: https://lore.kernel.org/all/20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com/ [1]
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..f78d67e672b4 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -384,7 +384,6 @@ rtc: rtc@40024000 {
 				reg = <0x40024000 0x1000>;
 				interrupt-parent = <&sic1>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
 			gpio: gpio@40028000 {

---
base-commit: 15e7d45e786a62a211dd0098fee7c57f84f8c681
change-id: 20241016-lpc32xx-drop-rtc-clock-32acf8f25011

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


