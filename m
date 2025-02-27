Return-Path: <linux-kernel+bounces-537368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DBA48AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE68C16CC36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F827182D;
	Thu, 27 Feb 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBeWHILd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394D26E968
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693559; cv=none; b=dKnUSvQ3VBtObaHddFnMJuxNKPNxUU6dK4zZRoOPs58TvFfM9rsla9UIlisE2Lxz2VyLvBpTfedHOIS0DWaCQaI/ROxh6oGw6z6WG/XUGX0rAhGOe6Fp847ITxHl7p7nMUT3Ev58tcvEVHAp8v8UuT38hOP0f2KD9tjjUEk38UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693559; c=relaxed/simple;
	bh=QCZYkUvlE3UzfZWsSc3yNZXvJUA9mEjps0buAFf2xDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTobwnEWw2niS1RAIoUIOqYiNpz0oXnPxu2gVpTUYu/tu2qlqFNAmHlwX5ccGNm0ov7GgrKC0hmVAGl/oZr3qAzQn62AKt+6/g3gY383oBwPqZ4s5oA/6NWd+gc14SWSvWcxRAkJ/z14AAFYFjM/T97CObcNmfT8z3HhLSVPYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBeWHILd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740693555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FuUccHO+G4qMZYQP5ieKHnhtOwv7wuzDWMMfQ5p9rW0=;
	b=RBeWHILd5ECST4Mrr/Rig0VKVLiqasJmIv7jtBnLJFqW7M2L8ZXKQGt57F+UBYoAY2VaCs
	pJv4QvhEOXYSDmKArf1l4taShKBpedjtv36wCEIpLVMX9dDnyPNNr7U6Z6BVvwO7PJuAC0
	GYlUdIPTv/R5JLTRX/DxrJ1wa4lB+Tw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-H9Xwu2UYPx6-_qK20sIWsw-1; Thu,
 27 Feb 2025 16:59:10 -0500
X-MC-Unique: H9Xwu2UYPx6-_qK20sIWsw-1
X-Mimecast-MFC-AGG-ID: H9Xwu2UYPx6-_qK20sIWsw_1740693549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D214B180036F;
	Thu, 27 Feb 2025 21:59:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 448A61800357;
	Thu, 27 Feb 2025 21:59:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Feb 2025 22:58:38 +0100 (CET)
Date: Thu, 27 Feb 2025 22:58:34 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pipe: cache 2 pages instead of 1
Message-ID: <20250227215834.GE25639@redhat.com>
References: <20250227180407.111787-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227180407.111787-1-mjguzik@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I already had a lot of beer, can't read this patch, just one nit...

On 02/27, Mateusz Guzik wrote:
>
> User data is kept in a circular buffer backed by pages allocated as
> needed. Only having space for one spare is still prone to having to
> resort to allocation / freeing.
>
> In my testing this decreases page allocs by 60% during a -j 20 kernel
> build.

So this is performance improvement?

> +static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
> +{
> +	struct page *page;
> +
> +	if (pipe->tmp_page[0]) {
> +		page = pipe->tmp_page[0];
> +		pipe->tmp_page[0] = NULL;
> +	} else if (pipe->tmp_page[1]) {
> +		page = pipe->tmp_page[1];
> +		pipe->tmp_page[1] = NULL;
> +	} else {
> +		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
> +	}
> +
> +	return page;
> +}

Perhaps something like

	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
		if (pipe->tmp_page[i]) {
			struct page *page = pipe->tmp_page[i];
			pipe->tmp_page[i] = NULL;
			return page;
		}
	}

	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
?

Same for anon_pipe_put_page() and free_pipe_info().

This avoids the code duplication and allows to change the size of
pipe->tmp_page[] array without other changes.

Oleg.


