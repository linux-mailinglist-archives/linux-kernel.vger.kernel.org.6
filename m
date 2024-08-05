Return-Path: <linux-kernel+bounces-274667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743E947B47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0225D281F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD919159217;
	Mon,  5 Aug 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkPNtGBq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A01553BD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862378; cv=none; b=hDjw1otcWoFxdxgF7bf4+IAQYE9c2XKU3S6q63WFtHoCpvtfxV0Su/kioqPXt7f0FGYN4yRgij4w12GfMQ/WlC67v92Oz8R1rxoK6RZeuMgCdOEWbUMvdyIrZAKSyD31AnaQx17gXze5dYqH7bDa/wSovnrIPWA+jPrn6QdOy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862378; c=relaxed/simple;
	bh=rJS+qElkhy5+j66Bcy+bEPtu7bAV5J+oGQhJjrLaFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=setMNoLuYhDDKsSWU7BeheZ7ppPQpw+lZ1L5t3sQPdZ/TtwGFlBXm++0eZ/FQQ5b/lShspA0776thRERIEBuLuQwNA+60ty6+zzkoX0nAXaPbootcS8fo+QRQn+I9Lf41nP9s/ViEnlmvxrNREGJu9HLXmBFzWF5gWYG7KXp8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkPNtGBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722862375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wg5uEtaKzzmeOJAOD80NwwJkOITcZMlBczYm/4JZgkM=;
	b=PkPNtGBqnii62nhfS/EEcsnrGMCJJX2MCl3q0ekwOS7duJ0/2d0LpKAUTz2Su2w6A76TBX
	nUlAqBEuJTDusfXZAeD1b5tBA7SPrcYAJtCK1Xh5l0yClUj7AeT8C+EjggkeNUbrBvEBxt
	d1L4auXQc3fNFtKROMLJJWHhKnRrwB8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-KaKSC-31OV-NDoQoT0NnNg-1; Mon,
 05 Aug 2024 08:52:49 -0400
X-MC-Unique: KaKSC-31OV-NDoQoT0NnNg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2AD11955D4C;
	Mon,  5 Aug 2024 12:52:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28F3219560AE;
	Mon,  5 Aug 2024 12:52:44 +0000 (UTC)
Date: Mon, 5 Aug 2024 07:52:42 -0500
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nbd: implement the WRITE_ZEROES command
Message-ID: <f2kaityrjmmstzvqq7xu755ikstida2hcnnng634oeo6fxjfbj@zrgbeik6fwz6>
References: <20240803130432.5952-1-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803130432.5952-1-w@uter.be>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Aug 03, 2024 at 03:04:30PM GMT, Wouter Verhelst wrote:
> The NBD protocol defines a message for zeroing out a region of an export
> 
> Add support to the kernel driver for that message.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> ---
>  drivers/block/nbd.c      | 8 ++++++++
>  include/uapi/linux/nbd.h | 5 ++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5b1811b1ba5f..215e7ea9a3c3 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -352,6 +352,8 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>  	}
>  	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
>  		lim.features |= BLK_FEAT_ROTATIONAL;
> +	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
> +		lim.max_write_zeroes_sectors = UINT_MAX;

Is that number accurate, when the kernel has not yet been taught to
use 64-bit transactions and can therefore only request a 32-bit byte
length on any one transaction?  Would a better limit be
UINT_MAX/blksize?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


