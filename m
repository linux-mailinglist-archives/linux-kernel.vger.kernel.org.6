Return-Path: <linux-kernel+bounces-567881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BAEA68B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFF91632ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EEF25523C;
	Wed, 19 Mar 2025 11:23:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD04253351
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383388; cv=none; b=UDo/C4k/v/uACFDQW9UuT3Gc9Myw3ahaEMj4rqSaQrq8VHPyJaxMUlpCcmpL4xuRb6yZfKWEKtJC+TLFJ8nXxCy7QPi5BnqA3zXrxakE0ns0FNHpbAoZlO8L6XGY89Gxnkhjm+mf3cYoXSKx8KmMUV/C6RE/cwOUuJk9/R+vEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383388; c=relaxed/simple;
	bh=I2jlfu32GpD3lTkpDQ4wiTr/uiD2t4PxQ2WOakJAtsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkm086QYAq9N2izkoETyYxSegGDH8gm7Pwv90n8Vl2+0y3aA5EClnv+hvAX7y1c/juolKZrCcTFK9A+lzMJtXPwE2ki59IHYpisbMPyvw4erSQK+ZM5VoNo7yoS1UBwDxOMEQjzJ7XTGAA8PsCS9op0AmlQUTK2lPZLJSvQ0KH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB306113E;
	Wed, 19 Mar 2025 04:23:14 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1AD3F673;
	Wed, 19 Mar 2025 04:23:05 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:23:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
Message-ID: <Z9qpFlBJeLrGuEXq@J2N7QTR9R3>
References: <20250318151712.28763-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151712.28763-1-linmq006@gmail.com>

On Tue, Mar 18, 2025 at 11:17:12PM +0800, Miaoqian Lin wrote:
> Fix a reference counter leak in psci_dt_init() where of_node_put(np) was
> missing after of_find_matching_node_and_match() when np is unavailable.
> 
> Fixes: bff60792f994 ("arm64: psci: factor invocation code to drivers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

The fixes tag is wrong. As of commit bff60792f994 the code was:

|       np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
|
|       if (!np)
|               return -ENODEV;

... which was correct.

The bug was introduced later in commit:

  d09a0011ec0d511b ("drivers: psci: Allow PSCI node to be disabled")

... which added the of_device_is_available() check.

Other than that, this looks fine. With the fixes tag corrected:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index a1ebbe9b73b1..38ca190d4a22 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -804,8 +804,10 @@ int __init psci_dt_init(void)
>  
>  	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>  
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>  		return -ENODEV;
> +	}
>  
>  	init_fn = (psci_initcall_t)matched_np->data;
>  	ret = init_fn(np);
> -- 
> 2.39.5 (Apple Git-154)
> 

