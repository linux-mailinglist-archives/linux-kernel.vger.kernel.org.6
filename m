Return-Path: <linux-kernel+bounces-224491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A5912311
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42031F231F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19352172BA4;
	Fri, 21 Jun 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUNXR5fC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562C172BA2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968254; cv=none; b=mejdtQAL+DzlxmHzq6NWjsrDPrUSY3qCOsEJNQZ3k7x5qGCexST8vdCHytTiAKl0MmCOYAdYlLKGjjzpXZLyoiBeD+N3orzsbnUbebo0ntDNhBWSrSbJfkcBWtFyi/tklHggx2y+utzfHTef9Q+9xFkt0n2kYaVRyg4ag2NDcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968254; c=relaxed/simple;
	bh=UO4R0l4BQjo+8MN+BiCA8yApkbBY8gcfTFydC4RacbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEbec80N+1RlYY6iPjcuC501smi54pfpDLVrF8wzlgAhja68xnPY20Ulzw0i5tbig2KutMYmHs+ecGPZOAgGprRX9eqWqkaM3GCxGm0rKGhSJU3faI77L8xHs/bhldBaA8N51CO6j50tbp3cmJVxW8TD288alQSdiQhE4X+FjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZUNXR5fC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef64b092cso219269266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718968251; x=1719573051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w03f0OqLX2Nc1ojSG/0rSD+sT2qxP1k7/e2j+VW0z58=;
        b=ZUNXR5fCuHwtQg/Yyqf8cA/Fy5HdEL0eAz8h9+zz6PLf2rFy20pOpLycHC8b+NYDdK
         YsNX0BLKadnd0fYU5OytXvzuisCSZHpViEmXVnbsQqFiK4k3CyLOPDfaILQnQcdUUPRV
         edrU1hiNaMarn7TmxbEtA22lugin553rpK98kZmMAMEcfuuNt6pd0AG8XbI1+79Kp14a
         zZJV45E+0JemdFqlVnwTlAip7uMhWsJAwcPx2fbrVq3q2lxq7dV9TieuXQOZAh+E2StQ
         AKtGAwGb26EoRf5UQCvIA4OpEismSJK7fK5kRO82y4zomXkJ/BFswJNIzpcipKJqp0G2
         Im7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968251; x=1719573051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w03f0OqLX2Nc1ojSG/0rSD+sT2qxP1k7/e2j+VW0z58=;
        b=tlUk0pUSyU/poZV0bL1bhuEcJGHtukEavRcjrd5Yj3tVdiA7c7+PztcsRm7aW9kd+n
         /fVPjl3GEudYEy1WZnq9UcEdnkAtiY6LUDTs7lj0nyzmbxJCNwnyCBM6Dsgz8I7CmDEH
         TglOScs82ND639NHb8j4psVdNKSkuZVkpKXgNIE1mxJz2Dud3RD3tcE+G8W0aex4mkK7
         gDpCHt8+hKlZJvqO7KCoaNyVQaeIohXQC56RAINKxriCghLZ8/ioAp5RKbqkGo2xudvs
         LEJlFBNUPG4W4G7iYJ2jeMj0mno0SgCjKaV76Nz5BeKVI0hhcwfle2+eKg4XXkeavn93
         WNlA==
X-Forwarded-Encrypted: i=1; AJvYcCWW4SUGnrB9D0YGdKJA3Rp1Rms36tzNGYsLn9fjAnQKL+wbT3wZ/hps8ZZhT7iZnQ7EVowlFLocXRbhSVP0DU3+5bxTuFOSAON5rZvY
X-Gm-Message-State: AOJu0YyA+ShZKWQ0hN0flf24kehVsV9+NLSzia6+owVd0dy6aGFj5Qbj
	cCbrDus3ZO1Oix88wg3M5773Mzo7fY/c1rYjuXMPtYkvatZoiFCWNrWOd4aThfE=
X-Google-Smtp-Source: AGHT+IHcLEkm7Cz+ShLlE5gYJpEpEwffjIEmwlmGa57Auxx53cOacxJYtkNzrRppjsAM5b9dOR9RnA==
X-Received: by 2002:a17:907:708:b0:a6f:2ee7:b21a with SMTP id a640c23a62f3a-a6fab7dc5b1mr646727666b.65.1718968250677;
        Fri, 21 Jun 2024 04:10:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56ed53sm72234666b.217.2024.06.21.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:10:49 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:10:22 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Martyn Welch <martyn.welch@gefanuc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Michael Straube <straube.linux@gmail.com>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: vme_user: Validate geoid used for VME window
 address
Message-ID: <9ccf4b68-acd0-465b-a5dd-4aa4569da9ce@suswa.mountain>
References: <20240621104246.11292-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621104246.11292-1-amishin@t-argos.ru>

On Fri, Jun 21, 2024 at 01:42:46PM +0300, Aleksandr Mishin wrote:
> In tsi148_crcsr_init() value of vme_base used as 3rd parameter in
> tsi148_master_set() call is calculated as 'vstat * 0x80000'. vstat value
> can be set from module parameter "geoid" which can be any. In this case
> the value of an arithmetic expression 'vstat * 0x80000' is a subject to
> overflow because its operands are not cast to a larger data type before
> performing arithmetic.
> 
> Add geoid validation to prevent overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index 2ec9c2904404..b601d2b20bed 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -2119,7 +2119,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
>  		slot = ioread32be(bridge->base + TSI148_LCSR_VSTAT);
>  		slot = slot & TSI148_LCSR_VSTAT_GA_M;
>  	} else {
> -		slot = geoid;
> +		slot = geoid & TSI148_LCSR_VSTAT_GA_M;

geoid is a module parameter.  It would be better to add some validation
to the probe() function instead of working around invalid values here.

regards,
dan carpenter


