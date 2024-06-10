Return-Path: <linux-kernel+bounces-207786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375E901C17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2601C212F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794DB315BA;
	Mon, 10 Jun 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TkrFNBHt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49F26286
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005793; cv=none; b=nMNjFcw3cguE9n5iy9R5mPX0huu8shuRLJLC3uA9P2Zm7o1jFxRTNJcr06yVYlV5O6G9RUOJurpI4UrooCVY6PnOu4ivjdl/XMhimWAxVWP4kKD32Wy/xD62PrqwLqwOZ/kbU9W6UVc90W6xgBYPWjAWeaO/RubLZiIsKE779X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005793; c=relaxed/simple;
	bh=ONacOLP/ztTRR3gIVVvVXcnxvcbkIhM+Whwr7wSUrcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeYdU5uqNQNL+1bpAjl1VBkz4JPk61Xv43sjH4ddhB/FSd/jaVZpUK/6UbEHiI6Y+0HdTxVi8YAYvxJXlEfzgaZxk1GjK6qK+KIszFxxyx4/C+gkA2P00HCM7Bx1ZMxCxC8Bxb1qc9D5L8WZ5F8bA0mXaJwQrCFVLBqV1J9nNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TkrFNBHt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso5955143a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718005790; x=1718610590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KwiEJNVRVOeG3gLM45b2+/KiKZQYIw3B7SIhM/nKLRs=;
        b=TkrFNBHtXh4iidBIIxZoJGanCdcC/TVnuGehAV6cuWAyEYEb/6vGGt08hJrdlFVYSb
         R/GHrMOl9RCzgwNJY1YNohQGLt9hTlgRy1vKksQz88APbV9Q5peRYbi9zrHKfuDkHEl7
         HrD7vHTqs1+YhDJFxNXwSP0TSNBqfNbL4vPhixr8x7AaaMeaaAJ8jVfl0WEUqMysaTSs
         7h8QFnxYWKiTEumHdO2PJkuPuQagbBZvSTuJj9Ces8SsL3fA2dHYlVcWhxM+23wz/y4M
         6Y9R1Vb7Sis2Q2yXHgelutNg+qkxPUbrVVbOqEW5G4gJujPYFHpX7cjsIIBDefb4MhuJ
         sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718005790; x=1718610590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwiEJNVRVOeG3gLM45b2+/KiKZQYIw3B7SIhM/nKLRs=;
        b=DH8qlTd/aw9pxyeJceqZkQrGRkSm88im4Dz4D0bEKofCySiKVAo+k1i6bnNEWl5tdx
         ux+8V3lDLMg/AZ+11uA28TV/l7rNOJzBlTMVWFXKeczjGVIXLl5USF4PwO9MKKpLj7F6
         RImtlvL6wCv7FAZP1zu88DaQUEg7vNXkNqLL4FDl9cYH1EUU6FzE37GbqTe8adFqEoZK
         cgmWTETwCASAJX03O9h38WZZhmAe8kc9/Effcu7yxwnsjroJLsHTz6cuW+44Q40aEzHj
         quDiCnl0E10RVMwuU6q/FSvtRhzsHX42c4NKjwYGmEfrKz9x93QmNCf0RUy6EhtvB4jG
         /jAw==
X-Forwarded-Encrypted: i=1; AJvYcCW610GT+d+B3VtgxvMa23mBZwMsdjDFL8tcmWswcZyMb5DLixk8FV2E942Jz+Rc4YvYkYd0a+JmzuCAkN1iEL7uNv1txSH4stqTA4WG
X-Gm-Message-State: AOJu0YyUF8PiBbT22pDZ8+vksCGmHqyUCiErH5R1xMPSYHLyrZV6PzHj
	yIprSqRkbBv2fLHYx0SpsBqshKfChtywS/E3b5AO9lCIzd0ZEg5Se/QvZo/0CA==
X-Google-Smtp-Source: AGHT+IHwC/Vukz1JeyzipUsg056gd0k4WnZOoz8F/+UkhcQ0n2rmEUO9tEIwvIH7PM7xzw4G844e+g==
X-Received: by 2002:a17:906:68c5:b0:a6f:2d5c:5c8d with SMTP id a640c23a62f3a-a6f2d5c6342mr17558766b.30.1718005789617;
        Mon, 10 Jun 2024 00:49:49 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efed85dc3sm315910266b.124.2024.06.10.00.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 00:49:49 -0700 (PDT)
Message-ID: <a5b5b0f4-0fe3-451b-b2d5-c9d2bcc91bc4@suse.com>
Date: Mon, 10 Jun 2024 09:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: xen-pciback: Export a bridge and all its children as
 per TODO
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20240609184410.53500-1-jain.abhinav177@gmail.com>
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
In-Reply-To: <20240609184410.53500-1-jain.abhinav177@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.06.2024 20:44, Abhinav Jain wrote:
> Check if the device is a bridge.
> If it is a bridge, iterate over all its child devices and export them.
> Log error if the export fails for any particular device logging details.
> Export error string is split across lines as I could see several
> other such occurrences in the file.
> Please let me know if I should change it in some way.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/xen/xen-pciback/xenbus.c | 39 +++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index b11e401f1b1e..d15271d33ad6 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -258,14 +258,37 @@ static int xen_pcibk_export_device(struct xen_pcibk_device *pdev,
>  		xen_register_device_domain_owner(dev, pdev->xdev->otherend_id);
>  	}
>  
> -	/* TODO: It'd be nice to export a bridge and have all of its children
> -	 * get exported with it. This may be best done in xend (which will
> -	 * have to calculate resource usage anyway) but we probably want to
> -	 * put something in here to ensure that if a bridge gets given to a
> -	 * driver domain, that all devices under that bridge are not given
> -	 * to other driver domains (as he who controls the bridge can disable
> -	 * it and stop the other devices from working).
> -	 */
> +	/* Check if the device is a bridge and export all its children */
> +	if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {

Besides it wanting to be & here, it feels as if such a change can't be done
standalone in pciback. It likely needs adjustments in the tool stack (even
if that's not send anymore) and possibly also arrangements in the hypervisor
(to correctly deal with bridges when handed to other than Dom0).

> +		struct pci_dev *child = NULL;
> +
> +		/* Iterate over all the devices in this bridge */
> +		list_for_each_entry(child, &dev->subordinate->devices,
> +				bus_list) {
> +			dev_dbg(&pdev->xdev->dev,
> +				"exporting child device %04x:%02x:%02x.%d\n",
> +				child->domain, child->bus->number,
> +				PCI_SLOT(child->devfn),
> +				PCI_FUNC(child->devfn));
> +
> +			err = xen_pcibk_export_device(pdev,
> +						      child->domain,
> +						      child->bus->number,
> +						      PCI_SLOT(child->devfn),
> +						      PCI_FUNC(child->devfn),
> +						      devid);
> +			if (err) {
> +				dev_err(&pdev->xdev->dev,
> +					"failed to export child device : "
> +					"%04x:%02x:%02x.%d\n",
> +					child->domain,
> +					child->bus->number,
> +					PCI_SLOT(child->devfn),
> +					PCI_FUNC(child->devfn));
> +				goto out;

Hmm, and leaving things in partially-exported state?

Jan

> +			}
> +		}
> +	}
>  out:
>  	return err;
>  }


