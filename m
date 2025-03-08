Return-Path: <linux-kernel+bounces-552477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57AA57A30
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3560D16DA1C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D31B4F1F;
	Sat,  8 Mar 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+jjazw0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYlqgFw8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3891AB6D8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741437279; cv=none; b=Q2ZbvDAmMlHPIDQv/pCta2FqJZOB64DeqRv6zhrPFlsIauyLgNggZ1eqK+S3GKziuAAt6WGMau/k8kcMENmyHczOgriibhHgeDTiPf7lpQ6B5HWBSz9bYj4vVz1hxCQa7XzGKiIXYfgwoEcs1/jxAvkDrZA5RQxu933YyVsQpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741437279; c=relaxed/simple;
	bh=u/GCCRAF6OglPtGFor65TgUnaoI2HcQTBF1oVQfsvCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPhPF2n//32v1OEuizAUcOYs3gucPUp23ds1bRL7quf7+3NzwkImEFl3ePiHeZABEZGDXHaUSm8AlMD3Zr8IFWPvTFmScd1894lHSe9kj8mPQ5+DoXQQ4qfLgupaZrAQOY4J2oHfT1CkIrS//Xe3203OMic5dM0ZsLPQ1RN5Pds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+jjazw0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYlqgFw8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741437275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2blBD4fHIkvRv51nR2l7bcgZxhbB6DMGzjOTU3SM5Q=;
	b=Z+jjazw0OOzesjK0osIFPH5S3ZUjt2QeZDlLD3zQ2Ve8ksNDkxRPVZAdYbr9in5W69xj0H
	YJ+UsgKtKNt4Xn9gg8Zoz8Z9T+rId6QwlHwW61RKntM35wS3ISYcw9Y812xS9x78toCp/Y
	JyS+grOJB49ujhK9GtCysqRfJ9FgtA8JUWPc/Ar2qBbS7SDcRvFnei75tEOJQKvbeKelNA
	7STOFY8lwYUfhUX5jY9lwT9eSp+ayTkiT6AOICqtp2cXFDYE2vV1G18VU1Cn5u4nxYA2sB
	vFRSQo9Om5O+okkXwB1Gjk0Hhke6rTQznYBNvXDVg6Ty6if3JbZQZhyoCptZPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741437275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2blBD4fHIkvRv51nR2l7bcgZxhbB6DMGzjOTU3SM5Q=;
	b=BYlqgFw847AHpz5mygpTb8rcgFx9j6gTO5BMRE2inUYFpxC1rSGEKOQYjNwb4ma2ehnzDz
	tnAd0H8lwmSBofDA==
To: Dmitry Vyukov <dvyukov@google.com>, krisman@collabora.com,
 luto@kernel.org, peterz@infradead.org, keescook@chromium.org,
 gregory.price@memverge.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] selftests: Fix errno checking in
 syscall_user_dispatch test
In-Reply-To: <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>
References: <cover.1740386567.git.dvyukov@google.com>
 <d11d91e0c27ef78affcef06e00d1cf4cd8747fcc.1740386567.git.dvyukov@google.com>
Date: Sat, 08 Mar 2025 13:34:34 +0100
Message-ID: <87v7sj3dlx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 09:45, Dmitry Vyukov wrote:
>
> Also use EXPECT/ASSERT consistently. Currently there is an inconsistent mix
> without obvious reasons for usage of one or another.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

As Gregory said, this should be the first patch in the series with a
proper Fixes tag.

>  	/* Invalid op */
>  	op = -1;
> -	prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel);
> -	ASSERT_EQ(EINVAL, errno);
> +	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, 0, 0, &sel));
> +	EXPECT_EQ(EINVAL, errno);

Seriously?

Something like:

static void prctl_invalid(unsigned long op, unsigned long offs, unsigned long len,
			  void *sel, int err)
{
	EXPECT_EQ(-1, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, offs, len, 0, (unsigned long)sel));
	EXPECT_EQ(err, errno);
}

static void prctl_valid(unsigned long op, unsigned long offs, unsigned long len,
			void *sel)
{
	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, offs, len, 0, (unsigned long)sel));
}

....
	/* Invalid op */
	prctl_invalid(-1, 0, 0, &sel, -EINVAL);
	/* offset != 0 */
	prctl_invalid(PR_SYS_DISPATCH_OFF, 1, 0, NULL, -EINVAL);
        ....
	/* The odd valid test in bad_prctl_param() */
	prctl_valid(PR_SYS_DISPATCH_OFF, 0, 0, NULL);

But that's not enough macro uglyness sprinkled all over the place and
too readable, right?

Thanks,

        tglx

