Return-Path: <linux-kernel+bounces-280852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A066094CFFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559241F2172A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430D194135;
	Fri,  9 Aug 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZ38z0Da";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKAseXSo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E97194132
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205915; cv=none; b=m+2DlohcdzMv/eL/Dd0S5lcPXj+fNTpVfHC7HYfNck9S2PY7xu9eBRBZJw4hY1vR1s3F9bNMAK5jivBRplbiw5guTfjmaba12zjdfVl5VnZXjGTKzA4rBGMQlEgKcEKqLOeUvDC8FBTeaXw0epMXBOzj9R+ZGyMh+xGDjGh1RVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205915; c=relaxed/simple;
	bh=JN23WNdRtVhVb5MRJuAFHn41fxMIElGqqXBAgqu21I0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojrXLZ72YLS6mjXswoCV1gijpjiXlsoG9sFeeZiszsnsh9rjVXh3zXvjzsHe+wOgcH5O1DcDo8mIvPBpDS99WyuUj+Uref6YKpaQteHkBNxk412vB62oxWQHqDIKI3gpVTEUh8/yJtw7ficNBY0gjlgEtjm7LGiI+HBzQ2nobC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZ38z0Da; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKAseXSo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723205912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zN/ApI8O29NUbIRQmQR9dKPaqi08zdj46L4zbMATfBI=;
	b=OZ38z0DaXL86Se3DSqxqPONAKZCgbVO5874FWlz+Q4hnVtyIXBtcF2T1Fe5F89LYkDOQhy
	SxJJAZviQFDfISmKM0tKtc+BjG6uGXz8DYzIfVt257AZlo/mKi7cSAmvV72+BOEDEn7JEh
	WyoUNw/HDqlWffZS7aAAv+djyA/fsG4xIUWspQFGF+MOtlEx0DWor22TsXbaF4o22nbh7D
	p0vROFpgqH8suNKo9KXze2owNKlgx3Sb/N7S3YV9RL2BnRAjUUw94G2oWWGF1sBbI9NMlI
	Rdj6bnZpGWMulAMrXCoir+8qEY6BeEEXG3tghyG3yn7hf5DK/T+3Gig43kgI7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723205912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zN/ApI8O29NUbIRQmQR9dKPaqi08zdj46L4zbMATfBI=;
	b=oKAseXSolFs77oGGv6DrSYkfkDBgy5+nzKtpWESyUAM4GBN/Q88VNl8KajsQ0/kSyLGvql
	kV2/fgevCpz4JECw==
To: Christian Heusel <christian@heusel.eu>, Rob <rob@durendal.co.uk>
Cc: Borislav Petkov <bp@alien8.de>, regressions@lists.linux.dev,
 x86@kernel.org, Joerg Roedel <joro@8bytes.org>, Tony Luck
 <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
In-Reply-To: <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu>
References: <20240725105029.GAZqIt9aLsIaG7JqN5@fat_crate.local>
 <12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu> <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2> <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx> <ZqTufKvJKvotC-o_@vendhya2> <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx> <ZqZ3Kp2NVctgstxs@vendhya2>
 <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu>
Date: Fri, 09 Aug 2024 14:18:32 +0200
Message-ID: <87jzgpubxj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 11:37, Christian Heusel wrote:
> On 24/07/28 05:51PM, Rob wrote:
>> * Thomas Gleixner (tglx@linutronix.de) wrote:
>> > As the number of CPUs keeps increasing, logical destination mode becomes a
>> > less used code path so there is no real good reason to keep it around.
>> > 
>> > Therefore remove logical destination mode support for 64-bit and default to
>> > physical destination mode.
>> 
>> Thanks Chris for applying the patch for me.
>> 
>> Thomas - The patched kernel boots successfully.  I held off updating the
>> BIOS so there can be no ambiguity.
>> 
>> Thanks,
>> 
>> Rob
>
> As far as I can tell this patch did not get applied anywhere so far,
> right? Or did I miss anything?

I forgot about it. Let me find it again and stick it into the tip tree.

Thanks,

        tglx


