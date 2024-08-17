Return-Path: <linux-kernel+bounces-290878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4B955A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC541F21916
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A7155C9A;
	Sat, 17 Aug 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZctFRYC9"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A829460
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723938999; cv=none; b=p872SxjcM1+3TUfOZNwKBn851CCrXaosfVEVx1c7fE7UmHLJrppa0CgHGTXebTXC6mpfRt66VD/8q+rx1se16Gmx4WrOUl/7Pk69qKZSQ2003gUB7DduQR1K8KV1Dclr6AksrvcxVjK/YulvxJHTZ2dFadPpxclnVAFOBP9RKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723938999; c=relaxed/simple;
	bh=HPeYGQj8KBfSSGdgx1xSLRs6X3tjsozpGe+pyT6X05w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hh023hvXZuS94w35Mej80VwexXdM1RK5dJE4a48KyT1hT1U2yYMsc4FsK7Fl/VPoH82+tleXH9Eur+HrFfIEfXXfN0oOjttKwHkHy7z0c3Stk8AGfzEeWPpU7BPI9uNUqmHXrtXC04X0Bt95ra4UTIZhyWTxhOJkSXIFAvgcgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZctFRYC9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2588F114BBAB;
	Sat, 17 Aug 2024 19:56:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 17 Aug 2024 19:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723938995; x=1724025395; bh=6a9TGoLD+oTDFnVv1MDv/D2dHc/B
	JH70iFj/8O7Fpy0=; b=ZctFRYC9RY1n6KoRyCwMYofxVl1Ye0qHGDd1MJicAPuA
	LaRVAnfo2UvRW9YjC9Xh5VKYWhOVA4sbKeq5D30UZuKCi0aWhonxYdIVuhy+Z/MQ
	DCNgVItf99RBICVeHV7mDoUQBKRugyNVgaTvqMTle7yLj/qG7PMse6TracTegRVu
	yvqthzGmThAq9lY1exLkTXLFbIeL9cCccveR40wgtP9cA95L6GL6be2/lR/G1alJ
	56NBah3T2IzSRHvpOf2wfjorhWWWOa9WQQyaxA1+dULRDRe4GgDtRDvlnRlKtHHZ
	if5Lx1/iQOMHxLJmffHCyaR+J4iqTXWZAKBcLCThlw==
X-ME-Sender: <xms:sjjBZkgqpyUx4t8wEyVb5zCUdRXL5DOEY8mRKvBx9i-h4wleloEaeQ>
    <xme:sjjBZtDMf-rML_MYnvXDMuz5P3eu2fSN3QdjtEa1gnS141_sPnyOg9Dq8GpRR-7Yo
    zsnF-xiEW6ru9_7MAs>
X-ME-Received: <xmr:sjjBZsFsjdFslxMJimuWpnDDEXpHRY8w1JjQzh70kS0JCnD3w-M2qE17D6HusXoMLayr7_P2aG8w2P1Q-Un30CCPxF1RcMfipig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehmtderredttdejnecu
    hfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrd
    horhhgqeenucggtffrrghtthgvrhhnpeffvdegjefgvedvfefghfffvdegfefhgeeliefg
    hfevkeekveeitedtfeduteefieenucffohhmrghinhepuggvsghirghnrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhn
    sehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhr
    tghpthhtohepfhhunhgrhhhosehjuhhrrghirdhorhhgpdhrtghpthhtohepuhhsvghrmh
    ehjeeshigrhhhoohdrtghomhdprhgtphhtthhopehstghhmhhithiimhhitgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugi
    dqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sjjBZlQgvC0UAL1WpT_hjK98vQZ1PS8BZpJNTvT5zVQnvjD2KigTfw>
    <xmx:sjjBZhwA2V-8-W9SNFEE8qgxfWFj8bhya21E8GPbziPwj0HucUBJnw>
    <xmx:sjjBZj7QNKh43mtmMU0zmyg1O6z5MUJPotgy-h9GUBwWFpjt5oQO_w>
    <xmx:sjjBZuzvWUHy1SL0i8IQMR9_8RQ8YAjl7Bd0ieCiz9izdCk_y1odTg>
    <xmx:szjBZkrhPQdBSSrVJErZS9o9M1uTC2OYhUh-HEAuYXi-xWWTFpmvek8I>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Aug 2024 19:56:32 -0400 (EDT)
Date: Sun, 18 Aug 2024 09:56:50 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Joshua Thompson <funaho@jurai.org>, Stan Johnson <userm57@yahoo.com>, 
    Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@lists.linux-m68k.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k/mac: Revise PowerBook 500 series model name
In-Reply-To: <CAMuHMdVx8XL5qPE0fWM3p6hWyUUH5FxSp-wCF5Q1ekXCSemmXA@mail.gmail.com>
Message-ID: <9da54e36-682f-aba1-a5fb-4e41665b9873@linux-m68k.org>
References: <3633d85c51d2133622708e5b0e07cfea96fc295b.1723445731.git.fthain@linux-m68k.org> <CAMuHMdVx8XL5qPE0fWM3p6hWyUUH5FxSp-wCF5Q1ekXCSemmXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-536073561-1723939010=:25075"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-536073561-1723939010=:25075
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Sat, 17 Aug 2024, Geert Uytterhoeven wrote:

> On Mon, Aug 12, 2024 at 8:56=E2=80=AFAM Finn Thain <fthain@linux-m68k.org=
> wrote:
> > The PowerBook 520, 540 and 550 all have macintosh_config->ident =3D=3D =
72
> > because that's their gestalt ID in MacOS. Hence, Linux describes them a=
ll
> > as "Powerbook 520". Change that to "Powerbook 500 series", which is mor=
e
> > accurate.
> >
> > Cc: Joshua Thompson <funaho@jurai.org>
> > Cc: Stan Johnson <userm57@yahoo.com>
> > Reported-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
>=20
> Thanks for your patch!
>=20
> > --- a/arch/m68k/mac/config.c
> > +++ b/arch/m68k/mac/config.c
> > @@ -677,7 +677,7 @@ static struct mac_model mac_data_table[] =3D {
> >                 .floppy_type    =3D MAC_FLOPPY_OLD, /* SWIM 2 */
> >         }, {
> >                 .ident          =3D MAC_MODEL_PB520,
> > -               .name           =3D "PowerBook 520",
> > +               .name           =3D "PowerBook 500 series",
> >                 .adb_type       =3D MAC_ADB_PB2,
> >                 .via_type       =3D MAC_VIA_QUADRA,
> >                 .scsi_type      =3D MAC_SCSI_OLD,
>=20
> This is a user-visible change, through /proc/hardware.
> Do you know if any userspace relies on the old string value?
>=20

I did a search on sources.debian.org and didn't find anything. OTOH, a=20
search for "powerbook" doesn't actually return Michael's packages that=20
used to be available for powerbooks...

Anyway, I agree that /proc/hardware should remain stable, so please=20
disregard this patch.
---1463811774-536073561-1723939010=:25075--

