Return-Path: <linux-kernel+bounces-177306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788958C3CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B76E28621E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544CB147C60;
	Mon, 13 May 2024 07:52:28 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199F1474DB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586747; cv=none; b=OJvn/jMLao+d4pRArfomFBx0b+TzuFZoyB1P1f30JARR61NfN3McufBmAffwOi8fuebEi+Y81na9bOJNueAvVe0OnCR60eqS+HhlxUd4pKpEp99JLt9Ofzs+g3WoU5Ti5PyxdvVwUmCjUV9oIyIpbQf8kYHinLrlNPBCPyCOcgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586747; c=relaxed/simple;
	bh=XFhq+fS8vngKltkRwhFgEcYvz5ZZ2cNTyMUN7weOJ6s=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dMwCcIxzA5PunGPQQAHxai8OVM30HxfVzen3Ix5bbHuurAJM5CeEUd88xVyumtnIHqNpI8k/fv5vb13o03fS4yNzycp//AbPyYb43aBupJOxVpRPfIp/lL7y6vmVMtU5Pfm4uPVnOY1RMIvfKEuPqKPGnBx64O3yeFR04KE0S+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by andre.telenet-ops.be with bizsmtp
	id NXsP2C0025V4kqY01XsP2g; Mon, 13 May 2024 09:52:23 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6QTv-002Sz9-12
	for linux-kernel@vger.kernel.org;
	Mon, 13 May 2024 09:52:23 +0200
Date: Mon, 13 May 2024 09:52:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9
In-Reply-To: <20240513071306.474132-1-geert@linux-m68k.org>
Message-ID: <da4545f2-3016-70b-7eec-7ba6ec4f5d95@linux-m68k.org>
References: <CAHk-=whnKYL-WARzrZhVTZ8RP3WZc24C9_DT7JMJooONNT2udQ@mail.gmail.com> <20240513071306.474132-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 13 May 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.9[1] to v6.9-rc7[3], the summaries are:
>  - build errors: +6/-1

   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]:  => 254:1

sparc64-gcc13/sparc64-allmodconfig (seen before)

   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]:  => 282:1
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]:  => 307:1
   + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]:  => 343:1
   + {standard input}: Error: pcrel too far: 561, 563, 572, 554, 552, 579, 543, 545, 590, 570, 581, 588 => 572, 584, 568, 550, 557, 545, 586, 581, 570, 577, 575, 593, 552, 548, 563, 559, 561, 566, 543, 588, 590, 595, 554, 579
   + {standard input}: Error: unknown pseudo-op: `.cfi_def_cfa_off':  => 609

sh4-gcc13/sh-allmodconfig (ICE crickets)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/dd5a440a31fae6e459c0d6271dddd62825505361/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

