Return-Path: <linux-kernel+bounces-557032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC4A5D2AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA0C189CA86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C64225A23;
	Tue, 11 Mar 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uevlgbQS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FF1DED5E;
	Tue, 11 Mar 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733289; cv=none; b=SlQ6XjGN5z1PI27WvUbGe8QCjdu0aA602UzJOBUxBVpupl9yRrbLHaELfW2iuewAVapbovMyAVVuX+7IufVq2vbSfmZv8Hb9UtHrY1vrixjzc5p/zKgkBg/Up/6+x0F7BaF4GSbHLKhHLix46XHfzGDES8Hf5zg8o1aVGhMLIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733289; c=relaxed/simple;
	bh=KONszdF6fxH7KxSwnwfukcwgFVVhCiCZ8EpbrmLPJxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCR6q/FXe7PfF4dvuC+QFc4X2rLW3yPaqSon0c3axagJyfNBYNgLewlrEMQcnfIUlhUW8705Cju4gMgJeOg7SXlngq1OqrIfSD+Ne1YylANY/W0y21Rjpt+DWxquzDosmhafeWkspCQfoV7bUqrR4oHFpe2QLVV60WPp1+wUlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uevlgbQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70967C4CEE9;
	Tue, 11 Mar 2025 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741733288;
	bh=KONszdF6fxH7KxSwnwfukcwgFVVhCiCZ8EpbrmLPJxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uevlgbQS6Ph9XcIY9+OKa49fwIDOeAxNdLYzizimLVsZrFaPt+IM8kmaOPDklrVWE
	 E5txlMTHMfdH1B6wSvb0HvvmBfq12ouUMMRrsondP1loRVd2t2nfItuPAIzyXbJUiv
	 H/2P+KiaQRXAPFqT+tvNIQs/aERgU751mIfIQT9M9pHCEFfWhWXDRisr6ClqEJ+oS1
	 Vy8XKC+7/hwvbWGq1U5TwEFV0tL7lurOeLA0C4Rx9ojdRbpnNB7HXtXTAcs654Ewd+
	 tkEwc98B6In1gd3izCutEArz6ROdQAtceEPWGic2Rq2acVUpJBf+a9WY6wNRqUg7+K
	 TONBvC2tKRtIg==
Date: Tue, 11 Mar 2025 15:48:04 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, apw@canonical.com, conor@kernel.org,
	corbet@lwn.net, dwaipayanray1@gmail.com, geert+renesas@glider.be,
	gitster@pobox.com, horms@kernel.org, joe@perches.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@leemhuis.info, lukas.bulwahn@gmail.com,
	miguel.ojeda.sandonis@gmail.com, niklas.soderlund@corigine.com,
	torvalds@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] scripts: Add git-resolve tool for full SHA-1 resolution
Message-ID: <202503111547.1DDFF8E4E@keescook>
References: <20250311165336.248120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311165336.248120-1-sashal@kernel.org>

On Tue, Mar 11, 2025 at 12:53:36PM -0400, Sasha Levin wrote:
> Introduce git-resolve.sh, a tool that resolves short git commit IDs to their
> full SHA-1 hash. This is particularly useful for navigating references in commit
> messages and verifying Fixes tags.
> 
> When faced with ambiguous commit IDs or imprecise references in messages,
> this tool can help by resolving commit hashes based on not just the ID
> itself but also the commit subject, making it more robust than standard
> git rev-parse.
> 
> This is especially valuable for maintainers who need to verify Fixes tags
> or cross-reference commits. Unlike proposals to add dates to Fixes tags
> (which would break existing tooling), this script provides a way to
> disambiguate commits without changing the established tag format.
> 
> The script includes several features:
> - Resolves short commit IDs to full SHA-1 hashes
> - Uses commit subjects to disambiguate between multiple potential matches
> - Supports wildcard patterns in subjects with ellipsis (...)
> - Provides a force mode to attempt resolution by subject when ID lookup fails
> - Includes comprehensive self-tests
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Nice! Thanks for incorporating the features from akpm's scripts, I think
that'll help a lot when resolving weird stuff. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

