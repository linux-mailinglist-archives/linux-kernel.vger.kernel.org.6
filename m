Return-Path: <linux-kernel+bounces-400862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382429C1360
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125A71C21D95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD27464;
	Fri,  8 Nov 2024 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evBSVb7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB21C36
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027539; cv=none; b=X1qhgqoTftEqr7IlwvjdR5o/Qv5sCJsfBDsqO3AY6a8xo6WEL0tFbMtnXYsazmRpiBMcn2NKXnclxxP+V3Wj2E4iGevEZy11trgkV4apxsPiVKl/BdU3Y3ucc2iaOj1KpDbXYEw+xrj5Q65EEAVYfo3n3REDahTG7ES66iK6PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027539; c=relaxed/simple;
	bh=sAOPRgtSvUtPf0Vd9bBaKPLSEYUCIvcRu9bVqU1rQsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2Rw7duycDnHThBu1CyTacURcJaxlhAObUWMg3znC2jGCZuKsC+1nrHtj2sKciF2x+e8mThRGXOUQXoBxzSJN9GymDB2MvUY3iZ0yu5bbEBUs1VWJOtOUj2l2VMum5ay+VGYmkEYV9KNtu/lLkp4kBTTT+WhD/GgopTvzQCQN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evBSVb7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD5AC4CECC;
	Fri,  8 Nov 2024 00:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731027538;
	bh=sAOPRgtSvUtPf0Vd9bBaKPLSEYUCIvcRu9bVqU1rQsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evBSVb7T+hSXvZRjaFb8yIY8viNU2ngTAILeUVY4zSLm1nZ0FcFUTFkap9yeue2Qz
	 agEgVIVmk5tVev2vkUXm0cVGfz5mk4senGJrumF4S2nj3Iow+8v3l0h+wl6ZTydbqR
	 t2cX/9bD/amopMg461kmiRStJa7LwYl9MydKMa3jHfyCO3oRfWFlDJAmI+VxrL2XnQ
	 LzfB9vl4S9uwPkfee2f+nAj7k4O3ll5l08spiyT92UWgT5HaveSu3ZNFpbcHEvHTsV
	 Qc0o7CWtCwcbkXd9iKQlIpzV2fgFfL9SOdPMtP6pZ1e7mP9kYcSM9QaFtHEwiL/KH3
	 LnpM0DUGXZtgA==
Date: Thu, 7 Nov 2024 14:58:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy1iUXxJE1qQLIsz@slm.duckdns.org>
References: <20241108000136.184909-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108000136.184909-1-arighi@nvidia.com>

On Fri, Nov 08, 2024 at 01:01:36AM +0100, Andrea Righi wrote:
> When the LLC and NUMA domains fully overlap, enabling both optimizations
> in the built-in idle CPU selection policy is redundant, as it leads to
> searching for an idle CPU within the same domain twice.
> 
> Likewise, if all online CPUs are within a single LLC domain, LLC
> optimization is unnecessary.
> 
> Therefore, detect overlapping domains and enable topology optimizations
> only when necessary.
> 
> Moreover, rely on the online CPUs for this detection logic, instead of
> using the possible CPUs.
> 
> Fixes: 860a45219bce ("sched_ext: Introduce NUMA awareness to the default idle selection policy")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

