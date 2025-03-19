Return-Path: <linux-kernel+bounces-568720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F68A699A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB832189FE42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683C211A1E;
	Wed, 19 Mar 2025 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onK13GI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332591DE8BF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413423; cv=none; b=jFUpg1zmWznPbA/ZXmkOnvXFaOtTCqOLBC9SGuZpPYEKyj/LnzmGcbuOcN6O754t82ZbHvPFDfw4R77IGZW6Qk1Z0KBVXRwBpGwf+LXo0HiDdGlTagkYQ/CYkPKpyvuPugRE7gPRvVFA/wOrkAdr/hcjgmquavxNpa4xIxC+wNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413423; c=relaxed/simple;
	bh=RLy6OEJ1xC5Ckuu5K/7meQHquD6LUU9xYTRNxvTVG0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTsAihOdjmjpjghOPA6Lg/j29tWbmJP83APcDvo9A8GCsEGcMPpgKTxk0RBLiqRn5gwWjyIMHJKNfffxxLDUS4LXncPG8bKDoJucM/95ys/KKNlcx5/WAyf2EKkHIbRYNbq+IwvZgufJzBLIXr6kTm8fGd4OCVFPEA8LJ2BKfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onK13GI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4290EC4CEE4;
	Wed, 19 Mar 2025 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742413422;
	bh=RLy6OEJ1xC5Ckuu5K/7meQHquD6LUU9xYTRNxvTVG0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onK13GI+gbK/j02VGOSL8tqrpiORrh22DADYaMxRsrL9ktq+oisQtWGFXxTIhSSQ0
	 Ga09cRtYtWeuIYGvEpdFT+jL0c3tnwBsRujnuI/IAduUpDBYlwMa2K6ReP4+1ZB5oW
	 3vcXIs1mPpVK5moVSLc9JaGbhxa+ItEkaxuva7suzN6WqcWssA4Q/IklVfZdJ9vbxe
	 wn7V7VIhYFhdwVuyzNAWU3iUsHpjMmCeNkMpnGvYf9sZlT5a8KAYrVGQ9YpsBwg8aW
	 Cw2TUO/CJDFVCj4+EUkHFAtMP8lHGg0EaCKNdhPC9aNaBmgJt45s7IaF/DrryRrq5q
	 Nzq51eHvksgGw==
Date: Wed, 19 Mar 2025 20:43:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	den-plotnikov@yandex-team.ru, gpiccoli@igalia.com, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de,
	hpa@zytor.com
Subject: Re: [PATCH v5] x86/split_lock: fix delayed detection enabling
Message-ID: <Z9seaRFmQ9nlOlWf@gmail.com>
References: <20250318144911.10455-1-davydov-max@yandex-team.ru>
 <Z9nWjlIYHXWYJ0eV@gmail.com>
 <8aa58cf6-646a-4676-add5-63f5b41f9842@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa58cf6-646a-4676-add5-63f5b41f9842@yandex-team.ru>


* Maksim Davydov <davydov-max@yandex-team.ru> wrote:

> 
> 
> On 3/18/25 23:24, Ingo Molnar wrote:
> > 
> > * Maksim Davydov <davydov-max@yandex-team.ru> wrote:
> > 
> > > If the warn mode with disabled mitigation mode is used, then on each
> > > CPU where the split lock occurred detection will be disabled in order to
> > > make progress and delayed work will be scheduled, which then will enable
> > > detection back. Now it turns out that all CPUs use one global delayed
> > > work structure. This leads to the fact that if a split lock occurs on
> > > several CPUs at the same time (within 2 jiffies), only one CPU will
> > > schedule delayed work, but the rest will not. The return value of
> > > schedule_delayed_work_on() would have shown this, but it is not checked
> > > in the code.
> > 
> > So we already merged the previous version into the locking tree ~10
> > days ago and it's all in -next already:
> > 
> >    c929d08df8be ("x86/split_lock: Fix the delayed detection logic")
> > 
> >    https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c929d08df8bee855528b9d15b853c892c54e1eee
> > 
> > Is there anything new in your -v5 patch, other than undoing all the
> > changelog cleanups I did for the previous version? ;-)
> > 
> 
> Oh, sorry, I missed it.
> Yes, in v5 initcall is used instead of deferred initialization.
> Either v4 or v5 are good for me. Please be free to choose the more
> convenient variant for you. :-)

Could you please send a delta patch on top of tip:master (or -next) 
that implements the initcall approach? Basically -v5, but on top of 
-v4.

I merged -v4 because I thought the fix was delayed enough already and 
-v4 was functionally fine too, but I won't say no to even better code! :-)

Thanks,

	Ingo

