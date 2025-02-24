Return-Path: <linux-kernel+bounces-528464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E1A417F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4A83AAFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507E2441AF;
	Mon, 24 Feb 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fl4GN5s1"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13E24290E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387378; cv=none; b=HWmvkJ4ocF/h5uXWb0W5tFAPhru1K3kxiU9gwVCIojdpbNWw0NAPdfnCPMs0KMYQ/u76C37J8fPSz9JpxUJqAvOEVKMBG9BlxqjWHcQNnAc225VP+H69P+7ZgY4to9nRGWiRpML6XTGWyVVq3GAx1a4NtV9+Lcg+hofZouHGhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387378; c=relaxed/simple;
	bh=06AblsnnP+1xAekOfi7Ql/W2vrMIvov4zF/dPunqSk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1j6HvS3kEbWwVaMj9v+77y1UOXLoNGzq5rXPYagDTzqGeC2bWl5Eu/MSg8epAB1EvR1FqWkeJVZNnh2SpP+FM81gCheMsEyBvSnd9zuYOyibJQljbvRNZu9253uzGWWOCoqKqqXcflm80N53gBT3Ow2/KMefjX6rD8GaMyaD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fl4GN5s1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f4dd756eso81622675ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740387376; x=1740992176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaBv8v02Nb3a5UGjEfTd42AEkkKkLNKGhI6ZakaIigA=;
        b=Fl4GN5s1yDCpk7u6QvDORnFrj1KzI1f4ncIRJ4sP9Gv4vhbkuTHZQU8mNzT2YqUnyf
         mWuALNw2DfeDR71uhv8k9dh/6Hy5sHadU0mYF4XiAgEmzigEnoq7s1lAEiC/UgMJ7+2O
         WoGRrnKi+FcmqT6xc0k7IXCXgi8MMWtpq11rPV6AO4LY+Iz1BN01Ej/y9Lf5zxufLAvX
         t9gdPIe6MZRusdGlA4JehdGXQX5vic+hY2uVY/xCAE7FvhQUr6yzLXPp1p0nkHJdhPZF
         vEIqAgTvhovNVnCaR5o2qGHoIp+RGX6JkQR0tdo/mPqyNY1c6JNDpjcJx0pcLLohv9/6
         tpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387376; x=1740992176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaBv8v02Nb3a5UGjEfTd42AEkkKkLNKGhI6ZakaIigA=;
        b=AtoZ86s4Upi5fJaB6VmUTwLaQvOve0UcpkyaQkLMR7XUV0ue8ppoQReBNebhqFw4Th
         bV3Ov4OISMo3ejlL66rxUfaKt/owrL+J2T4bNu/w/spAio6IFRHnbFFu3NwLpwlAGnCb
         6quqyyL0x8CWVjriRN7370NgZwyjYhqb59vMyoAhOeVjRs0N2rnLTcgIH1d6pCJhv+lD
         m19rhO4HZcG7xU2dIPkx7S3phbm/vGdYzLCi0AkH0vl3i7WU78g+TFoDiq7Peo3EjtVC
         xrt/zCvtoxF50ig5d+wNBLiwovX2pMhEiWCeqkJrXcBDwzZKodJkh9SWEHguJ1cC6OnT
         OEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXghOQGFVgAWqAB26kC4CjvU1fRqHjEwxTt1tsy5W9MIPN2E7zWz/TfAhgBHf7sHxY3zNKfNH/BfvVODD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZ1CXPJOsXEdo6bfY56TO+hjneXHPJpr1yxmdkpVEn733y3CO
	LUpDPah9oDlUmd29DaZYw1QSeabLgxDqM5pJzetRGk5CgSQ3QFZiHj1Xo9B/YyQ=
X-Gm-Gg: ASbGncsAuT9RGFv7W7Z1VNA+iIWn49K0fGKNstZaRcLAW/Q7QZDfpKgF8vZzZqLD2kl
	ZjX6+GGJoqMzWHNr3Azp3fwjE5671crF1OdXd8ZTMNxm8KW/TPzu4p/wVZ+tVbTKzbnx2B784it
	/OAyxY1OXa8RokzrfJw69sYfsoGNoEwZe09L9d0fTY7Gq2oR4MDyiarTflAaKxTT8ahCu0C2bfA
	jsUtT7Soq4sAuPIOygATDlvXW4N54W73ofiW2X4FEwgJAUJN15q7Sr9KNtXrzFxPHaOfZPj4ZAE
	u7of9IiSTGERMAjFcu+mbkOmgKk=
X-Google-Smtp-Source: AGHT+IGY+3wZyrH4ts9kooPUWiPLq9Tpuvj09t7MxZdfeBddQhQdu28WeUptIuYXx4KhcW9eZJ1mmA==
X-Received: by 2002:a17:90b:2246:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-2fce7b3e4cdmr21262746a91.35.1740387376617;
        Mon, 24 Feb 2025 00:56:16 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb0499c2sm6028625a91.12.2025.02.24.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:56:15 -0800 (PST)
Date: Mon, 24 Feb 2025 14:26:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
Message-ID: <20250224085613.ksburgsarl35tvnh@vireshk-i7>
References: <20250221205649.141305-1-yury.norov@gmail.com>
 <20250221205649.141305-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221205649.141305-2-yury.norov@gmail.com>

Hi Yury,

On 21-02-25, 15:56, Yury Norov wrote:
> Question: zalloc_cpumask_war() is a convenient wrapper around
> alloc_cpumask_var_node(). Maybe rust can use the latter directly as it's
> a true outlined function? There's more flexibility, if you need it, but
> also a higher risk that the API will change: ~40 users vs 180 for zalloc
> thing. Up to you guys. I can send v2 if needed.

I looked at the APIs again and here is what I feel:

- I am not sure if the Rust code will have any users of the *_node()
  APIs in the near future. i.e. There is no need for the Rust code to
  implement Cpumask::new_node() version for now.

- I have missed implementing the uninitialized version earlier,
  alloc_cpumask_var(), which I think should be implemented right away.
  Bindings for alloc_cpumask_var() are required to be added for this
  though.

- One advantage of using zalloc_cpumask_var() instead of
  alloc_cpumask_var() is that we don't need to open code it in the
  Rust code, specifically for the !CONFIG_CPUMASK_OFFSTACK case where
  we need to call cpumask_clear() separately.

- The Rust side can have following abstractions for now:

  pub fn new() -> Result<Self>;
  pub fn new_zeroed() -> Result<Self>;

-- 
viresh

