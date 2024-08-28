Return-Path: <linux-kernel+bounces-305288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8A962C67
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A452835BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42A1A2560;
	Wed, 28 Aug 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J1bYg6wH"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C8178CEC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859075; cv=none; b=VtyQLFGjbouz4PL8ZPlehr8nOPd91HrFrx86LMrQV2lymBlUsw/94vIsOcS4EsvXD/mKwaSkjQE+dlTmUVHfbc1TsrActmjaFHYxDVkGsGKw9c1lewegl5juNH5h8tx+GQVh2Jwb9D6jOmbuSlnkPa9qeye6Skiy4JT05E/cX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859075; c=relaxed/simple;
	bh=JdgHdpTQh92ELHSShZnfeSP8J4agZ/nDdvSkHkRgSgQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R25lWVB2/5Q0XFFbmPD6qmf8pic7HUdnq6NDztefndmOnWSm+zrkq63hxWFZ47u9qv9JSkCX6tT2nndyMd/RT6fBlOHraUyq28tLrx74NTXb1wEVEgVWLjEWH1k81ZNc+pmAruH5+5fM+g8t8ioYxHQNn+9iCm8rSqxLelAARbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J1bYg6wH; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724859074; x=1756395074;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bqc44ABQg6ruaDWPYgMyOlBqJ7wwPaJPKM6xG5VakJw=;
  b=J1bYg6wHFtXi9miQNXaPPXMQ75n/VhDBJN8i1MAX/oFHVnwGO3RQUIuf
   T0zPX4COytMoyHLTTkYBnfnT43NCzo1CiWKTu5rLATJNw1U7RLzoZ7vBR
   UTj0utQK/5OyruDFTXdzfdnAtp/fTJYapMY1e57fqvN4hI/0nP4+C52QV
   8=;
X-IronPort-AV: E=Sophos;i="6.10,183,1719878400"; 
   d="scan'208";a="676735071"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:31:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.150:2525] with esmtp (Farcaster)
 id 4ed1dc69-1286-4d0a-b0b9-c846a8cc70ec; Wed, 28 Aug 2024 15:31:11 +0000 (UTC)
X-Farcaster-Flow-ID: 4ed1dc69-1286-4d0a-b0b9-c846a8cc70ec
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 28 Aug 2024 15:31:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 28 Aug 2024 15:31:10 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Wed, 28 Aug 2024 15:31:10 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id B435F20841; Wed, 28 Aug 2024 15:31:09 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <puranjay@kernel.org>
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
In-Reply-To: <Zs8360kRPGa1B5xy@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
 <Zs8360kRPGa1B5xy@kbusch-mbp>
Date: Wed, 28 Aug 2024 15:31:09 +0000
Message-ID: <mb61p1q28y88y.fsf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keith Busch <kbusch@kernel.org> writes:

> On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
>> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>>  	struct request_queue *q = req->q;
>>  	struct nvme_ns *ns = q->queuedata;
>>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
>> +	bool has_metadata = bdev && meta_buffer && meta_len;
>
> If this is an admin command, then bdev is NULL, so "has_metadata" is
> false.
>
>>  	struct bio *bio = NULL;
>>  	int ret;
>>  
>> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
>> +		return -EINVAL;
>> +
>
> Since has_metadata is false, we continue on to process this admin
> command, but ignore the user's metadata settings. Do we want to return
> error there too?

As an admin command with metadata is an invalid configuration, we can
ignore the metada and go ahead with the admin command or I can add the
following after the above check:

	if (!bdev && (meta_buffer || meta_len))
    	return -EINVAL;

I don't know what is the best approach here.

Thanks,
Puranjay

