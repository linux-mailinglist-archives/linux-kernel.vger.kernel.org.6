Return-Path: <linux-kernel+bounces-422699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5559D9D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3A1162E67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E311DC198;
	Tue, 26 Nov 2024 18:09:29 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45D11187
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644569; cv=none; b=IESkNSXNc2ZFYpsPcTnN2HeB6XHA6XG5KT/obsVHT6Xh074e7rf3FuJX2GT4jGRaRkoUZxlglncMhFZ69855MnWd9H22l7tL+jyiCtInn9GR0+x+e0+dlWiNuOLdRjLKiMJjn1TMpLHZnuHoejJStEgM1ZdGPgJlAgGjp+ELI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644569; c=relaxed/simple;
	bh=lC29wVITPHMOuhHH9Nx7D96CtWmpeHRsQUFq67BE4vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l47+2pMdUyR8iVkL0YjK1DNhUqP4TEpczfgZEIpl3NjrtK+eQbtvIv6LK87R2dHpXFOIWTk7l/eiFBuOWAtgl/AGTGqMwaquz45HB8gVZsVaC9nFTUlfh35UtnltwDbTCnlcztCh9DAsOQcYynkXQVyiGHR0QmtSUHYr5cW3H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73DFF68BFE; Tue, 26 Nov 2024 19:09:22 +0100 (CET)
Date: Tue, 26 Nov 2024 19:09:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Paul Webb <paul.x.webb@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	Phil Auld <pauld@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nicky Veitch <nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Message-ID: <20241126180922.GA18892@lst.de>
References: <20241121113058.GA394828@pauld.westford.csb> <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk> <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com> <20241122121304.GA25877@lst.de> <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com> <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com> <Z0Dy8H0A3Wj45ZQn@kbusch-mbp.dhcp.thefacebook.com> <CD26086B-67EE-4A62-AABF-3068252B158A@oracle.com> <20241126045557.GA31032@lst.de> <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D00AC7C8-8371-4629-BA39-E0BFB9975195@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 26, 2024 at 06:06:19PM +0000, Saeed Mirzamohammadi wrote:
> I was waiting for the results but yes that recovered the regression as well (snippet below), thanks! I think that’s the best way to go here. Should I make it into a patch and send it for review?

I'll send out the formal patch tomorrow morning, need to do a little
more digging for a good detailed commit log describing what went
wrong here.


