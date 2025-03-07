Return-Path: <linux-kernel+bounces-550752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11711A563A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D97A7A58BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737F201010;
	Fri,  7 Mar 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkZAizUm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17C2054F1;
	Fri,  7 Mar 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339339; cv=none; b=AKT5lfWBKXr6VQlmo01aY/6WUTKb+OpHF+NuAdLCK5Tr7QYNxX7l6F6z7Apwonk4zA7x7EPx1EcwJPwO+w3a/I4ljIL1YeCXjgMUEsoqCLLjTLckH7LAxOOLyPyWAdAA8LolTfImm1tzm1M3tw965yBUFC4hnoFVhMNPFuRsDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339339; c=relaxed/simple;
	bh=Y5QkxB4IAd5CNZoC0GpGpQotuQUzUAn75froay7+oCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHIOmNHOXlymlSZeNxS23gTBfiAKju41PC8JgmOTBq+/RkqLqPN2UeYBxfLRCpvNC/Bx9jUQ5xbtWJG3r1UA28UCI0vXWuhleHAn0onU21E22RmA9f46ufXahh+2bYC7tcbQtXCl461EZT3Km0e3S+F/ENQN5GJ9vLFlZ7orCfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkZAizUm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso31739255ad.1;
        Fri, 07 Mar 2025 01:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741339337; x=1741944137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ikt1gbFy2U/XFaciwFV99W2Ywgj65pbYfnki12VldBA=;
        b=XkZAizUm5HiwkSIj2YhHTsJBeNdzwz2AqUIujj1bhzS+GKFHVjkUOFBVEvYyjdiuK5
         le95W4hAdNW8KWaCRZrYlIpL+b23ivNS6VBqZSmu3OvddnyUMDCj7W5aMuUwC5ITtm81
         qHjXsN2+z0GsCq8CJg8Ozya9kJQROXdeMP7qtDPaH4JV4eYxO3WvEZt7r/D+GOKARqNr
         BIvNmN/GgGaLhbyALp1tK2WccWH4XSo5VvC/zi+oEJb+aes/9XURBfffTT64Llt3Kq9C
         0htEJg0qEH2trb3bXsWAILwonGJSqj96CU7HJ+IQemM/3cdqsPtebPMgbszkq8HgGt+0
         fYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339337; x=1741944137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikt1gbFy2U/XFaciwFV99W2Ywgj65pbYfnki12VldBA=;
        b=saNia5S7iLCjm72nM6TPiKljqtCG1rZdOjFIEvMU3qbyRzT6o1WPqXIoKPmn/hGiQt
         OkN90Z5Hatj1Rs708ulxQ+/IjDnAuaqgnQB17MBTaPmarY+IIUXezQ4+bQY2bnhtjJfX
         DdoN3pIoIXcC0Nsj0IMqSDhB9fv0BeCjjDo8vBChmZpYW36lqyYjYpaTUGhrbHJ93FjY
         uzraYPcGI7x+jh86KJRXLfBsaA56t1JoIADBE0nyOB79R9PgxATVuwxrtSCvzrDXUvxi
         EXI7xhPL0+qunVaDZVKPiHiZzNfJfFN3Ghy/xnp8hy1WPNGo1yt9Mz2aJFt+juuZe52Y
         zdRg==
X-Forwarded-Encrypted: i=1; AJvYcCUnfiOLjl5/xORV4nNebQJPePKKS6yaSgpsgSAcuHkTKqX/9DWv1yvSAZFBlHEl2lfQrR6A3jcQFB1ppWFG@vger.kernel.org, AJvYcCXM7WtSGbAWGl3HXwoVkRGUYiLtIn6i40FPoJ8Er6LKouE4RqA9vM6olTe3m7lVN42JKAHx7W/U1NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCSorvlbI15+kHpZcSJ9VKNw/dZn3J5VvEuCJHKYZVbb834PH
	P8VVn9Sapk1NwS1mK43FAzTGvkvCnQ45qBgk7Vm/Xv33bq93eviG
X-Gm-Gg: ASbGncuNINhMZcoCUGPgvBPFo42kueSwWOboKUJUqwY6s/ShMQlqxcSyYzH/xzOIDOU
	JcoYJkQjnRIwfqmTxBS1XYjxNdec7i3JV1XwZssxNGKKLOaEStAxReheNclrXWd5C1oeUOTQW/H
	UUi26d9OLv1goQJ3P/phiLYR+zPsbNDJZROJD724oA1Wn/oR1hmkijXXrySE0h89pXbbUNj2NGk
	siwPhK2myBssr3wnVSI+TRNnfcU4dVOdi17UGPyHgMZyhPieJ//0UKIVOUrABazEyKMWYbTdke8
	mAP5F+z9MAusd93MZFzq6Ie3y0RDFgg1S/G7LNezqarxPTMM9w0wfkoS+x/xuWQosI3gqvqUy2n
	x+ZyubqT688Fb8fQ=
X-Google-Smtp-Source: AGHT+IEIiXoZZzxnSoXXPCIUnCwno0fB8cOp8sQafgL9UTqbrPTpwRetutsW24+5sVWmY2Y7FpymiA==
X-Received: by 2002:a17:902:ea07:b0:224:1c41:a4cd with SMTP id d9443c01a7336-2242887ffb8mr39955125ad.3.1741339336834;
        Fri, 07 Mar 2025 01:22:16 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a9194csm25574795ad.172.2025.03.07.01.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:22:16 -0800 (PST)
Message-ID: <cb168a2c-d14c-4c7d-92ea-ab70194545a9@gmail.com>
Date: Fri, 7 Mar 2025 18:02:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Yury Norov <yury.norov@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Only a couple of minor nits.

Viresh Kumar wrote:
> This fixes various kernel-doc formatting errors in cpumask.h:
> 
> - WARNING: Inline literal start-string without end-string.
> - ERROR: Unexpected indentation.
> - ERROR: Unknown target name: "gfp".
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpumask.h | 65 +++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
[...]

> @@ -667,7 +670,7 @@ void cpumask_xor(struct cpumask *dstp, const struct cpumask *src1p,
>  }
>  
>  /**
> - * cpumask_andnot - *dstp = *src1p & ~*src2p
> + * cpumask_andnot - *@dstp = *@src1p & ~*@src2p

The latter part needs to be "&~ *@src2p".

Note: kernel-doc (script) recognizes the pattern of *@name, but not ~*@name
at the moment.  (No warning from Sphinx, but the rendered doc doesn't look
right.)

>   * @dstp: the cpumask result
>   * @src1p: the first input
>   * @src2p: the second input
[...]

> @@ -729,7 +732,7 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
>  }
>  
>  /**
> - * cpumask_subset - (*src1p & ~*src2p) == 0
> + * cpumask_subset - (*@src1p & ~*@src2p) == 0

Ditto.

>   * @src1p: the first input
>   * @src2p: the second input
>   *
[...]

> @@ -789,11 +792,11 @@ unsigned int cpumask_weight_and(const struct cpumask *srcp1, const struct cpumas
>  }
>  
>  /**
> - * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
> + * cpumask_weight_andnot - Count of bits in (*@srcp1 & ~*@srcp2)

Ditto.

With above patterns taken care of:
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

>   * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
>   * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
>   *
> - * Return: count of bits set in both *srcp1 and *srcp2
> + * Return: count of bits set in both *@srcp1 and *@srcp2
>   */
>  static __always_inline
>  unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
[...]

        Thanks, Akira


