Return-Path: <linux-kernel+bounces-293557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2095814B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA6282711
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831118A947;
	Tue, 20 Aug 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fPj03iFQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BE18A6CE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143500; cv=none; b=mt6MNrM1f0vR+Qbnu8RJCrzZse5e1HAAqdjk4u/yNIjSaqTIkfRRamUV6+9KzXyCP2u/HK4JdV9sHxVDD2AE/uS/uT50jxSFb5PKDEJGfWmXzvmctRhJ0MB99VfWXytPUfF15XogwhCmZXRvIK10q6RNwDvjzBA4htgGygT+JY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143500; c=relaxed/simple;
	bh=JADV+q9fVZ090ZOb8QCo2PugZM/qt6yLvKXDywVVWtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUXZlkvqUqqE1gSvkA2YfmD9tKfZ69e+0DzXkWm55Yqd0IwZG99ErvBMeQ5/zZFkUg5qWghec6FoZrXQ6d9yyRiv5Dt61jx7XZJ9Cqu2E9OWxXJ2tWT5mTDjR/gr8B3FX/vd+j1qJAnlPOFW9tZ0Y5VoS/A17pOtTLZY8yNLtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fPj03iFQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso704784666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724143497; x=1724748297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6yD8g2KoL50GiIU4H3yhFvykxcp80Bk8XWTn51eVuQw=;
        b=fPj03iFQWn5haMZdvJUDW+iy6MBoLhqHrAvWIjMh+rM6R6Qg9bm4tk/lcWZzmCRTEq
         1GKtH5SW0X0nWyLMbDkNTlk+4u/hy13qXrhQyrBNN883vISAG2DFBKwLfyhPiE95RexS
         rDKjJ+W8m4FboIbfYSLDr/phiOHt33RCLC3U2eAFzGgLMo/Etku6o/SzGXpWBzgvRaC5
         QOha5xQRtIGev9nJXaXqMKNEQHzWsQwXWpazPQ4eNvYErBPkCueQFqtlbp71rZh3GwfN
         obtEeA7PoV64Kyb/1tRLM8eTPgjCwCyn0SJP7QpGRd0oK2UxH53DTzLPeqEnHOyzqguZ
         gqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143497; x=1724748297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yD8g2KoL50GiIU4H3yhFvykxcp80Bk8XWTn51eVuQw=;
        b=GLnQFuVIsyCqNiPFnKNOJ/VaAZDPLxHJy+P8Jd6jHI9QPQLxNa2e4qTLXCT0VRUJ42
         Al2nHOEdNxW6Mf/Dlw7ceGwX5fWTz+Wb90PXVzHiDvxZhmun6tU+H6XC9El3wokV8okg
         pVhzsDagHEzl5A+UF55Bj/2DQ4oLQdaum2vBvb4/ZqN2rHHEDOzRWkQbFIGkFr49R/AL
         lgJNIdjXaxeu3Gf1Ljg1JL+ByZsnR9+EQtwyNESrs7JXaxi9aYU/wUgJn6GHIeQ2xi9V
         sH6balFGg6XV8Tjpp501nla79/WWOMlIdPfMR5LTQS+in4uhfLgA9ArP4fZ4PqKPRrK0
         kZRg==
X-Forwarded-Encrypted: i=1; AJvYcCUc0Cp1K+fDg7td/xQyX37dZOrhExaqloSlyEorWmYkjesAIesndvu+TDWxFIu5oqCLGCkPdVMat81aY0BMzRbLfE4Xfw1n9vcmzrFP
X-Gm-Message-State: AOJu0YwK5rZCp+ExzTFa0ijbpHefrDKywx85tZnlULV5QTBJSNudiAKr
	qPc9It0vD1zEGJ7AqYBL6kfYYKx3qj+PSExvlPSsrkNm3ffqtyOMj2PsDyCZSg==
X-Google-Smtp-Source: AGHT+IGcH1K3GomaOMKnp10Sgh4hRQiaDwKk8MjXeZ4iL6GBsmVD3towt0FsuZ3Mxkev+5PfjgXUHQ==
X-Received: by 2002:a17:907:e29e:b0:a7d:c696:76ee with SMTP id a640c23a62f3a-a839292f15bmr1016706666b.17.1724143497021;
        Tue, 20 Aug 2024 01:44:57 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c682sm729383266b.196.2024.08.20.01.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:44:56 -0700 (PDT)
Message-ID: <b9556863-1536-4310-8005-f92e8948356c@suse.com>
Date: Tue, 20 Aug 2024 10:44:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] xen: move max_pfn in xen_memory_setup() out of
 function scope
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-5-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240820082012.31316-5-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.08.2024 10:20, Juergen Gross wrote:
> Instead of having max_pfn as a local variable of xen_memory_setup(),
> make it a static variable in setup.c instead. This avoids having to
> pass it to subfunctions, which will be needed in more cases in future.
> 
> Rename it to ini_nr_pages, as the value denotes the currently usable
> number of memory pages as passed from the hypervisor at boot time.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

I wonder though why ...

> @@ -712,9 +713,9 @@ char * __init xen_memory_setup(void)
>  	int op;
>  
>  	xen_parse_512gb();
> -	max_pfn = xen_get_pages_limit();
> -	max_pfn = min(max_pfn, xen_start_info->nr_pages);
> -	mem_end = PFN_PHYS(max_pfn);
> +	ini_nr_pages = xen_get_pages_limit();
> +	ini_nr_pages = min(ini_nr_pages, xen_start_info->nr_pages);

... this can't be just

	ini_nr_pages = min(xen_get_pages_limit(), xen_start_info->nr_pages);

Jan

