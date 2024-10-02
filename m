Return-Path: <linux-kernel+bounces-347604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D498D6DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5424D1F23649
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80CA1D0B97;
	Wed,  2 Oct 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJ4PCkKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GgIhnxg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7831D016B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876596; cv=none; b=HbPX27zN4QH3zBUjDLfvFH5BPYPZsUXnVc1VuG/X3CQie8BWgwdmfEJY8K1Siu13FyuIYO7RfKXStjFcznsNckyTAn7hGfASu6WLrvlwMdlpWglnC751UAMzoFTT2thOSp63HcWxK+0sxpIzGn7Cm0EwSIRmKk50YZa25Pe6w0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876596; c=relaxed/simple;
	bh=lKdaPrbDxYYptUY20vGcv5cxoNG1fG/jWI1EqVTMdt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SursFDCWFlsMOLQLezItqvYuManW8kApXShrcRQkiOaPteU5K+pTQ1+Hu/mZsLBftkUEGfenzuQcvMYOd9m9OzDO//kY77ZlB/vHCnxRBmtHCIrKhoYONUCGDBqL28YCgaX0MaV/Rt2GpZW3ZbVqhE1jH90FMZzdN9UffjnohhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJ4PCkKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GgIhnxg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727876593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whXTKWEOMAgeGAS9876qMUwkTE6aY26TEx5jZc2uCyE=;
	b=YJ4PCkKNbfvfP2++jy8vdMs6by125YjjILEaRFd0RVq5Rj2wFwx7jueEMoUVCQjcedtjfK
	NvkNgyvx5k6WBj3OJj8A3iVMpBe/UR4J6UWP0v5EHpK8jzEEBUyPzAc73b9jnTtpHaIPFx
	lAOO7hJZjACwkJVb3cQxr3UFtIq9x7ccz0S+RrgrIL+siOz6O9aQgfAwbwMu+ZucMvalh4
	6qWXSKzPv4mx9QCfHU2sbrtwljRprU4kUAcFfMrFBLkK4GlF6M81jNoTaYPMjsD7HOwxKT
	cKHZmRqGIPYdPGqmUaW2OqWzS8yvbE7XXcuN1oLJybMZoxjmfsx2lTH3J9DT5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727876593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=whXTKWEOMAgeGAS9876qMUwkTE6aY26TEx5jZc2uCyE=;
	b=0GgIhnxgfhcfTcN3aKWtZQE8UdWJyzvGgrZPc3volSOmQZhmKypRfEHSpO3kJ+buVx1NAq
	liAGqYl0L5MCoBCw==
To: Michael Kelley <mhklinux@outlook.com>, Steven Price
 <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Suzuki K
 Poulose <suzuki.poulose@arm.com>
Subject: RE: [PATCH 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
In-Reply-To: <SN6PR02MB41579C5C46B4F5F72A888743D4992@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240905091738.28544-1-steven.price@arm.com>
 <20240905091738.28544-2-steven.price@arm.com>
 <SN6PR02MB41579C5C46B4F5F72A888743D4992@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Wed, 02 Oct 2024 15:43:13 +0200
Message-ID: <875xqay61a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 03:47, Michael Kelley wrote:
>> +	ret = set_memory_decrypted((unsigned long)page_address(page),
>> +				   1 << order);
>> +	if (WARN_ON(ret))
>
> On the x86 side, the WARN is done in the implementation of
> set_memory_decrypted()/encrypted() so that each call site doesn't
> need to do the WARN. Each call site must only leak the memory
> if the return value indicates other than success. There are call sites
> in architecture neutral code (such as for swiotlb and DMA direct)
> that expect the WARN is in set_memory_decrypted()/encrypted().
> To recap a previous discussion, we want the WARN for notification,
> but also so the most security-conscious users can set
> kernel.panic_on_warn=1 to stop further processing if there are
> problems in the decryption/encryption operation.

What's the resolution of this?

Thanks,

        tglx

