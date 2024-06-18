Return-Path: <linux-kernel+bounces-219859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52D90D8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F255A1C232A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EF84DA0C;
	Tue, 18 Jun 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQzgJSBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330641C69D;
	Tue, 18 Jun 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727595; cv=none; b=rL/SoG97jxGH6yBntlD/Q8mPCWyrYVo9Gm4xhwKDeZIesoaFk09tB49lgsOIccagAvNPO9Zk3hkfz8JXzDOKYfptbA3pc8ud9zm9wRsEVug9psIhcKVeeOLfcnFTwQzj5pHsFYBczWOPWaybOIoJf49bs3w4bUz8unpR3Vlu5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727595; c=relaxed/simple;
	bh=+I09tVzQ9OtS9eIzACeB4nthPggIMP3+i7udNNOzVvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HEgzKX07qqX8uiQS3h7zCEOFwmQvfy+e1JK9lLq7r4qsDMGG2u8L+9ifde1dZjk3IA9PhYDuQIVNHPwqbRS+utsLzc43apQsU9nXO0PQoUh4brS9TXQfH90FVIEItmkeVZRuv/21/jHhwmX3aCgfbWlUroezFl9Ye1MJmldiY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQzgJSBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A927C4AF1C;
	Tue, 18 Jun 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727594;
	bh=+I09tVzQ9OtS9eIzACeB4nthPggIMP3+i7udNNOzVvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LQzgJSBP7HFiHKA9jkri7zvJ7NUSfYuQQBSgKPuLmObptGzn1arS98vKbeihR775U
	 GHvY/rrf46nqnbW7Q5H/7+Mx9E5qj8hlQr4tOaduAbDwmbMJ86Au5wGhh//4KEaklw
	 nxhZE3I30uqXE+CkTmp3B3jNfcXdL1izhMeP99m81hqG0rJeBW4utT00qWx/s+5eEh
	 pQrr7l25/x7MHNvOuJcGGPDit86H+B4evwMRuPpT1pFyH5f5pbRbx1pbfm5+rzZhv3
	 HR8bVn/gZ3q+2pvNK570jImcDHca2ri4+oU3U2ZtSRd9GholN9FX0lWML3KYovd7y7
	 6qBwy62s+zMQw==
Date: Tue, 18 Jun 2024 11:19:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	gloriouseggroll@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
Message-ID: <20240618161952.GA1258613@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d09ffc-a8e4-4e9f-9032-7c8583ca6abd@leemhuis.info>

On Tue, Jun 18, 2024 at 08:42:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi Bjorn!
> 
> On 08.05.24 17:49, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> >>
> >> I notice a regression report on Bugzilla [1]. Quoting from it:
> >> 
> >>> On Kernel 6.4 rc1 and higher if you put the Steam Deck into suspend then press the power button again it will not wake up. 
> >>>
> >>> I don't have a clue as to -why- this commit breaks wake from suspend on steam deck, but it does. Bisected to:
> >>>
> >>> ```
> >>> 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> >>> commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> >>> Author: Bjorn Helgaas <bhelgaas@google.com>
> >>> Date:   Tue Mar 7 14:32:43 2023 -0600
> >>>
> >>>     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> >>>     
> >>>     pci_enable_pcie_error_reporting() enables the device to send ERR_*
> >>>     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> >>>     native"), the PCI core does this for all devices during enumeration, so the
> >>>     driver doesn't need to do it itself.
> >>> [...]
> >>>
> >>> Reverting that commit by itself on top of 6.5.9 (stable) allows it to wake from suspend properly.
> >>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=218090
> >>
> > I don't think regzbot picked this up [...]
> 
> This is still open and it seems nothing happened for a few weeks now
> (sorry, should have sent a reminder earlier, but such old regressions
> have a lower priority here). Did it fall through the cracks or is this
> some good reason why giving up on this one might be the right thing to do?

Thanks for the reminder.  Will work on it today.

Bjorn

