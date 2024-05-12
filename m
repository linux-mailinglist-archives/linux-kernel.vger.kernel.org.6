Return-Path: <linux-kernel+bounces-177004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D98C3861
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEC71F21E24
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3082561B;
	Sun, 12 May 2024 20:48:51 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41001E502
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715546931; cv=none; b=FuuIIacsM18ev3U1B5IrCTaAEqBbSYHH3fK0EAfwydutowTxP0Z6JAPLOaPRz/RFn9kR3RYnrUPILUPBWgwjFByMNKIFbCpH1lqnb2J6L2kmiaZx9YkKO8PIWmB6ho549GUSb6JFRxYyGUR61KzlLGLsjMpBqylQIkzF5Obxm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715546931; c=relaxed/simple;
	bh=mQz2PVpow/m3oWLabdk1T8VjND6NQfy9quPq/5IXeUo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mbCENxJGl4WgRw1tTLPKAM2W0gLy1EyNGm7SH/Ik/WnUFoVTZAGpo2CmHU7uJ0dxjjRXGMoZk+cUL/ww96SzxN/c+rkuzQ/Gp4XIR6UyvI1MnqdRdVWX1SMf74+0STT1IdHXqJG17Wdm07tiG1oA2e8DJ+waXVPeO8tZN0CJajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 216D6647A81E;
	Sun, 12 May 2024 22:39:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id K9RyJ2jP0xmW; Sun, 12 May 2024 22:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 893EE626FAF9;
	Sun, 12 May 2024 22:39:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zTe9dMvffljG; Sun, 12 May 2024 22:39:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 69F4C647A81E;
	Sun, 12 May 2024 22:39:07 +0200 (CEST)
Date: Sun, 12 May 2024 22:39:07 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	lvc-project@linuxtesting.org
Message-ID: <1371873614.97879.1715546347299.JavaMail.zimbra@nod.at>
In-Reply-To: <20240329121629.316171-1-artem.chernyshev@red-soft.ru>
References: <20240329121629.316171-1-artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH] fs/jffs2: Fix NULL deref in jffs2_scan_dirty_space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: fs/jffs2: Fix NULL deref in jffs2_scan_dirty_space
Thread-Index: y5ad11duY8iSWWYoNLafHLQXdw07tQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Artem Chernyshev" <artem.chernyshev@red-soft.ru>
> An: "David Woodhouse" <dwmw2@infradead.org>, "richard" <richard@nod.at>
> CC: "Artem Chernyshev" <artem.chernyshev@red-soft.ru>, "linux-mtd" <linux=
-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
> Gesendet: Freitag, 29. M=C3=A4rz 2024 13:16:29
> Betreff: [PATCH] fs/jffs2: Fix NULL deref in jffs2_scan_dirty_space

> As was mentioned in 2ebf09c2, it is possible to get oops,
> when marking space dirty in scan, but no previous node exists
>=20
> It still can be in jffs2_link_node_ref() via deref jeb->last_node.
> Since all jffs2_scan_dirty_space() callers check value of a
> function, we can return error code safely.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
> fs/jffs2/nodelist.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
> index b86c78d178c6..6bebf1d64000 100644
> --- a/fs/jffs2/nodelist.c
> +++ b/fs/jffs2/nodelist.c
> @@ -669,8 +669,11 @@ int jffs2_scan_dirty_space(struct jffs2_sb_info *c, =
struct
> jffs2_eraseblock *jeb
> =09=09=09size, jeb->free_size, jeb->wasted_size);
> =09=09BUG();
> =09}
> +=09if (!jeb->last_node) {
> +=09=09return -EINVAL;
> +=09}

Did you test this change? I'm not so sure whether returning -EINVAL is
correct.

Thanks,
//richard

