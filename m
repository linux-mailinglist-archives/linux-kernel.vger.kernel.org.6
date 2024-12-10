Return-Path: <linux-kernel+bounces-439490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB99EAFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DF61883336
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CF212D86;
	Tue, 10 Dec 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aae7Xe9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84C210F56
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830317; cv=none; b=p5S+OObWOH5LFQFgS60whVCYah6xwPv+eRvPMLgEFhEGglDRXkllLDVl7izS1JmPF03+vP0VO9Qn/M/zg7WM7J3vxnebplFcio1TXIKiOrCI4OzA8HbxsK5l8+9TpH4hHzF0Ceu5gRZ5Gn/5rJ8swEnom1EHiUVILazVRJMw2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830317; c=relaxed/simple;
	bh=7G3MEYmPbcu7pxhtNlLxoLXwKKYtShwas8EpCDcYV/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pueeuSPDvikRTO8ZyM5Di1BJPGA1a6qv4x4VrLdnlKAkCyCVbNvmQRjFjlCN/7JUtsLPDFcHsZxwmU8IMa4nXJkoZWOZQ06Xj+CjTvIGeDay3qmcdLj+DG/OrfD+Rx+fup6MwUR6hbMrLWmL5XqaWewCbxti/uU6ZzY9FBA/6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aae7Xe9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05128C4CED6;
	Tue, 10 Dec 2024 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733830317;
	bh=7G3MEYmPbcu7pxhtNlLxoLXwKKYtShwas8EpCDcYV/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aae7Xe9X7J6CSJfWULApGStu0RbGgu0ObEfV0nHFXT/sxsaS1H4mYl2TbieO+ri3z
	 gO0kmUKoTDFIWdxQ/CINpFRy3QyOcT/hM7wvsvdLyA/DwTSmNGy/aBlF5RuMsUJwFS
	 TCcr9EbFrVR/rPVR10CLy3uli093tIIMr5yljzlzLVF2cF3dnN2167MoF+AR9JSxl4
	 ugQgDCgBiwDPdobwh1vy2WLysV+4KPNl8Guf4IYT3PQYQ3PuNwFinkn08f+eROczXs
	 kqVWfwx8HJkMDhv8HIG7nIJ/XnqFmCes5rrEfoza7b3G9m/2FdsPptnSllUhv9oK6U
	 WS7x9M/6sdJDA==
Date: Tue, 10 Dec 2024 11:31:52 +0000
From: Will Deacon <will@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, cl@gentwo.org, scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
Message-ID: <20241210113151.GC14735@willie-the-truck>
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118181711.962576-1-yang@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 18, 2024 at 10:16:07AM -0800, Yang Shi wrote:
> 
> When rodata=full kernel linear mapping is mapped by PTE due to arm's
> break-before-make rule.
> 
> This resulted in a couple of problems:
>   - performance degradation
>   - more TLB pressure
>   - memory waste for kernel page table
> 
> There are some workarounds to mitigate the problems, for example, using
> rodata=on, but this compromises the security measurement.
> 
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.

I think you can still get TLB conflict aborts in this case, so this
doesn't work. Hopefully the architecture can strengthen this in the
future to give you what you need.

Will

