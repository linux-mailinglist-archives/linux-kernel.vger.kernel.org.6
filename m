Return-Path: <linux-kernel+bounces-357147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC97996C79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735911F22B02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A0C1990DC;
	Wed,  9 Oct 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJzm/qMW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73011922F4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481416; cv=none; b=mZ42Oly3+McjyjsWw5PmP7uycAzyFwHlztMNbfQun63MXDZnSqvQ31O6pH135p1Lx+LQp0wGoKpD0mq2REO6DO/nWIscSzZF0s3/fBkKC/TLjl7kZpS4zNeczQqfyMdNek3pOvOj5BV0w/w5OfPK4F+wcZ4zawExiIzXGKYjO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481416; c=relaxed/simple;
	bh=BmZuKYMkRJ8L4w1vaVjp3jgciXYLxJjGTkK4HfuIKHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gq3osaJCcc3NyPUZeD4Y9pgwOhVEu8I0l9MeZL4Du3wtWbRyxTJm9zi+WCESnHvrWPPaGhC4dOXaxsBBViDWOcXObh3/ECclvIN9SE4IpdQ8jtsEbZXt9fAy4QhOfyRAl5WoSdMTJK+hN2xBUWO8eTbqYNegQlL29zm1SY1rqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJzm/qMW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728481415; x=1760017415;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BmZuKYMkRJ8L4w1vaVjp3jgciXYLxJjGTkK4HfuIKHE=;
  b=PJzm/qMWsX8QcyB4IkbhzyiyGfqhskSYJB1xyn0QR8neyv00098YBItj
   ZEB+QutTuUBkygVysPIgKEid33IrRQ/dYvM8OfIQ+X7zKBoNBQOuy95UH
   r0GnuKuJaNWv5gDYC0AVQKTFIR/gSeN6gHxBKjXh1TkNaEY3qte4kQ740
   DADANJ+Pfh531fxWYHFK4j0s5zvfLeaYpdjdTurPZ53QEVD3oolWO+WIv
   Vet/6MhR+lK/8NL0fbr6tQ6XebYs/uRmfNfYrNwtbWdualILa4cmDo7mc
   SvizWcG+sq+SjIH3XT6n5vCJPfQvjCCQcMpM02R28TigCcswTO53VBI7T
   Q==;
X-CSE-ConnectionGUID: 62fdH0cBSbKABUDcX3nydA==
X-CSE-MsgGUID: QkkwJnanR56h7/h6qj5NCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39142952"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="39142952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:43:34 -0700
X-CSE-ConnectionGUID: bPpCYgWzR1W8nDTQLGhBjg==
X-CSE-MsgGUID: HeHDlAiMQNyfm4UODcHrCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="75855340"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.245.243]) ([10.245.245.243])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 06:43:32 -0700
Message-ID: <c5e8899f4bcba24a787cd0f4c92c3fc4d7ef3130.camel@linux.intel.com>
Subject: Re: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: intel-xe@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, Maarten Lankhorst <maarten@lankhorst.se>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org
Date: Wed, 09 Oct 2024 15:43:29 +0200
In-Reply-To: <20241009131015.GP17263@noisy.programming.kicks-ass.net>
References: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
	 <20241009131015.GP17263@noisy.programming.kicks-ass.net>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 15:10 +0200, Peter Zijlstra wrote:
> On Wed, Oct 09, 2024 at 11:20:31AM +0200, Thomas Hellstr=C3=B6m wrote:
> > When using mutex_acquire_nest() with a nest_lock, lockdep refcounts
> > the
> > number of acquired lockdep_maps of mutexes of the same class, and
> > also
> > keeps a pointer to the first acquired lockdep_map of a class. That
> > pointer
> > is then used for various comparison-, printing- and checking
> > purposes,
> > but there is no mechanism to actively ensure that lockdep_map stays
> > in
> > memory. Instead, a warning is printed if the lockdep_map is freed
> > and
> > there are still held locks of the same lock class, even if the
> > lockdep_map
> > itself has been released.
> >=20
> > In the context of WW/WD transactions that means that if a user
> > unlocks
> > and frees a ww_mutex from within an ongoing ww transaction, and
> > that
> > mutex happens to be the first ww_mutex grabbed in the transaction,
> > such a warning is printed and there might be a risk of a UAF.
> >=20
> > Note that this is only problem when lockdep is enabled and affects
> > only
> > dereferences of struct lockdep_map.
> >=20
> > Adjust to this by adding a fake lockdep_map to the acquired context
> > and
> > make sure it is the first acquired lockdep map of the associated
> > ww_mutex class. Then hold it for the duration of the WW/WD
> > transaction.
> >=20
> > This has the side effect that trying to lock a ww mutex *without* a
> > ww_acquire_context but where a such context has been acquire, we'd
> > see
> > a lockdep splat. The test-ww_mutex.c selftest attempts to do that,
> > so
> > modify that particular test to not acquire a ww_acquire_context if
> > it
> > is not going to be used.
> >=20
> > v2:
> > - Lower the number of locks in the test-ww_mutex
> > =C2=A0 stress(STRESS_ALL) test to accommodate the dummy lock
> > =C2=A0 introduced in this patch without overflowing lockdep held lock
> > =C2=A0 references.
>=20
> Thanks, I rebased tip/locking/core, which should now have this patch.

Thanks.
It takes some time for that failing CI test to run, though so, and
since I can't repro the failure locally I'll keep a watch out.

/Thomas


