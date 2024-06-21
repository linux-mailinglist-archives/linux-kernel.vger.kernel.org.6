Return-Path: <linux-kernel+bounces-224944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B889128F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D8D1F26E66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EFD55E73;
	Fri, 21 Jun 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EbLTCULT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35043208CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982486; cv=none; b=oOjq8h8hYm4pByE+T+uXqNNbJ0cBj2LQEUiMfY+AKm+l2PqaVYxB5DYQiFxORPYe+WVPZ+D8bo1la8yPA/F1SYoNHnohxMCWlQMEGBKw8SC7BNjf7TdvUiT7R9uy15slFH8d91yWhXdD0A6tGdHWaqyGpLHOjeAsepdLTf3i7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982486; c=relaxed/simple;
	bh=Mfbs86+7m7VjWbpg442N0c7HyCNSgaJeK9YGCTPFwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gok6cdN1fRCdwIF1pt5IOkmQVQGRyTa7QJYVIEDhywKVai5b07r5mu/hfvjcUxSZeyCj3qBOfAf7PHDURhL3hN9KahttGpRZIPCbYU/JhwdOcGvqGtOpAXihmNBjZUvZ1p4ilSOvuyDY1ZFgZ3ZuGjoe9kuUInP60jwq/MgD2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EbLTCULT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421b9068274so20078395e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1718982483; x=1719587283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTWHPV88FmCEJH+LG722CyH2FEJ+u15rMxRs38TdpJE=;
        b=EbLTCULTTau4CB7cnTmZFS3zWxJMxSMtJZsUC/kbEC3J2uH4LuwAGxEGXduSvH0x18
         PMU8ATRJc1j+GSG4iZcE3pxY30+AB52qL0gXG9nQ3PumU0BtJQOCmby5Q43HnunHb7Yx
         R+LZLpy6knTIkSH+9C2N0Qnk1Jjo2l0jx0EOFCCD8/Q81v4qfOvBJZiFYyLmy6x4g9+2
         Wd5rSwNWjbx3BRKQWjMAwAOaDc1YJLRdsklsQtmvysVZTOtrH/21fk9r3LG/mixkl4TE
         xMUCvUFsHr4KFT4Ii+hg2AC9m4pOt8R49AUt6WYF5tVLUaJbd0yybxhTVN3VnO25qTHf
         CxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982483; x=1719587283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTWHPV88FmCEJH+LG722CyH2FEJ+u15rMxRs38TdpJE=;
        b=UA2Ac7rTyduC+Pa9kw8986zSYYQhGZ1HyK0aX2VhfPYYmo9ZbPCSu6k8MW/v+i5vGk
         rtvJulISZXaEtwkiNUHhGPYbE1C7h6JAzGUy3P1AcEWb7JSYzLPHHByWpPgDBKVs8j/f
         w0Uiyi2qEqtoIur6kHL4dH+9Amf31xuYiQqU+VIljyV1xtmdrUlYSTaLzo2/FDYJ/SXK
         WfNfqEJJL+SErGOcHaCeW3sgF6mhL5uRk8vI0y3cj4mzVyG/37mf0KKdGL/8N8fYC6o9
         W9jYvchq3iTUnk1rC6blyQ1VroMQYLjMWb9SSLJIv84/v1KVFEjfDnrrgccHcgocvPz3
         DTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJN1YfUFRsS7laiMn+iqqjwltW0HvEYxUI6gdvl1vImTBwn0LeopFeL1nUctgYqMZzXnbBp3i+8Gd7/4OkQAvSb3eB8aX3RjksrstN
X-Gm-Message-State: AOJu0YyGR4J0HGcHkjWtdRMSZSEeauZnGxEOenraE3rI8Gji4HLdijY5
	jB5zTmUNXKw39oyyji4G123cKM9xYmWRh9tzp4La9fVlw9ZtJz4eLd2R9/Tulek=
X-Google-Smtp-Source: AGHT+IEIRpUWHcw8XTIcAv4v8Oe5k9VV3v98Ohw140EkoEs6DEAbUs8kPNn5uZbUGX5eMmzZdCfjhg==
X-Received: by 2002:a05:600c:4f45:b0:424:777d:dcc with SMTP id 5b1f17b1804b1-424777d1648mr63667245e9.0.1718982483038;
        Fri, 21 Jun 2024 08:08:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3664178f5f7sm1935800f8f.19.2024.06.21.08.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:08:02 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:08:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
Message-ID: <20240621-8422c24612ae40600f349f7c@orel>
References: <20240605121512.32083-3-yongxuan.wang@sifive.com>
 <20240605-atrium-neuron-c2512b34d3da@spud>
 <CAK9=C2XH7-RdVpojX8GNW-WFTyChW=sTOWs8_kHgsjiFYwzg+g@mail.gmail.com>
 <40a7d568-3855-48fb-a73c-339e1790f12f@ghiti.fr>
 <20240621-viewless-mural-f5992a247992@wendy>
 <edcd3957-0720-4ab4-bdda-58752304a53a@ghiti.fr>
 <20240621-9bf9365533a2f8f97cbf1f5e@orel>
 <20240621-glutton-platonic-2ec41021b81b@spud>
 <20240621-a56e848050ebbf1f7394e51f@orel>
 <20240621-surging-flounder-58a653747e1d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-surging-flounder-58a653747e1d@spud>

On Fri, Jun 21, 2024 at 03:58:18PM GMT, Conor Dooley wrote:
> On Fri, Jun 21, 2024 at 04:52:09PM +0200, Andrew Jones wrote:
> > On Fri, Jun 21, 2024 at 03:04:47PM GMT, Conor Dooley wrote:
> > > On Fri, Jun 21, 2024 at 03:15:10PM +0200, Andrew Jones wrote:
> > > > On Fri, Jun 21, 2024 at 02:42:15PM GMT, Alexandre Ghiti wrote:
> 
> > > > I understand the concern; old SBI implementations will leave svadu in the
> > > > DT but not actually enable it. Then, since svade may not be in the DT if
> > > > the platform doesn't support it or it was left out on purpose, Linux will
> > > > only see svadu and get unexpected exceptions. This is something we could
> > > > force easily with QEMU and an SBI implementation which doesn't do anything
> > > > for svadu. I hope vendors of real platforms, which typically provide their
> > > > own firmware and DTs, would get this right, though, especially since Linux
> > > > should fail fast in their testing when they get it wrong.
> > > 
> > > I'll admit, I wasn't really thinking here about something like QEMU that
> > > puts extensions into the dtb before their exact meanings are decided
> > > upon. I almost only ever think about "real" systems, and in those cases
> > > I would expect that if you can update the representation of the hardware
> > > provided to (or by the firmware to Linux) with new properties, then updating
> > > the firmware itself should be possible.
> > > 
> > > Does QEMU have the this exact problem at the moment? I know it puts
> > > Svadu in the max cpu, but does it enable the behaviour by default, even
> > > without the SBI implementation asking for it?
> > 
> > Yes, because QEMU has done hardware A/D updating since it first started
> > supporting riscv, which means it did svadu when neither svadu nor svade
> > were in the DT. The "fix" for that was to ensure we have svadu and !svade
> > by default, which means we've perfectly realized Alexandre's concern...
> > We should be able to change the named cpu types that don't support svadu
> > to only have svade in their DTs, since that would actually be fixing those
> > cpu types, but we'll need to discuss how to proceed with the generic cpu
> > types like 'max'.
> 
> Correct me please, since I think I am misunderstanding: At the moment
> QEMU does A/D updating whether or not the SBI implantation asks for it,
> with the max CPU. The SBI implementation doesn't understand Svadu and
> won't strip it. The kernel will get a DT with Svadu in it, but Svadu will
> be enabled, so it is not a problem.

Oh, of course you're right! I managed to reverse things some odd number of
times (more than once!) in my head and ended up backwards...

Thanks,
drew

