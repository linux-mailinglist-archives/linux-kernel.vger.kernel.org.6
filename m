Return-Path: <linux-kernel+bounces-407062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7878E9C6813
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378FA2832E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2E2157A48;
	Wed, 13 Nov 2024 04:31:59 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DD1388
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472319; cv=none; b=Rj1PGfsUos5DOiD7zH6WdXATFOAMUCb3d+p3Hlii+M4GVMuWDGyd9AOkLYIBW2ZbryDkI4P29xPEx6cMOkZgnCYgp+AaHZrtk0ws2kmXyeboh4O1/+NldZMEzmPb+JH0pV9rGxkDaua/LyXHc6upOG4wg9JT0hKNrxktivFCmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472319; c=relaxed/simple;
	bh=sWoGW/eUfA3J3P+DDvQWkalkbAyF2dObCOC0VXF3HSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGA3rSskU/aThMHRL2Ft0jnjHnu6v1Ddfj66LQFpDGxtQgO3tK1pBlpLoHspDSv5Ytr3bqxSDFyP/oL5uEzKlahS2cz46r+HvBXHvixC48prMSXILRNbrt8+A/6VwZG6MbxuGnclBZJk0+iCukpNxSsA0goOAI3BN7QaIygQFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7421568AFE; Wed, 13 Nov 2024 05:31:51 +0100 (CET)
Date: Wed, 13 Nov 2024 05:31:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bob Beckett <bob.beckett@collabora.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241113043151.GA20077@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112195053.3939762-1-bob.beckett@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> We initially put in a quick fix of limiting the queue depth to 1
> as experimentation showed that it fixed data corruption on 64GB
> steamdecks.
> 
> After further experimentation, it appears that the corruption
> is fixed by aligning the small dma pool segments to 512 bytes.
> Testing via desync image verification shows that it now passes
> thousands of verification loops, where previously
> it never managed above 7.

As suggested before, instead of changing the pool size please just
always use the large pool for this device.


