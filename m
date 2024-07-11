Return-Path: <linux-kernel+bounces-249010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B192E4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93851F22546
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792FE158D8F;
	Thu, 11 Jul 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMQ2cv4a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3515748C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694600; cv=none; b=tfAYXGThnEklWYY0OrThyR9OblRJDvMP1iRHNQsVTVzKFocKxtanewcXACw3hGEwc1ZO7Q4r8slC+FSIXsPtvBY8qK9peasw7iZ1X+DyLiGhI8ykvAz/be0KmgwakHZsWGELTzagiffJCbLTggZVeG5PKaaxPNB91CH+ma9Oun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694600; c=relaxed/simple;
	bh=vLgN8ydt9R0lSQJEzNPu1qwo9POilw3g8eYIWXLN0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMwFQHrqxVRHnlKGfdOpEME4rgm9Vc1cuL71akUtlQpreMxoo1g1gKhhwTDVTKlMfXy7VzHH2h0aTMteMiCjWad7lYjA7/boTBqE3t0NNW2dLiQ1wVeknMy1lHSCuFVw7QMgpoflpc/WSyDR3wLAp4wbhxe+zae1Pb1eEUGwEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMQ2cv4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720694598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nFnMHEgP+MZLRxSq3Ch/Tx/f7UElIyD3peARHLX6JK0=;
	b=ZMQ2cv4azeaNc4QUFsAM8QlTH/sWj8EOLlJTbxZ3r/hfMVpm+wpz4DafOqO+0hrfRC4cfL
	JkOp3D4Ra4CyZWmAtdW5XQr+us19SvxajYOmVPkwkzNN9C4eNIdiptnw4n5J60d/z4hHZk
	86iMgbkc1zADzSjad+KTh+rTzXwy2Pk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573--6e0wg1MMMmHRSva5OPhbg-1; Thu, 11 Jul 2024 06:43:16 -0400
X-MC-Unique: -6e0wg1MMMmHRSva5OPhbg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367987cff30so385767f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720694596; x=1721299396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFnMHEgP+MZLRxSq3Ch/Tx/f7UElIyD3peARHLX6JK0=;
        b=h3ouwYoBPhjpw4IQMlIpI88fePkcUXkdGLzQIVZxZPTJmNSYRcHptiJZR6/G4ctHYP
         gnft3eRr0tUzZMYAFUZaPlHQBBa0YTmUnrZGk0f6jkm/AP6sGhmr3NYrr/btpBPEqRxl
         rj/FZHK0LpbFsmazqm/hMw3Yjn3VRpOmq8+QHqeLTl2A4HWCbqb8LxLxu9wFGpofTYgV
         T+0jTX/orbtZZlPlULqJU8xleoKMz0D2DA70SzaRrlq9NM05VxK+AP6EzjcwNjXz2J/U
         enQtF2+j5jJ8feyvFAgSU7lHVGygZpYwGGS4hPgGlAUhih7vMj8MimaTRk1XaADtpxZR
         UK/w==
X-Forwarded-Encrypted: i=1; AJvYcCWTP84kmNRv3uTeix2BVRn27LHge9n326xK6Pw+frDvlGOUTLJJftJQbTj/OyS2L/K1YMEjjcieF+z7fUNAMj3JUXx/eo5yrvcNn+EU
X-Gm-Message-State: AOJu0YwcAbSWAmwIZwXQvWgtIvS5rslFa6kw082Tnz9+xOBIJOVUdYGF
	g5T7sil/5RtYaAF55N7QQvNjvVVoH6/1VOFpQRnQke51tWuxRrgNjF+KTDG8BgTI8dmHFeYkgQ+
	uIcO7s7MUx+E6OYBL5mBxchQOH0SIUQ7YTBoAwXtMfBHKrRP+xOTmfYP2k02mRg==
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr5014629f8f.20.1720694595827;
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgRshjr+9ksnHSGSXuJd0NT8hvn9tanR8CI3BrSShzgi64VEFSJ0dPW8iU0bEZHBQ8xO0GpQ==
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr5014611f8f.20.1720694595446;
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84798sm7375792f8f.38.2024.07.11.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:43:15 -0700 (PDT)
Date: Thu, 11 Jul 2024 12:43:12 +0200
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
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <Zo-3QIPbhBsv8EjB@pollux>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>

On Thu, Jul 11, 2024 at 12:27:50PM +0530, Viresh Kumar wrote:
> This commit adds a Rust based cpufreq-dt driver, which covers most of
> the functionality of the existing C based driver. Only a handful of
> things are left, like fetching platform data from cpufreq-dt-platdev.c.
> 
> This is tested with the help of QEMU for now and switching of
> frequencies work as expected.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig        |  12 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/rcpufreq_dt.rs | 222 +++++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> new file mode 100644
> index 000000000000..3e86ad134e13
> --- /dev/null
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> +
> +impl platform::Driver for CPUFreqDTDriver {
> +    type Data = ();
> +
> +    define_of_id_table! {(), [
> +        (of::DeviceId(b_str!("operating-points-v2")), None),
> +    ]}
> +
> +    fn probe(dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
> +        let drv = cpufreq::Registration::<CPUFreqDTDriver>::register(

Please just call this function `cpufreq::Registration::new`.

The existance of a `cpufreq::Registration` means that it's registered. Once it
is dropped, it's unregistered. It's the whole point of a `Registration` type
to bind the period of a driver being registered to the lifetime of a
`Registration` instance.

Having `Registration::register` implies a bit, that we could ever have an
unregistered `Registration`, which can never happen.

Besides that, it'd be nice to follow the same naming scheme everywhere.

> +            c_str!("cpufreq-dt"),
> +            (),
> +            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> +            true,
> +        )?;
> +
> +        Devres::new_foreign_owned(dev.as_ref(), drv, GFP_KERNEL)?;

This should be called by `cpufreq::Registration` directly, otherwise it's every
driver's responsibility to take care of the registration lifetime.

> +
> +        pr_info!("CPUFreq DT driver registered\n");
> +
> +        Ok(())
> +    }
> +}
> +
> +module_platform_driver! {
> +    type: CPUFreqDTDriver,
> +    name: "cpufreq_dt",
> +    author: "Viresh Kumar <viresh.kumar@linaro.org>",
> +    description: "Generic CPUFreq DT driver",
> +    license: "GPL v2",
> +}
> -- 
> 2.31.1.272.g89b43f80a514
> 


