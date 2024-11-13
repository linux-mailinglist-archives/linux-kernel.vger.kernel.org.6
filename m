Return-Path: <linux-kernel+bounces-408291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F609C7D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB53B24088
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D420651B;
	Wed, 13 Nov 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvo7fXWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E520495A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530313; cv=none; b=Mf+vMwkQF2ssWbSV+rO8MzQ+U3+pzxdEgPxXjwYwUukLLkooZVSh1sQ4gFK1QVh3pqSFQN2iJcFL5mjZlAcnN7t/KkyyTZETzuzJbF/j9wMFpVBASvVO6SpRCaBrkCxlLRizFJJVI2cdacMANLcBgsv+pGpTv0HtCfasS2Tq5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530313; c=relaxed/simple;
	bh=NOZ/AF9zcqMuHZx5DsglCDz5xTEuqyu9Zz69RsOVV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6bXJ1B66/nqRfrPStotAO9B8w4H2KH+laJo2tfU/zFUTOhSqXWAblUQ1jtxfK87QNKt9xvQsAtFn6TcUXiYv/UoH8VSpxX/B1NGNKSBgIsybqThjcWduPmWOm2Tj2IamwmFGRStdItvTqKheCzVEzPMNgnOgQtrg3TlmHU+fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvo7fXWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F0C4CEC3;
	Wed, 13 Nov 2024 20:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731530313;
	bh=NOZ/AF9zcqMuHZx5DsglCDz5xTEuqyu9Zz69RsOVV24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zvo7fXWzeSjjQ3d4QEI3trAAJKBvXfENUqbSaL/L6EnWKTJm6PwIiiWLOMMJ5Xlsr
	 sv/3VU1+d+eeAwng8WOTzt+3Q0eN/PR77BcnRGe28xpaymt0mr0KABFGTNrw1Bphjz
	 tgzZPYTBRRzhrQQPNPkm9f1gy3CGUeiEKsIsIImRWhCtHGUy4qGXFjchsr56C8C/8c
	 CAOkSjzajDtLa2BxmpqdTHEbESR3sVBPI+MW+1EYXC+Egwbza+Ke4yiV5rX8Sj1E8N
	 jinqwT+9jRvZOXVFEtI8/E+368QD2xcjfMFy8AiM34TQtFnRb3rhd3Or+lzBiC7ZH1
	 9BrpdFr1GGocw==
Date: Wed, 13 Nov 2024 12:38:31 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] setlocalversion: work around "git describe"
 performance
Message-ID: <20241113203831.lyhmd7ssimejrxn5@jpoimboe>
References: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112210500.2266762-1-linux@rasmusvillemoes.dk>

On Tue, Nov 12, 2024 at 10:05:00PM +0100, Rasmus Villemoes wrote:
> Contrary to expectations, passing a single candidate tag to "git
> describe" is slower than not passing any --match options.
> 
>   $ time git describe --debug
>   ...
>   traversed 10619 commits
>   ...
>   v6.12-rc5-63-g0fc810ae3ae1
> 
>   real    0m0.169s
> 
>   $ time git describe --match=v6.12-rc5 --debug
>   ...
>   traversed 1310024 commits
>   v6.12-rc5-63-g0fc810ae3ae1
> 
>   real    0m1.281s

Works for me, thanks!

Tested-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

