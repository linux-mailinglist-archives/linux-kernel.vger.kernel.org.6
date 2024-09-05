Return-Path: <linux-kernel+bounces-317821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8498A96E420
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417F528835A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17B19EEA0;
	Thu,  5 Sep 2024 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jlPilkk8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8B17741;
	Thu,  5 Sep 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568370; cv=none; b=jcVkMETDbtL4xNTe0S9S3CVGTuNZmH9PCj30VF2TNfsVfadA76d7vQ7rpCiXBJDKUQ+7oM9umto+ZJBEpJmubmtWTyKK12Bs5yqYnBV8pcVjCzDUpEakMAsVhW4LTLdQ3RRzy+2TsELrhKvP48G7NICuyfyFXFYxx92t1Wrz1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568370; c=relaxed/simple;
	bh=SxFjYVkiumLY1N1oUnrdP0QrXBGiREuwKSNReawCjVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0/47M3IiRM5Pz4IBNsGE7IdRmG4uCCVJjKjulCqHyMlNsR2UYWa0ITM8/Jb9dOCuEbBANwlOvtuuA9A17HtnuZLyywJ2Qa3m634hDp26NvTYR+2iLa4p6Pj0ncDpRvH0KyyJWcHZh7VxeTGxmb3ZdYT2ZrVszCtCrKo1B7yPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jlPilkk8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2074542B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725568368; bh=F77LXWSP3jf5dTKjOCvd2CxWgDPIhzPhhUGbaIEFyYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jlPilkk8EhaItXbW6Sv/laQ8gGaFv98icdG0ZxTKxQsk6Y6NJSrN6gdZ+zjQHDKHP
	 3n87nY8i6eXnEpxcwoftwcLuotA/0mJGPs2RWtMXwfH9OfrbmdFpBHIckSKlWuIYrr
	 Ozme2RJRs6TG3u0caye40uhYwxZq0bw8HEncE+dWiotRzztv6TW77VK7Cm3rFHOPQu
	 7OuLnHBQF9Np/MuYsKfvXCEC+IgU4hY/TrvaxlniIzyuFcQwnPFxbMLUK49aXdF9QB
	 4k7ujegCeNNO1YVzrspva77AdEhxNjQV9hxk9b9wsgcFY9JDZZEkr/w9Cf0Lfq+2SH
	 VDfPxZNsveYvw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2074542B25;
	Thu,  5 Sep 2024 20:32:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Muxel <sebastian@muxel.dev>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Muxel
 <sebastian@muxel.dev>
Subject: Re: [PATCH] scripts: sphinx-pre-install: remove unnecessary double
 check for $cur_version
In-Reply-To: <20240827133224.160776-1-sebastian@muxel.dev>
References: <20240827133224.160776-1-sebastian@muxel.dev>
Date: Thu, 05 Sep 2024 14:32:47 -0600
Message-ID: <8734mdhmds.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Muxel <sebastian@muxel.dev> writes:

> $cur_version is currently being tested twice with the first test
> resulting in an unhelpful "$sphinx returned an error", not continuing to
> the more helpful "$sphinx didn't return its version".
>
> This patch removes the first test to return the more useful message.
>
> Fixes: a8b380c379ef ("scripts: sphinx-pre-install: only ask to activate valid venvs")
> Signed-off-by: Sebastian Muxel <sebastian@muxel.dev>
> ---
>  scripts/sphinx-pre-install | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index c1121f098542..ad9945ccb0cf 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -300,8 +300,6 @@ sub check_sphinx()
>  	}
>  
>  	$cur_version = get_sphinx_version($sphinx);
> -	die ("$sphinx returned an error") if (!$cur_version);
> -
>  	die "$sphinx didn't return its version" if (!$cur_version);

Applied, thanks.

jon

