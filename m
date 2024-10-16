Return-Path: <linux-kernel+bounces-368315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C89A0E26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0277D1F23A53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9320E02F;
	Wed, 16 Oct 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYYv1lK+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5F20E035
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092389; cv=none; b=GAOxAeZgBdCsrRQYEd3bTLDJHMQ7JV/nSH83s7xv90dArdswpQDiaWeFZ5HDVZGc6JaCB4iG8iLffQE9d7ZM6R20jyqZcddwU+pBH1Iz+wFdjvx4NnhYuRtWZ97o7/csQbFti08DDUv7eZdvOFpURVPcq4IjnH3hmF/WaLRWaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092389; c=relaxed/simple;
	bh=KTgnqcC7x3ror7WB6z40vDXc8FyUKwbCayrpv6TJ9WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daNx/jlPLP7Bjhh+PdVk30u0Dm70+iuAD3zTgOPkhIwhmc6z9aoLzGQ6a/kYtgVK0Xq6ZUGotgn4YLdPF6PnL/lQPH+vBqwRHQUSMLy0yQbhNs2wT7gx9Mj9NdmfzKqe5SGqJICSq9AvU1BPOg4SfqZzTRPihp9HBmE+6t+Iyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TYYv1lK+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso5581444a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729092387; x=1729697187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGUG8kIdO138NYD1p1N2N2xx7Da7NoNNAVUbHzLKyz8=;
        b=TYYv1lK+hkoE35xDoJFR4M2TavF+wQBOaGcaWrdZWHZzY3E8VnaZPlTW6NZ512s7su
         CG8VoBvgPmKik3cxwDPTqqJYzjEunxzWp+NYobjaxSBEir8jnkDiUcj/iHeiTS46qmbF
         vo9Mez/0WoGEuSQ8non+/4evdmu0BibhC1CDQoC8jfbY/vay+YBDyKDVGcqN2kiN/SdK
         +usWUbJVCH6Erx8rv5t6Cnm0ZTf+kKBDOQQNtESMtqA1cLqG6EZrJLHnXgzbzHfQ/Y7U
         vZi/6oVmAvDPn9uZn3b9Ed6AoRRU2c2byxYmtrfq19CpX1iRK5N76mOoZHRQNyCa5Ieo
         IxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092387; x=1729697187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGUG8kIdO138NYD1p1N2N2xx7Da7NoNNAVUbHzLKyz8=;
        b=Nt6/gQRZhJKwhtr0ivika9v9Cyy1gDqXv86QAEPGhZt052jIdwz4+KFWkx/sY+v+ha
         TfmD568cYmLo4yNamjYfd259kgZnhlK0XL5Peduz/P3jFOZdYu37kYew9S6nPRJwC9ip
         DEmhJVrwsY0S1cQguhFjIU3Rkloduqa7O1URQ99hFcrJl/8uohUBLfLKEHxTCIAWmwYo
         9mX9nAk5I119YpCKjYVx5ZhN7tE0Z4iVyAuFCPV3uyb1JxbrohFcw0X5MeRPiXCRA7IV
         esJ/HlYCjDMjqyCXiU7M+ZLs9BVf3kbQKK+Ebl2jgIO45lfBGVcbU0JxHxmGRW0wWVf9
         e66Q==
X-Forwarded-Encrypted: i=1; AJvYcCV26ytB9MwbFWRVrO7QMzRbd8HG67w5kvLh4eXJBTAsQC7a7hO+RZAY6mvZr4tReGhrZFwisa9B8x8NhLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+ZMUuxMAck26r2tmfNABPtHw28BQe38Hxk2XtK5ssKRZnoeQ
	D7WVsQJxyrKzyj9bZYygYKXU3c0+FKC9LqPsbqkKbidAlpX240fSNEulnR27uFcPhNo+mPdjYKJ
	j
X-Google-Smtp-Source: AGHT+IGgcLUwsw9+vZX+u2b6BeJKt6i8hCS8ohMzM5KQDBjn1/8dNRYAEWTkMJAef+iNELkLqzDvKQ==
X-Received: by 2002:a05:6a20:b40b:b0:1d8:f4f7:35ee with SMTP id adf61e73a8af0-1d8f4f7378dmr9344144637.8.1729092387345;
        Wed, 16 Oct 2024 08:26:27 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2add:7601:8402:667])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d3fddsm2997522a12.52.2024.10.16.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:26:26 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:26:24 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Martyn Welch <martyn.welch@collabora.com>,
	Hari Nagalla <hnagalla@ti.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox, remoteproc: k3-m4+: fix compile testing
Message-ID: <Zw/bIItwk0jeqKoR@p14s>
References: <20241007132441.2732215-1-arnd@kernel.org>
 <4d8a9786-ee4b-43b8-9207-e048c66349fe@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8a9786-ee4b-43b8-9207-e048c66349fe@ti.com>

On Mon, Oct 14, 2024 at 09:56:11AM -0500, Andrew Davis wrote:
> On 10/7/24 8:23 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The k3-m4 remoteproc driver was merged with incorrect dependencies.
> > Despite multiple people trying to fix this, the version 6.12-rc2
> > remains broken and causes a build failure with CONFIG_TI_SCI_PROTOCOL=m
> > when the driver is built-in.
> > 
> > arm-linux-gnueabi-ld: drivers/remoteproc/ti_k3_m4_remoteproc.o: in function `k3_m4_rproc_probe':
> > ti_k3_m4_remoteproc.c:(.text.k3_m4_rproc_probe+0x76): undefined reference to `devm_ti_sci_get_by_phandle'
> > 
> > Fix the dependency again to make it work in all configurations.
> > The 'select OMAP2PLUS_MBOX' no longer matches what the other drivers
> > dependencies. The link failure can be avoided with a simple 'depends
> > do, so turn that into the same 'depends' to ensure we get no circular
> > on TI_SCI_PROTOCOL', but the extra COMPILE_TEST alternative is what
> > we use elsehwere. On the other hand, building for OMAP2PLUS makes
> > no sense since the hardware only exists on K3.
> > 
> > Fixes: ebcf9008a895 ("remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem")
> > Fixes: ba0c0cb56f22 ("remoteproc: k3-m4: use the proper dependencies")
> > Fixes: 54595f2807d2 ("mailbox, remoteproc: omap2+: fix compile testing")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/remoteproc/Kconfig | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 955e4e38477e..62f8548fb46a 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -341,9 +341,9 @@ config TI_K3_DSP_REMOTEPROC
> >   config TI_K3_M4_REMOTEPROC
> >   	tristate "TI K3 M4 remoteproc support"
> > -	depends on ARCH_OMAP2PLUS || ARCH_K3
> > -	select MAILBOX
> > -	select OMAP2PLUS_MBOX
> > +	depends on ARCH_K3 || COMPILE_TEST
> > +	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
> 
> This line is odd. IMHO "COMPILE_TEST" should only be added to ARCH_*
> dependencies, as often only one ARCH can be selected which prevents
> compile testing drivers with various multiple architecture deps in
> one compile test.
> 
> Normal dependencies, on the other hand, can simply be enabled if one
> wants to compile test its dependent drivers. In this case, TI_SCI_PROTOCOL
> cannot be enabled as it has a dependency up the chain that doesn't
> allow selecting when not on a TI platform. We can fix that as I posted
> here[0]. With that fix in, this line can be simply become:
> 
> depends on TI_SCI_PROTOCOL

From the above and the follow-on conversation with Nishanth, should I understand
you are working on a patchset to address this issue?  If not I will apply Arnd's
patch.  People are sending different fix [1] - the issue needs to be addressed
well before the end of the cycle.

[1]. https://lore.kernel.org/linux-arm-kernel/20241016013922.1392290-1-zengheng4@huawei.com/T/

> 
> Andrew
> 
> [0] https://lore.kernel.org/lkml/20241014144821.15094-1-afd@ti.com/
> 
> > +	depends on OMAP2PLUS_MBOX
> >   	help
> >   	  Say m here to support TI's M4 remote processor subsystems
> >   	  on various TI K3 family of SoCs through the remote processor

