Return-Path: <linux-kernel+bounces-218132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46490B99F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759C628B7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E67198A2C;
	Mon, 17 Jun 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/gbUHQc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A6198856
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648705; cv=none; b=D43Itc7D+RPybdJzWfXb9W/m7sKmeOpDMzS6CRyQETZojIR/gx+CGYx4XfmPL5XS1H2dGAIrnoMeeu3KVtX6pv7mR1S4SC4tKTD+MJCDZMqHJ6KVsI1tCYgtNdJS3wOAJ4YqosibQluLDVQ8K2aMSoVxBDNnaW5G99MgB6oUQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648705; c=relaxed/simple;
	bh=7/AQgtSakvxJsoFB1zXH5OrpQ4h9ofFWZ5Z7vKtezpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc9lmE99ITwhOMJm8+AUVy7unu7wuwSdP77frqYgsdMHax+fv7lx/dO8nwmAZdawoO7On52I6x6qSbTmR8OFbHYMwLrDgo//cL+wcfZ2k6h7eRfpV+fDcKqB5AUL6rCLNrF7ipMdi2iEo/KfeeyEM5KpyAmox+X2HTlh6sL0+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/gbUHQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743AC3277B;
	Mon, 17 Jun 2024 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648705;
	bh=7/AQgtSakvxJsoFB1zXH5OrpQ4h9ofFWZ5Z7vKtezpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/gbUHQcHic4V4eBg/C8OOdCv+gi//8lkX59yhFAuQOJcBVHqpN8bAD9VPFwUoPPv
	 qSjYd3owVdsiFb2rQPq06nm7W1tCwK9hEDuYfZVqKUjjPlL02QEPvUsSBVF6ergHCp
	 QWrydLRf2S9/N5jdMyBS3BwJxtpe4Hd7xR3td1PBTK0wUha50273OUvWSscF5HJYEg
	 02i1aaaI7V/oMfj0hkbNHEK0ap5uwqe7PAPDAYS5GcnQDvMAxsel7COHe1dbZt2v+C
	 vPniVeNeQRL5nK81zyJbU073bS3NueRShAMMrh6vhgrvdsfTAx7B3nTkmYrAvbxwVl
	 xUh7RxRcqNxeg==
Date: Mon, 17 Jun 2024 12:25:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Boyang Yu <yuboyang@dapustor.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the
 disk as EXT_LBA.
Message-ID: <ZnB_fo-chyiCsvaL@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4@epcas5p1.samsung.com>
 <20240617131144.48955-1-yuboyang@dapustor.com>
 <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>

On Mon, Jun 17, 2024 at 08:00:00PM +0530, Kanchan Joshi wrote:
> On 6/17/2024 6:41 PM, Boyang Yu wrote:
> > The value of NVME_NS_DEAC is 3,
> > which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.
> > 
> > Signed-off-by: Boyang Yu<yuboyang@dapustor.com>
> 
> Maybe this requires fixes tag [*].
> Looks good regardless.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> [*] 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes 
> command")

Yes, added the fixes tag to the change log to help stable-bot. Thanks,
applied to nvme-6.10.

