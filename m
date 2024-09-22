Return-Path: <linux-kernel+bounces-335140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3697E1BE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABCAB20D8E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1BA5F;
	Sun, 22 Sep 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy//mgoy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F7A59
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727009671; cv=none; b=VIXwPon5+MkTKVwBq2TDVoXe51BfaST/yIbGho01o6CepzQGngpI0OKu9YTamOqh2qhx5LF66LDDcOeQ7kgO5wJMIr6QSCLBsy3jZn/7NqR0Vs0bb+ZJ9fSDr3ZtNxE5zQjGrhoCyV0+X0emO3iSq5zDlTx1LyK7GoKFDz7J6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727009671; c=relaxed/simple;
	bh=9hTuPr+B3KHIKAelhdUk9LKb6pM45k0P8KmcpTyBYr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmwktS5nDtKRfUNi7QwZf/2U+lFJ/AvH0ZV02IJjnE1k17kNODVEC+xNsy3HnCy0IyAnLVYfeHhqgYYD/XG0Zm1qEHgNExtEruacgnb6h4y5KE0WhouXSIfwvjGSZJn/pKTQZg4dcqy6Ok7Zvubg2XLEiK2CZ1F/1y+fhUafhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy//mgoy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso44053935e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727009667; x=1727614467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V9+EtBR3azzcqkeGxUhNS4gUNER4YDA+9BTF7UuDVDg=;
        b=Oy//mgoyfjRf29W3pZVGs7ercBDtE/zIChLy0CQbXY+nSeF8qyoTU8B0mKLBEWq+rP
         I+Thz2Eu5vRYg4WM/FzVCY51C0VzJMjFq2OBaTk44HKBWzWtO1sCW7RoLCUOafgy0ysR
         wvhNDBdZ0XISPjeEqg+C5+F40DCCOwaQdCHQan39rqk8D3sKthFGgIghQ0UiQwS5AUjn
         G+/C36rInhlR0CAxjY59h4CgK63exN5J4SbaLM8mVqAProVa7MqPXUtzayP1c2TSD/hZ
         trVZvzNsR4N+LbjpnY77V/8FCdnTbHVkuTNdlRvfIYMyvholTfG9CvTtmcC5Y/Che3vS
         86fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727009667; x=1727614467;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9+EtBR3azzcqkeGxUhNS4gUNER4YDA+9BTF7UuDVDg=;
        b=TiodPPX4aJ1eLHK4fMgSqksCvT/7TuFkw8855ZBpY7mL1U+fD+c5AQpjuzi456HmeV
         VgK+6Y92knesJNDhx8y8syS0PHoSw32+1XuZirbyn2LjxnfoR3d5Z0KnVB0GTVYIOcGE
         o/s/ZlJWitd6uEGYM42QovV7F7ePe3cq9xQnGqVlxAHCmCsCIL6g9BjoYSHaK5D1CxuL
         yTv+hDtEl24r2o9HJYZ7EPyBU2DZiYG+UpjNlnueDwVqeKhEgM58YR0bpqtZ/xxlSJhx
         JA8C8V7XOwW3Ie2iv6l91V/varwRCOboXgUsUp6bvkXNuhXnOfjMzY4oLFf/Hh8/QrNZ
         7xTA==
X-Gm-Message-State: AOJu0YwdCfjW1BvwsaSzqQgKv8bxDRDgOKAMdaPjmXXhCn4YFRo4u4eG
	uAR82eqy7oLlRcu1kDSBqORHesiHeB97LKOvBi+i6vngDKRVGKZS
X-Google-Smtp-Source: AGHT+IF4D1kWTYZjKNx8py68FOu1UyJ8Wf/u8gPHCfJTfC6kxaEL9TAyMJ5BZUL3jusB7/scEDTIFg==
X-Received: by 2002:a05:600c:350a:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-42e7add6bb0mr87514665e9.29.1727009667039;
        Sun, 22 Sep 2024 05:54:27 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754c5404sm100031895e9.39.2024.09.22.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 05:54:26 -0700 (PDT)
Message-ID: <194f2e20d40a496f9e9f23392ee911900a7c30b7.camel@gmail.com>
Subject: Re: [PATCH] net: cirrus: use u8 for addr to calm down sparse
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>, Arnd Bergmann
 <arnd@arndb.de>,  soc@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Sun, 22 Sep 2024 14:54:50 +0200
In-Reply-To: <20240922065212.7483-1-nikita.shubin@maquefel.me>
References: <20240922065212.7483-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nikita!

On Sun, 2024-09-22 at 09:52 +0300, Nikita Shubin wrote:
> ep93xx_eth.c:805:40: sparse: sparse: incorrect type in argument 2
> 				=C2=A0=C2=A0=C2=A0=C2=A0 (different address spaces)
> ep93xx_eth.c:805:40: sparse: expected unsigned char const [usertype] *add=
r
> ep93xx_eth.c:805:40: sparse: got void [noderef] __iomem *
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409212354.9CiUem7B-lkp@i=
ntel.com/
> Fixes: 858555bb5598 ("net: cirrus: add DT support for Cirrus EP93xx")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/net/ethernet/cirrus/ep93xx_eth.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ether=
net/cirrus/ep93xx_eth.c
> index 2523d9c9d1b8..c2007cd86416 100644
> --- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
> +++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> @@ -771,6 +771,7 @@ static int ep93xx_eth_probe(struct platform_device *p=
dev)
> =C2=A0	struct resource *mem;
> =C2=A0	void __iomem *base_addr;
> =C2=A0	struct device_node *np;
> +	u8 addr[ETH_ALEN];
> =C2=A0	u32 phy_id;
> =C2=A0	int irq;
> =C2=A0	int err;
> @@ -802,7 +803,8 @@ static int ep93xx_eth_probe(struct platform_device *p=
dev)
> =C2=A0		goto err_out;
> =C2=A0	}
> =C2=A0
> -	eth_hw_addr_set(dev, base_addr + 0x50);
> +	memcpy_fromio(addr, base_addr + 0x50, ETH_ALEN);
> +	eth_hw_addr_set(dev, addr);
> =C2=A0	dev->ethtool_ops =3D &ep93xx_ethtool_ops;
> =C2=A0	dev->netdev_ops =3D &ep93xx_netdev_ops;
> =C2=A0	dev->features |=3D NETIF_F_SG | NETIF_F_HW_CSUM;

--=20
Alexander Sverdlin.


