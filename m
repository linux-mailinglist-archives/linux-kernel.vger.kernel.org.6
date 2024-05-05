Return-Path: <linux-kernel+bounces-168906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5A8BBF8E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E3228116B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351A79E4;
	Sun,  5 May 2024 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsHxNlXI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A823D76
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714892599; cv=none; b=Iw+K3UP3G+1KIcR8IpVquGj/MouvW7ATUTpFcHawEZTUVUzgqM1Auom4bLTgE37xXmz2QGcB82tUJN+7qsJzDlVHaVWoPQSeQsgscCUCGiwoA8yer8mD3Udf+RnOG9WXpIzNTh8hUYtShwKrzszKbmZ+SNjiAc1mSxi5lgRhy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714892599; c=relaxed/simple;
	bh=9hZnRh56Hgq6alvC3MohA6OZF2IYSHDrjE3HGOFKtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz22DrCdx84cE16gvGbudpnEwc0KL5kRkH4TqRxCsNKzXD3G6rFIuEoZ+r41/n3qH/kaOk+vivFB/Dbte856lIW94Uk5NSlFattBHOOPqk6JERArRkXAtFUXkKz5zWmoNGhoN/MwhVNnpuOYZD3L+NQPpVNrs0jPKgbMUy3+h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsHxNlXI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714892595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S52qHVoar7wlTTIceOF47yDBu4Qxt+6rlWLzG9qUz8Q=;
	b=NsHxNlXIorVvQeCaJpN7+gcKALOqe4xQ0N4wDP/3FF7f8CetlEXFAQjQe7hg4kdva7eQnQ
	aVgC8ThSx+mWa5oSdNy0IVxNtImDWD4K2CFl+2wPzzKQoL1IRetk4AHXipE9iswWrLjR1j
	ZxqrDmQTeeH4ePkxyRCQaY6EifqIT8o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-3gqcqRtTPkC4Q8LzzG5xBQ-1; Sun, 05 May 2024 03:03:11 -0400
X-MC-Unique: 3gqcqRtTPkC4Q8LzzG5xBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A49101150D;
	Sun,  5 May 2024 07:03:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F65C13FA1;
	Sun,  5 May 2024 07:03:08 +0000 (UTC)
Date: Sun, 5 May 2024 15:03:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] crash: Remove duplicate included header
Message-ID: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
 <20240502212631.110175-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502212631.110175-4-thorsten.blum@toblux.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/02/24 at 11:26pm, Thorsten Blum wrote:
> Remove duplicate included header file linux/kexec.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 066668799f75..c460e687edd6 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.44.0
> 


