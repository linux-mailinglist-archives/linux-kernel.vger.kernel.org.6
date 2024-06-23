Return-Path: <linux-kernel+bounces-226446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED681913E72
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64FC280E85
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00718509C;
	Sun, 23 Jun 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6OytJCs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D2181BA2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719177361; cv=none; b=thkz7T56N9ZNN/YBx0d/1JWvqq6WVnLYzE5ufYjxUV9x+g87voP6ASByTwPYq9y+yVZDELwMonW8QOctxLxpmpb1nAJ1T51PanG3fMHV9fEoftIefAnx/ZAZUdZbNoeNCniH1RHEZQWoE1GukBj6CMTh3DnVlwRMTHPjnRpezR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719177361; c=relaxed/simple;
	bh=3Kc4F7ivhPrRmEzH14G9M7kQbUWv/PFz/3aeP0kdkEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PknQjNGZ5cduOo/OZuLLsG8ppm7BxGFGqkBDAh+KbmW54XI+Mp3hy1gnBVHzNvcaKYV/h8FspLT6Q7YYRew2izTwgwKJAXCkiZxLh4PVbmjeBPmKZAkhT+uKQ8YRhyVOz+wFKtytd8/WI9WSsm3EtU5Vq2c10yK5HPdOVVs/308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6OytJCs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so1675638e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719177358; x=1719782158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=npqBqrsZNAIwVwMzRpL1TmQcfMoNbDQggbKHwWlSbcg=;
        b=P6OytJCs6JoJWBoR6KGseTwnU0E+aDpxiNs0dcCEwXVN8ypNi+2896OdmCcvuOM3qB
         rk6vrvg9MVH0mHcpLcFBCqtqHFu5xidtQHTyJiaUZ1eMh46vDYnFXiei/O+RhCMTnGvs
         2WkoUHOVQ/DWbcxaBx1fKkahURn+PpDJeDuhe1GTNlIaqXvy0sFiK+I8EMgOGkbxGXh5
         Dqk9S9LP4vdzCl/FcHBZx/ERcF4JEojkBfKT9C/V/4hSLEufvh8ASYPKt7CeFFHAoOCu
         AyiK/Txd4y1TMZEifgiB1kEssV5J7eVvoU+haN9tqHa61fqctV5GCFvJx5Mml8Dytc0Q
         NsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719177358; x=1719782158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npqBqrsZNAIwVwMzRpL1TmQcfMoNbDQggbKHwWlSbcg=;
        b=U8rgdDSq3TclgCpQMrrPOT+tGm48E0HbWtC9ftyfVlXkhnsEy4AejG56jZxDrMfWcL
         iJT9MY2UvZRNK4juwFoL2CPkJr5vsdEwEm1rTp1jkhOn60ephgvOo9B+nJn+uaFf0Qjq
         xwAwF9M6B2bfO9Dyn4AoPAq+LAvKDaPy4A+F+PVyLpHev/IzKEY04KN3Lz2PS3iTyZk5
         7h+sfR5Y3SW5/N7UyjT5i7QCKgpeZssVCAhWUKIpb3drQyD5wp1Y4CXtnvLZoWYBqpuc
         P6xaTjZAZeWly3TNFOD5Gwv/ApXOy1E4NdnDPAXxgzZXFSJ1JMJO7iajwMy0Wu5/IksF
         ThZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXJigg8yuaioJ03kvvzew6xFzhYrYC6vypNA04EnetqacFQ+RQi1KKaS/farIUBsDKUhb1YtqEj0Sz9SKy78yjARHNg498iKD6NaIl
X-Gm-Message-State: AOJu0YxoyhcIIsuOyPwz1dU3NDRcHlkgB4RSc0bf/hxwuukefGgWEmRn
	atE0rQwBTHwDJvW6N5o4Mva0osBXWqfuAcG9QiC1sjYvGvxFec4j8zx/kdkgagA=
X-Google-Smtp-Source: AGHT+IH5kNGocu2dFm65gFsoVZhigJ6nemG+so7J1Pq+CT/tsTHpWdQ8xhhme3ais5shulJS0U/Jrw==
X-Received: by 2002:a05:6512:4004:b0:52c:dfe1:44ea with SMTP id 2adb3069b0e04-52ce0610526mr2776983e87.6.1719177357863;
        Sun, 23 Jun 2024 14:15:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce98c1a27sm3079e87.253.2024.06.23.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:15:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 00:15:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Daniil Titov <daniilt971@gmail.com>
Subject: Re: [PATCH 2/4] drm/msm/mdp5: Add MDP5 configuration for MSM8937
Message-ID: <l276ykxey3qvct7rwkngyby4ohy3bl5cl77ldvo6zqco57d6xn@4mkwdabfabtf>
References: <20240623-dsi-v1-0-4ab560eb5bd9@gmail.com>
 <20240623-dsi-v1-2-4ab560eb5bd9@gmail.com>
 <hzslz54iq5sjmfhcbuj3my7cbjsu73acxeelih3jekr6rznz44@qie4c4w5lt2d>
 <CAGsSOWUDbvUMW95Xnjrg4z7TJ9=tj7_KHyek3xTuzbDP2_VhHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsSOWUDbvUMW95Xnjrg4z7TJ9=tj7_KHyek3xTuzbDP2_VhHw@mail.gmail.com>

On Sun, Jun 23, 2024 at 12:48:53PM GMT, Barnabás Czémán wrote:
> On Sun, Jun 23, 2024 at 7:59 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Sun, Jun 23, 2024 at 01:25:52AM GMT, Barnabás Czémán wrote:
> > > From: Daniil Titov <daniilt971@gmail.com>
> > >
> > > Add the mdp5_cfg_hw entry for MDP5 version v1.14 found on msm8937.
> > >
> > > Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> > > Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 89 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > > index c5179e4c393c..6413c0d3e237 100644
> > > --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > > +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> > > @@ -1011,6 +1011,94 @@ static const struct mdp5_cfg_hw msm8917_config = {
> > >       .max_clk = 320000000,
> > >  };
> > >
> > > +static const struct mdp5_cfg_hw msm8937_config = {
> > > +     .name = "msm8937",
> > > +     .mdp = {
> > > +             .count = 1,
> > > +             .caps = MDP_CAP_CDM |
> > > +                     MDP_CAP_SRC_SPLIT,
> >
> > Could you please point out the SRC_SPLIT reference?
> Is this would be qcom,mdss-has-source-split in downstream, because if

Yes, IIRC.

> it is i think it is a mistake and it is wrong at msm8953 also.

Please send a fix.

> >
> > Other than that LGTM
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

