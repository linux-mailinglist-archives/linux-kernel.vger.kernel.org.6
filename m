Return-Path: <linux-kernel+bounces-548214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1AA541D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BC616DD91
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5A19CCEC;
	Thu,  6 Mar 2025 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMpHgUwP"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE82F50
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741236495; cv=none; b=e95GIokc4b5KzHBchFoLo2GfXIqmVHYghORUYZDgAg7s9t1S9BH4AzDMZXdtWoOe8H9R2pDHGx7PQoR/e7F14dYteLJDKyDhBF2ThbaVlLiQshilbtpMmZi/25x9M8ElATigtD0chHSsiYnBoSGZWouC9MrV7qMfjf21PmvxmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741236495; c=relaxed/simple;
	bh=SkKfQC6CZcQpKn3fA8/UGW3rZ+8PsyS1MkVPLxlRNEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNNBrNPuC4Tg/RTpOQf1n5XJwjcBT4RYAeyCg24WnsXBP3eWDlMz/n7vimsg7eoi6z7Dg4HTVBCNRHyCAt9thLN0kASqcQfOm8M54xssNki/VOER7Ogzez6D7x9Paq5K8wUCeJIpKb3TuJUPz7nxx7r7j+EKE3Rlqy5h1Da35fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMpHgUwP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso4630795ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741236493; x=1741841293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVhCeF3zfzn4fOX1E4nH6Dq1VG6iFwnhwgnMjYfbfh4=;
        b=bMpHgUwPQQ3kBe0bHMxiBD4El/qNbW0D6ULjA0jjV1iyWPU4110SJdFhZHRVXDOfr7
         lVh88ROeGXrddGokIVlm2rKDWy9k6hol2v0nxuK2JoIWt4RkcUdzQsMy3CJd89u0C7RG
         r+Y4Y2/yWLmf14owCWZ2Lz1IRb8OpcmPn1YkDNLCRtUcAZJx109N7GKTp81pG75T2FcF
         j3hp9vWinhGqu5I5Xq7i3FwJh5QcBpRzUUUILSXCJKpToBUyoNwqhpH2y9Ewta5yot8R
         OealpzSFnOxNuw7b2410LcPSPcqvUEWn//NAphrv8lzirFTzgLM+kAeBt1sUe2OHRCly
         Q5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741236493; x=1741841293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVhCeF3zfzn4fOX1E4nH6Dq1VG6iFwnhwgnMjYfbfh4=;
        b=Yv56kj+9SnjR85dOLwvDHJOxc3fpeqz9r9Memi6cMbug/CHsNjGIOGOi7d0z3l97vE
         7H/s2IgF5XXt0wbnT3+yUKjgfxV6vHt2bQaoJZiAnDVEgLDk7Ssuud8mRAIm9Hcx6vm7
         E+brTjLlhWaBGDnnvC/QGWDIbP6R3dAnxBi3bFIo+TqbrS1I4KtxUkh/BPHexnKG0cB2
         1ouu1h11yI5fRI05lizcfPto3YxDm9QkHzkRorvk8ZQzEHj1S+XNWROYVW2+2klvQOu0
         yObD2GIBEKUKdvpr6bc0QlJWQ+N2gfvsWxUTj83BHNNaPDXAYxKj+WtI9jjA5nes47I0
         mafw==
X-Forwarded-Encrypted: i=1; AJvYcCVX6pUYeIEq4mm917ytVXyMRpRU4PnYySooSQuimkRjyGZgU6GzDEzFFNmGGQGrYUCOg7gU8wsVcNa7tGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dJZwz9TOfnx+2KH+w1U6BgOhxo/er9/8wQwKQzNRaUCKgfxX
	PpNvHa4sRWgVvHiCPigr6g0MdbunK3Cw1pq/pwFiC2buAZBdRHcthk0v63lS/hc=
X-Gm-Gg: ASbGncuqr6mYBxneOsrSte7jbUKlLJE8P2GjjG+teQ+Qfxeb/WScCcljWNwcHTDOg3R
	hQ4gFuE+xpJ4RN10nA9MOHX8wH2ZAqee8/XWHSAkhX0q2eUI+isphq2KSYjujOZJN4nZIwzjRho
	3O9++Kcqn853BJVaebHd02eT4QrdrmX93YFK1tXu2iZ7WlFEKO1BLP/kn9yHWqyiGFHPz/pHzVo
	gy8iHIVIttc0gVLbIhx8t1s1TepPfmN2N26MwtnBGyoGw1cb9ttMMqiC8WZiUDRyBrJVw/KcZNs
	DdxwecNoQffiL/mq1fqh1/IsU7Uv84wlfVEHJvtF1DVnMg==
X-Google-Smtp-Source: AGHT+IF/7SpYm7RhZEOVyZQ0/yR2A6FRsW6wiwdOD3yjpFUdPfld11PpaLDCbSfVpUDCWJ0TInwjUA==
X-Received: by 2002:a05:6a00:4f8d:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-73682d10227mr7674703b3a.21.1741236492786;
        Wed, 05 Mar 2025 20:48:12 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985191cfsm333947b3a.145.2025.03.05.20.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 20:48:12 -0800 (PST)
Date: Thu, 6 Mar 2025 10:18:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
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
Message-ID: <20250306044810.mqbo74nc6ch4dauw@vireshk-i7>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux>
 <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>
 <20250221215931.GA134397-robh@kernel.org>
 <20250224095945.xjcjwkoqlgcsd2np@vireshk-i7>
 <CAL_JsqJFeb66pt37wsTB7esCpRD1tpvqP1bvW=Nw8MmP5LvktQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJFeb66pt37wsTB7esCpRD1tpvqP1bvW=Nw8MmP5LvktQ@mail.gmail.com>

On 05-03-25, 14:09, Rob Herring wrote:
> Either way, but generally I think 2 functions are preferred over 1
> function and flags.
> 
> The harder part here is in C we just return NULL and all subsequent
> functions (e.g. clk_enable()) just return with no error for a NULL
> struct clk. For rust, I think we'd need a dummy Clk returned and then
> handle comparing the passed in reference to the dummy Clk in the rust
> bindings.

I have implemented it differently in V3:

https://lore.kernel.org/all/023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org/

So even for a NULL value returned from clk_get_optional(), Rust users still get
OptionalClk (Deref as Clk) and they keep using it as if a valid Clk is returned
and will keep calling all clk APIs (which will return early for NULL clks).

-- 
viresh

