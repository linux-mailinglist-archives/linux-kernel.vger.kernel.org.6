Return-Path: <linux-kernel+bounces-396433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695D9BCD01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BF81C21225
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FA1D5AB7;
	Tue,  5 Nov 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0fiqg2Y1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846991D0B82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810920; cv=none; b=eSbS3hvnpZbyNiiJGT268RRexYD8Qa/7aMdWsA/oUC4Su7cYf7/TnXlUKTLWTyr0be5hfGC04gWG/JZ9CM0c9a0END97E9gCsS8YqvAe2cxDzUBvy1vn6opn61gP4hiYJbUsq5lNMVixvF7VlSfvXWkBDgbknzG+VaolkL+zuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810920; c=relaxed/simple;
	bh=z7vCOrw9FM+fwYTqvgedO7AEMII+CDcl3pW1kqpz+Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvq6eI8f3mSPU+ArywTOAjJkIG7LwcsgGbEKYolbRLklzmr+k0fMF9gG9/I5tzX77WWDi5NNXqw99QZ9MJhGnGZ4UE9lJaMh36qiRZmWfQsYiWyQ1v6IloODZdPTgsuoO7qGYtolGsONvx0kHjlU/46+7PtpLZCyeiNh2pOwq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0fiqg2Y1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3143446f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730810917; x=1731415717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPzUqJyq9Agfg2xFr5+F7YykIu7Y2oVke0GmFsSA2w0=;
        b=0fiqg2Y17wvSTnAQi4rSopClFWyVoRPnY64mgcIM0l9sVmBaM4W515hoKruniI3Bfg
         1JYr91szZCDg8NxaD++AXyYRNOaUbxp6QCFae5xFmhEH3qS1MAgRrZ+JNbYos1752q7Y
         FN5mlgge7JjZXnFRjJpYaFb/DfGdbkOl/0I59foD89F/WXekkWswAi/Eo9fL3ykYRBhY
         FDdR73LXwtBJf1+NSAXiqLYpxSxVy86R/cFLvDzQToAWWq636bpLIsclWzNn2ndRXrkq
         KWf6hK4KSbX7cU/ZciyWgSF8Xwpq7tAC2BdkYxjCB8lPz6el6QdY1ZfsfslduQ2viFW+
         Bg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730810917; x=1731415717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPzUqJyq9Agfg2xFr5+F7YykIu7Y2oVke0GmFsSA2w0=;
        b=WXlNj2ZgtZJnlYKzhedN98gJdYXHGhZzE8fQPJMt+FQdgvRbF7T5T9/IJE94L2Zc1J
         p4imEKxLBxy3soBASLGJMdkhhtv767AVF0S5iUdiad7jbxnEZThhT9sutCaOTUXDC+vP
         hnTut0P9eQmGuPdAFFCxlxCJGGnyYr8FJZgQyK/ireramAO/s1BuCh6SXzlawpcZY0U2
         9/r7K5a1Zk5KhIk9clELG1++vOq1XoZZAB9Eb0OyJi9NzliDPwXMTaCO1O8Ca4zmIi2m
         62ZmY7nEF+MPfNc5sPt9rj/JagkY/O4kBgFowKn1ypzbIjJ5BE5oHHO8xvuMx+1/IK4c
         ODYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzOYHyfyEfXy4ZfOH8vlFxR/uxaAuedFoVYqRX7veeo2/pZncsCIxZZxKyXMNz0jRqQrW0Lzh4ad7CoLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgFJ3JUZ3L1STEv4NN+mTz2VJN/H70vh6eq+l/d4EaptctQ9p
	jA3Tl/cJNHv5W/abJaHakw3gIoQxBEp+ujoZwpJrgygFvt6u07LsPnN4GaMAb1o=
X-Google-Smtp-Source: AGHT+IECQtI2afC9/nV4FjpvSFo3iL4mQ4d8sginqnfT6Xw/THWJSQbtpkRmjpc+xPfmHoSY5sr+jw==
X-Received: by 2002:a5d:48ce:0:b0:37c:d001:856f with SMTP id ffacd0b85a97d-38061220ac3mr24022035f8f.56.1730810916741;
        Tue, 05 Nov 2024 04:48:36 -0800 (PST)
Received: from ?IPV6:2001:861:3380:2e20:6214:6f9b:8e4c:f723? ([2001:861:3380:2e20:6214:6f9b:8e4c:f723])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e687sm16242693f8f.84.2024.11.05.04.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:48:36 -0800 (PST)
Message-ID: <78cdcdc4-8087-449d-b771-e41e6295137f@rivosinc.com>
Date: Tue, 5 Nov 2024 13:48:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: cacheinfo: Use of_property_present() for
 non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241104190314.270095-1-robh@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241104190314.270095-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/2024 20:03, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/riscv/kernel/cacheinfo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index b320b1d9aa01..0115051fa1e1 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -105,11 +105,11 @@ int populate_cache_leaves(unsigned int cpu)
>  		return 0;
>  	}
>  
> -	if (of_property_read_bool(np, "cache-size"))
> +	if (of_property_present(np, "cache-size"))
>  		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> -	if (of_property_read_bool(np, "i-cache-size"))
> +	if (of_property_present(np, "i-cache-size"))
>  		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> -	if (of_property_read_bool(np, "d-cache-size"))
> +	if (of_property_present(np, "d-cache-size"))
>  		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>  
>  	prev = np;
> @@ -122,11 +122,11 @@ int populate_cache_leaves(unsigned int cpu)
>  			break;
>  		if (level <= levels)
>  			break;
> -		if (of_property_read_bool(np, "cache-size"))
> +		if (of_property_present(np, "cache-size"))
>  			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> -		if (of_property_read_bool(np, "i-cache-size"))
> +		if (of_property_present(np, "i-cache-size"))
>  			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> -		if (of_property_read_bool(np, "d-cache-size"))
> +		if (of_property_present(np, "d-cache-size"))
>  			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>  		levels = level;
>  	}


Looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

