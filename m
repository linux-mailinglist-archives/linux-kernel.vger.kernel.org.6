Return-Path: <linux-kernel+bounces-260998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47A93B157
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8A3281DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37676158D60;
	Wed, 24 Jul 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtUSYbjQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782C12D214;
	Wed, 24 Jul 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826428; cv=none; b=jjizH5KxnvpPgHD+V3n0oVcKRphTjoTYFV0lh2kmV9bzMq7LyyGH7oF7VFTnwXAwx3yNiRdKifrXwRjxfjmmwEY/mTPWT5Dg7NbNtqNDL0+mbBsckuakL8yRa80jIBYkRvBGnDohiKfol8WDFotX/16NaDYTbdGJDUoHXFVAfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826428; c=relaxed/simple;
	bh=/FI/ucVqmMj9jsHikVZwjoFjxb10/bWcExMrDUeKIoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNGj5i9ZX3lnJcxJagvMGJYuDoyM+s5QuF4/72nt6K24jl513ZSmtITQKabAF3ERJmm+qwK718jf1XkdmIk5lk9AcqE2tG/AbvwD+9yayDZkxLmct8LcnJcvxLF1uEeY847V2jWyx2ixezUSOVH3IwKwJm21vMJKE1udr4aXY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FtUSYbjQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QBHCco2pOVst6S+cPIk2HSRmT4n2lXfN/nF+oAcaEHM=; b=FtUSYbjQ1WpJ2OMZ9m8NKUAxJV
	oAEaC3oM338QCkPyzQXOQS7lvogWLNRA6iHSy6SNMGU3rv60IjDv0gGdrKOlcE/sesNuTzgzcRB2U
	qPRhLbiswRQf3YhRSHXEVSLNTIqDPGVVt08mV1Cf8eXn8fRSrIioEOdjGfXTpY3aif1jCKPDTd+tA
	GIa4kOoyX0aj1TMGQ24pTOEnBj5U0lsf3IwEP61q+jouTYo+oCmvhFNY0SLsr7A/fnyfAg0A0qxLx
	SVQoFMbrvWm3n63HbcwGf+OHPRT5YVtBGrgqXg2WN4X/7QzLqULJxluP3RWwO3Zp9UlEGlNC1c8uv
	5u5K3YGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWbht-0000000FOwJ-3AHk;
	Wed, 24 Jul 2024 13:07:01 +0000
Date: Wed, 24 Jul 2024 06:07:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com,
	cuidongliang390@gmail.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH v2] exfat: check disk status during buffer write
Message-ID: <ZqD8dWFG5uxmJ6yn@infradead.org>
References: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static int exfat_block_device_ejected(struct super_block *sb)
> +{
> +	struct backing_dev_info *bdi = sb->s_bdi;
> +
> +	return bdi->dev == NULL;
> +}

NAK, file systems have no business looking at this.  What you probably
really want is to implement the ->shutdown method for exfat so it gets
called on device removal.


