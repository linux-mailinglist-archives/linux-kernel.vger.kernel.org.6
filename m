Return-Path: <linux-kernel+bounces-230544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD0917E59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC54DB276F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAE17B4F7;
	Wed, 26 Jun 2024 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHbB149Y"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EE16D335
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398408; cv=none; b=F0Ts1wm7Z3oza3KMjR5H0ySSW+1/MXwKyAuKMDpEIQeGedwXP5la3RDNpcqSm9IAxUy+8hor/zhhIoDd8qGZVWEkqLGa3NUi5BfzseejrKcsPbzW5VINc6pidoHqh7wmzCrLEqARatwMfrZQk1jjOP505HnvzBRlobYUXUK2bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398408; c=relaxed/simple;
	bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lulWLd3wIbGl7o5WtyWK/EikibXVBWTrbqiTVOzh+q+K1EHlN/SHMaROsZQ/DKC5jY3unNFrhCNMJIQrGE5WygPFcQyfR5NJJKlwUZpYmvEwReyW05SFSPmu1X/A83xCkaUhFOOcptNNgmd+vRnkR+uqkn+6Cg0YKwKTh3fhjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHbB149Y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso3864178e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719398405; x=1720003205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
        b=CHbB149YYvQ7hirS3x2iF+a7DrarXRo2d5iyB+wht7QLHKm+HImw/GaB6ZTMwb9c1f
         GsI+MSiU528QPHm/m27BBrXefq6Xd3j42G16ntw0l1L5AUlLmgUD4c9/ohnVIvIbMwM5
         7wspgKLxz4A0hpwHlk2BkqE0X0VWDG3+BgdxNf/89T7tBvOCwkLN7gsxkcCajta8XA2S
         +G1KxHMKbO9LZjh+xA1Tx7xnloWQK/0cUVhsyaPGNyjVkfx9xH3QBqYviY7YPagr83fQ
         Rxc6LcXzpxQXbEvqiUMxNdBbw8V18MjA1wTxGt/95RTWMg0OMQRzigOOlHdx96UJcl3Y
         DH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719398405; x=1720003205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOiuO5Fl6G+i9DWSRv/mCUh3g+3xRS6CNTyybI7Wnk0=;
        b=rrfVCIV6lwxWXNWFTxrNfrBw5OkwLQcjMHOSJJcTU9toBGGZqQ3gtZ0/4bnp8Owwds
         9SDYZDKA1dKOH56pvSdyON1yQbHuZUuo+QM/ttOVrxIjm+kze3ex2+abbUkddYZHByYV
         7A6TOdXK3SRVL7YgxYdHWFw6z4p9eZc5ZhqPz46SCu3Y496koElsq7YMghYISCTYeOU6
         MIdG7YO+m46v2sMgpehEgrgA0WLlrWVUr2fUACgLZUl+OKndMydr4btTkNxk7b2d4sSQ
         9Ka1s3b8C+PkBk+LY6jJpZEC+KlaeRhJHO++q08yjY2jddU8AMhJ2a5ODGTCnvLKlPIS
         7SnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLN/zyDWrApqn4n7OmvE6qPLdhW6dbB+uthTpY971CvwNb9fXmbO3QB/RFBtpfysjD0A9gzXmFh2v8rNYxb3ku6RVYSfOHR+Kglxvh
X-Gm-Message-State: AOJu0YwopOP7vHOOHfAFfiQ5rncuwNXXC4QPETdfoBoYezmLqpe2IG0l
	aefVqJ4Ny9oAw/IgfFc7mUzicLxorYWjH6I4ckUr0QAscjOiWWDjqsgx/xfI9u/bwUo4oqzS2R6
	MoK51jt/6K7hizLxOBotiG0+eLSjZunNf5XGdBg==
X-Google-Smtp-Source: AGHT+IEEDLlgKkyLEHb/F4ksXcKqwRKo5110z2q983p4MDz3/i+AYm+GBB6HLyfL9Ci6xvmQwPbQLu94NT1EQjQELFc=
X-Received: by 2002:a05:6512:110f:b0:52c:df8e:a367 with SMTP id
 2adb3069b0e04-52cf4dafc54mr2880823e87.53.1719398405223; Wed, 26 Jun 2024
 03:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr> <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:39:54 +0200
Message-ID: <CACRpkdYZfNyekcwo35Ccne7VaEhX+Oeg314piZP23piD+yxLWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: supply: ab8500: Clean some error messages
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sre@kernel.org, jic23@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 9:05=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> There is an useless extra comma at the end of some error messages, remove
> them.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

