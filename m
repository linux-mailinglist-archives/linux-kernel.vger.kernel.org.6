Return-Path: <linux-kernel+bounces-389631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9BF9B6F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D71F26535
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB221F4AB;
	Wed, 30 Oct 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QJCFMNv3"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEC21B438
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324063; cv=none; b=gd92spyOhpPjwHq+/6eshAloi6ReO9m3+tDXrx6NvQXutq4jAqdt/y5Q6xfaek/SFbJf01CMOa+S22pR5WcXZIwmcScVn3wqa4zJa1V4kmWiv83Dh0ZicD2RDneh8rsHKlsWtEQSUV6XCLDvbi1GT5gcO+xr4GAru5gCFeNGih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324063; c=relaxed/simple;
	bh=cfEZglRfXM92Rs9VKa/QxGF7CCG/G8uo3RqbR+JtOMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXx1/1mftxV2VF+2GdLgzKbQkunm03bbof2zSZf1FxBWqTZiVA2m89gLJcJx0HldiPf6Xyf1tgl1iiyJxX2OU2SaXXwdf0p6L8Cal2zHZDXSB9I9um5c3Q/Z6EAOzkQdKLa9XmO2z5x7sWLjYRM0N4PeYdkNL1ykcbuINGNQFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QJCFMNv3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso216738a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730324061; x=1730928861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57fEAwok3+kDJ02oPopU87vkGpDlety/NkYvCBCJnWo=;
        b=QJCFMNv3e6krGhwq382HjR23u1liVL+u2cUJoX9WgQxOoKk3oUx2+NmhNxxKdjlF+P
         CXlPyCV14Rm49MUTaUfK0bzGcU+m0B75KE78Pecvl/1EHb8SCeioR1L7DvrtK1akGjkM
         rju8vjrEsKK8omNvWLGwWlaxnplOy07WdmY8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324061; x=1730928861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57fEAwok3+kDJ02oPopU87vkGpDlety/NkYvCBCJnWo=;
        b=l/oslYPoqul+N5g2S/J/NLG71uaAagfiWPUKLSCYfJYOLMOzBSIT6L+dULOf79Sb6I
         ZjFAwmtX/731ozhvDNM49z5KGveajuKL2W84gD/jc6v1Qd1pGEBT4DDEvAKfAU4sfb3s
         RUDDFBfcZWIEIo/R7py69uIavopgoy4amiNTgrlGkEfvulM0CIVOkcI4uBYvuKEsPDBz
         mLObMtwqgO7c1si23/9auyflgwopEEg3wPoiZOW3PHFi6Hvg4N8lOPzEBQJZ7XLDrpsT
         g2uUbGrRvAcY4LMYwtP3BdiKYEULwUS1E6VatpsCvlTKS8azXUIhcU/M5DuPLlSBVdya
         pwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZdaJoTXIbu1uGWaR1BRnZz7QQ5FyGkUTnZCVwAoJBWdg2Hxa10dWhMwJvR0RFfUuM5EkL+Y2CDN5M+c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTOabb02odv3kR7i2KHuwvUmZJS0RE7JtbZgUFtpniF9MRRCD
	heeHG+9Ix8IJdjnFBTr79LjOMmo0Hz96Uv/MOL/F/g3Z6eVJAqFN454OXrxzSQ==
X-Google-Smtp-Source: AGHT+IFB0HWyN1/DBBH21gB+sB5G4OUo/anMiUMkhzLTxGINvoKiV41KlsMj+eULdwz0SKgQKoCYKg==
X-Received: by 2002:a17:90a:8a05:b0:2e5:5e95:b389 with SMTP id 98e67ed59e1d1-2e8f11baca9mr17595045a91.35.1730324060684;
        Wed, 30 Oct 2024 14:34:20 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa5f70fsm2372458a91.33.2024.10.30.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:34:20 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id 4222A886; Wed, 30 Oct 2024 14:34:19 -0700 (PDT)
From: Markus Mayer <mmayer@broadcom.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Device Tree Mailing List <devicetree@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] hwrng: bcm74110 - Add Broadcom BCM74110 RNG driver
Date: Wed, 30 Oct 2024 14:33:53 -0700
Message-ID: <20241030213400.802264-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the random number generator found on the
BCM74110 SoC.

Markus Mayer (2):
  dt-bindings: rng: add binding for BCM74110 RNG
  hwrng: bcm74110 - Add Broadcom BCM74110 RNG driver

 .../bindings/rng/brcm,bcm74110.yaml           |  35 +++++
 drivers/char/hw_random/Kconfig                |  14 ++
 drivers/char/hw_random/Makefile               |   1 +
 drivers/char/hw_random/bcm74110-rng.c         | 125 ++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm74110.yaml
 create mode 100644 drivers/char/hw_random/bcm74110-rng.c

-- 
2.46.0


