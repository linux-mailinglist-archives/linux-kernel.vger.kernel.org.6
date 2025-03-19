Return-Path: <linux-kernel+bounces-567655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F55A688BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547478A0488
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC5256C80;
	Wed, 19 Mar 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGwlIKjo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114B25335B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377487; cv=none; b=Bfrn624Fqqn/HmXzu8I+IAq2TcgR8UJRsgzsVvZNnUX2lKLbe2X/bDz28KZA/89d+JJSSOtB5CAbS9Oji38OPYSN9btdhabauW51l7cjqcL42HsGeTtOxPXh5B0xlVQtenj2UR/wmFj0ko9w+rnAGAvf/yVeFVJltm/wfvicpqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377487; c=relaxed/simple;
	bh=MjlNMdN088gIGUiobtC6+nb2mbWyj8fPm3t/xwISSRc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E7HAdDBtt3021GbnKyuFqp8G3jaGKckcS+KpJfPjdB42hxP3BoH03hC+MfMG4xuJ4dkkpQ7TCNu/SKoe1OIsPQIj+ucoIfeVmuMg0VBtwpKYS9PaDSKwglPclXx7bb64LI1KAfgSj+TxiPUtrpy++8BKByp5huNCXXFrSLQ7dc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGwlIKjo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742377486; x=1773913486;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MjlNMdN088gIGUiobtC6+nb2mbWyj8fPm3t/xwISSRc=;
  b=oGwlIKjo7euuSTZA6NTBqYl24r5o/bGjqxeAq4ahhzw2BbRzbw+lUzci
   DnFGNMFZfLEZxis/D398eS5MVwjedux0gj2t+4Ux54G+d7JeD6AXNQUps
   uKr9DtZUZe9Ot3FQ++2FlH4yY4JYU11UIfZgPx1JkkjVZY/FWu5E4l3LH
   F/y9mkc6d0GtEeZcs+Oq5nIH3LeHJCOhzOwwFl+83lLVD7zil+W+Ey6FC
   gwBrtRTCYLmkOzPqEKKx3hQj5RayixIXQLr6aq6jVYoRgcJAV1zWAPW7Y
   usY8+Vyhj9AGUBwDklA1JFnHGH64eq/wYTI2iK+9DjKOyqHzNZlRXQYb9
   w==;
X-CSE-ConnectionGUID: 2swPErOcTB2l1g2vLiga7w==
X-CSE-MsgGUID: kPVy3mVdQDuxRnjztxV/5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43659031"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43659031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:44:46 -0700
X-CSE-ConnectionGUID: PBgKVnyCQ1+2pUwcRqt4VQ==
X-CSE-MsgGUID: sASnsueMTf+dX6UWzpQJkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122546609"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 02:44:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 19 Mar 2025 11:44:40 +0200 (EET)
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc: tglx@linutronix.de, maz@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 12/57] irqdomain: Make irq_domain_create_hierarchy()
 an inline
In-Reply-To: <20250319092951.37667-13-jirislaby@kernel.org>
Message-ID: <eb8ff00d-32e3-82dd-d64e-e25d7ec9e5a8@linux.intel.com>
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-13-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Mar 2025, Jiri Slaby (SUSE) wrote:

> There is no reason to export the function as an extra symbol. It is
> simple enough and is just a wrapper to already exported functions.
> 
> Therefore, switch the exported function to an inline.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  include/linux/irqdomain.h | 45 +++++++++++++++++++++++++++++++++------
>  kernel/irq/irqdomain.c    | 41 -----------------------------------
>  2 files changed, 39 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 5eaaf74647ed..1480951a690b 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -591,12 +591,45 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
>  			 void *handler_data, const char *handler_name);
>  void irq_domain_reset_irq_data(struct irq_data *irq_data);
>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> -struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> -					       unsigned int flags,
> -					       unsigned int size,
> -					       struct fwnode_handle *fwnode,
> -					       const struct irq_domain_ops *ops,
> -					       void *host_data);
> +/**
> + * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
> + * @parent:	Parent irq domain to associate with the new domain
> + * @flags:	Irq domain flags associated to the domain
> + * @size:	Size of the domain. See below
> + * @fwnode:	Optional fwnode of the interrupt controller
> + * @ops:	Pointer to the interrupt domain callbacks
> + * @host_data:	Controller private data pointer
> + *
> + * If @size is 0 a tree domain is created, otherwise a linear domain.
> + *
> + * If successful the parent is associated to the new domain and the
> + * domain flags are set.
> + * Returns pointer to IRQ domain, or NULL on failure.

    *
    * Return: ...

...is what kerneldoc documentation suggest is the right formatting.

(I know that was just copied form the original comment.)

> + */
> +static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> +					    unsigned int flags,
> +					    unsigned int size,
> +					    struct fwnode_handle *fwnode,
> +					    const struct irq_domain_ops *ops,
> +					    void *host_data)
> +{
> +	struct irq_domain_info info = {
> +		.fwnode		= fwnode,
> +		.size		= size,
> +		.hwirq_max	= size,
> +		.ops		= ops,
> +		.host_data	= host_data,
> +		.domain_flags	= flags,
> +		.parent		= parent,
> +	};
> +	struct irq_domain *d;
> +
> +	if (!info.size)
> +		info.hwirq_max = ~0U;
> +
> +	d = irq_domain_instantiate(&info);
> +	return IS_ERR(d) ? NULL : d;
> +}
>  
>  static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
>  					    unsigned int flags,
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index abed179737c2..b5e111776285 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1252,47 +1252,6 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data)
>  EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
>  
>  #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> -/**
> - * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
> - * @parent:	Parent irq domain to associate with the new domain
> - * @flags:	Irq domain flags associated to the domain
> - * @size:	Size of the domain. See below
> - * @fwnode:	Optional fwnode of the interrupt controller
> - * @ops:	Pointer to the interrupt domain callbacks
> - * @host_data:	Controller private data pointer
> - *
> - * If @size is 0 a tree domain is created, otherwise a linear domain.
> - *
> - * If successful the parent is associated to the new domain and the
> - * domain flags are set.
> - * Returns pointer to IRQ domain, or NULL on failure.
> - */
> -struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> -					    unsigned int flags,
> -					    unsigned int size,
> -					    struct fwnode_handle *fwnode,
> -					    const struct irq_domain_ops *ops,
> -					    void *host_data)
> -{
> -	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> -		.size		= size,
> -		.hwirq_max	= size,
> -		.ops		= ops,
> -		.host_data	= host_data,
> -		.domain_flags	= flags,
> -		.parent		= parent,
> -	};
> -	struct irq_domain *d;
> -
> -	if (!info.size)
> -		info.hwirq_max = ~0U;
> -
> -	d = irq_domain_instantiate(&info);
> -	return IS_ERR(d) ? NULL : d;
> -}
> -EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
> -
>  static void irq_domain_insert_irq(int virq)
>  {
>  	struct irq_data *data;
> 

-- 
 i.


