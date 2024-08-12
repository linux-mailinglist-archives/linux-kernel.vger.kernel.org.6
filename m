Return-Path: <linux-kernel+bounces-283414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767C94F225
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544EE28376E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0C18562A;
	Mon, 12 Aug 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xfaS8p3q"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC04D112
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478092; cv=none; b=oO1wOjVB1HwjeQRr1M4W5L33NUfBvgUAO1tXU1l1GwwtyomA+mqft0zpb3J/AngR06PIHBSQQQkr4XnNT8igGIlFN6dBYtasrgI0z2AVey/wbNhhfh/WeJ9HmFO+u5AQsi78MaTFCuHOW13by2y6jbk7BARZanbvzrFDTSvxZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478092; c=relaxed/simple;
	bh=5cSLpYdcHigAnuod3lFrv0LJBoeyHFlT/zTkmNJcWME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0UvctyGVHR66M+1VRDmI/Adn83GKycZ9ZXcYzYE1o4zIjpf+vzZ8JYF8HOzNlD7/6LVTZIcAuwzmRGMTJc1NSFqsK+391hC/j2y6Yt/FQfhmTBJNqr7pY5zMb/ZPI8dS6OZfRlYxRLKpEdi5plFnIkVb/Sv4Lzur22tKioSVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xfaS8p3q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723478087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn7mptfJpte/FVlkXMMkL9uFm1dGPSD3Pv1DVJ3z7R8=;
	b=xfaS8p3qN8SDlcQKBhoq8ZBzmqWbC49MUzmcQAqt7Y7obNeWJ/e4jyUikRYLQsC7qnINv0
	XQ9ywBekHjMYylNyey+FYOc4w/jxL/dy7kGTHGNHpvfxXPKfZT9hqZfKdDXfvoO7LKYT/T
	VE4cxxk3bkN8eX2JWlDa71Y4ChZlEhk=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: tglx@linutronix.de
Cc: bp@alien8.de,
	daniel.sneddon@linux.intel.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	thorsten.blum@toblux.com,
	tony.luck@intel.com,
	x86@kernel.org,
	yuntao.wang@linux.dev
Subject: Re: [PATCH] x86/apic: Fix the issues in x2apic_disable()
Date: Mon, 12 Aug 2024 23:53:58 +0800
Message-ID: <20240812155358.890025-1-yuntao.wang@linux.dev>
In-Reply-To: <87a5hhsspm.ffs@tglx>
References: <87a5hhsspm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon, 12 Aug 2024 16:48:05 +0200, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Aug 12 2024 at 18:08, Yuntao Wang wrote:
> >  static __init void x2apic_disable(void)
> >  {
> > -	u32 x2apic_id, state = x2apic_state;
> > +	u32 x2apic_id;
> >  
> > -	x2apic_mode = 0;
> > -	x2apic_state = X2APIC_DISABLED;
> > -
> > -	if (state != X2APIC_ON)
> > -		return;
> > +	if (x2apic_state < X2APIC_ON)
> > +		goto out;
> 
> There is no point in overwriting the state in case it is < ON, no?

Are you saying that we should replace 'goto out' with a return statement?

However, when x2apic_disable() is called, it's possible that x2apic_state
is X2APIC_OFF. In that case, we should set x2apic_state to X2APIC_DISABLED.

So, I think overwriting the state is necessary.

Thanks,
Yuntao

> Thanks,
> 
>         tglx

