Return-Path: <linux-kernel+bounces-531259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E8A43E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543C87AB8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF6267B1A;
	Tue, 25 Feb 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1Qc/GVJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F22627FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484115; cv=none; b=GNIml83W+fOWwYQ7I92vtGPx0iJW2woJpZgfO3w+SQhHq1djFc70dEo6MQ/jfNmLRWlS7JOUnc2ttBwvy5eu3d8k/s7UFRfWeLM60FViuRatCrnwRlhGtgOUkjEIb7KMlw9TZujF+/epFuI3jr3i1Aoev+gQXeB44PIqasAg7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484115; c=relaxed/simple;
	bh=jwIlbIZa94zqM8VMYCdmZHEfQAR94TbRRxSjsWwuhj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rozjZS3NPAvRRTed9TwYNzdnGlgvkSbrkekPiVPqUqeNFOsUaxdXR1YZ+Eb3ybANzjTWLlV7//fnKrqO99iTVgrnSio2EuNYRP/0Laa7fZ0MjzacSVvDmyWqTOV/bMHhFZ0lx7JG8PONOdavw0pS1asI4Vh6RL0ztKBDlApVlKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1Qc/GVJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d132f16dso83653515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740484113; x=1741088913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qdo+jGz+lwZjU3PirrnDaRQoK8hS5+i1xXbU75YPLdM=;
        b=q1Qc/GVJVwX+ME8zwLw/SeZ1lv+FVhFgUk11WLduiLPKLLOcraR1t5O6oi6ZLkIsck
         cz81exzZ3LOu9nSKrsJ7UMALSZfUNXqawXrc+N81ZA2LYlMkDSncZhcr7mmzTKl7qJly
         AX6LwEzW3c70iFU5xteMy3jxSv/tLJhJQOCqDoswDauU9DH4B6F2rQPbbR9Obi4oh65s
         hIbJdAxbR5ukUAiza73ziXDxR17VxW3U97/KFVGJ3Q/ouFXTsYmRTGtAopJM53yoyHw/
         fSwN1VWsNXpBqjrMTaa6qaQhzijA14+Kr657ItfxV8RZXngI8b35hSINBlLMB8NP8XyG
         OXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484113; x=1741088913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdo+jGz+lwZjU3PirrnDaRQoK8hS5+i1xXbU75YPLdM=;
        b=LCtKtLXud46UxIYFg64TfaThV/hktzrzJRsejsMPggdk4jXaVKjHtnhWu+NN7GQabr
         aZy8bqkqE0ohh3pqurQ/SA3agyPmpIRrGaKBZTwrdAjPghrKBu6+3VRDqXAnod4cnaDR
         65r6Pk/HFjA2CWamqqpoXdgdzy3QLhA9OpdRSkeqAfnvVHUgIM28i7o52GuTYFfC4L81
         X2hSu6+82pLO7GIaOxuloC/PrVB/9FhDlYZfh56T3AIlgKAYrUDS3eRRPnzxvvkVjqDa
         +e4qTRJUNjKpIe7uvCVx/lV4Y5LMWsbQhwrsW7YnIaGzlzZNI0l4H9gFFvzsTB3aMVDf
         6dyw==
X-Forwarded-Encrypted: i=1; AJvYcCWHobDhrFLuz6/s7fhaeqkGn3BMvBAXmN4y6tmlCYH6W/6pNrMYv44FhQ+Ilcb3oCy48V0s3gvfThXJNk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzzoWsI21zHCcrDstvhh7Bs+opzJ03ut50r98373kqdsyaDDH
	rUxyoDkkaBRO54LzrMPixLsK911mgN7mN0QS4KkH7pLp6u877wsJmOstCPRbrLU=
X-Gm-Gg: ASbGncvUQqUGpntMxs7GSku5otMnLfzPotsjKj57N+W3CnS1zKewBVqDj+Dyx6ioWzQ
	Baf6pCO6D+KRV1yHdEzCkbPhhd8T6mjI/yiZfJSkGd5AnmA5fzcNaYyKZ4oV5GWwD/i3R6ify+u
	+b34ChKXTVtOpK4zh7kX0ig0hc3O48+qnqMqfUiXFxmTlDSiqulllW0zP7T0DRVUAVfxhr6rGxs
	2ch3lPVslnAk524X7BQoCvvYtcCRaosc+TgmUvrol3AQHnf8d5hW1eHpe6hKTtNvxOSPjcIqJHR
	yprMMeAzBGVQE7Kg/88QPoSPf/g=
X-Google-Smtp-Source: AGHT+IGUKnJVC/nEaDn3iOHt54ul5Z63F/FxOemwqa0BCGDkyy9oqbocMm7EHttfLYn/TzlCRx8DIw==
X-Received: by 2002:a17:902:f550:b0:220:e63c:5b13 with SMTP id d9443c01a7336-2219fff4ef2mr264491505ad.46.1740484113106;
        Tue, 25 Feb 2025 03:48:33 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000964sm12370925ad.48.2025.02.25.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:48:32 -0800 (PST)
Date: Tue, 25 Feb 2025 17:18:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
Message-ID: <20250225114830.64p56bndn4hkkkgq@vireshk-i7>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
 <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>

On 25-02-25, 10:55, Alice Ryhl wrote:
> On Tue, Feb 25, 2025 at 10:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +    /// Creates cpumask.
> > +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> > +    fn new_inner(empty: bool) -> Result<Self> {
> > +        let ptr = KBox::into_raw(KBox::new([bindings::cpumask::default(); 1], GFP_KERNEL)?);
> 
> I don't really understand this CPUMASK_OFFSTACK logic. You seem to
> always allocate memory, but if OFFSTACK=n, then shouldn't it be on the
> stack ...?

IIUC, the idea of the config option is to prevent stack overflow on
systems with high number of CPUs (> 256), in which case the memory for
the masks is allocated dynamically. Otherwise a local variable, in a
function or a struct (which may itself get allocated dynamically) is
fine.

In the CONFIG_CPUMASK_OFFSTACK=y case, the cpumask C core does the
allocation and the Rust code doesn't need to take care of the same.

In the CONFIG_CPUMASK_OFFSTACK=n case, the allocation must be done by
the caller (on stack or heap) and the cpumask C core will only clear
the mask.

I tried with an on-stack variable earlier but ran into problems as the
memory is shared with the C FFI and Rust moves it unless it is pinned.

One easy way to make it work was using Box, which keeps the code
simple.

Should I do it differently ?

-- 
viresh

