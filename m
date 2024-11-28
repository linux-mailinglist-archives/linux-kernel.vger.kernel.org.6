Return-Path: <linux-kernel+bounces-424998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17E9DBC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CF9B21793
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A21C1F08;
	Thu, 28 Nov 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOnVhtH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32C19EED3;
	Thu, 28 Nov 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732819500; cv=none; b=IannRzVgAd8PLGB7QmfM96Gi8vbE74cUvZj1RblFMOC22U2kgua6kosF8v+116r5qIFNGyXh0dWpQtWujdBYN6bTJoC+eaAQODRZZ3VExgF9dLcIDNGVhFiDhUrjYobKk4Vycud5+Yqm0e4zZs6/XH7wwha7hLCLbvZDxN6KYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732819500; c=relaxed/simple;
	bh=Bw/IZu5ttD+oj2McJaf9wZF0pR8x7qhJTuIezYhp0sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X40e+Xe/0Io4wXc6V1ZQCig5jIqScLuXhM+OQei2fxJov3r03srKtKgmoqZZI2eUrlx0bSb6Lbp59I9dbz5uE5B6Adts53zBSKeQMAI8CPP4OAbfbKdoDh3HLMGTF4ndW52off+3BoMtEWsaK/I+kl1aD/UGqWn/h0v8OxR7mBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOnVhtH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E82CC4CECE;
	Thu, 28 Nov 2024 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732819499;
	bh=Bw/IZu5ttD+oj2McJaf9wZF0pR8x7qhJTuIezYhp0sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOnVhtH0OCXbsmq+Qsgi2v9DwkEFGeH4FCJ1OqdYnkWbVLqxL9rpKVDhqZAfY0+vK
	 sWfgfsfa/gMnl08v+SjFY0jHxuDb5fWAc6m/j2t+Kg7mpx4KOaRAw3Mf5FblVRiCbb
	 Smlgjgu9vHnmZEkGCeO7CDSYpycs1Lv8Ty8oh6bIfIVq4ho9vw8GtsxGkRBuEAL1vT
	 BVy+tw3ecTZw8WIlbG8utQY9BuVCYI6UvptdqDgYS+WCGvbAKaxoojrn9mLSQ5QlcT
	 j/gVY+t9qZ+j/KnZpGdnrqyUPrHjDvWsyqyQVo8w2BN4BuQgwZ1waMC4g0byBubklD
	 2l4pymo2ZvshQ==
Date: Thu, 28 Nov 2024 10:44:57 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, x86@kernel.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/16] objtool: Rewrite annotations
Message-ID: <20241128184457.4lnz3pum7bysjv3h@jpoimboe>
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128093851.469225872@infradead.org>

On Thu, Nov 28, 2024 at 10:38:51AM +0100, Peter Zijlstra wrote:
> Rewrite/unify the objtool instruction based annotations.
> 
> Changes since last time:
> 
>  - removed unreachable annotation
>  - included reachable annotation
>  - various smaller things

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

