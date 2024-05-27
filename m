Return-Path: <linux-kernel+bounces-190469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817368CFEB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374B2283383
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D013BC3D;
	Mon, 27 May 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSXEvBna"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1C13A259
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808626; cv=none; b=HZaNs5AwSaqBJNM2Z2DxKOfMFZkG81PV+xCz4ZSq7Vrzn3SR04lukEI4thWmgPhl7JOVhPSX4nBGBTd5tGzA5ErvluKU1nE+9XOwvtw+IHNG50aRHTXoQrNkl7pcw1/scfyGeTXc7peBd/V9wlR2HOrSiQqunOuzysvs4RMnMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808626; c=relaxed/simple;
	bh=O6VzHqnKSqWms8Eo83avq6Qp5y89RLEkrexPlfSt96g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=ENJ8rFoKd0LavyLXCP8WTJi2x+LXsWpvVEvueKOKjdkO4C1A/F/prKJVdxT/otdQwsA4hWZC3qK0x726k75kCYi1i7MrFpIXqyJcfHBs8AiVNazJhuzp8h7AKdrZunWu4wduKmKnt+aqwnLLgEh2e9o8uNOOKLdGEWx+TTVYooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSXEvBna; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6819b3c92bbso2623700a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716808624; x=1717413424; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0DjMfdVZcJL4TTwkujKDYIw93uQiKEaf6AgX1+f72c=;
        b=GSXEvBnaMB9SUgZiBWRpSZf+FkBMjjCNL/0Jo3lj0kBXQGby/K1PXsRrDZKJvcB/bZ
         sAEM/4ZWX2QE77WstaPBmcKbz5YOje02IOJfft4XFcziJj0GEgmZsYYXKG/BVwOeRP/d
         4iYZPI7B59nB1i+GKTFZeGVNywf/cyqg52qbdGcU+vqhHUvJVXlG84uw+aBkY9KVmSDd
         MQwj2z+WOw7A/4lTCVpE3kgEPq0hX4GELZn1Du66YcnVOHot4MJhF1g8TaKePxH1L+uF
         SOW0DadyvRD9Kk33AKO5I6QzxCbOTodld+wTL4CfWdIhAz7V480AdcNHsxYnvVuBZyHB
         Wh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808624; x=1717413424;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k0DjMfdVZcJL4TTwkujKDYIw93uQiKEaf6AgX1+f72c=;
        b=T1EGPxwwfYXibJgmzsMfpYIGcKP30O4JAU0PJ9otdX0W74U76RKm7NjKDR51gyR3dW
         NVfkkQi7Ix9kUezKKIxcOytQI4SKc3r3I7iAdw4sx3iMS9KZo0RV63v3OCxQgkDkpZcX
         xkrOcWbGyXxlNIp0EvI/7I0evNqDEkdsqmM8ssbjuQow05tukpo8+rYOAFz2EOX3neP+
         rv9guANC8UAhYMeOnIz9LhmvwS9ehjoKVEXSEMM9nirGAm5s8udQZvzUR8z6+L6v4sMS
         0Ars9cHqUYeoV3b0E8l1/sibHBJ0Cb/uIXC3wSz8jMcWLAW+4UhToLUas/wxzDnl1BpS
         JNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVTziYLnzFUVFrX9stVL7Gyz2NFdew6WBqPZrgucb+CxX29TEkRn3lEdrsqfVc1IcmDDUiQcbdfyjFZPeHDwOGcMLl3fI1nlJa5rlC0
X-Gm-Message-State: AOJu0YzeFln6z6TAR46Bfng/DxVH2p0knAaN1gkNigExEBJwootYGy0U
	rsf5uFOuAf58+Su808Wga/3SZpN2ASVZV6B0WObe704xBG/r2+/l
X-Google-Smtp-Source: AGHT+IEac6mOQYcWGt2FqFIDPPZPgoQB4ZQtrAzme3YtQmJj7fSp5vPIEuAWFPie+fUAcpUBy6hYYw==
X-Received: by 2002:a05:6a21:398a:b0:1b0:27dd:3355 with SMTP id adf61e73a8af0-1b212d04ac0mr13876669637.21.1716808623762;
        Mon, 27 May 2024 04:17:03 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f45ad4444csm51065275ad.274.2024.05.27.04.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 21:16:57 +1000
Message-Id: <D1KDV2ZCWZF5.29STW6VA0LPX8@gmail.com>
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Oleg Nesterov"
 <oleg@redhat.com>, "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Phil Auld" <pauld@redhat.com>, "Chris von
 Recklinghausen" <crecklin@redhat.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx> <D1KB5Z1455DI.3HOVYR566ZGXN@gmail.com>
 <87ed9nd041.ffs@tglx>
In-Reply-To: <87ed9nd041.ffs@tglx>

On Mon May 27, 2024 at 8:23 PM AEST, Thomas Gleixner wrote:
> On Mon, May 27 2024 at 19:10, Nicholas Piggin wrote:
> > On Sat May 25, 2024 at 8:06 AM AEST, Thomas Gleixner wrote:
> >> along with the removal of the SMP function call voodoo programming gun=
k,
> >> a lengthy changelog and a bunch of useful comments.
> >
> > I might not have tested that path on powerpc since it should not
> > switch clockevent driver (or clocksource either I think) at least
> > on 64-bit.  Explains the smp_call_function warning if you are
> > testing on x86 :/
>
> Even on PowerPC the per CPU clockevent driver is registered during early
> boot for the boot CPU and for the APs when they are onlined. Before your
> change the boot CPU was unconditionally taking over the do_timer duty
> and never gave up on it in the NOHZ full case.
>
> The logic you added allows that the duty is taken by the first
> housekeeping CPU in the case that the boot CPU is marked NOHZ full.
>
> So yes, that function call _is_ invoked on PowerPC too if the boot CPU
> is NOHZ full. There is absolutely nothing x86 specific.

Okay, right you are. Indeed it does trigger.

> The difference is that PowerPC registers the per CPU clockevent _before_
> setting the CPU online and x86 does it afterwards.
>
> So the warning does not trigger on PowerPC because:
>
>    WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled() && ...);

That explains it.

Thanks,
Nick

