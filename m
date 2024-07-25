Return-Path: <linux-kernel+bounces-262451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA3193C74B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3381C21E18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC819DF64;
	Thu, 25 Jul 2024 16:40:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D9019DF43
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925636; cv=none; b=VuHwG9tuuhg24vSZYYmfZcoNVwQAqVVtLja1UyEJNe4lR5EUO6lYzO123q1TEI54hjcT9OY8oliTD3uSdoKImdLkEOoOYpoGFmgn/H1JPV8YoKp9tSYTJDjhrayYfTL6pWse0jxqITJejoJfrdehWu0LlqbF8ep5jM8dsPrbI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925636; c=relaxed/simple;
	bh=Ga6x9IkXLr4/KClvs9c0gNauYexfNJznKB82YLQTFbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FQBT18fExEIpMuQ1CK9U7+TJYkwiupM0AeuDFiXQXYhzsheWq0TqV/bkJPWi4I83M/p5jU1W8pMTGil3bf44EA+85+AuLMhZHCWPVgbPpaLcL8BQW0VK958763yGEBuM8fFB91wgg+78LVzMKkk/64VZ+bWgC5pz6swB4ZmLNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-203-6SZKwZkdNQGPE2agbHEO1Q-1; Thu, 25 Jul 2024 17:40:24 +0100
X-MC-Unique: 6SZKwZkdNQGPE2agbHEO1Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 25 Jul
 2024 17:39:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 25 Jul 2024 17:39:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'kernel test robot' <lkp@intel.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Linus Torvalds'
	<torvalds@linuxfoundation.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "'Matthew
 Wilcox (Oracle)'" <willy@infradead.org>, 'Christoph Hellwig'
	<hch@infradead.org>, 'Andrew Morton' <akpm@linux-foundation.org>, "Linux
 Memory Management List" <linux-mm@kvack.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, 'Arnd Bergmann' <arnd@kernel.org>,
	"'Jason@zx2c4.com'" <Jason@zx2c4.com>, "'pedro.falcato@gmail.com'"
	<pedro.falcato@gmail.com>, 'Mateusz Guzik' <mjguzik@gmail.com>
Subject: RE: [PATCH 4/7] minmax: Simplify signedness check
Thread-Topic: [PATCH 4/7] minmax: Simplify signedness check
Thread-Index: Adrd1i0k/JcX2h1sSAO9D37F5HIFAAAt19eAAAiWjHA=
Date: Thu, 25 Jul 2024 16:39:44 +0000
Message-ID: <f3b69fcd666e498da74c12f332c3a2a0@AcuMS.aculab.com>
References: <03601661326c4efba4e618ead15fa0e2@AcuMS.aculab.com>
 <202407252100.fDFchC5O-lkp@intel.com>
In-Reply-To: <202407252100.fDFchC5O-lkp@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: kernel test robot <lkp@intel.com>
> Sent: 25 July 2024 14:24
>=20
> Hi David,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master v6.10 next-20240725]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minma=
x-Put-all-the-clamp-
> definitions-together/20240724-224832
> base:   linux/master
> patch link:    https://lore.kernel.org/r/03601661326c4efba4e618ead15fa0e2=
%40AcuMS.aculab.com
> patch subject: [PATCH 4/7] minmax: Simplify signedness check
> config: mips-loongson1b_defconfig (https://download.01.org/0day-
> ci/archive/20240725/202407252100.fDFchC5O-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project
> 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-
> ci/archive/20240725/202407252100.fDFchC5O-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407252100.fDFchC5O-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
...
> b286d8b1a690667 Herbert Xu 2016-11-22  75
> b286d8b1a690667 Herbert Xu 2016-11-22  76  /* Get a spot of the specified=
 length that does not straddle a page.
> b286d8b1a690667 Herbert Xu 2016-11-22  77   * The caller needs to ensure =
that there is enough space for this operation.
> b286d8b1a690667 Herbert Xu 2016-11-22  78   */
> b286d8b1a690667 Herbert Xu 2016-11-22  79  static inline u8 *skcipher_get=
_spot(u8 *start, unsigned int len)
> b286d8b1a690667 Herbert Xu 2016-11-22  80  {
> b286d8b1a690667 Herbert Xu 2016-11-22  81  =09u8 *end_page =3D (u8 *)(((u=
nsigned long)(start + len - 1)) & PAGE_MASK);
> b286d8b1a690667 Herbert Xu 2016-11-22  82
> b286d8b1a690667 Herbert Xu 2016-11-22 @83  =09return max(start, end_page)=
;
> b286d8b1a690667 Herbert Xu 2016-11-22  84  }
> b286d8b1a690667 Herbert Xu 2016-11-22  85

I thought this version supported that :-(
Certainly I've hit and fixed this before.
Using min/max() on pointers just makes it all more horrid.
The problem is that is_signed_type() isn't 'constant enough' for pointers.

Supporting pointers may require yet another (bloating) _is_constexpr() call=
.
Or add a simpler min_ptr() that includes a 'pointer' check.

But this might only be reported by clang with W=3D1.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


