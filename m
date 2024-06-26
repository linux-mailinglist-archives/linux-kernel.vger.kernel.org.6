Return-Path: <linux-kernel+bounces-230315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E840917B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4546B285972
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4515F316;
	Wed, 26 Jun 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEEXq9Ob"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79522167DA8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391350; cv=none; b=c+pt4JUry919UoQqzM1f5Vf7adZuLGK3LHBA5xZGQZPQx9KyZTzYWKGEMsU0Pnzjz2VtWndPkhtS12YyJMAP46+gQwrCPdET1bhbsERp/bDafyc5zh/pN/c8VEAm/uUfMxPlxe67isLmz9vO9HLHwQOpjUAOrN6iXis1aXs3/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391350; c=relaxed/simple;
	bh=4CUIbUqVEh/bPjVMiA0Lgb2N/JCUZEE9OAiPQzAgEr4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdARw8u5UbahuJX6S0kW2ILrcgBVUnO1lgSSQgSHWGAyVNVMDpU8D+c11A8L3+urJVV2pqQ1lMYvytmHjdotuRWjOjEmm1Dh1H6ZNJxJNpDQoYphZMPA95F0V6dlGe8X0j199stYirKYmNtocvTDkZ3KirEAWzg/G/H98zIIp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dEEXq9Ob; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso68516961fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719391346; x=1719996146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Oh0VR40TRUiFXajEyAtrpMuiTr3n0qWoEDC9cdem7E=;
        b=dEEXq9ObmakIdU1ncLbs2e1P4X+pnXySWY5WBo0kTFDx4vTsZHtZ1zs7pYWdkUk5Es
         mNoWD0zyeaWG2SISQpaQRBU6D2Qylg3CzX+UTPIHH2CYmgslpXodgHsImJrf9SvW/gh7
         MdnmGkKwigUr5hwXAwblx6TKmbdNNCc5M/mnwN+ZuBtHOxL9qPHHHHtWfqD5VjBZJCed
         0lSah1NUdFxgCyxBYsDeW6g7+U13l+cshJ3HlawQvYfcu+pmSXMYBILLXhY5eLTS08bG
         sC8y79nf19amrdh6/QpTRNgUhr0+Ge3XxF1NtMjQc7FR7EZGri9zvokllYQlPBT6cL5I
         ExYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391346; x=1719996146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Oh0VR40TRUiFXajEyAtrpMuiTr3n0qWoEDC9cdem7E=;
        b=EzIZMyd/hSsOVDkQfRKO4VGjCZwVj8pUcBfM8BgUvrRma+2Pr14vYVYjyt5QQnqPN8
         jSsesRHXB4svMgqUNw97g3YtaFNo+YqtnCVqJJycu+vKooe0G6L3Z0/qIDEVjyVa20j7
         eokGCXKTylEam1DQdrIRa8g9G/f0D2feEdTU4rQ/2tuI4ZOnNiB/hDMhzZIE2NDS+zGV
         BNMkLAEnuXp8RXQmiv/+eaEY/riI3zqZKHRssg11rvksR8FbpZryJkgyffpZMxJHwso0
         cLWb1WgxPf2TBi6G/qm9qmx0RU9xcThfzFaPhyZHqvL6jTQKkw7v1hpyq/OlA8CLa9TB
         MMTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/NexX149hLtFFpop7YGbY6BgXQSRXCeweO5vp4Pg5RpIx50HsQEXDt3NQvTUYdnu7sMsQiYIsfSh6GDaLZCkxAjbUbF57qHdJQ4a
X-Gm-Message-State: AOJu0Yx+MbcZHOPA+D2BmP62loe00DdPlZXvs056b79hEgUev11PcD35
	vA4hFgBcXpdDRoZj+MjF/fh+b5tPEQH4Jhq1xvdJfxbongF8KkMZsxULxT+NgsY=
X-Google-Smtp-Source: AGHT+IFrbNPIOjz4l8L0QPdLiBhOanVgKGAzX1JGKORXX+GcNOkKakHvdEgvdrxZRYI3gB9j/fY5+Q==
X-Received: by 2002:ac2:5b4c:0:b0:52c:dcd4:8953 with SMTP id 2adb3069b0e04-52ce1839881mr6045361e87.36.1719391346204;
        Wed, 26 Jun 2024 01:42:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cec517173sm501360e87.244.2024.06.26.01.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:42:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:42:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-kernel@vger.kernel.org, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@gmail.com>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/etnaviv: Create an accel device node if compute-only
Message-ID: <kzk46s2hqrbipehnqhcx47q5mtkdjc3oeeobr2jwinw2ch3pra@37xuwtyakeus>
References: <20240424063753.3740664-1-tomeu@tomeuvizoso.net>
 <8c55dba5-6308-685e-13da-e728197d8101@quicinc.com>
 <CAAObsKD4-k7Ya4Mi=vEPaC9DucbnVGDO5SaEUt-_o2_Bg+_FgA@mail.gmail.com>
 <CAAObsKCm49y-nUph=m9c+-eG37SaGKG93-1etwOQab4f5MXxOg@mail.gmail.com>
 <20240509144118.baib2pftmpk5nikr@GABBAY.>
 <ZnvCsJfdZdLvw1ZN@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnvCsJfdZdLvw1ZN@phenom.ffwll.local>

On Wed, Jun 26, 2024 at 09:26:40AM GMT, Daniel Vetter wrote:
> On Thu, May 09, 2024 at 05:41:18PM +0300, Oded Gabbay wrote:
> > On Thu, May 09, 2024 at 03:53:01PM +0200, Tomeu Vizoso wrote:
> > > Oded, Dave,
> > > 
> > > Do you have an opinion on this?
> > > 
> > > Thanks,
> > > 
> > > Tomeu
> > Hi Tomeu,
> > 
> > Sorry for not replying earlier, I was down with Covid (again...).
> > 
> > To your question, I don't have an objection to what you are
> > suggesting. My personal view of accel is that it is an integral part of 
> > DRM and therefore, if there is an *existing* drm driver that wants to 
> > create an accel node, I'm not against it. 
> 
> Yeah, there's a continum from "clearly 3d gpu" to "compute AI
> accelerator", with everything possible in-between shipping somewhere.
> Collaboration is the important part, hair-splitting on where exactly the
> driver should be is kinda secondary. I mean beyond "don't put a pure 3d
> driver into accel or vice versa" of course :-)
> 
> > There is the question of why you want to expose an accel node, and
> > here I would like to hear Dave's and Sima's opinion on your suggested
> > solution as it may affect the direction of other drm drivers.
> 
> So existing userspace that blindly assumes that any render node will give
> it useful 3d acceleration, then that's broken already.
> 
> - kernel with new driver support but old mesa without that driver already
>   gives you that, even for a pure 3d chip.
> 
> - intel (and I think also amd) have pure compute chips without 3d, so this
>   issue already exists
> 
> Same for the other directions, 3d gpus have variable amounts of compute
> chips nowadays.
> 
> That leaves imo just the pragmatic choice, and if we need to complicate
> the init flow of the kernel driver just for a different charnode major,
> then I don't really see the point.
> 
> And if we do see the point in this, I think the right approach would be if
> we split the init flow further into allocating the drm_device, and then in
> a 2nd step either allocate the accel or render uapi stuff as needed. The
> DRIVER_FOO flags just aren't super flexible for this kinda of stuff and
> have a bit a midlayer taste to them.

Being able to defer render allocation would be extremely useful for MSM
too as it's not currently possible to mask the driver_features during
drm_dev_init()

-- 
With best wishes
Dmitry

