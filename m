Return-Path: <linux-kernel+bounces-173509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA498C016A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3D1F25ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F9127E3A;
	Wed,  8 May 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9yWQCUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC71A2C05;
	Wed,  8 May 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183392; cv=none; b=saU1g2zaoOVSpKfGCZoq6zYnscG8+zTIsLb1yz462/SBZIPJZKIHlw/yG7w725q0I60ADa8ulf3RNTS2oc05xIHWfeQtyhDBqIMHNHIeBF8fKNu3le1eEVhyxszQgOSzfKj/WJivrj/7htvjZIv/AfG0NGAYaD1hGNv4qWdDFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183392; c=relaxed/simple;
	bh=r5zbc1G8htKO/feOFFIuiqq8DEmaTRKGEMJpyhghid4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JYSUfoMchYCnVK0yBwpJUxwBXhh6syyf0+YibTokREts1SzyMJKXyyQzOO7r0Fq5DQbXRcnbW4MfwGKGQJfuzNdgr64h+iQKscN2uepkgPNebDGW38/4pVdpw1QgOMNqTmo59JngrWu5CfxgajVHNGPEqMtYHDKe9TDKZqJR5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9yWQCUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77EDC113CC;
	Wed,  8 May 2024 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715183392;
	bh=r5zbc1G8htKO/feOFFIuiqq8DEmaTRKGEMJpyhghid4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G9yWQCUuZvJqlikdQWGQ2GpyZ8bG1ZwF0Y4YtacLg/7xIod/D9DlNODVPYmwysjR9
	 z8MDQWpgRekgvcxzOapXNcglceBVwR7z0kKzqFnts1+R09IK7WSeTTf9qqt3xS43OA
	 tfYua92rJmB5MjWmpfT/mFcO3B/cBBjYpxdgfbKMyH6lyyVSseNPyty1euMEoPHVGO
	 2Dp2fFVHWVRL66J9kIhYX2PCeETvdNStWVs6SxWGByZJt5zNuXWfN1VBkyYYEL34jb
	 EKWnd/Yq5oVH1Xqy8gOTFVnaK7UGBbc3Iiezh1jiMYNlO+MOeNwfUiolplHuE0i7aE
	 mDnjPRDuojzbA==
Date: Wed, 8 May 2024 10:49:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240508154950.GA1768252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e784280-02bb-4e0e-a5ae-4e0a40ea4c51@gmail.com>

On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> > 
> > I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> > 
> > ```
> > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Mar 7 14:32:43 2023 -0600
> > 
> >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> >     
> >     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> >     native"), the PCI core does this for all devices during enumeration, so the
> >     driver doesn't need to do it itself.
> >     
> >     Remove the redundant pci_enable_pcie_error_reporting() call from the
> >     driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> >     from the driver .remove() path.
> >     
> >     Note that this only controls ERR_* Messages from the device.  An ERR_*
> >     Message may cause the Root Port to generate an interrupt, depending on the
> >     AER Root Error Command register managed by the AER service driver.
> >     
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> >  drivers/nvme/host/pci.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > ```
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.4.y&id=1ad11eafc63ac16e667853bee4273879226d2d1b
> > 
> > Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regression introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
> #regression title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

I don't think regzbot picked this up, so trying again since this is
still open:

#regzbot introduced: 1ad11eafc63ac1 https://bugzilla.kernel.org/show_bug.cgi?id=218090
#regzbot title: Steam Deck fails to wake from suspend due to pci_enable_pcie_error_reporting() removal

> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> 
> -- 
> An old man doll... just what I always wanted! - Clara

