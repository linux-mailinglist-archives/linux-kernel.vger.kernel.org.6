Return-Path: <linux-kernel+bounces-367537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E699A0383
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5E1B24DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A21D3621;
	Wed, 16 Oct 2024 08:02:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963F1D319C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065772; cv=none; b=JAiAwSScEQ/kLMCzPKId06hJ1Q+bojWMESy1AWii/xPAS3zQDC0vvxfifChKecNpbPy3bMasglbRgWRhOLQtmHuYfiDQAaXQS43QBNN/38/UxpVN2Xc08W6nhjDpgWh5Q2n79bSxUBWnGHTuA00gAQXq/5UM+aRwCD0cS+BOnUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065772; c=relaxed/simple;
	bh=LFnBnUs45XY9hwhutuM9DVjgpgYtMIVDMh3OHNwYp8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmwBUhUg78PwFu69lW9QduAx3uqy++hLWPNfvoANOpW9MedSsIXrV0Qn88xGCy62HSA/j8LNq+xqrgtM2wWlAUMt3h1XkwGJ1ullcUUfnXsA1GPPLfFdOfXts2XhAkfKZ5Sgfd78fcncdpQpPWObarwfzMiqQisBaCrCbCFq85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD063227A87; Wed, 16 Oct 2024 10:02:40 +0200 (CEST)
Date: Wed, 16 Oct 2024 10:02:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>
Cc: hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
Message-ID: <20241016080240.GA30380@lst.de>
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The problem is that the dma alloc/free tracing calls virt_to_phys
on the allocated/free memory.  But that memory can be vmalloced as
in this case.  I think we don't have weirdo allocators or pools any
more that are neither in the direct kernel mapping or vmalloc, so
we might be able to do an

		if (is_vmalloc_addr())
			page_to_phys(vmalloc_to_page()))
		else
			virt_to_page()

here.  Or just switch to tracing the virtual address to always be
on the safe side.


