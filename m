Return-Path: <linux-kernel+bounces-313595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3490B96A761
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E203028400E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186621D7E2E;
	Tue,  3 Sep 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANS7AbxL"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F91D7E2C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391740; cv=none; b=k8bedt5Pa+kABZ5M0m2MG5Hdwl91uRq3vC4/ARPaVrsNMpQxuwfkJPv9r27T/aTjtfH0/0/pH/nBQNwwvWcKOxJg4ZTWUtcmUCk64rBSsecof/wHbhpHxDLJ5gTNONrVQsYrgn3FAV8VQJfP6QmVnjFPtXUfBcclDpD67bCxL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391740; c=relaxed/simple;
	bh=ajyeQAiqH/g7TQ0qSBKMMDhVqcIKSArCXzkzE5HHHuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjwf1KbOjcoMUpymBCqgJ/K/QIrI/es8KtShGOvcc9DD75g5Kgj2HtYdoVKmTRc65q+zm+QarnsnlxTVIysi6JWLFTR4CkcRr7bwrFs8W7cM+bEYmCbUSTdPTIr1G8D0a678smCCXqa6puCYELDkDRi2RkA7tzqwHFXRqw1t9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANS7AbxL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714302e7285so5177139b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725391738; x=1725996538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrVsF/xtcGUGD8dhVKqbX4p7PSM6BT6D+MzGLwwgGDk=;
        b=ANS7AbxLAIY3D5YFw6Diev2Ttuym4vzxtdHvAEvbfo0F/JZXCvJCaFdwAiOenmtfuz
         gF+SQqB1DKL+/cj7d9BMVDRr+RYX6ipYNP4F5TwoiQkkbfCLiBg3dglEAXULhc9FKgIT
         wMGM9IdEtHRcC/1YWig8Aw8qA4UTPavvYLJmtOVDqapJ3YCkTg9w2ymWQ5IiS0EvcyBJ
         5tjepwaSf5bv+IiGW5stoTVy2RyXhwuhr115S+E9JyIiw2wbrCTDudED93sJBDP9I2Tf
         1dRXJ3uA6T5sw/jVrc1PQjETOm8oqEoVabuPXB1BBN1g8uY4Ztky99ng3RuCw1qbm8aD
         HZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725391738; x=1725996538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrVsF/xtcGUGD8dhVKqbX4p7PSM6BT6D+MzGLwwgGDk=;
        b=RuUhwt0CKesk0+k02zgv4j57Fhq8IYkZrLWLVbQFb3SygTeCkvvhwsGQ1TqHH7FaSu
         UvoEKmG84om3vOogEY3wPG/Os2XcBI3AJAVLxqJythfSlej5ibaKtJonaCG6LG5qvrao
         ia8n5eTx/+OVf+PINEsy92ctqe8yQ1w03LawbsirCgoMsNAuQ4IeIlMx5bBgWxTbxpo/
         x1/1FnUTKRhGVD7PKJjJz7UXU6eR/WvWJ7UBYgb0hTRsFlqOCtNWHQn3hIcMyTFWK6VJ
         DFFD24TScjb7FREN5kgPGpbvFshCbXmd7sgAGB0IEQj6KJXO8vuflI1gtbohlRQHj+yI
         4M7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUteAapWzju9gmsrasY86CAzdz9TKIg5coOWj5JWgRzyCBVtY5QIhgAPBXhUrWcBkR8Db3mAhX7ylHmaFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygh75fv4d7cGiwHneZXYP1VB/PxW0dXHtADbQ6c2p5JerZbIYk
	8wDHoQs5PFi9zk7Kt1P70CBjb4sYbLIGZJWJ9k6xSa8Tu5Ns//8z
X-Google-Smtp-Source: AGHT+IEElz3s73Z8vQDiLNbxmkJO97s6+Op5gklyaZWZ9BwLzpCDb2P1V7M6Ga/Whaa1/GltOcGZJw==
X-Received: by 2002:a05:6a20:d527:b0:1ce:ddf6:f382 with SMTP id adf61e73a8af0-1ceddf6f40dmr10955493637.32.1725391738449;
        Tue, 03 Sep 2024 12:28:58 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd9287esm199810a12.43.2024.09.03.12.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:28:57 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:28:55 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH 1/2] cpumask: Implement cpumask_next_andnot
Message-ID: <Ztdjd9s-eLKrTU9g@yury-ThinkPad>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903190650.53644-2-mathieu.desnoyers@efficios.com>

On Tue, Sep 03, 2024 at 03:06:49PM -0400, Mathieu Desnoyers wrote:
> Allow finding the next bit within two input cpumasks which is
> respectively one and zero.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/cpumask.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 23686bed441d..5da1c66cfa65 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -246,6 +246,23 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  	return find_next_zero_bit(cpumask_bits(srcp), small_cpumask_bits, n+1);
>  }
>  
> +/**
> + * cpumask_next_andnot - return the next cpu from *srcp1 & ~*srcp2
> + * @n: the cpu prior to the place to search (ie. return will be > @n)
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Returns >= nr_cpu_ids if no cpus match in both.
> + */
> +static __always_inline
> +unsigned int cpumask_next_andnot(int n, const struct cpumask *srcp1, const struct cpumask *srcp2)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_andnot_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits, n+1);
> +}
> +
>  #if NR_CPUS == 1
>  /* Uniprocessor: there is only one valid CPU */
>  static inline unsigned int cpumask_local_spread(unsigned int i, int node)
> -- 
> 2.39.2

