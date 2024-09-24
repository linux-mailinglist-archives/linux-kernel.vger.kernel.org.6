Return-Path: <linux-kernel+bounces-336627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A47983D39
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F231C226B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644FF17C98;
	Tue, 24 Sep 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mqYapK5m"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E523D7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159963; cv=none; b=DI54NhU4uuMiVq99px+auct+VtI7eS7u0iJEwKdb2gpCBeBMl2VIovLTiQkMYz4JbyiWb+Qr/pc21PWdK8hRNgBHLr8YBELy11RhaQXMcoIZP+aRjbzJzdpgLRwY1hhHDF+NcFCaxz6hRaelVvqhQ9kIiYdiJCrBk1Cs4HzZ8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159963; c=relaxed/simple;
	bh=frTifoM39MgH/psKMP86gXUsY8nXIpVTY2nmLrvPDqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWwUhnMlv4/1SkL7xbCqc6zdj393X4GypEZEKlIu43g93GwA0OwTOMVf4RMU6j3uCOPT3axgflTxU/X9X5eQLblOIsBOQKw3bjNAdShwkHtpWhBkr/QQ7IvzHcb4IvtiOfup69ljQopgLFSz7ebt8hZBFdhegIxqOftlRZN6wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mqYapK5m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/bwp9K2z7oMAUdlrrH8WLgUyutuYE9dnJFxhsyUAv/o=; b=mqYapK5mnJvthtVuUYKp2l3t85
	ni0DzoUkLwdThX++tfM2tKch9RobO1gUlXR0sL75EXRANP5AltdhnKG3WykP+eNIDe8ztqcs+FupU
	OLBoHRoVpGd7wMtMesLuWutFsVfkAbhxINY3io6hvgrTxbgBhf0OMaPJs44KqDKsH+qYGdG7Cc1Sh
	INSzs3Q7mJ3pmr34KmPMW3A8Epa5VoHxafiJpRrIp06Sx8kvGcKAIF0Haio6Ry8xQoHc8ytLxDZDS
	6kNFaOUb6EKRB5Jrcb4YwZMvxQ3ZX2ZJkuzVZILDy8yyxTWSAFptV6WrUyWM00dUicZekS40G7nOq
	e1QEp/3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sszCi-00000001HHO-2wcJ;
	Tue, 24 Sep 2024 06:39:20 +0000
Date: Mon, 23 Sep 2024 23:39:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Message-ID: <ZvJemFN1qdvi8qo-@infradead.org>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <Zu2A1l_cX36sOVcB@infradead.org>
 <VI1PR09MB233391A7544336FBD06303CE946E2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR09MB233391A7544336FBD06303CE946E2@VI1PR09MB2333.eurprd09.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 22, 2024 at 10:06:59AM +0000, Vladimir Kondratiev wrote:
> This is the whole point - there are platforms where you can't allocate 32-bit
> dma-able memory.

Ugg.  They will be broke for all kinds of devices (plug in PCIe devices
IP IP blocks).

> Unless there's IOMMU or some platform specific tricks,
> DMA address is same as physical address.

Well, that's where the usual platform specific trick is, as the
platforms with high DRAM either have a mapping between physical
and DMA range (see the dma_ranges concept in the DMA and OF code)
or a mirror of the higher addresses.  Or very rarely (e.g. sparc)
a required IOMMU that is always used.


