Return-Path: <linux-kernel+bounces-558075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB3A5E15C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E42816022A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF419C54B;
	Wed, 12 Mar 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WimAsWrf"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0EA79EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795388; cv=none; b=WkPQMzuXZM5SIeQjuehqYfV3RdqqwpihVNp4TFteqo2eOKa6tatTa0xnZAN4ie2UD52PZ5y/PzjDSRWFjXSYsu43Gc3hoz7ayRG+YRpZknIs+spH7gqJNZCGluIhYUOlp4wn+pTCArvvlW7TBjBPKEvk8bNLKZj4w8nG2GTsIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795388; c=relaxed/simple;
	bh=ciU7kKjanvySdci4cVr6ppjTDKsP4coUdhObiDku+Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuX9n6OvJGsQ5ol0j76uT5KIgWpVQ0aU9eQhXHk/InaftoxLVINDdBew9QqQClwOUrtp0nwb7t2gLd98rGs4mzURKTonsrKJm5sm5igPI9xFqKFE4D7LsT62mue+qB7rqHhVXyq6vvsVMd3k7y9VFBmQhUd7FzDehY02C4rTIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WimAsWrf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa764aac2so55885291cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741795384; x=1742400184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgQPX6to3ruRXTMnOsQSfBylTa8PLJ1nm8nO6/ovThY=;
        b=WimAsWrfspEX11nV77eNmJMg3YIufsyDxBS3F02m4wd2BzVunNQcUX+iHLxdQRU6JX
         fL7k0t7sAAtKBt5HqvazaklY4eS5lHfbpOoD8pAIRvxKykbS+oSp4HVJNtIUh7tS+bVF
         PKEv2PZB1r0WMUgIpGGSChMOKHN6OqXGv69tdwNEWx+8lXZVgsya9ZtFph2hcjAhCn8G
         QU2SczpH9saPvHtAmBQdoibSKAdiRG5zJ38ptRlyD2do5+DggNRd13hA0G/EUIjrf+3R
         6MKvKn+VmhwmqHoLz8p+Rietet7dhDqa09Wm2MJ1aFRpUxi/aQ/jf/5jkTJhheZbyLOM
         Qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795384; x=1742400184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgQPX6to3ruRXTMnOsQSfBylTa8PLJ1nm8nO6/ovThY=;
        b=bR2WKSiSScI0qk8+u49UMRmQnrClb1UO/Oy10+//kPSIn0CfYaUHxQZsTy8kxA90kG
         ZLaHFTxepz1+z01n6MIN6bJc6FnS9hNHGzP67yq8nWCP6tcX41PQ2yIBkJhnmUpTyb6s
         Fb5MyHdaFn2z2KZ34vorAExABFV1tY7ETUOIOlhGQpfyygS5JGszutPuIgmDLjOwBPL4
         QASa3x6ds0AV/98XcfGkHlAdZ/1Adh2CPN8bbuyBYN57NIdWVnD3oZR3LkHCu79t1G5O
         Vtnrnr3kqpC1+z4L7KHCS5+2kSm5UzebIGMLp1MD0d/X9esBw6MVVbcMiZ6xRqA/AkIx
         jLNg==
X-Forwarded-Encrypted: i=1; AJvYcCU60OSM/jeAQX5WqUI2EXOmd9NnZfj7J6k/c0Rv+3xcfHBKhDZTqE/Cliu5KAAA5KpuRjampI5iAfPrRpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJonySw4hziIvE19QRJph0+A3en9zojJUhh0A1ECXAqN/5cNHq
	d9HbTCUp4gsfgQSAN9Q59jiwUJzZcUYmZTPhF4DntGzG9JN0m+PHRwnktM2K84Q=
X-Gm-Gg: ASbGncsW/2bFrJu9e8aBkvH/XVeRg5z3vXQCh7f1GXaEhCpS67P3VGZ6crGqZtcr8Da
	mdKrt38kanwZrqxE6BblxyPhYbJZobi/PidQe4R+N4llB+82qNusoXsqRlQiMv+BvGRb6E83zIs
	TnfGnPPK4RJKjYpqP/PSHPRbGnKfjfJkG1qy9YHWIQLfAS2qrzIgeeZXhfxNUPCZ909jWFkJ9NT
	bWYz0n/CVVMFYfjL8u5sAN35rHI2o2x4WoD5gEaSNKgLIbiYgVdbqKtgwHvYFfy2yJ7Auw29Mnf
	GvC74E5WrBsdKPafZL5OqDW3yENqT1CEsDg54s6aysw2rnkVY5w8ARlcT/iJd8ytU2dr4E3cPs0
	wHK+ceE3hoE84ruzUAM2B7uRkUPLmeXbzLT68TQ==
X-Google-Smtp-Source: AGHT+IFOzNBmM6sNXdBPAvZOChEL8BWYIxX5n5ObZl7b9qMQ+gMxQRQ4ExDjUCkWm/IyG4QGgX5V6Q==
X-Received: by 2002:a05:6214:76c:b0:6e8:fde9:5d07 with SMTP id 6a1803df08f44-6e90066a2e7mr270478546d6.26.1741795383936;
        Wed, 12 Mar 2025 09:03:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c61csm86339506d6.4.2025.03.12.09.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:03:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:03:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z9GwNWNC9VfR3Y6A@gourry-fedora-PF4VCD3F>
References: <20250312075628.648-1-rakie.kim@sk.com>
 <20250312075628.648-2-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312075628.648-2-rakie.kim@sk.com>

On Wed, Mar 12, 2025 at 04:56:25PM +0900, Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby optimizing memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, the sysfs entries for configuring weighted interleave were only
> created during initialization. This approach had several limitations:
> - Sysfs entries were generated for all possible nodes at boot time,
>   including nodes without memory, leading to unnecessary sysfs creation.

It's not that it's unnecessary, it's that it allowed for configuration
of nodes which may not have memory now but may have memory in the
future.  This was not well documented.

> - Some memory devices transition to an online state after initialization,
>   but the existing implementation failed to create sysfs entries for
>   these dynamically added nodes. As a result, memory hotplugged nodes
>   were not properly recognized by the weighed interleave mechanism.
> 

The current system creates 1 node per N_POSSIBLE nodes, and since nodes
can't transition between possible and not-possible your claims here are
contradictory.

I think you mean that simply switching from N_POSSIBLE to N_MEMORY is
insufficient since nodes may transition in and out of the N_MEMORY
state.  Therefore this patch utilizes a hotplug callback to add and
remove sysfs entries based on whether a node is in the N_MEMORY set.

> To resolve these issues, this patch introduces two key improvements:
> 1) At initialization, only nodes that are online and have memory are
>    recognized, preventing the creation of unnecessary sysfs entries.
> 2) Nodes that become available after initialization are dynamically
>    detected and integrated through the memory hotplug mechanism.
> 
> With this enhancement, the weighted interleave policy now properly supports
> memory hotplug, ensuring that newly added nodes are recognized and sysfs
> entries are created accordingly.
>

It doesn't "support memory hotplug" so much as it "Minimizes weighted
interleave to exclude memoryless nodes".  

> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1691748badb2..94efff89e0be 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -113,6 +113,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include <linux/uaccess.h>
> +#include <linux/memory.h>
>  
>  #include "internal.h"
>  
> @@ -3489,9 +3490,38 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  	return 0;
>  }
>  
> +struct kobject *wi_kobj;
> +
> +static int wi_node_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	int err;
> +	struct memory_notify *arg = data;
> +	int nid = arg->status_change_nid;
> +
> +	if (nid < 0)
> +		goto notifier_end;
> +
> +	switch(action) {
> +	case MEM_ONLINE:
> +		err = add_weight_node(nid, wi_kobj);
> +		if (err) {
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +			kobject_put(wi_kobj);
> +			return NOTIFY_BAD;
> +		}
> +		break;
> +	case MEM_OFFLINE:
> +		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> +		break;
> +	}

I'm fairly certain this logic is wrong.  If I add two memory blocks and
then remove one, would this logic not remove the sysfs entries despite
there being a block remaining?

> +
> +notifier_end:
> +	return NOTIFY_OK;
> +}
> +
>  static int add_weighted_interleave_group(struct kobject *root_kobj)
>  {
> -	struct kobject *wi_kobj;
>  	int nid, err;
>  
>  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> @@ -3505,16 +3535,23 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  		return err;
>  	}
>  
> -	for_each_node_state(nid, N_POSSIBLE) {
> +	for_each_online_node(nid) {
> +		if (!node_state(nid, N_MEMORY))

Rather than online node, why not just add for each N_MEMORY node -
regardless of if its memory is online or not?  If the memory is offline,
then it will be excluded from the weighted interleave mechanism by
nature of the node being invalid for allocations anyway.

> +			continue;
> +
>  		err = add_weight_node(nid, wi_kobj);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> -			break;
> +			goto err_out;
>  		}
>  	}
> -	if (err)
> -		kobject_put(wi_kobj);
> +
> +	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
>  	return 0;
> +
> +err_out:
> +	kobject_put(wi_kobj);
> +	return err;
>  }
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
> -- 
> 2.34.1
> 

