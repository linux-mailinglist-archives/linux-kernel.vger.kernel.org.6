Return-Path: <linux-kernel+bounces-365284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6299DFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4676328237E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E771AB526;
	Tue, 15 Oct 2024 07:57:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D81741EF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979034; cv=none; b=V/iEtgXbIUVoKNVp69teYsY9IkxETZgssyfIEgOGCMzHovTBbMvjiumcYUEgImh0T004N2sm1FUIfiQxLHzGdKfk5tms+NGjDCU/P8ubyzA4TR8nEGfQDDdYTH+sqaByEwEZyIyTQyw25towVrAsBhg0S1MzalybreoIK8H+1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979034; c=relaxed/simple;
	bh=OOZrHTEyec8I+RfSjpQYoLPTXxm9QEXzIN8WSPEvVUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2cevtfKkSA0iEGjreU7O/sCCEAP8NjhrK3gsnZPsxoTLN1/IflvNPaQ6JcAXma1kPyfzRc6lgmKHO1hoPGDs/ZBK2ZmBUcEjNuxaUXUWYXbdks5iXcMup5f08Y+6SPGYnGLROcbZfVYxo20UkbsFJKyHuqFKQiwczARr/CYUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53C1B227AA8; Tue, 15 Oct 2024 09:57:10 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:57:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, stefani@seibold.net,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
Message-ID: <20241015075710.GC25487@lst.de>
References: <20241014144643.51917-1-hch@lst.de> <ab456339-18fd-45d8-abde-b04196e0f604@kernel.org> <20241015075053.GA25249@lst.de> <f5469873-f099-4926-883a-37badec904df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5469873-f099-4926-883a-37badec904df@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 15, 2024 at 09:55:06AM +0200, Jiri Slaby wrote:
>> Because it would not comple with out it.  To be specific: asm/io.h is
>> where __raw_readl and __raw_writel are defined, and we generally prefer
>> the Linux over the asm headers.
>
> OK, but how does this relate to "kfifo: don't include dma-mapping.h in 
> kfifo.h"?

Because before that it get io.h pulled in through our batshit crazy
header depency chain. 

