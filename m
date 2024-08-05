Return-Path: <linux-kernel+bounces-275439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D699485BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30CC285CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4C16EB63;
	Mon,  5 Aug 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9Ces9Ft"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3316C6AB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898797; cv=none; b=ock7kgoM3DveYi83QEQKUqJvzbhZz0LrIPe6EgXzqAGKwamunuBh4nxe8uJ/SEP7KF8a5TyHYIh2NB9iDG5J6293jlk8AJm7bXN1Hjc/4kjgCsVBvyKVQ/uxKZzUCOi/MF6qPQSZ3NKhFOTFyvBppgRdeuRVgguK354DLFB3STw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898797; c=relaxed/simple;
	bh=hitg7TR4JzeNUAGw6TcQl5XXYE59m4RNjJcV7FyuNTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMRNwqdnNswZPKO1b/X1f31MY0sNeO33DfczLPjbC4MAEZICA2ZHeY+41bB2OU799MKy2GEO0e6rDaA6ZnCQB0r7q+OemZ9UPGQSW2kNrdv+H1mJCwm92i9Cuvh9Jfd2uBhg9tLmKSvaAebEoZUtGbtyw+ChOdHtJo/TMfx4VkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9Ces9Ft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722898794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeKM9Izq3y/FBXidwLJnO4fZinQDYnhnSVbYAoKkSfc=;
	b=L9Ces9Ft2VFzkq2tnAa2cZFkuE9wGphbmEOcIY7I7P1vl9ow/aZHBmk3LKJr6LhneCjy5m
	3uAO5+7e/xe6Tb8r0zH7cJFKQGhtfBnH72mwOv3fmuH4TjYX6vs8StwKSiCjA5WV/NwiaW
	3K/z8eeBvBApgTsBFaG9z4ZKNSB17fo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-SWVVVx7EMgyeSb4b4CeoeA-1; Mon,
 05 Aug 2024 18:59:51 -0400
X-MC-Unique: SWVVVx7EMgyeSb4b4CeoeA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0F331955D55;
	Mon,  5 Aug 2024 22:59:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A5481955F40;
	Mon,  5 Aug 2024 22:59:40 +0000 (UTC)
Date: Tue, 6 Aug 2024 06:59:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	"open list:KEXEC" <kexec@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Petr Tesarik <ptesarik@suse.com>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <ZrFZM4W7S89VpfaG@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Indeed, good catch.

Acked-by: Baoquan He <bhe@redhat.com>

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


