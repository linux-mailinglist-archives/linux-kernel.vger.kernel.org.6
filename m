Return-Path: <linux-kernel+bounces-548048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74AA53F33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C1B7A1DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A418EA2;
	Thu,  6 Mar 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQiiVbXA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AC10E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221387; cv=none; b=X+k8aRyuT09bT62d2VAil2La8E99gJnKjT/1I1o2DI6NJ3UTG6GlyK5yXckGRN3hb+dFNYT5xyAvQmU7Wo5QM752pYtxUgty1TMk/FuUDtZUz6/dA7icsrsvJuOMA553mN38czLECQXUzDI5z6mdLRs8Imq1bSRiJsqVMNJXda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221387; c=relaxed/simple;
	bh=XvSYVIWIx4JlgRvVKfDmNeOqRvGeKDXeKAmROwFoSEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5tbHTx0LWvsyZb2Manm/ejl+Byx26rfIuIPKq4sfCYsz89YYIfq1k0xOP0Jz6Fflvk3Dh0DUqzXT0z5lZrM31vpjzAHL/Hq0EXAiSDIz0QUU9b8RUUIg+kDPqvSMS4wQcs/7HEb/8s21iG+LFhQR8j7AI/xzw+8rh8LokqDxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MQiiVbXA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qIu7osBSJiIgxNywGkZoX9U3Sf37DBFZmEM3WJe0tKA=; b=MQiiVbXAENaxQRYFHwlV/IXpms
	43KATUc6fOY2IJ1xYhrmSDo41DUMIC/BpEyopAt+54yu9aCbLZzNez2I0S/kAlzxrbRAaz5Brv3ET
	6NmTRIfwrg+Y4Ti23kjow0uS46Li7RvTiLOaFWXxSZZpEBln6CZa2+NorIMUNX36eGQMfjCIE1E+4
	gR01GmUAvQ3l7RQDWeHmpXFxfX27KF/JiXNqsmmppUhKt1o6Kx36m/g22q4fZB0NsNqk9a/X9JEOY
	97aX519bjLFOa+AbefuNEWweKq2L3/ztgfMyIz/TLMCR+DEYZhTMWXsEUsl1dZxxYNnQZ6O725WuE
	iWExdbcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpzDu-00000009i3I-0ezv;
	Thu, 06 Mar 2025 00:36:26 +0000
Date: Wed, 5 Mar 2025 16:36:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kit Chow <kchow@maxlinear.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Message-ID: <Z8juCusc7oA2VG9v@infradead.org>
References: <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8jpi5nf63APb8aN@infradead.org>
 <SJ2PR19MB80942BB17ED2D5B34AF2C230A4CA2@SJ2PR19MB8094.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR19MB80942BB17ED2D5B34AF2C230A4CA2@SJ2PR19MB8094.namprd19.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 06, 2025 at 12:30:48AM +0000, Kit Chow wrote:
> Hi Christoph,
> 
> Is the kernel licensing issue causing the shrinkage in hotplug memory range? Can you please provide some more info on how MaxLinear is violating kernel licensing and I can take it up with management? 

Your comany sells slimey solutions violating the kernels GPL licensing.
You shoul be ashamed in a corner and not ask kernel developers whos
license you violate for help.  Go away!


