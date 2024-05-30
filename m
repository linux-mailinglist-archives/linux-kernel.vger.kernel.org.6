Return-Path: <linux-kernel+bounces-195169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BA8D486F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3871C232DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742AB1761AE;
	Thu, 30 May 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="l+o35wmK"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB296155340
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061102; cv=none; b=sVyXV19wklCRtTfz9OmQYTsW9DhNS819+Xc+ASFb6EZ30y3RATyd/1lAXthiLfL6l6/Qg/5SlVjc+wGdh90pSUsloJ09+mW6nyzlOh5FTYznPY+Z5dGnbCThh28K/di8KmdygaaKbgVPQJShPwqJ2DuHI0BDbLa5g9efEI5rMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061102; c=relaxed/simple;
	bh=9pLWvL2Y/aTQ2LKyV9WT0bkWXzEMLQEvcWcjyBRCps4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfSRqvBqknqgy1t1qpj4Tp1u99jqqWdxvGXZGir8FsvKjpN6p81QluHy4Cfbwd5Mp++y0fG2a/eOOE6CjfgmFmBwBMgtbo61bkNWKImn3aLNia+GEeOvX1tdV3gHtAlgDuIs/Isb9DWBQYuho0CoGzc3NyzyiiCBWohRgIYQwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=l+o35wmK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b4fcbf078so832413e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717061099; x=1717665899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGWcoQz6bp5W8A5c5FEsjIeyZdnGRxg5AvvBbn2QbK0=;
        b=l+o35wmKWzcasIGgjeydEsxK0QNdtdB2hh1wI8O3jUcmwf24RAy/K/mm7LCukfRDiF
         uDWzoYjr7XuIHmkLnrB+M0DVr+Wp7H1ri7+PcCGc5WQmiCDAhRugrd6+rez4w2Fta/nV
         +w4/vYPFYoPR6rsnBz4UpHQtlLq5avOlsITeVh4qVLOBzP5ZWy+enG4sLo1b6e4YPISP
         5TVU3H6jG0zbHPBQuYgOhaoY2EbMdHV/59bd9/AK2Y+Htfuac+ypkD+RumWwnDgkWZwC
         4SOOOHuFbSHKpRofwa04ma0vwCZGw4TFMm9rt8uBVk/87xtY5DQLJ+uw+YnLBKGM/GQT
         cLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061099; x=1717665899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGWcoQz6bp5W8A5c5FEsjIeyZdnGRxg5AvvBbn2QbK0=;
        b=ibs7NEI/YcjDnMhxOGtkB/Rt3GeeZwizWWAa8fd0G/FV1FANh2ZnS976FsmqdVoydp
         aIirTTA/Sq7ZCLrOYJ3R4MtY0GCsm5WdUsMmwIoEqrvQUA7rXmzqm/Wi0ERH+CGkNhql
         mZbmWQaSvJIfKOQAkVbNByNZa5feHSK+KxFqkEZsK9pehOh2TBX9YI1D0mniwyQjoJbX
         LsFU+i/PtxVeI84pfblzeQyjV9TfZvki2HvNdE5X+nbOTYFEvWSyv93RUuzRZHVeeOmx
         qGXBRIovJRS0ewXR4lChqKInRFzjJMsX96PdEt+REXJ7TJ0xuiR+GIPdEr/S12aAOIII
         mOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCPs7I25Us7xrz/lTFal8b3X4VUGNnNeTcjvua6g6TZM2Z4DHvCw0lZnwPjlxRx1ZrjzZSuJVR+RnmR9ls0Hot2xh3ETRiDd8b9zJL
X-Gm-Message-State: AOJu0YyiyTtlifq9hpkDndiaWZEEBoI7Bm8NDRu51GGooF3ahCLxp1Gx
	toYF+eeD1l2U+HgmNPIKeO8GHtMNUY56dABv/Upi8FaQVnm3NGX9l+xUB7GSRlQ=
X-Google-Smtp-Source: AGHT+IELCUAFliwbdnLlRoUjMofrcBrzQ/gONVqlkzwZRu4BVC/i56ENc2IuIJrAiK/uaL4mr6II2g==
X-Received: by 2002:ac2:522b:0:b0:52a:f4f5:5cfa with SMTP id 2adb3069b0e04-52b7d480912mr782775e87.58.1717061098823;
        Thu, 30 May 2024 02:24:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08ab81sm16840093f8f.39.2024.05.30.02.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:24:58 -0700 (PDT)
Date: Thu, 30 May 2024 11:24:57 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, cleger@rivosinc.com, 
	Jinyu Tang <tjytimi@163.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <anup@brainfault.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Samuel Ortiz <sameo@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/5] RISC-V: Detect and Enable Svadu Extension
 Support
Message-ID: <20240530-de1fde9735e6648dc34654f3@orel>
References: <20240524103307.2684-1-yongxuan.wang@sifive.com>
 <20240524103307.2684-2-yongxuan.wang@sifive.com>
 <20240527-41b376a2bfedb3b9cf7e9c7b@orel>
 <ec110587-d557-439b-ae50-f3472535ef3a@ghiti.fr>
 <20240530-3e5538b8e4dea932e2d3edc4@orel>
 <3b76c46f-c502-4245-ae58-be3bd3f8a41f@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b76c46f-c502-4245-ae58-be3bd3f8a41f@ghiti.fr>

On Thu, May 30, 2024 at 11:01:20AM GMT, Alexandre Ghiti wrote:
> Hi Andrew,
> 
> On 30/05/2024 10:47, Andrew Jones wrote:
> > On Thu, May 30, 2024 at 10:19:12AM GMT, Alexandre Ghiti wrote:
> > > Hi Yong-Xuan,
> > > 
> > > On 27/05/2024 18:25, Andrew Jones wrote:
> > > > On Fri, May 24, 2024 at 06:33:01PM GMT, Yong-Xuan Wang wrote:
> > > > > Svadu is a RISC-V extension for hardware updating of PTE A/D bits.
> > > > > 
> > > > > In this patch we detect Svadu extension support from DTB and enable it
> > > > > with SBI FWFT extension. Also we add arch_has_hw_pte_young() to enable
> > > > > optimization in MGLRU and __wp_page_copy_user() if Svadu extension is
> > > > > available.
> > > 
> > > So we talked about this yesterday during the linux-riscv patchwork meeting.
> > > We came to the conclusion that we should not wait for the SBI FWFT extension
> > > to enable Svadu but instead, it should be enabled by default by openSBI if
> > > the extension is present in the device tree. This is because we did not find
> > > any backward compatibility issues, meaning that enabling Svadu should not
> > > break any S-mode software.
> > Unfortunately I joined yesterday's patchwork call late and missed this
> > discussion. I'm still not sure how we avoid concerns with S-mode software
> > expecting exceptions by purposely not setting A/D bits, but then not
> > getting those exceptions.
> 
> 
> Most other architectures implement hardware A/D updates, so I don't see
> what's specific in riscv. In addition, if an OS really needs the exceptions,
> it can always play with the page table permissions to achieve such
> behaviour.

Hmm, yeah we're probably pretty safe since sorting this out is just one of
many things an OS will have to learn to manage when getting ported. Also,
handling both svade and svadu at boot is trivial since the OS simply needs
to set the A/D bits when creating the PTEs or have exception handlers
which do nothing but set the bits ready just in case.

> 
> 
> > 
> > > This is what you did in your previous versions of
> > > this patchset so the changes should be easy. This behaviour must be added to
> > > the dtbinding description of the Svadu extension.
> > > 
> > > Another thing that we discussed yesterday. There exist 2 schemes to manage
> > > the A/D bits updates, Svade and Svadu. If a platform supports both
> > > extensions and both are present in the device tree, it is M-mode firmware's
> > > responsibility to provide a "sane" device tree to the S-mode software,
> > > meaning the device tree can not contain both extensions. And because on such
> > > platforms, Svadu is more performant than Svade, Svadu should be enabled by
> > > the M-mode firmware and only Svadu should be present in the device tree.
> > I'm not sure firmware will be able to choose svadu when it's available.
> > For example, platforms which want to conform to the upcoming "Server
> > Platform" specification must also conform to the RVA23 profile, which
> > mandates Svade and lists Svadu as an optional extension. This implies to
> > me that S-mode should be boot with both svade and svadu in the DT and with
> > svade being the active one. Then, S-mode can choose to request switching
> > to svadu with FWFT.
> 
> 
> The problem is that FWFT is not there and won't be there for ~1y (according
> to Anup). So in the meantime, we prevent all uarchs that support Svadu to
> take advantage of this.

I think we should have documented behaviors for all four possibilities

 1. Neither svade nor svadu in DT -- current behavior
 2. Only svade in DT -- current behavior
 3. Only svadu in DT -- expect hardware A/D updating
 4. Both svade and svadu in DT -- current behavior, but, if we have FWFT,
    then use it to switch to svadu. If we don't have FWFT, then, oh well...

Platforms/firmwares that aren't concerned with the profiles can choose (3)
and Linux is fine. Those that do want to conform to the profile will
choose (4) but Linux won't get the benefit of svadu until it also gets
FWFT.

IOW, I think your proposal is fine except for wanting to document in the
DT bindings that only svade or svadu may be provided, since I think we'll
want both to be allowed eventually.

Thanks,
drew

