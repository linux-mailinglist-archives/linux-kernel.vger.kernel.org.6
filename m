Return-Path: <linux-kernel+bounces-378010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBAA9AC9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC872830F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9290C1AC459;
	Wed, 23 Oct 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwPNo4TP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176D130AF6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686085; cv=none; b=B9y8Tktvex3b03pM57QHGmvC1zVMeFvEYdOOwxFsvy1mrWNdcE58lm8qAd8b3PQag1Xri/FhPvWCi/9L4dpEhmu3j/iHQE0xWinXlkaguQyNmQdH7cJhUFHOCLcMX8QQ/NjZshIO9IJwTCPO/mXcqPykE1FnUaTQRB6XfhEot8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686085; c=relaxed/simple;
	bh=lQs1la9L2oYeNRYYM5cMkMyjKcbNvh7MsMYdcM1XpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWn7ZYJumyOcijx05v4P33dB57Nabw8hJIOYKIe9OLpoJ+6RoNBfgQS90JGUU7qKx1Pyi8f461/+dW5w/m6zZEjpB9m2ucNN6EAf7SFL9TNh88qk+ACcEB4nJrs+hX407lfh2n1LXkHNs2fWmrJjmAz1qOfPD7yIj1eWZNkzL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwPNo4TP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729686082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9szr8EesRaiMsy5vuZnqjsrkCr7hiQCA7i9M3b2pW7Y=;
	b=TwPNo4TPT1oicK1UWcxDqsWvzIoJgeczouCICp3E6mlBhLvsIH2PPHg2Ru2lDbqD1wLWXU
	CaVnp7dO+RJ3EY38rwDJ1w2Ay04J1lysxE/5hxmKuOlJCMYPJu9e1crJtFqqQ4v1vhh0z7
	6RaxL5zIsCBC58uhjNFO2MwTAvt+Vp8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-9QZoEGicN4WUyB8LCh5ZOg-1; Wed,
 23 Oct 2024 08:21:19 -0400
X-MC-Unique: 9QZoEGicN4WUyB8LCh5ZOg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98A551955F43;
	Wed, 23 Oct 2024 12:21:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.230])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6EC919560AE;
	Wed, 23 Oct 2024 12:21:15 +0000 (UTC)
Date: Wed, 23 Oct 2024 20:21:11 +0800
From: Baoquan He <bhe@redhat.com>
To: Liad Peretz <liad.per@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	hbathini@linux.ibm.com, yang.lee@linux.alibaba.com,
	david@redhat.com
Subject: Re: [PATCH] Makefile: Remove unused filechk_cat
Message-ID: <ZxjqN/SlnwM/jDPe@reserved-66-92-248.nay.redhat.com>
References: <20241023070611.67449-1-liad.per@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023070611.67449-1-liad.per@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/23/24 at 10:06am, Liad Peretz wrote:
> Signed-off-by: Liad Peretz <liad.per@gmail.com>
> ---
>  kernel/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 87866b037fbe..ca2dfa4343f0 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -146,8 +146,6 @@ targets += config_data config_data.gz
>  $(obj)/config_data.gz: $(obj)/config_data FORCE
>  	$(call if_changed,gzip)
>  
> -filechk_cat = cat $<
> -

Seems true with 'git grep'.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  $(obj)/config_data: $(KCONFIG_CONFIG) FORCE
>  	$(call filechk,cat)
>  
> -- 
> 2.39.0
> 


