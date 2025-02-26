Return-Path: <linux-kernel+bounces-534193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECEA463FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEB01890B38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D482222CA;
	Wed, 26 Feb 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVFfL316"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0704190665;
	Wed, 26 Feb 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582191; cv=none; b=R8xS+dOUL2q+TZBqIYGQFC9wDwN6trbpNlMO9s9rNnDQNNf1QefHxHFfUe4tLkAyunCpm4c3wR3UqIoyL9WYL4krfs8NKRWu1eUdSNYtXN/l4DY0zP2GToeORuSk89KgJ9vZXgAIAISEC5oCtJWuZBFvNEp146FmojCJYMO9mT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582191; c=relaxed/simple;
	bh=fMoKzn75GHUYA90ipZu+q71iCAH9WvdZFZJ+RHG3XAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGLxX3PSaBegnQZoe9z6PcbgvtwhSu0lMJiWFl9QQ0o2J2/Lr4yKkVF61P4ToLVi+tWPMD/Pl2bgfni8DKNXid9owjkD+eR3cqm5HX0HaTHNpy9Dp7U9uEXcr4GoxRrJSqf3/bK00Xopg7JRiCOHbzMuezOMgzCher+eW/0Dg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVFfL316; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f4dd756eso149137065ad.3;
        Wed, 26 Feb 2025 07:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740582189; x=1741186989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgmChzRUPWrxU/Ro0HZWigmuIxGgec64e1FE97Altvs=;
        b=YVFfL3164/k2C18lmdJE9Wc5Xx3i/DzJaujEnVvW4fN+Q1l72XfnflOSiVo8FAhQkC
         IrTPU5jlJAzqNLOAC+KqPHbebPA4cbjyzHACSW0TKfEn0mHWJ6mS4NhT4ZzTkgsq5n4M
         ogS8Rzk9sb8MZVVg1YY/wnA1e8Vo+mrda2nocwPvgbZOmeT1urRh/vAc24VUcS+cMXGz
         Edvxpac1EK9zOne/Kfg5vVlCkjRX9NBPbXwO2M0rebgE+OmCeOZtV2yp/Yah868bY7CO
         gghY8rAQzxiuCOMvSS1VfenTEKp/ncD0vOeKXwRVxOulNAWSTjW1J3dYB/I+wwOjD8sj
         tV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582189; x=1741186989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgmChzRUPWrxU/Ro0HZWigmuIxGgec64e1FE97Altvs=;
        b=tB15cbaXnq1D8T/qOzT0PqoavkF6ACRVk4JbC92W4tdJyek6uy5/tyC5YgnQsbdjRu
         RG9wndbJT5bcsbTtwFUrrzgkm+RN6ObQ1Je3mtVhRSklRWeZQfT30sK2gttGpgA2GK7t
         G8KyqPLiOZmloSlViWXYzfC/67hIaF0TyIbq09DMplojDpnHcbkB83NwXFvTOEYzP1Tu
         feVkV7ui27XsRT+5AsdfaYRHCl4PPY7rm4KREcsI8Vd4UZZrnTOOJH6x4p8Ux1MhT1AG
         kAjA48biK8GdDjGJLt2Q6ln6qzK5bQdXucdN0j6Kr2ELBYyq6g63FRB6IBPiBdMAbfdJ
         53mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6uM2g+DY7DYpQvEB5mojjnNNoR9/GFHuNKSrNd/o/jiB8dXT6OpS6JK9jXnPFNYJHZaNaPKcZ+2q+nN8ZQqQ=@vger.kernel.org, AJvYcCVK4uoeTf63Wftk2QkvweZ5YIeZqay+FggWp40S4H9Cjdotsf07mL9OidDCoLDTPcH9IcvhQgCuaGl701M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvqKD924RAOaTYgerKTetwO/2eMtalyNm+daEbxVldLUnDhuF
	nMTVc+2KUX8ulJOnO6nqavmkEEJNg12wY8OljZFKZt/+ODT4ZJbd4OE9t/7d
X-Gm-Gg: ASbGncuRVPNmOyK6rUlE5N44Tyz7NO1fNei2LdnUKu8IXU2lwz1EZvtGFcaWg36+WAY
	7qbBX40tNC67dqwh/YmiJYyz8clu6DHLITf8ELBKaAxzM0Fd0bXgXP9gfayW2PMAtJQLv2fAZRi
	6z9l3eBHwRu1adiMHCIZLQEYiEuqwt/Ae0e56y6HIwqGUwbtEySJnl+YfpwKu5VfjgNS2kHCNEI
	JJLmZm7P5F5j4DR0Oferi0MybcJReW6Vcy8SCnvMhVoo8M5qzVOKiqioLcv2u7SNu/otJWakxxo
	FrpjdERZ9qTCXdgWd7qLl2zdjCzIRc1s4IkKd24vNHD2OI8X1g==
X-Google-Smtp-Source: AGHT+IFl++KPanhHASqmMVGgwPLmI6jBBycifC3LPnORcJTe5GZAgJBB2UNwedgMdxS/e6kNWR6Xhw==
X-Received: by 2002:a17:902:e5c2:b0:215:9470:7e82 with SMTP id d9443c01a7336-22307b455dcmr130723185ad.4.1740582188873;
        Wed, 26 Feb 2025 07:03:08 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fe8bsm33339875ad.54.2025.02.26.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:03:08 -0800 (PST)
Date: Wed, 26 Feb 2025 10:03:06 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add entry for Rust bitmap API
Message-ID: <Z78tKmTa3RVH327d@thinkpad>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
 <8c6249c6631f47565541d584fbec78cd2fbe60c1.1740475625.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6249c6631f47565541d584fbec78cd2fbe60c1.1740475625.git.viresh.kumar@linaro.org>

On Tue, Feb 25, 2025 at 03:17:15PM +0530, Viresh Kumar wrote:
> Update the MAINTAINERS file to include the Rust abstractions for bitmap
> API.
> 
> Yury has indicated that he does not wish to maintain the Rust code but
> would like to be listed as a reviewer.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec2428b82103..17e98d757b9b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4034,6 +4034,12 @@ M:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	rust/helpers/cpumask.c
>  
> +BITMAP API [RUST]
> +M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> +R:	Yury Norov <yury.norov@gmail.com>
> +S:	Maintained
> +F:	rust/kernel/cpumask.rs
> +
>  BITOPS API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
> -- 
> 2.31.1.272.g89b43f80a514

