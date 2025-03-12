Return-Path: <linux-kernel+bounces-557435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB5A5D8E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8D5189BF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365DD23875A;
	Wed, 12 Mar 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRsqfZk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNrGe1nb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05023816E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770616; cv=none; b=NaA5jX0UrHCyZ8i9++omC9l8HMT0DNguZfnj2L7xNRv9KRoQYZWwZ6l1kDo9WudUKZlGI0JPyM9OjM3eX7p5AHysw8uDEG2u3kA1yJ/ar78uwnyNrL2ko+N2v8/szlfg3+shcjl71NwdOictoMr/XxPSUQxxkKgS7PVDGvirv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770616; c=relaxed/simple;
	bh=4WG2cr8UtGv8vpJk7ukpFTGv84oRBoiT6dD3cvRe7r0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SiTGzOXo3J5K8Ja8Lg+L4NfC4ugW0QvbJr2VXrFBqWxi01JoZJIfWeOADu0hBDByM9BPUEMQreyxdqOBjwKan+b2vaSRSpf2q63lM7ESj69mYoDeWf3+WBEJbxw1VqrADs3FifpK7EtUViHqDv3Ftw1Tdq+f6bvOp+xCRRulDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRsqfZk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNrGe1nb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741770606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmDauVIi/lEx6hBT0EsRA2eVqslqGCn7HmyM07xSiFQ=;
	b=xRsqfZk2Du4ykBcvyi5Ml8ve4OnquIuhirPPzyi7ddcVOg3yJ/V24QwLKUuDm9lsrcd7XR
	TEgnLg3sSq/RulzDZqoXw22v0L1kxEgHjSP37dLsyUU6KArlhbpEyy8xPIW3EKlTBgxZz/
	Her0rP5gBjLwXfHrlSb2QExtRCiguDXSyl6CPO226ZZj1ajTJZwrOJHuSwssKdKpTvGl4+
	1VeVh1SKtlKYTr2uzMi2M63kEvBLjo+RGgqIf9LGLXGQ4DUaaL8TRbjDaxoOIccya3c3eg
	FlYliXrGfDC4ll47aryvZYUArXJYJRTd8G+7KNLJlzRMYaTsfTK2tqZKamD/4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741770606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmDauVIi/lEx6hBT0EsRA2eVqslqGCn7HmyM07xSiFQ=;
	b=BNrGe1nbgQHie93gbBdLfprSkNRFSNpOLIIOn3oG8A9J8l3fXShafy3PWLyYV0o6pkP2uL
	618qjuc+puy07NDg==
To: Yajun Deng <yajun.deng@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: Keep affinity_hint unchanged if it has a value
In-Reply-To: <171eb20e618f8c05ef8169e892a1ed08cf580ee9@linux.dev>
References: <20250311013352.2727490-1-yajun.deng@linux.dev>
 <871pv31wpf.ffs@tglx> <171eb20e618f8c05ef8169e892a1ed08cf580ee9@linux.dev>
Date: Wed, 12 Mar 2025 10:10:04 +0100
Message-ID: <87h63yzkb7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 12 2025 at 03:20, Yajun Deng wrote:
> March 11, 2025 at 10:14 PM, "Thomas Gleixner" <tglx@linutronix.de> wrote:
>> > For example, if affinity_hint points to smp_affinity, smp_affinity
>> >  is changed by the user, and affinity_hint would chang. affinity_hint
>> >  couldn't as a hint to the user, it should keep the value if it has.
>> 
>> What is 'smp_affinity'? 
>
> It's 'desc->irq_common_data.affinity'.

Which has no business to end up in the affinity hint.
 
>> I really fail to understand the problem you are trying to solve.
>
> irq_update_affinity_hint(irq, desc->irq_common_data.affinity);
>
> As in this code, this means affinity_hint points to smp_affinity.

This code does not exist and no driver should ever invoke
irq_update_affinity_hint() that way. The hint is a cpu mask managed by
the driver and not something the driver pulls out of a data structure
which it has no business to fiddle with.

Thanks

        tglx

