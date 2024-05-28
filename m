Return-Path: <linux-kernel+bounces-192921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCFD8D245A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D471F2990B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D569176FA7;
	Tue, 28 May 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/LCwUPy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CA174EE5;
	Tue, 28 May 2024 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923298; cv=none; b=JIP6r1wDhi3hhJGkSxFAacAl0oykmJU1MRzhXtw1CYJ8ouOvPUAPrCKT2KM4nrXTJquQWOrDGj1ujVJNUqxxkuRs3IkitxtjQwh5iUmpc/baTNTYQ+FbR1SQEtNizrQOWeTxZLr1ILPt7Dops9hGjTmDMGTJJTH88nw39kny064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923298; c=relaxed/simple;
	bh=rBmJsC3tlJj0b/3feGRs8G87U9Ytom71szWqyOUqoDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o29S48j+nTcc9ubdVFtbmAvhGpQ18xBgDgYR2cdgttW3ntWG6k3RPh9TuWcwARPKXI2QoOjp9N462riW7pKpTweje9LK7h9sA5VjI37VJNHChQn/Xt6QjjTEhJyM8G09dwVCYd97yykJuGSeIFcnqH7O/HNrlDjAPeGeZB+of5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/LCwUPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018F6C3277B;
	Tue, 28 May 2024 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716923298;
	bh=rBmJsC3tlJj0b/3feGRs8G87U9Ytom71szWqyOUqoDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/LCwUPyL2WBoKc70nb7fKrFT0/9KhAXJFpvafiAa0H+E2GCgZ84xKwLEhWgSqxEv
	 tuTIghJqks6QQdQzVqUVTUXojhPrWDCLPrCh5hoWFI/JuqQLowiGmgLMHOS3P/f8fs
	 IwtclGTfAhh47nUABPE1mTN65wo03yW6E6IB6Jwo=
Date: Tue, 28 May 2024 21:08:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35802: x86/sev: Fix position dependent variable
 references in startup code
Message-ID: <2024052814-bubbly-ramp-2d8e@gregkh>
References: <2024051738-CVE-2024-35802-959d@gregkh>
 <b3a6ea47-8628-4edc-aee5-e5051955124a@suse.com>
 <ZlWbKDZh18KHTsgX@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWbKDZh18KHTsgX@tiehlicka>

On Tue, May 28, 2024 at 10:51:52AM +0200, Michal Hocko wrote:
> On Thu 23-05-24 14:14:57, Nikolay Borisov wrote:
> [...]
> > I'd like to dispute this CVE since it doesn't constitute a security related
> > bug. Sure, it might crash a SEV guest during boot but it doesn't constitute
> > a security issue per-se.
> 
> Let me add analysis by Joerg here:
> : This is not a security issue. The patch works around clangs compiler behavior
> : where it inserts absolute references to kernel addresses. This breaks kernel
> : boot because at the time this code runs the kernel still runs direct-mapped and
> : needs to rely on RIP-relative addressing only.
> : 
> : Any breakage there would be detected at early boot of the kernel by a fatal
> : crash, which can not be exploited. Also, our kernels are not compiled with
> : clang, so from that perspective this is also not an issue for us either.
> 
> So this is a functional fix for clang builds.

Thanks for the review, now rejected.

greg k-h

