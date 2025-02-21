Return-Path: <linux-kernel+bounces-524956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41296A3E921
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4190919C4C83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36ECA94A;
	Fri, 21 Feb 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfEEqLkQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103765661
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097265; cv=none; b=OYkJyBQ+CwA2yYrn5KJ65hIilrES19YcJUdbTUTMGz2od0MPlBT6WV910N9PdL/N50jy6vOKHVgVJ7+vmbbv8MWkqGJxFwaknHe7jzDb8YMJv1cflJReAQifIcuiOEo07pgbnOS5q6Z+FDgU+dijCG3igtYEHWaIzvbz9wLr8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097265; c=relaxed/simple;
	bh=194jM7z6nV7Z/81iKeQOlcnR3ZyR6n8ihg/2VwlIvWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLFYVOZp98ni4MjnKq32MkCGj7BQxZzcWV1KIWTjnP8Q/AcXaEfMuZ5h8kXdBxNpIiE01UT5Zf1pcnsBoDDnNYi0vaj5tajN0/G0vCFqc1c/fbylMRr0hLkv2kqvmkuXxUAhUz9Idq+VnBGz1v2zjfs/IRyi27dNB2TCgD1aR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yfEEqLkQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543cc81ddebso1831365e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740097261; x=1740702061; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uumccPimCc696EpPgURZ0zz8UVBod+A3tWmA8Rwx4ak=;
        b=yfEEqLkQexupW8Av6qlS5CUAlPLSmos8u8U217DRruh9CiMRf0IQWGtuSGu1ULJ4YV
         uH1/vxajMfsXweR/ooAeY4L3aTh4GKocXLUftl9tTE8YUNlCr8kxbY97DyQHL6E5Ff6r
         SRxvHejR6/voBkx0rvSxljKCwnyRN5MOH+SqA0cixgN+ssrciB8o0RJUR9gTLUpC7Qz1
         nO0bwuXjmnHItYtSunj7W8Rm4c1J0EF2UR/6RFv0y8fhhVLeA/wLL6BvfijSWuIVUdP5
         kgHUaKkOsxuo7IsFQF59NyrL6F3dH8fUQ3T4SFNqZzByX3q0DqTYKUeJu8s8ke/a9aZE
         YGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740097261; x=1740702061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uumccPimCc696EpPgURZ0zz8UVBod+A3tWmA8Rwx4ak=;
        b=FftEP55V9PFw6TEvQerpAcg4eiCjWA/mfeliJaIPvOlZmz64e0/D361Z2w/vVPuUMc
         +AjIDAgD3OMvVm2tuRgUewyX4fSxP0YtIHnPvZglIDW1P4YAtROQy/PKvSifw2k36eSr
         CYmmMmN0n5uYdBi9RNoGhDn3yEMk+Op9ot0OEsHck1xPXKSLOPVXYvyHSKoICuuyMIUh
         KH/t0DxSIwES+oZ7KoIYMHKNNivKPI4Qeb/SDHBHukRkAtUolBIKx4cYxrQp0vg/MesE
         9Dy9vGI4LYKKef/gZMLGS6MNDoKeAG8VSUmRyYqdp8EPDpLOwiyzWmyE7qTaOzg/KNjj
         mg1A==
X-Forwarded-Encrypted: i=1; AJvYcCXJG3aEopz5L0OTGj7dtI0CUC2HiqqMrKZuhy8uiXX6D8EUbhfTKcXnjjvTcchw5+pNUdzmOLJ7HScaIBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwKfdb83aHydzBFt+b8hG8TVEM/gwU+SB4xjuk/F7IWq2ULnv
	tHXIGKQUzrfjvdyaa9E+spJaEI8s2RehNjx3khzCz76mue3bPWbGyLcykqaKnSg=
X-Gm-Gg: ASbGnctPGnhm18YdUxQVhk1LE33yzWVNaokKoXDhPWaRXINvom7P67E6rRptn4NwPMu
	clobYoaeDUD+0qddO5/2wwsxa4WOkgN8OOaDUU85CAptSFce5j8JTUfpVj7IQNuQe5XXlO8DsLR
	HQggyS5tkMzagUogbipkWH7K6ZlKE1QlXH1SAF2bsomT1fRqRSgUFBgeTC4dcnogGSikZlHE7Wl
	e6NAVEexwv5wwzifWP/Ziz89CP227cA3tSxca/HBXWyDW7Yk6i9vYD3s/Smo7Q8c0rikFoUCzkk
	q323eyBhB97JTSmUuG9w6uLcLH3Xd47ogF1SoxM2JYv5ANri2jx7NZi0Jt4cEtpu66HCD2c=
X-Google-Smtp-Source: AGHT+IGNo0fUbZvhJBTd0sVsxry1VC2OXImPx0tjx0XJ5qw8Unx7mQg3SjKB4fdzbc9nKdNk/+jLJA==
X-Received: by 2002:a05:6512:3186:b0:546:2f44:ee99 with SMTP id 2adb3069b0e04-54838eeb268mr405891e87.17.1740097261039;
        Thu, 20 Feb 2025 16:21:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-547df6106f6sm159624e87.204.2025.02.20.16.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 16:20:59 -0800 (PST)
Date: Fri, 21 Feb 2025 02:20:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Jun Nie <jun.nie@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] drm/msm/dsi: Support DSC for dual panel case
Message-ID: <jsir3n555ucylcc3m63gzrcf2arvsmsoivubsnrhzuxm3ts3qw@lyrghilffo5j>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
 <20250220-dual-dsi-v2-5-6c0038d5a2ef@linaro.org>
 <iibq3orsb7uf44luz2he2auox43ki42m2z4nnderyqlhypvfgo@pwqpvua6vuyo>
 <CABymUCNajuc8WnWgf2JehFYUY-MqxCYmD=By8nY-JppxYHsyNw@mail.gmail.com>
 <m7brftsrxdikfeumbjkubeeleezka7mwjbchxefqgs4ybtca5n@ge3ay2olagq2>
 <cokgqc6qd26caz63lwoyjcfbewbh3zxagjedzy6o6tfkt7wgmp@fz2gquyxcxbu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cokgqc6qd26caz63lwoyjcfbewbh3zxagjedzy6o6tfkt7wgmp@fz2gquyxcxbu>

On Thu, Feb 20, 2025 at 10:50:57PM +0100, Marijn Suijten wrote:
> On 2025-02-20 18:06:01, Dmitry Baryshkov wrote:
> > On Thu, Feb 20, 2025 at 11:42:28PM +0800, Jun Nie wrote:
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> 于2025年2月20日周四 18:39写道：
> > > >
> > > > On Thu, Feb 20, 2025 at 06:07:56PM +0800, Jun Nie wrote:
> > > > > There is dual DSI case that every DSI link is connected to an independent
> 
> There is a dual-DSI case where every DSI link ...
> 
> > > > > panel. In this dual panel case, the frame width for DSC on each link should
> > > > > be halved to support the usage case.
> 
> use* case.  Also, it shouldn't be "halved" just... because?  It should be
> "halved" because apparently hdisplay here is the width of the two panels
> together, while the width coded in pic_width should contain that of a single
> panel (since they're independent), which is equal to the width of a single
> interface.
> 
> Tl;dr for below: this needs a *lot* more text to explain the setup and
> possibilities.  How is a DSI panel driver supposed to configure this on their
> end?  Hint: look at my previous drm/msm patches that explain how we expect to
> interface with the parameters set by the panel driver.
> 
> > > >
> > > > Isn't it the case for the DSI panel utilizing two DSI links?
> > > 
> > > The added case here is 2 DSI panel utilizing two DSI links, 1 DSI link
> > > in each panel.
> > > I assume default case is 1 panel with 2 DSI link, such as Marijn's case.
> > 
> > So it should be halved in your case, but not in Marijn's case? I can
> > suspect that if you are describing two DSI panels as a single instance,
> > you should also adjust drm_dsc_config accordingly (on the panel's side?)
> > 
> > Maybe drm_dsc_config.pic_width and drm_dsc_config.pic_height should be
> > set on the panel's side? But then, how will that function for the DSI
> > panels or bridges which can change the mode?
> 
> It appears that these patches are missing a proper description of the setup
> or use-case.  I previously NAK'd those "dual DSI" patches because of this, but
> reading between the lines I think I came to understand the reason without anyone
> else explaining it, unfortunately.  Needless to say that this needs very careful
> documentation and wording in both code (DT and/or header structs) and commit
> messages.
> 
> In my case I have a single high-resolution high-refresh-rate panel that can
> simply not be driven over a single DSI link.  A dual-DSI link is used in bonded
> mode, most likely to keep the clocks and other things in sync, and to make it
> easier to be represented by one virtual encoder in DPU?  All control commands
> only need the sent over one DSI link, not over both.
> 
> In this case pic_width is equal to the entire width of the panel, hence it is
> double the width of a single interface.
> 
> Jun seems to have a strangely different use-case for bonded-DSI / dual-DSI that
> isn't explained: two "independent" panels.  It is clear to me that pic_width
> here has to contain the width of the entire panel, and is hence equal to the
> entire width of a single interface.
> (And in the future, it seems the quad setup can drive two "bonded" panels with
>  two DSI-merge's each)
> 
> But what we're missing here is what the **advantages and limitations** are
> of this setup: why would one run two DSI links for "independent" panels in
> bonded-DSI mode?  Is it more power-optimal?  Will userspace see this as one
> panel that's simply twice as wide?  Do these panels have to be "identical"
> so that they behave and are clocked the same?  How is the driver expected to
> prepare the mode and DSC configuration parameters to make this work?

Fair enough. Maybe you will suggest how to handle it in a more efficient
way. We have been running such configurations (2 independent panels over
a bonded DSI link) in order to get a single synchronous CRTC vblank for
both panels. This is a nice hack for the software that outputs data for
both panels, but doesn't want to be concerned with separate vblanks.

> Perhaps it's possible to scrape this info from [1] and prior commits but I
> rather have a more digestible description in the commit message, thanks.
> 
> - Marijn
> 
> [1]: https://gitlab.com/jun.nie/linux/-/commit/98c0f411a85d68a76be500f8421df467d6cc53f3

-- 
With best wishes
Dmitry

