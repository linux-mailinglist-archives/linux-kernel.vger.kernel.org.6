Return-Path: <linux-kernel+bounces-524094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF23A3DF26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1719C4289
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5F205E1A;
	Thu, 20 Feb 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2Gis8g8"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7511FF1DF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066268; cv=none; b=gLgx/09vvYncdy6zR//ZBH2nwyLigKjGx5wiJ/A1T83WBBzXJcT3E+pB87vKWkKVtNO5/AaMJuBDqinD9Njh/60ZZxICLhAuCttZD8eKDeaZQ26GzvzCWRo8sF1jcofUw5Gd56rKSCwdfoAgP+F/a9Em/UwbX4863TrOvIf1xRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066268; c=relaxed/simple;
	bh=xXwxaxmXw6dtlHtt1xU1KzXtl6N7ESURTUVxo9ULsn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtZ1uFuRp8fxxlrgHY69A7z5WTukoDe8M4b/b1Aew7XLwWJBF0b8olILAbdAHaFPlwbdHUSwh5z9yPT7i+LGahijtjthqxEFnaT9ijQdfPF+aPLC+Bys3Vly0Iap6Iw7eaf96pw1VQIVrUQLBx+0p7+bJ3R2Md//6xStqWyHauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2Gis8g8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so191823a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066265; x=1740671065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9YxMyeqS75qps1bWVWBJrujRRaxGFobz2rjhz2WSpk=;
        b=c2Gis8g8+aQTwQqQpJ9kCKKeE8qb6BlfEPYQr9xdQt+AopIbSdT5X9ZhzCjeHlj87a
         OqosQSQC653oXwNwVsJ3C9pGs4X0qywIhdfoDJcOguob5MLtLAnY2CRPWKR0psPQ1EwU
         mD0WmwAtMr2ISTzOnWEHvq7wBuNAWCs8Xz16oF27rvrQqgCAZK/CIQ9gUFe7NS+3O/Fi
         ipkKpFZ0bnBHJXjFg0AFMEScAUzBZdZ2P7Dh56bu7k/6p+DB5Ks+8qm26Tm7JIN1lvf+
         xmW6vH1gI02TVWUj49/H2yUmi1yhhnhXQHI9c3GOveiLU07B17cwgM9dIAQ9JChBc08O
         O3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066265; x=1740671065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9YxMyeqS75qps1bWVWBJrujRRaxGFobz2rjhz2WSpk=;
        b=TO+WHpac9XOg5k/PqtVPXPa+kxFUcUve1SDijY6EweCXd6izhfioBVKoDD1DaLy39R
         JwzpX/wlxsZkqbsKy6b7DwwzkZtU4gES8Z2YPp+OvxNz/HMsK0tSw9vrCAq6x2uwqny0
         qZmN9hP/XKEjCq+b0RXH/rlJI3buVcLTPwFHMjGyl82kOpb4aGxjcRA/GB/BLsUogCPz
         /aueDj53GIpX61CEKKc1ptHcFGCOLsY6kwZe+Gq24Je9atyEtpuMsJilVvajXM6uMnbx
         aJhj9heUc0zX+1hiSWsrVoXA61imC5pTWfdEQdwSan1GjCQdmHj/AmpsVgJTxhYfRB8n
         LX1g==
X-Forwarded-Encrypted: i=1; AJvYcCXFh+7CI21FxQaMY4DL+0HtbuMgVc4/p107PN8HUVNbnShWYAqpltz5xC6vBit0VC+TWf6WG9DNRERS3gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8cosi4UipR4OigmIIKtwGKuyMww83B2i3tOUwq87Qx/k8nr2
	A8xHU+Y2dO/4MBfKFqgbaJqWRQ6mttGJ7QNLtdTASj5rzTu7lefY87qxpjEQPvo=
X-Gm-Gg: ASbGncvC68GPWup36CqWBBB4N/lo804KVtsvjjc2nFOU0EuDDbInxoNk0cLvlsRRV3y
	nhEeVaqPhNkinrY5rXn5Nk2deGxo6Fz203QJYGWpwmkMsZeRZLakaMYJke5HW4h0NF1RHT6sbHF
	0MWcbfAJp1MldSCyUBrPMNX7Qn9zpiPl0ItR8fkih/9COPH97b+eHKiCTPGMlf687td4LTj8Ux5
	wD7+bZ4WDEVMmPuNHtgZVeEJ5H808j18dSEkjYIPfIG03ff9cVVaXSWvP597c3z7KuvWud6wAiv
	FQl/7Ym/ClVlt6Gy6nS0QsciyxA3gmxYZE5D6UFp6nP+/TYn/YFrAc4DucB3jl/Jyg==
X-Google-Smtp-Source: AGHT+IGp9uWA9SJhJT1pMW6ZaLZrmUYsKIL+Ttgvf6XHbn/btTPcRom0q5jvcQHdvteh1m1ccO4lMQ==
X-Received: by 2002:a05:6402:27c6:b0:5e0:a4ae:d486 with SMTP id 4fb4d7f45d1cf-5e0a4aed697mr1005792a12.7.1740066265519;
        Thu, 20 Feb 2025 07:44:25 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2881b3sm12418151a12.77.2025.02.20.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:44:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Feb 2025 16:44:13 +0100
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable CDSP and
 mention MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-b4-sm8750-cdsp-v2-3-a70dd2d04419@linaro.org>
References: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
In-Reply-To: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xXwxaxmXw6dtlHtt1xU1KzXtl6N7ESURTUVxo9ULsn8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnt03SupJAdaw4lGIG+K4TJuyxEvfAioKJ5IilP
 TbGVV1EGueJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7dN0gAKCRDBN2bmhouD
 13nGD/0WEbjNWwvuBh+ForoxRSibgKkNv4ljH6ngtU2dYg/UO6oV7vKRZCIc+bZA3SNt2d1s0kN
 oPS2Tm7dvZCP9RH/P71MYIKYdWHdKenvU/GveVh1L2Iryg7HT3z6kYLf/E5AYvqg2M5w2vA/fMd
 eKZMf6dnXaRuawXxzUpfS5oXQ9xKK/DzRePYIUhIDC6pQwq1wfTbRjxeFUWuO//GHYklzL5fgHR
 vztPMJAQoRj2a3PBmhJ2WJu73gWwNJKzFU9iqv/5p6khUj8d3nmAQ9CHQDP2bCvF8TlvOH1G0kF
 0lqCpDr9T4zjf7SNJGz54/aERVWVZ6HTnTGuG2ygcMPit/V976sPpfBaZzhwzJPSHEDXgs2KhPQ
 sZl6Ne4bPYWZcrw0VssnjDNElLnJxBcYqdY3mE2w5Xn2fqTo61UtUWRlTqlxTavF3wuZtWFmeH2
 uqYG8e8RLDtQhQXCXd7fhiO7zEW7yb0rcBT0m/ypfyEdrf3YRfRL6E0Qlkda4fjQD83dagxv0vf
 vn+LW71QKFrhaPiE3R/gUc9FnB2WwQH1pKSxFtAs2QqdyvW1G2KaPgKp7ReMWOd8jjzcFyF4OVc
 n0ZVoHuxiVuHSj70V3QNhkDX0XiE8lbm7fLn/T+glDYlySNbRsLYYey4F0EQcSU3MeoBcZLwrAZ
 QEXG3Oyi/E4fHKQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable the CDSP on MPT8750 board and add firmware for the modem, however
keep it as failed because modem crashes after booting for unknown
reasons.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 8eeed7f2f7766326cfc7830002768087e9783b9b..72f081a890dfe49bfbee5e91b9e51da53b9d8baf 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -791,6 +791,21 @@ &remoteproc_adsp {
 	status = "okay";
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8750/cdsp.mbn",
+			"qcom/sm8750/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8750/modem.mbn",
+			"qcom/sm8750/modem_dtb.mbn";
+
+	/* Modem crashes after some time with "DOG detects stalled initialization" */
+	status = "fail";
+};
+
 &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;

-- 
2.43.0


