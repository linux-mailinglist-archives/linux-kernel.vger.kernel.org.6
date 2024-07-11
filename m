Return-Path: <linux-kernel+bounces-249264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A592E8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6FF1C214FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D916C6A0;
	Thu, 11 Jul 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdTwny3L"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED616C68C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703287; cv=none; b=PhFynUNPkHo3da2D4w9wGCBVXckXbgXE9n54HsfHVyfWSodoc24BcAQqd314MZzmZC5UHxYLpVUVtH7jvBxmD0NKG61Q2ut1Sq3zxlXNQh+9JDK0fX0vJRwZDyseDTLra2GJU9MKWBakMI0xpo9hmukNJF4bFDiZVksMOY9ieCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703287; c=relaxed/simple;
	bh=iKLvXVCWEZ1L1B1OIv3plS/Y10k4Svm8KS1lPng7TAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3CoGwZyhnTBelZ8wcrd7x95jPRmJ6Qb0HAefFj3RpAZN0QL0VPy84mkbPnRCLzL9bUVmNv3gHgBXwhFKrtX6soolX9UaFu0DSOcLmlrmvjGGeMmKbGyh6fIYxcXtbClUTR2bYcomNjzfuEj6ShXbOY0adjHP5++uKd/ItRx2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdTwny3L; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b09cb7776so733210b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720703286; x=1721308086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4q0vF60ULh5IO/VmYdyQo5nT/zQh4fBZAg3It3beqc=;
        b=sdTwny3LnQXe3mrl8r2UeJNZ9qZtb2IGMfhE3xnlo/X5h4Tz64s3B5OFpEMvrsCRGR
         1R6OA/19xKlHZ56dY+05qMpB48uLVBfBQMXWLjpzIiUdEZcXdoI2YtLZNeU6sC/j0oyB
         wrxxzcwaOBKsyyYfMVPsk43ruGfHAbDGHtvHr9UAaekL9Xphzq3I2C631wtKmZpn8SpQ
         TXiyJXO9q/uX8svWAWSUfKUHzaryeDScNwuIsrlIZ8PIpYwwtfnCgZyUwOPJOi9DZW7i
         arf3LP2+XNvlGEQAAvdrIrKQIMfNFNCoAvP91skpeDYVgXC7YyuFX9WBuMuKkZOb+x+O
         kpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703286; x=1721308086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4q0vF60ULh5IO/VmYdyQo5nT/zQh4fBZAg3It3beqc=;
        b=MCmwR+A7tiL4m3U4n4Y+xtvI/O/TEqaUdoRpAZ/h0QntB9R/C3hJGvTo6+HKauuff5
         XDukABkcvEDbdaQf0Xpuk9h18EvRv8a6WbryPWkGRXjvDJykg96Q/OyEuPmIWZnuIcmk
         wwsOV8yJB+NM8R36clSWZDo2mtG9Mtoh7YWFyDLMQ0MVW3eHHDX95sLHitRXX+qsZcJ/
         ISImWEkdT+WbrmKr6kGh5pGYXWG5ngzJDMryWDRsxbGHIAb9BAqf0GfFZkq/kta0ixd+
         cZYdrbZ2c02TNav5LvRO9DGILBIGn4Vp6EeNWMPhqAvUk9796Hou8iKXZ2iMrqPQla8f
         7DFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTfv6SikmVxBmC02og/ncHfiasINAPgUJigpbVc1jvfvPiofC0MDLBryzFPYm+i19+9cvjvOvQYAC6SXn4YCkX+nAkTqa3nyeEcbrL
X-Gm-Message-State: AOJu0Yzk2qbyQyW5rtrSaeB985+U8KHQXI/o4QMuTFJR2jSAsv+wLAy2
	oFdHfO0+9n5IQpPWaXwN8VmOmhOyjQa1yE9Hn9eSz8o8ErvAkdoW6VsBWRrKwkg=
X-Google-Smtp-Source: AGHT+IGF/lwYTnH/yNgBlYFmzN6i0q9elfIFjJX82Lz71K3GRNMMLFBmqZwxNZJH309pIiGtCTcRuA==
X-Received: by 2002:a05:6a00:1950:b0:706:3204:fa4e with SMTP id d2e1a72fcca58-70b4337347dmr10360567b3a.0.1720703285481;
        Thu, 11 Jul 2024 06:08:05 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967791sm5607158b3a.118.2024.07.11.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:08:04 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:38:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <20240711130802.vk7af6zd4um3b2cm@vireshk-i7>
References: <cover.1720680252.git.viresh.kumar@linaro.org>
 <b1601c1dbdf68a4b812fcfaf73f3b5dea67f2025.1720680252.git.viresh.kumar@linaro.org>
 <Zo-3QIPbhBsv8EjB@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo-3QIPbhBsv8EjB@pollux>

On 11-07-24, 12:43, Danilo Krummrich wrote:
> Please just call this function `cpufreq::Registration::new`.
> 
> The existance of a `cpufreq::Registration` means that it's registered. Once it
> is dropped, it's unregistered. It's the whole point of a `Registration` type
> to bind the period of a driver being registered to the lifetime of a
> `Registration` instance.
> 
> Having `Registration::register` implies a bit, that we could ever have an
> unregistered `Registration`, which can never happen.
> 
> Besides that, it'd be nice to follow the same naming scheme everywhere.

Sure, ::new() looks fine.

> > +            c_str!("cpufreq-dt"),
> > +            (),
> > +            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> > +            true,
> > +        )?;
> > +
> > +        Devres::new_foreign_owned(dev.as_ref(), drv, GFP_KERNEL)?;
> 
> This should be called by `cpufreq::Registration` directly, otherwise it's every
> driver's responsibility to take care of the registration lifetime.

Some details were shared in another thread [1] earlier and I understand that
they are not very clear otherwise.

The problem is that it is not guaranteed that a struct device will be available
to the cpufreq core all the time, to which a platform driver (or other bus) can
be bound. And so this has to be taken care of by the individual drivers only.

-- 
viresh

[1] https://lore.kernel.org/all/20240620100556.xsehtd7ii25rtn7k@vireshk-i7/

