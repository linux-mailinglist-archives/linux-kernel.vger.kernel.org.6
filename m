Return-Path: <linux-kernel+bounces-542889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4177AA4CF18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4768E1894BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CE23875D;
	Mon,  3 Mar 2025 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qA7uTYMk"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDD1F12E7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043645; cv=none; b=o2q+ZMKj7bF/wu0b4SW7PXRMNxrnh4uxeLpXZWvCosI+rBgEbKCu3SV+jGr2x1rYjY0M7zL/QQn0cW7qj26OP5Wt/TvMJefQrdCMp9tYUdFk24sS8kw6qjdxGrMB7dWWAzHqZEXse0IHFcFtw/+o9SyReAjAENAZHRJyhxCFSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043645; c=relaxed/simple;
	bh=ksQKGGa9kQgqkg5ODjySLSS1WpbS/XcqzJBdz1UwtRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBAaeqL7n+bWrsT9451JdfYyRrjKnJixPuVv2+fqrwGT3W5rStWbVFq6qamdL9dYN8MI6r+wIrPiZ4Rq34oTQg1qCxqv1ZCnXfT8ODJdZp0UXXuPkENAYHVjyWmG14enODRCTG+5H67rSj/uPOKnRHsez1jcZrxB+72IAP5LYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qA7uTYMk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1741043640;
	bh=c06IwIafGujtJ/Kas9O7TJpHAAgll/CuyLRgEjfHugs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qA7uTYMkLIPYFCo8o3p8HzFqNGRJGG1rFKmM49NfYb7DWkTXM8xBReM0JY9FaDWHM
	 Dvm40Q6hRt2obXuQ4ROPplCnfmCnRudSrqqWm8AmGrLfdzWRYeyBcRsXGwYXmO0No9
	 mQ3Dt5v5NlGcQb+JwMyjbFgbWPdfTSJyOKe3M8AVaIK5sJAbGjujzY3uIoOjNH2j4x
	 JO8n0bWgcDeZhZzEM9okQjPCJIwbOmvvY5yzxVRYHUy0BSfY8ylbeEhPv5+RF9xzl9
	 H8CeJ4dlxabFB4oRQ7UJYcQspw7rTFzAoT/uoxz20oBnHpcLYJKv6fkVLRgRoy+Ez0
	 wneFlgpE7IZWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6F4Q3RBzz4x3S;
	Tue,  4 Mar 2025 10:13:58 +1100 (AEDT)
Date: Tue, 4 Mar 2025 10:13:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, kernel test robot <lkp@intel.com>,
 Brendan Jackman <jackmanb@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <20250304101357.66067dd3@canb.auug.org.au>
In-Reply-To: <Z8WQEpv7BNtDDoH3@black.fi.intel.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
	<202503010129.rJvGqZN1-lkp@intel.com>
	<20250228182804.GB120597@cmpxchg.org>
	<Z8WQEpv7BNtDDoH3@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZeuLQSGosGcBcpXwHeZ1evo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZeuLQSGosGcBcpXwHeZ1evo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 3 Mar 2025 13:18:42 +0200 Andy Shevchenko <andriy.shevchenko@intel.=
com> wrote:
>
> On Fri, Feb 28, 2025 at 01:28:04PM -0500, Johannes Weiner wrote:
> > On Sat, Mar 01, 2025 at 01:31:30AM +0800, kernel test robot wrote: =20
>=20
> > The patch is missing a dummy in_mem_hotplug() in the
> > !CONFIG_MEMORY_HOTPLUG section of <linux/memory_hotplug.h>. =20
>=20
> +1, I just stumbled over and this is not fixed in today's Linux Next. I'm
> wondering how this was missed during merge into Linux Next. Stephen?

I just get what people put in their trees.  There are no conflicts
around this and none of my builds failed, so I didn't see the problem.
Has someone sent a fix patch to Andrew?  If so, if you forward it to
me, I will add it to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZeuLQSGosGcBcpXwHeZ1evo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfGN7UACgkQAVBC80lX
0Gx9MQf+MIPUXZ445QXq8nD8kEGdAATVDoiwm2KZJnqzIHW6/h7P81s60M1tl97F
qyQWDc2auW3QKvim2HiMionWAZ8paCV7538ZeXtUOa0oiLffZYhUutci0QjLN9wh
qgyxpW+tfdGolwstw/xSqaOh2SRyBe9FpqnBJ6JOKeGtVGfLBfWu3dNWs3ktHddr
vZZKm6mI58JzkRbp70YvkWY9aSQGUFo3zx3GzhaIyPWg5QgvWH/IZl+JjtRMrQ+B
smEDQHhBcvANUzEjbWJzkQrsEQYdhuvjx/Xe14XTibwC1aNPH79FrcIqtN54aC0V
11+SnhPHeTwb4hUUzBZ6eypNlaNk8Q==
=C4Si
-----END PGP SIGNATURE-----

--Sig_/ZeuLQSGosGcBcpXwHeZ1evo--

