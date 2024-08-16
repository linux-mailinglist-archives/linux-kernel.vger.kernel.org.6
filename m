Return-Path: <linux-kernel+bounces-289150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21B95426F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8911E1F22042
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C985260;
	Fri, 16 Aug 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nozw1Gbl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4F583CA3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792376; cv=none; b=q9HxKOmBM6ukmpU67DgtDvkQue1C0wBPnnTb+c9RNmB9v1QirpgZXAA08mAy3dVCU+i4FclPGJK+JG51vKBc1wXUN+9vpFiRwQkbfnV7wzS9x4Wsq6dsvvpnlHN5ADXgiMBtL+Yxcf/4SgA2A9iTl37lX8xy+xdhrq5obVpxwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792376; c=relaxed/simple;
	bh=StV8OwRoHTmPstvFaQQLt9VqY4s7pcJMdLZ0lA2jtBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfhpYyRSOOncx+1gXQBKvNqY6O6+18fPwP5hn/a4cyfx9zEPwPRGLwKkkmqLu85ywh+CEbwW/jNv6qLlMQa+i4AjokMWshbmEk3ANdqBIlP6qqio2jyDi92IziCHiOLoKUywn5nEenWjBqUdtOJIzkrPiLwfOW0+NprK3lGuoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nozw1Gbl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723792373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBq7aYZZS57mYSej0WqgMxXgRDCvCAbACBmMzM3dZj8=;
	b=Nozw1Gbl5nreyIKaDeXCtqk2XyLUSaUuE3eFcQRkE0WOLgN+7luH74DilBnyPsfrjynqwj
	QcuHjotfI87EmiK8c4z1bc9JQaN6LMf2k1xZ6jDxnxLVVdCsjE2wCCj9ziICo04JWoqtzL
	xgtT/9mve4AnZDfD1VUQ5I6Rrm/RRVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-tdPrMVXhPxSuZDkm0UB6fg-1; Fri,
 16 Aug 2024 03:12:47 -0400
X-MC-Unique: tdPrMVXhPxSuZDkm0UB6fg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E7AF1954B11;
	Fri, 16 Aug 2024 07:12:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C9C19560A3;
	Fri, 16 Aug 2024 07:12:42 +0000 (UTC)
Date: Fri, 16 Aug 2024 15:12:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <petr.tesarik@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Petr Tesarik <ptesarik@suse.com>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <Zr775rzbuVP6AwMu@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Andrew,

On 08/05/24 at 05:07pm, Petr Tesarik wrote:
> From: Petr Tesarik <ptesarik@suse.com>
> 
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
> 
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.

Ping.

This is a good fix, could you pick this one into your tree?

Thanks
Baoquan

> 
> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif
>  
> -- 
> 2.45.2
> 


