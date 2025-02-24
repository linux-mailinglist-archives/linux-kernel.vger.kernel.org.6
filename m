Return-Path: <linux-kernel+bounces-528592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F09A41972
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EB8166A70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7224503B;
	Mon, 24 Feb 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4eU5hQ9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907051A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390353; cv=none; b=Z8zdVVK6vHlmU2yXPbe5s19Zo+mdj/Qi72LnplL02NZcPqVA6H7ZhKzTriLsTgVY7jsRKvmB2pteQpMsxoHWnAlLCTpc1bkpRdMSV8DK7cx2PytCa0bqrvHlJCIQ+Fl3Uh2RJHgq955OI2knty/glRr5FnxD/jRTbTy2UPHjNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390353; c=relaxed/simple;
	bh=yI9tsEdrCq+JVlU4+kbKkbwWKZIvMC5rRRc9jI/P0aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOAOFq+x1jflMqsO3Wt9mv3WUx8wLXaQq4eVVBMzSKWAkRgPiNfP3yM+5Hl6jgAVV29ld4wfBfuArbBAuiutWcKiv03RySTdI6n81QnZ1HiRwSwZk4kREhvN8ZI3A0yb7sXjFDwiF/QMxve0stP6ZVnampPrJt6hAeO48AELWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I4eU5hQ9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2210d92292eso123585435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740390351; x=1740995151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxGqqeJLsYbeTE+fl2BbkVU3VCr8NgnhEkdjvf5/E4g=;
        b=I4eU5hQ96a3BiKJELv/W5VvP4ql8/+5FakUXyNF9yyQ89OgNA4TTEcOz6VADNhn574
         tDpjrdZzAaMVCfgrBP9w4wgwIMPeUXI7hKCf2185ulMVnIlVG1hn8DpQhB8Bfr5ZSwE2
         TOPk/lCzFyYCF8/o9z0Nh9/MEnOTYXbldgauErMmgw2hvy6iUZGPb9I7A7wDW/rS15mO
         jMirpWR9gpYo9szt5uWmiiKSoG0rGzYBVZkEcUfY0o5uB4OXMTOznDhDnmTztBFpq8ql
         ROGfgqqk76i1XxX5iPGRPP8phk/ljgjWXBEyMYQB20UNiwKJkmkw3F1r8Bmm2pyv7NSV
         hZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740390351; x=1740995151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxGqqeJLsYbeTE+fl2BbkVU3VCr8NgnhEkdjvf5/E4g=;
        b=n4melqV/nvX74zB/TfLzUQ2wDoEuttXA+qYrQa9jJSH62gsCHJpwhCtEtXF04NkmP7
         GSKn0HHVkb/LuZpAUJBKCFt2BnmFncT8dRvn9MKG/3Zo3ZHAMPDtrkBRg0a/K8aKsqIk
         kO73FWyiXyDdC04sSuF6vFw/Q38/4QEW2Xl4huVaZlcEDPbUVd+APShXt5BtFFG6uj6H
         0m/BStlHe0t+SMKrqX1Ib+513vA/VXAz1EY/KCZw6Ab7jGDfySBB14AvLk7G7xc0qJfx
         WTO1lNfFIIMsEWZdbUyVnHeObDTQaHtmfhT461rOz1hfuSUaC0EqbXbGuUSp7w+uwqc0
         +4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc1SmNUMo0CPMEWzRKuAHeFWxXEhhBiGBJ1q43zKyTYJpjMHfbSbqBEnBbUFuuQaknS9KwH7bokPRkiOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkdWHxYpkN83GWT+4PSBpMTGCJhuQM7Bj8YuRjblepyj3XFXw
	9NUEo7NCvolrSifPw2zOvf1ON76hMzHvA1d36/CjC23042DXdHtZlUsCAvVLakk=
X-Gm-Gg: ASbGncuTSNAmAEzbY6H5zOq3lwkNtTZlkPaR4AJlqmLTF+CvihGU7l6z94sRfomDLFB
	d63w0h7ITEli9giSXWERwqpdqQTtBznysrEfZYvBZhPhweBXl9x3dGVimxofqlcIosQLFmO9g+d
	IF81Y26RydGsnelo7kedPaegBXKKVxlrPGenMbHFJIwbIzJTpDO1EsQs+9vhcREc8A/vhyC9wrY
	Cjkn6VGLYcc1wHQ5JCKQcwS4BGCNumybQ36BtNIl72H4CaK5dgfm/UWoOZ7+BdvYL5DlztzOuGe
	QVEzAuCACCZ4GSttBSuF2KViHpg=
X-Google-Smtp-Source: AGHT+IFJVi7/YSBChXY4dh8iK5Nu0pMgjUbuxiXxygSfU840h8IClcdVJYvYBB1ghUBATj9XYVnhcA==
X-Received: by 2002:a05:6a00:1956:b0:732:6480:2bed with SMTP id d2e1a72fcca58-73426ce76a4mr21390090b3a.13.1740390350591;
        Mon, 24 Feb 2025 01:45:50 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73287ed12e8sm12957914b3a.180.2025.02.24.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:45:49 -0800 (PST)
Date: Mon, 24 Feb 2025 15:15:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Message-ID: <20250224094547.dv3apdbpwhesminm@vireshk-i7>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7iSHR0F2QpiNpMZ@pollux>

On 21-02-25, 15:47, Danilo Krummrich wrote:
> This was badly phrased, the current implementation does not need to consider it
> indeed. What I meant is that we have to consider it potentially. Especially,
> when adding new functionality later on. For instance, when accessing fields of
> struct clk directly. Maybe this only becomes relevant once we write a clk driver
> itself in Rust, but still.

I don't think we will _ever_ access fields of the struct clk directly.
For the most common use, common clk API, the struct clk is defined in
drivers/clk/clk.c.

> > MaybeNull<T> sounds nice.
> 
> Yeah, it's probably the correct thing to do, to make things obvious.

Still need this ? Any example code that I can refer to implement it or
if someone can help with implementing it ?

-- 
viresh

