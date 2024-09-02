Return-Path: <linux-kernel+bounces-310911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C59682C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D5B2831EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247A187330;
	Mon,  2 Sep 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zLwK+okp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2657187325
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268244; cv=none; b=r5/SxyneNIXCVt94b7sarLZnlq/hhxFrwdZyaG0gjSFhD15dAKbZkivWANv7jnMhJNVdoJ5cCOGvpMcIGnpaGmExk2GPHCsRb9aACYGqdpi3TdHQdwkpGzFaNpANDJvXgchvn2WTcNBwxI58kgE+Jfop0SRIGn6nL457KvAFu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268244; c=relaxed/simple;
	bh=gLtzuCSwarsqWnE/n2QnjUDMRFa3rifgetcYyohvtis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX2nD9Y3RhgRdnWn3PNWTmHWisUwgyuiR2pi/nLCuKp+6wSE1uvPIZcfcB+CBftEMMixXvycXANWyYwS9X0qnUdB6303t/lWFJeUI2MvcYDI3ThER9c1jXMomZb6EpxQp7h24JAHCeN9mC655TP0pImrRTJAe+SW69tlylUcNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zLwK+okp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so24011195e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725268241; x=1725873041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feTQlQpe6m8ABYWkRp3ykckOGNnbYvWNZ3YH4k9+AFA=;
        b=zLwK+okpmyTL+sJZnelNzFIt3Bv+5pjv3NVNFPBgYBmcIK2NMCV1FVIhVDzFlhP9O6
         OPGvB1Pbnog0n9vITQnhYDDDtyGAZKKgkvUs6d/tRsSaMQuofCvlbPMKXRTX53x/RNge
         +NbJKcpKLbGLHEINdyBfVsBoeWwKmDwG6YsZaSbc8SyqpAJiMMli5tEKyHlrf/RcG5nE
         +Q4LHryE+adsWwHE4FQMihsuZDn8uxs3ULuNdUzyORkqqPM07jww2jVX5lzLUW4ZlXcG
         9UOICTslP9DYbu5lcjNfltQkJCtTXOM5OAyuzV6J87xVlJlJj9xne2eYnFpWpvfPsZMT
         T8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268241; x=1725873041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feTQlQpe6m8ABYWkRp3ykckOGNnbYvWNZ3YH4k9+AFA=;
        b=VKJOepQTyWf8D9xr5Dal0nrizcjJsRIDHaf0JWJjGYTpez0/8VOnkHovbKRxgscE/L
         Fxdd7L0y4g7pE+M9j3ZLxRA2+iuit15MjKpXzBMqXfZlw+Y6Iyv+foBwGeFBfey4+SCG
         3150SgFaiPfET5t/S8GwdDMOYkzwCkU+02hIbyWn3BOdnNumILhu5q44p9wO7f6rU7tr
         dffs9v+Jvlplo9lqPhw4z94lqurtFzPe96Yymi0w+4+nLN2AVoXcogGPtYbS8PBR905M
         5yvl3H22Ja/DhFE/FyBgCtJyLSYkLv+w0EvGkeRmH3EHBW2MrbMEBHpmAWF4c0iIsINe
         iTKw==
X-Forwarded-Encrypted: i=1; AJvYcCUpMCtJxAURqiEO/+FRgEZPQbHU6oC3iT7WvYAgi940G8w8blZhdSwEJtoUD+d9u7oTE1kb7reJXL4Pock=@vger.kernel.org
X-Gm-Message-State: AOJu0YxABVZZ9v+zcdwgNLl0qvxuAtyEVXuykqzZURq/gwkqYSkis8vg
	+l4zoZqQRjNkjw4eqstFLiJ7DDiwZuphd0OAjOGwPoZyR1xT8JMbHm/sZzcVHI8=
X-Google-Smtp-Source: AGHT+IFV8N0zfKLqSXeC4VxoLuFPCTp5JfwKgqTkJ4GlP9W5j2kpVgRQhJqygCon+ojugTmE1ye//A==
X-Received: by 2002:a05:600c:3b8e:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-42bb01b556bmr105669045e9.15.1725268240243;
        Mon, 02 Sep 2024 02:10:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df9705sm130386395e9.27.2024.09.02.02.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:10:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alban Bedel <albeu@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/4] gpio: ath79: order headers alphabetically
Date: Mon,  2 Sep 2024 11:10:38 +0200
Message-ID: <172526822993.12544.15229198628969363906.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821121456.19553-1-brgl@bgdev.pl>
References: <20240821121456.19553-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 21 Aug 2024 14:14:53 +0200, Bartosz Golaszewski wrote:
> Put all headers in alphabetical order.
> 
> 

Applied, thanks!

[1/4] gpio: ath79: order headers alphabetically
      commit: 7b4b93e260c684d346998a3dddc5335957b8be78
[2/4] gpio: ath79: add missing header
      commit: 4acde50b4d15373b55ff23424526378efa681dc6
[3/4] gpio: ath79: use generic device property getters
      commit: 10a968b21b89c647faa26b1f06ea82aa2eef1f9a
[4/4] gpio: ath79: remove support for platform data
      commit: c4a315eaf8eff0d3234600e13db7e7c71c0b3405

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

