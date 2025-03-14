Return-Path: <linux-kernel+bounces-560649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01FA607B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B707ACE7F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6E3594C;
	Fri, 14 Mar 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJZLrR2h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F25223
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922315; cv=none; b=I7MMzQQ3aduFAVJ7a64vkSi6AerMnzAhAIQ0HfuiL0aU69vtbPRgao1FbHjvXo62KYPAmLLumXz25K+MgL8piDxQ/O5+zPboCR1iFxCiDvfHZJIAmYK48DtOlYpArM01t9kcaoXTezrUzcK8+3BPeiY9zZQhPiGAxolHDYpdhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922315; c=relaxed/simple;
	bh=osu2LQzmJyUpS6P73LHFqMMwLo9XmQi5dNUgLybYIys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7GI/rq9e507SHWKkWBXhwuXiw6zdqiuiP59ONbrTOnCl8eGOjdRY7edOcpJmy6P4V1KeekPHVd0t/TLNNmlTZexKw0wOU/XeNWCGHZZ8HbGycuRdK24LQXy2mGJ76HLVGvqMCW7x6mrnm0nt3t6evdShjNYagJsUyPtFQv5Asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJZLrR2h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741922311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6JzgEgL5pIBDYwLuXLz6r0GwgBujt+SbWNkl5wTgE3k=;
	b=bJZLrR2hNpWz5+APcgnT+Zme2xlizOMOf0QMNxp2vEM2y9oa0UdRof1OVPvuDoakvr6axx
	WbhnmRD6Qk8g6uZaeZS+42hnlnZJdRJyJVtxLcvtTQolba3AoRtA1zt7ftdYARI6W1qZxy
	TGyFIhMU7KwoXnEoh0YHykez9GnEaoI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-Vb7vx6e0OM2FGa7KaIeFbg-1; Thu,
 13 Mar 2025 23:18:27 -0400
X-MC-Unique: Vb7vx6e0OM2FGa7KaIeFbg-1
X-Mimecast-MFC-AGG-ID: Vb7vx6e0OM2FGa7KaIeFbg_1741922306
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C443A1800257;
	Fri, 14 Mar 2025 03:18:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7E941800945;
	Fri, 14 Mar 2025 03:18:23 +0000 (UTC)
Date: Fri, 14 Mar 2025 11:18:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Bohac <jbohac@suse.cz>, David Hildenbrand <dhildenb@redhat.com>
Cc: akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v3 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z9Of+RYjpcDN7+ji@MiWiFi-R3L-srv>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
 <Z9H4E82EslkGR7pV@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H4E82EslkGR7pV@dwarf.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Jiri,

On 03/12/25 at 10:09pm, Jiri Bohac wrote:
......
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..895b974dc3bb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -987,6 +987,28 @@
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> +	crashkernel=size[KMG],cma
> +			[KNL, X86] Reserve additional crash kernel memory from
> +			CMA. This reservation is usable by the first system's
> +			userspace memory and kernel movable allocations (memory
> +			balloon, zswap). Pages allocated from this memory range
> +			will not be included in the vmcore so this should not
> +			be used if dumping of userspace memory is intended and
> +			it has to be expected that some movable kernel pages
> +			may be missing from the dump.

Since David and Don expressed concern about the missing kernel pages
allocated from CMA area in v2, and you argued this is still useful for
VM system, I would like to invite David to help evaluate the whole
series if it's worth from the VM and MM point of view.

Thanks
Baoquan

> +
> +			A standard crashkernel reservation, as described above,
> +			is still needed to hold the crash kernel and initrd.
> +
> +			This option increases the risk of a kdump failure: DMA
> +			transfers configured by the first kernel may end up
> +			corrupting the second kernel's memory.
> +
> +			This reservation method is intended for systems that
> +			can't afford to sacrifice enough memory for standard
> +			crashkernel reservation and where less reliable and
> +			possibly incomplete kdump is preferable to no kdump at
> +			all.
>  
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
> 
> -- 
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
> 


