Return-Path: <linux-kernel+bounces-427396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF59E007C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE322831DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC8205E03;
	Mon,  2 Dec 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TRUClMXb"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90D1FDE11
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138361; cv=none; b=p8lbCGmkBQkl07xoxZO/ZRsVk8EgvODuSgCGFU+ejpVsPwYV7Ga5TVpu0OplFsXWeO2/LwlgQtep+/cqzly+vefpU5ySMnswCX/purBagopQY2vn1pQCjAZ1r/+qWS1j/es58Fejd5rbAsQ6BUJ5hOuoDshcUKwb5c5suMGOA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138361; c=relaxed/simple;
	bh=QMBFXNqBpFgYP2yitTOgzdsfZItshvzAST6FqjQRjNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq1Mgqg/g5T520U0vrUXygfHHsYEURkNcvDpaMNqgHhs0Ndpj/tl+YNTueSYMazSr/m0hZVU513lMBB+1k6vFv3fMiSt145swaayg70XDd1GBveVBOMZ5iSmfc+02W/vKyY3E+gFLdEYm9aEgQX8Kdw/jwpos4cBW5QYddCuIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TRUClMXb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso6610222a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733138355; x=1733743155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dNlxUlq/zQec54ENuov38IuayLoY+NtEDaFnmM1inQ=;
        b=TRUClMXbT/BkEMucbnwqj8OcamE/lxRppa4P432szv42fzZY4uemRAU6iOZ7lsvAc/
         fwPFwx1PMfCtYKXQ8kfySDfXiki98a6L7hP2mDvg6NYBTSK92eHCHTkM5/dxnsxhnDVh
         9czhw0Zfjc9gR7ITOO3D8PJRVXyqkCwRu6VBq3gKr4fkkTBa4pc7n1W7bWHGio2Gco/l
         4cnH37V3kw8znEEAlmF3wv2i8gTG06ijbVp8lk3WHkawjM7ibZTM3dLei6KNr/FlPGx5
         jlA7CO0nA7UDUIr87WQu1nuM5wSUEZQ828yYv958AZPjqFj8pdzljNItiO9x4OfVCUgK
         fHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733138355; x=1733743155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dNlxUlq/zQec54ENuov38IuayLoY+NtEDaFnmM1inQ=;
        b=HEh+f4fpTA0DWK/hyApcYM935UdYO56OgkAvnDhOhHgkpdQt7r8eVlwW4bQKiVLl3E
         jz4gm9dD75AJeCDBFPYOpE3pzTHkN/kDnGFfPuh48dgLWd5RTiaojCY2LJR6hnvnLs1J
         RMiwB1S+OOsH6gE6gDBbvkiowhXxLgO5eQPDwiXUrTTWcCtCEA/vC86HL0bDwTecxHPt
         PP/wxut9gzFahEUdaM5Rbc+FhOGobVbtzFzywpbgeLkYHJqCF9jOmgJQf8J5mvLnXdHX
         drW9y0cWarhpp2M2GUpwZJ8ERAXtw1RiNofOseWOolOqRj/qDl7ApbC11GCkbdG5MRmP
         WBBw==
X-Forwarded-Encrypted: i=1; AJvYcCVfBrWT0v7lg4bNI2UeowTdXJkSHLz3ZASlt8mI1qZbxw9ek28bt6pJHfvCqEcNUsoZOXJE2srPFbQI5w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7Tqszw0x8JFPvcubSFl2DYuXhlykXJAkQfghniuAOPOZN7YE
	8+zqweCVv53q2E6Y223utNW2GPVU1Gsj6nnZvuM2cH1wB/VopME2yM9tr0oXB9g=
X-Gm-Gg: ASbGncusboRJx6gKeRO8gOt4s9huX8jSRihuKrQ3RGv3ZnzTGvIdLrT1AwuH+QdnkAb
	k0si59LgcB9Eh77ktbBjBzK6ij1wHv3/xN2tY1/A+yUA2eVaSre6YOo9Tn6nrMyEfaELGdssOBS
	soNf+gtDy0faR2tmUcqDMevkMPk4QCYXwVD0zOUAMeo1O03FtLlzqwAuVzj7PPVqZ9QCQXOws22
	LJZfb6+QkGpk9K8A/mrBugRZDFBKgQl3lzfZ9PsiEOUOIqWWbDRqCQLEeDNySer+x6HvnM966Df
	rQ5agfomLhdE4tKmdBDC
X-Google-Smtp-Source: AGHT+IEh8VAXDJC3bTBBrwDpqq8+bh66QBF8HuQqB3DA5Y6Ne4IKysOOgMjNIKrVqzCRG1epx5t5JQ==
X-Received: by 2002:a05:6402:3484:b0:5d0:904f:710b with SMTP id 4fb4d7f45d1cf-5d0904f726amr20592659a12.34.1733138354832;
        Mon, 02 Dec 2024 03:19:14 -0800 (PST)
Received: from localhost (host-87-20-211-251.retail.telecomitalia.it. [87.20.211.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0d2f0652bsm2371980a12.25.2024.12.02.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:19:14 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 10/10] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Mon,  2 Dec 2024 12:19:34 +0100
Message-ID: <2dc27b08d82e5257a831026c963ac148d11cb6e8.1733136811.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1733136811.git.andrea.porta@suse.com>
References: <cover.1733136811.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..91b39026dc56 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -609,6 +609,7 @@ CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -690,6 +691,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1272,6 +1274,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


