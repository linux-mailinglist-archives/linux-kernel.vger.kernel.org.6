Return-Path: <linux-kernel+bounces-247814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E9C92D4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E611B280F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200D1946AE;
	Wed, 10 Jul 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx6QaqQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FD18FDAB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625330; cv=none; b=aPQRQGXc9CyEPwkjZQAsA97vJR6jjqgFv5Moh1d1EfXMhNyd7X/e9qnYr5No2ffAYEC1/4uJou/OTrcmqMe/lYs8W+yl7HFX0/VCByvEaFeQrigCoDdWN30vg2cb7x1LQdZQbShM8yZ1Y1bOF0DEi7hfMBcTlAzznjpF4fOxDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625330; c=relaxed/simple;
	bh=umm5NQLzqFULNPwOL9iavZyEgQiYul3xYGSdC/V3Yi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHJA2/0nD70aUbsylk/HrEYKWZhA7rWGVnhF9RBqHFgZbCjNYxUYqOlXCg3eTVrvVGRouJWFOfyWRm4/t0rpRJtr4lRL4wxkZ9ysKDQ5bXzy2UG19BvsQC7R3//q0A7ip4eW1q7FPezKJKXVqPtRRNIekv2lnxjUGjCpzlxo05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx6QaqQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720625327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiswT65XwU9I/0a+3mkQf8xLZNUkrdHDC4aVFNJHkF8=;
	b=hx6QaqQC/baxfVj5v2DlQeaDsTL4tTiRvPzDQJ1INaqjhtxbp/2W0f/4co/n74ilt27yIy
	39XmJZviSLdsl4tHgeeVMIB5/VZvKWnK/XytlOwdQlQEr07jUX034K7zTdVHIu+q9n0LaE
	iJRpzaMkL2SHiyPqp31L3JIariNNtQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-7iGdA8UTNiK33EieEUs3zg-1; Wed, 10 Jul 2024 11:28:46 -0400
X-MC-Unique: 7iGdA8UTNiK33EieEUs3zg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42667cc80e8so24751545e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625325; x=1721230125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiswT65XwU9I/0a+3mkQf8xLZNUkrdHDC4aVFNJHkF8=;
        b=pzP5w+MGsKIvSzX5z36gzCrxNwKXTkQZCR3qmrCDr3jJrre5qHdJUUWi3AvtBKk/gQ
         tJlSPNgIWdn4EsGzvJaI/KE8BOnVpl09H3k1RC191OZyAROU2vFPMh/I3bLoRqoDizRJ
         qBFrZ7NSz7XVnPgfAFSC5OpotAzgVfpqD41zQbLTiu+MfYLrnK6rpWaJKmM5FE6mfH2U
         9bYEWIALoNAZdDScVq3aw9VyaYRD1WILcSw9jj6i++vHACMByrksS7CBxR4aBYVNLLm5
         A/HUA2PUd2WQuVo+gDmC8G0H4gF0dVAavYN+OdNHCveXYnW126sT4+vjZudwerwNkfws
         0LSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTPFgPRADXNGxg2j7VuFo1U9Cc0DEUxT4JqG/9PVaTQCXQIzqs22v0uJfsdNbJuma/XlCzVm4ThTMFUbejGm14kodp1k2gTC96SERu
X-Gm-Message-State: AOJu0YzdlgCvhq9WezF+hgFQwOn8cpKeUT6DV4ccgWGZct34MoWpsURs
	7SadixCQ6jRVLoIocKsKfIENxH/P6ps6abzdWXh1PJ/7QezcEF1Bl7/ZgubnrvkCZ4b4k6nCo6b
	EeZSAEwMVJgMPuOa3Yha5NiQ1JK7V9hBSI0ECA30bR3jtne4dBnCcfeQAyzYiWg==
X-Received: by 2002:adf:e80b:0:b0:363:341:1cf2 with SMTP id ffacd0b85a97d-367cea7355emr3811028f8f.22.1720625325140;
        Wed, 10 Jul 2024 08:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOpwUVhMBcEaYLWlYi0AGlNxmlsgMJ9+TlNHkqzOC0lgyPh6t979vO258uH0PKKJUo2HQ8g==
X-Received: by 2002:adf:e80b:0:b0:363:341:1cf2 with SMTP id ffacd0b85a97d-367cea7355emr3811000f8f.22.1720625324747;
        Wed, 10 Jul 2024 08:28:44 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e07fsm5583240f8f.17.2024.07.10.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:28:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:28:41 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [RFC PATCH V3 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <Zo6oqfFX-TNIeaIC@pollux>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <b7df0c75cc07a451243b554fb2272c91cbe42dfe.1719990273.git.viresh.kumar@linaro.org>
 <f0016987-4288-4adf-954d-665b35ae1bf1@redhat.com>
 <20240710085652.zu7ntnv4gmy7zr2i@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710085652.zu7ntnv4gmy7zr2i@vireshk-i7>

On Wed, Jul 10, 2024 at 02:26:52PM +0530, Viresh Kumar wrote:
> On 05-07-24, 13:32, Danilo Krummrich wrote:
> > On 7/3/24 09:14, Viresh Kumar wrote:
> > > +    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
> > > +        let drv = Arc::new(
> > > +            cpufreq::Registration::<CPUFreqDTDriver>::register(
> > > +                c_str!("cpufreq-dt"),
> > > +                (),
> > > +                cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> > > +                true,
> > > +            )?,
> > > +            GFP_KERNEL,
> > > +        )?;
> > 
> > Putting the `cpufreq::Registration` into `Arc<DeviceData>` is unsafe from a
> > lifetime point of view. Nothing prevents this `Arc` to out-live the
> > `platform::Driver`.
> 
> Hmm, the platform driver layer (in Rust) should guarantee that the
> data will be freed from the driver removal path. Isn't it ?

No, the platform driver layer will only guarantee that it decreses the reference
count of the `Arc` by one, that doesn't guarantee a free. If something else
still holds a reference to the `Arc` it will keep the `Registration` alive,
unless it's wrapped by `Devres`.

> 
> > Instead, you should wrap `cpufreq::Registration` into `Devres`. See
> > `drm::drv::Registration` for an example [1].
> > 
> > [1] https://gitlab.freedesktop.org/drm/nova/-/blob/nova-next/rust/kernel/drm/drv.rs?ref_type=heads#L173
> 
> I can convert to that too, will do it anyway.
> 
> -- 
> viresh
> 


