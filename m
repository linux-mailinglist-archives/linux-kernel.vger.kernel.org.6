Return-Path: <linux-kernel+bounces-549232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A1A54F56
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C03ABD8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E020AF78;
	Thu,  6 Mar 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhZc7Vyi"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF541624F5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275550; cv=none; b=nqlJfgVcAv5GxQdglqmIPI6laMErMRBs3xL6Q46APeaZ/HaqqY9l9LKgWQAbIm5hMeq9NsAKQhDtHu4G7LrB6cRwnQwcbiWvASH00T1Z92TwMCh5gUYj6WRSwpgEmXxUGH+/Tsetzbh3wLmcZ5bmMYkpNRMWdApkYq0vE1IcTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275550; c=relaxed/simple;
	bh=7l8jKJDj24Y2OIWQI9lEgNar1KvLa45MVoXXzQ/iBtg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gL3iv8tBB6SBH+943GcIAndV4OhP4As+ShzRddKg1fgpb3D9ycf6Hcf2InpvjhzVCnWBRYim1HRLMagO/NGdVUIMPgdCQyifFISpXkZ2RytPbzFpW0wW5BSW+vjZyHrlQO2EVV3nhRy9HqsJraEfHsZIOVCPrtj8E71QHEvUCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhZc7Vyi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so892790a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275548; x=1741880348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X1WTRwWwDPAfDSGxfNxGpcrZSgFIcK8sq/uSAT7PNA=;
        b=JhZc7VyifJ3Fgx8hY9YfGzQjqGei/U5YzZRqarT6INv6NLDugZPpDK/htrsGDDu8SR
         +9yvuUjSBVGqp6vHSrCytEaCCWLG5N5iaDgpxlmUBBvmWj2YKt7Vwx5lxaLwItIEQYp7
         fDQpNWaMTLVEvJF+0cPYLLmRGcOSGsXpiqksmoNWGs2aHBJNCY+DxIMYOpFceTktHS1D
         uea9o/Ct2A1umCPv5BOzLwTb37STzf9sFXgbpspgGdGAZ66+xex60ohfJy/07RQuzxAt
         edxUyVgQXYvsSk0X29668VNxYcMAvkURiVDpkbYTH+0PlsBPDZNQhewZr62nSy5VhTZD
         nvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275548; x=1741880348;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6X1WTRwWwDPAfDSGxfNxGpcrZSgFIcK8sq/uSAT7PNA=;
        b=RvEHRIkDaIHaQg06NxRAQMC9zELJ4E3JC9SmOXkKWuaSSA0PdduyJUSvWvIyFMYpwX
         +I6XsnTWVMWVIrE5V5qppt/RhZ7MeZQLXHQudgzc8xX1y7HzEssiLSZ2zeuRC4eFNXOt
         UJryfIm3Te0AoB7marypu2qsn1YWZMijeiHR16QJmrHh0jltZRN3XalPy/gjNsDeQVAI
         OljyM8ORBBXZUBufhcNMgpbuqiG8YPHFo9hRmUiGSXNiYCbi6VVerbpWmCEj2v7H4Dk4
         TRv47mmAyQuLbhZUi9u8IZQlIHtAMGdNaIOQ39H8B8PEX/3LG26Up6I4JZZfxopTOTMj
         Gkyw==
X-Gm-Message-State: AOJu0YzXmwq+nTKH/E+9Dh7kEphlJmcQob7RvRHysGrQMqapUq/sQJ0i
	S8VzyczpYwpt10vI8yRbF5IDCPNvGmZggN/nC/fKMJfyiPgYqSiF
X-Gm-Gg: ASbGncsMn8b+I05J8dYWk26MH2E2Ty96NbLZ8LT9N0u8oCAjjUVnYe6Ss0ua4Hb933R
	yMaQr3UP9WrjfQnpmiqtezqMGKjJJ+YBmM4DNouXCrRWWjFlipgoBmPsvUjoc+l+MtPXrjE5RiV
	maYSihzllYXD3yIwYA8djzijdFMgN6sVVxmxzwoyK1wy5rg9v6aH3Au/GaY7r5IgXK86Vu/yMAf
	GZa8DnyX4mD+yKdlxSzIfGeaABMtDg/xlXcYQ639s9gdIlICTH6IfpuC9nICCSrhMl2tzjx4+Q1
	RHawl3jkx+uhepr7BMhFrp97NNzUmXNsODP6seo0o1leqgvIhEL2HKVdYu3GzbeFupkuxllaj+T
	M0EPC9aMaPgQlq84=
X-Google-Smtp-Source: AGHT+IEznXLBriB7D7B0BnfTRNwqiGB4Va26/C+Yi+GRoP8Nme06v1431mPQUs5uJkNd7lk8438JhQ==
X-Received: by 2002:a17:90a:d64e:b0:2fe:9fd4:58f4 with SMTP id 98e67ed59e1d1-2ff497533d7mr13864376a91.16.1741275547772;
        Thu, 06 Mar 2025 07:39:07 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aaa9e7sm13741715ad.244.2025.03.06.07.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:39:07 -0800 (PST)
Message-ID: <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com>
Date: Fri, 7 Mar 2025 00:38:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
 vincent.guittot@linaro.org, yury.norov@gmail.com,
 Akira Yokosawa <akiyks@gmail.com>
References: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Viresh,

On Thu,  6 Mar 2025 16:06:50 +0530, Viresh Kumar wrote:
> This fixes various kernel-doc formatting errors in cpumask.h:
> 
> - WARNING: Inline literal start-string without end-string.
> - ERROR: Unexpected indentation.
> - ERROR: Unknown target name: "gfp".
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpumask.h | 65 +++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 36a890d0dd57..73ba808c559f 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -20,7 +20,7 @@
>   * cpumask_pr_args - printf args to output a cpumask
>   * @maskp: cpumask to be printed
>   *
> - * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
> + * Can be used to provide arguments for '\%*pb[l]' when printing a cpumask.

kernel-doc (script) can recognize the pattern of %*pb but not %*pb[l].
"%*bp [l]" should work here.
(without quotes and a white space in front of "[").

No need to escape "%".

>   */
>  #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
>  
> @@ -166,7 +166,7 @@ static __always_inline unsigned int cpumask_first_zero(const struct cpumask *src
>  }
>  
>  /**
> - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> + * cpumask_first_and - return the first cpu from \*srcp1 & \*srcp2

kernel-doc (script) understands the pattern of *@srcp1.
No need to escape "*".

But it does not (yet) parse the pattern of "*@n+1".  You need to say
"*@n +1", with a space in front of "+1", for the time being.

[...]
> @@ -335,6 +335,9 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>   * @mask2: the second cpumask pointer
>   *
>   * This saves a temporary CPU mask in many places.  It is equivalent to:
> + *
> + * .. code-block:: c
> + *
>   *	struct cpumask tmp;
>   *	cpumask_and(&tmp, &mask1, &mask2);
>   *	for_each_cpu(cpu, &tmp)

Do you really want those code-blocks to look fancy?

In kernel-doc comments, I'd normally use plain literal blocks instead.

Something like:

 * This saves a temporary CPU mask in many places.  It is equivalent to::
 *
 *	struct cpumask tmp;
 *	cpumask_and(&tmp, &mask1, &mask2);
 *	for_each_cpu(cpu, &tmp)

should work.  Note the "::" and the empty line below it.

[...]
> @@ -941,7 +950,7 @@ bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
>  /**
>   * alloc_cpumask_var - allocate a struct cpumask
>   * @mask: pointer to cpumask_var_t where the cpumask is returned
> - * @flags: GFP_ flags
> + * @flags: GFP\_ flags

You can say:

    * @flags: %GFP_ flags

instead.

>   *
>   * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
>   * a nop returning a constant 1 (in <linux/cpumask.h>).

[...]

Side note:

I think 1/2 would be better to be CC'ed linux-doc as well.
Please do so in respin. 

        Thanks, Akira


