Return-Path: <linux-kernel+bounces-537867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC9A491EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E81893A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E01C7010;
	Fri, 28 Feb 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLlLCrUn"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909F1C3BFC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726589; cv=none; b=ur8QYdxfK3Fqxu80yzlu+fKWEG0BWWT0si1zwVXTM7vH+5NtTSqZyESiuwR/lJ0PBN26DEnnuvko6iSqaQiqXeAtA7ZNMkilzdpc3vgT6J5vKtzw2YsvycsQc2Jyr6+ExpIWfPBX28qerTiJShB6PIKtPjAgYdUHbkMKqQIKJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726589; c=relaxed/simple;
	bh=iLmf7VHKN4mLCBJzNobgXQNWaOG09tK0WB6HgkGt06c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofZ0JoqB6KXXBD1s7uf8CmZ3rnHidOa6XmKYzhlph/7FBs6eSqjzywLW+i8erox5Z6aittNjVqmydyO9gYdqKjtXfY+rcDW7zo3QjPJuezLq9Onbk7NdUykrLd+0Nq0Q1T5QCaZIlwJSO+yJjqfQlC+WXB17GNBmfoC2blVHxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLlLCrUn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d132f16dso25594375ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740726587; x=1741331387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uVvdhLNEV5gzmNCw8PklT084LdOXqMPcGarwgbJHaaQ=;
        b=FLlLCrUn/imVVsXkm4DT5pLZoEfQmuESZwK2p6zBiYjftchR4hbIgvJ+bt2nA62PDR
         8hrZqGayJ/it3blPHC1aui5ptCEWup9Rt8uo65MKY+t78aHQ/kjL9UTLrZoH4eRNNmCX
         bSr8guf9zVSxNrQHlUA/S+uU54Z+1J/UeVQh7xXnFT3akfwKVDaLlmUPGLouZY6dq1cr
         14IWQjhbL7SaXXJCR7Qh4oNDRI0Da6huuKeu21eH2Cf5woZIL5cruhELcE6yeW/HfBnw
         6gyA2Bdl0NApMoAGXuDv+GfcAs7kGdlHKweBRzq/l5Apf1OWyodGeLzfaJstPMl42vUn
         KkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740726587; x=1741331387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVvdhLNEV5gzmNCw8PklT084LdOXqMPcGarwgbJHaaQ=;
        b=uYZ4cDnvCKVWottKITVCAPvgYeXhJ0Q6PcZFqLf3bM03LHvqoosS5TZ8p0IDfbFWMR
         uCtg/B213G1zWD7Ku8jbiTpUKt+Z9sNiAI1OunfG/EX1JuBykShPPbNzoMJSikDT6drs
         ZPebbSrIrge0kFzI4yt79cD8hU5ZPuWCJd6h7d1CJl4c7RYH0rIjmkJJlu3QsNnohLo1
         5wWooj1x+J6YBGvQDsTSd6hjSUjC6nQo8NuF1IEW8MtxnKdos+XPnRyaaDpM6waGQyv9
         3lUInDyGQY9ugoS5VVajipMwuNzrQ+P4FW2V5L5/YfvT+3zd9QHTnWEimVq1hkOOKJk4
         9HqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUcIABrcLSX7ic0WE0ay0KV3uufaHrSyvDy0FezAbRjCyjvXJhLTp1xGqaBpemhDPpfHxz9CA8F2+yhdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzf3Mjct03TIQ0qyIuzbu7Jku7S0y3i/6b1sOEWaO5YRuS6tF
	3wfHBKpXIL3IblAWsmRROP6SGmP1I10bCfbP9ilM3mv5Z+y9SSGFwgOn4X5WD/j6VfTyZ7JDZk8
	E
X-Gm-Gg: ASbGncvsFVlZg2SnmpHLmMFX/SabhvCN6Azis9z5XyyBM0lIHwhAqyxL9Tf+ijuSLBx
	PefWE4r2NnZZeOD8KQAgdVY20RT7BAo/a5Cm9IH05/8lowr04ntO5UcYrl7RvWb3/yrzZrGT3xI
	pgypkt4gjiXx7RrLXR637D1xK7yP+iR2sRlO9h0Fb5T+xEOb/BDivqJ6jKWKOx1rX33QsGo2bPW
	LtGCY/wzPUDuJFEJaqu+0pw0qSgCSwaaSi4yP4SQGQHJWc5uoQ7P4Sc5LeuWqgh0Evu2DRNYb5M
	G6aWVJ/toE0wJExh+GyOTu9ItcI=
X-Google-Smtp-Source: AGHT+IHtIrr/zv3KmIfmlm1LqRGukhLRc6W/VmLS8Bw3TxcDi6JjmxkxRaJvEgcKpjVZOthALYnDdQ==
X-Received: by 2002:a05:6a20:9f86:b0:1ee:73ee:bcf4 with SMTP id adf61e73a8af0-1f2f4c97a38mr4342310637.2.1740726587503;
        Thu, 27 Feb 2025 23:09:47 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf23b6sm2701998a12.15.2025.02.27.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 23:09:46 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@redhat.com,
	gary@garyguo.net, linux-kernel@vger.kernel.org,
	linux@rasmusvillemoes.dk, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	vincent.guittot@linaro.org, yury.norov@gmail.com
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
Message-ID: <20250228070944.an5mbauxvxkfnn6p@vireshk-i7>
References: <CAH5fLggyEXyyaFNnmBCPOSX051TiFyAp0B8GfahbPg=+LrtUWA@mail.gmail.com>
 <20250225180223.763026-1-aliceryhl@google.com>
 <20250227104640.sa6vqdz7j5hwjigs@vireshk-i7>
 <CAH5fLgg8PvCEEks81Dy_3eRBkVG4P0a7usB2cfP2pbcSw495FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg8PvCEEks81Dy_3eRBkVG4P0a7usB2cfP2pbcSw495FA@mail.gmail.com>

On 27-02-25, 13:19, Alice Ryhl wrote:
> On Thu, Feb 27, 2025 at 11:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  impl Cpumask {
> > -    /// Creates a reference to an existing `struct cpumask` pointer.
> > +    /// Creates a mutable reference to an existing `struct cpumask` pointer.
> >      ///
> >      /// # Safety
> >      ///
> >      /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
> >      /// of the returned reference.
> > -    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a mut Self {
> > +    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
> 
> Why?

cpufreq core has a pointer to cpumask_var_t.

> Perhaps put this on the CpumaskBox and keep the `struct cpumask` one here?

Yeah, that worked. I think we will anyway have both type of users and
its better to have both implemented.

-- 
viresh

