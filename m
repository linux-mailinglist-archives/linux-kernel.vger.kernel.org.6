Return-Path: <linux-kernel+bounces-279605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81194BF82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB62D282691
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88818CC05;
	Thu,  8 Aug 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3npnMf3N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSLXU61X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2E139CE9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126739; cv=none; b=kZzqt9X0gd7gBM/Qd/rVeIZyrn8YaacfbLGqrJeTgK24bKgZQt7KQh5vS02AxUbO5sHALE2tji/9bFDks14Hom1mqmqXgxaNQfG8YzSlM1lreYBEj/GdJ6+1iIye36dGRAq34LPDoSR0Kd5rECu5DBG6VVEGEz9/j1CitGEiZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126739; c=relaxed/simple;
	bh=PZ49HpVJAlgrayUxROkNQUxEuyMBp04FILBHdwQgdY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fb9QYTTMSfh2aagnmHzNfj5oTuaxwFp4Xq5J+NbCVnwK98IqbyOUU7IMpoEV0dg+q2/ikTJOcgjirONH02Du1BM6Hmd+2CJs5cfNg57INColjG1nRmzxMvv656QBeSXgRhhggXAj4oksUBCBemEL0uA4HfhrvIm58IDZurxc9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3npnMf3N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSLXU61X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723126730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUA4t6rf5tvFb1UBQskkIqkeRKCvV6+2VPfoOab/q8=;
	b=3npnMf3NFVbUSJWYUrv7kkmUZBp/EhniknUhhe9efFhdiFtQVuDP9miJXe6Lepeb8KZGn5
	eb/6P16BzC+il2vC9lFjaufviD6e2QIte0N/a6K4LIDEdiXQ7ZVTpv0Nv3SUPoD47qZsLk
	ybknxaIiSHIB/7X1zq5+ndxGZBIF15Yd2eWWNvDdsHPVu5Au5xMJeFJhcdf9K62yk6/GxO
	aAZLLBcG6aymkZcNsxkn6aZhVlhhN5egi+n5S9Poi1BGcJoMir4dW1Vb3/F/xLcE/rswKI
	cUyVOXT/jd78NEakkF/MZeExL7KOmpPs/lVYqpWIbO80wcXl8Z3zc5/NBJUq/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723126730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRUA4t6rf5tvFb1UBQskkIqkeRKCvV6+2VPfoOab/q8=;
	b=zSLXU61Xg6CmhOs3ZdaV78JkAPmOYGBun8wXSjBZJnQGqye5Nn9OuKu1UfnlIGdL3aUIsc
	F9TABUGjjtoExqDg==
To: Max Ramanouski <max8rr8@gmail.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org
Cc: max8rr8@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <20230810100011.14552-1-max8rr8@gmail.com>
References: <20230810100011.14552-1-max8rr8@gmail.com>
Date: Thu, 08 Aug 2024 16:18:49 +0200
Message-ID: <87le17yu5y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 10 2023 at 13:00, Max Ramanouski wrote:

> On systems that use HMM (most notably amdgpu driver)
> high_memory can jump over VMALLOC_START. That causes
> some iounmap to exit early. This in addition to leaking,
> causes problems with rebinding devices to vfio_pci from
> other drivers with error of conflicting memtypes,
> as they aren't freed in iounmap.
>
> Replace comparison against high_memory with is_vmalloc_addr to
> fix the issue and make x86 iounmap implementation more similar
> to generic one, it also uses is_vmalloc_addr to validate pointer.

So this lacks a Fixes tag and some deep analysis of similar potential
problems. While at it please use func() notation for functions. In the
middle of a sentence iounmap does not immediately stand out, but
iounmap() does. It's documented ...

This add_pages() hackery in pagemap_range() is really nasty as it ends
up violating historical assumptions about max_pfn and high_memory.

Dan, who did the analysis of this when the device private memory muck
was added?

Clearly floppy.h has the same issue. It probably does not matter much,
but it's far from correct. memtype_kernel_map_sync() looks fishy too.

Thanks,

        tglx

