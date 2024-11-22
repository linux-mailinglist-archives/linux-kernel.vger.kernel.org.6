Return-Path: <linux-kernel+bounces-418714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A89D64A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733FD282324
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08651DF26F;
	Fri, 22 Nov 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+daD2Hi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CE158DA3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304215; cv=none; b=WLOPcNbydMu65N/W/ZFfSEx5CeH0OAyqOlCdogfqTJOJ/CFUdEMCjQGlLzLpyDd4ckYDT3aPmAbSv9D7Y9FV0BUr5C0v4NNkhtfqyqNVesR/xgVZWy9In8rH2vDjkjWfCWDCRoGJcK2zwu+Nvs2ijYfTH19zWJsKqWrfunG2ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304215; c=relaxed/simple;
	bh=HEd5aBJ3V34Onf664GRVCd2iBvwbTpBtXpJbEPHxGho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzfXPe9ayeEfGEW6MMeK1vyXfpb520g+CMsQ6MmdCuke4qErSbeJ1WrOUBIBxlyAy+CbO+QcfAYVgBGPd+ednF1mYl4Ru2KYBitXmH/SYWKldxtbe4il4hvAF98fn1auDYuPPvjSWhX7aqK5TyUrk8iTUV0LDCQyZ+zcGMMIr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+daD2Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3883AC4CECE;
	Fri, 22 Nov 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732304214;
	bh=HEd5aBJ3V34Onf664GRVCd2iBvwbTpBtXpJbEPHxGho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+daD2HiAAZBrqAPWUK5vzZn/dwyWipto4WAyaAHb7vLkTjZALX6TcdkZllkg9/v/
	 XPYQ6q5CJV7JzSUVbE9DIFagxXYn3tOT7+l89vKH/gVMNqsEqe1zBa7u0k8P6ML9yw
	 ell+/GhlNHaffIgctGUdV2ECTh2qchW3kalTQtDYHWjbWQBGSTFHqoOuDvsK89EqY8
	 tE+74ufe4nDWb1yi/I532Hb4as8ISsP3hKDE12Cft3PRar3yZRfJRjejBD1TmTYZDn
	 HQ8Xx08Dax7fGvu4OPOmVcLZ7kP3Ca6DSY+MO1fjyHCnWRCWngVk4aQQzNPD1q20XH
	 nL2usENwwAaDA==
Date: Fri, 22 Nov 2024 12:36:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: =?iso-8859-1?Q?=22Pawel_Anikiel=22?= <panikiel@google.com>,
	axboe <axboe@kernel.dk>, hch <hch@lst.de>,
	kernel <kernel@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	sagi <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <Z0DdU9K9QMFxBIL8@kbusch-mbp.dhcp.thefacebook.com>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
 <1932ad8722a.102613bdb3737.769617317074446742@collabora.com>
 <CAM5zL5rKsEd1EhOx1AGj9Au7-FQnJ5fUX2hLPEDQvmcrJXFFBg@mail.gmail.com>
 <1932b818328.ad02576784895.6204301822664878956@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1932b818328.ad02576784895.6204301822664878956@collabora.com>

On Thu, Nov 14, 2024 at 04:28:48PM +0000, Robert Beckett wrote:
>  ---- On Thu, 14 Nov 2024 14:13:52 +0000  Paweł Anikiel  wrote --- 
>  > On Thu, Nov 14, 2024 at 2:24 PM Robert Beckett
>  > bob.beckett@collabora.com> wrote:
>  > > This is interesting.
>  > > I had the same idea previously. I initially just changed the hard coded 256 / 8 to use 31 instead, which should have ensured the last entry of each segment never gets used.
>  > > When I tested that, it not longer failed, which was a good sign. So then I modified it to only do that on the last 256 byte segment of a page, but then is started failing again.
>  > 
>  > Could you elaborate the "only do that on the last 256 byte segment of
>  > a page" part? How did you check which chunk of the page would be
>  > allocated before choosing the dma pool?
>  > 
>  > > I never saw any bus error during my testing, just wrong data
>  > > read, which then fails image verification. I was expecting iommu
>  > > error logs if it was trying to access a chain in to nowhere if it
>  > > always interpreted last entry in page as a link. I never saw any
>  > > iommu errors.
>  > 
>  > Maybe I misspoke, the "bus error" part was just my speculation, I
>  > didn't look at the IOMMU logs or anything like that.
>  > 
>  > > I'd be glad to if you could share your testing method.
>  > 
>  > I dumped all the nvme transfers before the crash happened (using
>  > tracefs), and I saw a read of size 264 = 8 + 256, which led me to the
>  > chaining theory. To test this claim, I wrote a simple pci device
>  > driver which creates one IO queue and submits a read command where the
>  > PRP list is set up in a way that tests if the controller treats it as
>  > a chained list or not. I ran it, and it indeed treated the last PRP
>  > entry as a chained pointer.
> hmm, I guess a simple debugfs trigger file could be used to construct
> specially formulated requests. Would work as a debug tool.
>
> Though at this point, the simple dmapool alignment param usage fixes
> both of these scenarios, so it will be kind of academic to continue
> putting effort in to understand this. I am trying to get answers out
> of the vendor to confirm any of these theories, which I hope will be
> more conclusive than our combined inference from testing.

Any updates on this? I'm satisfied with the quirk patch, so we can move
this forward if you're okay with the current understanding.

