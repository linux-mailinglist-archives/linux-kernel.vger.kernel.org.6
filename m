Return-Path: <linux-kernel+bounces-323012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F597369E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1FF1F2668B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650619309C;
	Tue, 10 Sep 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmO2Ftk0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5rCjD7Cz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FF1925AC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969542; cv=none; b=RWPe4KFR5ZlfbK/G/gMAw2MlFB8IZbHRfLcmhob2LSiKSwwXoYyb/1J70gfyu+JAZ1ocCaEGtnfnSqRay/TMhUuxGF0mxrT4di07CQiGOq6a2FyoMX6t1mUNiiVJGyC8vwvSTyNaNpoFyhhebSAvax+xdus/S3/QH2XmMigoTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969542; c=relaxed/simple;
	bh=dV8YL0PDeFQD0l4KO4/Cvf2dYJxa1rOfjCFZoPH16KI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcRUUJ9nw0/P197c+eL1LTSuJGbMGxoDLWw+0sjWVsiFnZnym5wtgpnqsJLWYLI6+2WyL9ZqlD/b9kjzsFYaydNR9IzhsZZzxa2FQ/E+nLOP711HJufnXlaNGr+5v3Nl70Q634xv5rSrm6VArFX1fba8ebuGRGxEkObt7fTvSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmO2Ftk0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5rCjD7Cz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725969538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO5KdUh0cJs44TGMoULWjclaSe4RKodSz84OoZEGSHk=;
	b=KmO2Ftk0/ulbxQwCzm1ryBhsczS047+ap09MCUd8ygbxQFsOf36fwmYvOkmrlTakj5IrKI
	Q8O1iVmuTMEyVTcsIwzeVmm/wusUJDnpqeprYT8xILg+DPi+wsNJgw4/eRhZkOCZ3gOYPN
	fCQWkA6Gn1h4XzhobFoWuOFLrOsQdELw+THdVg14VQYT1d8dH2TrQXIosvOdHD5qaMJfq9
	eVejvLMOtAijU7JjCw6c/efVR0AGhsMV3cOf8ahiuSNT6HR7OeN15EbnCy/FJfzP3tEpnF
	2zSH9PpF9JgernmBi0pocnZInGaRtA/v4lidcwIkO0k++SD9j9j4jGiYXZPIZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725969538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO5KdUh0cJs44TGMoULWjclaSe4RKodSz84OoZEGSHk=;
	b=5rCjD7Cz81ccSUsKXFbfwlZDAOix13oFo5e18EJ1nJpW+CLiTVMScpaXfmNXQSJ1QhvSN9
	BxS4oAcD/QJshqDw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH RFC] timekeeping: don't use seqcount loop in
 ktime_mono_to_any on 64-bit arch
In-Reply-To: <20240910-mgtime-v1-1-35fb64bd0af5@kernel.org>
References: <20240910-mgtime-v1-1-35fb64bd0af5@kernel.org>
Date: Tue, 10 Sep 2024 13:58:58 +0200
Message-ID: <878qvzbtz1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 07:17, Jeff Layton wrote:

Please describe functions with foo() and not foo. Also please refrain
from using abbreviations. The 'arch' above is not really useful.

64-bit systems perhaps?

> ktime_mono_to_any only fetches the offset inside the loop. This is a
> single word on 64-bit arch, and seqcount_read_begin implies a full SMP
> barrier. While we do want to use the latest offset value available, a

We do nothing.

> full seqcount loop is overkill on 64-bit, where there is no possibility
> of torn reads. Just do a READ_ONCE for that and don't bother with the
> seqcount.

don't bother is not really a technical term.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> +#if BITS_PER_LONG == 64
> +ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs)
> +{
> +	ktime_t *offset = offsets[offs];
> +
> +	return ktime_add(tmono, READ_ONCE(*offset));

Where is the corresponing WRITE_ONCE()?

> +}
> +EXPORT_SYMBOL_GPL(ktime_mono_to_any);
> +#else /* BITS_PER_LONG == 64 */
>  EXPORT_SYMBOL_GPL(ktime_mono_to_any);
> +#endif /* BITS_PER_LONG == 64 */

Why do we need this export twice?

Thanks,

        tglx

