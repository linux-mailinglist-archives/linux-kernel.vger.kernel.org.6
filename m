Return-Path: <linux-kernel+bounces-516009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E00A36BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA1F1896C45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666101624E0;
	Sat, 15 Feb 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Cbh2qH"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF321345;
	Sat, 15 Feb 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592210; cv=none; b=TTBhrkMhYrG2tRIPBj8ToAmmekH1gVj56VgHQqnm3V9IbEsLlTRtSPXS5I6Gky4X6AQZu4k5lc0UUomb6OvOd8eKFGR/cnAXSHn0HvQ7OeGg3lQaqPTpoMCDY25cTo8bgVC71SAIRI1V+i2sJAPgKxdRSBN1pp45k94xrg6GogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592210; c=relaxed/simple;
	bh=8euGxLRHA40eC51dGopJCrH+ddHXGBwKvkWGDet6qOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxayIJX6Ms9uDaBWoGu59Sa165qbozjJanTLA+AFPsxV6yFs/zfBRGcoezfIheGHhCbOfHgo/VlsaZLi+0DEEostL4pQeISYcCtLNOEENtV1TJ9hOKYW25Sz3jrMbvzOahVhPTNpZzj0/tY8Uz9woxRy2SgdpI+s0/tWeOqXqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Cbh2qH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46c8474d8f6so23604901cf.3;
        Fri, 14 Feb 2025 20:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739592208; x=1740197008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJ9/Akd4fSMQIMXpZijLUqRTB8clBSRR8MFzutJDF2A=;
        b=S6Cbh2qHgSvjX5dGkRrIWdUrN/Mj+K0nfhQx0QO5MUYRQ5/G2qoC/sxkjnsJSLzISk
         8/U6k6EhSIimlOkNvTBQKPZQDK3lYH7aLhvTqab54e5sCqArYKC2L2Fs/K2mAB2NqQ6/
         gLVW2TjJbUIFPE1/NgkgF/3TeYOwE13c0Jk3KQjn1q8WwowsOfxNWMKEx7ljSfTBXXdn
         +k2mkFYWW62PQILKbSc83VCeaRE1DwoQEzRUqaaVyRJHILFEUU3FiaRf7Q3hT+uZgeDw
         BpK0q/jiZUWGQ3set4EN/XKCiQx09b4ycDoovIiFLVVkGJ1O1BZI9Bl7JYVbgq6/FAkm
         wK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739592208; x=1740197008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ9/Akd4fSMQIMXpZijLUqRTB8clBSRR8MFzutJDF2A=;
        b=leoRMObVz3kaUvY+3AsOe8sljAu1cJp5sAvkEzbNtNUNIbH50MmYMEJ30yVuamBXmr
         FcfhfSaNowtsifbJnV5xp+zACvCcTfq2ZRHp7pe23PqVbDxuZbGjvApcXriUZ9cbxpi1
         6pvi1fRL5NdcVcbnZ2vVq5+PGw9k3ExPMC1mBFHgOXXSQ5IHA3BxDwSu1UXSMgNBKbGf
         Da2/3Pxr38aubpylg8M4ZSF4eAcG3XSXIOM6/3Vz+WbARfQtmT9cA71u44/5pziUd+jZ
         kciolOGkooHi7v3G2u9KZu+pwJSs9cPdhihJCFVBIKZGDrJLfDuo51ZIsLKXZ9ZdRuUV
         2mHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb7E85qeVL+dXwHusCuJUpJVtloR3OhE+E6Fuldaws19e/4dH6nUlHw79g7jOTGBgS7StgOAU8sGLeJUfI@vger.kernel.org, AJvYcCX9bebRYWH2P5zABk2Qu72Jc7sNd82n0iVFHd+jtiGQnQqj72ywg1gct6pyh8NnOonG34J/9uOeYbB7@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmehFuHl2KIeFKduKcVOEIrBt+4wkiS2azEI7WGVhD1TyPbWl
	+II5lXxVSWNb7dBpIhnGdGNvhkajxl9XNb2lhQg95zW3VEmfX5rJ
X-Gm-Gg: ASbGncs5iSBi3NizSdCUpUJ4myAvts688pTo/EtTNPRbtzQcI76w/D7YmSMBJuyy1qT
	y3od0KrRTCKZ6iXVm95yi7noX3eBE65f4P4M/Lq0w7mWnG/DFP8tyrpfFHksFuqw2mYfrOlLY1q
	bJnqYNohzS6rrCq6/eW9UcYLOXA+Aj1GDte0nxVFS/fqn06Kl6JzSIxKVBEArbkXbQtt4gZIf3d
	JAngdjC+/9hyW3cP2yCtjF3HeYg9GqHxk4ZOIrc+TvgvkpVfr1KwuIV72ylwsVyueg=
X-Google-Smtp-Source: AGHT+IGpZkShfqGOR4DZumQ8cgtF5xa0Zz0ltfO+3rGOTSuLke11tRfF5yjZeQQJKrSty8477vuMUA==
X-Received: by 2002:a05:622a:1829:b0:471:cd38:d08f with SMTP id d75a77b69052e-471dbe70a3cmr29566671cf.33.1739592208124;
        Fri, 14 Feb 2025 20:03:28 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2af3700sm24303601cf.64.2025.02.14.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 20:03:27 -0800 (PST)
Date: Sat, 15 Feb 2025 12:03:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, conor+dt@kernel.org, guoren@kernel.org, 
	inochiama@outlook.com, krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robh@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, chao.wei@sophgo.com, 
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, samuel.holland@sifive.com, 
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v3 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
Message-ID: <egxjuvebaznrtlzreie77p3gyykslagxqvwy6k3tje7a73ciqh@rikhellxp5ny>
References: <cover.1736921549.git.unicorn_wang@outlook.com>
 <b5c2f13aa94f68c3415a1292678e16db33f291cd.1736921549.git.unicorn_wang@outlook.com>
 <dh645pyvtylcxjcjjcdl7xttpp4qmtjouapifaql4lniab3qjo@lqmwytf5q35c>
 <MA0PR01MB5671D5D25616BABA0E7F60F4FEF92@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0PR01MB5671D5D25616BABA0E7F60F4FEF92@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>

On Sat, Feb 15, 2025 at 11:36:18AM +0800, Chen Wang wrote:
> 
> On 2025/2/15 9:09, Inochi Amaoto wrote:
> > On Wed, Jan 15, 2025 at 02:33:45PM +0800, Chen Wang wrote:
> [......]
> > > +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs,
> > > +						    fwnode,
> > > +						    &sg2042_msi_middle_domain_ops,
> > > +						    data);
> > Use irq_domain_create_hierarchy
> 
> What's the difference?
> 

I made a mistake, just ignore it. The original is OK.

Regard,
Inochi

