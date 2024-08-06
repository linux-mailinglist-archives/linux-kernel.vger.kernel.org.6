Return-Path: <linux-kernel+bounces-276257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA259949141
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909171F22E62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A801D27A0;
	Tue,  6 Aug 2024 13:25:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308D1D1734;
	Tue,  6 Aug 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950720; cv=none; b=ZlrnLYr51lI7lO4J19sghdhaYII4N93VJ2CzFN69lhBxsrVDttU8+9pmyIDLc7qPI86TDjifnXHls+k1CsXepr2yxqK/b6N6JyQ1wirpqEYvqkImFzmu/NhBSYMtkTsD6E0qkwG6p/0yvlc8+qGcE10P/gAdZ2GgX8mK0RxqqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950720; c=relaxed/simple;
	bh=U5dDV/v2PIx6PWOnrbWyAkbIQP9B98XqOWPeWZdUje8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCPw2zxa7Se8B2pzMmU4ePFiquN+RTrE2Rj6vEIb9j913Hx4d9EEm3Q7ss33fqOsMlG8mxwJpAXCYR671BtOFFc3HmqdtqI6OY/c/h2DyNhtk1aI9XXV4/dHYYXYrLkg+KaASYKcLENt6L1NxvDJocm2FAgjEf6CZNhlXA50IYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 443B368CFE; Tue,  6 Aug 2024 15:25:15 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:25:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 02/15] virito: add APIs for retrieving vq affinity
Message-ID: <20240806132515.GB13883@lst.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de> <20240806-isolcpus-io-queues-v3-2-da0eecfeaf8b@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-isolcpus-io-queues-v3-2-da0eecfeaf8b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

The title should spell virtio I think, and the commit log could explain
a bit more why this is needed.

