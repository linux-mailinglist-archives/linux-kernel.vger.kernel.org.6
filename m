Return-Path: <linux-kernel+bounces-431484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAF9E3DEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9822812B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83220C00D;
	Wed,  4 Dec 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsTQQMYM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD720B7E0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325261; cv=none; b=PmynHlXh8GVeMCF4LW62ufBYIYLlse0/Wh13PCCxnfCZWBht/RpFH3Mbiz3xqs4sPSV8fWy9y+mnYyI1plVkMy8dKQ6sLnZCa0wriiuzvIzo5qLpIVQTYrzduA8FcJoxqWPq23/F242Tuj2y89Cum2ztgmo84a2XSR7MrXbOviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325261; c=relaxed/simple;
	bh=CqMF2k27fPawUzrAl3XJEzyyoJ0D1NckOE+oujV0MnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj6ayeKZaWkMZfI0nQUzCM2441RM2/BntYZHnMsw6LrIUvnelm2tlmSnb1elh98q9Y5kbK70VvrktUfyOk9vsrMCWduwgTxxiWIoFqao3owLk/d7I+hNtrsVp/0c0Q7Oh+QN3qged7YukFS1L8lr27QNmePZizp+U4SvDaGX0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsTQQMYM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de6b7da14so6747422e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733325258; x=1733930058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqMF2k27fPawUzrAl3XJEzyyoJ0D1NckOE+oujV0MnI=;
        b=fsTQQMYMwp6kA8nJj5aMrANyXPlK7hYzzt1+w8rm19EM5eBVoX10vpi5Ovi9LPkPjI
         /prW7r5W2GgSNvZ8DD3Y73UGTyWT0qmw07aupif8zkg7HXE6qMwLJ+vpIrs1syJA8WwS
         z+tYM7ktXx8I1qZRWMNJthZIjJzq65G74mNqQD0M7Xus2Xux1XxNFfMunOBrjHnAVAL5
         4Iv6UsbbSdOk1oQaYPBRJAnKhxGWhWYONSxkLJm5Iwgnzux1xmjLVt5gXY7Ej6hxEE/K
         m2VbYAlvVfscgrs9vc7ns5zFhyRvdK9CdMu/+aJDaYfwLkUPhXnIrxzQi2h40oTsGv6B
         KvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325258; x=1733930058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqMF2k27fPawUzrAl3XJEzyyoJ0D1NckOE+oujV0MnI=;
        b=TZImYcp+bZlBFxSoEHh32vsXY4eu7I9mhgVbqYHIhDqy2NF3n5UXBWBgiZ7G51iZzG
         hjw8li8Y6x1QiY9qgNcn8ysPNuO+3ewOymAin4nrz13TsaADy4Vgb8MC3OhdaIUSV6w6
         Ae/nSEBuh8dY3CCdlNXJdtPvh4DWjRX33M3FrkPu2/8+8uGqbMc3BxRZNWQumns0c7cZ
         kiSfJqP4GsM1stUAT8CA1NaU6Rg78DRaiySpaOg1BWGhDSjDoLXhAKE84xV7gQNYcKu1
         x27B2smHRYx9LlbJrufAsyw69E2whe0ojOp0qNbM4VEgr6T4EwtWA0xDrl2Lv7CYptx7
         gWfg==
X-Forwarded-Encrypted: i=1; AJvYcCWfHOdjv+OO3DjcFTwSpnfDRSot0fzI8+UoanJuHkaFZSy2MNB8sS7VjCZXbhBlyiRSftoDXfOFCg62T7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvDCOsDzUrrNa2wIoPgMkTlXk37DscyLWxNtVGPltVAlTzuu1
	fWUOUswpk/98yrXO3xoS4aJRBc/uCjA3yXBOwMnIEbOpsclU0opIry/DlyFfB2BlLkIrNuphi/g
	7R/q3wdXNC3GayFr44Bj2vzm6qiT35ZQQA+S0hA==
X-Gm-Gg: ASbGncujGxsNGwff3UCY0WvzpQmdfkCIp7qy4Xl84QW4lPdtT4TTnExTHebMeYWbouw
	+XsFOAFeMwZ0cSJ50jo9+UAJYVi0eKQ==
X-Google-Smtp-Source: AGHT+IGzAxOlrmRmaVD/uFJ7prnu9I3o+zsrfRheOQRN2CTC8TTOFFz7x6MNDu8NIaQ/3T2TJdwvHmEkIfffu9SlLQ4=
X-Received: by 2002:ac2:43b7:0:b0:53e:1bc9:7aac with SMTP id
 2adb3069b0e04-53e1bc97b65mr1243440e87.18.1733325258036; Wed, 04 Dec 2024
 07:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-16-arnd@kernel.org>
 <CACRpkdahQhj5u9ATghszi-N2OYhFbvHF_W_eAMDAU+vhmvdrJA@mail.gmail.com> <Z1BpNQjWwxEKFbg0@shell.armlinux.org.uk>
In-Reply-To: <Z1BpNQjWwxEKFbg0@shell.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 16:14:07 +0100
Message-ID: <CACRpkdY-uKYqAR2Sj_cG7dPAtXMFG0Ldka7U13qZSFr+w15WxQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] ARM: mark footbridge as deprecated
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>, 
	Daniel Mack <daniel@zonque.org>, Gregory Clement <gregory.clement@bootlin.com>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, "Jeremy J. Peper" <jeremy@jeremypeper.com>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Ralph Siemsen <ralph.siemsen@linaro.org>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:37=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> > I am booting it occasionally, last time to test my KCFI patches.
> > But admittedly that is only to test it for other SA110 users. I remembe=
r
> > that Christoph had problems consolidating the DMA used in this
> > machine as well so it is standing in the way of useful work.
>
> What problems with DMA? The fact that it uses an offset between
> physical and PCI bus space should be nothing that causes a problem
> for the kernel. As maintainer for Footbridge, I've heard nothing
> about there being any issue.

No issue other than testing and iterating the patches I think.

I was thinking of this patchset to do dma_direct_set_offset():
https://lore.kernel.org/linux-arm-kernel/20200917173229.3311382-3-hch@lst.d=
e/

It seems to have stalled some years ago, but maybe there was
some other reason.

IIRC Christoph was onto me to test it on the NetWinder, but I
couldn't locate a good DMA capable device to test it with.
(Would be the soundblaster but then I needed some userspace...)

Yours,
Linus Walleij

