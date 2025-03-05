Return-Path: <linux-kernel+bounces-547132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55EA5034C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996103A82EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EA24DFF5;
	Wed,  5 Mar 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl73jgPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A223372D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187882; cv=none; b=bodsOQZVp+hJGDx94yiPw8j8YiYpJfwuVVD8VXfLb20BzSgN0YzxrArUDlN6FTidy/kuL05NvT5yoYQ6CLFm/QM9yzp1dPkeBuYEbKM2AVxZSt5xlsTHguSSu6Ewp6Kj3TzytMEndFWeqSzA90y8ZlEr20oxEcwQU+NDrCg8Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187882; c=relaxed/simple;
	bh=4/XUH4d6qHByGlAYL7Gr+YXKagxCHVRhwdzC2f31ZOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmkHunFP7L3FNdlQVAtshw2y/GZojEVu8U3H/5YgyqYrUDK1rKlt6rKnr97bX3RlFkC7mX68Yf1veIL+TkfnFyNAt+XVsBDufInmj0MCm/cwP54ty/6CDuYsGbgtiAVsU63i0Dgqu0Bo/1Z4yX+UlWqBr68/ok1imzKZhqWw/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl73jgPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474FC4CED1;
	Wed,  5 Mar 2025 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741187882;
	bh=4/XUH4d6qHByGlAYL7Gr+YXKagxCHVRhwdzC2f31ZOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl73jgPhaTVbXFF+Cs/OL3fP5WkoaXbJnkKhHT1HzgT8uZk5UPXw4o+Im78AtGGDJ
	 Px7Jc5A4uaG7Zl2iCzQufMeMhuuKYsWAP1d0euB7b/JNV9RqZZuNlh6Am5fnsNlE0H
	 6dvl/rAe2U8UwfTiXqWJTNuX8LF8+vvlw/NFKnSSfDTvbJfdMcq9z68iLxRmGC+L1f
	 P43xWh+eNdUF9nxofS6ZRejz4Y8JFHRjNW2Iy/gsX0PUKjbGjVPPuBKoKlkFXS1t4o
	 eKodc7Y7es0UkWalQR6lijVH75ldm014ztpzev4pBB2IoFeMBSfP9tgV9avVrVeE/i
	 ATHAmOyB72t1A==
Date: Wed, 5 Mar 2025 08:17:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305141554.GA18065@lst.de>

On Wed, Mar 05, 2025 at 03:15:54PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 26, 2025 at 10:55:21AM +0100, Hannes Reinecke wrote:
> > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > report NMIC and CMIC set (I won't name names, if you came across them 
> > you'll know)
> 
> ?????
> 
> NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> WTF are you talking about?

Obviously he's not talking about multiported PCIe. And he's right, the
behavior of a PCIe hot plug is very different and often undesirable when
it's under native multipath.

