Return-Path: <linux-kernel+bounces-215050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9157C908DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4476A1F21BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9F2E62C;
	Fri, 14 Jun 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qWUIBNXN"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED8C132
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376655; cv=none; b=t6q2yVNPf0viDWRB7Sj99O8NNirHDzIzYvcVP4A6pqovDrnHKzNV1EDdRSGleEFCXc3Bvy6SPpB76ipNqliWLiDUWBdG2SBnqvLc4840r/3EXBTQPfj0ovP0KS/KiDCt/sfVKvYPxRSVIxxL3XqQkgsfqtwqdYf/EuKQKRoP4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376655; c=relaxed/simple;
	bh=S0Y8/adRaiA65OlT4oLsf0s1kSP3BurOCFXn6UGKD2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ9egFecyBgDBbVww5a9SLZUAEjrr6etErlbIZBePvQ1s+vlUmOkFxxFGn//vWhlxFvCQQI5VvjWNgM8r9Yy15NjtqlwVUW6R/R2qN2h5JWVG3pQlY4ZYW0pteKTnVHwa6bFeHzFgImL0yxzqM93Mx8WFHuCL2Q7zmAuTjVf1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qWUIBNXN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kernel@pankajraghav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718376651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rJRg6kRQ6A4z9omnfII6w6KY3MnnOvY2HVa2sB5fm8=;
	b=qWUIBNXNZmNnKYRNzYO9AxMvN727QJtIaoTXzxgclFw0T3pevOCiQKzgWTk36btftmGf9O
	sdC+12kgPbXgK2MrDM/5QAoD39LotaAddKZ+yh99Nk7NzumTbArUF1JK+2x4ZTW36AUEDd
	V6n/kaBiKw8/27YaRY3COk6h2Axmxq8=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: p.raghav@samsung.com
Date: Fri, 14 Jun 2024 10:50:46 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	willy@infradead.org, linux-kernel@vger.kernel.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/2] improve buffered write performance with fgf order
 hint
Message-ID: <ex4uveapeddkvfwqmzzvyip5g4voij2jopwhypdpu7srswxzj6@wquolvtkeaxt>
References: <20240614105031.57032-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614105031.57032-1-kernel@pankajraghav.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 14, 2024 at 10:50:29AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Filesystems that support large folios can set the fgf order before
> buffered write(see XFS iomap_write_begin()) that can provide as a hint
> to page cache to allocate large folios, if possible.
> 
> The first patch is a minor cleanup.
> The second patch sets fgf order before starting the buffered write.
> 
> I tested the performance on Samsung SSD 990 pro on a system with 64GB
> RAM as follows:
> 
> $ bcachefs format -f /dev/nvme0n1;
> $ mount -t bcachefs /dev/nvme0n1 /mnt
> $ fio --name=bcachefs --filename=/mnt/test  --size=100G \
>     --ioengine=io_uring --iodepth=16 --rw=write --bs=128k
> 
> I measured the BW(MB/s) across three runs on 6.10-rc3:
> Before patches: 2730
> After patches: 3430 (1.25x boost)
> 
> With -o no_data_io mount option:
> Before patches: 2920
> After patches: 4630 (1.5x boost)
> 
> I was not able to test the patches with ktest due to some issue with
> debian(some broken package issue). Maybe Kent can run it in his CI while
> I try to fix ktest locally?

It's in my testing branch, results will be showing up here:
https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

