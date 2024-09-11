Return-Path: <linux-kernel+bounces-324955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBBB975321
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70119287194
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06163196455;
	Wed, 11 Sep 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k8d+t1/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65437190671
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059691; cv=none; b=Y+OuFCCFYEyO+xz2RxcQeggp6mOiZAng4i/9M19VAX8EV1cPbfg4E0hVtHMN7/Z/lwDb69ug01XREusMcJ1gS4MXAWKipJTWCQKIk/aUxNxWivIlZPiGlBWDr+ApYkLHiMI1xiHA4YCxdgiabUmEQrmFYgh3FVKzGFnci0tc/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059691; c=relaxed/simple;
	bh=BpnNUQcABW/jwFAvAkUZUCIqXwWICIkSNfWFZi7Lvrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gynfzp4ME2LKZrNn5X83hu+rkXFhlNY7h/uxRLdtdl8J0AJrNTQKoPJOqbM9Ife2azLshvRi4LHYpg766cF0kxL+Pan2OLoEQVRnp9PppPVfphrBanomc2XMoiO66ozJxN/xtTxMkn3aiCwfMbNzQ85YgiWvKfHFc0IYmobvbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=k8d+t1/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFEEC4CEC5;
	Wed, 11 Sep 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k8d+t1/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726059688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yEoe1b60GoGqfF1oeAAY0PZrmhE9ZZeMQsLq/rbcSgA=;
	b=k8d+t1/XrqBmzq1iuAxz4EkgcFnS+SrpMeMJ7fX9XD6BgfqqG7doSPovdxZrqNU7LML19X
	UOMT/cZDw38f+BGfz1jplhTjVD8x1/wvnZPPNOkhXB77jcb1+SfgwDw/RrO51KZ7kHtFK5
	HQlZJP0d0Eh/K0zPi4T4Vs43+xpRhh4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 42397af4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 13:01:28 +0000 (UTC)
Date: Wed, 11 Sep 2024 15:01:26 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <ZuGUpjOwE-f4YWUn@zx2c4.com>
References: <20240904155817.1153783-1-Jason@zx2c4.com>
 <fed980be-5082-4454-b696-6245d6a3d265@arm.com>
 <ZuEEIIV-J0mQVKE4@zx2c4.com>
 <974bdaba-6f99-4275-8b4e-f3e95d273ddd@sirena.org.uk>
 <ZuGRRp4j2qvUKxF7@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuGRRp4j2qvUKxF7@zx2c4.com>

On Wed, Sep 11, 2024 at 02:47:02PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 11, 2024 at 11:14:06AM +0100, Mark Brown wrote:
> > On Wed, Sep 11, 2024 at 04:44:48AM +0200, Jason A. Donenfeld wrote:
> > > On Tue, Sep 10, 2024 at 11:52:51PM +0100, Aishwarya TCV wrote:
> > > > make[4]: *** [Makefile:299:
> > > > /tmp/kci/linux/build/kselftest/kvm/aarch64/aarch32_id_regs.o] Error 1
> > > > make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/kvm'
> > 
> > > You sure this bisected right? That directory isn't related to the
> > > commit in question, I don't think...
> > 
> > I eyeballed it for Aishwarya and it looked related on first glance
> > (messing around with the generated headers), though looking again it's
> > only in the vDSO directory so shouldn't be messing up other
> > directories...
> 
> Okay, so... I reproduced the problem on linux-next. Then I reverted the
> commit and reproduced it again. Then just to be sure, I ran:
> 
>     $ git checkout v6.9 tools/testing/selftests/vDSO/
> 
> And then I reproduced the problem again.
> 
> So I think we can be somewhat certain the unrelated directory is indeed
> unrelated.

Ahhh, got it.

Running `$ rm tools/include/asm/sysreg-defs.h` fixes the problem. I'll
look into a fix this afternoon.

Jason

