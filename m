Return-Path: <linux-kernel+bounces-548213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6683A541B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110A7170C47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812519D08F;
	Thu,  6 Mar 2025 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlcOQw16"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F29195FEC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236033; cv=none; b=TVsVdFzaLh5EgwKoRc2PVCUzpk4OU+Sn3MeTFiThXwvWrh1cGP1G7YVAbM5RUvt9BS938+BUYdRfTwSmreGWWmjUrwr/+r6XzxP86QAtN3dLmT2CJL37HwZ2IqoOKDRBf687XzpcDjDqdQQ9ez4+CO8abcD7iSiPyUvXKhhE9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236033; c=relaxed/simple;
	bh=TNmgYWlFDAMgA64pxjarHkEGTDwxdEKRi2stuvaaK3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA7LrfLsfu0tZkrg9gISeN8WRVGxCgQJY95wP2jDhmoraHkoHBncQX2Dd+3TobR5Mfg19h6B/8tmjynn5midTz2d/OARBA76b8wxbn9BeUBEvFr45pPZa2wLmvEJi7mzeJqGl9xGBUqZ/Bg8ExBdixuc9pQvkuv9q0EriaZJN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlcOQw16; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2239c066347so2707155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 20:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741236031; x=1741840831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9YP9oXkSaz7kqYoQl3h7VT7PIEJ2wgfc59g3M6xM54=;
        b=zlcOQw16/QRjGvkg6iYXAaWKqSt4tLJAlqPLBUoJQ1CppdX0sVHh98ZKxxl46UoAh2
         C4aoLbuhHV3okiB1l6XeVyspWnW8i827mEuJZdiNZsQyUjNXdsBO9ksV1qTxabjXloC+
         ZzSMCapgEKVaaf8bxgEvw7VGKq0J1CkD017RH320wIwyjSAug6bljJBCjJ9ezAOMWDmc
         4jOrlb5qzsnmai4WW6XWiDVcyE23aof8rjh6tVf99YMK44PtRjCilKqkB8o42+HGD0qS
         MTuY/jYQbdRYmbIrnz6dgSlCi7VwUVeYSI5wH5ss69qNehHyJgCcA2rG//uGqvQWazrB
         PYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741236031; x=1741840831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9YP9oXkSaz7kqYoQl3h7VT7PIEJ2wgfc59g3M6xM54=;
        b=Me/WIZc4fvUHVA1G2boS2TttIeimKS6IT89l8pDuYay0NSpwZI4VajKV19X58F00MW
         9bEYnF/c98ouW7dBOZoBn/GfFpnWKj6JS6G9us7bY27RBfDlUuzYLYRcBUkIwGZxaryc
         o3PKqeIKHc7cCI2n9dfcVu1KUMOKba8YYiqcHaEoWY7KQM494WOoa2QrJZtJ9WuSVwjR
         oS1QozTg+cDfdmRZcH7nIUJUcmJsM6lp/pAZw0TAMUNA4jI8PlZJZHa0Png0rFuDERqK
         JQCggh98sxOPWW/hesw20j74PZ1bgeUKxHgSD0GcmTQ0oypXdEGrNZx/77MtOugrEu5H
         TquA==
X-Forwarded-Encrypted: i=1; AJvYcCV8hTpNMjHIZAbHcGPQbUFaJPJFp6fMLfT1a7/shvKlDyBAjjYmru9OcLIyB/PYt/H8gPSuzAuYRnpMzXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZP1fEBOl3Ih0gmbRHFTu5LfahaQgeD+fRgRDJQP5H9+TeYAH
	ek6BF/NFSxzOYlt6GX8nvwbGE/wlYn2AkbAhwSeKVlB7F3C0pkVC2Gp5W6E/ieM=
X-Gm-Gg: ASbGnctFpf8rTkv+SW2knbKPJy8ra7FxYY0AdPVaq7G50n7Z0DLlbNhYfi4uOh638lK
	0RRMuMy1FA+dXQH70z2Z2KkHXxNjQH7o+Alf6+4eUVl2Rn7I6kZw1z2tazt20FI2WShyLwGdyq9
	ul10LR0Wq3Jw0f1iL/II5OZsWHy7YSS32q1lrieu3ZNzU2Qpgc6oZHoErfqHmd7Z0D9YJR4Pcec
	LlhJYxGxSCC2ilbKAjy6q6nXMbPn9pSoMfBxh7ZGgoQgyQui6K2x15ND7F9Tdgas5K7Xxn4ygIG
	K1IV5cM9K3qNnfFlCzIv6AtytFvnYsNmtqco8zGk2elG9g==
X-Google-Smtp-Source: AGHT+IG7J6Pxt1P8Fs8iADeUT/+TxuIZLpkhrxazqlARnEVvRjqbFettsput67aKtZ+Lr4L7IRHItg==
X-Received: by 2002:a17:903:32c2:b0:223:66bc:f1e6 with SMTP id d9443c01a7336-223f1c6afa6mr107513485ad.5.1741236031221;
        Wed, 05 Mar 2025 20:40:31 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f75dsm2656285ad.122.2025.03.05.20.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 20:40:30 -0800 (PST)
Date: Thu, 6 Mar 2025 10:10:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
Message-ID: <20250306044028.5d2w4og2juclktqs@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
 <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
 <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com>
 <20250305114659.k5pptszvmusblynm@vireshk-i7>
 <2c17361891c4eb7edd947e5384cc9741.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c17361891c4eb7edd947e5384cc9741.sboyd@kernel.org>

On 05-03-25, 14:31, Stephen Boyd wrote:
> Does this mean that a clk consumer has to keep the Result returned from
> enable() in scope until they want to disable the clk?

Yes and no.

> I don't see how
> that makes sense, because most of the time a consumer will enable a clk
> during probe and leave it enabled until system suspend or runtime PM
> suspend time. At that point, they would disable the clk explicitly with
> disable(), but now they would need to drop a reference to do that?

Broadly there are two type of clk users I believe:

1. clk is enabled / disabled from same routine:

   In this case the result can be kept in a local variable and the matching
   cleanup fn will be called at exit.

   fn transfer_data(...) -> Result {
        let _guard = clk.enable()?;

        ...
        transfer-data here
        ...
        // clk.disable() will be called automatically as soon as _guard goes out
        // of scope.
   }

2. clk is enabled / disabled from different routines:

   In this case the caller needs to call dismiss to avoid the automatic freeing
   of resource. Alternatively the returned value can be stored too somewhere,
   but I am not sure if it what users will end up doing.

   fn probe(...) -> Result {
        clk.enable()?.dismiss();

        ...
   }

   fn remove (...) {
        clk.disable();

        ...
   }

-- 
viresh

