Return-Path: <linux-kernel+bounces-314363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60496B24C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BB81C20992
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6395145B07;
	Wed,  4 Sep 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oJQYeB/Q"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4171DDE9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433398; cv=none; b=jYefsb8rCOt/R9hY32db9S5GkBHu0XzA/wqK1wCL6kKAdqx7aqGdc1vt+rUeTY1wAl1hGDvfKiLFamHk98Y5nwNxB4ip3zlaR5MQZ6G0R9cKOEIK+3fohrnT0RfLTdJ5EvNfBNbIFhtwCMTm9e6BLRDGe8zEtjYh+eD4173T+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433398; c=relaxed/simple;
	bh=vYekh47a7+HGN8/imrmZjP46snfrGps/4ZzgzRPtpV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7DyR2AVRMt6caZ/nw3RRPn2y1CG+o4mtutKntAf4r4QAPIjI1LU1I9pAUBQ2uVYiZBCTYT8dowgW386GtC39QaDIpqLKRrOBU8BQw6gBatLh7lITHOkiSIxgplIxdfqDMeS11iX16/euEsiZpJqSEAXdwbZotoaakWDMWTHwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oJQYeB/Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so39552675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725433394; x=1726038194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9n0f996CYWxF2hU1UAD7Xtq+hNoe2T44xauGeIVn3w=;
        b=oJQYeB/Qj9OkzLwpQVWNduQ1XDOFtsM2CeSnUVC06S8G74Tzls8mkaj1dsbwf5lqkE
         34ADTbBgpdqyHcgdVZ1ow8QmrNFPnl84Gzryb/y5L28ttybwQVzCC7PcXmP4vUbrdzdN
         hEHaPtm4zYWPtHCH6fDCFiNv5eXnwfr9SUl0zEJuGyYShhPNkooQ2Zua41ptl3bVvkgf
         F0QxGT/8k94BxYND1EtmK0pkXcOaLbj3C9AQMt56pTb95Oi0JbTrRoVjkMx0+jfwJuJ3
         mT69z6FFcO8I/USAhQDAwJMLNO/I3SRpQA9ki7X9qS52LqlDZZFGoAQsyALBI4zyRS6t
         g6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433394; x=1726038194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9n0f996CYWxF2hU1UAD7Xtq+hNoe2T44xauGeIVn3w=;
        b=Wtn9BS+d46LXCTO8Gd4/ekzlAZnek4Jku/7UBtSb9a7LRLBGh/ktcwNy/KqIVBdA34
         lKjMyPzuTncyk2Wi7QGdJYs6o90pzttpmrkRqOkhdONCDRqHFzBQZR7+8Tdi761vcerC
         Vd7tl2FK3E/OssvqTtii9WF5utMLHwPt56k9wja/oQZuQUiMXQDauHzG9/x4G371Chdx
         6p37BbCPt+OIxMHB5o5BlKeeLvWxvZC26TkYScW96YU98BwaJ8+qCBgbaiT26hN0sK77
         ERvsST4/nb0JhQ89AMUE4HisWYSFsjupzXAjJKWV4KMlvg0Ik+qe7nA0pio4r+J7OBpq
         E+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUK6gr7nuQ5Cl3cCSj9mUTM90FdKAadlTU1/igQ8BHO+gs5pdzkf8BdZwNAZ8CVg5R6g728p4BLpG3rGCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpIjntreGxZSVZDtOcxxv/DJQxe0J5HG8QUf883XUejx/AxC7
	BzKMoF+ZBpTsob+/0wJt82K/SQIcF1MvIrADg2q+Xg9uCFxL+V2kxp9J34VcLGU=
X-Google-Smtp-Source: AGHT+IHEu3uWPSRLlF3gGCsHC8MFrCgGl3LyH/Q6qKnAcb1ZnsAZFgob7gsZSpbBpwgTcj5fqXE4aw==
X-Received: by 2002:a05:600c:1c12:b0:42b:afa7:801f with SMTP id 5b1f17b1804b1-42bb27a9c91mr124675185e9.30.1725433393262;
        Wed, 04 Sep 2024 00:03:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:66d0:70f:5bef:d67d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df954asm192565635e9.26.2024.09.04.00.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:03:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 0/5] gpio: stmpe: A few cleanups
Date: Wed,  4 Sep 2024 09:03:10 +0200
Message-ID: <172543338864.7843.11531696797398483800.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com>
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 02 Sep 2024 16:30:39 +0300, Andy Shevchenko wrote:
> A few ad-hoc cleanups inducted by the recent patch that made
> an (insignificant) typo in one message.
> 
> Andy Shevchenko (5):
>   gpio: stmpe: Fix IRQ related error messages
>   gpio: stmpe: Remove unused 'dev' member of struct stmpe_gpio
>   gpio: stmpe: Utilise temporary variable for struct device
>   gpio: stmpe: Make use of device properties
>   gpio: stmpe: Sort headers
> 
> [...]

Applied, thanks!

[1/5] gpio: stmpe: Fix IRQ related error messages
      commit: a794331325f143bd010a91aa078547fee7fe907e
[2/5] gpio: stmpe: Remove unused 'dev' member of struct stmpe_gpio
      commit: c028e1c5a414f03cd849912073db7c1927ec8d89
[3/5] gpio: stmpe: Utilise temporary variable for struct device
      commit: 56f534dde6ff41eaf71f4e368953cb8da54cecc3
[4/5] gpio: stmpe: Make use of device properties
      commit: e6815a05c0c909c8d6396bf41d0c06bc967f37bc
[5/5] gpio: stmpe: Sort headers
      commit: 9f0127b9cea593a661004df948dc0b4479081c2e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

