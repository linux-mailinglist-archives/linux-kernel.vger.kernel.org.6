Return-Path: <linux-kernel+bounces-221050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C290EB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543ED28691F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D182D9F;
	Wed, 19 Jun 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNOkxuOS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B071422DF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800589; cv=none; b=XQ/chGbYvxpfF7AMj+movqiSntcltjt9BrpKXhY01AphA/AG9hiHwg6UBps2BFELTUBvfjBPvyk1Myss3u/FXh1wXbQ0SlQaSR2ALWXUG8Ty/AicoP1r72BM/BZpjFgwzzBWqwLmB2H7WDDrrCCw5cAvLIDqdQMVNFykN76uODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800589; c=relaxed/simple;
	bh=/FVy10aFr7x51brEPgDPEOqk4u4JyYISn2GEH/QstT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coBJzWR+XwQsBUJa4vsSz0C2EPeNey5YS+/wT9pegv5ik3aFwciGl7nLOCRP70REdWdvIVeXH4ZUPwr2snfdPgxF7r72o5VO11Qs0XQrs1JO7elxN5lMH1ZrPSKWS5e5D83xEgYxK6FYb1lOqoTKCaG16Cv957vXj4Ub1ae9Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNOkxuOS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718800587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dd/aicNb70QNh/1zDfB5K+VP/fQZJBOti9XVpxOWFmg=;
	b=VNOkxuOS6JrB7tAkuQlwV+ePyqfqzs1fVJI7x02JA0hs4fLnDdTskZZq9sF4PfTdS9qO9V
	0m/h1TLj2WylKqxLIMT6bFW63H0h6+2AurUxpCjCHB5fcgmhhiRzQccSBIUu4ayudI0UxJ
	UIF75/WqFsFGPebKeiotOnfns9WbeLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-bNbGTblvPJ-h8G_vD3GE1Q-1; Wed, 19 Jun 2024 08:36:25 -0400
X-MC-Unique: bNbGTblvPJ-h8G_vD3GE1Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-363520c91b1so350893f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800584; x=1719405384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd/aicNb70QNh/1zDfB5K+VP/fQZJBOti9XVpxOWFmg=;
        b=EPNhoeCvC4dErh6xhi6XpGB2VQQ7PYgByoSNDGEjTG0weC6YMwKWkLfYS//7qecmj0
         1P54Wl6ZVBvy35zhyQj+2jWPwf9h1fVizdqZMJNIsnpsz+Efyt4kL6gr/0H5VLqIeP96
         0K4WmJ0AZVudLNlKDajZM1JAuI0HLT/c8ejfK0Lp86mEQZJVP7a+elV2jYBR/IwDzBwL
         PJc2JHzRdu3dEq6UPSFZ/d/Lh4K4lt61jxiVa7Yxs/bB0Hg9DTRFlmEJIjLQWNhlzHgz
         B1TJssA1C8f5dx74sHE3tKlVh2FLeaLM9ZblijEtlRr+esr7rs54pCSjbakVoWfRmNZ/
         lZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4VXukCYNvylRAVdXtDlWvBCJysfvcuDGgHVTTqKbMYtcCO+/Be0g3UBchOwYEPo9v/QQUSo7yRxvASF/t9kj8CWOpAiyUWvfRZPAx
X-Gm-Message-State: AOJu0YymU+14uIIt2aeoTrkUYMbr+2At045a7cDgQhbGAy3mK3zpqGW9
	C14aC44e5OfkJ1n0eRJL9VDzWeox8F1Sy4t8XSMeFEwSomum8da7/Qd56w1DsSmAnF2C0mSbnta
	isGh21zwaM4Jg8NRO4B94xGSdYDj1+7dJN6ZTzOIXOdfVYfYN5Xku7V6Vvw5WYw==
X-Received: by 2002:adf:ef91:0:b0:361:a8fb:6fb7 with SMTP id ffacd0b85a97d-3631998f659mr1543823f8f.57.1718800584634;
        Wed, 19 Jun 2024 05:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAiW64q2l48NwaPPFk1R4aXPb0dO4uvIu/0xZJdLCWddq9CQWGfE3dTeBvBqQlY0UcEAOZHQ==
X-Received: by 2002:adf:ef91:0:b0:361:a8fb:6fb7 with SMTP id ffacd0b85a97d-3631998f659mr1543785f8f.57.1718800584186;
        Wed, 19 Jun 2024 05:36:24 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36262f77ad9sm3874899f8f.109.2024.06.19.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:36:23 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:36:21 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Message-ID: <ZnLQxZjtsmDJb4I1@pollux>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240619120407.o7qh6jlld76j5luu@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619120407.o7qh6jlld76j5luu@vireshk-i7>

On Wed, Jun 19, 2024 at 05:34:07PM +0530, Viresh Kumar wrote:
> On 19-06-24, 01:39, Danilo Krummrich wrote:
> > - move base device ID abstractions to a separate source file (Greg)
> > - remove `DeviceRemoval` trait in favor of using a `Devres` callback to
> >   unregister drivers
> > - remove `device::Data`, we don't need this abstraction anymore now that we
> >   `Devres` to revoke resources and registrations
> 
> Hi Danilo,
> 
> I am working on writing bindings for CPUFreq drivers [1] and was
> looking to rebase over staging/rust-device, and I am not sure how to
> proceed after device::Data is dropped now.
> 
> What I was doing at probe() was something like this:
> 
>     fn probe(dev: &mut platform::Device, id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
>         let data = Arc::<DeviceData>::from(kernel::new_device_data!(
>             cpufreq::Registration::new(),
>             (),
>             "CPUFreqDT::Registration"
>         )?);
> 
>         ...
> 
>         // Need a mutable object to be passed to register() here.
>         data.registrations()
>             .ok_or(ENXIO)?
>             .as_pinned_mut()
>             .register(c_str!("cpufreq-dt"), ...)?;
> 
>         Ok(data)
>     }
> 
> The register() function of cpufreq core needs a mutable pointer to
> `self` and it worked earlier as Data used a RevocableMutex. But with
> Devres, we don't have a Mutex anymore and devres.try_access() doesn't
> give a mutable object.

If you want to split `cpufreq::Registration` in `new()` and `register()`, you
probably want to pass the registration object to `Devres` in `register()`
instead.

However, I wouldn't recommend splitting it up (unless you absolutely have to),
it's way cleaner (and probably less racy) if things are registered once the
registration is created.

> 
> I am a bit confused on how to get this going. I looked at how PCI bus
> is implemented in the staging/dev but I couldn't find an end driver
> using this work.

The PCI abstraction did not need to change for that, since it uses the
generalized `driver::Registration`, which is handled by the `Module` structure
instead.

However, staging/dev also contains the `drm::drv::Registration` type [1], which
in principle does the same thing as `cpufreq::Registration` just for a DRM
device.

If you're looking for an example driver making use of this, please have a look
at Nova [1].

[1] https://github.com/Rust-for-Linux/linux/blob/staging/dev/rust/kernel/drm/drv.rs
[2] https://gitlab.freedesktop.org/drm/nova/-/blob/nova-next/drivers/gpu/drm/nova/driver.rs

> 
> Maybe I am making an mistake and missing the obvious.
> 
> Thanks.
> 
> -- 
> viresh
> 
> [1] https://lore.kernel.org/all/cover.1717750631.git.viresh.kumar@linaro.org/
> 


