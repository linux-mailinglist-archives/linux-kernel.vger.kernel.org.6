Return-Path: <linux-kernel+bounces-218898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4390C77D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5479B24140
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1D1BA86C;
	Tue, 18 Jun 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AJTHda8q"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACF23BE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701061; cv=none; b=T0/YOLEXpE/HvgI+wJ28d8L/KTIff3HTwManD4IZKF2EmmYCswCzT4EH3L2O5m4ik4xM1e5vDdED7+tICIKhIfJHyXG3OU7nWfoaBmyszG6owhkJR2LeWLEvaSlBm8g7PQWx8EY5r9v8mCxK/Wk99GlNdYbFsBUH2U5n/QuVu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701061; c=relaxed/simple;
	bh=c8iN7F59VK8HhpRn5l0fFGS0r0gE+mAVh1zkO8Ckw4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoQ3KLzWoqOKFsFLrh0hryNO4+cKitD4x3j2TqeYxDUy9CdnXfuAkaLYZt3bqCrTOt9ajF+TaPOLC7jFPg4Tw5VfoG2kTLiJaMRfhh2/fN9NPezMNbi3lMyLzcmCTkvLOsCUIwr8bK75xVM8cGZbtFQJYAqBCXJimv6MCeOi3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=AJTHda8q; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7953f1dcb01so449730485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718701059; x=1719305859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1MJWeAXBDDEpLuGkGIY36gY2Jr0ZSeY/lNnVY9HPv1s=;
        b=AJTHda8qFeJGi4Ouo/iCiDuY/IxDlt+zCXmu9Jaz9rfuoaFWAuHnKrlPgYoAlYnzkd
         BpXvcp3bOWkaWUVfGS+/PzwaK+jziPtQyEvj3ToS0X40YSBs2v70LHF+1RuvJ+sVUKCr
         GPHOklVb6nUApWKTEE8lxtgWObsXzEQtT+dSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701059; x=1719305859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MJWeAXBDDEpLuGkGIY36gY2Jr0ZSeY/lNnVY9HPv1s=;
        b=mrTkf15cPnOKowfeSpcq+ycvEVzxR2boOlRTZp1WINtCQNAKQf0uQfMIZqheV4irPh
         snInonhsm0MGTQt/OZU8J6zuolnQrDzOb7+TSHpTQQ8YHf09IP7ludoPcbYBfGdBqcXl
         mNcSXy2VROL/WbEaPvWuM4p967Vn8jmaFt0l/UBMRy57j+rAtc/KLmiSqcrdAvhtL/gA
         La6Q/FI6oEV9M3/iksGH7BLZK2HD7LTJbLMR7Zycf0Q/nT+npdiXWPJO+Hs3n/3z+8rh
         D2I3cHOKPgaN/uHN0rkWpEJrVgzVLX5/2IvMoHo0mC2gvxSq8xwsJzXg+S10NMYYlKNy
         1SmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN40BVjE4KEsOakJVhl582ehQ5+orSskICLWQsVVrCt2l3Pxf0H07HnyrFPrcwXuVRd7AGWFp1fdu8EkPVjzSHmJEpC1DHRRxWZfIA
X-Gm-Message-State: AOJu0Yzhc2pVIqlxmqaMN/f/6Oy0nraTmpCe3DcahnyjJ1azlXJb9lJg
	usfjIabopb88Z2xi58Qtl6slxBCewm7Xva4iow731pVZ9pzWZBAE2tR8HCJdPRk=
X-Google-Smtp-Source: AGHT+IFECmvJp1ez2eLa+dpQfO6eX8nUMX4FYtnOHPp9ThmxkkpraoTUSlv3dCTdEWRDY19HCOSrbQ==
X-Received: by 2002:a05:620a:4005:b0:797:cfb3:155f with SMTP id af79cd13be357-798d240afdamr1497813685a.27.1718701058859;
        Tue, 18 Jun 2024 01:57:38 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe6b4dfsm506192185a.125.2024.06.18.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:57:38 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:57:35 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Frediano Ziglio <frediano.ziglio@cloud.com>
Cc: Jan Beulich <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/xen/time: Reduce Xen timer tick
Message-ID: <ZnFL_0ihWiI7Yaf0@macbook>
References: <20240617141303.53857-1-frediano.ziglio@cloud.com>
 <2fe6ef97-84f2-4bf4-870b-b0bb580fa38f@suse.com>
 <ZnBKDRWi_2cO6WbA@macbook>
 <CACHz=Zg4Zoyr4KNeig4yDDNUxvV325beJEyT-L-K0a+FHp7oDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACHz=Zg4Zoyr4KNeig4yDDNUxvV325beJEyT-L-K0a+FHp7oDg@mail.gmail.com>

On Tue, Jun 18, 2024 at 09:37:08AM +0100, Frediano Ziglio wrote:
> On Mon, Jun 17, 2024 at 3:37 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
> >
> > On Mon, Jun 17, 2024 at 04:22:21PM +0200, Jan Beulich wrote:
> > > On 17.06.2024 16:13, Frediano Ziglio wrote:
> > > > Current timer tick is causing some deadline to fail.
> > > > The current high value constant was probably due to an old
> > > > bug in the Xen timer implementation causing errors if the
> > > > deadline was in the future.
> > > > This was fixed in Xen commit:
> > > > 19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future
> > >
> > > And then newer kernels are no longer reliably usable on Xen older than
> > > this?
> >
> > I think this should reference the Linux commit that removed the usage
> > of VCPU_SSHOTTMR_future on Linux itself, not the change that makes Xen
> > ignore the flag.
> >
> 
> Yes, Linux kernel stopped using this flag since 2016 with commit
> c06b6d70feb32d28f04ba37aa3df17973fd37b6b, "xen/x86: don't lose event
> interrupts", I'll add it in the commit message.
> 
> > > > --- a/arch/x86/xen/time.c
> > > > +++ b/arch/x86/xen/time.c
> > > > @@ -30,7 +30,7 @@
> > > >  #include "xen-ops.h"
> > > >
> > > >  /* Minimum amount of time until next clock event fires */
> > > > -#define TIMER_SLOP 100000
> > > > +#define TIMER_SLOP 1000
> > >
> > > It may be just the lack of knowledge of mine towards noadays's Linux'es
> > > time handling, but the change of a value with this name and thus
> > > commented doesn't directly relate to "timer tick" rate. Could you maybe
> > > help me see the connection?
> >
> > The TIMER_SLOP define is used in min_delta_{ns,ticks} field, and I
> > think this is wrong.
> >
> > The min_delta_ns for the Xen timer is 1ns.  If Linux needs some
> > greater min delta than what the timer interface supports it should be
> > handled in the generic timer code, not open coded at the definition of
> > possibly each timer implementation.
> >
> 
> I think this is done to reduce potential event handling frequency, in
> some other part of timer code (in kernel/time/clockevents.c) there's a
> comment "Deltas less than 1usec are pointless noise".

Then why does the interface allow for timers having a resolution up to
1ns then?

> I think it's hard for a software to get a frequency so high so I
> didn't propose 1ns.
> What are you suggesting? To put 1ns and see what happens? Is there any
> proper test code for this?

The Xen timer interface has a resolution of 1ns, and the Linux
structures that describe timers also support a 1ns resolution.  I can
perfectly understand that deltas of 1ns make no sense, but given how
the Xen timer works those won't be a problem.  The interrupt will get
injected strictly after the hypercall to setup the timer, because by
the time Xen processes the delta it will most likely have already
expired.

Forcing every timer to setup a minimal delta of 1usec is pointless.
It either needs to be done in the generic code, or the interface to
register timers needs to be adjusted to allow for a minimum resolution
of 1usec.

Thanks, Roger.

