Return-Path: <linux-kernel+bounces-530445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B7A4338A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FD6188E738
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFFD250C0F;
	Tue, 25 Feb 2025 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="py1Hb3E3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC524BBFA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453550; cv=none; b=ija406qRscAX7jqo72X4kEWbJk+b26NI2WBXpoWKFAEIhz0tV+qxEqXOffVv/kdEWhbVW+kErpdLRb2y7LFUEyUiRY8DhbBYfdbjDaV7q/f67C2jw3InWd9qa+6T487uSQBI5beUUWUNOAsjdRoIusLodvkDW05Z2J/j/XvEmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453550; c=relaxed/simple;
	bh=iGhucKO1xH2G33nc9CPDvje6X4e8o45jdIHriUlAA/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU9nRBNpGgkO0Z8jROICv86UldDtBFF4D4XHHpH7Er8gWxM1+nOSA7PVfztFhr/GjtB1RZF0yd3dhCfv9iSgZvSn4Vt0BYSQiRpXBGVGDG5l2cisGOI02UnxPrPoZKCSGwW54DhPxQSMqsl7ePWHdw605M0S/p1WCUrvf32+ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=py1Hb3E3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c665ef4cso88927145ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740453548; x=1741058348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okLfK2M0o/s/bLpxMLsbGPzJcNNKMZqAK2HxekDd8DY=;
        b=py1Hb3E3rDZS37rGbAQxc6bvRBeJxEIiXYualP2BIlItr5Tyk/sfqsUoQ4rphouYXF
         nrEvl70h/uXFeGaoDM+Ejgv265G7QLIYmNoRVKLKu9XVKn/LtOBE1y3zSuEh2fc86qlk
         XwA9IRlIsJHDqzwB5/Mh8Eez2QrxDb/M6SwZeUhHoU6uyCqvkAX/cxdev0ma7b0vZ/xM
         Sd65SW7BFYEkiVo2q8IwzxAs/+J6DZu5qDTL7qPhHqua70gOEirwaRhjzmdvcMpwslDE
         xW5U13/cOl9FNcFYOgBH4/IhD1FCLwbKXlmaEqT3FpxKo1Ck72iYbf5d0SKx/YV1R2bq
         R4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453548; x=1741058348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okLfK2M0o/s/bLpxMLsbGPzJcNNKMZqAK2HxekDd8DY=;
        b=GsxB0MFOc/tAcV8zP1/6OseDpssdo3mU1Bdnw8LmdgSgzj06iLbbhB7ilxGvX2jyPP
         uLEexdemfgOzA51pOFOGqc59bRUE54xWFURJLJCzKO6MFT+3QBB13Lk5ITFBLuTIhtVH
         G0pCzKn0FMqOTpZFC4L305pHqh9EpT+XiW041Gkwra6FIya/cgc1RS8IDNQ1DSBNm/7p
         1xoZStHMlXyUBahPo8SwkdoPAPWLKcyLzH0fIenMMYtnpaty3xFeMDE9zZJtz9jGTLBx
         fOodlbQzRbCbUq+JgMWKXrIzrMSGGAZQ+oiou4jusL7r60I8THt+c48kxQFrac0gVsGR
         3MbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnSyEwDZ3kFKNviQRywqDKkko/woKNJwkrpDFp8pU86D+40Yr3PeoC4QWPXMBriomGBx2ALB2jZkAMJo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52Fzwh2EfCLfKXVQ2bx4UIpspWHoFKd0Elb6EZiTkC4bGG+Pi
	Zd6MBcYMPwycHeBFFelumchHdOs3SLbfbI6O8jHJ7NpUQYuc0O9PFxnmTYbWt+Y=
X-Gm-Gg: ASbGnctqp3WkjC79P+pFbLs+axjO7RZL6DZJtXLI2bhEkDP0VgCcuiWNhtiMSFYtTd/
	yLrpMDGFXfl66cJWpeHY4MQvbcuL3+YlsOODo7oocLJTKk40eVOHtOimg9CU8ZjxG3M6q/5+WMP
	KxhFvRWbBYHpEvWHSoypUFYef0FyOUeSWp0tM3pbx9uzCk7ivx7hYrjXShFBl1LDBhWCyQvvL3d
	NyZcAGk4/CyWWUjQziywC+yKOt6Twtx3+1CwGkdc8ACOtOOljdc2ERTvlpyQI/rg2Lkz3pBvsxk
	oPGiWAtDcGiwg1X0wT+twCSmhVA=
X-Google-Smtp-Source: AGHT+IGwP9mCcyL3DwKg0NjkD2F6ZEckc0c6miRTrYfkXRsNr8k5XeB4zhbt6QtFDhhSVbgmx1KyqA==
X-Received: by 2002:a17:902:f60a:b0:216:7ee9:2227 with SMTP id d9443c01a7336-221a0015760mr244998305ad.36.1740453548105;
        Mon, 24 Feb 2025 19:19:08 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0b0df9sm3538785ad.241.2025.02.24.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:19:07 -0800 (PST)
Date: Tue, 25 Feb 2025 08:49:05 +0530
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
Subject: Re: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API
Message-ID: <20250225031905.c63mg6hr4uddncbk@vireshk-i7>
References: <20250224233938.3158-1-yury.norov@gmail.com>
 <20250224233938.3158-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224233938.3158-3-yury.norov@gmail.com>

On 24-02-25, 18:39, Yury Norov wrote:
> From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
> 
> This entry enumerates bitmap and related APIs listed in BITMAP API entry
> that rust requires but cannot use directly (i.e. inlined functions and
> macros).
> 
> The "Rust kernel policy" (https://rust-for-linux.com/rust-kernel-policy)
> document describes the special status of rust support:
> 
>   "Exceptionally, for Rust, a subsystem may allow to temporarily
>    break Rust code."
> 
> Accordingly, the following policy applies to all interfaces under the
> BITMAP API entry that are used in rust codebase, including those not
> listed explicitly here.
> 
> Bitmap developers do their best to keep the API stable. When API or
> user-visible behavior needs to be changed such that it breaks rust,
> bitmap and rust developers collaborate as follows:
>  - bitmap developers don't consider rust bindings as a blocker for the
>    API change;
>  - bindings maintainer (me) makes sure that kernel build doesn't break
>    with CONFIG_RUST=y. This implies fixes in the binding layer, but not
>    in rust codebase;
>  - rust developers adopt new version of API in their codebase and remove
>    unused bindings timely.
> 
> CC: Danilo Krummrich <dakr@redhat.com>
> CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

