Return-Path: <linux-kernel+bounces-332053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB5397B4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7EF1F21F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5A18E058;
	Tue, 17 Sep 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kx5owZAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5E18A956
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605777; cv=none; b=JwzJaEef1xgkERlBav33nmI7Ode36UJE6my8CuQEyxBD14QDczXkkonk5JGG8OBK5G/WgMRHp3omjwTy7ScjbR3vBvi75WHHmUaQrYjXFyHgAvq+GtYSaHjcbGhM63bwXar7T9yGIexEUuLkmdqt35f8+8w8FXrXfOeytIef9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605777; c=relaxed/simple;
	bh=TMRd4Ct+X1vXdb7D+t1i3Sil5lbPkF4ByWGk3IsX2Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvJlwBm2ZyPOAy2nqH1gyuvEnOwa2XlfywX0XyTcDNceGi3iEGh3p6EcARF/DSiPK+1iea3tf8lQRuDqujEWr99A9gulVOYJUb5yNCUNyuftcML+35dzi+pp2GBFJw3cd49ne3w2AOJBD783cgo1cV5bfIgxPdPcREdAcWMzcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kx5owZAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD51C4CEC6;
	Tue, 17 Sep 2024 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726605777;
	bh=TMRd4Ct+X1vXdb7D+t1i3Sil5lbPkF4ByWGk3IsX2Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kx5owZAXMiusFrPRfxPXx6T5eQZ8RKib2xeicQ6b7FPQkdkGTNHvJWWGB3izaU3lN
	 ws5F8nzw/B+vxG+I7TB3qTkN7b2fCd7BNFYiD7ff7+1ZtTAYfg3jCbRv4V15io2jyo
	 rIPNb2BrVhSCGtG+IkvNtVng9yY34jn9YVizzxv8=
Date: Tue, 17 Sep 2024 22:42:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091753-estate-legroom-5d62@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>

On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> Modify device_shutdown() so that supplier devices do not wait for
> consumer devices to be shut down first when the devlink is sync state
> only, since the consumer is not dependent on the supplier in this case.
> 
> Without this change, a circular dependency could hang the system.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

What commit id does this fix?  Should it go to stable?

And what driver is causing this problem, is this a regression or for
something new that just got added to the tree?

thanks,

greg k-h

