Return-Path: <linux-kernel+bounces-548430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD41A544C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677FA3A924C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275221FC119;
	Thu,  6 Mar 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sPWAFcle"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4011C8625
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249517; cv=none; b=OPrVMPyjq/6qxRsGdyP0dZjuzdZGN9tytsB/OAK1gqiy9styxm0Lc4vkKBMCtMLuGkRaokqDj9FSi0wFe5KxbcY7CsvDG/JUQ/XRthWJ1PlmHiWfmdHiXkTdAcWrfXhtLRzF4br5lO0tgzAan3i0l6pHHnBXAe2B+rdLgTElCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249517; c=relaxed/simple;
	bh=7blf1HM2Rgz7cPSi6+aOLoGn1wtkmeeZrL6LLuLFIN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2l1foDvm0nClJBR4VaI2ZpmOgfDH7mjEuk/UyQZxgRK4WxUcWGeLJ/fXir/t64q+RRi2mTdv+4rAYlGRWlUuBWHQJ1Ktr5DeO4P1jYsfbDi3m5uVEux54LDepgzXxHBfnlD0Cl3VPsJdZoQaVJhiQe1ojTLo0G1up8T+08UA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sPWAFcle; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso1809215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741249514; x=1741854314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38xMwicGvP21YZCuem2zWHYfFPio2TDIjqcZv2bh+mQ=;
        b=sPWAFcleJrpAiBoWGt3axTPfKsU813oe5zMS6AQ8FNPtaa7cU7xcVcTEBoeepjTWMg
         iZz8vaY5mmnXgMEj+cU5lkcnT9FxTcdUmwb1Ruj1mflyUrs7/yDvxiRY7KnfHFUmurNW
         E1Mv3pZOnLuTOL3QsurGCQM9RJSrfMiTJP5Sq+h+WfBUe4SMvNpMRAwgHJ+BPNZCA1Nt
         n3ii3BkkmZ4KOTi1ayu7oJB7HHaJfnZx2FqKdXDE4L6usH9IYvOWf/AYGdn/moQpIbFe
         kuVKLM1DV7EkA9yuzqgo/F/m+TbiryAOOosoximbmy4OUFOkLsbqsC9Ayo06ypcawuY9
         gGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249514; x=1741854314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38xMwicGvP21YZCuem2zWHYfFPio2TDIjqcZv2bh+mQ=;
        b=LG83U6yy4gb/RRpLudaxPSu9tWbWf1gCPL0Hjj7nAIunVfQwawghp3dOibZb38lFci
         t/9U4kXGoKDkUzrQW+4ykRacyC08m9lUh/0X/Or6HGoLpsIe9ZUZK9jKsMHvVUxna5GO
         8/jUhIwg89wMnm+2hD+bTiLobFb4TlTGV6ufAFbxLZuJL3TxXvrBV0qdaOQ7Le23eSBL
         8fMiFH028dxrwLYjXUESJHaz7auhyzPoqJJze1YpVJ5f+328xHIegd7YcLqsv+s8Qisl
         TwxDY7MjOo+3RopfVVwdyzGjJ4N18YvMoA9ZCGELR/FTXBlzTdy07X1mADlCbyHtx9fX
         wugg==
X-Forwarded-Encrypted: i=1; AJvYcCUFq2aUodRTDpZE+AyOikzmnkqqxarFhGFZYyEmMszRr8XbDWbRS0yzCGcxuABO0Pn/g5kJfVgDe6JcyCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1H3IhHsvZ0/4ziZq18WtFtIOuypdpDlk68AMn798xMeEqtBhw
	FrEM6uZjqt2RXJvb1FITu0hssMTEV4gXcmjNfAHfF6ZtKekCbiKnSZgCudhew9s=
X-Gm-Gg: ASbGncssknDMw/fMflu9HIMlchnuZaggqeAsdStCfk6kW13+RfcPInRqCPLpbj6Awyq
	1Fo+gzjQuCWTT21/AQQy+hYWjtvf0go/rrkPOQMoSnD1hu7lqzdhDFmrTagDqc0/1NM1B8GHnuw
	it2v+4smSfLx8OGW50ujfMIHLrTwcKHGB7W9OnltKDd0Qx074T6M4FGg52IQ8WQtT0+b5DLzksY
	7d0wYEciX9srLUsLw2eerI6u685+ibG+sqdzfmigNe//EalQMyq8GffoqBtR0AV7NKxOWfeYNd9
	3n/YcWUQJpPyeL6qfSO4woR/3hlEZXsEUa56DncCAt0=
X-Google-Smtp-Source: AGHT+IEeS0vsBvB0L304XkSysGvXWBoOMOT1GlwzL9MRzSLRJYDOHSkssynYuuLiIOL+qgD4aMdSbQ==
X-Received: by 2002:a05:600c:3544:b0:43b:c878:144c with SMTP id 5b1f17b1804b1-43bd2940b68mr53718885e9.12.1741249513850;
        Thu, 06 Mar 2025 00:25:13 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ce13:b3e4:d0d:c6a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1037bfsm1250297f8f.96.2025.03.06.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:25:13 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] gpiolib: fix kerneldoc
Date: Thu,  6 Mar 2025 09:25:12 +0100
Message-ID: <174124951041.10974.13766856355488023425.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305094939.40011-1-brgl@bgdev.pl>
References: <20250305094939.40011-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Mar 2025 10:49:39 +0100, Bartosz Golaszewski wrote:
> Add missing '@' to the kernel doc for the new of_node_instance_match
> field of struct gpio_chip.
> 
> 

Applied, thanks!

[1/1] gpiolib: fix kerneldoc
      commit: 9b443b68d97983dfb9a92009a5c951364fa35985

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

