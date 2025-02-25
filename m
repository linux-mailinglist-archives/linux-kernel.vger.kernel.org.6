Return-Path: <linux-kernel+bounces-531497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96922A44131
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DEC3BAC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DF269D16;
	Tue, 25 Feb 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Im+1dMvg"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B8269B12
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491028; cv=none; b=bbZEKDIyXSdCJA9trg9p1vlVRFPOZRbeUHGxdCqspa2qal2xSjb2CK3MBHU2v9t80cZlsiiHw/kM8EjP801q6SiAoAcOpi9DppP62QCy27gkEAJp2UXOy6jbeST9Jqk2oeE9/0YXQZ7iwK9xugG3dBW7JJIj/Lq6NCqXlK3vPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491028; c=relaxed/simple;
	bh=3fM7biF8J6xeUXpwJrwCogIkZmL6UYqmxkrYYBnIQTY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=UnrjQMPijz2I3EHfFuDBw7sO3v70J1duVBXN9eiDTV2M5VtXfMVZpM2tXw7zPU9LO0kpIEbd1PtkNYHvSr9UZTWiF8cQSeHIBvl5ZBKcCoStE/QVe051nj7GNOqdzPxzBnD6EBpwVroj2GV6IOaVJUcIfGXZajg/OAdhx8RTS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Im+1dMvg; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740491024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5z/hgms5AtG2/Xq1zXh9FQ4fJkrKJYwbT/K/MGV0P7M=;
	b=Im+1dMvgGSmT5uiMpqSNiaMyH+vXd4RXZf8O81JtQU4RNWAQYPgTziHAYTd+jstdNd7tq3
	wI1C4gO1uusyW3pCu/71RhZd8+8zMCdp5HyHhoYwlnMWApahuQasyPBbosoLayUt0Am758
	iUX38c0hvLcRi3yftU67fNZYKgTKjQ8=
Date: Tue, 25 Feb 2025 13:43:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <3482501981b13aedda3c1c6b54d83d496bd05922@linux.dev>
TLS-Required: No
Subject: Re: mm: zswap: fix crypto_free_acomp deadlock in zswap_cpu_comp_dead
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "syzbot"
 <syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org
In-Reply-To: <Z72FJnbA39zWh4zS@gondor.apana.org.au>
References: <67bcea51.050a0220.bbfd1.0096.GAE@google.com>
 <Z72FJnbA39zWh4zS@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

February 25, 2025 at 12:53 AM, "Herbert Xu" <herbert@gondor.apana.org.au>=
 wrote:
>=20
>=20On Mon, Feb 24, 2025 at 01:53:21PM -0800, syzbot wrote:
>=20
>=20> syzbot found the following issue on:
> >=20
>=20>  HEAD commit: e9a8cac0bf89 Merge tag 'v6.14-rc3-smb3-client-fixes' =
of gi..
> >  git tree: upstream
> >  console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b667f8=
580000
> >  kernel config: https://syzkaller.appspot.com/x/.config?x=3D61cbf5ac8=
a063ad4
> >  dashboard link: https://syzkaller.appspot.com/bug?extid=3D1a517ccfcb=
c6a7ab0f82
> >=20
>=20>  compiler: gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40=20
>=20>=20
>=20>  Unfortunately, I don't have any reproducer for this issue yet.
> >=20=20
>=20>  Downloadable assets:
> >  disk image: https://storage.googleapis.com/syzbot-assets/8441f1b5040=
2/disk-e9a8cac0.raw.xz
> >  vmlinux: https://storage.googleapis.com/syzbot-assets/65b1f8d2f790/v=
mlinux-e9a8cac0.xz=20
>=20>  kernel image: https://storage.googleapis.com/syzbot-assets/1d6f6d8=
c3d6b/bzImage-e9a8cac0.xz
> >=20
>=20
> ---8<---
>=20
>=20Call crypto_free_acomp outside of the mutex in zswap_cpu_comp_dead
> as otherwise this could dead-lock as the allocation path may lead
> back into zswap while holding the same lock. Zap the pointers to
> acomp and buffer after freeing.
> Also move the NULL check on acomp_ctx so that it takes place before
> the mutex dereference.
>=20
>=20Fixes: 12dcb0ef5406 ("mm: zswap: properly synchronize freeing resourc=
es during CPU hotunplug")
> Reported-by: syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Interesting, it's weird that crypto_free_acomp() allocates memory. Do you=
 have the specific call path?

