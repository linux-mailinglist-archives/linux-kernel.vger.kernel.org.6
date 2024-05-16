Return-Path: <linux-kernel+bounces-180931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022AD8C750E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB2D1F24679
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879C1459E3;
	Thu, 16 May 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qOj+Pk4m"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0701145350
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858170; cv=none; b=U+LGUsaIgoo9Y7djkabSxvrfLYpmWgk1dCSq4zURd/qvVSvGouZDKZ8FdVEjkpGygjZT4KHOlTxcg2JnTL92NzEO5NqGCNaXOniYsjT8OXWL/Mr1DLypcBUMm2MdPDEbGfVVDnixGOHVxxfc4laESKHGrJC2BAHY5sYeD44ybN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858170; c=relaxed/simple;
	bh=OB7JAvMeIimxmVIdIIm0ayzHuZaHOX29FQ00F2p1ZIA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=TDq2999vNg6+3JQvgDkSCaUOdM4tnJic6IeIMLlY6wp4SC4iPU/dB08d0MWH4rs/Kz4EQhKNFFZRsA/iMzUuU9fNOyW3RYbIjEALCaz9z8xspYghxt5zGcbeZc3Li6q+R0XfjhNo6uaAik8h/rXSsTqR4flEWdpR2e+ajwMJnck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qOj+Pk4m; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: wangkefeng.wang@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715858166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLeSRS3quX4ZlkgzdAPYMzk5VTg8+XdQRte0NfGmRLA=;
	b=qOj+Pk4mcfUGWn7xkvKGJBmWnGR3HzgqOzbDB+kKCA5fVuBnOHvvOMmroddBtoDwCYqGvP
	wdpnWeRBsj9aPvkAz2QuNiOc5Pq8wZzDmCGJSl3xuGlOo4Cu5NA4AqO6U2ZaKoaIEvTbXz
	eJJ5KE6OxxCj5kktHMv1L81heiVJwlg=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 May 2024 11:16:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e41ea9022c217bb6aed5a8a4b8375a62878c9c8b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/cma: get nid from physical address
To: "Kefeng Wang" <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <1d38aa26-cd2f-4330-9dcc-6c379cecb83b@huawei.com>
References: <20240516091701.1527002-1-yajun.deng@linux.dev>
 <1d38aa26-cd2f-4330-9dcc-6c379cecb83b@huawei.com>
X-Migadu-Flow: FLOW_OUT

May 16, 2024 at 6:03 PM, "Kefeng Wang" <wangkefeng.wang@huawei.com> wrote=
:



>=20
>=20On 2024/5/16 17:17, Yajun Deng wrote:
>=20
>=20>=20
>=20> The nid passed to cma_declare_contiguous_nid() may be NUMA_NO_NODE,
> >=20
>=20>  which is not the actual nid. To get the correct nid, we can get th=
e nid
> >=20
>=20>  from physical address.
> >=20
>=20
> Please check
>=20
>=20https://lore.kernel.org/linux-riscv/47437c2b-5946-41c6-ad1b-cc03329eb=
230@huawei.com/
>=20

Okay,=20thanks!
> >=20
>=20> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  mm/cma.c | 1 +
> >=20
>=20>  1 file changed, 1 insertion(+)
> >=20
>=20>  diff --git a/mm/cma.c b/mm/cma.c
> >=20
>=20>  index 3e9724716bad..be6cdde32944 100644
> >=20
>=20>  --- a/mm/cma.c
> >=20
>=20>  +++ b/mm/cma.c
> >=20
>=20>  @@ -361,6 +361,7 @@ int __init cma_declare_contiguous_nid(phys_add=
r_t base,
> >=20
>=20>  kmemleak_ignore_phys(addr);
> >=20
>=20>  base =3D addr;
> >=20
>=20>  }
> >=20
>=20>  + nid =3D early_pfn_to_nid(PHYS_PFN(base));
> >=20
>=20>  > ret =3D cma_init_reserved_mem(base, size, order_per_bit, name, r=
es_cma);
> >=20
>=20>  if (ret)
> >
>

