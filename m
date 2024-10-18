Return-Path: <linux-kernel+bounces-371330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998C9A39B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC261F28F21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2491E1C0D;
	Fri, 18 Oct 2024 09:15:04 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107A17DE36
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242904; cv=none; b=svDyN7Bq7ce3Jl4DkEjLQvwDbeWnilb4QpUHjxVOlS/9dGG9ndtK3+CrUBpnRO4zjmSR9QvOsUXAj2hNygs6grbZyWCeE8SXXzQJBMV1ImNymLBeNTWId2yXT2OD2OkpKZSQkz4h4tu30vAB7h28D/jQ6znuLa3/77IT9vuugHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242904; c=relaxed/simple;
	bh=SrSm/L4Az9g9fy5V56VomBXbfb6xqEUBbb4W3MNx/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzl/JVMjTg+g0k4zNUi3JuUozr3Wof6q8hiv0golEe2ljRLqFRrW8iYBhTChiePahH69mYeEzgpXYl5fyQFZV1tXJnW6v28WVuggjvs/4WRNhTjSqy3nGLlhsYhmlS693iXlbLiMXhYAA4uGm9p8szotipplzije4ru0Z/TTOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A743D102B37E6;
	Fri, 18 Oct 2024 11:14:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 677E912BC8C; Fri, 18 Oct 2024 11:14:51 +0200 (CEST)
Date: Fri, 18 Oct 2024 11:14:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <ZxInC1U7WiB7FNkJ@wunner.de>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024101809-granola-coat-9a1d@gregkh>

On Fri, Oct 18, 2024 at 07:49:51AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
> > In the process, the workqueue code spins up additional worker threads
> > to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
> > threads are created during device_shutdown(), depending on the
> > timing. On the Pi 5, 253 are created. The max for this workqueue is
> > WQ_DFL_ACTIVE (256).
[...]
> I don't think we can put this type of load on all systems just to handle
> one specific type of "bad" hardware that takes long periods of time to
> shutdown, sorry.

Parallelizing shutdown means shorter reboot times, less downtime,
less cost for CSPs.

Modern servers (e.g. Sierra Forest with 288 cores) should handle
this load easily and may see significant benefits from parallelization.

Perhaps a solution is to cap async shutdown based on the number of cores,
but always use async for certain device classes (e.g. nvme_subsys_class)?

Thanks,

Lukas

