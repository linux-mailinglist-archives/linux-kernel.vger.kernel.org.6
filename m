Return-Path: <linux-kernel+bounces-536952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C804BA48649
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA02A188B9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7D1DE2A7;
	Thu, 27 Feb 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Y+hMjt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465A1D4335;
	Thu, 27 Feb 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675975; cv=none; b=mUnn21f9X4Fh4r7nAlAgWg0krbliyUSL+HS11y5Jellbs0ATLwofgvsyz1/3awFEIRTfa7YSAkcKsZnZgLISa3UngeDvnzVDjLu7QCAFzEmv3rz8u4X01t4kA5WKdA0yZNROvgVPlJZ14HlaL6xnxeI2jU24e0AmHuOnCQ9OYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675975; c=relaxed/simple;
	bh=TkEK4S2m3kpoLQQipeT7J847hl/h6o+fCAe8yfTLOfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBo1A/R149mysivXZZNIYhtho2YSCEfsh7Jx7tlLUO/LqJwbcux7uNqgsKaI13CRS0E+OAJwy+2SwHAn1lRRHcYHU/bnHSxaYmPQ9rrXEEbTcOSGtr9ZUHElhSqUAlbPWQpyJ4PAn+lHZ24O0dT7j/2Ie5XJOAVL/ybfnB4sZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1Y+hMjt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390d98ae34dso945221f8f.3;
        Thu, 27 Feb 2025 09:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740675972; x=1741280772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gO53KeG1WPUYrsia7l0Tb9ExCzbXGMl2yOXGdu7Dqdk=;
        b=k1Y+hMjt7/Cd5VNwcwgXX+XmTVcdl9KxHA3QgB1/6Out2W/0qKAyc7ZaHhrNKYZIyZ
         EvRqBZsAdJ2HTLS7N+eDio6MozwqTdqtDHwVqXeSPQAFpUrq64e/K15dzQ9hvqC6pbbz
         0Jcqi1Um4u/PZxeP8QhTaLAiJOHXZk5wRjbJx7LWlwDeTO0e71U5msdiDKMI5pFf5d37
         vgTukS4lTPJRxewjEct/BhWGY0rHL62qIvEgbSf2RlfzLveaw/xxzzHMm3GP/fYyEDLQ
         t7Q9jzeQIDpgthiM6XoK3HpMx2jo1dGqFne9/MWVJiS2UBYVJcub1ZICxegF5mK4XPwx
         5hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675972; x=1741280772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gO53KeG1WPUYrsia7l0Tb9ExCzbXGMl2yOXGdu7Dqdk=;
        b=ZpPMOy/pg7QYWIabXq7o6kKebpROgJNbavXrBCmPTR62QexOsR68xVcL8JGTbvXXJj
         /hvFvOSRtH9Pi27LUm2phKv+a+Pue+9nOLavK6aNQQkJcQdcMjfWiKtnkl5iR6g7DcMt
         Hw4Vb5aJcssydxn4fDM5IEh6OKGgt/9MT6Qp9uWSMM8SZj6eHnMTK5r0PNCpfZamqeTS
         v3GQcTYHoRVrRiOGm5J93anDsDM86UpMXRfPAp5i5E/TN+DgdTVSMad11zLzVk754fzF
         1o61F3oyRkF4XHFZ+feH+PptszeWartUtVSXZYWcsuALMa8/p34rSO6zbAKvvAN5m52F
         EWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz8/B8DUD4v22XJmZZxDm0cdkPO2Buvs2iJyg63/L7uMwXiBQPMzmGs5OrdVm8yUTn33lseSazkTCb@vger.kernel.org, AJvYcCX35Wg6RzHrx0iG4hzKTwzhk0XaUJUfFkXT6ddJOk+WHCpwmgoxIyPaXNPZhPOYLQ8LZdD28UoFqLKTDdvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvMdHFX0C7kwAxJU6SjHhF5ZKEBATOXXD9hhGblYBdl6wJlDB
	UhbBxxet9PUEpPmq4HVzutYnxJ28vezF6H3clckE+H1y9jgteI4f
X-Gm-Gg: ASbGncujBSPRuJ12ZJJpU5hsdsH3n1W69x14SKGCqqtRSanp95LZcBoct4p5wg1sdXH
	qguzi7jEsfTnlmVqhDQXhE0NggNvglgth0UTAUln1oa9QWbQZ3oKUx9dfzf19VlDfj2wRtQlvlX
	uLdRsh0pmNHkyQ5kg9VmR6WPn5L35De1NjFqerNIk2jVRJ2Mu86HSWLjG78Nzc/w7gGb6ij+EZi
	jY9Kspm7pN+G4782GNXcaG2TUqsAKkOPlB3inF8lq+hNJta6OVbtIjEm3pCRccvG45c6z3S59uL
	bEGigLhIMJ6PXncoXkYg5QLuTvN7+Udqgd9NorD5tFIzhwWF1q69UPm/Y1NzhrhT/jsGJsoGXBv
	uqB6R
X-Google-Smtp-Source: AGHT+IERDIu0iZ+hBFIiIkbbbpaVVGZ6G37IX9OWfYQr1SknQHLsuZbyaI8TcO5g3Sxx15wY0R6sRw==
X-Received: by 2002:a5d:47c4:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-390e311acb3mr3600237f8f.5.1740675971592;
        Thu, 27 Feb 2025 09:06:11 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485dbe7sm2613138f8f.93.2025.02.27.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:06:11 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
X-Google-Original-From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
Date: Thu, 27 Feb 2025 18:04:52 +0100
Message-ID: <20250227170556.589668-2-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
References: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the STMPE811 touchscreen in the SOM dtsi files. The STMPE811 is
part of the SOM. It's self contained within it, therefore, disabling it
is not the correct default behavior.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi  | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index dffab5aa8b9c..23913f18586c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -664,7 +664,6 @@ stmpe_ts: stmpe_touchscreen {
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
-			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 9f33419c260b..9a9f9764dc65 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -588,7 +588,6 @@ stmpe_ts: stmpe_touchscreen {
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
-			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
-- 
2.43.0


