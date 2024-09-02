Return-Path: <linux-kernel+bounces-311062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84059968472
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5508B23EA9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921913D628;
	Mon,  2 Sep 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g7SsZetC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26713C9A3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272323; cv=none; b=XgrlDjBz8zu7zLcFf9ugbr2xrAqoB9l5jXVju0PosWo8+uQY0FBg966jUhlRwNUOymT1fCbqy4z0wWUwmIrqy3IQRw+e4UO/s3HillmHTMQS1WyEaggWL8V1Aw1AzJb9ljLNGe6FahVDIdyQ06LjoOKGXJasux08ywASwtrhED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272323; c=relaxed/simple;
	bh=50tfvv2F74cg8NgwOd+29PBbdehKGtm1igcZpPk9ce0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpBCDye5KGnkFR5pbqk6iODJVHTJtc6Ws2g8GpBfW9qpSZBlfbroWQGN8EeMemrSGeVUZUcBeYe4f9ObY+RJNlgA8/fOBxERHHhbSf7MFTnja37G+MahgAHbSIIUpVJwGZjGGQkPftUvUHL6OGgZaLlt3iJ6u8xHkKGPV39VvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g7SsZetC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42c828c8863so8532335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272320; x=1725877120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycui+JFI9CxYt9XI0/T6WBfYUr3Kqy7UHMtVpcG41XE=;
        b=g7SsZetCJDojV1//zO6o/ilJu2+7Dp10SFHu2BR1J/IuG5+E1A0EO3D5PZN+tRHh95
         KN9YTVGjkrj+nFRSH76Y9g1BaqFHyDsr8YHOzMC6AfdhExyUYwEfx97fOmx8ilrh4uI7
         apwqElqHRRvLqcXsKoX8Ufv1m3rdbEYBZdwf3Lef0TRDj9pxTUncKJlQe+N6yhvrH4Vi
         boIH1fm1BBwgoFzrLZcgL6R5iHPNLbDhfCCkewY0OP1QNBfwdGOdh9VtUAar2U6FbL35
         whoZynyq8nlWLnskJyQx5LvtymigNVjv0jeyulQzdVjBRms+Dv+8IAGkD+XAJ3ZeoTwP
         WC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272320; x=1725877120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycui+JFI9CxYt9XI0/T6WBfYUr3Kqy7UHMtVpcG41XE=;
        b=jAnWkX9Gt8g+jCNKcKYmjhEBuaJMqFVD8hhJh/9OrJDunViyGoI4fXhyqJzhqtXnnG
         TIJcIznI1T/DDTFAlqzK+hbguNM1V7njCG577IDbLq+ONfpHAyRHnDpnj6EutIaENAqa
         sd5+TDrZE9YLYBPrGssSE+EPxZQshN7iihq6NAuDO73mAf22u0C79VLul692ZmxbqXWg
         MNdy1S0tkKskCHhtMyHQ0IZucY0LXDsplOkR2CP2x80dd5ufozRQMHZqkR4t+yZD4NfN
         mnJyyaAU422OQhUTrEWxEI+JvE/ONl/Zd/6uEib48LeFoCXX6sSldXTqt1qdcWfFG05o
         gGsA==
X-Forwarded-Encrypted: i=1; AJvYcCVaD8w2vebi1kww6R3asDZ1OKHEqlk4lmKrx86u6pdTZs7R3YQOzhkeexDLDiEkuXNZBg+1YcxGm0dysW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymH8sWQh95VGAg/buf3R5dAwnYFTblEvPu1WdS12idCloaq2o+
	blHW3JhIfVzDPoQphecjqWnc0c5sePG+SjXb4tXW79CkBFKw033wEbGsx2T7biE=
X-Google-Smtp-Source: AGHT+IHAioSwRJUzEmySTq0sPUNBl/DQdHLM1f5yXoCI1J5K/3asH8icQw3XeLJ1hVXzCu80aOZggQ==
X-Received: by 2002:adf:e262:0:b0:371:8a70:b107 with SMTP id ffacd0b85a97d-374bcfe5eb0mr4538224f8f.49.1725272319908;
        Mon, 02 Sep 2024 03:18:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cee38722sm1190892f8f.112.2024.09.02.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:18:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Prathamesh Shete <pshete@nvidia.com>,
	linux-gpio@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] gpio: tegra186: Replace of_node_to_fwnode() with more suitable API
Date: Mon,  2 Sep 2024 12:18:30 +0200
Message-ID: <172527230206.24237.11721376467897307405.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822224737.706870-1-andy.shevchenko@gmail.com>
References: <20240822224737.706870-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 01:47:37 +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> 

Applied, thanks!

[1/1] gpio: tegra186: Replace of_node_to_fwnode() with more suitable API
      commit: 6955e021fedba9d50b58b1fd674829524bacb8f9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

