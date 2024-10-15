Return-Path: <linux-kernel+bounces-365283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2675399DFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE0DB2250C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB431AB6D4;
	Tue, 15 Oct 2024 07:56:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18918189BA7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978978; cv=none; b=BD5JrYbLak2bY5CkuKnTmC+zZbTlIVDRnWpbldFJnYRdcpynF08TEfHhLpII/myGnqXp8aTKmjS34OdbvicTc7zqoC09rNhGr0ESKg7H012JsLyHOukRTp9xv6wuYXNAk2KtQrs10/wXF+UuK0I5RMGwGUZxlIoU3a1G9MKpBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978978; c=relaxed/simple;
	bh=mKuO4UDBN99v2TE32dBCY5mx8L/dJmJwLDrgpzIO8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df/FS/WFt6wKT+NdZJEtffQPNNMFy36sPtQMgcG4WDJRJvihTNBNf5NkFMJBwkWta1JyaQ49gB23DojsRLRprDfZ5PDHe7TPP64MIDv0KdkscPgF2ZVnHxwCVoqajtDYp9HY42FpZd4edrNIihY6sYX/iBevNiFsDztUFk+e3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ACD3227AA8; Tue, 15 Oct 2024 09:56:13 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:56:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, stefani@seibold.net,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
Message-ID: <20241015075613.GB25487@lst.de>
References: <20241014144643.51917-1-hch@lst.de> <2861f304-c8d9-4e56-8a91-9ddf6d7b05a5@kernel.org> <20241015074043.GB24501@lst.de> <7f723486-237f-47d2-b9c1-e5312876dfb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f723486-237f-47d2-b9c1-e5312876dfb5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:53:52AM +0200, Jiri Slaby wrote:
>> DMA_MAPPING_ERROR is never used by kfifo.h itself.  It is used
>> by user of the header that instanciate one of the macros that use
>> it.
>
> Well, I don't understand. Looking at:
> #define kfifo_dma_in_prepare(fifo, sgl, nents, len) \
>         kfifo_dma_in_prepare_mapped(fifo, sgl, nents, len, 
> DMA_MAPPING_ERROR)
>
> You'd have to include dma-mapping.h if you used this macro.

Yes, obviously.

> Even though you 
> do not explicitly use any other def from the dma header.

Sure.

> Well, this is not a definition of self-containment.

Yes, it is the exact definition of it.

> If you use every macro 
> from a header and it does not need any other include, then it is 
> self-contained.

No, that goes way beyond the self containedness.  In fact these days
the main reason to use macros is exactly to avoid these kinds of
dependencies.


