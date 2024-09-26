Return-Path: <linux-kernel+bounces-340162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABD986F41
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E251F223F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3781AB52A;
	Thu, 26 Sep 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYG2ylC/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29201A7AD0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340530; cv=none; b=Nc3+M+ERE48pX4mnoRdkabMYCwKoVgJR2yYjRo6BsWPjuDDNDIgmbfShrZVL8kKhhdlKNYVWYggV5AseGLZt123XEShQlgvW+jLu8dqHOPbxzd04Z8yCzjYVFFzkJlBGn5uObyxQB6D6v+6ZGN2xTA1s34r87gE2I1OU03vdcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340530; c=relaxed/simple;
	bh=GqW2hqIsMVVOZmezY2NwpHbzeYEpLgncKMPpb91rTug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnnPt4UNgsZqdhVgEVRQVKTX8tD2Yinadm1fhyDDIhBP5Z6vo7WHBD74/Gn+Vs5kYaGu4RiwSsP2EvtsWn+qwVtnm900iUx7SIqev/H8EQMquYH6Do+TKEf700fnVHtJo2LFLgAVkOAr32Byn8kwBDzZGmGAxI3Dx4f7wuaEWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYG2ylC/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727340529; x=1758876529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GqW2hqIsMVVOZmezY2NwpHbzeYEpLgncKMPpb91rTug=;
  b=BYG2ylC/OtstAOYq0q5T9YoYoPJ8DSDxuhFQZFd4szOoU5udZPo0hZ33
   DhapVlthBOXRX+N/Ds9vKJYqCSE1sNBwGnc/ZVQFJbrWMspOeUlMtnjAD
   TYl56RQTFWpfDnt72pSC5+nOl7Gs5vw0WxdHOy2rLAs/PP1Elk06fCaVn
   oqUgTyD9b7SO0DEZIkLLimb+eM1sr8+XhXBdsmPSGBdiELv2sL5t//QIk
   SPOidhPFZ0KDGcKi+1aV5Y6utVqbvBXXCZcfdeT+5C3CF6JIjvqparQmn
   XTSeUBHzI+mjrEI99I9gIeNPFMGZJPT8pZELm8+rSlUL1JIGwdICSLPwK
   A==;
X-CSE-ConnectionGUID: mlBNmM90QPC7674Qj9lsYA==
X-CSE-MsgGUID: Bk9YFhpZSSW0wWi2knqfeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26287502"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26287502"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 01:48:48 -0700
X-CSE-ConnectionGUID: AqV/+7iIREie4U49A/m75A==
X-CSE-MsgGUID: RJ8UF7yNR+WgVWHjZsk8ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71950612"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 01:48:48 -0700
Date: Thu, 26 Sep 2024 01:48:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, hjl.tools@gmail.com,
	hubicka@ucw.cz
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
Message-ID: <ZvUf7pkvq3m9wYjr@tassilo>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com>
 <87ikuj30g8.fsf@linux.intel.com>
 <CAMj1kXEQJraatFuA1CVwQz6Uos-0LbVVyCa=FgkHgEAQBCn=TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEQJraatFuA1CVwQz6Uos-0LbVVyCa=FgkHgEAQBCn=TQ@mail.gmail.com>


On Wed, Sep 25, 2024 at 11:23:39PM +0200, Ard Biesheuvel wrote:
> > What matters is what it does to general performance.
> >
> > Traditionally even on x86-64 PIC/E has a cost and the kernel model
> > was intended to avoid that.
> >
> 
> Is the x86_64 kernel C model specified anywhere, to your knowledge?

The basics are in the ABI. Maybe some of the details of TLS / stack
protector are missing (I guess that could be fixed, adding HJ)

Some of the motivation was also in early papers like
https://www.ucw.cz/~hubicka/papers/amd64/amd64.html

I'm copying Honza Hubicka who did the original work.

> 
> > From my perspective this patch kit doesn't fix a real problem,
> > it's all risk of performance regression with no gain.
> >
> 
> It's all in the cover letter and the commit logs so I won't rehash it
> here, but I understand that your priorities may be different from
> mine.

It sounded fairly nebulous to me. If Linux wanted to support a third tool chain
and it didn't support the kernel model yet it would be somehow easier.
Apart from the kernel model likely being one of the minor issues
in such a endeavour, I don't see a third tool chain othan than gcc and llvm
anywhere on the horizon?

> 
> I'll provide some numbers about the impact on code size. Are there any
> other performance related aspects that you think might be impacted by
> the use of position independent code generation?

Code size isn't a sufficient metric either.

Linux sometimes goes to great length for small gains, for example
there was a huge effort to avoid frame pointers, even though it's a
small percentage delta. PIC could well be larger than frame pointers.

You need to run it with some real workloads, e.g. some of the kernel
oriented workloads in 0day or phoronix, and see if there are
performance regressions.

Unfortunately for an intrusive change like this this might also vary for
different CPUs, so may need some more coverage.

-Andi

