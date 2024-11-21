Return-Path: <linux-kernel+bounces-416673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DEA9D488D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE2283024
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BF1CB53F;
	Thu, 21 Nov 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qSNSMf7K"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018C1CB30F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176643; cv=none; b=mbx/2miJaXNDnCsuRz7pH2QKlC7lUvR2nFwkRONL9VncdWvva9bX/Wkt9kYhdeLJkV/euxCF2TU2dOvgAg6Lqp472c6imcJkvM9iMqEC0taSVP61Z3ZATsiG68x68deWZhdVQImQq5L+l+goLPXVYitGo6jbg7o45LvJx36X04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176643; c=relaxed/simple;
	bh=iDnfgN6PGF/7eyy8/94LuMag65g09uiHiBRee2CmnRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DipVuPc3n5sy4Msm2Ccs+qm99CiQHCM5a2G6Kf9f7MY1k9do5vlXtLcPqNO9kTsyxhku1GhrjqpVY7iaRdhiLIG6HdkP+MompfSTgfEkgzssYwVfNEsmv5QtsW1F3TNaeIetjiqZ/l78AGSitST3DNuiNlqb3WDSS7WJh0Dd9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qSNSMf7K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431481433bdso4779625e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732176639; x=1732781439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQemGKV1Bllv1eo/npoEZbbDyGyqNGRo1Pu4zW5KeD4=;
        b=qSNSMf7KFrZrc4xcOTbAF9Mor1guiCFSsgfuhYw//KYaFhWUz18lrYGalM3baip55G
         o/ebpoRgMrnJthKule/uEmeUqE/gw+2Z5g6zyQ/aynT+l+scKT0dpdJVVUS44vjGidlE
         m839el3mcxdKMMNpB+VHRUp4mizq3Hl6zjggIwG8LTUU2XdqQ8dQsw1G+L2xeoKG6ShW
         0CKGprZ4rH/1g4YDBVTMbNGKwT8l0cqcLnBRZyBb37pShCnPenzuG2ys63rMfmlvIty9
         8KsG7Sovn2As/fqAKVzlYuFTvPwOnghYsJ/caBokYZ22KrOJ8z8ZxqRU96dhQSPEheu0
         qDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176639; x=1732781439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQemGKV1Bllv1eo/npoEZbbDyGyqNGRo1Pu4zW5KeD4=;
        b=cMxF/Cm//q6ZuppPMP3rDIOjgH6aUCV7GMCOOK9bk/U7V4OXOw8U7pRa9KVsgj8Rmw
         A7keBaoTh3tG8+cRmElpTDtMkfxkNR+DDxf8Y7BAksgJA2j8R8/e4ioUygHuzetBlgEt
         zmYdWvuNNuHIddTWiDNiyvWvlsfmmXFMwVt8pwKVnl0R2Ca8jQjr1KmQK/bJ2wKq8E4u
         1WY1MnD0IA/p22U/7kSSvGbBdPSTBGogx9xHJD1xLNPOcxZNF0wGvYIiBn5B2T8YIiDs
         1tesRyvd+mXM0tfK9NhMnKQiR8zVvKr7SCKcaeKvEhS50OUBMvj8zaL3kd6AhBDNM3MH
         Vd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIGjzrnu5T4dlBVlVARHBAUbU+i6/7SR8x+CmFVc9nguSMqnUsQFCdT/4VG2KV9JGNfOfxfSmgu1pxpQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgCrd/D5+q6W1SnSQ7aziZxmfLPi2D/Omqh5IFRulXpTtgDpk
	IXzbViqIGHQTTbKyr/2cTi7zVUZq4s2aMdOwZYkQ7bkMHCAQ7O0hED02LnmLrW0=
X-Google-Smtp-Source: AGHT+IFAtlq3C5FetoSTY9WO82Elg/WGpTD8ieKV2vPhZ+MsbQlICDjhoLXP4IZVp/9ulSV5A7GPcw==
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-4334f01f731mr45241085e9.26.1732176638718;
        Thu, 21 Nov 2024 00:10:38 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d902:9409:ef0:268d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1170sm46696195e9.3.2024.11.21.00.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:10:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/1] gpio: zevio: Add missed label initialisation
Date: Thu, 21 Nov 2024 09:10:29 +0100
Message-ID: <173217662606.10730.5446470361475878860.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118092729.516736-1-andriy.shevchenko@linux.intel.com>
References: <20241118092729.516736-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 18 Nov 2024 11:27:07 +0200, Andy Shevchenko wrote:
> Initialise the GPIO chip label correctly as it was done by
> of_mm_gpiochip_add_data() before the below mentioned change.
> 
> 

Applied, thanks!

[1/1] gpio: zevio: Add missed label initialisation
      commit: 5bbed54ba66925ebca19092d0750630f943d7bf2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

