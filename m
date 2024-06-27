Return-Path: <linux-kernel+bounces-232577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B391AB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C0C1C21BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A919AA62;
	Thu, 27 Jun 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U+SV9x0E"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35319AA46
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501801; cv=none; b=QS4puZw3uv/ciy0NZpL8PIgW42bynj2SFiab0/ZP9wHW7MyCRawaZ5AeMiNyHqXaXdcMl/x6kzg66p5uvo8FlMtlVfjnLynnQV7NHpkOxLqng6mjID+CUhKSVsgQ8EYra1/YjjS1NiUzZJ2ufe/JDDOmIgwNfoiVtDvRPxWLKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501801; c=relaxed/simple;
	bh=k7iuqBPgmy4nZnAtT1DilW05j1Pk6QbPYjyaED4GR/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwuYwjSQCWxZ4A0StKd1iAuygzhcK39WhyPM4sF7Gk4zGmiYbJwJal/BjPyTtaRGrap23L3K4pSJp+2znoJZ02vuHMHLAJeME+B05BdYWxV1Z1VMlvlFkpCHkGRP+dwAcHgD8EagiYwVVDJcMz2ZHQigEGL5AKAdoDfCAEVkCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U+SV9x0E; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so73977691fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719501797; x=1720106597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpx1KcQ5akaT1bBDzPSP9F6IViuH6XlSIvtgVZQlUv0=;
        b=U+SV9x0EkLuWYMcySakVnUakOkc52s/GD4n7IcTdO3F7sACbU0Yx8K++z8Onu8SygK
         XkzCkd54jDhLc+Wr12yGBkghNGx8rnkFlgg1AegyLVQlmcWAVwtIpcYwFKosUW7fP9dt
         wDcRk1VlM+KC9byoXIjq/+k9RkO7JiZYzORtl5RX/GgBJVLKwIoNyMCpPBonG0OLxnC4
         czdz2CxFFOeBRdPvTybhfGKVDqb1qxcQ3n+k54jDrFUTT1bOiIEtj3uKZfx8yf+fqLin
         t5SKQVNrmyScip6zdmadPII0cUQv/SFKkZWNBH11WU4vjlyBhWVXbsC5Llg1V1pOxU2Z
         h7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501797; x=1720106597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpx1KcQ5akaT1bBDzPSP9F6IViuH6XlSIvtgVZQlUv0=;
        b=NDj/TNFCOFA42LFdtE9AyXLbYfcdO2wAoSc1IMq4aNZzsyJkH5uiURrDSZOsbQfHi9
         WUwXHeO9l/OvNcs22RPEQzDd7KmNLGtIA6dYqtrK70F2g3/+LOX0zGOmDyu9OHTvJHY1
         Q/vB+zbMP0FfGS+nugEntOzMd3pzIGiUTEWWFRe3SpHOXbz5GW46Rig3Icp+0W8dy6xM
         0mHCoOysjJAUVRegXJqdIrgNeJ24k78qfq3W3VVznGJdakwciYkDBOuYA5PDIr8qSH42
         33N88hQaqwQbRVbX+1jHBIUsQzNA2aYdWnZQB6S7ktIP2/mnwdmFmNKCoNklOcsi1gVu
         ph6A==
X-Gm-Message-State: AOJu0YyplcB+70UANxkdfzQ80hwCfnivTAXAehx/bXXr5sEQMRneepGI
	ZHC+INgLADemc1q8k5ocdu9OYEm3+4limXYv5oVb1Zm9j3JVxAajDWuZmSx+lQt37bETogBcd8Z
	S
X-Google-Smtp-Source: AGHT+IEfW2J1aLs8C2mx86xG1gaIK3GqOHl1FAZHCp5/HI8HlO6Jse403WoiVWIs/cdfXCGzzG73rA==
X-Received: by 2002:a2e:8297:0:b0:2ec:174b:75bb with SMTP id 38308e7fff4ca-2ec5b38ad36mr80664021fa.28.1719501797218;
        Thu, 27 Jun 2024 08:23:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b65731sm31245685e9.14.2024.06.27.08.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:23:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/4] gpiolib: cdev: directionless line reconfiguration
Date: Thu, 27 Jun 2024 17:23:15 +0200
Message-ID: <171950170548.40188.15774254279072823982.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626052925.174272-1-warthog618@gmail.com>
References: <20240626052925.174272-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 26 Jun 2024 13:29:21 +0800, Kent Gibson wrote:
> The behaviour of request reconfiguration without a direction flag set is
> ill-defined and badly behaved, for both uAPI v1 and v2.  I'll will refer
> to such a configuration as 'directionless' here.  That refers to the
> configuration requested, not the actual state of the line.
> 
> The configuration validation used during reconfiguration is borrowed from
> the line request operation, where, to verify the intent of the user, the
> direction must be set to in order to effect a change to the electrical
> configuration of a line. But that validation does not allow for the
> directionless case, making it possible to clear flags set previously
> without specifying the line direction.
> 
> [...]

I applied the first two for fixes and will apply the remaining two for the
upcoming merge window once this gets upstream.

[1/4] gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)
      commit: 9919cce62f68e6ab68dc2a975b5dc670f8ca7d40
[2/4] gpiolib: cdev: Ignore reconfiguration without direction
      commit: b440396387418fe2feaacd41ca16080e7a8bc9ad

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

