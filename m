Return-Path: <linux-kernel+bounces-438006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0A9E9B89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DB018868B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AE142E6F;
	Mon,  9 Dec 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1qagcRB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F35954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761505; cv=none; b=mD9iP75fYmMRfVFGoQ0XTabr4Ndm9HuREpx6dyaz9C94J3bSfbjMGsW/SHbjTq/cn/5Uknf7VmHbNKIwOs9yvQsASBHvdEle+kw3i0HdMA5NlnVQVT9zCV3+UdXmmC/1SYYPf8NvQH+P7yDNhRA5Xnq3l+lg9V2zBi/YO06jwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761505; c=relaxed/simple;
	bh=svaWucKKzhxQ0ba1XDoTVZ2h6z/tD5P/2yvXSJtO+mo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cSI30qj7Ocuu+Luh5cyZiZsqEplcSeqMkA06V28aMYrvItXqL11iN9z0uqWlCZGfK5agF24AHRQAE1lHXCjJ6WWmm9f38n/p8AXLezoH/A+aCGAxO0j3SzfYkfT9ESv1iuMm+1sMun0NnUgrt7HRlG2xE01OdqtsMqjnBfK0N/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1qagcRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16064C4CED1;
	Mon,  9 Dec 2024 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733761505;
	bh=svaWucKKzhxQ0ba1XDoTVZ2h6z/tD5P/2yvXSJtO+mo=;
	h=Date:From:To:Subject:In-Reply-To:From;
	b=Q1qagcRBTkoPRBQuidRo0/DuVOxqZMl6J45yH2SdQGyYWp1yeThnDG73fYMkxC/c1
	 wDJgWpIKAG7X54pXfgX2u2vQzGaxV1qAQbpphMqr8aO/8W0lxw3w9WcciZoMo210jW
	 KnTW8q26j4XDX9adfZzfEfp4aI800JEnO3TgpEwMYX9FkK7Q9R+TpRDoi39tLpL8GY
	 GmYce4kSZkQYufXM6hrp4QkJBTuDyDLy65loVcMT0mPRJyNBmLy4Tou8t8sROF6JiS
	 QPjOqAl/Vyj3TyKdTQbVLf6a0qECLOAbwmIGiSYuedTmPcfT6zIafjdyeqDT4+CR+1
	 RBH/dC+ojvRaA==
Date: Mon, 9 Dec 2024 10:25:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firewire: ohci: use generic power management
Message-ID: <20241209162503.GA3198764@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207011316.GA148867@workstation.local>

On Sat, Dec 07, 2024 at 10:13:16AM +0900, Takashi Sakamoto wrote:
> On Mon, Jul 20, 2020 at 08:37:16PM +0530, Vaibhav Gupta wrote:
> > Drivers using legacy PM have to manage PCI states and device's PM states
> > themselves. They also need to take care of configuration registers.
> > 
> > With improved and powerful support of generic PM, PCI Core takes care of
> > above mentioned, device-independent, jobs.
> > 
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_disable_device() and pci_set_power_state() to
> > do required operations. In generic mode, they are no longer needed.
> > 
> > Change function parameter in both .suspend() and .resume() to
> > "struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.
> > 
> > Compile-tested only.
> > 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/firewire/ohci.c | 43 ++++++++++++-----------------------------
> >  1 file changed, 12 insertions(+), 31 deletions(-)
> 
> Although it takes a long time since the patch was posted, I applied it
> now to for-next branch with my handy changes to optimize to v6.13-rc1. 

Great!  Thanks very much for rescuing this patch!  We still have a
couple stragglers, but we may yet be able to retire the legacy PCI
power management.

> I still have a slight concern about the operation specific to powermac
> platforms, however let us fix when receiving any reports from the users.

Please let us know if/when you see any reports, and we'll be happy to
help fix them.

Bjorn

