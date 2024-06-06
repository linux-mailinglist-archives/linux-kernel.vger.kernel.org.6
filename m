Return-Path: <linux-kernel+bounces-203761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E998FE029
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8DA284538
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A713B5A9;
	Thu,  6 Jun 2024 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyeVwCmT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E87DF44;
	Thu,  6 Jun 2024 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660257; cv=none; b=e1nbRokBa8zqkmBnR9amfITeACUVt0VxtWT7kWfp08oh90ZGoXf8xXc4eS6Jt76F4cAdtVS7rGocV4yr/MPw3cQInOmJAiWvxMRLTtzM927uxfyJjsTK4uU18GEefxobmHs1UzPaCocPZlf9MO2dfYNd0qzLMNGJD6aKV10P3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660257; c=relaxed/simple;
	bh=KbKt7/g1FIVQl+e686tRBTUARQfsnnzl+KTMOBV11GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdaJo0rsWxypvuEA25xXok6V4FLO/vqYGYum4DpHK2FAuMURMlGjiqa2FKnzqIUz3lRlqM4LH8Z80NUem8Hqbyx0+7ibamlaAMfr94z6VdVRh8V3B72qt2+LAK/WEupr9UZuvWK9lqAM6POgtfZwojb8C3lwIQI2q67y3Be+V1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyeVwCmT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717660255; x=1749196255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KbKt7/g1FIVQl+e686tRBTUARQfsnnzl+KTMOBV11GM=;
  b=nyeVwCmTjzY0f6CllUF0rka7wDHi0PFxX+GZ1HsU3uhsQtYxq0jRh/sD
   oJehUKPWY5NolNaB2wJhTlN+t7fg00FL2LUFatKQQgkDxRFqR5rgMwqwc
   O9Vw8Mdzd8rz6km6E05x+7+BXm9SL7N3EDeGbOTsibGkfyyyBUW5URhiK
   jcOEaKGxEpOzLK0jaqQEkRf46Rjjay8EfBmXoXThs6WLpOyeiiiR2RuKS
   q+XCAOIbvMsgXeMU61R+JPAYyGMpLfKPatvdCqDw5ejQ5OekH2JnY7tAk
   RjIVe6IICxUoXHkAqpMomaBSeFxYo+5l7QUBX2ZJnwcg2ju+gvA6yj0tX
   A==;
X-CSE-ConnectionGUID: r98B2grqSAeSE+FQGgQUEw==
X-CSE-MsgGUID: 9SbnLWjgRDyH9kCt/JUkTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24966544"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="24966544"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 00:50:55 -0700
X-CSE-ConnectionGUID: ASUIEKgwTyCLrIwxWuK8sg==
X-CSE-MsgGUID: aRNYetmaRNa8KejmhwBAJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="68689466"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa002.jf.intel.com with SMTP; 06 Jun 2024 00:50:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 06 Jun 2024 10:50:51 +0300
Date: Thu, 6 Jun 2024 10:50:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xin Ji <xji@analogixsemi.com>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] usb: typec: anx7411: Use scope-based resource management
 in anx7411_typec_port_probe()
Message-ID: <ZmFqWxqOsd6FxD3l@kuha.fi.intel.com>
References: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>

On Wed, Jun 05, 2024 at 07:11:04PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Jun 2024 18:56:19 +0200
> 
> Scope-based resource management became supported also for another
> programming interface by contributions of Jonathan Cameron on 2024-02-17.
> See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
> property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").
> 
> * Thus use the attribute “__free(fwnode_handle)”.
> 
> * Reduce the scope for the local variable “fwnode”.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Was the fwnode leaked, or why else is this a "fix"? It's not clear
from the commit message. In any case:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index b12a07edc71b..9fb52f233a30 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -1142,11 +1143,11 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  {
>  	struct typec_capability *cap = &ctx->typec.caps;
>  	struct typec_params *typecp = &ctx->typec;
> -	struct fwnode_handle *fwnode;
>  	const char *buf;
>  	int ret, i;
> 
> -	fwnode = device_get_named_child_node(dev, "connector");
> +	struct fwnode_handle *fwnode __free(fwnode_handle)
> +				     = device_get_named_child_node(dev, "connector");
>  	if (!fwnode)
>  		return -EINVAL;
> 
> @@ -1237,7 +1238,7 @@ static int anx7411_typec_port_probe(struct anx7411_data *ctx,
>  		typecp->caps_flags |= HAS_SINK_WATT;
>  	}
> 
> -	cap->fwnode = fwnode;
> +	cap->fwnode = no_free_ptr(fwnode);
> 
>  	ctx->typec.role_sw = usb_role_switch_get(dev);
>  	if (IS_ERR(ctx->typec.role_sw)) {
> --
> 2.45.1

-- 
heikki

