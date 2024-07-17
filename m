Return-Path: <linux-kernel+bounces-254634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF99335A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F1AB217EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D476FC5;
	Wed, 17 Jul 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="cwTycDiK"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102519A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721187164; cv=none; b=ba9cMsPoICa7lt7kj3DKCgTvIQvwOs17GK7+N2xfmeq1Ygpt+0GIbgcwdZjMALysIyxWh9e178uG9CEv9gGiKhyQvcSf26GytE9nSHcN9ADZETHV35/oIFIERh25CEDqeupnQpRA+xBaaQgWxARFxlgzEe0xprC8Oje2s1FVJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721187164; c=relaxed/simple;
	bh=D+rQdq7saURwnRscJ2/+YDkMyHgtBaUFB+rvXbbHMec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2w8Zz2vsURY64XfozC01UYSiSWII3whcSs8eUcL7pdtjqDyNnSJkz1MCmNOMd6VaIUFkvWNWtUVf1YXM5yQX5CP6Xm4Q5kno67UsH2/dl2rCEoeu/GjE8p/q1h4YCwJzWexv1ZlNoCJ5qb/fZbqpTVJ2KlKYB9Cfy0UrSPLNXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=cwTycDiK; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1721186815;
	bh=D+rQdq7saURwnRscJ2/+YDkMyHgtBaUFB+rvXbbHMec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cwTycDiKaboJnqoXqwPWjsiRJrmVMfgoLFnIvcU8mtGcSDRVguTGblpRSJhu5OyGF
	 544x1HYcGcUehPhAYEBiyfby4XK5cqkI29JvdULxDqDIfZAVR94bRU9OdVyFB81AIb
	 EsSJaCuW3RRGmT0AAmfkK4rfwwQlKvYxv1ty2LK8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 9E2E066D08;
	Tue, 16 Jul 2024 23:26:42 -0400 (EDT)
Message-ID: <a754294a55b0b11578e34301eacd6badd133eb09.camel@xry111.site>
Subject: Re: [PATCH v10 1/2] x86/mm: Don't disable PCID if "incomplete
 Global INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	 <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley
 <mhklinux@outlook.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Wed, 17 Jul 2024 11:26:19 +0800
In-Reply-To: <20240626171541.eeisf66vhuyspv4j@desk>
References: <20240522020625.69418-1-xry111@xry111.site>
	 <b901776293d19271a34bb14f79639c4b574b6174.camel@xry111.site>
	 <e2cb23a6-60d4-49b1-ba48-1ded846e5292@intel.com>
	 <20240626171541.eeisf66vhuyspv4j@desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 10:15 -0700, Pawan Gupta wrote:
> On Wed, Jun 26, 2024 at 09:50:39AM -0700, Dave Hansen wrote:
> > On 6/26/24 06:10, Xi Ruoyao wrote:
> > > Ping.
> > >=20
> > > Ok to queue these two into some branch for integration?
> >=20
> > Please don't top post, and please trim your replies.
> >=20
> > The code looks fine, but this has zero acks and I can't find any public
> > documentation of which microcode versions fix the errata.
>=20
> Based on an internal document, I provided the microcode versions used in
> this patch.
>=20
> Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

I hope this can catch 6.11...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

