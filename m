Return-Path: <linux-kernel+bounces-318996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1F96F654
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4231F2393C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A931CFEDE;
	Fri,  6 Sep 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLfHG5fR"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53361D014A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631747; cv=none; b=SKtSQp+Ds+WmJ5GWnW39G46k7oLkvErz2Eo1pfnlUWIyVSxPDXVTYQicvXSLecsFIyyb5XMDp4DGXOY1NZGM/pn8ObijHsv0fPh30Z5WwmNNkn4825B4FLby9Fg18CCr+uCli9++lxfy/Fn9W9MHRVNQDfyZPYP8jlftoYqk34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631747; c=relaxed/simple;
	bh=2nxzFzHhhX/ZPx75VxE8RZenfT19/X5QvX+L3IufulM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxuQgJ6DHJeCGyF6wEsoyYJCu8dMryBh11ni/POWJiYUeYascOynKyJDTlgtR/oCv0R3hFT6YT7Hc8F8pWO07rbApztEsvQzFcklLQ/sg7Tsa3tT4rgeiKN3br2/w+Z7vvToJPMFWOps77KRIgCq6BKj27q5mkVwGBCb70VOpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLfHG5fR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f922ad1eso2251951fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725631744; x=1726236544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7z81VoupqldHvJZcn537NLL4ciTBDcA6n/Wx7M861xs=;
        b=hLfHG5fR5awBcSCQEBQQZe6BUTBBzT9Q8+j0h2ousAD7MwAXNZ5fYRCqlZ73R20SCI
         D68P3JRwbyPRto6Ne9zjfTxcbEb1F4Q8Ae7AoS8PvqYjIbY8iiN1z557RkLJnQwNeDL9
         bdPx0kLQM4CzQrMDo28s1Ts2nathoWbaM0wDNwsNbJo60R5nFIkiE2BSISUbErBTk2cy
         Ux2NCwF3yOKPAq0h6ZT1EVsx7V8EUmtDaTYciF/Y7NMxq+Dd5isvIxteBrjhigTld3qR
         ufz13BAt4fINgqYjdHb4lLBLYSKilDUWPcK17i/HNvUqmzsXXCDspiKumctVPNeX1/9z
         sXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631744; x=1726236544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z81VoupqldHvJZcn537NLL4ciTBDcA6n/Wx7M861xs=;
        b=Vdi3eQZgVzPsIvohsOaiDj8rR8dd3NfDiPGQ417B0jJz6UXDEUFLssoW4BRqf0JfyR
         wNgryhFkQDvNmptBy+ub0XDac2/rGg9wOM2Dx+aDoJW7fBjAiiJwGHLm4El/jTMw4scY
         iXT+U8hw4tqEBh1+hUWEZXWT6539w0dmAuVBNeu3Mpr2f2b2KmX1DM0OKxG4FNEIjXue
         T7o44/6Kz8R62uVprcIa1Wxiilcz6L7nQrA4TDDNRRnBFQ1BQNSNYMaSA6a+VbeR25kb
         UIXNJu4SUiCE4ylqPnpoQBxN6mSZd4AESwiayfAb6oergUpsMfdi46vn+TW8/rdZtgrB
         28vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4xDJds+aH0W9FGMcojQ7zgMB2fardaAKU7fZW/P+XRMuBFZx/8eb2X34ksHn/GyE8I5nHhiMoUjrHPb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFkHXkfcVOee849eEtKbm8Er9jRgE1Zlixd2isDwA/Ms57Rlue
	mdCYl/nbEoDGcVtKeJwH5TfTA+jbfYzF1X3gsBmIz1JRIMQEn24ZsQ8//zBBnEo=
X-Google-Smtp-Source: AGHT+IH3iaL4oS2mUwzJ9AE1R1DnGu0Rom4pkohNdiiLxWCsFN7TeNMR1ZB+QFbicEFDqoIRA6zGFA==
X-Received: by 2002:a05:651c:541:b0:2ef:27fa:1fc4 with SMTP id 38308e7fff4ca-2f751ea5828mr11150271fa.1.1725631742884;
        Fri, 06 Sep 2024 07:09:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789160d5e3sm14305f8f.40.2024.09.06.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:09:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.12, part two
Date: Fri,  6 Sep 2024 16:08:58 +0200
Message-ID: <20240906140859.71712-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Second pull request, on top of previous one.

Best regards,
Krzysztof


The following changes since commit ff390189b7f2cfa20c644bc58b4462b5e2621838:

  memory: mtk-smi: Use devm_clk_get_enabled() (2024-08-25 11:02:17 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.12-2

for you to fetch changes up to 32960b4f25c248f13758b8bbe6cc4260828442a1:

  memory: pl353-smc: simplify with scoped for each OF child loop (2024-08-31 07:44:24 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.12, part two

1. Renesas RPC-IF: adjust default setting for pins to accommodate
   different flash devices, which should fix 4-bit flash writes with
   Renesas AT25QL128A flash.

2. Simplify a bit probe() in PL172 and PL353-SMC.

----------------------------------------------------------------
Biju Das (1):
      memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF pins

Krzysztof Kozlowski (2):
      memory: pl172: simplify releasing AMBA regions with devm
      memory: pl353-smc: simplify with scoped for each OF child loop

 drivers/memory/pl172.c          | 28 +++++++++++++---------------
 drivers/memory/pl353-smc.c      |  7 ++-----
 drivers/memory/renesas-rpc-if.c |  2 +-
 3 files changed, 16 insertions(+), 21 deletions(-)

