Return-Path: <linux-kernel+bounces-209566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFCC9037CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016721F249AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EB6176241;
	Tue, 11 Jun 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySUr6KHe"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB19178367
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098204; cv=none; b=NlbxXhrPF4yKFpzq621mx47Swei8ITWkBQCLU1EPwO/YSP5fVQ7KB42JrdSyPKciTpYdB2kSevWiKfXFH7ZN68PeFrl2vkNesp9SyCucu0cVyjWNF1+x/w9k4WEOpxkg4v0rcScBHUGL2BlE036WIYpeVAz+azvNxnXVSd6eVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098204; c=relaxed/simple;
	bh=sROeVyOWP8ju/1YuUGlfVA/lz/40KedsP6ga/DvrQF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o8kyhv5xJyooUxQmUXwpRaXpo702N3Uuf/qm2SCvX2UIM82cKxGUxzT9/Nx8mhBUsQDvZuZePtA7FQFD8sU7gE885fT8l+Wc9imJkcfQKPOxc4jO5fPqGinSJAcYdOEGEmYo5IE40FpvRvz3c3VsFD2oUmVlGMHtsAweFGKlu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ySUr6KHe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f1c4800easo239025266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718098201; x=1718703001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDDStHJVnEvxpIADP0VNO9TR02kZEk+naFrQocyHQd8=;
        b=ySUr6KHehSVM/JSQDAKt4Nh8ytdWYocy/Zh0WmcTLxzv+lLBWIO4zSHmFd+ruO0YYp
         HxhSUvWOxE1pEWXiRJEn1yFxIy2nZ/BF2Xix53dmugbGgzqCC8T1lvo1N73UTkmPS/HF
         YBrv0s7heCJeO7BCR6jpiyJCYWJVhfkvSZm7P6ywjSUIa6ESTF8WXZAKNt6IOniSlwiD
         zga1TiAmzUFkch4amJan8tQHsYI+W0UB3zLnDkRJv/b1jKP1bTOtw0p9o7pL52+AYyuO
         2SIwsvZ+nni/3/E2RCOCDEllYRv3FB52nD2rszSLAv36/KmpQEbYe+hXJlWXKYX6+nIs
         raZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098201; x=1718703001;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDDStHJVnEvxpIADP0VNO9TR02kZEk+naFrQocyHQd8=;
        b=Ul3pVPo6NuLF686C77Jmx7/j798oHigVezdi6wJJJ2hwy50fxlGoLJSU8uVbdwl1pz
         jS8JTb3Ern6foH+PsTV93rn4VVLpUUnOWvTxIzGVvo+HtfKuIJfxpacyn5q4FlN5YA9y
         M2Hk7uWxzPgIhqpcbE/Ne5398nZfxBYkG4kZ2XZTAOCvPSI/XkA1I8e3bUBsmXWmAydt
         5BoGxXzdepY2YHmGZ4pWbjbfsyATmoym54UvDWElH0GO7zQltYRy4kwgb6SqsLNbmMYc
         qLz3FwsyBARo2tWpP7Tn0QwbP9H+bfJFzajHzWGiilVOVYe2eKMyeek2wY/Bz/p5w+PV
         Y6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKi3NP2RsAgNHtSRiP/CJ+oXVD+VnQfSUiab6N3Cqf1yYKtWuUtlSRyb5+zTq99L4ApyRHLVCEtSdRzmMjMfkameYEHmQ579aDSK6T
X-Gm-Message-State: AOJu0YzJTyXS0mEBIEeQCdcdcT+bh/1/SEnTjs0hyDriMLOg45pUN6SJ
	SwJFzwgtbgPHQRjifCqSl2P1A3v1KlZ5MumsJA7v0gj4CNB834osVASK0ZuiGsA=
X-Google-Smtp-Source: AGHT+IFy7enofklQCZekReZQIgYTREHNstyvhStXcx3ghHAyAYVYwn36q+89r7o1pxmzUZJ0jiWVjw==
X-Received: by 2002:a17:906:e0cc:b0:a6f:1872:4e1f with SMTP id a640c23a62f3a-a6f18724f43mr308823766b.77.1718098201313;
        Tue, 11 Jun 2024 02:30:01 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm735715966b.110.2024.06.11.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:30:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240610-md-drivers-nvmem-v1-1-c5d378597cc7@quicinc.com>
References: <20240610-md-drivers-nvmem-v1-1-c5d378597cc7@quicinc.com>
Subject: Re: [PATCH] nvmem: add missing MODULE_DESCRIPTION() macros
Message-Id: <171809820035.51273.16981931013045082641.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:30:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 10 Jun 2024 15:55:58 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied, thanks!

[1/1] nvmem: add missing MODULE_DESCRIPTION() macros
      commit: 43b4167fcdb91a57d6102347a6f848285aa214c1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


