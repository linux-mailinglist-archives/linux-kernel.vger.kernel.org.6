Return-Path: <linux-kernel+bounces-429887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA29E2829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C002284BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B071F76CF;
	Tue,  3 Dec 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDjUjZpC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5381F7577
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244708; cv=none; b=oZekD+khnKeENkDBTxgWvmVFpS2c5BKXiFeH5ccGPIP2mN4TY3dZzCdLtdrNqg7KSviagjU5eupYL8vnFSZLBLTeG9gb+MERQO9e++zTIsAi1slObQE95HBjH1YFYZEV/HsVbu/3G60/wf+wNiHV+YHIfd7BUxveVfIvIk7SEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244708; c=relaxed/simple;
	bh=a2ngSfIWXO3GXq+7S83SPUVvD24EqXEnYhBFHVBsugY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X103BWDu349kttiyM9M1ZbaITEVGcaeieqzAfOorgMUCE1q60z8489nF9Xu86y6DFikdkvQXfLB0xQcfRVj4dFEcI8mbyc53L+JV/u83sqoe/J34J6SjWUfjHudvkaK+XhbrsyPY3ooaREWPU0+XqlCqJGQPDaCuHcum7N5uTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDjUjZpC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733244705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9lt53vsuFinYfQPPMtO0BSGgjTyTuTC1kRLkpQGt78=;
	b=JDjUjZpCo/gM5H4o0JTgcIqgB5eAVWD+NBoWa+OCaYBA2acXf9Ux8oF8NQBOhcKG64nGTC
	ifG5pTFBiy4gZgdvptV+R/pa4ZbAFnmF+GX6nHGrjcjaGBkndQCk46iXEEuB6b97SKfmVE
	3JyWrBZ8kgWz2tZgYR5gswJ6WYbMumU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-QjccPDO0NU2axXe93qgdYQ-1; Tue, 03 Dec 2024 11:51:44 -0500
X-MC-Unique: QjccPDO0NU2axXe93qgdYQ-1
X-Mimecast-MFC-AGG-ID: QjccPDO0NU2axXe93qgdYQ
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5f20bd95c54so668238eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733244704; x=1733849504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9lt53vsuFinYfQPPMtO0BSGgjTyTuTC1kRLkpQGt78=;
        b=KS3m6tWkdKd+QRiQxlFkdgFiXKcM1YYR69PG34CSgOh5owq2/JRpFKlIgnRiIOLwQO
         mO6Wjl3JDHVdzITgMBH15OgGQnoQVBco/oPN8JyOVL+80HJeCM+HfQXGQKylW+Og1VVk
         dlizALSkwaalHp0BrzkBAN1jeO6mvPgtIMAJnDfPVp+1rMW4OYWbkaM+CBfiGbKi/bIE
         ZKLA422026xPZEHdOf1bHE5QZLHd4wvWxc2g5dB67htqHUw2dhaM1uoOnJn8n8LN9j3E
         5TLx2XnM82u1vXgLrfeDQlwU+0TtuRcSnNImnN5YtHJ2LwurLIInQrrlGXGPc6tcPywL
         KpMg==
X-Forwarded-Encrypted: i=1; AJvYcCX/2p1p2CkHAsh0mHv10r4m4t4f+5tBx3vG2D0jFicO6n+APF19dT9gx6WX1ZNmX/xDMLwIH3eKVhlJGfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/qmHkOph2uUDt/GIGQs66/RlF0+rDGrRSL1mMqcXrcYFiL8B
	Hf1q0C9jqAsl9x1VzNM4KL2oG3br/pzSM6h7KEsvQwuvV051ab/LxVPGWA4vWwBlQXuEegKQUkg
	ODB9ZNtNd0WYxy0UYDwyFesL6Er1nFamkE3z2OKtGQthkm5zLrJ9CLlA0wPCPVoqDhSRbuo8HHB
	ZiqYJpFuuPHOispzWEdXQlTifhWZDnkjf+W/gC
X-Gm-Gg: ASbGncvFVRv/HDcumh1lG4U77H2C043oDlpARqfKKyYPZr3EvRiel8dmU01eYfucupN
	jZv7AfKyMucLAfCWBoo7kogum0BOk1A==
X-Received: by 2002:a05:6870:b526:b0:29a:ea3b:a307 with SMTP id 586e51a60fabf-29e88852dedmr743623fac.10.1733244704082;
        Tue, 03 Dec 2024 08:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzceRUoX3DvEQufLmwTQCJTEwNRUOUtXnGjhdEjvUwvKuNpVXgMIpmPswi4qlPBGvFF8FPGxubxqQ5PeUM7BE=
X-Received: by 2002:a05:6870:b526:b0:29a:ea3b:a307 with SMTP id
 586e51a60fabf-29e88852dedmr743612fac.10.1733244703832; Tue, 03 Dec 2024
 08:51:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615093433.3659829-1-s-vadapalli@ti.com>
In-Reply-To: <20240615093433.3659829-1-s-vadapalli@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 3 Dec 2024 17:51:33 +0100
Message-ID: <CALE0LRssDPn2UAscbCdx2UsO3cQYuYHpBsdGxEWje9LCf4Hr4w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Enable PCIe Multilink and USB support in Cadence
 Torrent SERDES driver
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, kishon@kernel.org, sjakhade@cadence.com, 
	rogerq@kernel.org, thomas.richard@bootlin.com, robh@kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siddharth,

On Sat, Jun 15, 2024 at 11:35=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@t=
i.com> wrote:
>
> Hello,
>
> This series adds support for standalone PCIe Multilink configuration
> along with the support for PCIe Multilink + USB configuration in the
> Torrent SERDES driver.
>
> Series is based on linux-next tagged next-20240613.
>

Seems that these series didn't land, I think they are still required
for the AM69-SK board? There is any chance that it could be rebased
and resend?

Thanks,
  Enric

> Regards,
> Siddharth.
>
> Swapnil Jakhade (2):
>   phy: cadence-torrent: Add PCIe multilink configuration for 100MHz
>     refclk
>   phy: cadence-torrent: Add PCIe multilink + USB with same SSC register
>     config for 100 MHz refclk
>
>  drivers/phy/cadence/phy-cadence-torrent.c | 276 ++++++++++++++++++++--
>  1 file changed, 257 insertions(+), 19 deletions(-)
>
> --
> 2.40.1
>
>


