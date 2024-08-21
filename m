Return-Path: <linux-kernel+bounces-296032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC795A4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D05283D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788681B3B2C;
	Wed, 21 Aug 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="To6gR4n0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759561B250D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264479; cv=none; b=C035e10oHQMODLI3DoNeUD9eeBf5PAuJuyFXagLK/o/4zyyIOPfPlmxgViA02YBHGcCyG2xcYrCUHoImiB1fMOYLkiv8WzC+slGOPd3aBQ2801yceyMgSw2BVokZ1khcNR5nOISkKfX8pPcMBvdabcoF+naX9zKL4Jvu2okp8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264479; c=relaxed/simple;
	bh=NSkAYr7bCmb3Whw3daQ77DB27/Rap81/w8JLe5qOJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxe9OW4isWfM4ZLmKu+S6rNa0Q8kC2MRoHijoKLrA9G85LUi6vySz76yt6se5fQRYVBXISVckgDEVD9+WewpFIvcFULuX1v5eSwxft5M7OgfObVuPONAZumasC0Tid3hULzvhbB7skdGAa0Q1O0n6ffBW2EPGCuX2VzjNqtH/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=To6gR4n0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7143165f23fso158134b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724264478; x=1724869278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLaHZXNQ7BrbOIHjJhTXeFkX6/m+9PAM08pS1uhnqTc=;
        b=To6gR4n0/NxZgq5CmUwwHcgS5sxPFKjrEWc5zzTBAmfvBCS214HO62SX1zzS7fdMZh
         8YtdnbKOYpx+rpdLFZR+eqdt5zZmgpF+tlZGhfFQZ/u4gmP9PIW/YvxBk5DF0a4BbKCC
         TxhYUdFNkwitLmqkjBZZewx6xzrIR7kts8KrZKHg/wYLbB0Z9Xbmwad270kv2nxm/joE
         Wzd8QCI0glUkQ9OPh9gRyarJJvsXdUXWpR9R188LBpqFebeZhKFwwooOnQM4/wt0vhQ5
         MBcFNJoOAJBcRXgGBixs0HPuY7LkcGpbVS2NBs6pWbdlyz2eBzO8L9m8yWqZpo8EqvsG
         3WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264478; x=1724869278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLaHZXNQ7BrbOIHjJhTXeFkX6/m+9PAM08pS1uhnqTc=;
        b=i9CZAKljC+pzFIwUC/VRVrxHryv3Rsm6dwRxdLziw6RxcrmZnbhjMPEXZn/gtr1e5P
         1ekoXnELnyZ4EUrU0X6Y2+rKRIi+w99Lb2SB+ZIOSWUf9Xpijb+GO+GdVi72tHIRMBer
         S4c2JM8QumtQ3LO8hWQ2ZKKnT5Tz2/peUD8pM5Atl6uXlF/v9RZoTzU0TwTZCjSNrvNQ
         m9wDK09Xh9hHIOm/9i35a2H01+coXaFCCv90UOJ2/IlOzck9gwmSisT5jRNUuRe8QD/P
         tNS2D5LjVSi1G+In0NQAoTdwM/443NgwA8dstUzo7Bl88YgCdeJ3bNksCukMK1+v2V+4
         gtIA==
X-Forwarded-Encrypted: i=1; AJvYcCVX7Xkm+pnrf163qGrzJWKNUGo8fsrW3e46igNH8G3yMzeM5v8wmjoi4bNeZVk/BVlzlVAcunCaJ3btB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxVWb1J2i/u0WiJhRGI1KMPdpXSra9zgUjZuFQM3MX35vWb7p
	e/tnxn8atseZxC8DzYxzMnnJ3CNC9QFHsAqBJK/I7Pa9lA1uPSO5ZA0bACIxMg==
X-Google-Smtp-Source: AGHT+IEm1ZehgvYO1cvgACbjrPTylob0tJBTNrg8E6mB8b6jByYU12rCK6TYepFT8mmhNG1+9jhoTw==
X-Received: by 2002:a05:6a20:b598:b0:1c4:919f:3675 with SMTP id adf61e73a8af0-1cad81a731fmr3349633637.35.1724264477214;
        Wed, 21 Aug 2024 11:21:17 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3aeaasm10248967b3a.191.2024.08.21.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:21:16 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:21:11 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Jinrong Liang <ljr.kernel@gmail.com>,
	Jim Mattson <jmattson@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] KVM: x86: selftests: Fix typos in macro variable use
Message-ID: <ZsYwF5QJ8gqto8Mm@google.com>
References: <20240813164244.751597-1-coltonlewis@google.com>
 <20240813164244.751597-2-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813164244.751597-2-coltonlewis@google.com>

On Tue, Aug 13, 2024, Colton Lewis wrote:
> Without the leading underscore, these variables are referencing a
> variable in the calling scope. It only worked before by accident
> because all calling scopes had a variable with the right name.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

This might need a fixes tag, right?
Fixes: cd34fd8c758e ("KVM: selftests: Test PMC virtualization with forced emulation")

no need to cc stable tree though, since this is very minor.

Reviewed-by: Mingwei Zhang <mizhang@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/pmu_counters_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> index 698cb36989db..0e305e43a93b 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -174,7 +174,7 @@ do {										\
>  
>  #define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
>  do {										\
> -	wrmsr(pmc_msr, 0);							\
> +	wrmsr(_pmc_msr, 0);							\
>  										\
>  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
> @@ -331,9 +331,9 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
>  	       expect_gp ? "#GP" : "no fault", msr, vector)			\
>  
>  #define GUEST_ASSERT_PMC_VALUE(insn, msr, val, expected)			\
> -	__GUEST_ASSERT(val == expected_val,					\
> +	__GUEST_ASSERT(val == expected,					\
>  		       "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%lx",	\
> -		       msr, expected_val, val);
> +		       msr, expected, val);
>  
>  static void guest_test_rdpmc(uint32_t rdpmc_idx, bool expect_success,
>  			     uint64_t expected_val)
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 

