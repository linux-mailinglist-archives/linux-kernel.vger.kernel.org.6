Return-Path: <linux-kernel+bounces-515838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAAA3698F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51791188F684
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178F43AA4;
	Sat, 15 Feb 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="NcHNGV18"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DB3F9D2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578047; cv=none; b=utjw9PZaq10rzPbD6hmJlrCH1qzBJhPf88BUp/FrXP40GVXuIgAH2z7uQsf976S2a/k92G+VosaLloHOujFF6hbLzhTQq6jX834HmYdMsWEow9uoFy02R9iMDa5UnmdeeqvGy6ZnIhtq/TdR71o/wtBi2a7U0F9PqxGfgHRU+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578047; c=relaxed/simple;
	bh=8+xzf9ySd/X+Hdk6TVNjRCzbanGBd6Lj9zLGXDU7P6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6y3AB7jykwhv+MN/A3hLjPPF4U2bJAUtFhuVIqSWoz2dhGNvoy57X3tPv2ecOblAIHh0K35KNtwn7UaXGZPNn2M/m+8ix8+GZpUHWxUVeCpIv/BC9WGqkHbC2CMrI/s3hMYS/M5dsuTe/pUrFOTSpS+I5VPsLsyn4U6KmxBy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NcHNGV18; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-221050f3f00so3876885ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1739578045; x=1740182845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOjx+Bv4LjyysKyz1M7F23hlX9gJ5MiSnBCNPTwWjok=;
        b=NcHNGV186OL4xtOyAINLbGLf/7e1xkPuNFC3INAK6Ix6VZdBFDoQtrrXjokae3SrcI
         CoEtjHWZMolgKp4Og/AcNXvtT02czKpV3dhw2KGFPuFGXP8qahbSDQItJ2+IXKnuZBCB
         BWBf5Li5ZeekfB0nsB2lwSUOGRSP/8Nm3P0AUIz2Py4tN0t4kzclhCRTwxBYL+L6W4r+
         4DU6SaEVDYHtUuuGFPWD+0pj1QZl9Y8y9csvbNPED5+Oi8tLj5TRREKcU1dpYIOxx/1l
         Oi7sOsUy8P0ABwT43BW04lzaLpn9pmTUh6SfC3k7Z+l3NUfFcPAFPd7dwcL3SiDxFktY
         1DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578045; x=1740182845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOjx+Bv4LjyysKyz1M7F23hlX9gJ5MiSnBCNPTwWjok=;
        b=A4dN1eqjB+uX3HAQu9/nisuCCcg2/DfXIBoVmSxFMwl4jW+NVjJ73jjkEvV8GwPEtx
         i8vgKxAn/c5krkF1sMmnQY1XLz8Mzj67+KU5HpToIxCSBnp5PQ5ke8htMmODQmo+74wA
         eUJ2wVIt9dOQmioCL2NPh45/p481dJ9C4ZakLukx8GxRm6Yj6+IRFzujpcRdIdSH3NFJ
         jOvLLUDAMV4eZUaZAOrJi1atqmTW7gTUHVO2b6YZb0Dahdhs/W8w0yUuvTDH+ysRoZNi
         +qjoBqtcP9HPjo95pfuSqXcoS7nYaSp6jEy0Ngw8XTnaRD3S4au6HjzDWnDRP7EOsG6e
         ydOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYzNKpK1UHvQeoHXqIDu3MGeopUBkirfMCXmNMZxpCQKm8mSgcGx2K8riGo+p0RKRKbjHrW3F+hNVnC5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErAQ1SH5cZct/i+/M9O1iuSZVldcoOkURyGmRcnLWO6ThEycP
	I7Tt23QdH0FxsdfPdCoDRILbXv9nTsDhZi71JqAC1XAUNmQBMlIxbpfttcH3ow==
X-Gm-Gg: ASbGnctg/HPKMgvO3R24Nf3aqEKYh09Fj/kIXmGIBpBGsX1hwxka5hOv8SJp6m1QqrD
	gQG6N6ZTywza0gUvJtpko0yCxl9qqQuQoiZQlV6DnpGOXfhATwJddcgN8kbmMiFwWMm0K73JnNX
	z8mItWWJtEi+qKGwuE+2//j8bYh4/gHMrAwZlxuzWRqyNOL1MZFE6pVim9tOTOurTWpX0kIDEvD
	oU7prAG5GxQjHIfnm1AQKmmmaciZEd10n5OVBwyCKBxJbD/tzIPmtJ5cdd0ObOy37xIhTX007WD
	pA==
X-Google-Smtp-Source: AGHT+IHx5OkXIJXTPCfIKeOntur/esg3MA+G7B7HcUfQ9rX2ygUHZhoSaE9erMQQrxJMl6S5EprERA==
X-Received: by 2002:a05:6a00:1903:b0:730:888a:252a with SMTP id d2e1a72fcca58-732618c1eb9mr2143203b3a.15.1739578044553;
        Fri, 14 Feb 2025 16:07:24 -0800 (PST)
Received: from ubun ([2600:8800:1689:e500:3522:b69b:bf26:8dfb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73261a0c0b8sm372070b3a.164.2025.02.14.16.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:07:23 -0800 (PST)
Date: Fri, 14 Feb 2025 17:07:20 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
	linux-hardening@vger.kernel.org, kees@kernel.org,
	joao@overdrivepizza.com, samitolvanen@google.com,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <Z6/auDKBF1E0m/6L@ubun>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com>
 <Z65/Fpd9cnUk8TjE@ubun>
 <c2af5771-1c16-4ac8-bc09-c33d07956358@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2af5771-1c16-4ac8-bc09-c33d07956358@citrix.com>

On Fri, Feb 14, 2025 at 11:06:50PM +0000, Andrew Cooper wrote:
> On 13/02/2025 11:24 pm, Jennifer Miller wrote:
> > On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
> >>>> ; swap stacks as normal
> >>>>     mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+20>
> >>>>     mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24>
> >> ... these are memory accesses using the user %gs.� As you note a few
> >> lines lower, %gs isn't safe at this point.
> >>
> >> A cunning attacker can make gs:[rip+0x7f02c56d] be a read-only mapping,
> >> at point we'll have loaded an attacker controlled %rsp, then take #PF
> >> trying to spill %rsp into pcpu_hot, and now we're running the pagefault
> >> handler on an attacker controlled stack and gsbase.
> >>
> > I don't follow, the spill of %rsp into pcpu_hot occurs first, before we
> > would move to the attacker controlled stack. This is Intel asm syntax,
> > sorry if that was unclear.
> 
> No, sorry.� It's clearly written; I simply wasn't paying enough attention.
> 
> > Still, I hadn't considered misusing readonly/unmapped pages on the GPR
> > register spill that follows. Could we enforce that the stack pointer we get
> > be page aligned to prevent this vector? So that if one were to attempt to
> > point the stack to readonly or unmapped memory they should be guaranteed to
> > double fault?
> 
> Hmm.
> 
> Espfix64 does involve #DF recovering from a write to a read-only stack.�
> (This broken corner of x86 is also fixed in FRED.�� We fixed a *lot* of
> thing.)

Interesting, I haven't gotten around to reading into how FRED works, it
sounds neat.

> 
> As long the #DF handler can be updated to safely distinguish espfix64
> from this entrypoint attack, this seems like it might mitigate the
> read-only case.
> > I think we can do the overwrite at any point before actually calling into 
> > the individual syscall handlers, really anywhere before potentially 
> > hijacked indirect control flow can occur and then restore it just after 
> > those return e.g., for the 64-bit path I am currently overwriting it at the
> > start of do_syscall_64 and then restoring it just before 
> > syscall_exit_to_user_mode. I'm not sure if there is any reason to do it
> > sooner while we'd still be register constrained.
> 
> I don't follow.� If any "bad" execution is found in an entrypoint, Linux
> needs to panic().� Detecting the malice involves clobbering an in-use
> stack, and there's no ability to safely recover.

Sorry, this was in response to Jann's question about the mitigation
strategy proposed in my initial email.

> 
> ~Andrew

~Jennifer

