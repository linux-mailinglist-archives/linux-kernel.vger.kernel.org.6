Return-Path: <linux-kernel+bounces-311468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB1968992
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6633E1F236A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB019F10C;
	Mon,  2 Sep 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="Pz+Rc1H6"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8819F104
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286436; cv=none; b=MJLZIyxGPq6HxjObAmUmj2CnkMMJCGPwZ+qtqIzZzZmZAD6T14GasIRe3iI+T5kalPt3e0GnonW/rfY58qRPijQjReErUbz3Q2ZV0JoGBbinswVnHmDajmMEMCID6C6C9Y5imEXv6WMczGedbYwp3sKdjDjZFGzP3ZbdGyaxuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286436; c=relaxed/simple;
	bh=uGPV9tAR75BtaCLwmnuCOAw4KGDFFnJEqjWSWmwE5Gs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBH4hDvHTaZwn3eAHkegzJUI5oUY74GeG1JbrG8k/cP/KW13xwKHPpgXo2IGfu4tNycGeA+amaXFhcmkiD4frcLxCFatFF9d1Ii3AFv4DhBk1oWmZNynR9T/72ZlvYQQ0XFRGEikkaLlt92MG8XUIBPRJfAZiSUJCrsPHgxUdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=Pz+Rc1H6; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1725286429; x=1725545629;
	bh=uGPV9tAR75BtaCLwmnuCOAw4KGDFFnJEqjWSWmwE5Gs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Pz+Rc1H6l8xE+LNq1VflhrnR6hZy/Zy65dlMYNFu0Q8+2bXbIZ8uwxqaYPoqjRD18
	 eHNaNmifT8ruB1nWzp4M976xXzqEIpjnI/i8sg906lFytRLJH5mLzDehjT3c5dNfeH
	 olHtHEN6vipEHN+87gDxRj1iVr3lLiZVKbig94IjnwUcfcYczG2oPfBkF2OFiAy7pO
	 PsHkX1Wx1+KZeSTOogz0TkTPux4oi5KkSfScEeXHulppwGMkWDrNXzeiHZNbRBsVwi
	 SAxKg2a8G+fqZcYOA0Q4/R+0sOE95H+JTuSkM6W1mHWMUuMRxmcWsm+nhDRIkWr0Qe
	 JWO4oYs9ILFfg==
Date: Mon, 02 Sep 2024 14:13:43 +0000
To: Andrew Morton <akpm@linux-foundation.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation/cgroup-v2: clarify that zswap.writeback is ignored if zswap is disabled
Message-ID: <d305db940e461c92a618dd26224144a5105274b3.camel@yhndnzj.com>
In-Reply-To: <20240823162506.12117-3-me@yhndnzj.com>
References: <20240823162506.12117-1-me@yhndnzj.com> <20240823162506.12117-3-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 1b059982da0bd1a3cba5619155b6e8cc6ca71b5c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> As discussed in [1], zswap-related settings natually
> lose their effect when zswap is disabled, specifically
> zswap.writeback here. Be explicit about this behavior.
>=20
> [1]
> https://lore.kernel.org/linux-kernel/CAKEwX=3DMhbwhh-=3DxxCU-RjMXS_n=3DRp=
V3Gtznb2m_3JgL+jzz++g@mail.gmail.com/
>=20
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
>=20
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> ---
> =C2=A0Documentation/admin-guide/cgroup-v2.rst | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst
> b/Documentation/admin-guide/cgroup-v2.rst
> index 95c18bc17083..a1723e402596 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1731,6 +1731,8 @@ The following nested keys are defined.
> =C2=A0
> =C2=A0=09Note that this is subtly different from setting
> memory.swap.max to
> =C2=A0=090, as it still allows for pages to be written to the zswap
> pool.
> +=09This setting has no effect if zswap is disabled, and
> swapping
> +=09would be allowed unless memory.swap.max is set to 0.
> =C2=A0
> =C2=A0=C2=A0 memory.pressure
> =C2=A0=09A read-only nested-keyed file.

Hmm, Andrew, it seems that the commit messages of this and the previous
patch are somehow reversed/mismatched? [1][2] Could you please confirm
and fix it?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
unstable&id=3Deef275964326760bb55803b167854981cab97e55
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
unstable&id=3D42c3628a37400c2bc4199b9f8423be701646d4e0


