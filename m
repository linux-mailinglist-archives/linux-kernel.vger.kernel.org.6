Return-Path: <linux-kernel+bounces-249493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C092EC68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C39C1C21A87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDD16D320;
	Thu, 11 Jul 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCagrrnJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552D16CD18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714336; cv=none; b=hskiwfQ3jna21eE6xKuYeq8a/SPbjtB/kBzFHexe/ziIj4alMbqPnecsx3qATubUwZHtmZKd/yZRC3LbaEEo8oxG5NSoFk78esIBg8zTqJnwFZJzhR2YSpRm7Tws6EA8Bvz4ZyD9JgMsT+/B5Xwbj42ZOz10u21G9BgDLonKuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714336; c=relaxed/simple;
	bh=xSv/pAElyqabmJkJ/UvEKYZHt7PFzhtbXS0sLNGobLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmGzGOo07Yd9PNCKC/031KYk91jX7XAlgysqqN0+T4HrK81bVr3rg8J6zv7FXiuozqBcgyInOdoP50i+mR60QMiqTPG9jp10H569Eb57sydHWRqqlI9MQIVCilhNk4KIccxtonKiOctRoMFrD4ttNJGBajSh5+KyVl1ZFFjRS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCagrrnJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720714334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGp0x2KyrISOhdhVBMxGIYQs/iAq5rAVU04UXibc0EE=;
	b=WCagrrnJID41JcLzSu9QSTyJyY7StUaMOOf+Wyho0cc1yNeyEU07n+PC2C183pGHg7m5Sl
	oY1uBaoth+8y0qpkZeBUzQwu8bhcOdpmNLdUHWEdovebr0zKsCmvHl4YRq9U+64dM7bfP3
	aPR4pVuqvSITNHfnqXshrKEjB6dDSQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-kBRgCihQPeKPmNe2-Yrqeg-1; Thu, 11 Jul 2024 12:12:12 -0400
X-MC-Unique: kBRgCihQPeKPmNe2-Yrqeg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4264dc624a5so6184925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714331; x=1721319131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGp0x2KyrISOhdhVBMxGIYQs/iAq5rAVU04UXibc0EE=;
        b=VrA2kROnUuX5GLvGW7nO9ub2QxOmE7oQbnfylhkGUsU+oAF0KibQ8UUwCq7kYbQY/0
         EwxNkpbxRVJYTqu6cvcjEDOnoYBd3+yUcJhRkbBQ3FYxNbB+ZRzVwCL+CHg30jJBPg4C
         f5OFzIhbOfNkjRetu14x3Ub6xSpwqLTddWJkH6TH7cder1a1x+reRDCwHIywSHCr7Wpd
         m5jfxXa1DJrVTsE8eHwKSwvSeoagX9hhcTMoUNK9kzAe9UJ0YIAspXmlPAw/KezxhXLN
         fT0DyT7MoRoDJliECaqoLpjCM74V9kS3g/cfg9j8LNEmfrZkvvmSxqwkOCosBmbhsi5D
         YqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgj0wH2njR469ICkaHd4VWe096JHaa19na1rJ8NRJ3gwAYtvZc5n4TR6ivd8WrDX7arx8w6cVoT6VodPahBCjBQ9s3xapzSpCi7v8E
X-Gm-Message-State: AOJu0YxA0k9P60751la8JkPUM7VAn9JVcGWh/VFwwnsEqK38HDu1lPtu
	S9Zsm5GQIPx+ARADdutjfX6OBOs0uRNvWlffQ6iGzVEJBj+kTLWWQN1QMC6Mwt30xkfkfCjZGSI
	Rb5mwo/amyJl8r5PrZ3kHh0PwgVGh+KFxb9QPD8REupWpuvBQf2PhkoJVz7XDkw==
X-Received: by 2002:adf:cd8b:0:b0:367:99fd:d7b8 with SMTP id ffacd0b85a97d-367cea965a1mr5399167f8f.35.1720714331748;
        Thu, 11 Jul 2024 09:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk9MfL1t+xrZwkJ0qJ3kx9NSKMMHVhwHWXaLexst1iGqnCx78rqRXhjzLmuuqO7RJ/+QTB1g==
X-Received: by 2002:adf:cd8b:0:b0:367:99fd:d7b8 with SMTP id ffacd0b85a97d-367cea965a1mr5399140f8f.35.1720714331381;
        Thu, 11 Jul 2024 09:12:11 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84907sm8138566f8f.43.2024.07.11.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:12:10 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:12:08 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <ZpAEWAzETnrVI-cs@pollux>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071122-escargot-treadmill-6e9a@gregkh>

On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > (2) You require drivers to always implement a "dummy" struct platform_device,
> > there is platform_device_register_simple() for that purpose.
> 
> No, NEVER do that.  platform devices are only for real platform devices,
> do not abuse that interface any more than it already is.

I thought we're talking about cases like [1] or [2], but please correct me if
those are considered abusing the platform bus as well.

(Those drivers read the CPU OF nodes, instead of OF nodes that represent a
separate device.)

[1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
[2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441

> 
> > I think (2) is the preferred option.
> 
> No, not at all, sorry.
> 
> Use a real device, you have one somewhere that relates to this hardware,
> otherwise you aren't controlling anything and then you can use a virtual
> device.

Of course we should stick to a real device if there is one, I didn't meant to
say anything else.

But since it came up now, some virtual drivers still require a parent device.

For instance, in DRM we have vGEM [3] and vKMS [4], that use
platform_device_register_simple() for this purpose.

What should they use instead? I'm happy to fix things up if required.

[3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
[4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c

> 
> Again, do NOT abuse the platform subsystem.  It's one reason I am loath
> to even want to allow rust bindings to it.

How is that related to Rust?

> 
> greg k-h
> 


