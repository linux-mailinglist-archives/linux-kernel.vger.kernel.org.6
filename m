Return-Path: <linux-kernel+bounces-524281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31015A3E186
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DEF86171D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F820DD4C;
	Thu, 20 Feb 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEy4ALXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFF2135A3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070075; cv=none; b=FwKpViNdrI5209vAdP3ncdADlnxLdWCScoQrmMdhsZ7wOTxztywcI9s2r+AyEvdGgLInSAfDk8EyaCNOfZuOH8tWjkf29GwD37YCxUXOfMN35Nof+pp7PCnj1uBzNFh5PnqJ0+0Qj2Kv0PgQjZka3OVPAQye2j3pvsrNXyny8TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070075; c=relaxed/simple;
	bh=GPxVw7bQtiLeaIrP4s1aOjzx0JOUy8nLHSb5iM03rnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlVDqPxjrrKjBiC5dVYVCYTULziQslDmyO4f7tvkcq+wiW0uI2arn658DG8QowK23A+u6jxB+RAkZl6eYIdr8XUC7Q75Sn9BI5zLkTTQQnMQUv7yQ9d5n2ekFMKklaonMRFr15tTzEkSdcoDDKAxN28q6NS2s2frkkXeObihSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEy4ALXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E67C4CEDD;
	Thu, 20 Feb 2025 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070075;
	bh=GPxVw7bQtiLeaIrP4s1aOjzx0JOUy8nLHSb5iM03rnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEy4ALXXi5x5DdpYEXT/bOE4Baii5ouVVCl6e+/eZkE/JS3e4/lxwhSm5N5TfKbo1
	 8mZ9dRky7Rb4Q3Y4BKSS44o1R7iPbmeApCnxsZ1VFMMo99CwJdfCMPprTpg45L/La5
	 R2rKOCXYFGxn7rn6fbD6LahlCe7qfQBlEHCqYBK+vUnvUvN+yPKRx4X5tybUUjH1ai
	 cW4RiYbPtNaAZ7AxeF1h7JwnF6geZDjAalpqQyMwIz7U/8kWAJBfu2ENR4xClAdORu
	 adRm7E+26bNhYMRz6qliCz+ByRlKAm1W01sO7LMaoi1m9TMVVYzn+/XGv0kRkt26O+
	 a12DBHz41M7Kg==
Date: Thu, 20 Feb 2025 09:47:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, hch@lst.de,
	bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7dct_AbaSO7uZ2h@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>

On Thu, Feb 20, 2025 at 01:05:04PM +0200, Sagi Grimberg wrote:
> This discussion is not specific to RHEL, if there is a real use-case
> that we are interested in supporting, we can change our minds and keep
> it (and simply remove the log msg), but I haven't heard any real life
> use-cases thus far.

One use case: ublk.

Other use cases are manufacturing and debugging. Linux has been a great
environment for both, which don't want anything hidden behind virtual
devices.

The module parameter makes it possible to do this with your distro's
stock kernel that came with the CONFIG option enabled.

The device mapper multipath needed some layering violations out of the
driver to make failover work correctly/better. That's one reason it's
not supported here, and that's an appropriate place to draw the line on
what kinds of patches should be accepted.

