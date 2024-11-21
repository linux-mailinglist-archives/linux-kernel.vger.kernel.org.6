Return-Path: <linux-kernel+bounces-416572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BE9D4700
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989A71F21A75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFF1547E0;
	Thu, 21 Nov 2024 04:57:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E1849C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732165041; cv=none; b=pfVhipxLpvE0JgimvxcH0657Kysh9RDKKSgIt/aCNL/Gbtj171izZRpbWfM8nVCphtKB+g1YrP1qzbjlczTEFNhYbYBkSlcFbN8b6il1KCUItXSrVipProiQ0w/ZzBxyaI4HiWKkVhEuFHPBmnHzyZhlr0JDeMfvOhIEY47ln8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732165041; c=relaxed/simple;
	bh=6Z2AU7YhC5tmjXwQ88AWETqN0BUdsHTSCxuB7Ig9lkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcxPp5DJAAt30ty8BBTxgDgFwZQleFQh0e631WBJguNKteM9ZmWimaxAY40mYhKf+PWVKZ1QMtlRqmTSdQivgha23N7nGIaTzKcoHyzRitD6mjc3JlVZov0+pjPl3RFa4Osp5drglyhzXOQzl7uVqgjLp+ctBoIC6lWl1CoFzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC6E968BEB; Thu, 21 Nov 2024 05:57:14 +0100 (CET)
Date: Thu, 21 Nov 2024 05:57:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Paul Webb <paul.x.webb@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on
 6.12.y kernel
Message-ID: <20241121045714.GA20680@lst.de>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com> <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 20, 2024 at 06:20:12PM -0700, Jens Axboe wrote:
> There's no way that commit is involved, the test as quoted doesn't even
> touch write zeroes. Hence if there really is a regression here, then
> it's either not easily bisectable, some error was injected while
> bisecting, or the test itself is bimodal.

ext4 actually has some weird lazy init code using write zeroes.  So
if the test actually wasn't a steady state one but only run for a short
time after init, and the mentioned commit dropped the intel hack for
deallocate as write zeroes it might actually make a difference.

To check for that do a :

/sys/block/nvmeXn1/queue/write_zeroes_max_bytes

with and without that commit.
 

