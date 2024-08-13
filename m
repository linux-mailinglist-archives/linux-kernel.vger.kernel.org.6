Return-Path: <linux-kernel+bounces-284305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1782194FFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D5282ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241713CA97;
	Tue, 13 Aug 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFl153jk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mwh/zyf7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40326F2EA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537265; cv=none; b=iPhj9K4G9qhOEOtARmxunJkPh0D7Q+r7BAghFn742LyJwlPuUBswDnSRNkib9LkK9D8/CFgNyKsoAmL/5Ph+Ua0h/Hq7vZJeS5Hr0Dcj/PPHz4VAJgkbZDquUzLUKZS6MAawyZj4wX1tbWy004IeI3+A2Q2KRVDytdPQ8Vbjf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537265; c=relaxed/simple;
	bh=c9rbshkfD/V9CoFS0QeZSkXs26ntSZSRUx2ZEzx3nz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iI66mnHyzvlDDq57i/zTKQH8B9dik7OeuF1tHocJ3IeAOJ9BYrzmCeIR7Ielmh6az9a5qDcjEhDhhwPvhdncC8sMzUblwd8AzEhTqXXvfSFaC9n+8ybY+LZQ58pfyWu16GFV8wmjmcQ9z7vy5TqAFDDFg4ycQaifz0Fv1DQPavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFl153jk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mwh/zyf7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723537254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38F3sNH8ztiaiNG0ZcMefUPwKEiefKhLvCbe0mEnWeE=;
	b=iFl153jk0ch/4/FPzdddAzA9AYNVCb+Baz4vyd8s9Lz4OmFywtgxDYElJuG64DHNnkikDu
	PUJwc4e6ch93ej+uPIMvNIWNwjNCqYLi6XP0bHiEFay1yW6qzTyClVfcNwZcZ4rEWXBIiX
	6RQ0sFnmwwtZsbGae1CmRWe2W+i+ou7JI1291vuBSF8kaNfmQwM3a3bAjjR6yXm3ls8Wha
	rQVStQ7/H0SksnCnRAbKBJtaw8axRzaJLeG8v35BfVqrST13ySjeWb4BES9YnjzFe1vj9x
	Quqx4C2gC6sGe46xqIvMvvmsWe5e9+OApwtjMz0LDwgzFhoc+I0wYz6abQC1iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723537254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=38F3sNH8ztiaiNG0ZcMefUPwKEiefKhLvCbe0mEnWeE=;
	b=Mwh/zyf7fOzrbyoW/Z7rrm57Xarf3qSB15hhrNuHcoKyX8NL6TLSduZCHloOChEamW7cKC
	3ttIXrrP5MTEHUBg==
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
  Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <87bk1x42vk.fsf@nvdebian.thelocal>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx> <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal>
Date: Tue, 13 Aug 2024 10:20:54 +0200
Message-ID: <87sev8rfyx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 11:33, Alistair Popple wrote:
>> On Mon, Aug 12 2024 at 12:03, Thomas Gleixner wrote:
>>  
>> +#ifndef PHYSMEM_END
>> +# define PHYSMEM_END	(1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT))
>
> However I think this should be:
>
> # define PHYSMEM_END	((1UL << MAX_PHYSMEM_BITS) - 1)

Bah.

