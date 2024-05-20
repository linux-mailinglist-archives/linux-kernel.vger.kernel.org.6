Return-Path: <linux-kernel+bounces-184192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62F8CA3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70982281A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432AA1386D5;
	Mon, 20 May 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxDfy+Fi"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A0134DE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239899; cv=none; b=EKH3kW0XTRXJIvvxL0yclgdI5SyR6acChklW5oFY8iEC3c2PaxTrrwD6aDRJJ2Yg0o2Z2bgZ+6DE/5H6wAPOR/G6vM+t1mCUjUgtKNxJNpqMsQsmOaT+v1nuYhpG/GrZktcYnMdjD9dN7gFhfcpVLDmrErfZP8UHKOdnEpv1krs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239899; c=relaxed/simple;
	bh=cXSYJ6Uq/Nt1467RetY5cc0avV5e/FrYKk+EzIhsnug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgswxAcKby9ByMQtS6A9TO7ENBJdww2dWioOIzZvw962sAQIL5bhCn+hSTr+I7oEADOyMhksA/v1zE+42zq+eg04gPFRMH8aC1ldetyLF4gxMXSMIbADdQLR6w4nt10CsYjxqAFIkBe6ZXpRPuuti1lvEQTbiWfrh6MQai29XG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TxDfy+Fi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so60509561fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716239896; x=1716844696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HW+WHMVY50002e9IRpssfBbRimW3FKru0iLADUV6i64=;
        b=TxDfy+Fiw0Cz4cVFTNnE4KQTiU0YUknEySgIum3PBx8SjWnAE+mawUjgkkfZDOLOTd
         HYPxlmqul8sIH6Q6irLFsAxYV0a49rjjI6Vn865cYdD5T4gIlBYdzu8zfTV+PGZN+YDx
         dwfQlnjE1ON54o9DUMP73ahQNlhjpWqy6A/9OJ9iSA5+tTqsWVmlGcn8zAbOhiwsKI4Q
         m1fcMh6KUSbdaQi9V/0GiPoGAnyTX7A3y2FLNTxWPf1+zZP4C+R/Go9DwSGv3TEkAcYG
         A4r9qSx2cowd1tdTkyw4yPFkGb9XlNEeXCEOEI6rqdhaPbNacRKVntJzeTQ+Q43ZksE4
         wRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716239896; x=1716844696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW+WHMVY50002e9IRpssfBbRimW3FKru0iLADUV6i64=;
        b=a8LtYXn3TglWWxYOQolM3NP/RcgMQQ1k9lAoEslpij8vQSxXELwSSpwO2Ibhi/5ETD
         tOFpWNUsG6SfU7Et/h7PMTzdKo84ktD0WpDO8ZtQQUcudHSdbUsYJQsik3J5pn1rLWY7
         KC21ukazYZtkrYncmyM3HyE4F4ryx4NeaS8HDZ8OILqd3DaUtZ+0T3NgjIpKmVYYiDcU
         9TIkO/jEkBgewEiUWwnUFHLV6UEVjHGClH7AoA4GSB9sH9gV+YvaXYafbKp2AlXbEQkj
         M41k2FWrFYGPHM1uHfU/SU0zdsUN265FjjJZFyGrhrHkEBGQf7ZhDhVEKeq7kFWaU5j5
         jRAw==
X-Forwarded-Encrypted: i=1; AJvYcCUEkxIo3XcsStAzlFw+nEc6CMyzsITzB83xzhgZU6YHCMhN0X2Ot9XOs0LCSXoLLpt4dwZ3Pww5nipgNP5UIXfdcZH0qNGfDcWGy8t9
X-Gm-Message-State: AOJu0YwHd/BDBj9C+8ItFleNUf/i+DfOqmUxb1taY+83v2d7Bh9o9i96
	9oGWwkEBrQYCxqsgi8fzCgno16qUECH4gWoEStWVez9VmvYAihNCkkAUgPyBSAo=
X-Google-Smtp-Source: AGHT+IHjDaHWa60F+jHY9vRPyuZpYDge9YtHlyBxPbhzbM3teDE9hhUOJNQM1jd2KggUv9gaasw50Q==
X-Received: by 2002:a2e:a7d5:0:b0:2e1:5684:8fa3 with SMTP id 38308e7fff4ca-2e51ff5ce98mr229404741fa.22.1716239895787;
        Mon, 20 May 2024 14:18:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e76070598dsm639771fa.35.2024.05.20.14.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 14:18:15 -0700 (PDT)
Date: Tue, 21 May 2024 00:18:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <tmlrvvop6lhmppwxp5pfumq4vr24rq4byiljsqn5rt72sokslz@bfqeqmfdlqdl>
References: <20240517232427.230709-1-linux@treblig.org>
 <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
 <ZkqAoG9ZGg0_dC-9@gallifrey>
 <la43b5ra7aziiv7dwt4o5zha3px7jarfmk45dwsf24qn6pgcre@pcmcsicjdrus>
 <ZktIwMWtQXuxCgRN@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktIwMWtQXuxCgRN@gallifrey>

On Mon, May 20, 2024 at 12:57:36PM +0000, Dr. David Alan Gilbert wrote:
> * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > On Sun, May 19, 2024 at 10:43:44PM +0000, Dr. David Alan Gilbert wrote:
> > > * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > > > On Sat, May 18, 2024 at 12:24:27AM +0100, linux@treblig.org wrote:
> > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > 
> > > > > 'bridge_init' is unused, I think following:
> > > > > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > > > > (which is where a git --follow finds it)
> > > > > Remove it.
> > > > 
> > > > Please rephrase the commit message following guidelines in
> > > > Documentation/process. Use Fixes tags if suitable.
> > > 
> > > I specifically don't want to use Fixes in these set because
> > > there's no need for someone to backport this to older
> > > kernels that use the original, and many backporters
> > > use 'Fixes' as an automated means to find stuff they should
> > > backport.
> > > 
> > > Other than that, is there something specific you think I've
> > > missed?
> > 
> > It's not about missing things. It's about a way it is written.
> > Consider something like:
> > 
> > The commit aaaaaaa ("drm/bridge: foo bar") has dropped all the users of
> > the struct bridge_init from the exynos_dp_core, while retainng unused
> > structure definition. Later on the driver was reworked and the
> > definition migrated to the analogix_dp driver. Remove unused struct
> > bridge_init definition.
> 
> OK, v2 sent with text close to that.
> 
> > 
> > > 
> > > (I'm also purposely being less certain here, because --follow
> > > is showing it in a ptn3460 and I don't quite follow
> > > why that changes it here).
> > 
> > The mentioned commit is a correct one. Historically exynos_dp_core had
> > been creating the ptn3460 bridge manually. Later on this was fixed in
> > the ptn3640 driver and the code was dropped from exynos_dp_core.
> 
> Ah OK; remember I don't know the actual structure of these devices
> or the history.

It's all a part of the git history. I've just read it aloud for you.

-- 
With best wishes
Dmitry

