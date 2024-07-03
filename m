Return-Path: <linux-kernel+bounces-239039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB0925549
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8181F23561
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B5137C34;
	Wed,  3 Jul 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZdHdlV5y"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05113049E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994953; cv=none; b=tVI2tWS6ldroa6BqjKmjQ2KoLJotCpW3iAbBeCCi4AOrR7UZfH9sO17xCsILb3SfhGd4ZPgFyDWPMZKzrgvyHf9R/94BzYfuKj0SpTC1d1Nh9a48QyaL8E3nAMKrbb0kHGdt4hwSnCRAMr66flfwOWELgQe9xBFWnk3mH+zoE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994953; c=relaxed/simple;
	bh=krucwHfZgcKYkNzvalwXTEzmuibTJbKcB/Iz0w38Tuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqGjGK/1Xa/3JCsGkRgBS4jnaf5UoOhnIOJrA1K2KX51O7AtAwC9nGPOBHqnkfzz/jI6q77J3DF5CNlAEp+FSs7J7ceHITJ8VHCiZjIEq/msXg6DT/7Tkbuc7sEeadzuYEk8I/hUcJOH9aJJ/iviboFR+4HmiJjyqEdBXEkDfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZdHdlV5y; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so20816501fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719994949; x=1720599749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMQqT/Muz0iwxmBm/vQkZCAi7Byb2pCrA2WM9iHg1No=;
        b=ZdHdlV5yriZV5W2z0XZDrHuTq3pD9AFqc5tdA7R73oflre9CglUW5FnedqIcA9uSpG
         RZwf953EmV7IVt/uTuBUJO+zV1/ahsAwjdnBQ+w2FEs7IE9UWtQSDBq+l3wE4bypCg+c
         WI+LlQS8tE7i9IiOdlG5Znkg/lnEJRnT/BUuPFrVzFLvQP5iPzgf6xLMVwKV5ih0ti38
         m5P2HxBECQN+OZHI0i0BXRnfC/O2xSL6prJhXn6kAEZB5/SHAx6UhUca1dJIDghDMU7f
         JOVSWWz01zDNwBPJ/9gTtYvUriuTEsggyAjJgeG6zagQoGDxAjbVIeW6kqmssI2Apb+E
         ZpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719994949; x=1720599749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMQqT/Muz0iwxmBm/vQkZCAi7Byb2pCrA2WM9iHg1No=;
        b=vjay3taHWxyqNRvAeix5BpN/UrcCoN/C8GlZQn0eNFubexyJi/rnuVOlobrL9CXImd
         S4T5NTn3Bmi9r0gnaabW/1kBglrqH+qh3RruMBcXc7062QErlSTmo1nMiCv3YOubaWI6
         oQCrjIso4+A/G2mHS1u0aTR0eoUkSSl1+uP7mIE+/UpkIdARMu8BLNxxdMD/hLgSVRBY
         xESHaN5a7prfImEtiV7HieCtFQFMjTfhL8O0KnJzMd+QqRblCUjpXPcoHfGImhXiaUUs
         PaJwAAUUGMP/TPTs4/2LM6LTDVXwD1IV99psXf1Z44dqWPIBZ6uBSyfVObUbYA1zF2N6
         UdFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBbgMKdClX7zOA5sY+ZmRTmXSODPsxPYjwKs/QQOFDY46JovaoOIbyhvhQl+Dd8z/j1fiwB2nYG809/romrUiPuUZkfqLkpVCjdF7a
X-Gm-Message-State: AOJu0YzIHnh8EtlhRDvFEk0f9dzdPcqcI9efLHN+xgAL+LgC9X6cIeYc
	4k0Zqxb/esn1i/sKEq7xcfKhd8ppH3T72NlmYkVm2+WzcdQ8syrduDUBQms8g78=
X-Google-Smtp-Source: AGHT+IGgmL2y9QM4c4g0Wf6Xz0uaCMi9coDigbGLy4p0by/hZmKG4KPflaiBbCeCe+DcbaFV7kidJA==
X-Received: by 2002:a2e:bc88:0:b0:2ee:7a54:3b14 with SMTP id 38308e7fff4ca-2ee7a543b8dmr26465461fa.7.1719994949278;
        Wed, 03 Jul 2024 01:22:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802959d41sm10094847b3a.96.2024.07.03.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:22:28 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:22:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
Message-ID: <ZoUKM9-RiOrv0_Vf@pathway.suse.cz>
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <202407021326.E75B8EA@keescook>
 <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>

On Wed 2024-07-03 09:57:26, Jocelyn Falempe wrote:
> 
> 
> On 02/07/2024 22:29, Kees Cook wrote:
> > On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
> > > kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> > > callback.
> > > This patch adds a new struct kmsg_dump_detail, that will hold the
> > > reason and description, and pass it to the dump() callback.
> > 
> > Thanks! I like this much better. :)
> > 
> > > 
> > > To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> > > function and a macro for backward compatibility.
> > > 
> > > I've written this for drm_panic, but it can be useful for other
> > > kmsg_dumper.
> > > It allows to see the panic reason, like "sysrq triggered crash"
> > > or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> > > 
> > > v2:
> > >   * Use a struct kmsg_dump_detail to hold the reason and description
> > >     pointer, for more flexibility if we want to add other parameters.
> > >     (Kees Cook)
> > >   * Fix powerpc/nvram_64 build, as I didn't update the forward
> > >     declaration of oops_to_nvram()
> > 
> > The versioning history commonly goes after the "---".
> 
> ok, I was not aware of this.
> > 
> > > [...]
> > > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > > index 906521c2329c..65f5a47727bc 100644
> > > --- a/include/linux/kmsg_dump.h
> > > +++ b/include/linux/kmsg_dump.h
> > > @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
> > >   	u64	next_seq;
> > >   };
> > > +/**
> > > + *struct kmsg_dump_detail - kernel crash detail
> > 
> > Is kern-doc happy with this? I think there is supposed to be a space
> > between the "*" and the first word:
> > 
> >   /**
> >    * struct kmsg...
> > 
> > 
> Good catch, yes there is a space missing.
> 
> I just checked with "make htmldocs", and in fact include/linux/kmsg_dump.h
> is not indexed for kernel documentation.
> And you can't find the definition of struct kmsg_dumper in the online doc.
> https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper
> 
> > Otherwise looks good to me!
> > 
> 
> Thanks.
> 
> As this patch touches different subsystems, do you know on which tree it
> should land ?

Andrew usually takes patches against kernel/panic.c.

Or you could take it via the DRM tree, especially if you already have the code
using the string.

Also I could take it via the printk tree. The only complication is
that I am going to be away the following two weeks and would come
back in the middle of the merge window. I do not expect much problems
with this change but...

Best Regards,
Petr

