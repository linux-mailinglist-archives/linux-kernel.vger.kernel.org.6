Return-Path: <linux-kernel+bounces-283107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64294ED49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5346B1F22D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FE17B508;
	Mon, 12 Aug 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmIGq+7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2316D9AE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466768; cv=none; b=g5fQEWkDON1IYE/dsiSbKrEUUiK2CBhoy7h+9cp902ShAFCJ0dCrqJLFuYqTQhtFkiOnFta306Ge92d/QJFpqiCOTUeAzM87Ut/PpsY6XsHXbWMiY9eDBpcdJGtKmnmPfcrbFPtQDTVIm1R/sH9QNzIVlopl/nYMb88p3ezmmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466768; c=relaxed/simple;
	bh=b/y09YHavkqM6IvK7Q7CY4hdPzCfffVt4tKff0uiNjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8/HJVEwXeME2qpkITBp3gjb1v5RKGk1U1JByDW8r0xZiRj6xoP0cQEEMux2cpMHQVetkvlJwtL9RC1tm87ilQc1uDGac2DSbK3aCyZwR+p0LqQdrGWIr1IBMi9VFJxNZrpBoO7fBrXCUXDq5JDeHCCicenlXtYlqHEQkRY2Pvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmIGq+7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723466765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKDtWb6RxLCMwAwdf51Z/WY8vKRIwoyi9gdOkFeKbfA=;
	b=LmIGq+7Q5Zfon6Ho5WrxpK4TeE9LkLzBYuay6M4Rm772NyzNEkL4BpTsdan4osNSwovjvc
	X9pVuF/HThP+kuMz7aGxma7mbcICN0IpI+X6Jktpz3a0pNSO2n/otsU5ZMeG5eBRlKui2t
	LZ6OOBmUA4M05I+QYHejDM2vi93Cdzo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-dDBCF8nhPw-oOgt18glHEw-1; Mon,
 12 Aug 2024 08:46:02 -0400
X-MC-Unique: dDBCF8nhPw-oOgt18glHEw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62EEA1918147;
	Mon, 12 Aug 2024 12:46:01 +0000 (UTC)
Received: from localhost (unknown [10.22.8.16])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A54819560AA;
	Mon, 12 Aug 2024 12:46:00 +0000 (UTC)
Date: Mon, 12 Aug 2024 09:45:58 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error handling
Message-ID: <ZroEBi-yAGy8ogJ3@uudg.org>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Aug 09, 2024 at 03:34:30PM +0300, Dan Carpenter wrote:
> If the "tool->data" allocation fails then there is no need to call
> osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Looks good to me.

Reviewed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>


> 
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index f594a44df840..2f756628613d 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  		return NULL;
>  
>  	tool->data = osnoise_alloc_top(nr_cpus);
> -	if (!tool->data)
> -		goto out_err;
> +	if (!tool->data) {
> +		osnoise_destroy_tool(tool);
> +		return NULL;
> +	}
>  
>  	tool->params = params;
>  
> @@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
>  				   osnoise_top_handler, NULL);
>  
>  	return tool;
> -
> -out_err:
> -	osnoise_free_top(tool->data);
> -	osnoise_destroy_tool(tool);
> -	return NULL;
>  }
>  
>  static int stop_tracing;
> -- 
> 2.43.0
> 
> 
---end quoted text---


