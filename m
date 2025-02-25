Return-Path: <linux-kernel+bounces-531223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B1A43DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9233A7FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38132267B0D;
	Tue, 25 Feb 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPpsczPE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA42676F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483407; cv=none; b=AUJqHatmP68aiReRhtXygmPuum3UBYKIfeIlge89VcHcTiVRzjvWtcmW//GkaZ2Ab9ILv9sJ9mJVBw/lBeHjdpCG+n0+7qxiRziIHXLZpgFqgoqvYeDPaMT+5PF5RzRcPhmJ+deyXfuMpx+OWeRuIt1PsOKfoc+Md0WpZXBjH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483407; c=relaxed/simple;
	bh=SPyeeF8ZDM6n3BTkbmavwfPW3rzBXox6GvsTJ1dVtH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZPYJgBJuxQxGk2MuSjndNPKFM3/AQCmwVGzldULFcOiKrFwnSQBPe7mbYxQXAC3h3d3LeTzDbk45g49x0h2shOD5YmNcVHBmzZckwlOd9vunAt9g2VENQD3v0YP31dMoE7B8H2DgvH9LLXVqTqOEEQdzH7g1ee9dqMkdFegGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPpsczPE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so114435045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740483405; x=1741088205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WC5C3PmHDugL9d2JtiXigt+VtVDMX7X1fFRsAgejZKI=;
        b=XPpsczPEga9uRDg0PbzIhCzB0QMqEBg9peZEIxqbORhGvZlp88cC5uPDQbBXT0rSWL
         jt2629EU6DGBZaSjTatwybtPWhO7T9VaSY218uC1QOA8W5oM7tUAdeyvK9eU5u7Afknj
         3sJuNWdqCG5W+NnVlvoTEqhNpkDdpBVPhN9pXecQxQSOlD2OPCspZwCkmYcsga8JciJc
         HoaejBYZ7yu91HionGAKtiOssHIj3iy6e+LQtEvcqBAJploPsBYNqQV/dHWZYfhpb37N
         il1c0Q8VfyxZ7FqKKli7VjTcpfpHK++7/OxgADSGdXJ7L+mgBKMcHovDmp/M4q89r03O
         BOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483405; x=1741088205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC5C3PmHDugL9d2JtiXigt+VtVDMX7X1fFRsAgejZKI=;
        b=gdIXqGOeQ5G0hqEQxccnVEkLlveIyqgkY8Fnm4drcwoEWZBZp5tagUL1KdA1c0t2Yz
         06A6+LFnenYSyBqebAkMShr9vNy8A3qDZ6IpGzIMlDh8PEdFel7MdimFSxviSpVcjptq
         qvbde/fdpDRvdAcxXk7e0kQweNPZs3QGsxvxyzaPNHuhUqTEPxxf7CNOGgymsrfVscn+
         TyGmkGXtqM5XcUeeq5pVrP6fDPBsUJHFhbxE4IV1ItiXrEOSL0aDpVmkkl9GQGl1uPNn
         hR0Uzqk3nCBcaWv6Ur4ArVrScVrrTGUvzRBBuWLpAfunzvr8N1o5VCOgVoagYeqGYdvA
         Vzew==
X-Forwarded-Encrypted: i=1; AJvYcCVHZqd1X2EPeIVORSicg5eBEwtMVPYzgm7oyfoGuk6fO99aLRWDo05qATjN35k8QsBbL7ctnIs+3qJoR7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEYJrasOr/VixTzC4pqOasfaYfPHR1UPRoPR3rQHwUABNwpqX
	mVS2wf55qDWrnMCYUR6XDCXHixCiHK+Ny2JxtYwX1AUCLebLjOTTiZDvLn0OCSU=
X-Gm-Gg: ASbGncv145Y9kJatB2/fWRFIgElnJbD7QXO3fOjlzPJBpxC3jQBLXZe6Z08alyAjtqK
	a7VRsF8RD+h68JwPUsFaaWeK4FT25de9dqiKtc7vIFmBSwL8AceBXGsIY6rrBiZ2AGdrH0OJqxQ
	t40ULef8I/5JdlLX/0oyqhF5upVBCLMtTWf4Za4nHdHvWeCTBvAINPJySTz1JTo0MQwzLJ12H/+
	LEB2ZHaTzKUOyw9mjADLJzmySHYl/C55j7/EztOSqod82k9jXIKg+XkxzGFeBbs34meVPYmNghv
	X9bzlu3vc2kcffvVJjfduOjTCus=
X-Google-Smtp-Source: AGHT+IFf9+/TCwETlYZrGvNe//P5GmUmZ2zWdQMKr87qE/PBaYFhyRDJ/Ygg/isUFT38R/PMmw+VtQ==
X-Received: by 2002:a05:6a20:6a04:b0:1f1:431:edaf with SMTP id adf61e73a8af0-1f10431edc5mr1333969637.10.1740483405445;
        Tue, 25 Feb 2025 03:36:45 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaac32a42sm1091445a12.70.2025.02.25.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:36:44 -0800 (PST)
Date: Tue, 25 Feb 2025 17:06:42 +0530
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
Message-ID: <20250225113642.5fek3cy3jvmusunz@vireshk-i7>
References: <cover.1740475625.git.viresh.kumar@linaro.org>
 <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
 <20250225105425.ooqvefiae5bmr723@vireshk-i7>
 <CAH5fLgjbW0yGm0TQcQEG9cc+i3WxbF8JKaqBUFD7=pJ-JkJ9zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgjbW0yGm0TQcQEG9cc+i3WxbF8JKaqBUFD7=pJ-JkJ9zg@mail.gmail.com>

On 25-02-25, 12:34, Alice Ryhl wrote:
> Hmm, ok. I would have expected it to format on one line:
> unsafe { drop(KBox::from_raw(self.ptr)) };

I did try this earlier and rustfmt suggested to format it the way I
have done it currently :)

> That is what normally happens when the semi-colon is outside the
> block. Not sure why it did not happen in this case.

-- 
viresh

