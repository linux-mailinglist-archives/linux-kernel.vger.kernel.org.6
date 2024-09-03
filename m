Return-Path: <linux-kernel+bounces-312969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53316969E74
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867571C23BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9021A0BEA;
	Tue,  3 Sep 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQF+W/WV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692301CA6B3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368167; cv=none; b=o/BkT0C4SS30IwtKvrexhRJrE6c2ixd6PJTTWnIj1lDCiPRxIpzEnz4v20myL6C8FSQRuoc464NmJlTFngX3+KQxOGqrSEzfJiA2D6QI7dNTvd/Z8esNNM2lt7/8i8tjMWxiE5wFbb4ymKCtKoyIIeov9ZKC9ka2tbLxTPP8yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368167; c=relaxed/simple;
	bh=rSE0//7WUDjNzarzSUPUHI+6/w6UsFMjAQQNrVRsonw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nICDN87sspc6VjhSTF4antzIz6Iph6Y1tHwTkPSQYHuW7Hksa0ihC4479O3U8v7ni+MkuEDIkJGYtWSHHveDfJXjnfR7JrCLuXseYyW6jG5giDtilXYHUk5VgYsQge10N7HO2gp6LaeiD/yCaFmQzwC6adNc9WlN9CcH2EtxDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQF+W/WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71035C4CEC4;
	Tue,  3 Sep 2024 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725368166;
	bh=rSE0//7WUDjNzarzSUPUHI+6/w6UsFMjAQQNrVRsonw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQF+W/WVFN3jnhojAme/KFv6r4PyuyPQg5xpiWTiGSkkKxy72UoFt6I3bRSXBBKr/
	 mXWZq6wtTkQAPetsQuvf5+shRd41Rg6X2zDq+057sn+I9GwiM0H89NrgTAxT6wOChR
	 xSREXkOQK/6UlqacA9ndI3n0ZioqjWzx/sSVl5+8=
Date: Tue, 3 Sep 2024 14:56:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
	theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com,
	u-kumar1@ti.com, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/2] Add resume support for the mux mmio driver
Message-ID: <2024090346-hug-handyman-13e2@gregkh>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <32351be6-d08c-4b4d-a4a6-a75066689ccb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32351be6-d08c-4b4d-a4a6-a75066689ccb@bootlin.com>

On Tue, Sep 03, 2024 at 02:39:03PM +0200, Thomas Richard wrote:
> On 6/13/24 15:07, Thomas Richard wrote:
> > The patches of this series were originally in the series "Add suspend to
> > ram support for PCIe on J7200" [1].
> > There is no changes compared to the patches in the series [1].
> > 
> > These patches add resume support for the mmio driver.
> > The first patch adds a new function mux_chip_resume() in the mux subsystem.
> > The second patch adds the resume support for the mmio driver using this new
> > function.
> > 
> > [1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v6-0-4656ef6e6d66@bootlin.com/
> 
> Hello maintainers!
> 
> There is no remaining comments to address since a log time for this series.
> Is there any chance to get this series merged ?

I'm not the maintainer, not much I can do here, sorry...


