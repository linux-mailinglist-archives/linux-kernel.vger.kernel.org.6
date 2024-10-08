Return-Path: <linux-kernel+bounces-355753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0B99568A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFA2866C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331B212D34;
	Tue,  8 Oct 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfWrTHoM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6F212644
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412099; cv=none; b=uXLyWwPEvL7R2eL7AML+KABOXV1JU8suJ3v/xpqriI4VLuGnA+ec9+dW17V9d7RpIyWuI6uPtqOFq/thAoQ36iw4fjo54hc2bDzjy30OpMAcOGDekUNVdXDcfLADYPJ5cVQg8VaSSlOHUKCZrUVOeE4Sb3RNGyV02peSYMLbojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412099; c=relaxed/simple;
	bh=KRIMSaQJxsJnrkquxy6hhD3S/qPAyWsH44gpf2J/73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUY/FqtW5d/BR3rqyMGEovXvSrt9zd+yez31E3n+igzIIFKYT/yeWfRyS125xEy9TO6pGHbPP1n8Aqv37iAMh8jtkJbadJd5n3A+AfYmM6HSBxkDwz6+9L7jOGhix+U28k/uzIkQDapDKGQyxp1FuzWyqCS8YHeaHG1Cw4rJRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfWrTHoM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-430576ff251so4791255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728412096; x=1729016896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj4U5NZezle5klngEkutB57b0MoLORIo7RbzeKMhINk=;
        b=cfWrTHoMgyQleQgKBDSITavn2krx/9iImZENtnOLbvISt+U/EcDA5zod9AXfNFGwXL
         Eq66dFMV7VbHNKuSG4an/R8gEN54nBgD2FyPo8QF8puHrwB0xaq5jplhdq+KVZJdth11
         Qz+jX2qC9rtFjoWjAkv/PTa0RXYZaBrd/HyRRGUvYgvCvPZOxygvZ+qOD02db9UExUU0
         qzKyL5VO27u/O/Ge+BrpDSPvXI3OyD9ZfyepS0GeEqcELjU2vAdGpUdx19p2JEXTOupf
         APzI8+CAX1aSIw+ggQG6OVZMBPa7E+UZOvjjP4DM/lac5JGnEkFD3MNE+WROYVwvBleu
         7EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412096; x=1729016896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj4U5NZezle5klngEkutB57b0MoLORIo7RbzeKMhINk=;
        b=Tg6gH5ZzsQHQoilKxt461qmejpjHuMPKeoqtwwkG3X80TV3YgSq3mzj1mi3MJrme03
         59kf3//A05XSmlUGvV4YycW4SBakdmNgfzQfs5XxeHk7qZTiadA6jAsHF2KL3HBdc12u
         wRsIccqMSlJryu7GPhgWOO+RTaRVrqu6EhvM6GhukHF2WF2f+4sxupfnhqKes/vbfQ31
         Iymbnm89Q+4Y4oLd7pj9H3W1ho1eiXwgVmfGI+8Kcg4NrZaGpvo/K7zY2H2gg3LWPePD
         97KpOJ7v8Jehod1SJFqlEC4n3OoQitTzrCksnMNXCSZVsIKBVlWX09mwmgXAbDBTYT2m
         jTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUebheK6XovXFng35BetGP65dzIg7TAQzEJdFDaqS0Xh6a274evPlY3Zv2+/4ggEzBgMoRcF1F1klDzDRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmwG1JuqPP7wgL9dDF4HlVxrRl0sMmY8GqZtI1G73N7yK4eHN
	KblKJQFtGGmefevArreIR1/URw0BwdxnU2H+TZ6/i8nQo1CI4vUHuPCKIdVGm8M=
X-Google-Smtp-Source: AGHT+IF28xrCjVDMGy24eCmaDxnDHGfA069+feSTET3yVX4pIr2vsTYPGgc9aCT6y84BOEZg8lwf4Q==
X-Received: by 2002:a05:6000:400b:b0:378:89be:1825 with SMTP id ffacd0b85a97d-37d0e8f4bcemr11804315f8f.49.1728412096232;
        Tue, 08 Oct 2024 11:28:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b725sm8578482f8f.46.2024.10.08.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:28:15 -0700 (PDT)
Date: Tue, 8 Oct 2024 21:28:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jack Yu <jack.yu@realtek.com>, linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of values
 into uninitialized variable ret
Message-ID: <84edfcd4-02f3-4cd0-90d8-eb5f3cdabec5@stanley.mountain>
References: <20241008164707.203792-1-colin.i.king@gmail.com>
 <ZwVmCNAVSOgqT6Qd@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVmCNAVSOgqT6Qd@finisterre.sirena.org.uk>

On Tue, Oct 08, 2024 at 06:04:08PM +0100, Mark Brown wrote:
> On Tue, Oct 08, 2024 at 05:47:07PM +0100, Colin Ian King wrote:
> > There are a handful of bit-wise or'ing of values into the uninitialized
> > variable ret resulting in garbage results. Fix this by ininitializing
> > ret to zero.
> 
> I'm very disappinted in the compiler for not noticing this :(

We disabled GCC's uninitialized variable check years ago before we enabled
-Werror.  Clang does catch this.

  CC      sound/soc/codecs/rt-sdw-common.o
sound/soc/codecs/rt-sdw-common.c:119:3: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
                ret |= SND_JACK_BTN_2;
                ^~~
sound/soc/codecs/rt-sdw-common.c:111:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0

regards,
dan carpenter


