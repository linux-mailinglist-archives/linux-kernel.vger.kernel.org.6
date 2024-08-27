Return-Path: <linux-kernel+bounces-303890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF6961688
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0FA1C22EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CACB1D27A0;
	Tue, 27 Aug 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="T8IGj4LS"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3090B1D2784
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782391; cv=none; b=B/CnummVG1ehta8xR6H0l3ODOFlZrHdKI3zysLSDBlug74hcxd5qgM1SybOrZWaTORhpg18T20BgzQeQgIzaYaiQcGOmx+cQ1YIVU1KiM/caTEScJQBhB518HboRcAtNswIbuYp807TiRbOA42UIFoVEeD3pULbBxnW7xbSEgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782391; c=relaxed/simple;
	bh=VcDmWN5tuvcf9Gn2Ph/J9APylvM2kII9TBKe7Yws0B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWepz65HSn2s+XRMg2QIiDqph3DHQ6itkgVYTbWpSXP1VqkkWz5sQSI6jS7cLNY5hJWnTe7tkkxL3FjqgtMHhFT7oCuDyxXWyrjawQJE5U5qkJVt903vUeNrjRXTkT6lc+7RAY79cK29hKafidvQjlMuh79uVQH6aUVu7HAeXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=T8IGj4LS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714262f1bb4so4251539b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724782389; x=1725387189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPA+hJJLDVmD4KICeVltx2lJ4690a/Dvth1Aghkw/GI=;
        b=T8IGj4LSz6ZqOTtZdiBqpcdDSVYPZqZuDsAAKj8WVbHRE3Sgd6f6SB3cz6Z7eXOAd2
         AWMn2InNC3ojBFKzP7plIFim6q0XazjhM406gIemkkMQ5q10ODD/aQPI5NZrMkevk0rU
         f+mLezGsWusptwHZgjD9UK+D5M6Sy7Ptz8AlR4nd6a6vIYOqctIrb5rxZeNqJijVt2PG
         g9KhzpkK1S4zE5ZQZiH8kQ0ObtvJ1f39J9cvTz0Pe2m0MflufXIVqslTKzhzIahnVdhg
         xY7NjV0y8vs0TjnmJ9wH+3WsHAVn9YSedznZlJrMZ+fSS8vRH3JqHXoJxlExqqUVx1f/
         25Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782389; x=1725387189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPA+hJJLDVmD4KICeVltx2lJ4690a/Dvth1Aghkw/GI=;
        b=JQZGzWpzPhCcL44FDzuF7mc8n9UgVe40RrzSPQ0iPVzbUrsWOFV+OHcfb8NpdMVV/Q
         RbuEu1BwN64coeU49CH7NZyKqzwlWWI5H/nBIi59Uw6EYCPkiMH61JHfaM3HSotzXaNS
         e90hme9yXhomMTsXm6lKEXbhEg5SXR6bsfBzsIJGqW415fu3dv5YWyZq2/oW813Gwc2L
         +9mZV1uNrL2prk8xjax4bKfqgFQEA9bfE4/EaVF4FSy2dmJTN6m7MrjuuOeUynyzz92m
         gLCzupZQzjtnYgvuDor13KS0KM3d7oQHbNCsDC1UW11s9bx1aGev5FpB+9TIzzRqCtZa
         +GGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0LdM5TzPugcyzQPSTKJqXRPWLpKBABSBoEVqG6504t4FJHnlmhmBtgaERzTXkf0mjbL+CU0K7MJmd1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YynwA9K2x75q1sqzAElYvGzJXUlB/7oZQWrQOngPGLyQLqnCJfa
	r+vQ1ATZns+0oBiCZsDMS6HjrLYP9OfAC95k9Wi1lyXkxZQ5IJ7F6iuR9qIki8I=
X-Google-Smtp-Source: AGHT+IGEsVPP4TjFJ+n/ifWb2tjPXQhtvEJKI4QpcXf0fpsIED85YBXgVczc0V+0pl8DdWJzUA5R6g==
X-Received: by 2002:a05:6a00:91db:b0:70d:311b:8569 with SMTP id d2e1a72fcca58-71445ed4f93mr12988732b3a.26.1724782389449;
        Tue, 27 Aug 2024 11:13:09 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09c3sm8820322b3a.122.2024.08.27.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:13:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:42:58 +0530
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
Message-ID: <Zs4XKootCrW5ZPy7@sunil-laptop>
References: <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
 <Zs4HCZH3M9nRXUvu@sunil-laptop>
 <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
 <Zs4NcmM79kMUc7Ol@sunil-laptop>
 <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 07:56:52PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 27, 2024 at 7:31 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 07:12:11PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Aug 27, 2024 at 7:04 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >
> > > > On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > > > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > > > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > > > > > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > > > > > >> series on latest RC release. Should I rebase to linux-next in this case
> > > > > > >> and send the next revision of the series resolving the conflict?
> > > > > > >
> > > > > > > No, please don't.
> > > > > > >
> > > > > > > That will be resolved at the merge time.
> > > > > >
> > > > > > Alternatively you can pull
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> > > > > >
> > > > > > which I'm about to send to Linus latest tomorrow morning. That contains
> > > > > > the conflicting change.
> > > > >
> > > > > So I've applied the series on top of the above.
> > > > >
> > > > Thanks!
> > > >
> > > > > This included a full-swing rebase of the last patch, which I hope I've
> > > > > done correctly, but Sunil please see
> > > > >
> > > > Yeah, sorry about that. You have resolved most of the conflicts but few
> > > > are missing (which were not obvious anyway). Could you please take below
> > > > commit and squash?
> > > >
> > > > https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a
> > >
> > > Can you please send me a diff?
> > >
> > Hi Rafael,
> >
> > I have sent the diff to you. Hope that is fine.
> 
> Squashed and pushed out, please see
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9153fdae30867fe5d71f6a15b8a1974d7e801f39
> 
LGTM. Thanks!

