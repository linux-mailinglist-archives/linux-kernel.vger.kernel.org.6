Return-Path: <linux-kernel+bounces-354000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1779935FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA61C23AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BE1C1AAA;
	Mon,  7 Oct 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcRkum99"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B461DC1AF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325384; cv=none; b=VZWVST+BLLt1x61VeXzYNlfPlqyw839f3SJm8eP1AF6szGgYcRAr4MdE2neV821ibTZ6+p30GoS5Kl/LdGyXHgHX4TyTN3d8PJLjiNf2fS+XfysYuIlMFOcFsTZCiAnpX8mJXbRFAdvmODfJ7S6EH3TgujxGC0h8YrP4YXrREmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325384; c=relaxed/simple;
	bh=jD98uaOVQPh5YnYxVipjs5I1jUj2Lcty9HE63JRpATI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nHcpE5o4jQgS0253txkXm6RykFcc3IQ1puOH3D7s41mUS9sFV06NZFmx/2VFSurisJb8zNj7Xyk5HgZKo+Zaes/PJRltPhyVecxqtgBccAR8KgWpUAkxKr6fjFxHrQToeHmxsDbVutH+a7jEgZ8ANRBEtC/7KdqM6sjpmBc5P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcRkum99; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a994277b38bso179284666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728325381; x=1728930181; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=It1tAyMa3+6DqFnmaw7FuZdO601D4t1L+GiQKvslZaM=;
        b=IcRkum99ZHb6ibVpx5AcyPQgE1drWiw+NGY2YfQsfVxFVI41Mjgy12P6zfGke0nxie
         fLKonWFRTt/5d9Q0ZzLuIzlGg+LfJ4xbgH2/OAVBmeShlnvM5J1oqyRAvCytNOfWPpk6
         b2+zERxvZ3GBBh4M5kPUGXUAnWsAQZhjors569ofsUCcKm32BtEStdej2kHtFbJ9yvbW
         85rKe1GEFmeqJlEnDrjSgOgW+yCE4p9k4MO8CdKDdhGn4lCwxjSt4xp3hlCX2TkwdezM
         Xec/7Yn/ac+7Uw7nZwxrGPRMo6Ikd7HiZrD6SIprhgT8IRSpQ4FfpKjrkl1qVoGJPIoM
         vXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325381; x=1728930181;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=It1tAyMa3+6DqFnmaw7FuZdO601D4t1L+GiQKvslZaM=;
        b=QgI1GUuRHt5RJy0k3FnP/ZrQUuqF53jCt2TOUNq3Y+E4O2qYuURdXuu4QYQ8BV6Pb6
         NzaSnSOuC6Ry5PI1MUUvpwRTvebqjONJwdeHHaD4Y1MDXp96Hc6p1QF8krDgiYxSgpIA
         ZA7qpMV7N/yx/S5+c/yMKXjoYSycIYkhUaVa0fw+JVrhyytrn/113GsUhEPRBhBGh2uW
         pj0sH1JdAtArp85K8VxEGKWe5sGBde5o7+UoMUBzeZZqttR4slvz9smNRPDusf/z+yju
         7TNt+HDV7GWyXEXOofepJ3uLUQNHXBV728iUktZuFi1RGmcTB+1AKwBAf0Hpt+SxgMXq
         fseA==
X-Forwarded-Encrypted: i=1; AJvYcCWizUyy0UM0euxDnnXX8YempKLYJfvuL3UWr4vyv9xTsYhAPEXpx7kuyrCUtENd8K87pWUtw1bwYvivmho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIKhOu2c8OBdZ7z9+Wyyg5Q+uwuH0GT6l0zFHPPmXLtGDdanh
	Qj8WJkk22U5tQ6oxkJIDDLL1wZKrBV16JIEnXeJ/96tIroZbalYtW6LN+gk3PVU=
X-Google-Smtp-Source: AGHT+IHxW0LZn3oH8CLuuI6D2GfiUaA0AGWg171+2Cpznanu6FP4rPLbEUSXqMhUlfUyROR7Id5s8g==
X-Received: by 2002:a05:6402:3513:b0:5c8:bb09:af83 with SMTP id 4fb4d7f45d1cf-5c8d2eb773amr18031965a12.31.1728325381309;
        Mon, 07 Oct 2024 11:23:01 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:4109:b8c2:873b:4a28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3452963a12.59.2024.10.07.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:23:01 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq
Date: Mon, 07 Oct 2024 20:22:24 +0200
Message-Id: <20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOEmBGcC/x2Myw5AMBAAf0X2bJNt61F+RRyoxV6oNkEi/l3jN
 nOYeSByEI7QZg8EPiXKviVReQZuHbaFUabkoEkXiqjGW7GlROivEPnAw3nU42wb6yoypYFU+sC
 z3P+169/3A+GGP/JlAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.13.0

Enable WCN7850 WiFi/BT on X1E80100 QCP using the new power sequencing DT
bindings.

The first two patches add missing power domains and the definition for the
UART14 instance on X1E80100 (typically used for Bluetooth). The third patch
adds the regulators, PMU, WiFi and BT nodes to the QCP device tree.

The same setup also works for CRD and likely most of the other X1E80100
laptops. However, unlike the QCP they use soldered or removable M.2 cards.
Describing this properly requires new bindings, I'm planning to propose a
solution for this in a future series.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (3):
      arm64: dts: qcom: x1e80100: Add QUP power domains and OPPs
      arm64: dts: qcom: x1e80100: Add uart14
      arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq

 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 144 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 231 ++++++++++++++++++++++++++++++
 2 files changed, 375 insertions(+)
---
base-commit: 7b780f717d1f162620dda6f6a3b5039d67e1e3e3
change-id: 20241007-x1e80100-pwrseq-qcp-2bf898c60353

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


