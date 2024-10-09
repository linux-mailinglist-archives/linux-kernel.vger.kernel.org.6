Return-Path: <linux-kernel+bounces-357415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3765997108
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94627286E8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9D1A0BDC;
	Wed,  9 Oct 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKMKmxAx"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9757E765
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489753; cv=none; b=Z9HrM4RFh5cdBymXYt5a3jKWBPwLwonkKHlqFGcJw6t5HRk/SmaNMw3khMR1VK6DPRy6fi0IWiYWilpoo9V23hRF3aKq634z/SHta6sxD+avAgjMYmF/SHtVxMjUHQzzkxLiJNddsWVsCtzN0eOlAnFIuJm4CyL+RlpnYBLBBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489753; c=relaxed/simple;
	bh=UqtePFxmQBmzsO5YsdCeQzk39Y53zC74QvUKUFf9xso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBr7gprvW+US9cWd8A+tFBoOjAcOX++vrQZFClhOQLrg2dLQa+2JkI4Rn5Aq+wiTqVz4nfuGrO3uNSa1MiA64eT2X4SraLBsm6n0pcfZ9FurewTvGN/2ttJbQ2lCcHjNJIMl9hwnRdOPZZMO+UgXoTJrsYV57R+yeZ6nr/vAtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKMKmxAx; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso1018756276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489751; x=1729094551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOnZ3s7FurB42eYosuD//ONdW4vPSEKiKv4IH0gVfdA=;
        b=WKMKmxAxQXkonjIEeClSmHmLMh97TE6nPHTBlHHDkylrbeYi4RhGMG8cD/msacg3aJ
         +pW7sb79uyMnYWJenp2Cx2v8QGu+rynxLYkKhb3RfKZGykbwPiQPt9G9pxF1QE7NY4Xg
         68/3g38MkRZnkmGAleeiOxgrIc+y64Zo6dX0fLXwCZmikehNLPmMhBhnLmZQIe/Umdff
         uBHMaCsSRFeC/0y8ZXke2idEk0P07o++iNokbenmSATzRGwMQrayOOtkTqbwOXH2eHYz
         1/dx6sgGPHoz2sDnBmfvRRE4sZrEvSNxmL+8Sf10OvKCRCqP3PnaIGrADC6j7mX4djUy
         fahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489751; x=1729094551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOnZ3s7FurB42eYosuD//ONdW4vPSEKiKv4IH0gVfdA=;
        b=W5p0QXr96SOPNkItRM3w5SDmKVXZdtd5UDTjJxMzcLpRUum6IxmvVimdTrGejzgLzg
         QX/feG/wkCNB2oD2oiMCOUXOU7DXc2YgnylNa3IWNFOHdW8WYYN7nHDpQjVsIsBeh5i2
         NxT+hvSIk3FNkxHfFk7bZXWj81tqxNtKZvGnZhoZqLtEF+f2IGvFPEY7wJ9XQVb3cMI0
         GowjDYUuRMu+BAm1ymyMMV/HEguABD8nAPANf2G8lwgliPgdqs+4Ujnq5pEvmJjPYJSx
         YHPivHwyioG8/J921QWaghv84dTeGQ5Dp/1SPSIxLN9m/05G2u4LDXIAnmfPF31sv6Cd
         i0aA==
X-Gm-Message-State: AOJu0YxCWma7HDKqojP/sGQdPXmc1d8Wx3kmkqrHfslWUjzabyPG9ThO
	5DQfAF2JJP6Kk9+iRa1bSqPBIXl8yisVNkyOyvsUm3grLwJ5V0uAjO5HwAswsZAjbX73jE8+c2a
	Z2hjYAlyG/Z23YRlFQCcv8hVPrGR4hUwzI5wCXUh/y57srNd4
X-Google-Smtp-Source: AGHT+IGwbvhINlaQ69+Ou+iAJ+7gcTu80rat6BegoMljwfg9x3T5XWppUQWyTfekV843Gnm8+DX26ZPueuTQNzjtQvw=
X-Received: by 2002:a05:6902:2503:b0:e25:dace:d4a4 with SMTP id
 3f1490d57ef6-e28fe4e7350mr2488952276.36.1728489750634; Wed, 09 Oct 2024
 09:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008161334.483211e9@canb.auug.org.au>
In-Reply-To: <20241008161334.483211e9@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 9 Oct 2024 18:02:16 +0200
Message-ID: <CACRpkdbcbnFLb3e57QxxnOqt+xxcYD2LCFORSZ50ozLoVPrwpA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:13=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/pinctrl/pinctrl-aw9523.c: In function 'aw9523_probe':
> drivers/pinctrl/pinctrl-aw9523.c:988:17: error: label 'err_disable_vregs'=
 used but not defined
>   988 |                 goto err_disable_vregs;
>       |                 ^~~~
>
> Caused by commit
>
>   8498e6b2b852 ("Merge branch 'devel' into for-next")

Okay I fixed it with an "evil merge", I better pull in the next rc
to get a proper resolution in my tree, I think.

Thanks Stephen!

Yours,
Linus Wallej

