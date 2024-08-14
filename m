Return-Path: <linux-kernel+bounces-286581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81023951CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36095282B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B861B32C9;
	Wed, 14 Aug 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODQSY6hO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMCWSYFl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245871B29BA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644695; cv=none; b=o5Y8ClklAyI0JBoyQO9PytQPbgRY9Cpo4LHeQlIMUUQAORGr3w6n/fYHyQZ2SdI23BMPqq9ya9UsEEyk1zSFit4KnO5COjAffoQHZdy8sm0caXj4GFC1TfeylSBmyG9FAGns285uzv572mnSHtcs4hgOMQxcgnRRn1F+MpH6oA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644695; c=relaxed/simple;
	bh=QMjWwqjS9TOTssR81pDXKtNQ5aMSZkZMYENMeVdxWa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S+9AzKavSrr/eI7bwquNAW+Lqv++WcUngvLXX1s2AMNIzv3jgp+5aODdn4jaczmQk/6r9C6tjuzHLPLQq0BYNBinwXM6ZIyjWD/LtPaGoIBwWcZ8LkwLopa+LLG4NCY4j4t3+1HZBW3mP6MlqcrV8/Cq9gj1fTuWtPfsaUTUnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODQSY6hO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMCWSYFl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723644692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1AhgiSWd4CHbyJVRcAUEEiIVnvLy5DrEW8lz6MAKjM=;
	b=ODQSY6hObDfscF3DXOwJHOfLU+seGzt1TE/bjezu3XDbLMh5Xi6riBqPqQ6nb0oOK9KDXS
	f8+1CtrsnTsr68nSLVjVnSmeksFHVxiEwBDFWt6ZeMO9YiZJsOAwX3yvfc46lNxxyqtVUZ
	3u3grBa0md7iyoWN+ktmH2bMSEElLXavibBRLs/lx0R4QqoM2dTmtid9WZaZF+yz78Arzj
	IKf7EylEh33wBF8hfHpS3O12pdSZRTuxshqkFndnQxgBhat6Odd15dxNPmjafhtGzGMfcx
	uS3Xr4uj5jGgUqZcNmdKzJqM159oQg0keCyUOkREO/eZlVxTWm1xcw9O6oLNYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723644692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1AhgiSWd4CHbyJVRcAUEEiIVnvLy5DrEW8lz6MAKjM=;
	b=YMCWSYFlVF1Ph7fRO3ylWD2DNyVlLYqTFg573JIEwa5UA1vIRvpCUdxgCfJ7c1IG9g5YYR
	O9fms278zo7AVaAQ==
To: Christoph Hellwig <hch@infradead.org>, Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Max Ramanouski
 <max8rr8@gmail.com>, x86@kernel.org, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 jniethe@nvidia.com, jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
In-Reply-To: <ZrygJqIAz_AqqjcT@infradead.org>
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org> <878qwzpfbi.ffs@tglx>
 <87le0zmhdp.fsf@nvdebian.thelocal> <ZrygJqIAz_AqqjcT@infradead.org>
Date: Wed, 14 Aug 2024 16:11:31 +0200
Message-ID: <87wmkjnqi4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 05:16, Christoph Hellwig wrote:
> On Wed, Aug 14, 2024 at 10:08:23PM +1000, Alistair Popple wrote:
>> I would tend to agree and had the same thought when we found this. At
>> least some kind of message (WARN_ON, WARN_ON_ONCE, printk, etc) would
>> have made the issue we were debugging much more obvious. FWIW I have
>> tested running with a WARN_ON() there and it never fired except in the
>> bug scenario.
>
> Various architectures had either an early ioremap variant that got
> silently ignored here, or magic carveout that don't get remapped at all.
> None of this should currently apply to x86, though.

So I'm inclined to have:

       if (WARN_ON_ONCE(is_ioremap_addr(addr)))
       		return;

in the x86 variant then.

Thanks,

        tglx

