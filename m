Return-Path: <linux-kernel+bounces-402466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D37F9C2802
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9B9284831
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2091E22EC;
	Fri,  8 Nov 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GCDkp4PA"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B129CF4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107785; cv=none; b=H/MWG0CgYYXrcoWmf1Es+wwGho4oUBMx9GSVvxXO+GB2FvFJsA7BcjhKGCEl4N/8DcueUnHouTKGkveAX8dXKsGiWPPXS10+P7ay4FUYbIht4ihGh5La/CWkm+5R6uxwMOAdYyhdVm2PhLIuvGpwZt0Ye9fbN06Eic5o6PzFgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107785; c=relaxed/simple;
	bh=2nTj6JnOKAQpi9+avRpsHJ9IAPB0ru/zHkNR+iuamAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhD7R01NYCe9t4noy4u6OaSTsklVBT4TPaYF0B8sUOLE629sp4I7/zrRuCEyFHcNbnVocwhr+4pLhWH2UXKKRPLL0Z8eN0I3d+aPpn2tbDzfPqPWkGqzhH5niQnRKMV2BKS6TeA/jfp1qFuUFmKjZiMleqaMTo+fb9y77LRvpGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GCDkp4PA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so2159009a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731107783; x=1731712583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3s19kqrmyY22Y7qqFzMaAHjUFofrm4HNgSWYVbsk21c=;
        b=GCDkp4PAarPkJYF3zFCOJHiBlz3khxykxqrpNDyNFy5ZRmW+53AFnwWl+Qz4xbAfE1
         a4fdlxP6qA03mhAq/g0kVwhoEFyBarBcvw0+8VK8NUg5bqQp2YxFpxvgQoPgMVdJdWdy
         MJefyHXUp9FL4OZmihaIRPcjx1x4ecRcVNAD5XkbO5eKWGG/SuGVbLt2HNvg+Jzcln5q
         0Du466D5XYMpSlLo2kNFXtSUvYwihFZohyNzaGLPeppHT/C665XQjYdsT6rV4lUX2KMK
         1WdDHQGvGx/7JILGbHkDpt7lER0k4/gUW1AStgalY18vdASnGtK64+CZ+C/6vnjavsAM
         ISIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107783; x=1731712583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s19kqrmyY22Y7qqFzMaAHjUFofrm4HNgSWYVbsk21c=;
        b=hWC4XtVfKyD9QXPS66jS5GUIrqn73GX4yADW+Yde0TAvLIerynhaDCT0R73k4OkbNx
         QNmffS0j+GKHG8a8HIdqY6bAGQKSPUlBlbLoK+Vj769Mfa/Qk1ZhzfXq/zF6fwGre90O
         rpYeZTjeh/PSyFRXIimQf/i3tzgwJ3aXyk7mDuJqfOJZE1kURi53kjkEDPDeGQWRr1Uf
         o75ROQTUJROzsE3FHJk/hIMgkCKauWiwIdBl/P6EOmW2xUVxjJZPEB/8O4dAGeSZXgas
         C4NKNQtD3zsqBnm/7/eEe1jxL168lulOCS+YAPfGWD1o9wwCTAJKRx2QE7MZSM0AIuxy
         JGFg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGljHREgIOkQq6/uAch5UmY8TbNWiCL0FJZjqAGj+TKEVIkJ3/BbuAQCqZjmwgYCEWWC5lbFJWwoiAMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUT2uOqn1NYgOy6DYrB8ELebNwRw9ERFj8a4CvMs3zwUq5WrCM
	piX6+6fjLC+5WRCM2QqcOoiup+1M9BEpzDddRzOMnGNC8S6PxtZXuTNHwF+Uj7g=
X-Google-Smtp-Source: AGHT+IHWS2zI7KGQTmBA7oV9V+N8SCN4SRWJ3iSOSny0p4gLDXp0McEBB/xZ6NoObJZivwctCIwgIQ==
X-Received: by 2002:a17:90b:5447:b0:2d8:a672:1869 with SMTP id 98e67ed59e1d1-2e9b174807emr6165396a91.32.1731107782960;
        Fri, 08 Nov 2024 15:16:22 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc82a8sm36221385ad.28.2024.11.08.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 15:16:22 -0800 (PST)
Date: Fri, 8 Nov 2024 15:16:19 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jesse T <mr.bossman075@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] riscv: Fix default misaligned access trap
Message-ID: <Zy6bw8Fnkxl2Q78K@ghost>
References: <20241107-fix_handle_misaligned_load-v1-1-07d7852c9991@rivosinc.com>
 <CAJFTR8RBcoqYmWNmNe_ZixO3bv2aP-wGCbX7ieorXYxxMAa7BA@mail.gmail.com>
 <CAJFTR8Sas83NkRPSuSdbb3qtDNra=cbinPoBmpyt4_ic8R5LQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFTR8Sas83NkRPSuSdbb3qtDNra=cbinPoBmpyt4_ic8R5LQg@mail.gmail.com>

On Fri, Nov 08, 2024 at 05:12:04PM -0500, Jesse T wrote:
> On Fri, Nov 8, 2024 at 5:09 PM Jesse T <mr.bossman075@gmail.com> wrote:
> >
> > On Thu, Nov 7, 2024 at 5:38 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > >
> > > Commit d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses
> > > supported") removed the default handlers for handle_misaligned_load()
> > > and handle_misaligned_store(). When the kernel is compiled without
> > > RISCV_SCALAR_MISALIGNED
> > Technically CONFIG_RISCV_MISALIGNED.
> > I apparently changed `+obj-y += traps_misaligned.o` to
> > `+obj-$(CONFIG_RISCV_MISALIGNED) += traps_misaligned.o`
> > in V2 and didn't change that check back oops sorry.
> >
> > > , these handlers are never defined, causing
> > > compilation errors.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Signed-off-by: Jesse Taube <mr.bossman075@gmail.com>
> >
> > > Fixes: d1703dc7bc8e ("RISC-V: Detect unaligned vector accesses supported")
> > > ---
> > >  arch/riscv/include/asm/entry-common.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> > > index 7b32d2b08bb6..c2808561df81 100644
> > > --- a/arch/riscv/include/asm/entry-common.h
> > > +++ b/arch/riscv/include/asm/entry-common.h
> > > @@ -25,7 +25,19 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> > >  void handle_page_fault(struct pt_regs *regs);
> > >  void handle_break(struct pt_regs *regs);
> > >
> > > +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
> 
> Meant to say to change this to CONFIG_RISCV_MISALIGNED.
> As they are defined when CONFIG_RISCV_SCALAR_MISALIGNED is false
> and CONFIG_RISCV_VECTOE_MISALIGNED is true. they are only not defined when
> CONFIG_RISCV_SCALAR_MISALIGNED is false.

Oh yes, thank you!

- Charlie

> 
> > >  int handle_misaligned_load(struct pt_regs *regs);
> > >  int handle_misaligned_store(struct pt_regs *regs);
> > > +#else
> > > +static inline int handle_misaligned_load(struct pt_regs *regs)
> > > +{
> > > +       return -1;
> > > +}
> > > +
> > > +static inline int handle_misaligned_store(struct pt_regs *regs)
> > > +{
> > > +       return -1;
> > > +}
> > > +#endif
> > >
> > >  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> > >
> > > ---
> > > base-commit: 74741a050b79d31d8d2eeee12c77736596d0a6b2
> > > change-id: 20241107-fix_handle_misaligned_load-8be86cb0806e
> > > --
> > > - Charlie
> > >

