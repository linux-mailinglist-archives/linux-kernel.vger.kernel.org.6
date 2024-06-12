Return-Path: <linux-kernel+bounces-211072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE7904CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E391C2407A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D216D331;
	Wed, 12 Jun 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eNd5Ceix"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E816C6BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177103; cv=none; b=fnd1wO/hQvW05O4tIky1us9ua2903PjadP12Z71HqKy0PoU1HKc5ZDLqVuWI3O4LbiHQJY9r1hpi+OIV70sS3L25rFxfuOHlJ033tyeopNnllRDiCjFv9Ya7NynBIbiKd28oCNv0tlBUstTdSIRCAq58HdHBcWNG/+HNfs+96l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177103; c=relaxed/simple;
	bh=GV8vhLk5W+15Fu37cvfJGGkkE6AbEn/05xw+plQAHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxHJ2CDfghp1HuJ+cCIwSaG/DnJxUSUwhQCM/asB4leyXr+2t3wZWbd3RPDYSiq3LTjR0NhV8IO+v//BDsCFLSmPNdjNT6FC/MWwwf/M/mbe0mv4Nd4oYHztQLydw2gnHE3Doum+EFCBh5FoSOb/Q7CqtLrZhuQKd+HLockUHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eNd5Ceix; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35f1c490c13so4028211f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718177100; x=1718781900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZZ648vF2hGd45hekWosmU80qN8L5wlOVqhbijLkjGE=;
        b=eNd5Ceixs5u/g3v6ODZjFyxjAEDPzadGTSf/6GUQL7AfM8wJycLhpqO50pAS875tqF
         pg+mNBSeEF7bXrFHJo9gihBclpdBSOEVmvXZIOw+od0s+EhKU7y+XEdx8FQsmCZL/V9a
         LeEY2OVP4QZOeFICVlJxoNQ61YWf5BHY63T+p624Daf1A8qank+N2v3o0rZSAykbW9W5
         +vylme+bJks+NgvEyucWZ7G8dgWY3kT7Q4sJWubMgbPALPNtJsFcGzKYrP82VtCdiQs7
         nh6saJxbGvhw+xi0l05gHc3uU/GxIAy12BRCGYvNigqyXA9PnY/DtWXlj0c4QURYFkpB
         C6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177100; x=1718781900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZZ648vF2hGd45hekWosmU80qN8L5wlOVqhbijLkjGE=;
        b=f5tfiABCLLcNcu3lvmZ3pKsu7KFbbnf+oRfqEC5ZxKl5cmI4nTSch6wfTAOunsk0Ow
         K7iEcq8zYGUGTnNAFLj+tr5yQLxSaLyJdumutpkvPcRjMoGDwS6dFlX6tfoFvk3Fmsj7
         +tcUlj8mF7rYr42mWPfeB9lSlHYRFg3Znwr+mdmU60f0tUwVaxrO8KRrBZkjD3GKaKrm
         0GbdGrfHB0I00Lrcs8/HpepINHZ/bd/rstBqBy7TZWaSifaDFloeYeGPhuVnDOfd/3Z1
         syn7lykVtiRQ5bNUauk0C/lMFMgshfZbIwK6Bc9AdMxbpKNVCNvjx72nG7I1zI6wcUHu
         QiPw==
X-Forwarded-Encrypted: i=1; AJvYcCVCHpqZszXMicZ2CB2PQfUVycs3HMFYoqKVS21GodqyKZhWNIv9w0yj9UxOVc/f7uk+EQ2oAd1dfZ6RfGcFpihpZ4DLmle+wR9zP0K5
X-Gm-Message-State: AOJu0YxnPNLxcATv0bZEH//e0lSpj2pLK/ZRRedXCHBv0iP1M4Qu7Edc
	vR1UouIxS6vIV4soTQu2aunrjDdSK8CV96zf2NJXRV4NbAFa4COySaWQGHwl0Mc=
X-Google-Smtp-Source: AGHT+IHzJQZOo7VhfwHUIA0Rvt2UNlF28rgiuiNCV0gXUegLqiznXfYjxQF2KbE4ePZs0+9rQ3O3JQ==
X-Received: by 2002:adf:e6c1:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35fdf7adcd2mr650626f8f.25.1718177100076;
        Wed, 12 Jun 2024 00:25:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0f551c20sm11692172f8f.69.2024.06.12.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:24:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
Date: Wed, 12 Jun 2024 09:24:56 +0200
Message-ID: <171817709104.16429.1270997690165832044.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605123850.24857-1-brgl@bgdev.pl>
References: <20240605123850.24857-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Jun 2024 14:38:48 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hi!
> 
> These are the power sequencing patches sent separately after some
> improvements suggested by Bjorn Helgaas. I intend to pick them up into a
> new branch and maintain the subsystem from now on. I then plan to
> provide an immutable tag to the Bluetooth and PCI subsystems so that the
> rest of the C changes can be applied. This new branch will then be
> directly sent to Linus Torvalds for the next merge window.
> 
> [...]

Applied, thanks!

[1/2] power: sequencing: implement the pwrseq core
      commit: 249ebf3f65f8530beb2cbfb91bff1d83ba88d23c
[2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
      commit: 2f1630f437dff20d02e4b3f07e836f42869128dd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

