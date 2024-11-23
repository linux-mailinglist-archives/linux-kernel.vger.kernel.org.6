Return-Path: <linux-kernel+bounces-419222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A029D6AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863F4161B36
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFEC152532;
	Sat, 23 Nov 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q51br0tl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77413D531
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732388965; cv=none; b=CLue3jGkGGmnpRe5GcnHTjhmUqMQXNdpXv3qthkspeFh2bLkopdTRExuPHhiss7Pc0DZxuPZa9YMr1EOu8vBsjgx0I7rwMXw+NoD3qtLzXcMYAIFTkggNAV2PRIBq8BGl1yfyiCYZU0ho+0uaT8FSpRI/V9+NvasARaeRCTd7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732388965; c=relaxed/simple;
	bh=2j2uauFKrxX0ydUR2Vfg+XFHiCgWCTsBIv0ACAUd73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSVLTlht2fULkqMicmW1HrID7aaRYwzCm8VOfNhpJqazrRvfIu/5XKdSTNrM2eNILFfgZu1dNix6rVSVs8U5O/o94xQRAXjum3lwkF0tiUbyuKq48Yjw4V42e67lCEUA5zwEkRAIcmEYx9d5uH2wyZwJVAwSWxEF0jlamNaRmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q51br0tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACB0C4CECD;
	Sat, 23 Nov 2024 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732388964;
	bh=2j2uauFKrxX0ydUR2Vfg+XFHiCgWCTsBIv0ACAUd73g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q51br0tlFhxv72qzFNS+fMqY/TBh6ZXlbZ5ar34mDBLUMFkETlc34io0wXeiL5+0K
	 n6qQ6f1rYs6cXNF+t7fzwl9iprnQv+MluO0MibT2RejPM/sU9DCfOhZdT72plkY7+H
	 8jeXOzctqMRhENoCu66hxPhWKbHSV6wathkfxwI69BAFnro2Yv3Dm8mzuVfwNjqoLM
	 UZyFDnhDQ6b1YAHvUaJQ6y529PWQ3+6vSahE27vLVJ/ElAX61cGTXzpb67+vIm602G
	 ujlfollE612GZHDyiRF1zHJzrr0SJeaAcnRLFJfj0JqG/hf1CM3vmJM9UNOfWcIY2V
	 VtTLB8kNioClQ==
Date: Sat, 23 Nov 2024 12:09:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Mateusz Guzik' <mjguzik@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "andy@kernel.org" <andy@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] string: retire bcmp()
Message-ID: <20241123190922.GA3314432@thelio-3990X>
References: <20241123094729.1099378-1-mjguzik@gmail.com>
 <20241123094729.1099378-3-mjguzik@gmail.com>
 <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com>

Hi David,

Thanks for the CC.

On Sat, Nov 23, 2024 at 03:13:09PM +0000, David Laight wrote:
> From: Mateusz Guzik
> > Sent: 23 November 2024 09:47
> > 
> > While architectures could override it thanks to __HAVE_ARCH_BCMP, none
> > of them did. Instead it was implemented as a call to memcmp().
> > 
> > These routines differ in the API contract: memcmp()'s result indicates
> > which way the difference goes (making it usable for sorting), whereas
> > bcmp()'s result merely states whether the buffers differ in any way.
> > 
> > This means that a dedicated optimized bcmp() is cheaper to execute than
> > memcmp() for differing buffers as there is no need to compute the return
> > value.
> > 
> > However, per the above nobody bothered to write one and it is unclear if
> > it makes sense to do it.
> > 
> > Users which really want to compare stuff may want to handle it
> > differently (like e.g., the path lookup).
> > 
> > As there are no users and the code is merely a wrapper around memcmp(),
> > just whack it.
> > 
> ...
> > 
> > -/*
> > - * Clang may lower `memcmp == 0` to `bcmp == 0`.
> > - */
> > -int bcmp(const void *s1, const void *s2, size_t len)
> > -{
> > -	return memcmp(s1, s2, len);
> > -}
> > -
> 
> As per the comment I thought that clang would sometimes generate
> calls to bcmp().
> 
> So while the two symbols could refer to the same code I don't
> think it can be removed.

Right, commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
explicitly added bcmp() to lib/string.c because LLVM will emit calls to
bcmp instead of memcmp in certain circumstances [1], an optimization
that still exists, thus this patch would trigger new errors at link or
modpost time:

  ERROR: modpost: "bcmp" [arch/x86/kvm/kvm.ko] undefined!
  ERROR: modpost: "bcmp" [arch/x86/kvm/kvm-intel.ko] undefined!
  ERROR: modpost: "bcmp" [fs/quota/quota_v2.ko] undefined!
  ERROR: modpost: "bcmp" [fs/dlm/dlm.ko] undefined!
  ERROR: modpost: "bcmp" [fs/netfs/netfs.ko] undefined!
  ERROR: modpost: "bcmp" [fs/ext4/ext4.ko] undefined!
  ERROR: modpost: "bcmp" [fs/minix/minix.ko] undefined!
  ERROR: modpost: "bcmp" [fs/fat/fat.ko] undefined!
  ERROR: modpost: "bcmp" [fs/isofs/isofs.ko] undefined!
  ERROR: modpost: "bcmp" [fs/nfs/nfs.ko] undefined!
  WARNING: modpost: suppressed 254 unresolved symbol warnings because there were too many)

  ld.lld: error: undefined symbol: bcmp
  >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:715)
  >>>               vmlinux.o:(load_pdptrs)
  >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:715)
  >>>               vmlinux.o:(kvm_arch_irqfd_route_changed)
  >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:715)
  >>>               vmlinux.o:(vmx_check_processor_compat)
  >>> referenced 438 more times
  >>> did you mean: bacmp
  >>> defined in: vmlinux.o

Please do not apply this patch. If we need to shore up the comment to
make this explicit, I am happy to do so.

[1]: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7dfc4ddd18eedcff13

Cheers,
Nathan

