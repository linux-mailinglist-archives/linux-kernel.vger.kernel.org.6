Return-Path: <linux-kernel+bounces-429605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6149E2709
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60CDB62788
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2D1F4716;
	Tue,  3 Dec 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fl+HyxFY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6941EE006
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234268; cv=none; b=Gj69PyHohky7/9vLlARYVzsGZFTapNZgCip2UWLWRubhOIMCGjSotZNShqnceo2wuhfPM1dwDecaG+Aizkgy0UNfRciAB5fH2CJtNoKQlVmFTJ+Baat2UEwSkecisAvzqcd9qzfJWsUlOIelBWKG+Kcgh98YBUipr04QRDeRjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234268; c=relaxed/simple;
	bh=rYvvBdg8fi4Xr/3R+nVFs7fW312NlcNLWvE6GK67uZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MynMegf+wnM7amjF258RCGrNY/bgP9qQdwtd/Ef/VmO48MTi0YZbplwtyTlbOI9C1pvyi+z+0aovWPu1YTRhYwBC5eqT95aLiAEta+PICkhBo9RWn0yhPQsRQCE5A7MD2OU3ssjm+qN5CNiIEHgmGu6Dnjul9oPwV0KQhkUeR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fl+HyxFY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so57038681fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733234265; x=1733839065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vma/aVgOijobBlFAdjamC8x1tA3Lu2jI5+iEG7pb/Rs=;
        b=Fl+HyxFYW+x4I5aqYjjuCRfwZjrlx5AD52TR86fq15vcJGuthMvY0T5nbjIxdgek32
         xqQXEEOi9YZte0gnhnDQGK7EUPruhor8bp4WZpX3+3Ib5bDTo9s7jC1xmnN5eQr2QPlq
         bNZeCdmTyJKycEofHFFGuqnN2XcmTrVKGZq8kf7lTZYpsfCPKt/LdOx1sgjri/QsyirK
         Z+R7NFqjgNoBFUDRJV8tb13T8z2ignlBD2r4FytBTiHTpjgcFfGKytV75jweJ3+Hq0T5
         3ZlGFx0f5R7RiJskcxFrIFeAJQnpniQpgBPl3bUdrzXcFdzzYmpsiYwFi1LPa1bPIA3j
         lEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234265; x=1733839065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vma/aVgOijobBlFAdjamC8x1tA3Lu2jI5+iEG7pb/Rs=;
        b=t07xINaMFFdqYa9o6CGOIYX8l3ShOf4Y7bV+bhf3IF4loq1+l2kfP4m8Jx7z90iRQn
         EcUB0Kaxx9VKtJam+r7iGTCPfJWLUFtgksjiLN1IJlbutx9yt2fsAsen7bKqFCBSxs+S
         coqTpjPX4FRi7gldiObNFfNBk4rekDzhRNQs0ATM4Cscbo0gCI43WlBHF3bZQ88ucfYa
         LCNem/mT165SDMCbv0pxjvcaKowpdneeSLJza/E7ysnLr/L6m6CMHe88m14gAPtFgHP6
         qtnm7mbCAv6Y39h8HX0FIRNsZlmYg0GLYHW9QBO2maWamAhFL0eqNOll36so67BcuHAd
         lw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU8Yrlv5TDpol747ox19+CY2c7vl8MrO5o0sMg46wFq9Y2eeiUntzCpbUJiUSHKFwyVaRm4O4+FMrcOKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTXdBR4VqecLFz1epu9gEPS45o7vff8C8CPr4sofIJ/qWjSr1
	TDKzs1jKi0C0wgfyI1meQEdkGLSRsD4gEcUYO4OxDWjiBOsj96lt2bPmxR3Ry7U=
X-Gm-Gg: ASbGncs7+jnLR2Why3R25R/4r9aWyAOFVyB+gGYbsYWpQywdnALY3oq57JAwbB0P7jF
	LlDHPekVGrJo/8/fdbyFZVtnrgu0m2rGDaQIe5CWLpwmTIDkt6AUpw+ry2bJr+10vsgZLxnJUNV
	+u1p+DYLovRpnwuB0IDzKLnEhp9XIvdWb5SuhFdzHiGc5bf8I5QQdTCvNA8DuiLlDti4FC3MwvJ
	BYzgezFR59qpF/CCEDTlfrC2SSahed7tTzhg4XTfKCzu+FJWLdZeNbKcNbhv9rVKjazTF3swGrY
	mkPSHnmR2RzNyFaxpt0IMg0AMH7ntA==
X-Google-Smtp-Source: AGHT+IEWu4ApKaC7Ta4KrqQTWekPko59agvuRUFXVxJooAszNQZ064G9g5fn/NzI3dsNUT1RD2yGnA==
X-Received: by 2002:a05:6512:3b2c:b0:53d:ef6a:17f4 with SMTP id 2adb3069b0e04-53e129cc3d9mr1370082e87.1.1733234265135;
        Tue, 03 Dec 2024 05:57:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64432b8sm1845404e87.90.2024.12.03.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:57:43 -0800 (PST)
Date: Tue, 3 Dec 2024 15:57:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: rpmpd: Fix comment for SM6375
Message-ID: <rcoo6p56lowzbkgci5umhg3xd2hnp6ledk74ys3hw2t2il22nw@bcbs4zmcbzgn>
References: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>
 <yo5cc3cvvwwdrqrrgwlquztj52sijip3ffyyqag55jrnztxi2m@hn75ylkhnxie>
 <D61WIF2XWKL8.MWU6PK2XGX4F@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D61WIF2XWKL8.MWU6PK2XGX4F@fairphone.com>

On Tue, Dec 03, 2024 at 08:52:59AM +0100, Luca Weiss wrote:
> On Mon Dec 2, 2024 at 9:00 PM CET, Dmitry Baryshkov wrote:
> > On Mon, Dec 02, 2024 at 04:45:02PM +0100, Luca Weiss wrote:
> > > During an earlier commit, the comment from SM6350 was copied without
> > > modifying. Adjust the comment to reflect the defines.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >
> > Fixes tag, please.
> 
> I thought for just a comment fix it's not necessary / desired.
> 
> Anyways:
> 
> Fixes: 2d48e6ea3080 ("dt-bindings: power: rpmpd: Add SM6375 power domains")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

