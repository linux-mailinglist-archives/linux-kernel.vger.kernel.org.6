Return-Path: <linux-kernel+bounces-268299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9C59422F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4C52817D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1DB1917CA;
	Tue, 30 Jul 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsnXh0cI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D34A157466
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378597; cv=none; b=aV2gNnL0uXGx9uLgc+vugywLNfOavLzNjASTw7JjZuzIqKPcn2IONWTfrnHs3mWDhSIwV3t9yHTt19EbJxLWSncqijq8im9/0T4w4OpeR3n9ljuTl6QCwHjnF/C5uTK22MNBRGGrwEDCem+d03k3DeMLNrizOXn4bii+A/MGHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378597; c=relaxed/simple;
	bh=iXwmhYCCcyRDw2DJIPfqL2B2J9LqKdHICiKlj40dCDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QBshbknbzcIktKAxAVFn/jVr0/4OZFk1TOpga4CX3NkoDqPLy1pYvscfwR7OiznGrGlkISqifc1d+re6XQsJxdD3KcHON60Q59+OaWrKYwyiIRhp95yFgmYQ7kJTEECGpQvMJN5g5DsJyVy5SSlV6vxQuza8FIGSE3qylv0VIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsnXh0cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B4C32782;
	Tue, 30 Jul 2024 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722378597;
	bh=iXwmhYCCcyRDw2DJIPfqL2B2J9LqKdHICiKlj40dCDM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VsnXh0cIy6MwRgYVov2Hu44Q4Oy3vb1WSweVdDxDaI97QumUZaMY8yvnIJ4nu3tdK
	 Qcah3xymNH1R6+gerYm9S2QtrUOH9w2EPp3hX0mLAcrTv5LEGF06PE/2BiHqakmqgR
	 oFfBFMVKfzS3GviRUTLV1g7i4AMqQMSgAGsE0gCWdxZwVJT1BJQ4CU6OrJlLpKoTbZ
	 YR95RfkHdzuAGmUh+mbn1vlQ5MkgdYiO0M0uz/m/fPVLkT/gzSGlgR5r/ymXcsHq3Y
	 bQv0u7POqU54AT+PkRoxBl5UNZ55ocumaEAdfM1yzfaMR+zvEkGgVAgyBp/NOH3BAB
	 vNr9zJ9isCXKg==
Date: Tue, 30 Jul 2024 15:29:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Amneesh Singh <a-singh21@ti.com>, mst@redhat.com
cc: sstabellini@kernel.org, boris.ostrovsky@oracle.com, hch@infradead.org, 
    iommu@lists.linux-foundation.org, jasowang@redhat.com, jgross@suse.com, 
    konrad.wilk@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-imx@nxp.com, linux-kernel@vger.kernel.org, peng.fan@nxp.com, 
    virtualization@lists.linux-foundation.org, x86@kernel.org, 
    xen-devel@lists.xenproject.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20240730105910.443753-1-a-singh21@ti.com>
Message-ID: <alpine.DEB.2.22.394.2407301519330.4857@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s> <20240730105910.443753-1-a-singh21@ti.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jul 2024, Amneesh Singh wrote:
> Hi Stefano,
> 
> First off, apologies for bumping this dead thread.
> 
> I came across this patch signed off by you recently
> https://github.com/Xilinx/linux-xlnx/commit/72cb5514953be3aa2ac00c57c9eaa100ecc67176
> 
> and was wondering if a patch replacing xen_domain() with xen_pv_domain() in
> vring_use_dma_api() can be sent upstream? If not, is there a reason why?

Hi Amneesh,

Yes this patch is still required for Xen on ARM and it fixes a real bug.
Unfortunately the upstreaming process stalled so we had to keep the fix
in our Xilinx Linux branch. Here is the link to the start of this
conversation and to the last message:

https://marc.info/?i=20200624091732.23944-1-peng.fan%40nxp.com
https://marc.info/?i=alpine.DEB.2.21.2007151001140.4124%40sstabellini-ThinkPad-T480s


Hi Michael, I see you are CCed to this email. Would you be open to
acking this patch now that a 3rd independent engineer from a different
company (NXP first, then AMD/Xilinx, now TI) has reported this as a bug
fix?



