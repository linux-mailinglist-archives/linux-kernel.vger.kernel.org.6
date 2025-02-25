Return-Path: <linux-kernel+bounces-530936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C7A43A59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873E917A4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C855263C9E;
	Tue, 25 Feb 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRJt0Gw/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3844262801
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477059; cv=none; b=tF9isu/Uwv+xLldokMsBugYNa6lbQFjza9lwcnfFQrTw3sqbOGc0dd+0/oX3lBhaOP7QWpS8sEm6HI+IxXZHllu9euIYZLUcPXlSQZcWDcDsoQsHf/zAqV8hW+eAfrjiRyiNapWfbziTtGDaTv8cDSsfck5yGbIzCCBkxVhzyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477059; c=relaxed/simple;
	bh=p6BtO1SPEiYTgGfRVtTmaaauZNwaUPFNQtWx4//eHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/04IrRlToMDGzeOwAQFsf44L3nkJRtBQNtOTbmw0f60Pt4Br+I7xa424XfwzxLf4uJLLcY6OrQoHn5KGLoIq3M1kB7GsmOODdfOxPYV9NyRjgt7tHjjow75L5CFlUfXcsoahuJuhingloMa+A536PHkmI8B1+uj07NFDsaFbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRJt0Gw/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d28c215eso82419975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477057; x=1741081857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHFlVMAkFi70oXxJTi8F3j9ugzg66NFhSakMattK2Gg=;
        b=SRJt0Gw/CBCRugy4nlXziSvNcuFA9XuJnuCc79uMJ5Kf6kJv49gMzEgroeE1vDtBhk
         Q4Hf1CU/2BC0Ptn3WgGJ5rBtsLGVgyv9abpkBgy3zxKd/hb9+4BTQqV6roQLG49JR79E
         6voI2Kv8ISOcsIDbKRGMWk5k3byp2LMoxhtrgvyHOGnxF/cb9bZkkk8Ag50A+Cccyg/j
         F3xlKyrhll+RhDG0oRdg6Cbng4IchFRogcvrjyC4fPLr5Ovysnp0roDMjb3EtTHprP0a
         /vkJjHnPybFnSfYoqN2+L1Gjmo3GPRd3Zk6pn4SvMG1oOXEI6tNab1KXDqIdOzlb2ClJ
         Ut3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477057; x=1741081857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFlVMAkFi70oXxJTi8F3j9ugzg66NFhSakMattK2Gg=;
        b=ch6MwnE2tN0nJplPMhGKi05mPQ/02q2mLJLFWSbrGIgdsf5C3AZbn1ocC57zEMBgXR
         01SVJG+OJKne8pxquBtdaggGlb2IkR0xNeV3UXCu1KePQCxajdXXoO+iOHmEqJf9YkCG
         nRehtgrBCNZyD+eS25CE5bSrHqH0mi25lWgma5wpfXmRp5sBvtob4ygn6Q2VZbXxnpWZ
         3dFSf9i9nB/sTW/gHbAZH6E9MviGza711OAVqR8q85WElAsfP4uJpjxXicbE7XrI9uFi
         IXDhbvtUrhvdaws9RWo/jhdEQxytvSmzqpcFa4/Iyxe5nygwIk/Xf9Ob/4pXoHiUw9Oy
         Xwhw==
X-Forwarded-Encrypted: i=1; AJvYcCWIbox92brFiEquGW02xNgv1Gf0WXyJotZ2Lk+bzHhC8pyxX1GWYQv7nFHOJz8qBYOuYKw4JTBIJ2JHpjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrId22MimPQzivXgiO7ilGCWUiBrjsblYFdDMSRrparfg9ROs
	A3aKZhf6KVsr938cImGvw6eXe+i0NXP+s1QaM7Pql4kWbN93bjSqC7X9IbG9XD8=
X-Gm-Gg: ASbGnctRqbbQtmmYtBR4C5zcyjQf0zMq3Q2Q0TPVfvyxwoaWmA1E5XJCHFNhfTARDBZ
	JupSvh2d7hryRoiUOg9upSdFR8N5jweUz5TBQPrH6aKJ4UHHbkMJ3fowM0IQK95I4er63pO+s83
	iBddfM9m3Qo4ErkhobD6h90wlnYvhQr+R/mahq8SfbytpTu+MWv02QnVwd7ihA2Xr5eHUQ8b0Le
	iOLZd4cTBFUrJfIVIfqFFSRgsLe3PzOz6G3S+HcPRHh/j6RXj/SqhE3sxwV+hybp7y5L2QrG8BX
	37HSBaJOmYi0EtpYIguLzXnVRa0=
X-Google-Smtp-Source: AGHT+IEh9+WnAiY4cGXADIGyyOzeQbN1kuedINyZawngjXfyPvJCRIP88vK4skeZvmAi6UCA6cE6vg==
X-Received: by 2002:a05:6a00:929d:b0:730:8d0c:1064 with SMTP id d2e1a72fcca58-7347918cd47mr3591985b3a.18.1740477057199;
        Tue, 25 Feb 2025 01:50:57 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6b8a82sm1071040b3a.6.2025.02.25.01.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:50:56 -0800 (PST)
Date: Tue, 25 Feb 2025 15:20:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <20250225095054.fp5xdolezdh2yalc@vireshk-i7>
References: <20250224233938.3158-1-yury.norov@gmail.com>
 <20250224233938.3158-2-yury.norov@gmail.com>
 <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>

On 25-02-25, 06:43, Daniel Almeida wrote:
> I don’t understand what is going on here. You apparently did not provide the
> Rust code itself.
> 
> Usually, when I see a “in order to prepare for …” I expect the actual patch to
> follow in the same series.
> 
> Right now - and correct me if I'm wrong - it seems like you’ve essentially added
> dead code.

Rust abstractions:

https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linaro.org/

-- 
viresh

