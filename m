Return-Path: <linux-kernel+bounces-249625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297292EDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30B61F2351E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9E47F7F;
	Thu, 11 Jul 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtDhUili"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD542AB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719753; cv=none; b=n97q+C+WsX0eFv3TfHa6+Y2U5BGJ1JlnjVXY2lCt/62XSDjFWFh7q0cJOzi457vd6rS/dgOkqwcbVrn5MhIOJsjM1La/m4l8BrJcf5GFgioLFPmZeuST5VR1JOnSClX6KrBhjaLHWDVt3fdjYvq6xd5/VI+cf/qmHDYaXLpP67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719753; c=relaxed/simple;
	bh=AgLVqDHEn0/CnUyJN5XMWMJbr8yXezc7m1phC/lLtxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLRuza9I+3EL2e1LsdpqTSeYATFcZEsILXlICkOWGbv17DSD4s7D7TqG1fqv9mj79Y6O+7koLj5BWjXf6BPXIn3ufEqKZWxOQoKXAo1PKLErX2Ntke4o9SLmt8iB7EYpXq87xUptrYuObmgKVH+9XX6h5VRxuoTxeneW/BphNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtDhUili; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720719751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8TsYVq9c5ngy71SlSWTBr6NT61WSPVDabfg4WDFbaU=;
	b=dtDhUilipohRbvOGYnmv7oweC/54hmGEvFArORCUiOzCutJ1rTpBdB7b9P9LS6d9rkWzhR
	8E15FL3Nwalftnwe4Cb9AE+or15iktpPCjW1TiXX+ngTvexRydETaJx12o5Xm2bYvFv3ht
	fbNZZOlWge5A8s+A1HAVAool6Ad3+Qk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-pMP6C3JrOuOYShiPAMyzLw-1; Thu, 11 Jul 2024 13:42:29 -0400
X-MC-Unique: pMP6C3JrOuOYShiPAMyzLw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4266d0183feso6699205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719748; x=1721324548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8TsYVq9c5ngy71SlSWTBr6NT61WSPVDabfg4WDFbaU=;
        b=vsbmWtVmfcfB30Jf8qEdfI8GD+ObCZHDR3DXmD0PK9mvq9l8msBQ40pdRDNSLatnyB
         Xk3T+7NCJwlhV/yfi+qhbW9ETiMPXt/lfNvVlKFgI5x0HU5s9ErnSWm+hUCUu4sP2gIb
         9OjGUvFm2XJlaUZ7rjPNlkXgOHJfUQroM854rN5wlQbG8xgPv47UaZQiOpGgybdLCmBm
         HLUbhu9NtKvykfNgJ+TCVREBnue9vlnIrjB/uZR8UzaTUFU2klZ5UNspn2i3nyZPA0gN
         AkQMyDWPxdsulBD52t1mVn3cKZ/Kmw0ZH1lQZrT5QAusIM422128G9ekprNifkgH+93d
         ySJA==
X-Forwarded-Encrypted: i=1; AJvYcCVCpXrzWUKY6Q0VS96vhzJ/WEfZheRYPTZYRJJWFMKb+dMv+LLDegz0C2ltX+6yC1CKhnBV3XfNOYXJJxr0q93MDvZXNOYygrG6vsPt
X-Gm-Message-State: AOJu0Yy30RezTlK5ohylVBOEfTdC4LoI+lJJx+JxrY2yY1O/js8+vpJK
	wYbbKjzskStp2jVyEwMoHcVhUU6YY+OrK0/9mPl8Daf9KCrrAiPwJ/w1xx4kP7pFJuixwcLCVjp
	MMs0ehyyp4p/btp3UAXfsuMamduQp8DR+GNwmxnb6CmLjDLqfCef2knasjqD8Kg==
X-Received: by 2002:a05:600c:4a98:b0:426:6ea0:d5b8 with SMTP id 5b1f17b1804b1-426708f2012mr61042995e9.29.1720719748641;
        Thu, 11 Jul 2024 10:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKwn2C6s42uOUj9q2Pg0MUFJ2DDsOSx1NRMtE3FwuTWPB3a6WMkyF+42TClnNhYZIlQC+U8A==
X-Received: by 2002:a05:600c:4a98:b0:426:6ea0:d5b8 with SMTP id 5b1f17b1804b1-426708f2012mr61042725e9.29.1720719748237;
        Thu, 11 Jul 2024 10:42:28 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e07e1sm127086985e9.7.2024.07.11.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:42:27 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:42:25 +0200
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
Message-ID: <ZpAZgaY4VlqqdXwq@pollux>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
 <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
 <Zo_cW57i_GMlmYV-@pollux>
 <2024071122-escargot-treadmill-6e9a@gregkh>
 <ZpAEWAzETnrVI-cs@pollux>
 <2024071111-negotiate-spoof-da94@gregkh>
 <2024071149-pork-vacancy-14b8@gregkh>
 <2024071106-handed-oversleep-2377@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071106-handed-oversleep-2377@gregkh>

On Thu, Jul 11, 2024 at 07:21:59PM +0200, Greg KH wrote:
> On Thu, Jul 11, 2024 at 06:41:29PM +0200, Greg KH wrote:
> > On Thu, Jul 11, 2024 at 06:34:22PM +0200, Greg KH wrote:
> > > On Thu, Jul 11, 2024 at 06:12:08PM +0200, Danilo Krummrich wrote:
> > > > On Thu, Jul 11, 2024 at 04:37:50PM +0200, Greg KH wrote:
> > > > > On Thu, Jul 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > (2) You require drivers to always implement a "dummy" struct platform_device,
> > > > > > there is platform_device_register_simple() for that purpose.
> > > > > 
> > > > > No, NEVER do that.  platform devices are only for real platform devices,
> > > > > do not abuse that interface any more than it already is.
> > > > 
> > > > I thought we're talking about cases like [1] or [2], but please correct me if
> > > > those are considered abusing the platform bus as well.
> > > > 
> > > > (Those drivers read the CPU OF nodes, instead of OF nodes that represent a
> > > > separate device.)
> > > > 
> > > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-riscv-sbi.c#L586
> > > > [2] https://elixir.bootlin.com/linux/latest/source/drivers/cpuidle/cpuidle-psci.c#L441
> > > 
> > > Yes, these are abuses of that and should be virtual devices as they have
> > > nothing to do with the platform bus.
> > > 
> > > > > > I think (2) is the preferred option.
> > > > > 
> > > > > No, not at all, sorry.
> > > > > 
> > > > > Use a real device, you have one somewhere that relates to this hardware,
> > > > > otherwise you aren't controlling anything and then you can use a virtual
> > > > > device.
> > > > 
> > > > Of course we should stick to a real device if there is one, I didn't meant to
> > > > say anything else.
> > > > 
> > > > But since it came up now, some virtual drivers still require a parent device.
> > > 
> > > Great, use the default one that the kernel gives you :)
> > > 
> > > > For instance, in DRM we have vGEM [3] and vKMS [4], that use
> > > > platform_device_register_simple() for this purpose.
> > > 
> > > Again, abuse, please do not do so.
> > > 
> > > > What should they use instead? I'm happy to fix things up if required.
> > > > 
> > > > [3] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vgem/vgem_drv.c
> > > > [4] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vkms/vkms_drv.c
> > > 
> > > Use the virtual device interface please, that's what it is there for.
> > 
> > To be specific, look at the devices in /sys/devices/virtual/ that's
> > where yours should be showing up in, not in the root of /sys/devices/
> > like they are by creating a "fake" platform device at the root of the
> > device tree.
> 
> Ok, at first glance this seems a little bit more complex than what the
> platform api gives you, let me knock something up next week during the
> merge window to make this more simple and then let some interns at it to
> sweep the kernel tree and fix up this proliferation of platform device
> abuse.

Yeah, I stared at this for the last 30 minutes and was just about to reply.

I think that we probably want to get rid of this abuse, as there are quite a lot
of examples for this.

And considering that I wasn't able to find a rather straight forward replacement
that makes it go into /sys/devices/virtual/ I think it's not super unexpected
that this spreads.

It looks like we probably want some kind virtual device API for that purpose?

> 
> thanks,
> 
> greg k-h
> 


