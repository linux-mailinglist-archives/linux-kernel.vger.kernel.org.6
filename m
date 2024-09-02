Return-Path: <linux-kernel+bounces-310991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D154C9683A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EA71F237E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283C1C32F2;
	Mon,  2 Sep 2024 09:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aU2ghH6f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/PkPtDEe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB077102
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270697; cv=none; b=WyOdfZFIudk5h4Yb9LTypaUzF3IBIMLMRmQt12F0IMm6ausQdja6nPBfsEISiG7L9e4oHd49FymOznUHpCnwnLbXK/Room7HpIJyGrBffuK1nWyGj/MguHSgonBNJV+8URPJqm5IhVMrFTtlK7wKqZ6maPzUkkiZOeNYSWKs9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270697; c=relaxed/simple;
	bh=lBWss3WpH1dOEF/rSJfKJv2XVA13bf2pTLclwU9CZQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+oYLN9ygbFf9x+h/0n9F/+YnDH67/F3Z+dVDg3TJOqEPteOFbkJsBqG99GgrN/701ACQtdEqxRT1zVAkLEXNC0dxoyzHMfwRAslExhom5TR9/PLXSyYCphDQBqWcI96elsjPVyVYJn0GwxZUpKoZY1Iuhl2TDe2f8qbVjYsz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aU2ghH6f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/PkPtDEe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725270694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXX4b4vx9EXt2rVqBKrcCvfB/iNzSmFwnGSb8EDwvdg=;
	b=aU2ghH6feVl3O5RfBJsp+YEYGPJ2aP4HNzYELwrdneEvKaac75fForahyPtHE9CjqviWRD
	4r2BqAmgi0m8q9f2FORGBk/f3BwHbwyxF4/d0qcH16CG9VADvQMXfTa0wgICshu+SyvwcF
	UMaqtST9B1tua5/UnAJ0Kc8jCG2LEDZvl8m9krpkOrkG50bNNV7h8HptXfiKoS4THTvE6Q
	cjODwfjDaOenaQwvkiXBMhx0ycfHCRmNfAndVoj508H7t6KT1wOSTjSDfVfPliLoefzCW9
	qB3HAtRW1HU7XaJ3oRmbZO1WWHrUbniaab/O48VpZ8otZ0AggazGnhjC+afGfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725270694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXX4b4vx9EXt2rVqBKrcCvfB/iNzSmFwnGSb8EDwvdg=;
	b=/PkPtDEeywcHg1PNLIjOYlvNlCRANsnfVPpWvrolgEZB9/ou157cVI3DI13JOlvHied7Na
	0+yZpbcI1QXaKhDg==
To: richard clark <richard.xnu.clark@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
In-Reply-To: <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
References: <ZtUuYXSq8g2Mphuq@den-build> <87r0a27blv.ffs@tglx>
 <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
Date: Mon, 02 Sep 2024 11:51:33 +0200
Message-ID: <877cbu7596.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard!

On Mon, Sep 02 2024 at 16:42, richard clark wrote:
> On Mon, Sep 2, 2024 at 3:34=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> 1) insmod()
>>      irq_create_fwspec_mapping(fwspec)
>>        irq_domain_translate(fwspec, ... &type); <- Sets type to the FW v=
alue
>>
>>        virq =3D irq_find_mapping(domain, hwirq);
>>        if (virq) {
>>          // Path not taken
>>        }
>>
>>        // Map interrupt
>>        ...
>>
>>        irqd_set_trigger_type(..., type);
>>
>> 2) rmmod()
>>      tears down mapping
>>
> This just tears down the action allocated and installed by
> request_irq(...), but does not teardown the irq's node inserted in the
> revmap_tree.

So what creates the mapping? If the driver creates it then why doesn't
it unmap it when it exits?

>> 3) insmod()
>>
>>       Should be exactly the same as #1 because the previous mapping was
>>       torn down by rmmod()
>>
> Not the same exactly, the {irq, irq_data} will still be in the
> revmap_tree, so it will enter another path in this case:

That's exactly the question. Why does the mapping persist?

>> So how exactly does that happen what you describe?
>>
> The logic is if the trigger type specified by request_irq(...) is not
> consistent with the firmware one, the request_irq will override the
> FW. We need to keep this logic the same as when we insmod the same
> kmod next time -- override the FW's too instead of returning a
> mismatch type error.

I can see how that can happen, but what's missing is the information why
this mapping persists and why it's tried to be set up again.

Thanks,

        tglx

