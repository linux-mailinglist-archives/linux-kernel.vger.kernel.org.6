Return-Path: <linux-kernel+bounces-575095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DDA6ED71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF833AD761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D3253F1F;
	Tue, 25 Mar 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkEqnHrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166D1F0E47
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897928; cv=none; b=DxaQTysPnZUyHYeOhB1e0B0TzCo6nCjQvatmlaPopSn42pwmXKr/ELjO/WykE2sOy1owuyEIpuw+bpYhP57FmKFKGISI0wezD3pLoXWkb+/AYk2RwNfGhMVG0b6ewMpQAtThyxhf9OWr3dvtlSyaCEV9lqNUu5KuE551eYF6ZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897928; c=relaxed/simple;
	bh=6o4TyZysflmzaORYu0a+7D4SDpl4+647CEQM1O9vXPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIHNrhB8D5cLFo6kFdZcbgT33fVL4ZO940eT6W7mdQlnpezBQrGwXFbFT7RAsFvCpGlE9dVjXorZriv9Yp9m/VYW09hok812M/Ttm1jBcNjoAR8PclWOPbxgHTbjcA+HpVytFEkE0ANc1uULId+veew24zndX0NGe1/n73rTLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkEqnHrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9EBC4CEE8;
	Tue, 25 Mar 2025 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742897927;
	bh=6o4TyZysflmzaORYu0a+7D4SDpl4+647CEQM1O9vXPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkEqnHrJ1Zx7MoYjWJ2rZxRAGI2lWBdDP4dxryYdxtkY/74FAMD6wEeOrsbzUiX3M
	 os7U9spqKMCzPh1fqAeXo/zmSWghxUfX1AWbYFDLxke/On7xvEPGPZ1tZazEy4zHy1
	 7bvUjXwmxabz/Rd6kwERvYOEt+gCiblSDlEftm1lTRyHEPJsO9KsbJXkTA9Sy86AXY
	 OGXhMFNdCEwFwJq8TH26mOmYC/LM5dobH/o8rBtO+dEA6SWlFpNTmoSuEEAxsddX3z
	 FiusBse1L10cNvH8MOILinyDmvZy1MrFxB4EgvGmBPY1VJGU/TARHkO2mnZ6FUM0k0
	 +9thIZMziE9zg==
Date: Tue, 25 Mar 2025 11:18:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nick Terrell <terrelln@meta.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Ard Biesheuvel <ardb@kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Message-ID: <Z-KDA-yFUuNM6PSx@gmail.com>
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <323A7651-9BD8-4C8B-8784-8C9DAEF5FC88@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <323A7651-9BD8-4C8B-8784-8C9DAEF5FC88@meta.com>


* Nick Terrell <terrelln@meta.com> wrote:

> 
> 
> > On Mar 21, 2025, at 8:16 AM, Michael Kelley <mhklinux@outlook.com> wrote:
> > 
> > > 
> > From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 AM
> >> 
> >> * Michael Kelley <mhklinux@outlook.com> wrote:
> >> 
> >>>> What are your thoughts as maintainers of lib/zstd?
> >>> 
> >>> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
> >>> in gcc 11.4.
> >> 
> >> So the patch below would work this around on GCC9 and GCC10?
> > 
> > I've confirmed that the patch gives a clean compile with gcc 9.4.
> > 
> > Note that I confirmed yesterday that the gcc problem is fixed with
> > 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
> > if I can get the original gcc 11 release and try that to confirm that
> > your patch has the right version cutoff.
> 
> Thanks for the report & proposed fix!
> 
> If you can test gcc-11.0, that would be great, otherwise we could just
> cut off at (__GNUC__ >= 12 || (__GNUC__ == 11 && __GNUC_MINOR__ >= 4))
> 
> I am preparing the zstd-v1.5.7 update, and I will pull a patch that 
> fixes this into my tree. If someone wants to submit a patch I'll pull 
> that, otherwise I can submit one later today.

The proper cutoff would be GCC 11.1, not 11.4, as per the testing of 
Michael Kelley, right?

Thanks,

	Ingo

