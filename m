Return-Path: <linux-kernel+bounces-206774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E475F900D88
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51CA51F22EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFC155353;
	Fri,  7 Jun 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h+n7Bw2j"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD84E1DD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795974; cv=none; b=m6QSWvGD88TCFHMUJ+/sWIWgi6VXyno8oUkdwvDkHjEDz+UsZj3cL6tFYoelxwq4CP4QITxnTV5C2n1VnLbLmrtx4julqEMxIHPjMclX9807R9QZDWzFxWdZ37sKnZAtlxXqvwTtCV9r+0WQCwmRviKCUAqhFmCFG9yWpNfmDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795974; c=relaxed/simple;
	bh=8qHPzm5a5JgFK8worTleaMJ20xoqkrEwmZZqgOn913I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdAiCqE6mTNZQxJ9VzdNSVNFxT/fnSe06cUt4CmLB5DW5gADcPCWwDiakadt6FzntkCM027lcmxZ2+4qsq5NR0ZI56/D+XrLvGJyPjLdHfdLEWuXq1IctaVgjxNEsWEEL7sZJPIQAeNmQ/GbdlBRD5rXoQ+jl6OLMZNivEsjeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h+n7Bw2j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6559668e1so22765265ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717795972; x=1718400772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=en5rhVQeS4jMQZ7MYT9HPVU5AsizJ4lSBaI/jISWz7g=;
        b=h+n7Bw2jIFjjjb2AaQFDJKBQ6fnQgmYdj6kCxAXBUGkAImlg1AJCr1erzHbODVI1xC
         6ctSS7OTfikXmwUvHPknG+LUT2wX8AoX107B1lgQ/YV3RuajHDLmq4XtiAYypMQi9byD
         uAUO8qqTF+CP57fVF5jwbG/k9t6YktG3cdtKwWrJ7DKmuYekf1fJj0/iuWvC2GjXFEkR
         IUVJG1cWKNk/HNpnGHUsKOwU8rbL1Bd9xpmsraXPJ2ZUyJjcMjXXQ3FKQNR4/UJyFA09
         YMq9Ch75RWOnNZIordgppqV+YuOLeaT0QC6a4asfrSGKpzkW3sxaD7m3s1owgF703qBc
         7mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717795972; x=1718400772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en5rhVQeS4jMQZ7MYT9HPVU5AsizJ4lSBaI/jISWz7g=;
        b=QoiqHOikqNEGfdpBToAOh1OKaiJk3VzDQnxeZevZmQoHSQKyJW7WQitfTKpuIbhvwd
         +vEK08ZRzwt6JgOCV/wS2Rqjrh530j3YlPy84/jGPa1H600ss5lJDt4ouMO+FkZgt0Ws
         h+v3NXitJOteEUPfGArwccd5ZJnjjYpMkxxlN228vNpZb4nA0Eua2TNODVJ3pffevWnB
         mEU96ebNACk2nGGpZHw2rNpezw76EHB1p3xzZD4rRcMIPBLohnew525L6fecRn02nJa1
         q0USbYRUnGENTMWqwMkC5cfbMy2gyJcCiPoYHmDc+nC43DsLLzqqPMxD5l4riG0DjBQe
         Os0g==
X-Forwarded-Encrypted: i=1; AJvYcCXAdExlecHzMlrdrvOSIvIne5eU7ZYu+cpL1t0FgbhJGUrc3UwRIbtsXxvNYYsCIVfEchXqX/jK2vJRfx3w3cYED2mMWuuYrLF685Od
X-Gm-Message-State: AOJu0Ywz28ibOadiD5mWUqJgVeywwe2+4RnsiqIXIFVHyDVze3Y2ovda
	KXqQeRgBeAMdlPNVxeie5XQ6SaLLUn5qptDE6ahjSYZiWTYh7UWUioenNhHEok0=
X-Google-Smtp-Source: AGHT+IEejcYKl9fBro2kSxxk5hY4d+88L6bC3+D1SvPJuq0Hk5YpcIl8tPK8uKbkJgY2r7rnpSoToA==
X-Received: by 2002:a17:903:244b:b0:1f4:8d11:723 with SMTP id d9443c01a7336-1f6d039d26fmr43937765ad.51.1717795971902;
        Fri, 07 Jun 2024 14:32:51 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6e78585desm10762055ad.133.2024.06.07.14.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:32:51 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:32:48 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
Message-ID: <ZmN8gER4RnyoyQT4@ghost>
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606183215.416829-2-jesse@rivosinc.com>
 <ZmIqM3Cuui0HAwN1@ghost>
 <ZmJCq7bsglq7olSB@ghost>
 <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>
 <ZmN2U6BDAYRXxHEi@ghost>
 <20240607-wildfowl-baggage-54f622e18c4a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-wildfowl-baggage-54f622e18c4a@spud>

On Fri, Jun 07, 2024 at 10:21:19PM +0100, Conor Dooley wrote:
> On Fri, Jun 07, 2024 at 02:06:27PM -0700, Charlie Jenkins wrote:
> > On Fri, Jun 07, 2024 at 03:53:23PM -0400, Jesse Taube wrote:
> > > On 6/6/24 19:13, Charlie Jenkins wrote:
> > > > On Thu, Jun 06, 2024 at 02:29:23PM -0700, Charlie Jenkins wrote:
> > > > > On Thu, Jun 06, 2024 at 02:32:14PM -0400, Jesse Taube wrote:
> 
> > > > > Please use the exising UNKNOWN terminology instead of renaming to
> > > > > SUPPORTED. Any option that is not UNSUPPORTED implies that unaligned
> > > > > accesses are supported.
> > > 
> > > Conor didnt like using UNKNOWN a proxy for "SUPPORTED"
> 
> I did say this, but in the context of wanting you to actually add the
> performance probing (and potentially the other infrastructure that
> Charlie added for scalar).
> 
> > > Having SUPPORTED is better then assuing the speed to be slow.
> > 
> > The HWPROBE key is about misaligned access performance. UNKNOWN means
> > that the performance is unknown.
> 
> Right. I also don't think that assuming "slow" is even problematic -
> seemingly all extant hardware doesn't even support misaligned access.
> But really, just whack in the probing, it shouldn't be too bad, right?
>

Yeah that's a good point, slow is a reasonable default.

> > The scalar and vector names need to
> > match up.
> 
> That's definitely not the case. A different hwprobe key is allowed to
> behave differently, but...

It of course can behave differently in purely technical sense, I said
"need" because it would not be a very intuitive interface to have a
different name for vector and scalar versions of the same thing.

> 
> > UNKNOWN was already merged and is supported by linux so if you
> > want to use SUPPORTED here then you need to add a scalar SUPPORTED key
> > that is an alias of the UNKNOWN key.
> 
> ...this suggestion of a scalar change I disagree with anyway, so it's
> moot. Unknown should be a state that we only have internally when we
> actually do not know, and not something that userspace should ever see,
> unless there's a bug in the probing code IMO. Unknown gives userspace no
> actionable information anyways.
> 

I agree, returning slow is probably always be more useful than unknown.

- Charlie

> > I would rather keep UNKNOWN as it
> > is, but that's up to you.



