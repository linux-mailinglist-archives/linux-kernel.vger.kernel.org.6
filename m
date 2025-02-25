Return-Path: <linux-kernel+bounces-530308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC3A431D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA1D3B2C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149385672;
	Tue, 25 Feb 2025 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY1g8LL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A34A29
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443078; cv=none; b=knESNlz858CNnJtDqTMwh+jGlN9ok5AnrBsX6XtIUrYWxry0fPtqKjYZurNHHmASICnMpQVf8n4mNn4PLWBMLNrzP7Wvis8n7eI18Jq6t2ufqRr9zIFoBg1fzeemgziFkaFTp+3io6NvfhAzXhFAs+gtRBYymDCQ+GuSeu2jW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443078; c=relaxed/simple;
	bh=s9AubUqdramGpjA8lgQWKWNWaT1wRkkghen5U5eiCUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqRMx2RJnP8TA1TjHD5tOSI6s4Pq73g5OBpmPR1tQkMao7iZsiac7V4188HJw7jEzPKmDPXYtZfIhq/Bknbb8XaYtPH9bTsHoJZ3s1af+LStbHVeNZieb3WNCi7oTiqgKaQf+whfQbhbluefGcGczBeYIpdnFDV3AsEfKguEt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY1g8LL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C03C4CED6;
	Tue, 25 Feb 2025 00:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740443077;
	bh=s9AubUqdramGpjA8lgQWKWNWaT1wRkkghen5U5eiCUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY1g8LL/GC+LvEPADM+IgOAwSlCZPEvasSikEKi1L3Fp7Pogcy40nzhIMolFkiQzI
	 r9YbAV5QV4z1Q7o57hFrjA5EidwmLuwsYdmrj17XFMDSkZqkyRxBHnj0KKIj/uc4uX
	 PmQRKPXpjTDOY9h2WeRrQ1gm5DUM489nN15QGTF8LXafS/mbdpDgAGZ1d1xPT4kyT7
	 0cQh4eUrIG/tqAnGzwkIDOpusuG1Wm0cNIZLXcjx0BZXlUffu3DZfS+GD2S0w8/f0Q
	 e4Ajk068SlgDMaHLcMBRtOaG96YB4H3cWavAKAn1GVu08J01oFtSA3rmtcubUANjlI
	 m+XTQKGdIhJTQ==
Date: Mon, 24 Feb 2025 17:24:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
Message-ID: <Z70Nw_RQ5C1sHiCV@kbusch-mbp>
References: <20250212170444.16138-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-1-uwu@icenowy.me>

On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> Here is a small patchset that is developed during my investigation of
> a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> SSD), which is because of the SSD's too-small CMB block (512KB only).
> 
> The first patch is a fix of the PCI DMA registration error handling
> codepath, which is just a observation-based patch (because my disk is
> only NVMe 1.2 compliant, and the register cleaned up here is only added
> in NVMe 1.4).
> 
> The second patch really fixes the warning by testing the CMB block
> against the memory hotplugging alignment requirement (which the CMB
> block of my SSD surely cannot satisfy -- the alignment requirement is
> usually 2M with SPAREMEM_VMEMMAP enabled and even larger in other cases).

Applied to nvme-6.14 with the suggested changes in patch 2 folded in.

