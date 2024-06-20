Return-Path: <linux-kernel+bounces-223587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48841911529
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C5B1F2200F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D8713D278;
	Thu, 20 Jun 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5auG+h1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC78626C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718920324; cv=none; b=Sz1cXHC8AUdtjWz/MD2b/OpZ6IbtK5j9VoOcttTwvnZlvf0Cw9oZ7BRkBJUhtCDEMdA+Sf87/ZMhV7REQxIHb/CtUnBeP25boEErmDIA4cxlSYWYCkoj1SNPQyhUiYKcESRhQBgl8J13eP7fchHbybVRL4vGtgOZSEOoB9Tlokc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718920324; c=relaxed/simple;
	bh=IDGHQeVi/J99Ud0h98ztO9JyZxnoDSj89IWh+m4Qijg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBbcEmkzcq8ageVBp9oY4pklAlR+hfPtw/PpAmdl7mJOkGNI5F2WGWVVL/hm5wZOouBMON76Sdq5mMbYLD2FSmA0n2xuI94IMSvEEBVHKtjfVsU/LADszPYANvFcorJOG6wo+8RG4cFSyCUqrHQNRQrrvtck0gqSdTyOmFEqk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5auG+h1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso1183034276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718920320; x=1719525120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5TRSOhA8iGH1R60np2uoqVbWEYsCAZsWtQBh11sRns=;
        b=D5auG+h1GKzv+9RcwYa7bi/7IqQ9PufT+M1bZ5jJ2jm25xD1SoHBYNHVt4B2YPfNWG
         W0HJ7bITl0TLbsuGpcL0nb+8+gHnqhYAc6lQ66X8oPIWhbbb5vO/hS+jWwx3UzGWM2FA
         11TzlXpd0h4gTvV0DuxXzYiYbD24/YE4hxV+krecm98YrRlCsbrL9JgvXT16Wt2Qwngo
         98kPBvu17nx+rWyqptx+2UdDOch2+wE80gc56bBdAjHwP/7H7yj/qwPOpTjgdzcPxyce
         m9Nz8gEituRbOP9RWaSI5orXOtD7uba/+3N2Nah6FKRe6rHTOAu7cjMyVs+GcjF6fnVR
         /FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718920320; x=1719525120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5TRSOhA8iGH1R60np2uoqVbWEYsCAZsWtQBh11sRns=;
        b=wpc5eGmZ0+M8fmotojjfMllWQ77E/A+UGZGz7etFCb54beCPpAlEQ5t3BAdqdwweV5
         E4ywdyqa9t7cniiab4lgDOdWv5XDBVecBCwqm+6vlOESdGg3xDx0w1ZppZGMSXk79mfx
         1M8gC6InbWDsvLRIcNdu7zfgJeTD/hbKLWr4eUPjhzwknI+q6c98oCGuTvuvDCWHUCFa
         x8WchyqmQ0F5pnx3o0FQi5bLw7k3mvaOzXQ3C59s5z9mV/4XPr+ZKGOd8Q5CXh262982
         8hCeGBHyxNQgWIA9Y+KExg42IOQ9Q6GqEYgWrcTCVqonAbxwI4zid7TypdUx8rXSmK5F
         hFpw==
X-Forwarded-Encrypted: i=1; AJvYcCVhAQ31K7WqwbJ7aCBA6cLAtG9hdSNu02Msqxzu1l5DXvbQDml+YtUE7wO1rlf79cVI0mA8QEYWhhGARlRDKBtHNkT7u80mNWrTp0B6
X-Gm-Message-State: AOJu0YxsYRm7kFy4r7RPc7pTphw36GdTjDTTxCqnkQZXzFexVSgR2Guv
	1wZm0gqSVmGe+/Oflf4PvZim2er3WDcbk9sKgm0+WuMRkFIzn22efMEIWYxsXKsu91lOBUb4e45
	JQog5+Nl49onYMS9C0epMohViYiVR1J4G94INvA==
X-Google-Smtp-Source: AGHT+IFWhs1oHnCwYtIqEUDb3GYs2ctlTMeXUy+SHit8M9zRZ1POT9JRHWWKif58A0sP7XezyP4BsfWsLr49BttIR4Y=
X-Received: by 2002:a25:800b:0:b0:e02:bc74:522f with SMTP id
 3f1490d57ef6-e02bc7454f5mr5257999276.30.1718920320565; Thu, 20 Jun 2024
 14:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618204523.9563-1-semen.protsenko@linaro.org>
 <20240618204523.9563-8-semen.protsenko@linaro.org> <6e4e78f7-9d94-4c4e-9098-02522dee29a2@kernel.org>
In-Reply-To: <6e4e78f7-9d94-4c4e-9098-02522dee29a2@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 20 Jun 2024 16:51:49 -0500
Message-ID: <CAPLW+4n_x9dBwuSOyAn4fNA61vHPRCSMVzTs3p3Oa94NCOhDFQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: exynos850: Enable TRNG
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anand Moon <linux.amoon@gmail.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:31=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 18/06/2024 22:45, Sam Protsenko wrote:
> > Add True Random Number Generator (TRNG) node to Exynos850 SoC dtsi.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> >   - (no changes)
> >
>
> That's a patch for Samsung soc. I'll take it once binding is accepted.
> If you send any new version of the patchset, please do not include DTS,
> so the crypto maintainer could apply entire set easier.
>

Thanks, Krzysztof! I'm going to send v3 soon, so I'll remove this
patch from the series.

> Best regards,
> Krzysztof
>

