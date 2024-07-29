Return-Path: <linux-kernel+bounces-266175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313093FC02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C37B225A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705115ECF9;
	Mon, 29 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zmPT911L"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1215DBC6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272595; cv=none; b=Mw62vYk0mEXOPxH5pa8gBe99gVsQtoupX4Jw4Yg+q2YJR2LI0nR/cN70Evl1ZWDrFNoAsuQxBaDTnIEL2+9r2rF7/phaq+Lls/e31g4BA0hwHdZj+DcGIh1XZEOsihySFjaooT/b0LOGyZN0kAo0bfwXQ0QATDThjGlw2Kzq2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272595; c=relaxed/simple;
	bh=UHVNvFrTrI5pqn9bcN//du/ZwIV/yuivfOCu8/p0nUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QP75BeB9S6RXLmeoYyp5XaQN+RbUeR2YhYlBX+kqPIB3RIsadCWr0v5ZaNobF1D6VsjrqM7G4k+0DNy0qHaherMlquL2WojdkClJT/PcEpp9VJf997kq86iIFcw0o3lA/E4fjjLwfMFtNy/JWxXEJ6KWhi/6+pAVEhds/xmkuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zmPT911L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42812945633so19296385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722272591; x=1722877391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY5TOx2hRF+eF5XgzHezi9Eadz0rgXiadgCBpJMGjfc=;
        b=zmPT911LMxADSPYsIsjEhWaLxBBnU2o7+PvVliShMRLcz+P7FKec8KNnPasQSQQwJA
         CGpqJsZZuUzx7DN15jkPKy/DzU6LVTvs81RWzNtUb4yYB3YxqpfjsnweWcUdXltrw+zs
         wDPfBHgSvttVbiA6quxcT/yBJdIr5APbBn5axLVJv6SG1YIrLbYAWiqtVJmB2hrBVNbH
         aQxS4qqR54AwrA0vmbYhF3eCpNkZT4RMNN1++iCGAROy9JFXDw8Wno+VmeFrExmILE+l
         rMy9Wrkz+dYdEWd/VS1LoDFKghq9853wW+Oavvdb+Kd67IEk1RsN0XF8kPJmptZ4sN5V
         fOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272591; x=1722877391;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY5TOx2hRF+eF5XgzHezi9Eadz0rgXiadgCBpJMGjfc=;
        b=ZVzr1d5mJq5mhc+U6wXWF/6L6IOO2BRsSq2y1ki4hWI6//RraKfm058a7twuQ50ZOF
         a6UUg3+z/FZ0ECXcTE4LIDllkcVkVmkEZsrrtjwWlfiVstWk55vNuXdMKhNSzOwGkqyL
         YkXcHCWdeXRlYxPUvJ3pA+ZoAzOIUqhE43IodyHUhFHgxiGTWNw0GqA/v4EMFVqFDxbD
         GeEnunkOyOphFPSWYd73hJCj0Pb7hZzsMcUk+W0eBuKdX09aKBY6VEYTV2+LdYnM77qh
         f9rl+ECRj3RaYxbMYyMg4SQfhzy7K0cPdj3z3SGI2u0NfNa0k6WuSI1lsGHOUyBE/ctm
         VNuw==
X-Gm-Message-State: AOJu0YxRN4UD9GTgZQchdMZHhIGQuUC64uRSKvPP3XLgICufDBYuMgP2
	DJxeM6WZbAAjbWCW4fzHHv34s5wVzCVtLqeaMcyM0qwRy4Wkeg/GXa+2l+lwKhBtj7M8cPFCZMD
	jHKE=
X-Google-Smtp-Source: AGHT+IGNPdzs0UIEPCwCmFyWraPBLzbyEZadx1Vll6KLs5CYVRk3p18pfByHR1j6BgOgSb7ZcteNXg==
X-Received: by 2002:a05:600c:154b:b0:428:1090:cfd4 with SMTP id 5b1f17b1804b1-42811df08a0mr56262375e9.33.1722272591104;
        Mon, 29 Jul 2024 10:03:11 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:abd3:cdc8:2363:54ef])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4281a26e1bcsm59809445e9.34.2024.07.29.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 10:03:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240719093934.3985139-1-jbrunet@baylibre.com>
References: <20240719093934.3985139-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: sm1: add earcrx clocks
Message-Id: <172227259008.348899.7822977439322261576.b4-ty@baylibre.com>
Date: Mon, 29 Jul 2024 19:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Applied to clk-meson (clk-meson-next), thanks!

[1/3] dt-bindings: clock: axg-audio: add earcrx clock ids
      https://github.com/BayLibre/clk-meson/commit/02672e609fa9
[2/3] clk: meson: axg-audio: setup regmap max_register based on the SoC
      https://github.com/BayLibre/clk-meson/commit/dd8ab39a8b41
[3/3] clk: meson: axg-audio: add sm1 earcrx clocks
      https://github.com/BayLibre/clk-meson/commit/4cb834703c64

Best regards,
--
Jerome


