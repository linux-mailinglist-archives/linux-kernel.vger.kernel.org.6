Return-Path: <linux-kernel+bounces-184929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB718CADF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292D21F2358E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C87603A;
	Tue, 21 May 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eJjUE0HW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F774C08
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716293543; cv=none; b=mq3H2V5acPoqpqti+qTM7CRXqHQC0v16w1ESrEYD1FSKwVdkhflQrK1Y38ZLe8K/8yaxwnGpWAElSO5gLAtjJYvVRyUyboBdNrna86FG9Xp0e2SsvBVuIKOju4YHD+i0Zz7gHMoq0IReLol/iz5Sggmt1W1UaZdW+vxJg6n3pQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716293543; c=relaxed/simple;
	bh=uYONIolNYJ2gxaECU5+g1gmjLl4stpl2JUxSp4z05AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCY7A7B40HMm6l5gpDZ5vA5zLaBsZsU/40V5M9dUfF45HNp6bmTO/UvlU0olYILB5Js6UqwazVmJaSuKk42TT5m37HKz3AMQwadbDvG8JqoJFG/CWCbZvDhnlPfeJg8AOb5SoqW5Kin8TrLlcEQhu/ViBQ7I+6PAu8JWMqM+Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=eJjUE0HW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5238b2ad2f6so551875e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1716293539; x=1716898339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxZi2jUdCHohJh9CFW9THnvKlpXtvUSrWlAxZCRE9qw=;
        b=eJjUE0HW4cZ6l/1th05wD4UYAxEsRJGCWE6HEJ6Vhq/UUCdXra+gWfeoS9TGovRLD3
         NfDAaBT/LQEtOP0YX6ssvtuRYjn+GUJTSdowfhfhQaTo7Telvpg6P+9MtDbWX3eUw6LN
         AvjganHFSiNkOpie7J09u0eVrazQOGAVDycIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716293539; x=1716898339;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxZi2jUdCHohJh9CFW9THnvKlpXtvUSrWlAxZCRE9qw=;
        b=nO8nIs22aJc3zV6EXwyBmPgcj7W+aOH0I2GymW8szwVxkzsZ16pYW08MwP1vL9TJmU
         /qUBNzVye6i+mws+8osOg1wbHVTLKZ+lntsZibRL1fewMjXLsnZpNl3Xgw5FNSbkWU4Y
         L1vYFQ9hLiQFClhJirQy3pt0F8juqppYsy1+7NYGI7VwgQnk9tNOFnOuVf7HKWBSTK7w
         lmzc4HAnOyNwcNecwJl8H3nTfLBOHB3ys0aaqK2edvJRBp4U92wf0Gbp6W5APYNVunc4
         55xb6kuatrgl1oe/m2NO9yhU5MjdKajXv28of/44RxnQqTz6ita15Alxec/Dp2GbJ0tE
         4tlg==
X-Gm-Message-State: AOJu0Yw7NgIb/B0eqxPKdbrnrdcTM4XpkzlffAGWq+A887BXFinU6KWf
	B0FbJ1lp2ubOEO2NRXezDyZd+QRLUBXgcg47XG/kc0TwuUY5xA04YSLQ1CkeK4I=
X-Google-Smtp-Source: AGHT+IGRVhJKirVdP7yNCwkTehT+08uY6+K3fghXr0eHR1c/ui/sugCNgXZoZpMkjkoJQGkc0hNdyA==
X-Received: by 2002:a19:f604:0:b0:51f:d82:8e07 with SMTP id 2adb3069b0e04-5220ff72b4cmr14733108e87.2.1716293539571;
        Tue, 21 May 2024 05:12:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a615e5c1a3asm276777266b.71.2024.05.21.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:12:18 -0700 (PDT)
Date: Tue, 21 May 2024 14:12:16 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	David Airlie <airlied@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: DRM Accel BoF at Linux Plumbers
Message-ID: <ZkyPoIXBeBUqFJ48@phenom.ffwll.local>
Mail-Followup-To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	open list <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	David Airlie <airlied@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
> Hi,
> 
> I would like to use the chance at the next Plumbers to discuss the
> present challenges related to ML accelerators in mainline.
> 
> I'm myself more oriented towards edge-oriented deployments, and don't
> know enough about how these accelerators are being used in the cloud
> (and maybe desktop?) to tell if there is enough overlap to warrant a
> common BoF.
> 
> In any case, these are the topics I would like to discuss, some
> probably more relevant to the edge than to the cloud or desktop:
> 
> * What is stopping vendors from mainlining their drivers?
> 
> * How could we make it easier for them?
> 
> * Userspace API: how close are we from a common API that we can ask
> userspace drivers to implement? What can be done to further this goal?
> 
> * Automated testing: DRM CI can be used, but would be good to have a
> common test suite to run there. This is probably dependent on a common
> userspace API.
> 
> * Other shared userspace infrastructure (compiler, execution,
> synchronization, virtualization, ...)
> 
> * Firmware-mediated IP: what should we do about it, if anything?
> 
> * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
> that are hurting accel drivers?
> 
> What do people think, should we have a drivers/accel-wide BoF at
> Plumbers? If so, what other topics should we have in the agenda?

Yeah sounds good, and I'll try to at least attend lpc this year since it's
rather close ... Might be good to explicitly ping teams of merged and
in-flight drivers we have in accel already.

I think the topic list is at least a good starting point.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

