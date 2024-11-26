Return-Path: <linux-kernel+bounces-421868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400DC9D9125
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3214286946
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2E49627;
	Tue, 26 Nov 2024 04:56:05 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013D3D6D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732596964; cv=none; b=h9MygMKaUFALzXnLUUVtcyl2uzsEH9F/xyrW2V1a9s+Ycg2U285OevJW6DBNMQrJKIBIZLEJ4gv3IoCmWLGc9fGPsgG3jyMLIpBKVZV0zsAUj96+dNB7TNgGZicdzMH5MwUPdTHhHzP4Vrx3tVnMzWmQYLEa/dbTGPmz1D/g5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732596964; c=relaxed/simple;
	bh=ahTfncGgNaSjejkWk0kmdB2AH0E9a3fmxL9noberQUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDJg8HCRQcJm0xuVw/QyPVUyGyp2QE7OK+vt+SAcvaDdsjifB12v18S6X1fEx66jJFByM659TJf2ZoCjYe5W9Gt/4+x4Ti0kGHCVRo7GpKC7h23jGmcloSKj/f3aj7FOGBBM/4+M4izOY2hjc/W1Cm8syYlxGOj7yHTFKfItWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B3DB68D09; Tue, 26 Nov 2024 05:55:57 +0100 (CET)
Date: Tue, 26 Nov 2024 05:55:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Paul Webb <paul.x.webb@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241126045557.GA31032@lst.de>
References: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com> <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk> <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com> <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Saeed,

can you please also test I sent yesterday?


