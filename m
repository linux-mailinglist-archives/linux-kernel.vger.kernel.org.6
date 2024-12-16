Return-Path: <linux-kernel+bounces-447621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2B9F3508
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3661D1626B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A21531F9;
	Mon, 16 Dec 2024 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOHt2ZBm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3714B96E;
	Mon, 16 Dec 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364450; cv=none; b=JlIa3LiNrJNh76FdAOWX1xIJtAIG9p80nlrLRGNWatYDTTrIWxhVz76ZzHm3O5sIFml7VENBeSGRrr0dUvfook/v8SYlbx5HrBawcSAsP1MWj5xjZZdA9uxcrZpbfz/BXvtn1AeFfSBOK4kQoavTPGrId9hcnNUQ67jBaGFF/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364450; c=relaxed/simple;
	bh=pHRkmI7CTYFFLG3QWXUWmvFS4hdcEJUz1YVt3Tqj64Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkq0nsvk+aysz52omENP3ZgYkQRKAiuSUNFhPYvzL5SpnH0GvwJ8W5lnRaQ5AJ+ruk+sTL8QXtJFvKV5w7F6BywAGsMoZJcfOlYxvx6uUr7OyoiNeymjuwH8XTc9wVsZIrUinhcZYUXiBf5/NvcjJiHdrABobsPk0ZKQXIjd1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EOHt2ZBm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pHRkmI7CTYFFLG3QWXUWmvFS4hdcEJUz1YVt3Tqj64Y=; b=EOHt2ZBmStuQDmLEN2BD+P35nN
	Mpc4H+hkNjK5ZWJAZ6cF1jT2p59TqrWI5+S7m3r7ZT6uiVQ9QVOkerYvjYZiADCoMMdV+ANUIAwA6
	trZPy1kVpnn978AVOkFzPoJhmgeEiAMRmoESv9RX4+dYQnWenHyN5arhcMHy4PL0gVhAAFx46iRAH
	Z2c7f9nOcd8oo3zxfOM2bfT27Fe1O7BEPXv35Rr4IfeqEndJe7lFT/nrKn29Dls1T1a+FJpGYaQ4B
	Fjmgcu6ubf8g0HEI5fkdAwBb2pLDqbmTNBpb9YrE7j0KRZ2W3a/kSMwSTjAO3NCbE4l168GbVqr8b
	oMBnW/Tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDQ5-0000000ATwd-3Wec;
	Mon, 16 Dec 2024 15:54:05 +0000
Date: Mon, 16 Dec 2024 07:54:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ferry Meng <mengferry@linux.alibaba.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support
 for virtio-blk
Message-ID: <Z2BNHWFWgLjEMiAn@infradead.org>
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203121424.19887-1-mengferry@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hacking passthrough into virtio_blk seems like not very good layering.
If you have a use case where you want to use the core kernel virtio code
but not the protocol drivers we'll probably need a virtqueue passthrough
option of some kind.


