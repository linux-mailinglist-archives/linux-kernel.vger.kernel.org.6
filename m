Return-Path: <linux-kernel+bounces-422288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FB9D9727
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6554B250B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537E1CFEA4;
	Tue, 26 Nov 2024 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMZhZaIz"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72C1CBE8C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623479; cv=none; b=jlRV1co5kXfZt5V2+zqDvOcZB4UpjBt55bYmlRMxKJqaw2oOxXB42ZY07vxjWIRlJwux5ilib2ZJwGSFCGn5Sb/h7jiv1nhX18I6CLIOuFWpe5P19fZ0jzXfe142RVAwh0tlIUSWfIvKha/j2JY0xPhAjZojBu/gSbp3UYp9/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623479; c=relaxed/simple;
	bh=A6FseKMXYrE/gymKDoYli8XDXiRXwIQNGUcDMIEhP+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL40Hlzm2vJivwTCM7FbahXEOMfsppiX5rEyrDoKoNP3hZTqbAsxlgad3g34E5quq5ii5ABOMFaHPkcm9qUkASjEDkJGMv54GfvGNvwkPHy/i2GAB585z55SrMrCiUHkVTzG42CIYlO1GUxFALHGslEopyTtOE+rOwSVZ8KH5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oMZhZaIz; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de79c2be4so1640086e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732623476; x=1733228276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIiJZ55i8NdMGDjfrOdk3DfZs/tLxD9oconoLO+oq+A=;
        b=oMZhZaIzWkPtIelMC3oIlDlHY4MO54NHfOp2+JKR/P9y0xxTVoq+dg77cVwqDIpKCr
         Zb2Ujjk2AxNe/Y13pbmW0U9CxU9Ipr4KRlZ/b5+B9T5kY4oz+CKXllWJgy77AGxJwhTl
         c2BZsA9WA43J3yEKdvYVW11FruSTdjjSJbl712MxMcl5ch09nEQtl9AbGKtKpo6HnRJa
         eHQrB1VPBjUnaYL36S7N7E1F5pNNTsGLxjy/h+ri5DoiAhvoRCpaKCwV6rSE8y/ruWKo
         SBHSum0SwTgchsu7OR7XmNirzR8CkSawIdMBCaQQJaOTS30Q1oPR30AmRq7ZJM54n5F2
         tONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732623476; x=1733228276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIiJZ55i8NdMGDjfrOdk3DfZs/tLxD9oconoLO+oq+A=;
        b=UakxYxJKBz1oZotP1v0bKz5yPJttCRG/OjKmct7r39fYCd1G8HYb8VEcCNLdC0iQp6
         J3ZpyEzv6yb4cEQ20dkgB4g/tz20nfV7ECi0yCJU2qBAJEHVgmo8WRKrJeNtGtJ7jg/3
         f8qt0Ba7sdO0WWb5Q03j1Aa6d+yw7lDyLyze/VRODBL98ywltbRXFILvE9BkJUVtKaOC
         6cGK6CWGXSd9Pna0R+yN2v9a9CmNUNYby/jC67yT/7z17I8/eaCpdYKQkqQft3H9/yGn
         Vr/rQ+6MxMe0/riz2mrADGiujBaXHWcayc57DEe0eFUEMzxNXu0M1RnThYXZJ2XI0Qr+
         oT7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSaLxHimYlPm3oUYnjDiX08W1qHtfPvFKQo/OiwVDywQVzY8hKhADXvQu2rPCgYOc4UbQmRUTyfnyAjXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRZsXmjpTMRbXKfwQ2GPiotEqqeaznOzxamcaoALWQzgl5sqF
	qDyCI7ajvKH2tvn0YnX9XTq/GlXPa3TCQVdJLR3ZuI472VS3VC/72dSpTYBSVwc/Ed+qwo8Hv+/
	c
X-Gm-Gg: ASbGncvnR0tuJHwCMNIXRk2rwEUmKMYVv+PIvxHAtws5uVyD1BjGWPzYN18nAuqmOjF
	/G2wx9SxnX9m+3rZ2MIG1XOwBmz+6kbyy9COQh9DnyIc5sgUNOavxRCSJDB6K/Y6PnRs7s/fbm8
	3R2nS2PiCuwHYWGI8mGxXmbm0Om8xtSIs5NkJyg/DHk3sn1fRzSVq0yOpQmrHlav8PjuDPQ23+U
	6RaBn+DmuI1dxigZzcvGWudyGIZc+SNYZpeLTAiFMIMQR1fHwgAle0jXROxZvAbQFIto6gbzefx
	iYuulzh1vdC65d5HdUTM5RhsQb2HWg==
X-Google-Smtp-Source: AGHT+IGNnMnzJzSH4csFVqMWLKW+PYj2pG4i5xQYfHjEXv1hvwV2rJVchkFPFu5thqmIhO3VCJ0s5A==
X-Received: by 2002:a05:6512:3c84:b0:53b:1526:3a63 with SMTP id 2adb3069b0e04-53dd39b564bmr7770105e87.56.1732623475913;
        Tue, 26 Nov 2024 04:17:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd68c64c7sm1790045e87.114.2024.11.26.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:17:54 -0800 (PST)
Date: Tue, 26 Nov 2024 14:17:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Connor Abbott <cwabbott0@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] drm/msm/mdss: define bitfields for the
 UBWC_STATIC register
Message-ID: <bclvvuo3i4icx5kraqsvmpdtokx46pnjmdhliz2mhsmdm256vm@rbkwhkhjvjtc>
References: <20241123-msm-mdss-ubwc-v2-0-41344bc6ef9c@linaro.org>
 <20241123-msm-mdss-ubwc-v2-1-41344bc6ef9c@linaro.org>
 <784a7813-b024-452e-8d7e-8cbaea761bcd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784a7813-b024-452e-8d7e-8cbaea761bcd@quicinc.com>

On Mon, Nov 25, 2024 at 06:03:52PM -0800, Abhinav Kumar wrote:
> 
> 
> On 11/22/2024 9:44 PM, Dmitry Baryshkov wrote:
> > Rather than hand-coding UBWC_STATIC value calculation, define
> > corresponding bitfields and use them to setup the register value.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/msm_mdss.c                 | 38 +++++++++++++++-----------
> >   drivers/gpu/drm/msm/msm_mdss.h                 |  3 +-
> >   drivers/gpu/drm/msm/registers/display/mdss.xml | 11 +++++++-
> >   3 files changed, 34 insertions(+), 18 deletions(-)
> > 
> 
> <snip>
> 
> > diff --git a/drivers/gpu/drm/msm/registers/display/mdss.xml b/drivers/gpu/drm/msm/registers/display/mdss.xml
> > index ac85caf1575c7908bcf68f0249da38dccf4f07b6..b6f93984928522a35a782cbad9de006eac225725 100644
> > --- a/drivers/gpu/drm/msm/registers/display/mdss.xml
> > +++ b/drivers/gpu/drm/msm/registers/display/mdss.xml
> > @@ -21,7 +21,16 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
> >   	<reg32 offset="0x00058" name="UBWC_DEC_HW_VERSION"/>
> > -	<reg32 offset="0x00144" name="UBWC_STATIC"/>
> > +	<reg32 offset="0x00144" name="UBWC_STATIC">
> > +		<bitfield name="UBWC_SWIZZLE" low="0" high="2"/>
> > +		<bitfield name="UBWC_BANK_SPREAD" pos="3"/>
> > +		<!-- high=5 for UBWC < 4.0 -->
> > +		<bitfield name="HIGHEST_BANK_BIT" low="4" high="6"/>
> > +		<bitfield name="UBWC_MIN_ACC_LEN" pos="8"/>
> 
> MIN_ACC_LEN OR MALSIZE has 2 bits , bits 8 and 9.
> 
> But bit 9 is unused today. Hence we were using it as a 1 or 0 today.
> 
> Its unused on all the chipsets I checked. Do you want to continue using the
> same way or correct this?

Let's correct it. I will send next iteration.

-- 
With best wishes
Dmitry

