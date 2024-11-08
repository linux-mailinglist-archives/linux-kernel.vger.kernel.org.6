Return-Path: <linux-kernel+bounces-401171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD99C16C9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0381F24EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210C1D0F51;
	Fri,  8 Nov 2024 07:08:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA435DDA8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049701; cv=none; b=TLkW+WO2fy4bUTkua5SHBu7saJx0XSirJyRon4rgb/zmykY1sHgG6oihbBztppkG0PSvNyoH14rdrB8d4wTjHBnySy1h2DxjEIOTlNFr5Z9t4u/BenmvpjAFl4ApNDO/wVa7cDWfG2CMJjw8W39HB8ME4Ofqod+RU0dVVDFOKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049701; c=relaxed/simple;
	bh=Ew36ksT+oX+8/RU8nWQadFRWIm7fTggzOfZ9S3UXCDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3K4E5RsR50Qz0Lt21XEV4RkbOfC0apADd946uGT96X/5yoCTCYZm7P40DpqAc2qxCt+A0bJFygDAtbFQmW195TuXw2DS5fuJ0g95OmQ1PxcAT3BR1+19+cJjawq0fbzPydImHjzCimxCVtsAGh1OEkrYOYZijt6fG8Nq/MRDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D2CC68AFE; Fri,  8 Nov 2024 08:08:07 +0100 (CET)
Date: Fri, 8 Nov 2024 08:08:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bob Beckett <bob.beckett@collabora.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Message-ID: <20241108070806.GA9216@lst.de>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com> <20241107165131.3462171-1-bob.beckett@collabora.com> <Zyz2oiQ2pco15HHT@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyz2oiQ2pco15HHT@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 07, 2024 at 10:19:30AM -0700, Keith Busch wrote:
> We have a constant expression currently, and this is changing it a full
> division in the IO path. :(

Yeah.  Given that the device is broken I'd just have it pay the price
and never use the small prp pool instead, which just adds a single
extra branch to the fast path.

