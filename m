Return-Path: <linux-kernel+bounces-352131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B0991A9E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305741C20FB2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEE1591ED;
	Sat,  5 Oct 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpe5du+o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AE1369BC
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728159669; cv=none; b=WsdKvKSxBQQRl/RirIDln43hQr6N8yzzYTdO5T5VUliTK0gZ8hINYV25KMZXytFoFjAQaJd1c++7mf47L+5j9DB7qQ/RydAReKQY+qplsIRRK5p1t8Q9VYK2Gk6q0Rctz9Qyqwr9HPrC39lj+JGuS6xLE1oA8dkZ+592TIV6VWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728159669; c=relaxed/simple;
	bh=HdGGRUJA3ot3A2wPAcO5bd+w4FRZUzvDnqjHAGnqKrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7RAcgJrbY4y7vFu7aLpQijAc8Gqf+725LDUYMo8t1Ey8uKYxSRHs2mpJt6iaiuGuhm1bqFr5LzDpda7kRMLxWlvgjfisiSCQx7RzeYAfm1A9yjy0epyMvc+E9A3GwzBQxWjrLwgRt815x7hRhZ5EfOk+F0j5FghD96K1I9LShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpe5du+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728159665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hds8gsArPdIf+pvdxK6o6yfAbf3VijCTl4UpFIAf7HA=;
	b=Gpe5du+oyQhPOFciQLcXAQOmUr6SJkB4wVdxn0Pf7OgUQrjePOL+jHedaoOzsLD39Yc5t2
	8LERgDpzGCiWlCd+xNqiMIGESG07mAOB8DeQ38fFQEhgioAXSN7VPXyajY//dojB21xx0z
	CO2YQgAWSacC53sI7EnyNRwQ3P/Ubzo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-dNeJWzNMNTqjoTrd6pKcLA-1; Sat,
 05 Oct 2024 16:21:01 -0400
X-MC-Unique: dNeJWzNMNTqjoTrd6pKcLA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8131A1954235;
	Sat,  5 Oct 2024 20:20:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8B55019560A3;
	Sat,  5 Oct 2024 20:20:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  5 Oct 2024 22:20:40 +0200 (CEST)
Date: Sat, 5 Oct 2024 22:20:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org,
	mike.kravetz@oracle.com, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, nathan_lynch@mentor.com, dsafonov@virtuozzo.com,
	Liam.Howlett@Oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com,
	peterz@infradead.org, ardb@google.com, enh@google.com,
	rientjes@google.com, groeck@chromium.org,
	lorenzo.stoakes@oracle.com
Subject: Re: [RFC PATCH v1 1/1] exec: seal system mappings
Message-ID: <20241005202025.GB24353@redhat.com>
References: <20241004163155.3493183-1-jeffxu@google.com>
 <20241004163155.3493183-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004163155.3493183-2-jeffxu@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sorry for the noise, forgot to mention...

On 10/04, jeffxu@chromium.org wrote:
>
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1535,6 +1535,15 @@
>  			Permit 'security.evm' to be updated regardless of
>  			current integrity status.
>  
> +	exec.seal_system_mappings = [KNL]
> +			Format: { never | always }
> +			Seal system mappings: vdso, vvar, sigpage, uprobes,
> +			vsyscall.
> +			This overwrites KCONFIG CONFIG_SEAL_SYSTEM_MAPPINGS_*
> +			- 'never':  never seal system mappings.
> +			- 'always': always seal system mappings.
> +			If not specified or invalid, default is the KCONFIG value.

perhaps the documentation should also mention that this new parameter has
no effect if CONFIG_64BIT=n.

Oleg.


