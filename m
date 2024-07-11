Return-Path: <linux-kernel+bounces-248623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9D92DFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04AA282361
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBC839F4;
	Thu, 11 Jul 2024 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUVHatp8"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767826ACA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720677967; cv=none; b=W6jREu2qEo37rhRj++Wd1Hbg8uKG1XLyCD9bEaSngXGxZqC0NwtwS0vBto49VWeATPSUoZh1fYBxZTkPekUOUBruIdRIjJu4Mvw9u9ACUSc5E5tuamnUpMSyXgjDRKjEctQPclyE1XeXaTtZvQjWnreQFc2f+KwPd5gHaqJHE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720677967; c=relaxed/simple;
	bh=Pct07P2cTZvGxvW7F2GXSza3Mvzjb0y516idEyqvNVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myPCoTYpCMIM3F84XoJ1iJntITdAJnbSycawlMg9kRyF3Co3tzIH1pUuJ2+kg7x1QOhnQ3AfXo4RWv1X3rPmenWA4FxQnf+0hBuAxJVFgbsq4uOTDfNcA08Yl1UPy+dvMWcoRAYnhUf8NeoBff5pNlwYvAsp/x+RXeioGbzVSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUVHatp8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c5362c7c0bso423884a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720677965; x=1721282765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1naGOzRkLRpp7KZwz3L99c4a5Zz60/yAipmQv8kxf0=;
        b=AUVHatp8vF5gYWwK7526wGdxIPpkALAZEMDYWToA4vF544UtTUi74jWaPIdQ1g9DPO
         pXNgvOD556DCuLqIYmyx4ryXxemvk5JIokhoqW5+5+spST9uOHDjhmq0Wht24YNxYy4H
         3aPFEyqabzkry67W2RxBhndVTL5ecwW+z+iuCmRyApyD3cWaOnBZQRQM1dnTrzGg1WQJ
         +VsDP2/qTo9iYDDHE2Hlh8vucEjwshP1gFAfs3boRv9ycPxNPw/ffgrwdtZ8xxG6gVUW
         DyACbPE9oreHJbJ1X+duzTHNc/TJy427YHK3/EkGGnQ2T24fJSSxKxbPVtznV5pM7ypi
         aAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720677965; x=1721282765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1naGOzRkLRpp7KZwz3L99c4a5Zz60/yAipmQv8kxf0=;
        b=IJg7TA0B9pLFSbYArOJovNjQQ0lAZfrzUR/jxsMxTfBL1DPTZyyf4BXfn1ogYGaVC4
         f8uNDP2Ykb4VlScjClD/6tFZ9AJFTTgYvZIRNDdq9a6YI0IbN27TfzDOhGx8vORXeSqr
         2dYNrT+AmDJ6Lcd/lVkbxKKC+6uLlJ58rg/UEBo5lyBhpthzU29P1i4xI51xivm5WJJi
         85rm1wKihxF4tYXcCsaRBPLLtdBnxWFDu/Z25JXk2Y301CLmnRjSaHX2MQYQEDa0gGr3
         eZFkAgSmJcBR3A7z86nf0rt84odMRiBNZnEKnrM3SkePEsil3H3STDOIkBZlrI/k01Yk
         eQEw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwLJEOWKek+ugZxY4jFmVeKK8iWrCdUMQmb+2DiKwNFyILFfqbb5vlR9OAAU4qTwj2Kfo+qkOsHNBYU+pAQjcX7OWWVW23iQGwPPw
X-Gm-Message-State: AOJu0Yy7lp4F1SIvmN+sX2Qjn6lsYgLRdc4xOonLXIxNeHiXFERazrZB
	MtOUcxyhUSwTHJ+OdkiQrclXPDNvZK7RR0l18NQfzlj9Vw4zcbY72gmLL01+Jbc=
X-Google-Smtp-Source: AGHT+IHKIRAKhiyYiKLP0CQNpVmFEZVj0D+u79CNLoPp13J4mrQM8iSlQeqWiA0KS/IHQxTYeT1Glw==
X-Received: by 2002:a17:90a:c7c9:b0:2c9:718c:73e with SMTP id 98e67ed59e1d1-2ca35c79e3emr6122202a91.29.1720677965084;
        Wed, 10 Jul 2024 23:06:05 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a951741sm13039837a91.15.2024.07.10.23.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:06:04 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:36:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 8/8] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <20240711060601.fmnttgqhbh2pitzj@vireshk-i7>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <b7df0c75cc07a451243b554fb2272c91cbe42dfe.1719990273.git.viresh.kumar@linaro.org>
 <f0016987-4288-4adf-954d-665b35ae1bf1@redhat.com>
 <20240710085652.zu7ntnv4gmy7zr2i@vireshk-i7>
 <Zo6oqfFX-TNIeaIC@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6oqfFX-TNIeaIC@pollux>

On 10-07-24, 17:28, Danilo Krummrich wrote:
> No, the platform driver layer will only guarantee that it decreses the reference
> count of the `Arc` by one, that doesn't guarantee a free. If something else
> still holds a reference to the `Arc` it will keep the `Registration` alive,
> unless it's wrapped by `Devres`.

I see. Thanks.

There is one problem that I haven't found a solution to yet. If I make
the following change to the driver:

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 315adca2a747..052ea2db095a 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -236,7 +236,7 @@ fn probe(dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<

 module_platform_driver! {
     type: CPUFreqDTDriver,
-    name: "cpufreq_dt",
+    name: "cpufreq-dt",
     author: "Viresh Kumar <viresh.kumar@linaro.org>",
     description: "Generic CPUFreq DT driver",
     license: "GPL v2",

then I get this error:

  CLIPPY     drivers/cpufreq/rcpufreq_dt.o
error: expected one of `:`, `;`, or `=`, found `-`
   --> /mnt/ssd/all/work/repos/kernel/linux/drivers/cpufreq/rcpufreq_dt.rs:237:1
    |
237 | / module_platform_driver! {
238 | |     type: CPUFreqDTDriver,
239 | |     name: "cpufreq-dt",
240 | |     author: "Viresh Kumar <viresh.kumar@linaro.org>",
241 | |     description: "Generic CPUFreq DT driver",
242 | |     license: "GPL v2",
243 | | }
    | |_^ expected one of `:`, `;`, or `=`
    |
    = note: this error originates in the macro
    `$crate::prelude::module` which comes from the expansion of the
    macro `module_platform_driver` (in Nightly builds, run with -Z
    macro-backtrace for more info)


And because of that I had to change the name of the platform device
too in the existing kernel.

-- 
viresh

