Return-Path: <linux-kernel+bounces-375803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7EC9A9B00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F47B282324
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D814B088;
	Tue, 22 Oct 2024 07:29:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667D811F1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582159; cv=none; b=TpP+CzOEviH7cQc94mYTjUaWp/yZquvRcte9F018eI9kfYkexncS503wYTDs2aC+SjhfKAMVoYMHnClPZxLoEUAFwMPeuIskB7PfkT4Pox2i19h1equASVd1oU2mlPvkrhiYrkMtJh6R/O9TbDiW3xsB3IAg2UxqeIBEmgJWoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582159; c=relaxed/simple;
	bh=GlP/lRWGBZdfU6JkHKsIO8pfbfRNVdkUHl5BNg/NUpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVpE8FrP3eYIJmhvti43sBmpTHzdVIfof2jstgwPXDEYVUlOyQO1TfInL5QlmK0TOp2C6u1yBCfSueT/RkeGPM2Srn2Z8N1jajtbzSkjZA66YjPhFBlobt9SOsuc/1E3kk90cnzlUJvZkY+S8N12pWyu2hHrX+rcdz9wKqqRjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAAD1227AA8; Tue, 22 Oct 2024 09:29:13 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:29:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: After the memory is released, the
 corresponding pointer needs to point to empty
Message-ID: <20241022072913.GA12854@lst.de>
References: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 22, 2024 at 03:01:50AM +0800, Liu Jing wrote:
> The code frees memory pointed to by dev->queues. After freeing memory,
> dev->queues should be set to NULL to avoid dangling Pointers.

How claims that?  Clearing pointers clearly defeats redzoning in the
slab allocator so actually is counterproductive.


