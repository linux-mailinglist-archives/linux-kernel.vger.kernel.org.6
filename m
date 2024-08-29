Return-Path: <linux-kernel+bounces-307202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA659649FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901CF2826DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3C1B3727;
	Thu, 29 Aug 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLk138Dm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8B1B29BE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945206; cv=none; b=HzDQt2OGJGRmRrxcjFtcVSMFKo2sZbWyY3Pg5sYd4YO7G5yUi5PswFWFN2zf2s3Ld4esvXuofJZ5uaQEhmWoez4OH6ba9skaSSAu95PTs4QGJOR90l8YYIXaFc4HxLmmkaV0RVDjql9TwHHehlTul03wtlPkihsu1GAblgpw794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945206; c=relaxed/simple;
	bh=4dvJdY5K5kxOqoCC7pXRpqwFhdbAnaNKbX4E/D+enOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF6zi/LDJdYUk1q7boNI9jAdXyJAUc/sd3k04jKc55piFbIYZ3V/iSm8WBCNFmMft/hDegcA6mUsEHs37U3pqc1Vd+ZtrVVeitWfadNuxQfMDVheddm1fNksm6PEF7FffLOhRvJ7bQbsq4IAqJRbGck1DjkGrq5M8O4NRQILf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLk138Dm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8696e9bd24so103467766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724945203; x=1725550003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIVRFaFvh25kJ2shkW0d6LgWcnTu2JPMWtkC2wxiE8c=;
        b=iLk138DmuUR/gMoYbr0SRJadehtWKOy07A3t4/MS4xnlhm1Fsz7e1JxSkvVK01qO+w
         KiaVHPTY9k1sJ3IufZZNtAdKdTezn5LYjB3Sk/yxwX/a+37NW75hpxKSZgzpf4M+nhMp
         r5n7amg+em3PwlXIypgGviQVM1SLcm+VuBFrpc57kIFeEOhCmib2JcrXgEATVMojGACU
         R8t0Mx48+cx1AqUn5rEXjHA0ypfXGDCYgM1Fz2m0gfN1fz3HZNxpufi4TbWzkfmELc7b
         LD88e2Z2U11bSOXqwF7u5ZIYoiPH63yWpDINWFo+MZ2iqafnmr+2SCag8V+5K1fOGSzb
         +n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945203; x=1725550003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIVRFaFvh25kJ2shkW0d6LgWcnTu2JPMWtkC2wxiE8c=;
        b=rtkW5nHSoaacQP5AESlQ6hQHgH+gcWfr5Zp8OKyxXFfwgKuhLNSNezzG2FsO6ULb05
         jaX+o3jC/CO8773LmQfjgp/Lt2rDZFVq7kwlG6hvU+BaruBJaVC3LbBiNHeQdejco+6F
         f5MfK/x10I2eoSjIYnvXRMbWQq1B8yaF0KvEQYs7KSzz5QFmJ+0VWMCFotvI2nEPIW4z
         OwmzuZE92ZnUUssh2uxuFVKDwXITrV0UwXVu0s/ToedO4xcISPygsN2b5IWPL5tf+3AH
         mAN6xpjFZdo7605Iz/yrH6DLN4OHJ8ST4UxSWEEQD/yOF3W8mQPmXF7k5Naot/nKOPIo
         AwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtjSEbu6jG29XfjbOrWSIN9dn6F0aRt7j9AMzL5SkIA7nen4UkBbuaCuBnu/ufTh1aALj185uKR8q528U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWQvzVHT/jeF4+qpzig7lSWAjIvZv+Wakpla2b9HTYvH+nY5L
	gIPm4m+GrfHLFpg6SoykTCmGidRiiQGZC353PRO3huJfoC+lIhccKf88x30ddgvHypdICQqsn9+
	OBrDCLBMPO9A2G/7ZlBcU/cWYFnP1yhXi5luGdg==
X-Google-Smtp-Source: AGHT+IH2kueLQc5TRgnqFrkLjrGvJRIK/BMurN2noHpa1MBrWwQdN5e//Oya3AbhSVY9odHODdUMQtzGctXu6ADcfvk=
X-Received: by 2002:a17:907:970f:b0:a86:894e:cd09 with SMTP id
 a640c23a62f3a-a897f78bdb5mr287428066b.9.1724945202995; Thu, 29 Aug 2024
 08:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Aug 2024 17:26:04 +0200
Message-ID: <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be, 
	magnus.damm@gmail.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, 
	sboyd@kernel.org, yoshihiro.shimoda.uh@renesas.com, 
	biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Hi,
>
> Series adds initial USB support for the Renesas RZ/G3S SoC.
>
> Series is split as follows:
>
> - patch 01/16           - add clock reset and power domain support for USB
> - patch 02-04/16        - add reset control support for a USB signal
>                           that need to be controlled before/after
>                           the power to USB area is turned on/off.
>
>                           Philipp, Ulf, Geert, all,
>
>                           I detailed my approach for this in patch
>                           04/16, please have a look and let me know
>                           your input.

I have looked briefly. Your suggested approach may work, but I have a
few thoughts, see below.

If I understand correctly, it is the consumer driver for the device
that is attached to the USB power domain that becomes responsible for
asserting/de-asserting this new signal. Right?

In this regard, please note that the consumer driver doesn't really
know when the power domain really gets powered-on/off. Calling
pm_runtime_get|put*() is dealing with the reference counting. For
example, a call to pm_runtime_get*() just makes sure that the PM
domain gets-or-remains powered-on. Could this be a problem from the
reset-signal point of view?

[...]

Kind regards
Uffe

