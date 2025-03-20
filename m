Return-Path: <linux-kernel+bounces-570060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB48A6AB89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08143BB690
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD022257D;
	Thu, 20 Mar 2025 16:55:41 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E411E9B02;
	Thu, 20 Mar 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489741; cv=none; b=u0LMuG8F+B3ANlymjCowbsS4vOFGs8W975CtxS/sHAKvrpKRv0bSYBBGelYnBJXTQuRgQIZQNXjk7CJTfy8WDXBdmZ+7J7f1L0aSP1zJ4qWHutaQakw2YSskCDHhjfhaltJQL/xp7O8tQXdTC1qAb7wtoBSPDTNOibwExpAEu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489741; c=relaxed/simple;
	bh=cESvC4LT0egAIOny8aWYQ6lxbETK/HKS0OTbS1TOsqM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=no/H2Qv//5cRHvkYFVjoBU9lDpk7gGSEhpPiIDRMVy2qzr1+aRqzPQtHG0p2oq+bjqLvY+dp+6Sio6CDLNCggnvjQzo3ZX7ffQXnE/NMorODHtVrACgqi0LtoKxzGr4OoquULLw70uxPUH0XjOc36PtbmR+aLJqYrT9t+lGECGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tvJAp-000000001zx-13kX;
	Thu, 20 Mar 2025 12:55:15 -0400
Message-ID: <8b5e03015a5783ed4c80ad0bd57e09e651d890d3.camel@surriel.com>
Subject: Re: [PATCH] mm/vmscan: batch TLB flush during memory reclaim
From: Rik van Riel <riel@surriel.com>
To: kernel test robot <lkp@intel.com>, Vinay Banakar <vny@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Andrew Morton
 <akpm@linux-foundation.org>,  Linux Memory Management List	
 <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Bharata B Rao <bharata@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra	 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 SeongJae Park	 <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Byungchul Park	 <byungchul@sk.com>, Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Mar 2025 12:55:15 -0400
In-Reply-To: <202503201810.9JxSMo0Q-lkp@intel.com>
References: <20250319132818.1003878b@fangorn>
	 <202503201810.9JxSMo0Q-lkp@intel.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2025-03-20 at 19:42 +0800, kernel test robot wrote:
> Hi Rik,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on akpm-mm/mm-everything]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Rik-van-Riel/mm-vmscan-bat=
ch-TLB-flush-during-memory-reclaim/20250320-013150
> base:=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git=C2=A0mm-
> everything
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20250319132818.1003878b%40fangorn
> patch subject: [PATCH] mm/vmscan: batch TLB flush during memory
> reclaim
> config: sh-randconfig-001-20250320
> (https://download.01.org/0day-ci/archive/20250320/202503201810.9JxSMo
> 0Q-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20250320/202503201810.9JxSMo
> 0Q-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202503201810.9JxSMo0Q-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>):
>=20
> =C2=A0=C2=A0 mm/vmscan.c: In function 'shrink_folio_list':
> > > mm/vmscan.c:1560:53: error: implicit declaration of function
> > > 'folio_test_young'; did you mean 'folio_set_count'? [-Wimplicit-
> > > function-declaration]
> =C2=A0=C2=A0=C2=A0 1560 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (folio_mapped(folio) &&
> folio_test_young(folio)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> folio_set_count


This is a fun one, because there appear to be several=C2=A0
instances of folio_test_young sprinkled through mm/*.c
in the current mm tree.

I guess some combination of config options and a previous
change to the tree broke this?

It looks like this failing compile is on sh, without
CONFIG_64BIT, but with CONFIG_PAGE_IDLE_FLAG set.

In that case, page_idle.h has an inline folio_test_young().

Does vmscan.c simply need to #include <linux/page_idle.h>
or should the code be using folio_test_clear_referenced()
instead of folio_test_young() ?

--=20
All Rights Reversed.

