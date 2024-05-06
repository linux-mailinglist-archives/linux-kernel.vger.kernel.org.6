Return-Path: <linux-kernel+bounces-169589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45558BCAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACAB1F22017
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21614263A;
	Mon,  6 May 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AzVWkB05"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C8142634
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988286; cv=none; b=eLB+o60VSCWtDpL99MkSDbNW0DNIwbAh2xHhmpfGbKDAUlVbcWU4ptPJ3teXAUaz6TkYlygVboW/RnonL15nyHORVdN6AI3Pmp9/DQUodrHxGrrL6HJQ8AEe2u01J7+Ct+Qoq7SVuxZMfpV8kmujC4YrJ2HYfb7A31UUZAZRrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988286; c=relaxed/simple;
	bh=wHyesn2c+4uPrRMN/hoEGLlstvq75J089aFyHbM6WtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQw7/2k3Of/zr3wHZ990wnX5kouNK+Idki9P7St6T5KJQuhm8iLgjrAJGJGV6mA8h30hslNBtOjMsKd3Tq7O4ZdI7wwIAYzzXv5xHu1jmM8VeQUdyXda5sofuU8XLqg/fS+uUyDpJgONbB7VC7xAna9ODrN9E8Qmcz8pRUHn944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=AzVWkB05; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714987741;
	bh=wHyesn2c+4uPrRMN/hoEGLlstvq75J089aFyHbM6WtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AzVWkB055SnLz5VppuwlXKdiusNLAQRaDUsZlW0hN9qA+J/nll4r5UkP8vlD14Z04
	 MwMz7ERbPa5/gsP09ELdQK0Zl4tI0Rz33njl7MQILs2KEGUR+rLvV/VrUWE5fqSucR
	 9sPzMjSV+1kYfDM8Cr5H6QXEUbco778n0GLzbQvg=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D7CAB66BDF;
	Mon,  6 May 2024 05:28:59 -0400 (EDT)
Message-ID: <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Update the flush cache policy
From: Xi Ruoyao <xry111@xry111.site>
To: Li Jun <lijun01@kylinos.cn>, chenhuacai@kernel.org, kernel@xen0n.name, 
	lvjianmin@loongson.cn, dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 17:28:58 +0800
In-Reply-To: <20240506092419.4109941-1-lijun01@kylinos.cn>
References: <20240506092419.4109941-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-06 at 17:24 +0800, Li Jun wrote:
> fix when LoongArch s3 resume, Can't find image information
>=20
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> ---
> =C2=A0arch/loongarch/mm/cache.c | 24 +++++++++++++++++++++++-
> =C2=A01 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
> index 6be04d36ca07..52872fa0e5d8 100644
> --- a/arch/loongarch/mm/cache.c
> +++ b/arch/loongarch/mm/cache.c
> @@ -63,6 +63,28 @@ static void flush_cache_leaf(unsigned int leaf)
> =C2=A0	} while (--nr_nodes > 0);
> =C2=A0}
> =C2=A0
> +static void flush_cache_last_level(unsigned int leaf)
> +{
> +	u64 addr;
> +	int i, j, nr_nodes, way_size;
> +	struct cache_desc *cdesc =3D current_cpu_data.cache_leaves +
> leaf;
> +
> +	nr_nodes =3D loongson_sysconf.nr_nodes;
> +
> +	addr =3D CSR_DMW1_BASE;
> +	iocsr_write32(0x1, 0x280);
> +	way_size =3D cdesc->sets * cdesc->linesz;
> +	do {
> +		for (i =3D 0; i < (cdesc->ways * 3); i++) {
> +			for (j =3D 0; j < (cdesc->sets); j++) {
> +				*(volatile u32 *)addr;

??? what does this line do?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

