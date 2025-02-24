Return-Path: <linux-kernel+bounces-528640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242FA41A18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F01E1891246
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142C252900;
	Mon, 24 Feb 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmfp9WQS"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AC24292F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391198; cv=none; b=AMZE6iKo8NnN/iDDe60mmD4otA2vOAXKwnLiU7nzI45sN1WPlf6PkL5iH0XnNPZnDs6A0pG9D6G2d19SfSklaINrEig70Q6HXSqEdhpzRGPosaIeF/yMuu1P5V0AfKYvffnsc0Mrz/igugHvlSkmN2gFPyqx/1d5pCwF7N1oqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391198; c=relaxed/simple;
	bh=gkcWo6CbuipnuwBWmiERHV9pRVv4+yAvrJkF5cLVnqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgRZdiMIMh4o5ijcfTBODAOruOLXXL5VJBt6Na2NwM9TyfzOd/H+7nI9QTU3Yc7l7ogDbNX3jcPm+WlGCcaTCR9BYUrNqVUU8Zm2FUZUAomfv3IC0OCo2rULWciEuzYgVvu/TgF3fhN2MF86QR7h4mTvuKQ/ex2HVJWJMDQu+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmfp9WQS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fcff77ff9bso3735488a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391197; x=1740995997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m/misXjt0Q5BUlaADzuQsIymnQ6d4dUSOqiq4YJRiI=;
        b=xmfp9WQSnKiUHR/OQ9XeMlpxl/W8kLoEFW24Zc1zxPooalMafc5nahHvVIwhB0hpGJ
         klpdF+2aOotaZoA4ycsOTXN7pECOh3qEWvE+usSXy6e9vYUWwyFd+UJz1zy2A+uKXaaa
         jTUJhLp2zh6GjhhtgfLShWG0zrZdNRxncvm9w7tgy7EkojPD0rtpjAvVYMZkLVzN7zWd
         gp0UC4IhgOFz2dBNali8fAUayQMUVRzNYQz9vWrSHQ7LSI3c4C02bFmwXHfXxoH1tiof
         LSOx5eJZodjKuFtVufo0PUKDfet5K18E6dtyJp4rG9WlHvXU3zGnpWh83NaplXszcF/9
         H4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391197; x=1740995997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m/misXjt0Q5BUlaADzuQsIymnQ6d4dUSOqiq4YJRiI=;
        b=B7Mas3jIJw4ZYI9fsaQlIrhdUMAj9dX2DEBmTkuy4P7fGjd0XvQV/p45efJ/8cdZxT
         DGtBbinpdG2GWoldoiI3NEB6hEPMkXYEc1XCvcQMBIntCKWDLB9TPjwakb8LQYLD6otx
         gNX9jSlQ2v9RFOaEgtwDUedYdN/Kdd73zq5/I52txqE05mnCPkUsTO4Uixd54rRYUIdg
         0UPA3cQiz/btWQTf8srFWMduc+hH/bSEOrCCzOoH/mRWvO/7gV5bCWSBVWo6I/mKj+ZK
         YmVwIJrTq4ejq9v3c2Eazd6IZw42qGiHfnxOBuU2g0uWRr5WcaR5b+rbacWUe6XIkJUw
         QEag==
X-Forwarded-Encrypted: i=1; AJvYcCWkgP4pHt3aD5ku8SUwLA6jmIswMmRbk9JfI9cYbzy6Cr0qy3KkJUvtnnxgfGbDJHJcSvN0OfbnmtIsW/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVJBM8v5oUG0dlnUtYXPLk3KVBtV/cbzfckyNzpnQ35X2qHhH
	waYaxqwZeJ8A3itnF6m9LKmC43QTRN2dyCybryv6gJad6ZoNhEnT9sY4Qcvh7KA=
X-Gm-Gg: ASbGncvXg16iOhDIj41jNqflmnrNG5PW2fpFK77dOhY1NINEdCPdR/tWGp7THqrKbt/
	igFNDNE18VOcQkjkIEaZSkjOOsMVH7A6Xf2nYr4w7ht6M1wA0a+bqwTmqDH44XwEWBoIrX0/uaV
	pHPt65f9jRQVoTF+cVdWrIcxgR42WX/nvqiMAkF/+ANk6HK1AQjGjDEAjfhAWQogh2t6SRmTTvQ
	/SbaQSGgKEn+EAiL2mD8f85jjV79szLClwQv/IqbQIEIszSLJCK4yuOhQGGll7r1tIDEgWCdjzJ
	y6ralYpXVQdGcyLrtQcbYwTsBmA=
X-Google-Smtp-Source: AGHT+IFGXKt2Ne+312FHQKlsxHl1O51sDX7kIoA6jMtZwlTfC7DlPo6BokxDsPaa+yv/IacOx2QUMw==
X-Received: by 2002:a17:90b:2644:b0:2fa:d95:4501 with SMTP id 98e67ed59e1d1-2fce78c90damr24754674a91.18.1740391196814;
        Mon, 24 Feb 2025 01:59:56 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb5bsm6054636a91.33.2025.02.24.01.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:59:55 -0800 (PST)
Date: Mon, 24 Feb 2025 15:29:45 +0530
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
Message-ID: <20250224095945.xjcjwkoqlgcsd2np@vireshk-i7>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux>
 <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>
 <20250221215931.GA134397-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221215931.GA134397-robh@kernel.org>

On 21-02-25, 15:59, Rob Herring wrote:
> It would be nice to handle the optional case from the start. Otherwise, 
> driver writers handle optional or not optional themselves. The not 
> optional case is typically some form of error message duplicated in 
> every driver.
> 
> Every foo_get() needs foo_get_optional(), so let's figure out the rust 
> way to handle this once for everyone.

Are we talking about adding another field here (like below code) or
something else ?

impl Clk {
        pub fn get(dev: &Device, name: Option<&CStr>, optional: bool) -> Result<Self> {
                ...

                let clk = if optional {
                        bindings::clk_get(dev.as_raw(), con_id)
                else {
                        bindings::clk_get_optional(dev.as_raw(), con_id)
                };

                Ok(Self(from_err_ptr(clk)?))
        }
}

-- 
viresh

