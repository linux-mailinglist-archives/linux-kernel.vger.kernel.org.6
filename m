Return-Path: <linux-kernel+bounces-415966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F469D3E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4AD1F26DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154EF1DE8A7;
	Wed, 20 Nov 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ONzI589g"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67861C4A35
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114611; cv=none; b=J+Yj1ZXepPmlD0icC0NECOzw5D8pfOxLOcNH8ZfZJReFLHl4KKSICUEz8Nt2RCBBetCKPjvwif/C2FN1WlLriepnLRTKFqzwU8m7JUaYAzkFxIcxKPsW/6lY79FmPxDTPs/JFTM2u9bRRKIa5C7WuuzhmcSXPGGvUCJ/tQ1Uj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114611; c=relaxed/simple;
	bh=HFi3iYVf2L2AZYU4Q1oHE4nthfnWHmyGbKDeHcSz6sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzUhNhA1UU5b6H2TH/Ed0MTI5hZC2c4T8DsTNO80hPSejgblUHhHc8+OPaWIcD4WD6mdanNfLdL4HrwDLmSZUU/+qdUhxspG1SFB8s9P8OTEDmLqBpV3hsshIqj16B/mNmce/yK6Z+UupAIJploz0GzcIgKsKGpYrikMQQUvbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ONzI589g; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159c9f617so18684295e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732114608; x=1732719408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WhX7sy9ylH8oB54T8NmaXKVtwnhmbfEVEz1XB5edX8=;
        b=ONzI589ge5HADKWKUKx3ni1XbJQZ0oggiJ4CwSrHcgFeeowkHuAINGp0of0vMJplCP
         ot1iXoCjakEM10mVVfWzOrnyD0CGp1YEC9aJGFmP1DKMxHOEeVjxhJK7WScRToCgIn+z
         Mo13Q0ezxR/4NcGbmPp4gwyFAPe54xX3DhL4B8ZrZlOHWpzLGLWepvLghNwwaW2YRT0O
         oUTPsZ/Ac5zdFFV67o1zhN/9zpa5EbiuvOTsCk1CDEOKWOri6RIkKd/yD05OUr3GY+JR
         tQ9VW1c8UAswil97UqFLrS5NzlO8B1nDw3cJW8d3arfe4a4lORM9pkUKS4udfJlyRAUG
         SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114608; x=1732719408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WhX7sy9ylH8oB54T8NmaXKVtwnhmbfEVEz1XB5edX8=;
        b=Cm7HZK6g+ciWp2wBHhsRt2/60JMGPh4FKNu+p7/i4lAyu/TbksdHiRyiKe3rvyXI5h
         y5NvixNmCcTX7UnZdvLnYBJfQaGUV8JmKtmwD/qUIsLwUggJ6f9n/QUXasyOeJddUfhE
         knudMLXTS2lwWLtzgeZhM++Y4zOs7AHsjyZ8qtEZgDQwtVAs8VrxrDWWyCIfwxWY25mY
         ICbhfabqSRmfF5nT2Fk24f9Ca9hWBBv6jAVxoh4c8UVAlBhPvTztPer5TUtZbYebsD4N
         jNNgZrVNA/7qsRptelhhGu+e8LHmqi5wvVheoMnir1FMf0UkvSzWelNvtR4NwQNbESF9
         AV8w==
X-Forwarded-Encrypted: i=1; AJvYcCUGrP8I5kgJCdjAZ9LRNGoVX4i7psK1m16HkQLOwNv7u20NaDcTkfKi76JaloI0jN9T05qXks2zFwlPyXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGc6fSLugGfSBuqogEIUzhjcHkmhB4z/k9GlOO21UuzNybXaO2
	OrQdZcZuFl0xRG9hJxnzoEwOmuM91XK7R1FsBo/3UXwXfqe0oO4dnd+Q1C9S7s4=
X-Google-Smtp-Source: AGHT+IHrKfGLOGxnCvfbK0rlizot2Xe7bNWUl7+WlgkZB4qaV364sHZfb2rsYw8BE+EFPgwo4ike+Q==
X-Received: by 2002:a05:600c:4f83:b0:431:50fa:89c4 with SMTP id 5b1f17b1804b1-433489868e5mr29893195e9.3.1732114608102;
        Wed, 20 Nov 2024 06:56:48 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ea7fsm2279732f8f.90.2024.11.20.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:56:47 -0800 (PST)
Date: Wed, 20 Nov 2024 15:56:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com, 
	yclu4@nuvoton.com, peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
Message-ID: <klp4a7orsswfvh7s33575glcxhlwql2b7otrpchvucajydihsi@dqdkugwf5ze5>
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xlycwx5h2jmtpvei"
Content-Disposition: inline
In-Reply-To: <20241118082707.8504-4-a0987203069@gmail.com>


--xlycwx5h2jmtpvei
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
MIME-Version: 1.0

Hello,

On Mon, Nov 18, 2024 at 04:27:07PM +0800, Joey Lu wrote:
> +static struct platform_driver nuvoton_dwmac_driver = {
> +	.probe  = nuvoton_gmac_probe,
> +	.remove_new = stmmac_pltfr_remove,

Please use .remove instead of .remove_new.

Thanks
Uwe

--xlycwx5h2jmtpvei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc9+KwACgkQj4D7WH0S
/k7LQgf9Gwj9QyarYndFEA5e8v9OUMxfn6Cu7vJ3gmwOZLcBm0Oi+KHCfrK/5oMe
BYJvIWmrL6AbSFQqaIp38aZmWH2UiKV3KCeRx2kikFou49njcPVyqAKzwpCCi5TE
6XTZpAg/OHN3kJOiLwN4RZVsnsA4pR1VQVIdch+oGFMyKEgyu85MLpjeQecxRCT/
RP/bgKRO/OTWrrtnIewHNV2YsehEzx/+wY9gCh6lEVzBJYDGNNkZf49WdTO5nF1G
KB/pOfKMX4LrldyqelhrRyOOkqDa2mtB5gVdJf5vGP64XwbyxPhzUbblHk/cc5O3
wThAhMtIKX1kBcxmm20loeBenE3nrg==
=CCaY
-----END PGP SIGNATURE-----

--xlycwx5h2jmtpvei--

