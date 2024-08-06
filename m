Return-Path: <linux-kernel+bounces-276267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E294916C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001831F251BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4826F1D417A;
	Tue,  6 Aug 2024 13:28:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321B1D1F5B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950912; cv=none; b=UZWwH6hIouabJb8bDbHLwblGLQmmHf5mXlpQEBUgTbZmCH4I3WlVuvlSx1Va8JpYE1I6qjzip2yGsGuepwLJJY2zxOhvdPU35CX/6IRBWIiIRuXtE5PtgjN0T8rcO5K2b8XDVvrI7q5dW17KiDDQFtRp4wNOD1AfrJ0+EQAsDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950912; c=relaxed/simple;
	bh=HRZU2bUQQrg9YfoQht7fniD7t6/KgSnU3lZzf1ENk80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFsKBknm4LszNGh6WVryaTrkyq2Bh9dooFVrjDIwQHuVDPUbiC46MSd1CBAjjWTddD2mcrqiRMdQCAv9axcRloeVYAL5T4kT3VC8w0Xpu0SIJg4SGHS894ZGK20irqpI6hOSpLz1hiHf+PjdDNy9fR06l07NyADJgSMBZg63s1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F04E4FEC;
	Tue,  6 Aug 2024 06:28:55 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 272243F766;
	Tue,  6 Aug 2024 06:28:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:28:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
Message-ID: <ZrIk98D9N6-Ln5eC@J2N7QTR9R3>
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
 <Zq4Pg9_BIajyXmSI@J2N7QTR9R3>
 <88e4f6eb-9ce5-4f52-9f4c-4511fe054b94@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e4f6eb-9ce5-4f52-9f4c-4511fe054b94@arm.com>

On Mon, Aug 05, 2024 at 08:30:48AM +0530, Anshuman Khandual wrote:
> On 8/3/24 16:37, Mark Rutland wrote:
> > On Thu, Aug 01, 2024 at 11:14:35AM +0530, Anshuman Khandual wrote:
> >> FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
> >> defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
> >> new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
> >> utilizes recently added macro GENMASK_U128() while also adding some helpers
> >> such as define_field_128() and parse_bitdef_128().
> >>
> >> This patch applies after the following series which adds GENMASK_U128()
> >>
> >> https://lore.kernel.org/all/20240725054808.286708-1-anshuman.khandual@arm.com/
> > 
> > Is that patch merged or not? It wouod make a lot more sense to send them
> > together as one series.
> 
> The latest series [1] here has been reviewed and merged in bitmap-for-next
> tree for testing purpose. Also there has been an additional patch [2] just
> to keep the GENMASK_U128() helpers inside !__ASSEMBLY__ guard.
> 
> [1] https://lore.kernel.org/all/20240801071646.682731-1-anshuman.khandual@arm.com/
> [2] https://lore.kernel.org/all/20240803133753.1598137-1-yury.norov@gmail.com/
> 
> GENMASK_U128() series could have been part of this series, although 128 bit
> mask creation seems generic enough to stand on its own.
> 
> >> A. Example for SysregFields128
> >>
> >> ------------------------------
> >> SysregFields128 TTBRx_D128_EL1
> >> Res0   127:88
> >> Field  87:80   BADDR_HIGH
> >> Res0   79:64
> >> Field  63:48   ASID
> >> Field  47:5    BADDR_LOW
> >> Res0   4:3
> >> Field  2:1     SKL
> >> Field  0       CnP
> >> EndSysregFields128
> >> ------------------------------
> > 
> > Ok, so we get the definitions, but do we have all the other helpers we'd
> > need to make that useable, i.e.
> 
> The first objective was to get the definitions right, so that they could
> be stored in the new gcc __unit128 data type.

I can understand that being the first thing you do while prototyping,
but upstream we don't even know that we *want* to use __unit128, becuase
whether that is desireable depends on how we can *consume* the values.

> > * read_sysreg() and write_sysreg() variants that can use MRRS/MSRR
> > 
> > * Macros for assembly to use these?
> > 
> > * Other bitfield manipulation helpers that can operate on U128, e.g.
> >   FIELD_GET() and FIELD_PREP() ?
> 
> These are still work in progress, but will share when available.
> 
> > Without end-to-end usage this is a bit academic. If the U128 definitions
> > are oainful to use from asm we might want separate hi64/lo64
> > definitions.
> 
> Right, U128 definitions are difficult to use in asm code because they way
> gcc compiler deals with 128 bit data types.

I meant that this is likely to be painful even for plain where the
compiler is not involved, because the *assembler* cannot handle bits
127:64, e.g.

| [mark@gravadlaks:~]% cat test.S
| .if ((1 << 32) >> 32) != 1
| .error "Oh no! absolute expressions are evaluated as 32-bits or less"
| .endif
| 
| .if ((((1 << 32) << 32) >> 32) >> 32) != 1
| .error "Oh no! absolute expressions are evaluated as 64-bits or less"
| .endif
| [mark@gravadlaks:~]% as test.S -o test.o
| test.S: Assembler messages:
| test.S:6: Error: Oh no! absolute expressions are evaluated as 64-bits or less

... and so either we have to handle the hi64/lo64 halves explicitly when
generating definitions, or we need the assembler to gain support for
128-bit absolute expressions.

... and if we go for the former, we don't need U128 at all; hence why it
would have made more sense to do this in one go.

> Should the separate hi64/lo64 definitions be generic or platform
> specific without adding them to kernel bitops ?

I don't understand that question here. I was describing the problem of
the bit definitions, not operations operating upon those definitions.

Mark.

