Return-Path: <linux-kernel+bounces-418121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738919D5D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF671F21B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9531D61A2;
	Fri, 22 Nov 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZY7EgGCi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E8B67F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272591; cv=none; b=pH37J50ODAJSnKO+KDLqUS/trG1Eet+6esJRbC56jnUOc5eyqUo3yFHX8k1qU4wT7/8hFaN1Ju0A4nNSGsglsQJ7yJlNQZuxdn7+XSGPEMchoVGKIDv0ZbKJB0DoEn5ONgwi9ea+XvE4GXiBjTw4osTczjO36pY1JgWbnkjhQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272591; c=relaxed/simple;
	bh=qjWqLrCVJW7yLRP9TOihAqD5vjNVfL16o5s5MqU/e0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8WZ+7LCONQ8M1Kr6Htdd+o7nrutGecZ5vmymWvUrHmlkraVlx8iCynQ/BHEkTACTVv6pU6mc2ETpnXyKl7jkeWvh8EBU/GaryXaJ7hxnRJSGl40B8pzpLmbWXyCmIOphcSVR/1NoPIb+kV3MiLFpAYFNDqKWR5eSEvdMPXMVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZY7EgGCi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa4d257eb68so372259966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732272588; x=1732877388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VCCZYEFyPvvi9pJLrfTrBaqaVLRyI5f0XR9dqSok6s=;
        b=ZY7EgGCisu5F6hOLhr1MH7dP/z0Sqbd9LC0aMBGGvmMPfZ4GFHy1E2z22iXsxFBhDX
         fxhgZfjsViJWnGBHUzPc1QG+QFNwYvP/7QqhjIcmgWQoJuO+RqAVNUh3wqmEtyjNpgSt
         5zRfLQk3YooDj9/tI/szbvcUIDBoMBw9X9gnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732272588; x=1732877388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VCCZYEFyPvvi9pJLrfTrBaqaVLRyI5f0XR9dqSok6s=;
        b=hWGbOwpPpTFNV31Nkn8rkzAV+y0dlsd11ZwusnH+AsBjq6lECNRN2DT8E0Z+BpiFYt
         V10SMwY6nfpYxGzhw1Iix54E/fIW7dAh9VKA6TL0zZ2efKn8HaEvwT/SLtaxLZsjchMx
         NtrRHAPgWXtWaqGdGM+1IpAg7C1vrtzj9yB5WSE9kGzInnP5LcNLcxP6P1m/x+kBNUkC
         yXIaQCCkzRqPETHhHPOrUaw7OmeA5Dnlp85cZvCvLhs847A+dHc8cP633uopEQwDldH9
         so9gtcl4BcYkgdAvtY62MDu/WdWASXLZow7tyCdT5/N2frNK8E1/BIjcCvc1bUokP+XU
         vp0g==
X-Forwarded-Encrypted: i=1; AJvYcCXWziWIdYB8vzVl3Hwm3dPKkaTxlm958RJBGXSdtaeMzC/SsIJ9djh+RXTLRVmEHe8RJCFb+XfbNo2pt/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2cOw75YPdUZRPHrWkyyKJP2jZRda9NV7UrkNda1rkSF97okr
	FvLwiAPhJzCiijvF/uqJNq8kpJKcspCVm5YgRr6DgkN5TsBu9GhdNp/ksyIaQg==
X-Gm-Gg: ASbGncsJFh6pRUcOW01qB2b/7y146CDOewmq1/eH7OtpTU8T2y9hJqyWjkPb9Ynp/1Q
	C87fI5RMgvQTvSuvwlI1Tp+1Ib9R60R4xSMyXOKZD0XHjofhc3ySYTzJ1t9wZVXx43nDAk/7XBo
	eLerEr3LbuP7r3ubv/7AcYxZLsJKG/w4OCsvqS8dIdHaqfbZHCuQVZeQsLTAyp4mWOKup0IIz6o
	BkcLzpwVqNOBD4XWVwUWywdw86rzM5Wzu5b8DhhgiJoYXIrcoI/1gf8TCk+tNth2YnTdaTQ7zff
	0ej75ywc
X-Google-Smtp-Source: AGHT+IEtqFLgN4QldlEpfUVybXqSI/MRA5+30+n/3WXfgfU0sDT9bCvRjWg4moxr2vE/+F91ZGikZQ==
X-Received: by 2002:a17:907:762f:b0:aa4:de84:3a23 with SMTP id a640c23a62f3a-aa509d09bb8mr253938966b.26.1732272587279;
        Fri, 22 Nov 2024 02:49:47 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa5175972f5sm55606966b.63.2024.11.22.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 02:49:46 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v1 0/2] Add Starmie Chromebooks 
Date: Fri, 22 Nov 2024 10:49:36 +0000
Message-ID: <20241122104938.1437925-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also
known as the ASUS Chromebook Enterprise CM30 Detachable (CM3001).
The device is a tablet style chromebook.

Wojciech Macek (2):
  dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
  arm64: dts: mediatek: mt8186: Add Starmie device

 .../devicetree/bindings/arm/mediatek.yaml     |   8 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8186-corsola-starmie-sku0.dts  |  29 ++
 .../mediatek/mt8186-corsola-starmie-sku1.dts  |  46 ++
 .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 480 ++++++++++++++++++
 5 files changed, 565 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/
     mt8186-corsola-starmie-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/
     mt8186-corsola-starmie-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/
     mt8186-corsola-starmie.dtsi

-- 
2.47.0.371.ga323438b13-goog


