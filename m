Return-Path: <linux-kernel+bounces-433846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF09E5DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91DB716D089
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB1229B23;
	Thu,  5 Dec 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsBP90Tu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1B1922FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421728; cv=none; b=ajY9hazHNcLpHwEi7Jcrwf7Ttpz9alOdaCJ1lpnxU2mhww8HU5hBFMI3N+Yb4irEuRT3hZjDi826PUOfqdQFs1U2RW6jLntv/t4blpPW47rhjrgpDoRYwL5ljT5bKqnjDvejaRoF1S27CknjufylkUEdY+t3C6s56+Nf1J+T0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421728; c=relaxed/simple;
	bh=dlMuW7aHH3sXo8GJQzvMEdKqOSxun+0YrH0hUFqmXK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9LZSBltvrwHzB3pDw6pKh8VMPd9bHgmRDHXLU/iIIiaS06uOOT9ktcIA0JluQNlJ7VJpk05J9G6DvpK+Fv8RNT3+JOt+ifPdTxwr0U6jxYY5tKgNW7EXZIdUY5pgGdPiTELR6f+KaBFcqiO28WrpfHOW0TCB17DEVwZULUn+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GsBP90Tu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so667290f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421725; x=1734026525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUhzG3caX9aWXbpAIl+TsEC4KHzPHOePfY0vBdmRaDs=;
        b=GsBP90Tup0DQtGgO1Apm6K21drOeWOqV7zjJyWzva0TVXp2NkLVk5NBLjax+adIt2O
         faqWnDGye38ItpaHSS81LPHGGwxv9bvfm+fCyvjYJPQDQ2M7UBH49Zjc+7qhPmTDdNHm
         5vusRseGmAQs461u5qbVOsrhB+v6iAl1Mr1z8787Wfuf0jI6iqjmh7/WlbElKbVUS3IA
         jFq07UBwgFow0EdiZnA2XX68eQtDbfvt3rFt6BvrSoKJjUvV3la9knmgihYiKTz3k1/v
         /tclNEBt1Wgoq9t0/NA+Y5fR1lfX+Uyt7Ro7uEfuTow2PjQzz5Ed1TwdNUtBOayN0UsE
         dH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421725; x=1734026525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUhzG3caX9aWXbpAIl+TsEC4KHzPHOePfY0vBdmRaDs=;
        b=tj2e5Fq26SzyD3uamE7R96TKj9dkZ4erXj0hJnfzsZM3IYhUCyIxbUiHyTms50ZlLJ
         MgSH9LTwjMUSeUMedJzyqPgUEJG1ktxEqXXLPsFYgVOv2QN3gdkSbTdKTcnpnPL5v62l
         bi4CmZYk9U7MiTQmup5sG8wWUDvnFbtSO9l+1HdPh6ZjwzTJrctfakua433G6+dHBV2B
         AvNJxfzh+OdyasQ1qzFNfLRUvURE1gq6VGnyJuJ7muwI8O9/XkAvJDydl8rx2e4SWYlE
         BjmXl1PQxWYnkoj1yFCTzTQst04Ks/mPHDQR4weHLyRF6EQAOMVGJUrcRqmLbaiiKKJc
         KYRg==
X-Gm-Message-State: AOJu0YwmcKrDTvVZH1KsR/2rVWcEVmMmIA/OWmvOVN71VUj6YjHkTHz9
	AzBKaVXVm5KG/5wW2HqIH+8Xky25BZKQlYcpNrwR/fjKg/vgRDdS1zQ6y1VSK5E=
X-Gm-Gg: ASbGncsNiaYoP/kAKDRt5clBxdVM7fcExF1kfaDBalwodRPHTqWMHCuSzN8o7u/UVYa
	FpDYLNa1vAX+fhCYc5lg77q7LS70TTZsnB7YUUkb0onqdEL8qmp9zK9uRTwselgIIxHsaYs8qDG
	+T9yj/6AajmJrVvyE7/P6xuHFC8JO7S+wD7lAcIpbyq2LpUoQjJoOiU4YX2tEHy4b/rbIae0tnj
	Rcpb5ac/IFD+aAdSI0BlCb5RAbJ9kzQlWMw6/DS4lrTsARUC7+J5IN5v5URBEA+m1hxJOSaukQ0
	HzNZ6XjRmDZZ7dJJcjNUpgTYQI8uHD7R
X-Google-Smtp-Source: AGHT+IGmIVnSzknE9WcSqtMq8Jlgijm5XW+UPlAChDtBhFcBlLYDYS+u/7aO8ZXJh83ENw/Haen6jg==
X-Received: by 2002:a05:6000:178b:b0:382:41ad:d8e2 with SMTP id ffacd0b85a97d-3862b3d096emr17492f8f.39.1733421724972;
        Thu, 05 Dec 2024 10:02:04 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098d3sm2618228f8f.70.2024.12.05.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:02:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/4] arm64: dts: exynos: gs101: add AP to APM mailbox node
Date: Thu,  5 Dec 2024 18:01:58 +0000
Message-ID: <20241205180200.203146-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205180200.203146-1-tudor.ambarus@linaro.org>
References: <20241205180200.203146-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GS101 has 14 mailbox controllers. Add the AP to APM mailbox node.

Mailbox controllers have a shared register that can be used for passing
the mailbox messages. The AP to APM mailbox controller is used just as a
doorbell mechanism. It raises interrupt to the firmware after the mailbox
message has been written to SRAM where the TX/RX rings are defined.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 1441e9a252c2..0970f6fc1ef5 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1445,6 +1445,15 @@ wakeup-interrupt-controller {
 			};
 		};
 
+		ap2apm_mailbox: mailbox@17610000 {
+			compatible = "google,gs101-acpm-mbox";
+			reg = <0x17610000 0x1000>;
+			clocks = <&cmu_apm CLK_GOUT_APM_MAILBOX_APM_AP_PCLK>;
+			clock-names = "pclk";
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+		};
+
 		pinctrl_gsactrl: pinctrl@17940000 {
 			compatible = "google,gs101-pinctrl";
 			reg = <0x17940000 0x00001000>;
-- 
2.47.0.338.g60cca15819-goog


