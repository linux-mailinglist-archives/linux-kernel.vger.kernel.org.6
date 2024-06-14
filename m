Return-Path: <linux-kernel+bounces-214429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CED90844B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9241F2438A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE6149C4B;
	Fri, 14 Jun 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VtUqZoPz"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18010146A90
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349508; cv=none; b=iihepbripxrR9qF6teHptLB91/RGs9NV3mHGrFkHX7rWQb16TpnYFBPFsNEJRA/jm4eQWZUKF/ofT7X3JvrXSNMyxAuDMHU+NujOiVK3HRJNxViT8xind4+AIfJbjZItmyrcSIQ3KBwl2kYZg1/naUb9G6jXOFpCg/TG+TndprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349508; c=relaxed/simple;
	bh=wqLPYteu3ayqHey69yCKfVVfVBHj/xWhI8yDdx19SLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1T6Uu5yirbvgk4M0NSXWcMJ9TYCW/MAsOsA5qtQJyMEklLeGKZ5XWJhUWwK+OOIgPZbq5Q56PNMsftHaOP7vvzRkio32VttD23eBhlJyfcyknahYYzo7fsY+Cvc8MMoWaZIYomiB0NiNDRqU2/8iQIC0YqNWP6rR/0Sz/YLDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VtUqZoPz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso21118041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718349505; x=1718954305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqLPYteu3ayqHey69yCKfVVfVBHj/xWhI8yDdx19SLE=;
        b=VtUqZoPz1UsOwgW8eYU0udIbjZpUtAcB2DEjl7VEQodjFhu7/wvvGpbvI6G8A5XEwr
         xWh4T1w8haEgMcE3QAbHDUoSaGDvsH848MTnEIX/HioQTbJILLFrOY11MzBJFSKJfYSM
         X4wBsKLYUQKgx9KDfvkJfXV35a0ZDqWwYbTS7Ea/KsEqTHHvWo7xjX8gKn+zYmVJyd8T
         vvpK967izvdPAj/k75XtlZxgoNUOfAVBKTRvSFf2vpyhChn9oVchYGGuspqQHy1RdXdg
         aCDtGhHr4OUJitR7e3Ei5IpWhwIYvNqutHPGh/nITec4ESfyGzymfnsPS7t9/Lw0IT5R
         c/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718349505; x=1718954305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqLPYteu3ayqHey69yCKfVVfVBHj/xWhI8yDdx19SLE=;
        b=nM5k1XFgb8NiO/V6vmZh51zZzosRl3zBKrXVTcze+LIxC9PbSEqn84eXxHAcF5t3Db
         e1PKU0ewDxnt7sbfUddsbbW6QKpCGNAnMVtCNw/BAnTrQPBc4T0aDgnZ1eLCUARPWK4r
         mafGLfH6vN1kgtPrPxxL354Z+gPatbm0Yl1Uyc4dRWCLNrxJ+9hsrvIXlYX3GRX4HXak
         fWlNs1qpoZlGm1apAEhmu60WE8awawjvQTVyGN6TuNdKoN9uPapsJqtk6RgmyrR4a3z9
         w3t15AZ48lUSuf0kH4dePXZNazo6yfDgo7V/sdIZEALiF8XQLcBXQ8oTNUHMG9PSTHB5
         pfTA==
X-Forwarded-Encrypted: i=1; AJvYcCX01C+kRSWKoDUVK0lXn8uFo/e8Yjza7cPnmjdIWP+FHa1o0KVUPnZR3ZZNNw1QaeiYZKSGJxsWUUrz9FMTRlyNgu9/OEiiC7iKC+yg
X-Gm-Message-State: AOJu0YwGDvnuQCBhFC1HQQKlzwlG6PA5uQ/1x/R2cAMDAVvfXhhppLmV
	mwqur62APBTf8YSCixvFPcrhKIxXhu9jTTSu4DFhJtHtk9mW48FiQTTTXRgHAULKdLYmblwdN+y
	7FUM46Z/WDkHn9a4pk0Ki40cagTYJ1Lj17/lHqw==
X-Google-Smtp-Source: AGHT+IEqAc/IITHR5XH5IcyBzMofjdG67Sdge1uWmTB4/BihRUG9JruUjf29s0w2MnX3meX/UPaZVWsbSfUHTarWmeA=
X-Received: by 2002:a2e:8886:0:b0:2ec:492:3fee with SMTP id
 38308e7fff4ca-2ec0e47c209mr11243421fa.30.1718349505123; Fri, 14 Jun 2024
 00:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605122106.23818-1-brgl@bgdev.pl> <20240605122106.23818-2-brgl@bgdev.pl>
 <87h6e6qjuh.fsf@kernel.org> <CAMRc=MdiKxtnN+g92RUTXdOydaPV5M2u5iUdKyE2SNvDkdXAjg@mail.gmail.com>
 <871q5aqiei.fsf@kernel.org> <CAMRc=McacZMP-51hjH+d8=PVe+Wgw4a8xWcv0sRPLJKL_gP=KQ@mail.gmail.com>
 <87sexqoxm9.fsf@kernel.org> <CAMRc=McYAbhL5M1geYtf8LbgJG5x_+ZUFKXRuo7Vff_8ssNoUA@mail.gmail.com>
 <8db01c97-1cb2-4a86-abff-55176449e264@kernel.org> <CAMRc=Mer2HpuBLGiabNtSgSRduzrrtT1AtGoDXeHgYqavWXdrA@mail.gmail.com>
 <87ikyenx5c.fsf@kernel.org> <CAMRc=MdPQu-r4aaeag9apYP1-FoQ2-_GAk_qnHqDz-jWibRDFQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdPQu-r4aaeag9apYP1-FoQ2-_GAk_qnHqDz-jWibRDFQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Jun 2024 09:18:14 +0200
Message-ID: <CAMRc=Mfsqnfy-Q++QyZNmsYoV72hUoNFEDCW6KZ0H_MEHEe5Rw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k: describe
 the ath11k on QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Jun 12, 2024 at 2:49=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wro=
te:
> >
> > Bartosz Golaszewski <brgl@bgdev.pl> writes:
> >
> > >> >> Sure, I don't need DT but that's not my point. My point is why re=
quire
> > >> >> these supplies for _all_ devices having PCI id 17cb:1101 (ie. QCA=
6390)
> > >> >> then clearly there are such devices which don't need it? To me th=
at's
> > >> >> bad design and, if I'm understanding correctly, prevents use of
> > >> >> qcom,ath11k-calibration-variant property. To me having the suppli=
es
> > >> >> optional in DT is more approriate.
> > >> >>
> > >> >
> > >> > We require them because *they are physically there*.
> > >>
> > >> I understand that for all known DT QCA6390 hardware, the supplies sh=
ould
> > >> be provided thus they should be required. If in the future we have
> > >> different design or we represent some pluggable PCI card, then:
> > >> 1. Probably that PCI card does not need power sequencing, thus no DT
> > >> description,
> > >> 2. If still needs power sequencing, you can always amend bindings an=
d
> > >> un-require the supplies.
> > >>
> > >>
> > >> Best regards,
> > >> Krzysztof
> > >>
> > >
> > > Kalle, does the above answer your questions? Are these bindings good =
to go?
> >
> > To me most important is that we are on the same page that in some cases
> > (eg. with M.2 boards) the supplies can be optional and we can update th=
e
> > bindings doc once such need arises (but we don't make any changes right
> > now). Based on point 2 from Krzysztof I think we all agree, right?
> >
> > Just making sure: if we later change the supplies optional does that
> > create any problems with backwards compatibility? It's important that
> > updates go smoothly.
>
> No, you can always relax the requirements alright. It's only when you
> make them more strict that you'll run into backward compatibility
> issues.
>
> Bart

Kalle,

Is that ok with you? Can we get that queued to avoid the new
check_dtbs warnings in next when the DTS changes land?

Bart

