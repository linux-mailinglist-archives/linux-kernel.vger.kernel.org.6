Return-Path: <linux-kernel+bounces-310541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E90967E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91C028253E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84522075;
	Mon,  2 Sep 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEPv2h58"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081D79C0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246324; cv=none; b=R4dDdgubXgQim61Vgi8+4NrxXrNaCeFZ2mW1bp+nPbiNCf7jyC9oPuri4p7FQ/lcK4AVIlrRz4+aDVbfLZfu7TuTSyDDf6z0mTUjNL7z52vajG9RMOPRKnbVsYoESOOid/ssIe5Ecq60kIYnLqAMnoVBQtFbweYBC1T9pOvyAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246324; c=relaxed/simple;
	bh=SdBGx/046qIxw3N5LU0o7ilkNZVrzxdFOb6VXUgXw04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh/GXwDes4SFDGvOvvVoN7Arjc/HHiLavX66oYyZ0SwYTs9r36ygczYnYqm6HA4YCnrtqgzrF8xqhTyCULPpMEcx69PmakO6dwYReuCBcQFYa02hD+CcMe2rBb5owYJTE/SSL1a5Pxt5wGZPCe0n5VN17CWHQzJ49ddndCH05/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEPv2h58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725246321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wSjolqkdgtanP1gHe7DoyJjSl0u2RbxSmbePTYD+6I=;
	b=IEPv2h58EMWcJuba8LQ/pYBfMDi8szUBbqDgMiK5L8s+FbirzvBp0phUJeBpZ88iFT46w3
	BLFu/rlhmQjNv5Piu/5kqhueWY3KWXTFHk6xoi6cwBot7ZDizJfbA+oZwl9LMwPwQgpbrw
	8C3y7GBPUrD6qkoP9K6zWf7LPrXFkDQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-QtgqlzQbOqKpg5gH5i3qkw-1; Sun,
 01 Sep 2024 23:05:18 -0400
X-MC-Unique: QtgqlzQbOqKpg5gH5i3qkw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE2E719560B0;
	Mon,  2 Sep 2024 03:05:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1A9919560AA;
	Mon,  2 Sep 2024 03:05:13 +0000 (UTC)
Date: Mon, 2 Sep 2024 11:05:03 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, vgoyal@redhat.com,
	dyoung@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Message-ID: <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
References: <20240830182219.485065-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830182219.485065-1-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/30/24 at 03:21pm, Guilherme G. Piccoli wrote:
> Be more clear about the downsides, the upsides (yes, there are some!)
> and about code that unconditionally sets that.
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2: Some wording improvements from Stephen, thanks!
> Also added his review tag.
> 
> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc52ddc6864..351730108c58 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -913,12 +913,16 @@
>  			the parameter has no effect.
>  
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases the
> +			risks of a kdump failure, since some panic notifiers
> +			can make the crashed kernel more unstable. In the
> +			configurations where kdump may not be reliable,
> +			running the panic notifiers can allow collecting more
> +			data on dmesg, like stack traces from other CPUS or
> +			extra data dumped by panic_print. Notice that some
> +			code enables this option unconditionally, like
> +			Hyper-V, PowerPC (fadump) and AMD SEV.
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I know Hyper-V enable panic-notifiers by default, but don't remember how
PowerPC and AMD SEC behave in this aspect. While at it, can you add a
little more words to state them in log so that people can learn it?
Thanks.

>  
>  	crashkernel=size[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> -- 
> 2.46.0
> 


