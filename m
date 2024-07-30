Return-Path: <linux-kernel+bounces-267341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07A94107A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E81F25E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EB19DFAB;
	Tue, 30 Jul 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0hyiaym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dESyCu4j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCE19DF41;
	Tue, 30 Jul 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338969; cv=none; b=S9LY8JvbIAu4KwM2HNe2lDAgSFrjyPGkQtgWJis+qNOYDFMNJWCZkEWCpoo9iWs9KtiQ2GRHRI0uEe+7ZreifnoYG/RxMhhM5bZUxBU6iy9RJptOVdlo9mFX5sMBkJLhTIM9INW1FsKC7IxOLA8TkUOP09dm2CjHTEZAmJR4W/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338969; c=relaxed/simple;
	bh=aIydPvqJA2em2PQ8rQgyo2FGOfcmh0a+5O18l211/5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5Vz/og/GuqUu3WbUL8MEUOg9y0wgpJqBsx/y/bTJyOk2WIMdbRTHbdx3O4HOdt4fF4W0WBidKVbDPM7On7z3V++q8B+HVha3Je0o8fOJWwlyLow2N5Rs0Rj5UjU6a8K0cuXYD7zr1MBDvSmQqpl73KSOq6m1LBdx1SkWrzMC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0hyiaym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dESyCu4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722338966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTD/R6R0srsJVGCxFPEOiXeBb576WkIuMblUhuZTAbo=;
	b=j0hyiaymqL2DdUjfhT3Vq0LnIl2oArFS1FLzP578NQGGFzOiqLlMNqsbt6rjN+Ts1NYhMX
	hTteEza9ncc0tIAiPLacR2x7rVilXwngsw2He58eFrf9wBJ39c+6yug3MzcP+pBKrT5K8V
	dNDh3x744TmfA9gCPjtwNFdoVemdimoMw0DeiWxc2JKwjPqVks3o4cnO/bzBZJzVpAO7gi
	11S/6xt/4D+26Oo0QfMFCiXmNu31a8mGJ9DPSoDO/BMaFJLY/aqebsnZCXL7PmX4jV6L/v
	CAWjBF/O+iq757EStkCoBbkbHX4HMSiD3xH4APxcwicPBwK9U+GhEDY6WnLokA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722338966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTD/R6R0srsJVGCxFPEOiXeBb576WkIuMblUhuZTAbo=;
	b=dESyCu4j7dkif/Co9M2x5fkynoy1U9lTlSvznKsKHWhLCxufiHK9LkvWqpoVaTLzn6CBKV
	B1HHfPLKWXVrvyBg==
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, kernel@xen0n.name,
 jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, yijun@loongson.cn, mhocko@suse.com,
 akpm@linux-foundation.org, dianders@chromium.org, maobibo@loongson.cn,
 xry111@xry111.site, zhaotianrui@loongson.cn, nathan@kernel.org,
 yangtiezhu@loongson.cn, zhoubinbin@loongson.cn, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Huacai Chen
 <chenhuacai@loongson.cn>
Subject: Re: [PATCH V7] LoongArch: Add AVEC irqchip support
In-Reply-To: <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
References: <20240726102443.12471-1-zhangtianyang@loongson.cn>
 <87o76kuqza.ffs@tglx>
 <CAAhV-H7c0Gtjf-6iS-E4nviMqmPWpJMNwvhWf0fLBx75pDXtrQ@mail.gmail.com>
Date: Tue, 30 Jul 2024 13:29:26 +0200
Message-ID: <87r0bb6ru1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huacai!

On Tue, Jul 30 2024 at 16:51, Huacai Chen wrote:
> On Fri, Jul 26, 2024 at 11:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> > +     while (true) {
>> > +             vector =3D csr_read64(LOONGARCH_CSR_IRR);
>> > +             if (vector & IRR_INVALID_MASK)
>> > +                     break;
>> > +
>> > +             vector &=3D IRR_VECTOR_MASK;
>> > +
>> > +             d =3D this_cpu_read(irq_map[vector]);
>> > +             if (d)
>> > +                     generic_handle_irq_desc(d);
>> > +             else {
>>
>> See bracket rules.
> Do you mean even if there is only one statement in the if condition,
> we still need to do like this?
> if (xxx) {
>     yyy;
> } else {
>     zzz;
> }

Yes. It's documented.

>> > +     msi_domain =3D pci_msi_create_irq_domain(pch_msi_handle[0],
>> > +                                            &pch_msi_domain_info_v2, =
parent);
>>
>> Please don't do that. Convert this to use per device MSI domains.
> OK, thanks. But it is better to split the conversion to another patch
> (so we can convert both V1 and V2).

Why adding it first?

This can be done per interrupt chip. See the conversion series for
ARM[64]:

    https://lore.kernel.org/r/20240623142137.448898081@linutronix.de

Thanks,

        tglx

