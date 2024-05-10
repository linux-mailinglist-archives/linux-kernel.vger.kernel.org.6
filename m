Return-Path: <linux-kernel+bounces-175936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7D8C277D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D882883C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A6171648;
	Fri, 10 May 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUxrujlw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FD17107F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354173; cv=none; b=Np3WnLS1iU+t2OZ/uJbV+uyb5O0MKdfB3sH1PfVqjc8+hPVHuYIDMcYysTAgqLeC7D130FvSVW/X/l0HvYfwDSafMII+rt938emVD9i2bbylM+OFXu5pL54uOSsVPt1NW2MAKjpQl1MH6nc2Xjvc2Eq2yrQH8uN/7K33a5t4a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354173; c=relaxed/simple;
	bh=5d2ghIVf05Zi72JoXnUEXEhIXLKHBqJpULQ8q/aIAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSwxVkBxOk7YKj7sbgjAY7v9fTeqvVlh0iEdZU56VRISDCm448v0Mjm+ZAEIv9iSXd/DPdlfFfhWcTf+iGe2BeqocUfM909JlDLjw6GPUNhO1w3SfaypwdG7kkYWGhY5XqCwSeYF2Tr8+xTDnWk2oP4i0qyH5BOjtLopPUQkvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUxrujlw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715354167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Pov9+KC2IIoqKLTUpuUx5CGWm5+OizuP9xcaM6fbo=;
	b=UUxrujlw14GbwLz7ARL1A571csX1GKTuAlm3rQcpb6iUD/7Nt5u1Rlp2rui/fc4uWVdiH3
	WGWqcxN7Ga7k8bZcXTtBa6RI+Yzcft8LZxvCyP0pcIsIzOHpf9HyzvlK0YIYWUAIfLhMTc
	BOYMEj7bEmKx9N68QcxJmbJfGLMHrPU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-sec5aB0YMteQ3ha-QDNx7g-1; Fri,
 10 May 2024 11:16:03 -0400
X-MC-Unique: sec5aB0YMteQ3ha-QDNx7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD31829AC03B;
	Fri, 10 May 2024 15:16:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BEDCF5E1B;
	Fri, 10 May 2024 15:15:57 +0000 (UTC)
Date: Fri, 10 May 2024 23:15:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, tglx@linutronix.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] genirq/affinity: remove rsvd check against minvec
Message-ID: <Zj46KiMO5trL09RA@fedora>
References: <20240510141459.3207725-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510141459.3207725-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Fri, May 10, 2024 at 07:14:58AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The reserved vectors are just the desired vectors that don't need to be
> managed.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  kernel/irq/affinity.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 44a4eba80315c..74b7cccb51a16 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -113,9 +113,6 @@ unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  	unsigned int resv = affd->pre_vectors + affd->post_vectors;
>  	unsigned int set_vecs;
>  
> -	if (resv > minvec)
> -		return 0;
> -

This behavior is introduced in 6f9a22bc5775 ("PCI/MSI: Ignore affinity if pre/post
vector count is more than min_vecs"), which is one bug fix.

Thanks,
Ming


