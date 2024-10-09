Return-Path: <linux-kernel+bounces-356387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9A99604E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6062E1F2371C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54C17B4FC;
	Wed,  9 Oct 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uz0Brh21"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394E154BEE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457545; cv=none; b=ti83eLtp4ClDg39z7UiGtEIsDQZpgFbJcDuxFsvJVG3g/6nPjAW/56Q7YFIuGg09I+1szozDa0S1Is8j4syl7BO1cIy38l3gfKUEY3NhDSedQVf3aatDibZ6M6Vz7y4nVikC0zQAgqvl6tIT0EtF9ggRayRcbQNsS3vmCldj1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457545; c=relaxed/simple;
	bh=4QvXtqWB8Xa1pB8kW5YxswJfaD71DQzAzp1jthtA7B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCyJFe7REuAqYuxhkB3nI5PcrkE45AlgL42rpRVdRRbc6a8g6Ma+aFXHRPFppNtNwk6i/LszYSQjAKUDHhqmX1h+tid1z/2hmvFC59cshM+o9HVsUAdeJFRTCMI59FfPb76wo9e8AptFFrwCx+nkQJyM0wqdLcLOWao++0l0iEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uz0Brh21; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so183114a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728457542; x=1729062342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+YP64Bzsgpvnxz/FJuxw20ht91RmIctuXvRjG0GIwvc=;
        b=Uz0Brh21Ue+rw5tbsl94pFc/zSEhFML93pvJjBA8bmCwyGDcmpOqcJny7Vn7YaBBEv
         gcL62IC1/UOXbESSUa0WKWlZsWSXEQV1h+9yeSAEVyxTWoAAsK8kDtrYLgHvouJSVs1T
         qpqedh5rAq42LbWb7IZFOFxCi/Fy1Jpr10cSi1M83Djpkdg/DEjD31HTMtEtOItrC6G5
         neQa1BdyfmdmEDXv9ODxzXESe5TlOUnD1ieYQh7eY4Nb2fnpQpMCEN4Vw7linAJkkuI8
         AN8PQU51HnxQHvwtp6SlsvUf0Jd7UfoMh1Yj87IFg03hEal1Llx5Wb3YwMwkdSsifEJr
         diaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457542; x=1729062342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YP64Bzsgpvnxz/FJuxw20ht91RmIctuXvRjG0GIwvc=;
        b=JifNy8Q6CK9FeKbeFxx9bqo7OTuxczuNy0sOhHDTKrFsGs1rJAXwLxSKtxaMB60hlp
         BdFAkU1e4pJlo/d8CCdGkoFg4/ZQmlln14tbasulUgk5hcCF7fU3Melfc7JujUWEOyzg
         Jd61xh/Ty8L9DmIQKOMuaY8I2i1Lds3LpsCpOAzBx9YpiAbnK1mZ9UI01tbXRnBdKvTn
         wGBLhZ9s5WlVhfXopMo1J1YzY53LdpWperCZioMUDOXwajjXQ63VMg0MlzCgh7N9NSS/
         JZVP9dAKpUuGputSZI/LJ8w6gsOCMcziUjC1dNEwQQpjT45Wsl9sGqY42XWNV5aVFBp1
         D2/w==
X-Forwarded-Encrypted: i=1; AJvYcCW2xx/H5l6vxihqY41FLne3XOIieOrO6ewkP8VZXvRQiyyLO9llXcAsco/tjKooJkwSUuG/1W4DHESvMXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgK9T08SdNreTeQGIWDnxvvkeclmtnKqX2X8F4Oo1tUXEIhqHy
	aQj8aYzy1TanauqAjJW6zKLBWqlPLDl2fVh9JjwidMM8KfVsXecfasJdj4KpDR3/j5kPSPu/si0
	=
X-Google-Smtp-Source: AGHT+IHZxJwFnZHWTviJgoSX5gDunTuaGTf8PSJ1stqDgqHdqgBz/1EPV8MrJ91I5WN25SkvtWU9Wg==
X-Received: by 2002:a05:6402:34cc:b0:5c8:958d:c902 with SMTP id 4fb4d7f45d1cf-5c91d689219mr1066677a12.30.1728457541730;
        Wed, 09 Oct 2024 00:05:41 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f4e93sm5047949a12.96.2024.10.09.00.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:05:41 -0700 (PDT)
Message-ID: <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
Date: Wed, 9 Oct 2024 09:05:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
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
In-Reply-To: <20241009062014.407310-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.10.2024 08:20, Jiqian Chen wrote:
> Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> adds a weak reverse dependency to the config XEN_PRIVCMD definition, its
> purpose is to pass the combination of compilation that CONFIG_XEN_PRIVCMD=y
> and CONFIG_XEN_PCIDEV_BACKEND=m, because in that combination, xen-pciback
> is compiled as a module but xen-privcmd is built-in, so xen-privcmd can't
> find the implementation of pcistub_get_gsi_from_sbdf.
> 
> But that dependency causes xen-privcmd can't be loaded on domU, because
> dependent xen-pciback is always not be loaded successfully on domU.
> 
> To solve above problem and cover original commit's requirement, just remove
> that dependency, because the code "IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND)"
> of original commit is enough to meet the requirement.
> 
> Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

This lacks a Reported-by:.

> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -261,7 +261,6 @@ config XEN_SCSI_BACKEND
>  config XEN_PRIVCMD
>  	tristate "Xen hypercall passthrough driver"
>  	depends on XEN
> -	imply XEN_PCIDEV_BACKEND
>  	default m
>  	help
>  	  The hypercall passthrough driver allows privileged user programs to

The report wasn't about a build problem, but a runtime one. Removing the
dependency here doesn't change anything in the dependency of xen-privcmd
on xen-pciback, as the use of pcistub_get_gsi_from_sbdf() continues to
exist. Consider the case of XEN_PCIDEV_BACKEND=m and XEN_PRIVCMD=m, which
I guess is what Marek is using in his config. Both drivers are available
in such a configuration, yet loading of xen-privcmd then requires to
load xen-pciback first. And that latter load attempt will fail in a DomU.
The two drivers simply may not have any dependency in either direction.

Jan

