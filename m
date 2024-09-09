Return-Path: <linux-kernel+bounces-321411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C29971A25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385EBB24B68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237641B86E2;
	Mon,  9 Sep 2024 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l0C8vqO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493D1B2529
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886626; cv=none; b=Bj3nftJsYnXICsLRSEP2TwBGXoczcxkKdSEaE5FCv3kCj/L+5yeBMGavfeUxAjI3nrbJiu7SYLT3REhyMqpmzatb3DO6c4L0Hou3qlCXkei6nTsbeED/N2cTYKPPu1QJLCCqpof9Ntr4S4oALnT+p4K4uzgrO+z42WCTm1BOpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886626; c=relaxed/simple;
	bh=Cd0tRbBC8z/SXozT4nfhpxNkfjK4Qb93NiYph6UqVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMHa5E329Lmy4RvwkLjXkOPn7eoGNWfSE8pv1FabGul9tuevol8SjRHRGUzfE2R2zd9DnIuxDtW1JtXoqvzKkU5jojVsLjxyiQBa/zgQcqm0RlKm/OpXPNkmsTQ403PWn0h/bootyO4CAWMgq19Ft/lxMQZSBv+f8LefYSWySXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=l0C8vqO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A14C4CEC5;
	Mon,  9 Sep 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="l0C8vqO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725886623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tjj9pMckNrZn7r06sJTn7WWtsAUED56WaVUDPWPH3ug=;
	b=l0C8vqO6Gwe6lzG9ejUc1Q+n2IZ0YfrmZl4bW5PGpgsbjbZ+3DRhYejrEYCalmaPy9ulJa
	ZNV4wKxQLmaJlCVMnbzvSgi+r9vprfjMuk3GG6yommoBZhSXFK6ZEvJd9ZmeV/nGUJ/Tjb
	uoizrUVuJRC+aRbInvuftlg4oItv+T4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 827428f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 12:57:02 +0000 (UTC)
Date: Mon, 9 Sep 2024 14:57:01 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, adhemerval.zanella@linaro.org,
	xry111@xry111.site
Subject: Re: [PATCH] selftests: vDSO: ensure vgetrandom works in a time
 namespace
Message-ID: <Zt7wndSBTuqGlViB@zx2c4.com>
References: <ZtnnZMa_Yi-UwhHT@zx2c4.com>
 <20240905173220.2243959-1-Jason@zx2c4.com>
 <6c84d516-a3fd-4b9f-a27d-8da8ff117c92@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c84d516-a3fd-4b9f-a27d-8da8ff117c92@csgroup.eu>

On Mon, Sep 09, 2024 at 12:42:01PM +0200, Christophe Leroy wrote:
> > +	assert(unshare(CLONE_NEWUSER) == 0 && unshare(CLONE_NEWTIME) == 0);
> 
> ~# ./vdso_test_getrandom
> TAP version 13
> 1..2
> ok 1 getrandom: PASS
> vdso_test_getrandom: vdso_test_getrandom.c:276: kselftest: Assertion 
> `ret == 0' failed.
> Aborted
> 
> That's too strong. When unshare() returns EINVAL it means the kernel is 
> not built with CONFIG_TIME_NS. In that case the test should be SKIPPED.
> 
> And when unshare() returns EPERM, it means the user is not authorised to 
> use unshare(), that's an expected error that shouldn't lead to an assert 
> either, instead it should gracefully says FAILED I think.

Generally those assertions are for when the test itself or the test
environment is broken, rather than the thing the test is testing for.

The CLONE_NEWUSER can be split into a separate unshare statement,
though, and then the return value can be ignored. The only point of it
is to make it less likely that the CLONE_NEWTIME will fail. I'll fix
that up.

Jason

