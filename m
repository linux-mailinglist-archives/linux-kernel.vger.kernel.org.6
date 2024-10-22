Return-Path: <linux-kernel+bounces-375879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523C9A9C39
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AB3B22E43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBF16F85E;
	Tue, 22 Oct 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nYfqMRqc"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E428115E5D3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585182; cv=none; b=P6UIiFSEq+QV/4lzP889MuC1tE31TSuCzlyE6iTcVlvYTdK0kZobk1r1yzg0UyUso8wrNoqRJZS9XLp0+25P31Rzl/mDDy+uk4dfneRQVZEpEbYCoe7Lg4LOZmWjHBroDDRJSlR8B7SSgKO15Rw5rsk67oOGaVf0spzXjeG5VfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585182; c=relaxed/simple;
	bh=nDEq6xflV38Oys6mIGHJEcOdSrdQnYTmfgJUgN3pu2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D6Hgm0i7E6nFPL++qJugCnwhCppg7JB/Nf0Z20y50VcFP8xuN0+L4622F4aF8RRoqLY2Bh0f6CBGeiHc/3Sud1Jdnek5Xfa9YLjLUg+PLfi9DZE1CF2Cg58wEdJqg3jveJmJpui+NRCUSqYn+Z6fd85Stdv3VxMmZRTjcydDrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nYfqMRqc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so51627745e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729585178; x=1730189978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL7mVxMp+9R/aCr51mmHchZz4EvxpV8Oo1TSu+Ak7HI=;
        b=nYfqMRqcr8Yskxe8DXd8sKjQ/POixyZja21U/M3/b0/FNN4Bc63PoJjLwY9xs4v+EE
         UjhGwwiVlSLgNugY28fsLsYjy64+bU95FjhsgSk9P6SdOQQM1v3DlMYG/sraL2M+vUgb
         2b5mUJS6CVEhW14zZH96PLfh8kOzjGAaLb/SyF69S7E8CG0jHSRr9e9wXGdesX8B3Sna
         1wYPD81GI+lCNE83oaNmHOYW0yCZ5c2gv42qUJU2sBgV0/GhltyVpXPccggEBPaji+8v
         jN1JEPVbv96wfJO67N+P4TKioK4ruW+UHUWIg5pwi7UIU4sJpahUVZqQkGtqizHpPgos
         7VWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585178; x=1730189978;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL7mVxMp+9R/aCr51mmHchZz4EvxpV8Oo1TSu+Ak7HI=;
        b=v22vVCgvtvlJfaNyNS8Ud686z91CBHS2fxx9llpZw2HcxfLXH5ZLG/8Hv9eU0hjtMG
         zgTC7e+QNm0VWpesd+IOaShxZ2E8kJb3hEQbgQjm2a0AXGyrx6Rgr0N4aCbRWpAQLfqV
         RpW9Y20/h7K9+ImOD5ab5rA+3Fyg4jWNGCb+3mF4e4DI0xYK9hH6nxEt2lT8XQgtQ2Cn
         6NhYBDtjKMFnHajzMlEzmQhInjCimqcoXhSUxMA8Z7AtPeMbD2rLcZZ1gfwILpX5MWd3
         1WTCcRPcXT2GouoDJ+VnrUDyc8A6lcLcoykBIdD33/4MwyHZ/I47jiaOBrtfsnCwHBGV
         BmrA==
X-Forwarded-Encrypted: i=1; AJvYcCWA9kd5Re/zxGSfGIm10DyMHCW4IIxMo7AQC4SX614EEcwxwB5juI3jiK4197s56AoDzCv0wVhevNZCoaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbN3BU3z9vYO0TTWYaNB1QXbKEhQzPouDuf+CCvxjDxFgTfPH
	8n8dZG36QSNuiCVPShlRUvolUQmKJC7q/1i1g+lhLc/BDUFPxJz5k7zWxy3+gmQ=
X-Google-Smtp-Source: AGHT+IE5vRD2Vte+CM4kdc57GSfq9BMFWtI/WIUONZMXx/Kfa0SAtSqvVmqF0g9m0UTtA9qWK+DO7w==
X-Received: by 2002:a05:600c:4fcd:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-4317cb09538mr14288875e9.30.1729585178324;
        Tue, 22 Oct 2024 01:19:38 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ef1c:ae40:1300:20c6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a4b26dsm6074261f8f.45.2024.10.22.01.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 01:19:37 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241008-meson-clk-rst-aux-v2-1-682ab9151f4f@baylibre.com>
References: <20241008-meson-clk-rst-aux-v2-1-682ab9151f4f@baylibre.com>
Subject: Re: [PATCH v2] clk: amlogic: axg-audio: use the auxiliary reset
 driver
Message-Id: <172958517664.9195.129752834617236997.b4-ty@baylibre.com>
Date: Tue, 22 Oct 2024 10:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Applied to clk-meson (clk-meson-next), thanks!

[1/1] clk: amlogic: axg-audio: use the auxiliary reset driver
      (no commit info)

Best regards,
--
Jerome


