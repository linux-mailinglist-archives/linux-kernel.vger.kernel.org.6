Return-Path: <linux-kernel+bounces-274071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BB947316
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27F71F2118D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB313CA8D;
	Mon,  5 Aug 2024 01:34:23 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABA20DE8;
	Mon,  5 Aug 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821662; cv=none; b=n3n/4rJ5gOi/ysCQehDXrQSB7C+Vvjn1bAW2EYV9Tj1xs9gNg9cUu7njLYC9kS3QICiuRowJ0VNhJl7ns1kYW4+c+4uxkNjWdxsHiDZe/Z6Kb17EWsZfs91aL0DOHFPiSbCJsJHbissib4HVkq9bnfPK6A7TzS7DpCzK8sLyfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821662; c=relaxed/simple;
	bh=Wgr58nwnY0Mco7kjux8ii6T4Q4O2jfEhsYqBxsD9YpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lzdsv6pou/3hgt4AC/9F1A3xoaxT7kF2Rf1pyUoQbtDyYhN/B25Yw/uBRIPqvYbfhgC7rLa+l+X/1RvjY8KOOcdOx7RQSaunMuxI37oL9Vk1TicEtByiohvS7illc5i2X6CumjF2BzVQyKv/X5fZ3CeqJf0bdakL77QPMkA8wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1samao-000000000mQ-42LS;
	Sun, 04 Aug 2024 21:32:58 -0400
Message-ID: <a3e367bbb2d3f32532b54ad91facec3ff4fee686.camel@surriel.com>
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
From: Rik van Riel <riel@surriel.com>
To: Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
 linux-mm@kvack.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
 roman.gushchin@linux.dev, baohua@kernel.org, ryan.roberts@arm.com,
 rppt@kernel.org,  willy@infradead.org, cerasuolodomenico@gmail.com,
 corbet@lwn.net,  linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
Date: Sun, 04 Aug 2024 21:32:57 -0400
In-Reply-To: <CAOUHufZ=Oquy_UGBC0FTjJ5QvQnhk0UipHBMfJ5yqSYn06qevg@mail.gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
	 <CAOUHufb7z13u51VCTGZMimoCXpmfT5AOAbrUpAvJjTx5+AXwew@mail.gmail.com>
	 <aea333fb-44ab-41eb-9060-472b08e3010d@redhat.com>
	 <CAOUHufZ=Oquy_UGBC0FTjJ5QvQnhk0UipHBMfJ5yqSYn06qevg@mail.gmail.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Sun, 2024-08-04 at 15:54 -0600, Yu Zhao wrote:
> On Thu, Aug 1, 2024 at 9:47=E2=80=AFAM David Hildenbrand <david@redhat.co=
m>
> wrote:
> >=20
> > On 01.08.24 08:09, Yu Zhao wrote:
> > >=20
> > > =C2=A0 I would recommend shatter [1] instead of splitting so that
> > > 1) whoever underutilized their THPs get punished for the
> > > overhead;
> > > 2) underutilized THPs are kept intact and can be reused by
> > > others.
> > >=20
> > > [1]
> > > https://lore.kernel.org/20240229183436.4110845-3-yuzhao@google.com/
> > >=20
> >=20
> > Do you have any plans to upstream the shattering also during
> > "ordinary"
> > deferred splitting?
>=20
> Yes, once we finish verifying it in our production.
>=20

Shattering does seem like a nice improvement to the THP shrinker!

However, given that the shattering code is still being verified,
and the THP shrinker policy will no doubt need some tuning once
more real world workloads get thrown at it, would it make sense
to do those two things in parallel?

We could move forward with the THP shrinker as-is today, and use
the increased exposure it gets to fine tune the shrinking policy,
and then move it over to using the shattering code once that is
ready.

Is there any good reason to serialize these two things?

--=20
All Rights Reversed.

