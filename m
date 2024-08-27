Return-Path: <linux-kernel+bounces-303826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B696157F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845FBB22C76
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A41D0DD4;
	Tue, 27 Aug 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RsXHOS43"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB91CC8A3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779903; cv=none; b=WLQPLGFUnJ2/lnA+oJo4UboNhbpcKk8Ndzw+09Nw6hvxG/vXA6DXV1CgotPXU1tG28ateXVzPixdUar7UNEKMbKQcnDg7594lL+54YEqoF4Vp74j0h/qV7PjHz21defvhCHSWvRAR/Yx52r+cRkgmWeVF1hD5mXYLTFuMjpS6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779903; c=relaxed/simple;
	bh=lMxqEwCHue8352wDt5PH7yOS5++RVWZI4siqNz83c6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5o+JX9iOMfG+REPxMqubvaKpPIHszYgPOVwcY1CX4AsAs2LX/Jh6v5/gOKbGPG4f+HMeZGyovSYRaROOXXiE4HHFvr1eDyxZDljqgFjIFx9GfVpKzVQQ7dLu+TRTfzeJvespdfJ96jfiwQtPXGEAXuAiG/hEa0AOAlM1IdveIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RsXHOS43; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201ed196debso51393875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724779902; x=1725384702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eyakK3kXJdL4Hi3Zxsy/Z79bQ5vm7LShwCBS+rqjrc0=;
        b=RsXHOS43G83ILp37rTqwpKoc16N4UGyWsy/s541Hn/pwkwjSLWlGH6qgRv4F636TLe
         MRnHjpSwh5Kj/4/2sWjZROlFhNt/M19uPT6EeRNEwIqjqR2vLiAQFtpYMOGpyZOFSYPm
         vBipS61h2rge6H5FeoYhfa7GUB4QEmC7ebEtaIWTnMlYt7l0dxyl3bAghdR4uv0KILWR
         FhL+FfZInqSh51bdBKdEI8rV8qmv49UMojjsPNzK8/T3yVfR92A5hJ8GI79OUTbz0mRG
         gaH+UV+MMiC2QiEp9FOg1spbuaeZCzWlN9uVsqJL1cpdrJJ8R8LWTKuhbdOE/grtSGLk
         oG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779902; x=1725384702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyakK3kXJdL4Hi3Zxsy/Z79bQ5vm7LShwCBS+rqjrc0=;
        b=OLefC2iL15xEl+nAYNIVpOdl/YB2f1pEpwSfrLS4UcDMPFFJS41pAaUmCfT4mNpND4
         apffWBEYcfHycgxls7i2tNRAhLWwuv5UiX4TH+pf2O5RfqHF2KT4ZhfqLeAcZKGV9K88
         Ut0E2/IGMNU0NXtoeGgfFtb7KT0/OuIfeLxKqjqbRMfE17wy8HSiEVKnFFWdXcDe8Rod
         cBbiBxjpNOUj6QDAUl+F5FHR3B0ypcSc5meBYTKkbRV2gIMOpwLEqaKvc5gjTtx5zFAf
         Nfx9DhVA8BEt4v6nBsSAW5il5hX3nZeBCyHRAhI8FuJnEpDWW3aAufeU3cA8SAE8/IDe
         4hmw==
X-Forwarded-Encrypted: i=1; AJvYcCXmHKo0SO1uPm2iJZiB/qUwf3puZLfUNZ/9Tdp/kBDaArBpCck1yYN3lIyDaB0IsifeDCCgwCQBs8YGV/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfkPsRI10SZcGt7Zz6U/jklKZOtjDQFYO26oEdawn9y355JtD
	NDudazUP36Q+Ki7FQi0fXLzdsA1qnktB/ntsDo7GRYbFMJoDt4fZAzbzwrQAJ4o=
X-Google-Smtp-Source: AGHT+IHflfR+4oEKIX2AdkLpfmbDgIyQiynrQVhbNue6r8R5xP1CRH6FV9dXMTMD0eIz75yo1iaVkQ==
X-Received: by 2002:a17:903:2349:b0:201:cda4:69cb with SMTP id d9443c01a7336-204df029fbamr35148895ad.9.1724779901775;
        Tue, 27 Aug 2024 10:31:41 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566611sm86220445ad.2.2024.08.27.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:31:41 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:01:30 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <Zs4NcmM79kMUc7Ol@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
 <Zs4HCZH3M9nRXUvu@sunil-laptop>
 <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>

On Tue, Aug 27, 2024 at 07:12:11PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 27, 2024 at 7:04 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > > > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > > > >> series on latest RC release. Should I rebase to linux-next in this case
> > > > >> and send the next revision of the series resolving the conflict?
> > > > >
> > > > > No, please don't.
> > > > >
> > > > > That will be resolved at the merge time.
> > > >
> > > > Alternatively you can pull
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> > > >
> > > > which I'm about to send to Linus latest tomorrow morning. That contains
> > > > the conflicting change.
> > >
> > > So I've applied the series on top of the above.
> > >
> > Thanks!
> >
> > > This included a full-swing rebase of the last patch, which I hope I've
> > > done correctly, but Sunil please see
> > >
> > Yeah, sorry about that. You have resolved most of the conflicts but few
> > are missing (which were not obvious anyway). Could you please take below
> > commit and squash?
> >
> > https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a
> 
> Can you please send me a diff?
> 
Hi Rafael,

I have sent the diff to you. Hope that is fine.

Thanks!
Sunil

