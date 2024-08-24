Return-Path: <linux-kernel+bounces-299996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D5295DD61
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAF28387B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B3155A52;
	Sat, 24 Aug 2024 10:29:35 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2D155730
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724495375; cv=none; b=PDiEwtkhBvpNnbshmI5p3Iihq1eLfi6OjtXZzH6hVqBM1a51ZLO9VVRe7EYMZlEkrQfzZnCvfaFFdTlO4SWyork33PL+CFdXMUuzSui3KZDbZvTFoG/vpD36/xs/r0pjBi0S9TwxFrCCcVbwBd/ePRUxnubc1iAV/NgCQQjoiEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724495375; c=relaxed/simple;
	bh=q3YIn+/Mar7vek8JUF3lRp8fHfxEzqdOC0YKHwMpm9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBVpheLzR2pLVE83g+y59htRq8HEZWohkAaUqL1ZkDYnyjn5XQbNcrKMWHYUrNqPx/23os81matmlFrR+NYUtlw8t3COI3WNpgi7oEhII6Cd14mBQdkrvXFE/7HfTJC4zZOJtnNTvNKR75YhkpX2UsM2Tpc05uzQdxg9puPpkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 702FB3000B9FB;
	Sat, 24 Aug 2024 12:29:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 482F25B60A; Sat, 24 Aug 2024 12:29:22 +0200 (CEST)
Date: Sat, 24 Aug 2024 12:29:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <Zsm2Amxu6kBmc48W@wunner.de>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>

On Thu, Aug 22, 2024 at 03:28:04PM -0500, Stuart Hayes wrote:
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
>  	klist_init(&dev->p->klist_children, klist_children_get,
>  		   klist_children_put);
>  	INIT_LIST_HEAD(&dev->p->deferred_probe);
> +	dev->p->shutdown_after = 0;
>  	return 0;
>  }

Nit:  Unnecessary assignment since dev->p is allocated with kzalloc()
immediately above this hunk.

Thanks,

Lukas

