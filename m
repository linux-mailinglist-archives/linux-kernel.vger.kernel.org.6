Return-Path: <linux-kernel+bounces-574424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2CA6E52A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A976175376
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E01F4626;
	Mon, 24 Mar 2025 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia/WUMF/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956B1F419C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850268; cv=none; b=QvN7kNlvv6OzZYvatTUDYxII1o9WDt8ySszksUCBhlW7h11AzirZl98CxfdVMcrBEKiWoqNwjDQzgCrj1yWdad+yVbgdizlv5thCMexF1oHuV0NhQWLR1SZUxZiAkC1sPcD1CZf/oht5r/nfM6/XlsZ04J2NZt08g1iWQJBbCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850268; c=relaxed/simple;
	bh=eiFdI0qMx/FEyNazgOqSyjJ5N/QguRbMM18kQO4jfoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMIGKOXcetpq0zL6GYy0pfmEzdygkEtsh+cflnWNwx49f9S5aRXsDZsAUGMwfzEiAV8jjplT2e+kT68hDrq34Ost/kYsW7kbFnNgqfmLfOV58Fx4rfo1T91KisFmoGqRo1soSOGiJG5UuM2ra+ZuA96jFv9VDCYssUmV9GBmwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia/WUMF/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912baafc58so3862227f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742850264; x=1743455064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx31Xuauv5lcovVQ5lpjl/sztBs81A6P9TQ0U/Jv4XM=;
        b=Ia/WUMF/kML3NDqqMjXh1PF39Bpjo/rEvFKKP7F2mNn/zHNVmH+Dg587/wHVNkj8bM
         u/xbTw0twLGe9Dy2xuyHnGmgXtApWrmwnqDeu8FmKssVC+digd5QM+ARI3+obMtnHEny
         ETTREiKkRAGfr7Iue2UfMg14q5YuaNEVr0PQy+K+MALShM5yptlnfJ0LbvAf3OB7WnOk
         pGxKr5HTBy5v2egKXxwH7hrCbF7V3eW6QzZhDqPzDfZ9ffz9BWQwRd9XKUDS1SkZVK7m
         SdQlRakTjkRkLeyYwfdtCHExJXGaN1hd2N9cyNXbBZQbTDiuXqsaMUbj4QqyYl0O1aIF
         Oc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850264; x=1743455064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx31Xuauv5lcovVQ5lpjl/sztBs81A6P9TQ0U/Jv4XM=;
        b=gwOkG4zlfeaG5zH6YJKWh1JDtncVWozB45YTv9/gJFt0cJ61tk2MAc4BcWjySHsUkR
         PDF8eG5si7/oikCMXp6LQEA25EjroMmERf+LiR/EYlZMTEZ6atCjVcfQR1smNA3aWLWy
         GwLuhW/iOzhz2eMtkc9xt+HLJUWgYC3q6B8XIF2FOD8G3fo+HkzUV1F5vMf290aOmW1z
         zzDKfXZNdV7ieGeVhSFAddWLU4Fro8FYs9AfEYwsykM6/Sew0/SoqRwvIRr/qIDVFLCr
         ADYtLtSzUDtRyBNzI9/gCjqjIajVKChMINAB5P/kDRKd7mdOZYQw4N7uOuPwONjCg8Pv
         Dnrg==
X-Forwarded-Encrypted: i=1; AJvYcCW6lnA5RJMln3zn0n4mT2EkZalQHP8+LlBz1CoLQo7HhC/1sY7e98rSlDPqG4hSuPi1yp/67X+xcUJtZh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcN3CH77FME6uuQK/RItoWESBug8i/d2Rtfz+xDmBZQOigaZc
	1Sedl2O9JK0lwjbPq8fOZYamGJnTNWuIUvedJkPA9jbByioHx8jdeC53MA==
X-Gm-Gg: ASbGncuVH1IdbM8dK2TlQ4R8Zy70JIVwRPSzYKOmOOyNnGwTjHezqWi5FH/L7mTARWI
	MrCiVLR5tml6c0KtW2mV6tFTJU4Z2d7+gNiP7MHkbW9iFQpYMPJPhYshG4V/cC3Vf1jshdcfIp6
	dwQJw9FENlOfW03nCBP+jJhebWp4flXyNWx5SAg+SdMtdtn626iLuyAI0Lw5EIIPFpJT+9sg810
	uXRSrfvJS14GWIXgeSpBg4CokfgGN0V6cDt6xBTaIYskCEX6gheGnUm2wBA6KcGBL4skEmmU0Cf
	d1Mz8dLw17vUkP9PpgDFVdfB50fDeEI21+7PaD+JdkgiKOFfcK8FNdTNjWgOdt9HQdgv9bXRLNM
	5R9+prOI=
X-Google-Smtp-Source: AGHT+IG2bGELzVJtzL6ZA05ImdjYkIcn3Fz+Pgv8cOihRj5p03OjBONfcto0Y2QnYq7gotvv/mShbQ==
X-Received: by 2002:a05:6000:4187:b0:390:dfa1:3448 with SMTP id ffacd0b85a97d-3997f938a97mr8491408f8f.43.1742850263373;
        Mon, 24 Mar 2025 14:04:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm12132016f8f.35.2025.03.24.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:04:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 21:04:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: shaopeijie@cestc.cn
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvmet: Replace sock_create with sock_create_kern
Message-ID: <20250324210421.526c1729@pumpkin>
In-Reply-To: <20250324031708.1687164-1-shaopeijie@cestc.cn>
References: <20250324031708.1687164-1-shaopeijie@cestc.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:17:08 +0800
shaopeijie@cestc.cn wrote:

> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> Replacing sock_create() with sock_create_kern()
> changes the socket object's label to kernel_t,
> thereby bypassing unnecessary SELinux permission
> checks. It also helps to avoid copy and paste bugs.

Does sock_create_kern() hold a reference on the namespace?
It hadn't used to and sock_create() will take one.

	David

> 
> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
> ---
>  drivers/nvme/target/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4f9cac8a5abe..216afacc8179 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2049,7 +2049,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
>  	if (port->nport->inline_data_size < 0)
>  		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
>  
> -	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
> +	ret = sock_create_kern(current->nsproxy->net_ns,
> +				port->addr.ss_family, SOCK_STREAM,
>  				IPPROTO_TCP, &port->sock);
>  	if (ret) {
>  		pr_err("failed to create a socket\n");


