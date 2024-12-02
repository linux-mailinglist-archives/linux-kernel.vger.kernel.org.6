Return-Path: <linux-kernel+bounces-428038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86D9E094D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718B1166952
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A21D95A3;
	Mon,  2 Dec 2024 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="bs92t4zt"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D8163A97
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158609; cv=none; b=qQ5h2p7ztglIv+l8OKKbU6gi295TrRlDGDpuyAqq7UCdQxCCN1rnfebIn7A+vCXAR0dZLSvxWenHX6ZVfaQmQ4pPV+/AnqoeXElzdU9+sOcgyefouml7IaXatCU1lK1dQw3KrGK9mkyrjHGZEGQFpy7MoaYbasGewv8F0hHFoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158609; c=relaxed/simple;
	bh=emGAN1+EMUf28igJw06VauS8iTUY99X3hp2KRjFEqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svjq5+GeBzMjbSscJRnAvB7C2wNCGcTbhOq9hv9SKREWDmvurKCt8SXsuEqWC2yPT0VcbS9GFaSlcWB8BQMbVsn838rKcelqGe0XnEfYBRj0VEY5gqt/fJkNdKYd6bWpqLKvFAUSVUeLXIvfl0AJfpDwzZRG3zpZJObY1FHxp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=bs92t4zt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2154e3af730so22964475ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1733158607; x=1733763407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w3OFyvhX2S0fS/HLJsRvLxU0HED4I5J8Q32eP1dhM90=;
        b=bs92t4ztQKC7IF2JbciQeyunRkSVxSAdnI6zrqIaEs6tA3jwkxfbBvKJrHNyQ+iSWy
         Hihfoxn4sdfK8eUB3whKURPkIaWqfsXkujxdGfPdsxPMOXRGaPrNXtz+zx1c+iWLY+b9
         NmJdfism+v9SSEKnb7656R+4fsfHh0724GnTo6SIM8MDIMJQr8/MrKV/Hj9gviGz8F0k
         jpNV7+wHeWBvmL8AUte38/RNieMBr5jDjPCGxlUsYlm1LZMVj2W9f4ZPh0Y5ZrvvY3Se
         9f1Qahm4TjkH3AMZcjf1FoHZP8wsCWT9N7tkg0OJfWEJSv3MQQj4i7YmEn0f0NzFGoB8
         WO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158607; x=1733763407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3OFyvhX2S0fS/HLJsRvLxU0HED4I5J8Q32eP1dhM90=;
        b=N5o/hHhq+rbvM+IuPv1i8dwDF9A7H1drKF3XyNScnWITOWJPNAmqX3YiBOwayL59si
         HC19ljX2oGd06x5L2b8R1bamI2ssXizrydFnZvQroPBBPvqKQjtpEKBp+hk/4W+v3KYZ
         Sph4x9yIgh0yjBN+zlERFt5rIccoo1E0mbfQogBns8ZTlNWuyXfh14/cMaSPa6Q53Efm
         nmy+JFywVFvGJE1rqjq+pBPChCwNDdWe6rJUvzLlOlZ1CKF916gwSTrgtkj4v+GbIa0r
         8uRykyEqHghIPVchkso5XpKbP1TMulm3ay/oAy/A8DLhaMAJ1moNeHAfQ9G+kggaHSLA
         Vg7A==
X-Forwarded-Encrypted: i=1; AJvYcCVX7wOI/fd0Alz5ovGhl0cEGdixiHFt/n3oeCY80cC5qSJXwKDBr8+M92EP3yOaQ78QBRNtiqJgmENBf6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pZlxxU4iNMfAuYjpT8XHwnRCyvoU/XqNwpZrg+W10ke1Nc7x
	NnkiyLMEKm6dwS5maEXKGYSlePugSIQAy9XqV2JgiMW502wirX8eStcpCCnLPCA=
X-Gm-Gg: ASbGncvntTfKbFfiYh6rLFVGOg9yp10Qf1iO6GkpwCx3OYYLBIz3Sz1dNIQZICvYe/u
	BsTP/tc5YEc6DUwCi/c3lTlTRZI1KwaT30RlD0r2l7GU1/AQ50/mJi2Dqi8RDfFjKdCMUbeJuq6
	yZXjgq5fNrh5XkFbKdI3aKie0lHGS32G3GZVeY2MMUXu0H+nFCV0IUwnpQaxeFqYOgjFQFzBYmm
	I2UQY2czri1m/8VhSwzNDAOM6fpUmFvljT4Zco8hAcFDImIzYWwP9uevSSdIF6CGwBzMrVK5SjX
	GwjZDAi50HPXlgOqKxU=
X-Google-Smtp-Source: AGHT+IF/WXdHEWTzcZGmDX/TQvBlkOpoaDr/uvYAvANDEQg3/W0HGGYEL6JGyv2MgYdrerYUgVZgnA==
X-Received: by 2002:a17:902:d4c5:b0:215:7f94:2d0 with SMTP id d9443c01a7336-2157f9408e0mr106700955ad.29.1733158607440;
        Mon, 02 Dec 2024 08:56:47 -0800 (PST)
Received: from mozart.vkv.me (192-184-160-110.fiber.dynamic.sonic.net. [192.184.160.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f165sm8700418b3a.41.2024.12.02.08.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:56:46 -0800 (PST)
Date: Mon, 2 Dec 2024 08:56:45 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] pps: fix a UAF and clean up code
Message-ID: <Z03mzf2R925FVEQm@mozart.vkv.me>
References: <20241202163451.1442566-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202163451.1442566-1-mschmidt@redhat.com>

On Monday 12/02 at 17:34 +0100, Michal Schmidt wrote:
> The 1st patch fixes a UAF bug. The fix is quite minimal, although a bit
> ugly. The rest of the series are cleanups in the area.

Hi Michal,

I've also been poking at this, I've sent some patches recently:

    https://lore.kernel.org/all/a17975fd5ae99385791929e563f72564edbcf28f.1731383727.git.calvin@wbinvd.org/

The major difference is that I used __register_chrdev() and removed the
embedded cdev too. I think that is cleaner, what do you think?

Thanks,
Calvin

> Michal Schmidt (6):
>   pps: fix cdev use-after-free
>   pps: simplify pps_idr_lock locking
>   pps: use scoped_guard for pps_idr_lock
>   pps: print error in both cdev and dev error paths in
>     pps_register_cdev()
>   pps: embed "dev" in the pps_device
>   pps: use cdev_device_add()
> 
>  drivers/pps/clients/pps-gpio.c    |  2 +-
>  drivers/pps/clients/pps-ldisc.c   |  6 +-
>  drivers/pps/clients/pps_parport.c |  4 +-
>  drivers/pps/kapi.c                | 10 ++--
>  drivers/pps/pps.c                 | 94 +++++++++++++------------------
>  include/linux/pps_kernel.h        |  2 +-
>  6 files changed, 50 insertions(+), 68 deletions(-)
> 
> 
> base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
> -- 
> 2.47.0
> 

