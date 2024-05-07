Return-Path: <linux-kernel+bounces-171444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC948BE459
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72071F27832
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F816C45B;
	Tue,  7 May 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG0RxQ/t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FF15ECFE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088729; cv=none; b=Kn5j2twu9LSJvR+qbnEDe3TlIMGvhdWz2PllscVrePKeAqiP5AmdqwnORXjlWyRHnI2WhYoj6EDCqeNxThgBKwCot3ugb2zUTx0fO1tSo7EuG0dc3/BF/oDduwzEttJgGwHnACqc8l7DFMn2vNaVhb5wEFb2ejb7xBabOpWD8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088729; c=relaxed/simple;
	bh=sBzFX/sadxZL2cJQXTBg/KJIkDZ/894I5/zI13q8LZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYrjXeKcInovSdptIzR35J85aYUlaFcZh92WmucCMQ8JlZmIRA9fipMIr+8jn9sTAefsrdM7Wesco4GbDtbod8Uhz9qf/b5AdV589IRCexBxYubrtFyWcjN3aJk7B+8imvC7dS7Cc3OFq0nSqX3GPuJkZojqX2ndcHCYuKjx8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG0RxQ/t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715088726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIYdM7z5+Xm1S+hITzfLVzD6aDULkUJFC6+y9ilbGSk=;
	b=PG0RxQ/t9HvQ/jrzumbNaLau9EK1YuEcTkvNDQNAkTlk3g2u4fEY9BYcm3lxfwXhOGZin5
	Tb3PGRaYoTsHXyNR1y72lKWuRgcvTcwRlzhPrlYQ0INZ7rQqc9QqfXS40+qqyZIhRo4nok
	XODVVNqcjrBDX+EMQCNgJ0+b77OPly8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-bPPBVKt9NLmUkqabt3Wgiw-1; Tue, 07 May 2024 09:32:03 -0400
X-MC-Unique: bPPBVKt9NLmUkqabt3Wgiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 474F784B16B;
	Tue,  7 May 2024 13:32:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.146])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C793C35;
	Tue,  7 May 2024 13:32:01 +0000 (UTC)
Date: Tue, 7 May 2024 09:34:23 -0400
From: Brian Foster <bfoster@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>, Su Yue <l@damenly.org>,
	Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC to UAPI magic.h
Message-ID: <Zjot36J9negcVlfh@bfoster>
References: <20240507111124.118520-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507111124.118520-1-pvorel@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, May 07, 2024 at 01:11:24PM +0200, Petr Vorel wrote:
> There are other bcachefs magic definitions: BCACHE_MAGIC, BCHFS_MAGIC,
> which use UUID_INIT() and are used only in libbcachefs. Therefore move
> to <linux/magic.h> only BCACHEFS_STATFS_MAGIC, which can be used outside
> of libbcachefs for f_type field in struct statfs in statfs() or fstatfs().
> 
> Keeping non-standard name BCACHEFS_STATFS_MAGIC instead of renaming it
> to more generic BCACHEFS_MAGIC to not confuse with the other bcachefs
> definitions.
> 

Perhaps it would be better to use the standard naming for the global
header and let the bcachefs subsystem catch up with better names for
internal defs? Something like BCACHEFS_SUPER_MAGIC also seems like it
would be generally consistent, FWIW.

> Suggested-by: Su Yue <l@damenly.org>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  fs/bcachefs/bcachefs_format.h | 2 --
>  fs/bcachefs/fs.c              | 1 +
>  include/uapi/linux/magic.h    | 2 ++
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
> index f7fbfccd2b1e..52e03f13b780 100644
> --- a/fs/bcachefs/bcachefs_format.h
> +++ b/fs/bcachefs/bcachefs_format.h
> @@ -1275,8 +1275,6 @@ enum bch_compression_opts {
>  	UUID_INIT(0xc68573f6, 0x66ce, 0x90a9,				\
>  		  0xd9, 0x6a, 0x60, 0xcf, 0x80, 0x3d, 0xf7, 0xef)
>  
> -#define BCACHEFS_STATFS_MAGIC		0xca451a4e
> -
>  #define JSET_MAGIC		__cpu_to_le64(0x245235c1a3625032ULL)
>  #define BSET_MAGIC		__cpu_to_le64(0x90135c78b99e07f5ULL)
>  
> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> index fce690007edf..1c856ae2b0e2 100644
> --- a/fs/bcachefs/fs.c
> +++ b/fs/bcachefs/fs.c
> @@ -27,6 +27,7 @@
>  #include "super.h"
>  #include "xattr.h"
>  
> +#include <uapi/linux/magic.h>
>  #include <linux/aio.h>
>  #include <linux/backing-dev.h>
>  #include <linux/exportfs.h>
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 1b40a968ba91..45c8f4916167 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -103,4 +103,6 @@
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
>  
> +#define BCACHEFS_STATFS_MAGIC		0xca451a4e
> +

Is there intended to be at least some logical organization to this file?
It kind of looks like it, but maybe not as a rule. Personally, I'd
probably stick this somewhere in the first chunk of definitions where
the other major local/block filesystems are, but just a nit.

Brian

>  #endif /* __LINUX_MAGIC_H__ */
> -- 
> 2.43.0
> 


