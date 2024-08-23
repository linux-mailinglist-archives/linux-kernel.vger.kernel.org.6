Return-Path: <linux-kernel+bounces-298508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADCA95C833
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04921F2255D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0B7144D0A;
	Fri, 23 Aug 2024 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lT8QL2le"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1F32C85
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402384; cv=none; b=spnQ9WsWjEWql7Fnk4R2uDjHLp6SdMhQXAZIn1Xl6UXjnyaDJ7HLPsT3W4AtrVIQusYNxhKhFiKL0kQXQqLKZ1wR8npGsaOrTeHVISRt3uajjRGdTHGaqWZZYgqBQ4pn3/qrBxyyV2ixzksKWoccbD9ccS7nBjdEIPy94AH6lOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402384; c=relaxed/simple;
	bh=D8z43P6jLVu3q7dcPfqbOyjqH9/C0Mr3kx1TPvlCjpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIPapAUQQH+lBHnGcxN09O/oUayeRo5bXsP+xWGKKhqqnqKnB6RevFgD6LRY67YJgPTUlm4Se3MfpXY80nJcPeQx8vhfHT+++cYwJtiiTId5/aW0KqYeCFjD/Lam8+lLADa3vzQoiI2jXy2EwYu+TC8U9atwPbSD7JzgbN1X/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lT8QL2le; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1451A20004;
	Fri, 23 Aug 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724402380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT8K3DazghTsHSMYf5ANJ6HHOnB18G++J6IAvYLGbdM=;
	b=lT8QL2lecsRe6uvti1+hnDsYCmL8Gh0qnxzpdZW0q8n0jQjOYgEN3RA+yVdXOgq2zhRoys
	Sb1YcrwYl3YFnPKL1FIK6+6BeTFIuQaE7n8ILoYlrxMJMRNpHcdqpJ6BUyZlw9AS0srn+9
	o39tQWKI9Iwlp0jcDVo/Og08AIfGaooYYBBKxbQY143RrXT8gQthzM44zmcG5rqSTECgq2
	/KtPaUVSvAYNZ2G4BkZBMNkfTPgHMs3TBG5qr4gt6cNgJmYPUQzflZpcn+ZL4n0GhuFDU9
	3wahTKDqoZcRcvYoIKNPjM9Y9uRhEujP8ayYHo0tgfI4G0zvw9CBXAJrHNKf/Q==
Date: Fri, 23 Aug 2024 10:39:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mtd:concat:Switch to use kmemdup_array()
Message-ID: <20240823103938.4fad7ca3@xps-13>
In-Reply-To: <20240823082535.3419187-1-yanzhen@vivo.com>
References: <20240823082535.3419187-1-yanzhen@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Yan,

yanzhen@vivo.com wrote on Fri, 23 Aug 2024 16:25:35 +0800:

> When we are allocating an array,
> using kmemdup_array() is more appropriate=20
> and makes auditing the code easier.

Why do you cap your lines at the insane limit of 40 chars?

Also you're missing spaces in the title after the ':'

s/Switch to use/Switch to/?

>=20
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/mtd/mtdconcat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index 193428de6a4b..f56f44aa8625 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -204,7 +204,7 @@ concat_writev(struct mtd_info *mtd, const struct kvec=
 *vecs,
>  	}
> =20
>  	/* make a copy of vecs */
> -	vecs_copy =3D kmemdup(vecs, sizeof(struct kvec) * count, GFP_KERNEL);
> +	vecs_copy =3D kmemdup_array(vecs, count, sizeof(struct kvec), GFP_KERNE=
L);
>  	if (!vecs_copy)
>  		return -ENOMEM;
> =20

Thanks,
Miqu=C3=A8l

