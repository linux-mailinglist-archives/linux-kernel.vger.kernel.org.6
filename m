Return-Path: <linux-kernel+bounces-303276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522E960A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30BF1F22503
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D41B5EB3;
	Tue, 27 Aug 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHDMp0Zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07531B3F21;
	Tue, 27 Aug 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761505; cv=none; b=GokXcr9tyu9JedyTuAknNREMPAKCoPdLGuTTEpUUbctdBI+516QWjWLVXtCowLk2scII9HlatHzzYSXkCDKLOWCjHQim4VeeLKKmufB9Br2nGQMMYfaCdy469Sg0prmzbgyv4VTjtcrmiadjEjJWeOrK2/3xIDuGlsiwn62ofF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761505; c=relaxed/simple;
	bh=ibFELH6wnefwxqmKPLY/CFWmccSL2UNN83qpRzxLezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsgnoM4lv+iMS5lkzGsBJEZ7eJJoXYOMiW0QRxsSMB43VLmeQ+emWPaiHEf5v6wyEr9snk2YBBAGNo1UUSEJT5W3WyOf5tOLwkRs3AGBo9XqJ/cdQc1d5W+NjlM5VCKMpObZwF7gxT0ZAOVkumR52ZvzJVnaAmvF3gwI/u2Oo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHDMp0Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A3FC61047;
	Tue, 27 Aug 2024 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761505;
	bh=ibFELH6wnefwxqmKPLY/CFWmccSL2UNN83qpRzxLezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHDMp0Zs/84W3n2xKjaRCFUmn7pMXCcxZmqzHIEEsZFoD4qv2OgB2rdPpNUTUtQ4l
	 FVKgDPnwvNsyTja6FadTfNhI1CRmKezIZ+SVOq++Gmie8+XBsT0hSjxzzWhB9YXGJO
	 YaeRD96UD5py7GYNPYW7xQTkDHH/aGfnQC6+YE1da0dVhOOokhrfrGiWp3EawHUIiN
	 9Lkqluky0xoVcomrjkcQVRGmGkD8qgXOJc1JhWuSmdiOHRC2HpsmvrGwSBSWEjN3bH
	 jFLF4csYk30tvCGcf5oT5ngr+9EuL3zjM/srmSpj7aEEBg6krZEm2cqN0w2d/tz/xF
	 SISPZITH4x2dg==
Date: Tue, 27 Aug 2024 13:24:59 +0100
From: Will Deacon <will@kernel.org>
To: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <20240827122459.GA4679@willie-the-truck>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 26, 2024 at 02:52:02PM +0800, Kuan-Ying Lee wrote:
> Since arm64 supports 5-level page tables, we need to add this
> information to vmcoreinfo to make debug tools know if 5-level
> page table is enabled or not.
> 
> Missing this information will break the debug tool like crash [1].
> 
> [1] https://github.com/crash-utility/crash
> 
> Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
>  arch/arm64/kernel/vmcore_info.c                | 3 +++
>  2 files changed, 9 insertions(+)

In which case, wouldn't you also want to know about pgtable_l4_enabled()?

Will

