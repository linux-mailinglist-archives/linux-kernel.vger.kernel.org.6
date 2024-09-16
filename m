Return-Path: <linux-kernel+bounces-330943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE597A650
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B301C21776
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C015C131;
	Mon, 16 Sep 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6XYr9Pl"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A680C0A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505911; cv=none; b=gPhqQ7C8ybyNZF5zhZMy5vEfLBn0gVq4/mMxbMRx23luKBMO/MHw+qDCXjMcNZFzE9DgLvapEArPIoNOQ00+NC4xPGqqjYecMCF3w/iMCjl8knEwc2SJoXHAnqaSNyTARQsJG2RMyb7nDSoMCYrCBEjWYwL/ErUVxN6jWNUOfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505911; c=relaxed/simple;
	bh=s6i/fzSPozPo95wcaQqCNYjDpPyZpQB4dqJyJ9WhGrI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OzH7Ncr3TT4Hk4Fc5/H2rBPN5h0nhlVZOtu1IDSzi2GsClgbHg/9jHvUR9qNgM3JzWrjtsI4xbyTbGh4UDJ0KeQ//ZTpRd15pRySGyAkRkypyQQL+fW6XoRZR/DxboVSLgz/NPVW7COLCp1T7obz0kbBTPhsvm8t7NuGTGGZeXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6XYr9Pl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so6071652a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726505908; x=1727110708; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80BvolWRqd+vCna2rvdnH0ppBYcL8z4URj2M0qkUhYY=;
        b=n6XYr9Pl0ECrNc2Upp/dfkDWAdMmj9WUOxGs+5YnNhFARRvTVrzvf1DGj9cAicv43g
         lWCdITfHdM4/CqxULBHlpUTCdIcyp3yYGhGUK1kAk6XxyDxo4D2FtsbAGQkwvd2PNWoL
         dd75Rtz/NS3+jW/KQWuRIJ23utscl5EwGOiumRlQN+snOK1FjLFZmWe/VnwwXq0csYc6
         5V9zenJWYKcdK6C106A2jsV6hxOTf42rmyHvQtonuHCBgwlZTCIFwzxy3X0dcSEPj1uR
         43svYl66t08jerwvB4za7i/ZYHXuf6KnlGHwKPXrLPyo/IWFF8VlHfapnTDDZaiApNIr
         HQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505908; x=1727110708;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80BvolWRqd+vCna2rvdnH0ppBYcL8z4URj2M0qkUhYY=;
        b=f3JN4Xp7FK5/vENYrDmDR0+H/yGXlF+vFVAK2/tJn4RXcSCIUVqNIUbEMSnIYEAYX5
         0goH2H0KkMIHtSn4YCbVGKeS6y0A+mf/evLbwJOYWVIuuIBOjifq4qOBfbJiqpNvZpWN
         +dHHxrwBHF2gJwkftFGp2M99zqtyWIMAnsEPyEp7Wttcg5G7Kr567t+JumTDihxxRIN+
         4u381eHtgX/5XAtuXkoxf0jyq4XDdegcA0HqyGvQhEY7N410YjU8mXhWBbMinCp7126f
         SGavWpD+Y8jSa8gutrWKjR+TN/bq15T3Dp7eYFJP/jXIoFhqiGH53tkGPn2G6EHjjYQK
         WDhw==
X-Forwarded-Encrypted: i=1; AJvYcCVr2SLFfHLRSTZHMjYJs/ztB/wZRQxQJgQ3yiFIj69Ee5/CqZHirf71z39PqDm4/nwWwPzK32kmX9OpHvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiVcmTVRDnG9nYNQMjnn33UTT7rfcdLQCZ0NjjUJkh69KtOXz
	SznIQAalyLS2LDNKxBd+UvN3PASQ/LfvR6G6jk2K24oIAA6d0mdmA/B08/k2A+k=
X-Google-Smtp-Source: AGHT+IF4ndpzFvHoUkc20adekDMu808u/yL3lssD9NKD3r/HJwjqBzQjqBvlnzv0kYnwmnQBQIJpgQ==
X-Received: by 2002:a17:907:2ce6:b0:a86:b46b:860a with SMTP id a640c23a62f3a-a90296775ddmr1482776066b.54.1726505907790;
        Mon, 16 Sep 2024 09:58:27 -0700 (PDT)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90979ceb67sm32992966b.219.2024.09.16.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:58:27 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] Google Pixel 6 (oriole): max20339 enabling
Date: Mon, 16 Sep 2024 17:58:25 +0100
Message-Id: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALFj6GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3dzECiMDY2NL3ZSSYt1kA1NDi2QLw6QkY0sloJaCotS0zAqwcdG
 xtbUA0r3MVl4AAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Hi,

These patches enable the Maxim MAX20339 overvoltage protector with load
switches for Google Pixel 6 (Oriole).

The driver and binding have been proposed as part of
https://lore.kernel.org/all/20240916-max20339-v1-0-b04ce8e8c471@linaro.org/

This is the first device behind the USB plug and can gate all incoming
power as well as protecting the input path from overvoltages.

Its load switches are used for wireless charging and for OTG.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      arm64: defconfig: enable Maxim max20339
      arm64: dts: exynos: gs101-oriole: enable max20339 OVP
      MAINTAINERS: add myself for Google Tensor SoC

 MAINTAINERS                                        |  1 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 51 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 3 files changed, 53 insertions(+)
---
base-commit: 7083504315d64199a329de322fce989e1e10f4f7
change-id: 20240916-max20339-dts-c0518c81bb39

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


