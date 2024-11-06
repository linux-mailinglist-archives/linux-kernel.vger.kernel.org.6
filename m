Return-Path: <linux-kernel+bounces-397364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC59BDB0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C706A1C22DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D355185B56;
	Wed,  6 Nov 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtj59SKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E1F9F8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855760; cv=none; b=V/6RxElhhR1qAhP5x2VWPGDDLyAZAPgXW/dQwVp2S6P0TcT2+1V7FzJ+fQpgIzXeChG8a4fSdAq2Vn0DWP2U1L2H/SccrLfbe1T0yU9kJztgPgT2A5f4eVEVvoLZrorAX3Y78QOODyCGJZ/gs6TB2Q9iyNW2xyyERDdSWwStKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855760; c=relaxed/simple;
	bh=MZWoBwlZiAXJTFKh7msEn61e6iXLL3MnWnqnIEtQiSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgSXzvSltR1AuF8RHBLjoK/7/PcP1pN6H166jZrbfd3rPHS02DbEUmlKUBRG70Hvf/EtiuggJOvNNbx7529LO3+vpnIitAMA1KUrzNzNgyM3D3YXymoFBySbE7xIG2zp4E2otE4I34YL9lxpzOFAA9voa94CdgG6/tbNzbDxBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtj59SKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F2EC4CECF;
	Wed,  6 Nov 2024 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730855760;
	bh=MZWoBwlZiAXJTFKh7msEn61e6iXLL3MnWnqnIEtQiSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xtj59SKZ6x4maD2ljnHvu9pcYZmXHRQ5YB1K2CDad7ZlkiiBNnHUsOG8FIQByPiAv
	 thWMSVGo80xsD3iRMUBIewm41vzwINfpacqhBpODMQ9xJg173UW8zLx6ie6CZ4ppXH
	 y5Yt8BRDOwwKag71hR1NZeqV8o1vXj+gSfOBBf3WhouuRWK3SHdKZJqSv550cZ3PyN
	 dAlq9Cw8tNSGM+RQcErKQVipX6SlELSpxuuM/RZysYdA1GBVB3qZ/ab4wPuhddltLD
	 Dr4nbLgH5M01zzC8spwd5Va2bJDbH9j3EYyxEQnQ6HqHWE/KNIaBMRkkdF829TZ/NL
	 uL+iTRNdeJDBw==
Date: Tue, 5 Nov 2024 15:15:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <ZyrDTzVSQtNBcZ-x@slm.duckdns.org>
References: <20241031073401.13034-1-arighi@nvidia.com>
 <Zyqq9fnsOg56aO7S@slm.duckdns.org>
 <Zyq4VFpbaKXERdDh@gpd3>
 <Zyq5cX9fLE-3wZSx@slm.duckdns.org>
 <ZyrBcDvFVtSFPhvG@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyrBcDvFVtSFPhvG@gpd3>

Hello, Andrea.

On Wed, Nov 06, 2024 at 02:08:00AM +0100, Andrea Righi wrote:
...
> I think this is only possible in a virtualized environment, in this case
> LLC should be disabled and NUMA enabled. Maybe it's worth checking also
> for the case where LLC > NUMA...

I think the current code is okay. It just needs a short comment explaining
why it's so. A cleaner alternative may be walking the llc sd's and verify
whether any two llcs share the same node sd as an ancestor.

Thanks.

-- 
tejun

