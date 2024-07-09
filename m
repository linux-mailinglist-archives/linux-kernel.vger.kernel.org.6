Return-Path: <linux-kernel+bounces-245213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230F92AFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C061F281945
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB812C52F;
	Tue,  9 Jul 2024 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvkTf79+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2D376EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504985; cv=none; b=sGf3Ns61LXt4lVg8GUnXdwLjLXV1qoUtFeMgyKVEVXv93DzILjApC/eCvQFgXQ+fNKT8gVBhSS+6Cd5Dbky5KNpnmGGxKBNXOzV0z09F/Y+/rcXV3rfrcKI+iiYVxRE4VNSPaSyQWRXteRq5S4qanyZUY80HzleY5aK+axkAaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504985; c=relaxed/simple;
	bh=+1Siwtg2PP4qPcydHrjOjXxACutTM0mVIVCoVyntj2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdPxxuJ2SViYu9ljrBPDrOu1uLW8fVJbB8T/N5DyLpvMCgfD14OV3aOePBH4mRO86awLmLwGPAdqhDOIFgviVT/2fFmONtthtoGKFbOKHNQabgWZd1G8Y4x7kY9m8BU8KIiOYr/uGsaiKy+Pnk9YO6zrQvk8n2BHLNfSI771pJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvkTf79+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tKHQRgFDrLCK5Crj5Wg5zMK8q+bae1u83gb7i2j/810=; b=gvkTf79+lcUFCj8HL20XdPK0+1
	bZrRRH/Ji9hXW8y8EixOJf8T59NxCjk/0/XAUGaHaqDEa1nez1fzcAmMV/qOmbHjMgF8M1K6giwzm
	p16M0EFKN0ajLX2i8bHdT2+129cn/oDz5uYrNjkQhFZ7oveeKkXSjs+cx4nOIj6djjSqDwaDpL9A1
	+bt3t7w5WnbbvhocQcy807PaQk3Y/UM1Ag4Ku7BU54YZH8wHq4IQBRhRWvVnC9Q2u00QBFu+4HjR9
	V2iG3uISkIZNc87aekoQHlf00Zov5GGGcS6VE/DTr6YG1BRMbhQgs+Fe6xTE2dI95/hbZz4SZVlte
	+P+fOFaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR3wK-000000060X9-460K;
	Tue, 09 Jul 2024 06:03:00 +0000
Date: Mon, 8 Jul 2024 23:03:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: George Stark <gnstark@salutedevices.com>
Cc: linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH 1/1] initrd: use O_SYNC flag while opening /dev/ram for
 write
Message-ID: <ZozSlCGyKCkj3uUl@infradead.org>
References: <20240708200923.1824270-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708200923.1824270-1-gnstark@salutedevices.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 08, 2024 at 11:09:23PM +0300, George Stark wrote:
> initrd image is written to the /dev/ram block device using filp_open(),
> kernel_write()

First question: why are you using the legacy initrd and not initramfs?

> . After fput() /dev/ram is mounted and may fail due to not
> all data is actually written to the device yet. The mount error remains
> hidden due to MS_SILENT flag usage and mount_root_generic has retries.
> So use O_SYNC flag to have all data written to /dev/ram before mounting.

O_SYNC is highly inefficient.  If you have a valid reason to care about
a corner case in the hopefully soon to be remvoved legacy initrd code,
the right way to do this is a single fdatasync after the writes have
finished.


