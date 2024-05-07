Return-Path: <linux-kernel+bounces-171761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3978BE873
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEC5B2A1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BFE16C85F;
	Tue,  7 May 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXq8MApD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350E16ABF2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097678; cv=none; b=Urz3IT6XqxE4WQQlUi4L7tMYIhrMKPU7RxzldypOa4GEI6zylGtw/5eR0QVZbU/OgQbNalEs7PCzhmt5qT3EDF7j2K+18mLdBYy9p0/Gh5qWfmwMu93L77q+zUkM21NnvR8FjP0+SvACHK+4SlPQax/MEKXOJPvNtY5xIyImn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097678; c=relaxed/simple;
	bh=uDr94odQe8OoQaFPGiq0E+3/jKUcjGtIbbMd+XhGBRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMgyhl4cbTCPFPveUZq9rOEdEvRZ4d1HVcKQ+gliLyAh2x6cUIpkGvfS0E6obIy6v5BgQ5QJEAsWMvTLGoPrQy2euOx+p+Y+HRDGXbfRrxcEI34hyBBW5o8bze7CTn6k8TTKaUBM5HcRoo72Q1lCutXNC6LI5ZaMP2t1/CN1nDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXq8MApD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715097675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bqj+NSNknAKcKDogP9g0dp95XkIoSf3FKtqZnMGIcU0=;
	b=aXq8MApDkbMsC/RFjpfsw4OVTfytYYt8dkhx+f0Rtq6SjylDzmx9xIalaZO2SirCjJQY3o
	DuxLmFCoRseBwM2s+HPWH0/l6aW18Fo5XI+zJPKSV2ggi+MfFxkeJ4+uP2u0NuyB3S3++w
	3TaPhy/QOwUjuVzqzhC2Xjn3mhROCOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-MowG0XtLM_SWxohaTA-HCQ-1; Tue, 07 May 2024 12:01:10 -0400
X-MC-Unique: MowG0XtLM_SWxohaTA-HCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1260F185A783;
	Tue,  7 May 2024 16:01:09 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A04A43C25;
	Tue,  7 May 2024 16:01:08 +0000 (UTC)
Date: Tue, 7 May 2024 12:01:27 -0400
From: Brian Foster <bfoster@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>, Su Yue <l@damenly.org>,
	Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC value to
 UAPI magic.h
Message-ID: <ZjpQV0ddhG9sUo8P@bfoster>
References: <20240507153757.150891-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507153757.150891-1-pvorel@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, May 07, 2024 at 05:37:57PM +0200, Petr Vorel wrote:
> Move BCACHEFS_STATFS_MAGIC value to UAPI <linux/magic.h> under
> BCACHEFS_SUPER_MAGIC definition (use common approach for name) and reuse the
> definition in bcachefs_format.h BCACHEFS_STATFS_MAGIC.
> 
> There are other bcachefs magic definitions: BCACHE_MAGIC, BCHFS_MAGIC,
> which use UUID_INIT() and are used only in libbcachefs. Therefore move
> only BCACHEFS_STATFS_MAGIC value, which can be used outside of
> libbcachefs for f_type field in struct statfs in statfs() or fstatfs().
> 
> Suggested-by: Su Yue <l@damenly.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

I was thinking you'd just rename the STATFS_MAGIC def locally as well,
but whatever.. LGTM, thanks for the tweaks!

Acked-by: Brian Foster <bfoster@redhat.com>

> Changes v2->v3:
> * Align tab with other entries.
> 
> Changes v1->v2 (all suggested by Brian Foster - thanks!):
> * rename constant to BCACHEFS_SUPER_MAGIC,
> * keep BCACHEFS_STATFS_MAGIC in bcachefs_format.h, just include
>  <uapi/linux/magic.h> and use BCACHEFS_SUPER_MAGIC definition,
> * move the constant to the first chunk.
> 
> Kind regards,
> Petr
> 
>  fs/bcachefs/bcachefs_format.h | 3 ++-
>  include/uapi/linux/magic.h    | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> index f7fbfccd2b1e..3b831415409b 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -76,6 +76,7 @@
>  #include <asm/byteorder.h>
>  #include <linux/kernel.h>
>  #include <linux/uuid.h>
> +#include <uapi/linux/magic.h>
>  #include "vstructs.h"
>  
>  #ifdef __KERNEL__
> @@ -1275,7 +1276,7 @@ enum bch_compression_opts {
>  	UUID_INIT(0xc68573f6, 0x66ce, 0x90a9,				\
>  		  0xd9, 0x6a, 0x60, 0xcf, 0x80, 0x3d, 0xf7, 0xef)
>  
> -#define BCACHEFS_STATFS_MAGIC		0xca451a4e
> +#define BCACHEFS_STATFS_MAGIC		BCACHEFS_SUPER_MAGIC
>  
>  #define JSET_MAGIC		__cpu_to_le64(0x245235c1a3625032ULL)
>  #define BSET_MAGIC		__cpu_to_le64(0x90135c78b99e07f5ULL)
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 1b40a968ba91..bb575f3ab45e 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -37,6 +37,7 @@
>  #define HOSTFS_SUPER_MAGIC	0x00c0ffee
>  #define OVERLAYFS_SUPER_MAGIC	0x794c7630
>  #define FUSE_SUPER_MAGIC	0x65735546
> +#define BCACHEFS_SUPER_MAGIC	0xca451a4e
>  
>  #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
>  #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
> -- 
> 2.43.0
> 


