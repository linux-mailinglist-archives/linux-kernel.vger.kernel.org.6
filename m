Return-Path: <linux-kernel+bounces-231429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7D91989F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3931F21930
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D61922FE;
	Wed, 26 Jun 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e02XvyJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E01922D6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431891; cv=none; b=ISyQpVjVErhvLS06Y99szI7OS4DsUzrx/Uxq8roHhiOCMoH/ufk+ekjFG4xHb0tmYbkS+hDOVCLQqM0LkcrMR75acJ+cmQEXwGsNKT1VUYLcI6QW/NyYPEH6ytKR/fBgZWl2Ra9Inzh31UPl/7LgeQe270mbdpjcm7/gQxU3Erk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431891; c=relaxed/simple;
	bh=uA79vWCUyRgJech9KT2AJEAWRSx6HJIuO/RUTPWht9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzlsQUX9ynLptwpsD9JEibD8VH6l5RShU3n39dYcSiquJukZ/JG7Z739ggi0g/gumPBU82KU/L4D91tep9oWHrAT5dNwJWMvmwWl/Z408tgsT0WC9yHV6zaVkWSp3TCyl90XusOQZXpesOQ2EhPNp60jBb0eCkSyHZaE8Zq0fSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e02XvyJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E954BC116B1;
	Wed, 26 Jun 2024 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719431891;
	bh=uA79vWCUyRgJech9KT2AJEAWRSx6HJIuO/RUTPWht9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e02XvyJequFk3LPbd7xtl6Nlx2Eg/Tc2KkpkeqOcB/DM9yrbmkcAJnI7/Q7xC4Egb
	 Fq2MWjqeO7fgFtk/sWmaxYg8y6OQw5G51ZYYB38bke98sfPPenQa9ni58z5jwYIllw
	 SPb+idVTNBv4VVqx+YtmMUUlE2xphx2xIEbFzReMkqVGSrBvzXySMO/c8SysD2KItm
	 rZAp5gbb2pOa4Ej27fTmJwmK/csDrdYeGFvROTlZzl1vDK61OttYyg8YgWaWS9H0hW
	 AGbLd47cq3KxR899pu1cEqDlCj+up2ChEqti/g4EMSP+h6neVfW00Vk7zJbhUgd54n
	 iAYCSva84eEdg==
Date: Wed, 26 Jun 2024 13:58:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 0/4] shut down devices asynchronously
Message-ID: <ZnxyzyPIHlgH8eyQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>

On Wed, Jun 26, 2024 at 02:46:46PM -0500, Stuart Hayes wrote:
> This adds the ability for the kernel to shutdown devices asynchronously.
> 
> Only devices with drivers that enable it are shut down asynchronously,
> and this driver setting can be changed in sysfs.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

Looks good to me. For the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks!

