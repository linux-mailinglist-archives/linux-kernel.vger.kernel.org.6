Return-Path: <linux-kernel+bounces-170835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08C8BDCAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EF1C22F94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DB13C677;
	Tue,  7 May 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="eFfL7MIw"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB313BAE9
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068096; cv=none; b=ClRJ0mq3jVjqmsn3CuqWQeo7xIC9IGqWZ0DcBzHd7Jw3IiQ0eVMk2UJvIlb3ja/jSN5XYJI1B1EyX51t4njVPo6Z5RvmV0LOmu/I9fp3X71sTuWEMYEJl25xKjlKU2jd7Bd4I1/cdL55+QnMZ12mf4anQEuDtJeKAkrjaji5xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068096; c=relaxed/simple;
	bh=QpWK8tGEk5ck2XW/s8yztEHz7kBviwnCEcPgX3pHC6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBlJVwDqEHgVEXWr2zZ+y5B36eKzLVP40ZY0b8VyGfXNB5YlF1Cc46+BEFDOKU4IAHnYokh2oWZ5SV+pxOjhzuEHbuGSXKdozODektfm6ujwYg9MdMidYzhNeGKJJkE4CDKxkKkGOtCAL3z7ZlwhvKT3TrOlDzEooay3j/EomVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=eFfL7MIw; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1715068091;
	bh=QpWK8tGEk5ck2XW/s8yztEHz7kBviwnCEcPgX3pHC6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eFfL7MIwrp2A/VxUjep4YMKQVqF8O3SN3tqBicAghYfA6B05bOFPYzKluJaCEd/ZG
	 2YmpET+UOQ7qg9OYJ1+b87/+2ZtqDbLoA6yngIJdC1o4Kf92FJEx96Ki3d0dZt7RAw
	 KqQVlAwJcfDXFf5wxPdFgFuo14FBCcuG+N775SNg=
Received: from [192.168.124.11] (unknown [113.200.174.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 528FC673F0;
	Tue,  7 May 2024 03:48:09 -0400 (EDT)
Message-ID: <d41a1f6e2940e9747f9efcb3721646186940da03.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Update the flush cache policy
From: Xi Ruoyao <xry111@xry111.site>
To: lijun <lijun01@kylinos.cn>, chenhuacai@kernel.org, kernel@xen0n.name, 
	lvjianmin@loongson.cn, dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 07 May 2024 15:48:05 +0800
In-Reply-To: <18342368-ce79-9820-26be-01834876fc9e@kylinos.cn>
References: <20240506092419.4109941-1-lijun01@kylinos.cn>
	 <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
	 <cbb24599-8b40-cd27-6ce7-215476c0ddf4@kylinos.cn>
	 <cbd6ed9d5be1d7112d69117a72e0cb0081f9b64b.camel@xry111.site>
	 <8809f5a7-de6e-0794-feab-726c26f87344@kylinos.cn>
	 <cf5df629b88fe38ae04cfa5714b9de2a44792704.camel@xry111.site>
	 <18342368-ce79-9820-26be-01834876fc9e@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 14:38 +0800, lijun wrote:
> I guess, final the value of addr is not important, just all of addr must=
=20
> read once is very important,
>=20
> so use two 'for()' and 'volatile' to flush all of addr=C2=A0 's cache,=
=20
> exactly as the name of the function is
>=20
> "flush_cache_last_level".

AFAIK do a read does not mean flushing the cache.  The cacop instruction
is intended to do the cache flushing.

So why the cacop instruction in flush_cache_leaf is not enough to flush
it?  Is there something wrong in flush_cache_leaf?  It currently reads:

static void flush_cache_leaf(unsigned int leaf)
{
    int i, j, nr_nodes;
    uint64_t addr =3D CSR_DMW0_BASE;
    struct cache_desc *cdesc =3D current_cpu_data.cache_leaves + leaf;

    nr_nodes =3D cache_private(cdesc) ? 1 : loongson_sysconf.nr_nodes;

    do {
        for (i =3D 0; i < cdesc->sets; i++) {
            for (j =3D 0; j < cdesc->ways; j++) {
                flush_cache_line(leaf, addr);
                addr++;
            }

            addr -=3D cdesc->ways;
            addr +=3D cdesc->linesz;
        }
        addr +=3D (1ULL << NODE_ADDRSPACE_SHIFT);
    } while (--nr_nodes > 0);=20
}

There is something bizarre: the flush_cache_line function uses the cacop
instruction in the Index Invalidate / Invalidate and Writeback mode, and
if I read the LoongArch manual correctly in this mode CSR_DMW0_BASE and
1ULL << NODE_ADDRSPACE_SHIFT are just ignored.

Is this something undocumented or flush_cache_leaf is just "incorrect"?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

