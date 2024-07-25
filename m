Return-Path: <linux-kernel+bounces-262533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E061A93C85D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B98283041
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D83D57E;
	Thu, 25 Jul 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsB5ZbfR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1DF1E528
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932249; cv=none; b=tF0AUGi3U6uiWYbzEdj0zeA7Oa0sELUPHwztTdpvBlX7KEiIvxYA4+gjuO5kO7YLq1LpRWXIpeWxc4QasFDvvxdc7FlVEu0Mutcaj7yekyVOHqfhHGe8/PMMutxcQ08QIWzfffes3230qI2Ze+qYnA4fW+2PMstWdi018NYf0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932249; c=relaxed/simple;
	bh=qyrHzsvZ+fr4cYGQYpVCy8DTG9FS25Klp9PEKJaPtmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmfQPBAMSZ17OEyGJkt4fUjXHC3kBfaz3zhRwsf3Wd0m/TBjNK69vyqW+i8z7VscI8JJ8MhUJogTG5qk0Hu+k4P17HV3KH1z+Qh9aY+qm+lsWghxgeb1KwnKsB39rRWC52Yf0vqSc69n5oHfUJ1MDieGgOqYQvrIMUboprFYoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsB5ZbfR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721932246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1EgtC5Zyd0+M7dW8BgWSZUgLMCFLsbULmk/eMJ3Z2o=;
	b=CsB5ZbfRMEt63gyzWCSTfxjfKBMiBgIuOG5nUVoit5kucj2KwlHabrhoknbC8d8AogcLwy
	dPr5JqlVLXeP9qutX9Nn1kHDLIweNLJ3EEMZpz/hWuuk19Qlf5YGPG2ZlIrlA1mJz6FcFq
	whaCsnyb8guv5eKu52S2BUBQFm9Gldc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-c6HQHpleMdWs_xEVZUrgrQ-1; Thu,
 25 Jul 2024 14:30:42 -0400
X-MC-Unique: c6HQHpleMdWs_xEVZUrgrQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12AE5195608A;
	Thu, 25 Jul 2024 18:30:41 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8241955D42;
	Thu, 25 Jul 2024 18:30:38 +0000 (UTC)
Date: Thu, 25 Jul 2024 13:30:35 -0500
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: add support for rotational devices
Message-ID: <xdq3z4oosh2l4hzlkgxsfbqza6z2q2c2zyznmo24rtt6svlixr@c2w2tpzqlzbp>
References: <20240725164536.1275851-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725164536.1275851-1-w@uter.be>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jul 25, 2024 at 06:45:36PM GMT, Wouter Verhelst wrote:
> The NBD protocol defines the flag NBD_FLAG_ROTATIONAL to flag that the
> export in use should be treated as a rotational device.
> 
> Add support for that flag to the kernel driver.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> ---
>  drivers/block/nbd.c      | 3 +++
>  include/uapi/linux/nbd.h | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

For what it's worth, the nbdkit project recently made it possible to
aad a filter on top of any existing NBD server to change the setting
of the rotational bit[1], as well as a filter to intentionally
simulate delays of a rotational device[2], in order to experiment with
how much impact changing the bit can have when it is not ignored.

[1] https://libguestfs.org/nbdkit-rotational-filter.1.html
[2] https://libguestfs.org/nbdkit-spinning-filter.1.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


