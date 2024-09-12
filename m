Return-Path: <linux-kernel+bounces-327176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9E97717A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC161F24E66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C765E1BF80D;
	Thu, 12 Sep 2024 19:37:09 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20318BC20
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169829; cv=none; b=BQRXDdEdCuv126crkNOFeGvGiWuzWA4C+yvyqPO0AJhHISmHgGJSsBrKQU97UIMsT4ZRJmYjhuWlUfclglYgUkDctjWWBJBgEcazSgD0BzRKk8IY62yUCDeiHHogoGPw8gBUSBqtRLkrtujM6Gfsa4lZFtNYf8tbS9vhs1XVms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169829; c=relaxed/simple;
	bh=m4uVIsmRBCQS8wsoLOk+4cGG0ABaeIsPxjbzr7hkfCw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PDmR0hOOn6yWE2KRlLX4CeaTR/hHr3tJX+rhSff9WgKR+jd8jTwaxusu/M+QgtrpDfTB6nvkqnr/uMf1of933sO0Hn0fy82JRi/cjQZkaF+HaNaImACPXCJ0LMstgu0+3spsk/IFA1e1d4qoMu5lO9WG1F0VNK/bqvZIWC4IPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3DC0C626FAF7;
	Thu, 12 Sep 2024 21:37:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OTU2KmO2FZ4A; Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AD138626FB02;
	Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0XU1_VBP06iE; Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8B334626FAF7;
	Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
Date: Thu, 12 Sep 2024 21:37:03 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Matthew Wilcox <willy@infradead.org>
Cc: Li Zetao <lizetao1@huawei.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <108225933.37250.1726169823389.JavaMail.zimbra@nod.at>
In-Reply-To: <ZuM0xHQqSpen_xxY@casper.infradead.org>
References: <20240820025045.13339-1-lizetao1@huawei.com> <731546887.37035.1726165368713.JavaMail.zimbra@nod.at> <ZuM0xHQqSpen_xxY@casper.infradead.org>
Subject: Re: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Convert hostfs_writepage to use folio
Thread-Index: RplTndW6NFIHyOhW2DjJoD9i6RjPoQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
>> > -=09buffer =3D kmap_local_page(page);
>> > +=09buffer =3D kmap_local_folio(folio, 0);
>=20
> These two lines assume that hostfs remains a non-large-folio filesystem.
> I'm not sure what the plans are for hostfs.

Somewhere deep on my TODO are plans to remove hostfs and replace it
with something such as 9p or virtiofs.
Any volunteers? :-)

Thanks,
//richard

