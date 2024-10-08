Return-Path: <linux-kernel+bounces-354967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA499454F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFEB2409C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF51C1AB8;
	Tue,  8 Oct 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tpq6IVS0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96332192B98
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383161; cv=none; b=P7jdjWrVt0VqsSC96+08dNw09BBv4bw2Amrz4foiibi1hJRoFA+PirkhV1rzCVjJ5KejYZr7p49OyWZQbgGMEp3v0vCgKRPNWKQUYPLZE4FCYXSC2v+r6YrMpbKNt+Eh+rQT+YX+PI4vZeUm4UwNcemfVHEy5Fj2C/nOh3kQheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383161; c=relaxed/simple;
	bh=cEOnqj5/taNdqs7wqZHJLE/H1nb6Cudd8JQkaXdwQeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjvCRfoh8gKq1zg9bUkJ6skrMWw9vBnKW9ocTnp4KofBSFv94VZqwigLo9uajpPLZ36JieZLBVUnvRtfXq/lDoXAAslFPIRU1WQ0ddx67a/iXUKQVelEbzW7v70dqAw3fkwuAweXxfDOIMsOF/1W4sbzfNfUyoaaY45sdSEymBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tpq6IVS0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso48623725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728383156; x=1728987956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI/4C1YBupkU8pa4hZnKaHzVnRWuBc+sLm07dr7BR90=;
        b=tpq6IVS0wIhafuOrNCF4p2NvI73pEyzZ46uQpy/r1QTW7qfutv6s0EVP+6ZvGUBP4+
         NuJBuYrDxoNO9AnZhXMsmyPB9CqMLUzcGjvIIsrucOp1uDSZqiLiop2Cq8Ot05+BK8WQ
         TDGnK4oa/T93fPw75778XANCmwr4l1U7U/2NpoLHcQToe/8udcXa4OnIyJmQwKCtSCmG
         Zv3PgXuWtO9rkSeHAlcL+ogEFB18tALTo+B4gubTwH4Zclb6o5r6lP9erKE6eExfHhju
         0w7PQaqF/Y9qaD/slI9jYhx4smOQc0bVJiIfI877qIqFSLMBHMIpa/sN0Vq2nVt5mu97
         MLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383156; x=1728987956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI/4C1YBupkU8pa4hZnKaHzVnRWuBc+sLm07dr7BR90=;
        b=uwpPIgqUH6ENuSsFSPkRRw+zJdEwPQzn4+V7EYLxdRyhrh6ODvp5ahHUiM/8vvaTsJ
         UUaEQDlJJZQYfQEpvIafadRGGMqi8YOjBnnsR0jyZfRsR0344g0ehDVB9ud01/z/GUab
         VOlKSb74AYZBdySZDQkgc49ugxLdDpKevsuWpbMVcyGAtp9PpjPJUiqB7GjA3qtUPkx1
         COe1n3yMG4hexjI1TCkNt3A+s4e6nbaAICoPo7K145FmeZOGPSaM0miQ9RlgfT0VlZxb
         aevZhv7MIIlZrCNeiaIYJCNiLCZCoPEvJkoCv1tgTQNnuV0AJR2dsoCAkghDBPZOO54V
         omFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8vAbSZDMwBuWj5mjcpCgy+xuvhi/9iO0B2cvIht5+PDowi0NAOYwI3uAbRhA751xbO4f7BOSY5Jg7cC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzdUxr+3SaiGlawdoyeo+RChAFZc3cPrScOudsShXMTzpRdmk
	oysxmFAdvvaM+lQ1moKEzIChEPhC0Yzpy30TZijrtybF+KGKkUeIJBOpC19khaw=
X-Google-Smtp-Source: AGHT+IFY6KPUaMK+qzf2Zm9ZWecXwxFv6eiu5QHuPmZPBeE7Q/AAZ0VjrtO0RZyy9X4qOeKZ00jCsw==
X-Received: by 2002:a05:600c:1d2a:b0:42c:a72a:e8f4 with SMTP id 5b1f17b1804b1-42f85ab645bmr118620325e9.14.1728383155751;
        Tue, 08 Oct 2024 03:25:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b505sm7766800f8f.43.2024.10.08.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:25:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 0/3] arm64: dts: qcom: sc8280xp: enable WLAN and Bluetooth
Date: Tue,  8 Oct 2024 12:25:41 +0200
Message-ID: <20241008102545.40003-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This correctly models the WLAN and Bluetooth modules on two boards using
the sc8280xp SoC. For the sc8280xp-crd we add the PMU, wifi and bluetooth
nodes with the correctly modelled wiring between them. For the X13s, we
rework existing nodes so that they align with the new DT bindings
contract.

v4 -> v5:
- put vreg_s10b under the "B" PMIC on the CRD instead of modeling it as a
  fixed regulator
- order pinctrl nodes alphabetically
- restore the drive-strength property for all pins to what bootfw sets it to
- disable bias on wlan-en pin on the CRD
- remove stray newline
- add the swctrl pins to the PMU node

v3 -> v4:
- bind bluetooth pins on X13s in patch 3/3
- only drop the regulator-always-on properties for vreg_s11b and vreg_s12b
  and fold this change into patch 3/3

v2 -> v3:
- move adding the bt-enable-gpios to the PMU on the CRD to patch 2/4
- add a patch removing the regulator-always-on property from regulators
  on X13s that no longer need it

v1 -> v2:
- fix commit message in patch 1/3
- drop drive-strength from the wlan enable pin function
- drop the calibration variant property from the wifi node of the CRD

Bartosz Golaszewski (3):
  arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855
  arm64: dts: qcom: sc8280xp-crd: enable bluetooth
  arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 167 ++++++++++++++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 101 +++++++++--
 2 files changed, 254 insertions(+), 14 deletions(-)

-- 
2.30.2


