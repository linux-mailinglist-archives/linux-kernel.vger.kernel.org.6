Return-Path: <linux-kernel+bounces-267564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F19412DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDBF1C23141
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08119E83E;
	Tue, 30 Jul 2024 13:13:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEBB1993BD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345202; cv=none; b=Qqe94ceZoEOtkSAIFIKyBXb7T4PB8V0iaaFNtkYASkfLZsB120zCPd0UhGV7U5Uk+lzLwp91+LBOc07BzfWAEjMYYYFa8Bu3xMBrwTpr+SatzSkEryhYpQ4LSQKmmAskdIHdVJ+X3uFAOGYn83qExzx2/sYxTnIlRd0vcVvh7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345202; c=relaxed/simple;
	bh=VISTxJp2mQkG0SJltq7xzPM+sRU0rmhMu+cq1srTJyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsYv/b09LQxunvGADZUh5T1BVDQ2nnWtCVs19PuhuA3RX7O3j4feScLysG5q8WnjjHac7cIoSCX8PvxWY+kpfGjQ9Ze7ItBXVk1q60JLiCdxn6SHTtD1vq0mfwyQhh47nVAtW43aj5XkM7GJJS0cDgRJqUz581OdvornaYBRHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D45E1007;
	Tue, 30 Jul 2024 06:13:46 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEBD23F5A1;
	Tue, 30 Jul 2024 06:13:19 -0700 (PDT)
Message-ID: <a86ca03d-13ab-4304-879d-ac4cbacabfa5@arm.com>
Date: Tue, 30 Jul 2024 14:13:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: remove the dma_set_{max_seg_size,seg_boundary,min_align_mask}
 return value
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240723000604.241443-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240723000604.241443-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2024 1:05 am, Christoph Hellwig wrote:
> Hi all,
> 
> the above three functions can only return errors if the bus code failed
> to allocate the dma_parms structure, which is a grave error that won't
> get us far.  Thus remove the pointless return values, that so far have
> fortunately been mostly ignored, but which the cleanup brigade now wants
> to check for for no good reason.
> 
> I'd love to get this in after -rc1 so that we can catch any of those
> cleanups that might be queued up for this merge window.

Indeed, I think this is long overdue ever since the responsibility for 
dma_parms was moved from these callers into bus code. For the series,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

