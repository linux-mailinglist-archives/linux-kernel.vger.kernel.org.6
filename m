Return-Path: <linux-kernel+bounces-373562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8FF9A58DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294FA1C20EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA917C9B;
	Mon, 21 Oct 2024 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMDLsoee"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4A3D994
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477626; cv=none; b=l+6XpwBYxbwqfrsb4QtAhkzkIcdm8a7YTLOHZ2CvVvlpknAHqwjgDJU4Y5Pn6bESkYZIolMFA6vv0RKbMFUmR0E+xYia2bXzOFZy05QPKUNOyZK2zEs0bHJ4l5s46OOIEqbsSZAkU5j9PW3gSKIfoXd5+JbC5cmVLhH5YKA3mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477626; c=relaxed/simple;
	bh=wChIIOljRZMbMsClGwWazXIABPZWJ1X/9rhsdtrKznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxjuXeTPSftq1RokazghgvyPWvxm9efy5IQhexkMbBhkifaYEt8alWht8NBBrKHAG4XP1mj3hOwo4JjBzjm87kD1II1LUgZ7Id57mBWYc061JbSQr12elC7N1PgyHDtN4MSEi9Vh3hE+yZjFlVe6nv95/loBSHxQ4x6nrf83/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMDLsoee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729477623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+sjMziFfxbGDr6d+iWUv4ZQCz7jkJM/gB/nV/7pRVlc=;
	b=SMDLsoeedojgzwHeaYgr1chxujM4zCfqTXgwfHIaj7R08DmqT8fjMpk7JhrKSAgD5lu47A
	fxG2Zs1VKlPT7SgVG+x1QqGMgNVKqYv+kxBc6OnCQImPx/aou/n28nGrwR1wiDnEXdDQl8
	ehZh6/qjR7XnqSsMdmx6ryUMyCSOEgI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-mJgu-wZ7M3C4MjtQVk-IAw-1; Sun,
 20 Oct 2024 22:27:02 -0400
X-MC-Unique: mJgu-wZ7M3C4MjtQVk-IAw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEDDE195609D;
	Mon, 21 Oct 2024 02:26:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F4C119560A3;
	Mon, 21 Oct 2024 02:26:53 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:26:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
	dhowells@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iov_iter: don't require contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZxW76N4hU2_4Zs3E@fedora>
References: <20241011132047.1153249-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011132047.1153249-1-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Oct 11, 2024 at 03:20:22PM +0200, Christoph Hellwig wrote:
> The iov_iter_extract_pages interface allows to return physically
> discontiguous pages, as long as all but the first and last page
> in the array are page aligned and page size.  Rewrite
> iov_iter_extract_bvec_pages to take advantage of that instead of only
> returning ranges of physically contiguous pages.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: minor cleanups, new commit log]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> v3:
>  - open code the iterator
>  - improve commit log and comments

Hello Jens,

Gentle ping...



thanks,
Ming


