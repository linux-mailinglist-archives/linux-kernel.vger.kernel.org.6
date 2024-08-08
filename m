Return-Path: <linux-kernel+bounces-279676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F330994C05C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E14F1F28767
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3618DF75;
	Thu,  8 Aug 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/6v9ohB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AcCE30f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59318C346
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129073; cv=none; b=Ecytqd1p9ZPflwvlGsyUkh8xoYwtSNZZJzIYF33zSjxFcCGurjeV8x8U4JHk2PqbkS6+uYxk3TEVj2OVUqCjCX8F8a1VPjP3DHtr9zMd+zZpC3UjER1Fu92N9a7USPLU5X40IwVB18PsW09ywc0mKxKfU3leuHzK4Ww6HoNoZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129073; c=relaxed/simple;
	bh=4sHV/cuo1auDM5d3jkLz3V1UZdyzVmWHEZVYR1Jewt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Np3YNGf/QihH+DbYReERAhCNTvzALI0BN/EQ+Xiufa7Sd+LPFbzIT/Rfndk7p0V3A0HGuB1PCe/5Asih1lRYH1rMX1G1/qmmvDMX5NqaqGIdpOiMOnWZVtyKkZ1LAgxAHWXMM3cHOzbIzkAqKE8rjp8iqpievSNK8uHHi6vsb80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/6v9ohB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AcCE30f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723129070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcU8jHNp+0iq+RbsEV6EN3ntmm5cSHAiATW/SrWGmEQ=;
	b=R/6v9ohBbuRdP3zwMnO/cZvKQKW3izWBpmlfacSfMedeDL+wEXg57vlzsjn8AuiTGRQMIa
	s7g/NNiArIJW5eMfLj3k75deqAdDi0dTzZjA5vH8JX3c0abT1ePEYcMFybS5v0WIS1Tnhn
	pXysLIykRPCAo1ewNYnNZRV04rSxex1i7XQMjEpjTK8rZNLMbGspvkVwxzIr4EcnGKVmMl
	CcYrQ27+4JgiI3+7WSpI+6JF4bcDNzddKQGgC9fArTSmTC5paeDuMMEAKkTPhgVWTy8JCY
	YwTPqCKwY+QsbFeIcLT178daUHq/2vKxOszy1a5dwUQC4Z51hIqwOXCYDLnBIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723129070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rcU8jHNp+0iq+RbsEV6EN3ntmm5cSHAiATW/SrWGmEQ=;
	b=1AcCE30fL2txXoTbcNJs1x2KaLfEwHcspQcbNxVbz0BcdKOUdh78hrQxMFTwC25hz2aZk6
	GsuzW+ATyahrKoDw==
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, michal.simek@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] irqchip/xilinx: fix shift out of bounds warning
In-Reply-To: <1723101895-3470952-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1723101895-3470952-1-git-send-email-radhey.shyam.pandey@amd.com>
Date: Thu, 08 Aug 2024 16:57:50 +0200
Message-ID: <87frrfyscx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 12:54, Radhey Shyam Pandey wrote:

 irqchip/xilinx: fix shift out of bounds warning

Please start the sentence after the colon with an upper case letter.

Also you can't fix a out of bound warning. You can fix the code which
causes the warning

> In case num_irq is 32 there is shift out of bound and result in false

What is num_irq? This is text and not subject to random acronyms.

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> warning "irq-xilinx: mismatch in kind-of-intr param" . To fix it cast
> intr_mask to u64. It also fixes below shift out of bound warning
> reported by UBSAN.
>
> UBSAN: shift-out-of-bounds in irq-xilinx-intc.c:332:22
> shift exponent 32 is too large for 32-bit type 'unsigned int'

Something like this:

  irqchip/xilinx: Fix shift out of bounds

  The device tree property 'xlnx,kind-of-intr' is sanity checked that
  the bitmask contains only set bits which are in the range of the
  number of interrupts supported by the controller.

  The check is done by shifting the mask right by the number of
  supported interrupts and checking the result for zero.

  The data type of the mask is u32 and the number of supported
  interrupts is up to 32. In case of 32 interrupt the shift is out of
  bounds, resulting in a mismatch warning. The out of bounds condition
  was also caught by UBSAN.

  Fix it by promoting the mask to u64 for the test.

Hmm?

Thanks,

        tglx

