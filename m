Return-Path: <linux-kernel+bounces-418205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE799D5EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDAD9B24EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C41DE2D6;
	Fri, 22 Nov 2024 12:13:10 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB471D2F50
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277590; cv=none; b=Rw0jX8xMRl2lV5mAd1GBstS/OVBn3eooD+FHjanrtgE8U5CtumNscxCnss45u3vkYjOclwwvZxa4EXTQSJF4+g8O3i0Y6fz4kjGXM+gs2aEU1jjeXSiwQ2H++5LEaZRvnRe9PnpbijNrZlBMLUT/fygo6v6paYAe31M8UixiDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277590; c=relaxed/simple;
	bh=zcV4mHRQzAP1sa32/HPaseAkiBJ70x8Ya9dPVZ8rCD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndwMLixKur/qjnU3tGkYezpm0G4RuZmH4Vx9rcdfzYu0lZE4IBBVlVqDSLkBiFifK8QXYqdVjOevAuPiSyZZVfnxN3HnfS/CSLmxz6gVmPovg96OBRuuivjXhg0D/ZkcV00IMMrhmAEEwA8cdIU9UKrpgPDb6McJ6ny5Jb1qkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6EB1168D0A; Fri, 22 Nov 2024 13:13:04 +0100 (CET)
Date: Fri, 22 Nov 2024 13:13:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Webb <paul.x.webb@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241122121304.GA25877@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 21, 2024 at 09:07:32PM +0000, Paul Webb wrote:
> Christoph:
> To check for weird lazy init code using write zeroes
>
> Values in the 5.15 kernel baseline prior to the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 0
> 0
> 0
> 0
>
> Values in the 6.11 kernel that contains the commit:
> $ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
> 2199023255040
> 2199023255040
> 2199023255040
> 2199023255040

Thanks!  So 6.11 actually enables write zeroes for your controller.

> Another interesting datapoint is that while performing some runs I am 
> seeing the following output on the console in the 6.11/6.12 kernels that 
> contain the commit:
>
> [  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0

.. which it doesn't handle well.

> [  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR

.. and interesting this is for a Deallocate, which should only happen
with the quirk for certain Intel controllers from the very first days of
nvme.

What controller do you have?  Can you post the output of lspci and
"nvme list"?


