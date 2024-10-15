Return-Path: <linux-kernel+bounces-366851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42A99FB72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FBD1C23B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6ED1CBE8A;
	Tue, 15 Oct 2024 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45AT27Ng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZWm6qDN8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8E21E3A4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729031316; cv=none; b=dPc/eD5ePIHbQqRThSYCvpuWn4WyEFkmy1ZhYOcKJr6q5uujEpmEczO/mBRpP5b+O4crOzOLKj8ioLNk7UawzXZyWq33ch7qUScjLdFO56NZ/BSTdn6iuK+DazosLLACCFD1qHZzwiglPIrzJZ5qmbagbhMstkCJPJKrx5mb4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729031316; c=relaxed/simple;
	bh=7kCc5P3nYypQ+DSN3mEIqF1s3DGPm4C7cj53hn5IjqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKz7mnHmgY5wtOT3F7D7eU2TqARQ070wWC9RFZiAB30jvzQpXG9Gwotydxo9yBAKRJ4h6aSAbyFm/8U0kgQFk9vW9KpQFapSJFAvQBqjwS297p4YSf46H9LFNDwlJMZstj2enfkwTmv/SAjJdNnTOGK3kp6AOzFMYbzl4wU9k8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45AT27Ng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZWm6qDN8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729031312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOYmPMGxBG4u2ssHn07KTR5Q3rDwMwSrXrOzMkyOvzg=;
	b=45AT27NgEVuFPbaaRhWNuRrbahbQMlVPKWrevohxch44/+vx4JIwd8XRNUYYCZfNtv9gJ5
	/T1GeSM5mAy5F0OPXHYY90wJd8KfBY2oIHlWBSSjVAfoSBSewiipHH3nAv3U/YiQd0W2tq
	UBBNwiygAvlJiCj/hGd9VLjF/Jd4YnGY5POqfeGiinsVmmEpzO7KlsNnc7YiEX1SENXWPB
	jAmgs6DV7Z0Qi/PGAOxLb1bp9IlmIFlkYUPxkxyBLFmJeOy4Gbklcym813YNoaH3TyEnvj
	9492e80F9tklt8uC9L7sUji1Guwb5ZiciBQx6lVekCMbX4Y+NL68tviACAlvBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729031312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOYmPMGxBG4u2ssHn07KTR5Q3rDwMwSrXrOzMkyOvzg=;
	b=ZWm6qDN8y7KRHPmnPvhXs9Jtsj6TIk5g/EKAseaIs4qJQVoX/fsnqtwlhGinRD0p77vUc9
	4M/Rn3AiMe5STCDw==
To: Benjamin ROBIN <dev@benjarobin.fr>, jstultz@google.com
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org, Benjamin ROBIN
 <dev@benjarobin.fr>
Subject: Re: [PATCH] ntp: Make sure RTC is synchronized for any time jump
In-Reply-To: <20241006165805.47330-1-dev@benjarobin.fr>
References: <20241006165805.47330-1-dev@benjarobin.fr>
Date: Wed, 16 Oct 2024 00:28:31 +0200
Message-ID: <87y12pc86o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 06 2024 at 18:58, Benjamin ROBIN wrote:
> @@ -2553,7 +2556,6 @@ int do_adjtimex(struct __kernel_timex *txc)
>  {
>  	struct timekeeper *tk = &tk_core.timekeeper;
>  	struct audit_ntp_data ad;
> -	bool offset_set = false;
>  	bool clock_set = false;
>  	struct timespec64 ts;
>  	unsigned long flags;
> @@ -2576,7 +2578,6 @@ int do_adjtimex(struct __kernel_timex *txc)
>  		if (ret)
>  			return ret;
>  
> -		offset_set = delta.tv_sec != 0;
>  		audit_tk_injoffset(delta);
>  	}
>  
> @@ -2610,7 +2611,7 @@ int do_adjtimex(struct __kernel_timex *txc)
>  	if (clock_set)
>  		clock_was_set(CLOCK_SET_WALL);
>  
> -	ntp_notify_cmos_timer(offset_set);
> +	ntp_notify_cmos_timer(false);

Can you please add a comment why this does not need to cancel the
hrtimer? It took me a few looks to validate that this is correct. Six
months down the road we both forgot about it. :)

Also can you please rebase this on top of

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

which has a larger change of the NTP code.

Thanks,

        tglx



