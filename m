Return-Path: <linux-kernel+bounces-370192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE39A2935
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C016C1F21042
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0F1DF72C;
	Thu, 17 Oct 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5rmp3w0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8111DF26F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183240; cv=none; b=JRUcDXMrp3pbAE7a1/01+o7+e0BUvLvdMvgIFRI/2h1EPkkmtE7+Vb893RfmYI02EUCJSyV4N4ZhCndGfC9VPemXEs7XUuqkK3bhl7d3FBvmKaHn2XUlGorYZ2yFFMrop4zU91WtxNaae5xEsaopfJ/lq2HQQ3o7ySmL1PEPhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183240; c=relaxed/simple;
	bh=6eOYogsD0a3OKM1weP7TQicoaifRnyoiDZo73obPdmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHQ4t4636gGsf/eRt07GZvAGVEyHJCR0bdApXaoAAi9Ob+ZcKNm57IRbOwMxwudu/suT5oxqvn7k0vsTL7tU1RdzK1dAD7+/XfYzLfQPlEmO57NVsQs2kaAthYOzXwYAHLnHkAnYLmQFTyUjfceQIphh0+VqrbHSNjjkUEDOqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5rmp3w0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54798C4CEC3;
	Thu, 17 Oct 2024 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183239;
	bh=6eOYogsD0a3OKM1weP7TQicoaifRnyoiDZo73obPdmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5rmp3w08F/HfPsrqpYjiMQjPQ6IMkiosR7ZoJVI48ooEJMumCKcpOwhHExA0WYEe
	 hHBVtwHzs9ItTfcRDYXq5U75vKDFi2FUu2JiIcRJNvbyj0uIy189ZiquAQ8vNZWj7t
	 LkuZp4AoptEThaPY4ObBlDsXR0/LQ/H8GTm9J6b9zyNRS10PxfaJyS6DNOpaEkp5YK
	 UQUe+qKKlICYQaL8W7biAXjcH6ptiTINpcMVcg94RL5hejrPj0WsD4MrXEJcRGv7+j
	 rgT6kHMeVFgmbmm0K9E7q68zc/PmeGpe+Ijm8Njhn9CgZKKBDuzC+NoWL9SDIk0fXb
	 uf9sT7Oz3SW/Q==
Date: Thu, 17 Oct 2024 10:40:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Abhishek Bapat <abhishekbapat@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Prashant Malani <pmalani@google.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
Message-ID: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016213108.549000-1-abhishekbapat@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016213108.549000-1-abhishekbapat@google.com>

On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> max_hw_sectors based on DMA optimized limitation") introduced a
> limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> (MDTS = 5). This restricion was implemented to mitigate lockups
> encountered in high-core count AMD servers.

There are other limits that can constrain transfer sizes below the
device's MDTS. For example, the driver can only preallocate so much
space for DMA and SGL descriptors, so 8MB is the current max transfer
sizes the driver can support, and a device's MDTS can be much bigger
than that.

Anyway, yeah, I guess having a controller generic way to export this
sounds like a good idea, but I wonder if the nvme driver is the right
place to do it. The request_queue has all the limits you need to know
about, but these are only exported if a gendisk is attached to it.
Maybe we can create a queue subdirectory to the char dev too. 

