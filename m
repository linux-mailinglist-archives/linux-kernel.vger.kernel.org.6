Return-Path: <linux-kernel+bounces-355705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7E19955E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98DB1F21C88
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A720ADC6;
	Tue,  8 Oct 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJS2tuio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781C1DEFF4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409324; cv=none; b=Ogwfz53eVPgs/ebezPX5CHU0Cib18S4CIpuss0OwDYlESIA9JFF7n0mRuurfI4FqdbPcOwA//YcGz5NfeeLlVvXOk4nvwvAvWE06QQO/vO4ZKxNudS+l3gJ5GgFz8/s4lmkLXxao3+0PXyUcygyu14M44PaR/lh4NU2gahdTkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409324; c=relaxed/simple;
	bh=yw2KYIv7qrAH7d7bAAjLMZ6BXTHpbn3+HL3vduIV+x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1eqWA0AcU7+RbMYPQ3FJVFBozcbwoMdJt2S0Z+iJAlyBBTlaqhrsUnje8RJUxM/aXVGjPkgeUaZH/u9F9yQ32pvIjw3T8ZVCDtImCJNd6ByqswYnZA9/6SlYrbzz0mFXWHUvOI5jH4yv7G7Cj8K8UnqWfWb7NoY/OEF1e4kBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJS2tuio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67936C4CEC7;
	Tue,  8 Oct 2024 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728409323;
	bh=yw2KYIv7qrAH7d7bAAjLMZ6BXTHpbn3+HL3vduIV+x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJS2tuiolsQ4N1mhpBSZf5RdutQUoBX8X5HBl3p4M35jRIQfnFK9SvCaaY4dDCkDe
	 jRhc08KnwQp75DRYROWFqfnLmF0daQK7Zgb/LMusz7ElsTizw2wIe/tp5N6Uw3x/1g
	 3SpjSL0TmtQ/yv+8Mqx+1UchzPf9BCg71R2VMlicEBhjfi+yaphP+bQR3bRm6REV46
	 ohS7Pa0kpT9O3U5rjBpLmwJksb6ypEXeQSK//qoDLYa4sYG5aZl6dd+1HmDJbeWGx9
	 YBd9Ksusc4OoPs8ijFwdzPsfD9n8wkMp73ZZf/qtDzyUCBDBMGHJ33Nw5CwgFLeAyS
	 5Ygi8sABo/v7Q==
Date: Tue, 8 Oct 2024 10:42:01 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] objtool: Deal with relative jump tables correctly
Message-ID: <20241008174201.b23zrrvqv26ihq4t@treble>
References: <20241007224747.3973322-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007224747.3973322-2-ardb+git@google.com>

On Tue, Oct 08, 2024 at 12:47:48AM +0200, Ard Biesheuvel wrote:
> -	/*
> -	 * Use of RIP-relative switch jumps is quite rare, and
> -	 * indicates a rare GCC quirk/bug which can leave dead
> -	 * code behind.
> -	 */
> -	if (reloc_type(text_reloc) == R_X86_64_PC32)
> -		file->ignore_unreachables = true;
> -

I'm not sure if this bug still exists on current GCC versions.  If so,
it will start reporting "unreachable instruction" warnings again and
we'll have to figure out a way to resolve that.

Otherwise the patch looks ok.

-- 
Josh

