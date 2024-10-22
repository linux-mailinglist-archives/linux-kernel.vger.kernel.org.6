Return-Path: <linux-kernel+bounces-375781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F29A9AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D40D1F258C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754521487FE;
	Tue, 22 Oct 2024 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1q6oMpn8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7B137747
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581370; cv=none; b=fZCjfsmpYXrDkfSqImwb03goJWW7JQei9RkykH7+NZIadAh9ViqteCMkOE7T5F0/tHiUF2FZoo+/NJXqvKPPDxt01b1oHFj6SYzJ2LJxwryPKnL0IuPnOnDEo3/+BITxkZ8sW5DqscxcvATV7EjlRg7X7fE6LlmqTfveX+aidJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581370; c=relaxed/simple;
	bh=RkG0Ike9hCJFKf87lYaZyHqL96vQEbiDxmQ6YA4RipM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqxtFoRpkuFU4ynx07juP4aCDXhX9x9NO0mbVxw0VW7FG1Ov1mjsGWsZMbpUafIHHALICJSz4OtvhhhmPsfKtP9s9zW2kqw77OI5N6rqzNPZrEL1AXHZ+iAqxn8igxSMHFhFhXjD93WB+Fz4N3AJv2CzWUW959Rhkwl460py7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1q6oMpn8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431481433bdso55918085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729581367; x=1730186167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U7VRMCAMM1ghAu++CV4mgxS/6bp959K4DFHz9AO5Jo=;
        b=1q6oMpn8cNr5s0ayHJYwD5rjnToIU3taeQ8HaH/xmq9V23j78Sbi2WhPnXlaRdF+G0
         Nm+rlqxzVujJWe41LllQqlRwlnksWA7cuDmQiaDiloSys7TUbNziG530NZOtyGcc28nh
         vv6L9HADSbDxQHqKW9HDdQ822FPQbhJZ7d0threSTeZxgIS/KpEl7h9E1vOMUrT3p7Q7
         jf1Fiqj9tLWaCpM9AT0bIucT7F5Sy9AZn540xHoDfTVPHl0utRAk/KEQjqj88lO4ymGb
         a7y50fVBqZVfh+lWV/2uvE5XDx88LWwpsMQNkXNih65DrAuOU5s/99lRIq7fJx/tN7Lg
         7pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729581367; x=1730186167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U7VRMCAMM1ghAu++CV4mgxS/6bp959K4DFHz9AO5Jo=;
        b=sZ1R5CXMnmC0zbOsQe7ZOcH8ouqk/owP6U8O43PfUzGPDeWdFLjnfCp31iqk62rnfU
         vBSre5v8RFfhNtjlFmt2xDIDPC0DNDPZ/CRDAvuFJ3Un8y/AOno4SLhGggV9a85OcEIG
         cjSemwDA2v4gJCIc9X2dLo0eMQYSTZqdQ3SrLCO5IM2i3Kz6oOKcRrU0/X8lr0UMHzdT
         Z34oN8nzQzo9I2deIrVGHKO2kpoAG0gHHiDr4CknvmRtwGPw/fsf96VM+ljxJxF6oIsm
         CmMM7dAC0yVgnKJQTJnAgO4Gq8c6ob6Fe4W9glAmkncDoZooVrdFT1QbH2adcWfMe/Hw
         J9cQ==
X-Gm-Message-State: AOJu0YxES3PVlMjITFt47yefVNWw3+5MlTai2AKe7yDbQDvbD/PbPJPJ
	udcnpn0/hVPNqDoqa7/EVHhFgp55SEpqiv/PApa5zurkoh+cyj1vQNtoVZUzjT1KvNiZ4KaiZ2A
	5
X-Google-Smtp-Source: AGHT+IG+I31RcTT4b72YS+WEqLV1rBfMVac7CEQ9/N1GJCao/ZJjmgB2LDsywBCj+0YLSMaNn1G97Q==
X-Received: by 2002:adf:a14f:0:b0:37d:4517:acbb with SMTP id ffacd0b85a97d-37ef214d026mr1036500f8f.17.1729581366849;
        Tue, 22 Oct 2024 00:16:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9c8b:c7e5:66f5:b8f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4aadcsm5978778f8f.40.2024.10.22.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:16:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: remove redundant store of debounce_period_us
Date: Tue, 22 Oct 2024 09:16:03 +0200
Message-ID: <172958136079.18777.9577583278910860026.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020115238.170994-1-warthog618@gmail.com>
References: <20241020115238.170994-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 20 Oct 2024 19:52:38 +0800, Kent Gibson wrote:
> debounce_setup() stores the debounce_period_us if the driver supports
> debounce, but the debounce_period_us is also stored where debounce_setup()
> is called, independent of whether the debounce is being perfomed by
> hardware or software.
> 
> Remove the redundant storing of the debounce_period_us in
> debounce_setup().
> 
> [...]

Applied, thanks!

[1/1] gpiolib: cdev: remove redundant store of debounce_period_us
      commit: 9eb1e8276155b9f540281f2dbf59885efbb9f09f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

