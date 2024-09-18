Return-Path: <linux-kernel+bounces-332793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B959697BEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FF282E97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF61C8FCD;
	Wed, 18 Sep 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i92yJnAT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC01537B5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675124; cv=none; b=LInmt3Ge621hYIoSwTGpoIa3MeSPxl7bYwtCHNQEiJIiaPWO4jOC/qctPxCbEEp/kBMXFb8cZgzs0p/SKy7wodwRL0cRwKk2oO3t3trJkFwYs51G92SJXwj0o+O064il+Lx17xycJrbPTlUz9js/5kdEC4QTEADwWpk1RHg7ikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675124; c=relaxed/simple;
	bh=XTl0akMhLk29+AOFsdWdqvtoDJjo2Zyt/IJFizXRBlY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHVVOl0jH5URTW4RuqSw7uFZCOdu14OxV3rjJcacQiCOwv3vk4m7Li99f1uT2XWGkbO5c5I91sYVuCq5tCV1YGjfjfsmqdTMprMAEzfNSlMkhetMZcBnTk9hfEtu4G6jDZNM4GRwRNE09xPBBllyRrvJvnoHkj330UixSk3pZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i92yJnAT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356ab89665so8057022e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726675120; x=1727279920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/nN4RLUg+rsp0zC2dF8c0G2tRr1/u478Y/JOVZAT/Z0=;
        b=i92yJnATD90UruszcewWZUZ47cdnGvZeoYki9Wj51h/YucsJLqcc9GombcpiOB2b2s
         jFCKEsVjpc+8AAFkAnluROk0MFCPGPZcGnFMjcHypRis4hiUdZoHhzjeLSCVwC0ZUWcL
         rH3SQpPxpilDnSZyR0/h3qiy6EceMiAK6UuRcSA0a749bpKXmT5a0ZReZyX2HH34zYKB
         6ghX7LMYiU58NMq+uCgEmjSIm8TaagQKqyE20TVJhr+IeRBC033jzcpSG3iIP8f+yZkO
         jt2E1/fQDfu0vnaueotJFnkirTiV/dXZj+nWdApswd2Wh3aYME0tuDXZjfIdU8U0sClr
         5bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726675120; x=1727279920;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nN4RLUg+rsp0zC2dF8c0G2tRr1/u478Y/JOVZAT/Z0=;
        b=dotJFlcs6jPOaGITWlP2ru4cR5J0vXZZL51OTVGx+4jx8EQBN1fB5am/idaOHmAqBP
         vgcND2zQZg+NKDBv4QR5iDlTmnLFDhk2W2loMczh5tNZpMu0/3F8wCTCrrayZpPNyUcj
         Sl0XvhOPz1DnyxObcVamLd0Wv2tBJdO3AsNR9I38wiNaU7mbnlfhxCulyHI4StHVvGWd
         P5tPM5RZ1URPUVIIj9q5MFI6vrxnQR/ak9g7wDH9+PXEeozk4HEyMlHMUmsM0aN0te7t
         l6kgy6Xy+uTsEeRIzvbjfJ49vQONyFKw+AVY+cwPBj/np03dkZVzGjCp89wy9wjZTDcE
         qpsg==
X-Forwarded-Encrypted: i=1; AJvYcCUTuZguAK9omSGJgHdxBeDncpfSocJn3tSVr/riZPpZA6x/5S9fDAy4NZe3U4EbL0HkJK3VQhBaQSv0SJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvq5NshaHCVcfWMgdt3lQ/zZPgzZ3uC2HaOTL8GWBHYAYl7Yh
	HGAUxWNkzH9Klom/CBeuBDgmn+JvG/z6TGul5aByrThSnW/KG7N0
X-Google-Smtp-Source: AGHT+IH8VOQsJfHDSqWN86iefH7nUBxWL2kMFITGTcXQybMmXDSZE1mijRo3aKboOiGWLXoB8Q9s6w==
X-Received: by 2002:a05:6512:33ca:b0:52c:dc97:45d1 with SMTP id 2adb3069b0e04-53678fb1db0mr12278687e87.10.1726675119540;
        Wed, 18 Sep 2024 08:58:39 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096890sm1549135e87.130.2024.09.18.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:58:38 -0700 (PDT)
Date: Wed, 18 Sep 2024 18:58:38 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
Message-ID: <Zur4rhyT50lwxE_v@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org>
 <ZunCysUTSfQU1ylg@skv.local>
 <c7664fda936d36e0d916ae09dd554d2e@manjaro.org>
 <ZuqyuvZ6tdzp5XSW@skv.local>
 <8df5fc79a3e899738aa944a290774c72@manjaro.org>
 <ZurYndjVz7r0U6dz@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZurYndjVz7r0U6dz@skv.local>

Hi Dragan,


On 24-09-18 16:41, Andrey Skvortsov wrote:
> On 24-09-18 13:27, Dragan Simic wrote:

> > > In device tree mount-matrix documentation [3] there is
> > > 
> > >  users would likely expect a value of 9.81 m/s^2 upwards along the (z)
> > >  axis, i.e. out of the screen when the device is held with its screen
> > >  flat on the planets surface.
> > > 
> 
> how I read kernel documentation.

Hm, I think I misunderstand this part in kernel
documentation and you were correct.

> Picture 2.
> 
> up
> 
>      +--------+ 
>      !        ! 
>      ++++++++++ 
>          !      
>          !      
>          v      
>        gravity, Z
> 
> down
> 
> Screen (drawn as ++++++++++) is looking downwards ("its screen flat on
> the planets surface"). Gravity and Z axis point into the same
> direction and it's expected to read positive value.


Sorry, for the noise.


> Actually, unless my analysis is proven wrong, perhaps it would
> be better if I'd submit this patch in its final form, because it
> has diverged a lot from the original patch.  IIUC, Ondrej only
> imported the original patch from somewhere, without some kind of
> proper attribution. [4]

please, submit your version of this patch. I'd be glad to review it (I
think, I've already did)

>> [1] https://rimgo.reallyaweso.me/vrBXQPq.png
>> [2] https://rimgo.reallyaweso.me/uTmT1pr.png
>> [3] https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt

> [4] https://xff.cz/kernels/6.9/patches/0221-arm64-dts-sun50i-a64-pinephone-Add-mount-matrix-for-.patch


-- 
Best regards,
Andrey Skvortsov

