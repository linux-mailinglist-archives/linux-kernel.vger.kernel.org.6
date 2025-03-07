Return-Path: <linux-kernel+bounces-550593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70680A561B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82853B4DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6781A3031;
	Fri,  7 Mar 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3vQW+Sa"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A71A3146
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332207; cv=none; b=TL5RmA7ZosZL3pBLJFmXt+AQstag7sHd6uAkH0No6wYonhT5q4UaW61iarUDBQmxdr3U58pYSYK7Hju2+/WRVQGz37PH/cixjUatS4rtx1bDRkUXNjCctTBsmc9ATu2nJy+TM9kRYZBsES1LfdGFzQWhv5xsE5AgR/vLlGG+WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332207; c=relaxed/simple;
	bh=QqafGuAhOIuebi5LncashDc9XDAZ2JG7WWMLwyg4leQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBa7EFTY/hZouPODTQZ1Nb3alZqfYj0fbco0HRC2JUeJ7TytuDGGR+eJjKk7Ozml9X+617dUp3cmtPkp6c4yrQKK4sou8H4/Qq0aBYCimaPa1cGzAqRVKs7OGnNG5yntRPpccrFfHjJYFMKKS+iTEsghfy2V3cm2Rtv8+qR7gfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3vQW+Sa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223785beedfso27266065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741332205; x=1741937005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCjDatYdwCCsM/WfG3Y3BLozY6pEAZzndrpXaKUoI/0=;
        b=Y3vQW+SaJy/gHv6ZVcpj26Nz/nPLhjopvhJCzdQrwcq2voCbSuX4omSWT8qy7xAoU6
         waEKUYLL6qLvXMNhc2pgzKAoT3Pa6ysytjhU0y77D7gcixTQlro4lqLgBXFxcLgMxM9X
         T2/+Vm0Py0Is+em8EOeTL4zwUAeMMX6gSuiBc3VkbCHT/Mbj4NdmlkCPGT3eoDyJyPfg
         cfI1r7SwWj87rjhLH0ylAMRoxLDdWIzztZ21+ZD/NISMBUfIxxhVgX4ruWHalnguGygF
         p6d2jb+NkIyF8ibwdYKnfldV8GF71x4Yot1B8DRwm+g9ZAVabve/YWx7RBtZ6ZNYx2gz
         fH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332205; x=1741937005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCjDatYdwCCsM/WfG3Y3BLozY6pEAZzndrpXaKUoI/0=;
        b=pB7mR3e6KZXlPMHoL+k8SL5AF5DMYnQ3gBdmbRZPpF1D6pIoXXshO3XDq1+3hfJXwz
         Dv34B7kqCI55ML5oopomDooZFuyJmotToDukt/tla3c5W+QjblSomujMRYUZQFywdd6r
         3+vCoarkG0oc1q0tOfFStmgYMKIXUV3HvLkej98QWMom5IA4FXoqiwwpYZK/b/68VRHL
         q1j9istJQentWd0IM9mb4vMWT9lsL2vYuNR4KzyDFHA151S9A9gZmFwJ8X6NXBu53kAY
         Q5jcFT3CZqSA5u1LXhvzYtkOLtUaa28p0tnpCoTO9MtKnZuZ2cZ6YeEWqUvo//YGCgpa
         c/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU+txaM2l2rOhvAVUwwBH4jXpQomJqCXzMbOCHMQrFbMRciAHQ6yn+WfMVEGbq20v3fi6OeTHcUuMjVNoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLrtIg0XX0qYIrqd0GBfe/lF3mRN4vJ/VK5A7jagXzWSDhcYp
	6Zvqg3iD+A/DQkRyL8HRiaVXsTy42FRgZduBu8idJFsR+Q+KQKWYfm7ZryRQXck=
X-Gm-Gg: ASbGncsCDeWaZp+R5aBJS8H/IrU4ylBl7nE9A7YMcjhK+Z8nOMUrPsgXIpGA6cqQYFi
	TOXzYsVz1zQY8cdcmyn08eXmuSQUTnTKCtI1rrhb8r8E2rCZ+9fLfTXX4C14xEBz6GrXk0sU7bc
	1VM43guXXEHyFMn18fprAhJBGKQ1Ep4BAQoHCf3tleF5rG8zI9LgF/N8pzauEBSbCS4Z2O2gECN
	QIydPb8jyN+Iow4Pnu8S9HRJden5qZnU3Vdur0/NxWqRqdNzo4DH7yCaZW3pwIgFYoKWMW57FHV
	xx7FV9LtyYCERk41TZhiq3O+B0cI8Dfc7ckmODsmRSu4LQ==
X-Google-Smtp-Source: AGHT+IGAtNyb2kEEWj4EBD2NQHNijL6RTt39L6X5JPOWRj3HjNXnhSpRkQZgMznJ39lNF6si/KC6VQ==
X-Received: by 2002:a17:903:192:b0:224:1ec0:8a16 with SMTP id d9443c01a7336-22428a97f21mr36812615ad.21.1741332205491;
        Thu, 06 Mar 2025 23:23:25 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109df225sm23794445ad.47.2025.03.06.23.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:23:24 -0800 (PST)
Date: Fri, 7 Mar 2025 12:53:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <20250307072322.5w2i7dxtcaani2ok@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
 <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
 <CANiq72=sU1sHvamC5REFPEC1aOVdZw9EKdxOgkUYESTR2yh3iQ@mail.gmail.com>
 <20250305114659.k5pptszvmusblynm@vireshk-i7>
 <2c17361891c4eb7edd947e5384cc9741.sboyd@kernel.org>
 <20250306044028.5d2w4og2juclktqs@vireshk-i7>
 <1ad3e7e2f8f2fc375b472d7676e47f5d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad3e7e2f8f2fc375b472d7676e47f5d.sboyd@kernel.org>

On 06-03-25, 12:58, Stephen Boyd wrote:
> Quoting Viresh Kumar (2025-03-05 20:40:28)
> > 2. clk is enabled / disabled from different routines:
> > 
> >    In this case the caller needs to call dismiss to avoid the automatic freeing
> >    of resource. Alternatively the returned value can be stored too somewhere,
> >    but I am not sure if it what users will end up doing.
> > 
> >    fn probe(...) -> Result {
> >         clk.enable()?.dismiss();
> 
> Yuck. Can't we tie the lifetime of the clk to the consumer device driver
> so that when the driver is unbound the clk is dropped

Yes, that is how it would work right now, the driver needs to store the clk
instance locally. As soon as Clk would be dropped, clk_put() will be called.

> and it decrements all the enables/prepares and puts the clk with clk_put()?

Miguel, how do you suggest we do this ?

> A ScopeGuard could probably be used for that on the struct Clk itself,

Not sure if I misunderstood that, but as soon as Clk goes out of scope,
clk_put() will be called from drop() anyway.

> but we would
> want to track the enables and prepares in the rust wrapper code until
> the struct clk can be inspected directly.

So Rust abstraction needs to do some sort of refcounting for this I believe. Not
sure if we want to do it and if yes, then how.

> The problem is we don't know how a platform may implement the clk API,
> and CCF hasn't taken over the entire kernel yet so we can't rely on some
> private API between the CCF and the rust wrapper to know how many
> clk_disable()s to call, or even rely on clk_put() to do the work for us.
> Can the rust wrappers depend on CONFIG_COMMON_CLK? If they did then we
> could have some private API between rust and CCF. We probably don't want
> rust code to _not_ use COMMON_CLK underneath so we can encourage the
> last few holdouts to migrate to CCF. I'd lean towards depending on
> COMMON_CLK for the rust wrappers in this case.

Sure.

-- 
viresh

