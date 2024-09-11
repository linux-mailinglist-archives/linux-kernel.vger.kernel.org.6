Return-Path: <linux-kernel+bounces-325174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335899755EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D82B2B6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479B1A3A8E;
	Wed, 11 Sep 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RWkL5dP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D261714AC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065648; cv=none; b=nUTCzwlt5MvA6h5Sw9TfpgEGXRtfqiuXHk2eBM618M6p431lb9NMHVuhvipZtUpLlhxqcxHbXr0l4/SbPODfHtXImyPjRwjiiSUVLBc4bKwaM/MlbMqcuiVD+S14ztCpYqVGGhAFFEpuMWcVk0ZeCLFYctfNuudvcMqbKERTD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065648; c=relaxed/simple;
	bh=Axiqh1nzBbK2Ig2WsrozBE8yrdfCB6PUjqJ9fD9Db2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCuvUmUCns7BGZ+oFlMmnX/S9+P3WBGZcUk1exdExqmybreaZ9DgwY/XWjeYbiRHRR0mm6t2wy9A1OD8uDMa6h09vbqqpE7tQTJGC9H0rbCbe+45AjQ3YutlF9boTOtdZp/ubr4LV/pJBoq8l9dkIFTpk3rZaySXRYIQ+I3dO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RWkL5dP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ED8C4CEC0;
	Wed, 11 Sep 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RWkL5dP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726065645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9TJV7uvW8wxglOna89ziSDrdWLDv/dSzaNs29gG5bGs=;
	b=RWkL5dP7s9ajBanZXSch1EXo4YCbeShCM/6dMiiTbOHPz+lbgTM1o7grU3tRKUMdsA/er1
	2t6plwhsru5M+BFMBTnWJGkYkocRAgBKW2SjfOENJ5hPtCW6WTIOPLM9WPSaZMElRsYEbR
	SjG++7t4630c9BEWiM4fesoQJ6+UQ1Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c02ef0b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Sep 2024 14:40:43 +0000 (UTC)
Date: Wed, 11 Sep 2024 16:40:41 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, adhemerval.zanella@linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] selftests: vDSO: don't include generated headers for
 chacha test
Message-ID: <ZuGr6S_At40u4WVY@zx2c4.com>
References: <ZuGcQnzUev6eAy0w@zx2c4.com>
 <20240911133745.3124327-2-Jason@zx2c4.com>
 <8d4c1292-1e4d-4d11-b6c2-66dbb5aedb6d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d4c1292-1e4d-4d11-b6c2-66dbb5aedb6d@sirena.org.uk>

On Wed, Sep 11, 2024 at 03:12:35PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 03:36:32PM +0200, Jason A. Donenfeld wrote:
> 
> > It's not correct to use $(top_srcdir) for generated header files, for
> > builds that are done out of tree via O=, and $(objtree) isn't valid in
> > the selftests context. Instead, just obviate the need for these
> > generated header files by defining empty stubs in tools/include, which
> > is the same thing that's done for rwlock.h.
> 
> ...
> 
> > I'll replace the broken commit with this one. I've verified the
> > kselftests are fine now, particularly for kvm.
> 
> Did you also check perf?  For arm64 it uses the sysregs values though I
> don't off hand know if that includes any of the generated values.  I
> would expect that KVM will start breaking for arm64 at some point even
> if it works for now, there was a desire to replace use of magic numbers
> for registers in the tests with defines.

I just booted an arm64 VM and built perf with all the various options
and such, and it works fine. Those header files in the fixup commit
aren't seen by perf.

Jason

