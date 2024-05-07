Return-Path: <linux-kernel+bounces-172240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74D8BEF9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549481F23F01
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D314B974;
	Tue,  7 May 2024 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSP9CBQt"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754C77658
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119408; cv=none; b=c2kSWuPq01rV7iPTurkGWdqmXT9D7GlIqUm+FDW+stCfBF60DxHG6ZwEWO5a35eAW2k7dL+q4HMDEJM83tp3U4LEsYWCfrVpZ17eIZRxGWgMxJcSLJ6rY5tN2bvFdbus47sFUo7G8vcfg6WRGxTQ8qcXxLfOM1ruVI0gcXkr5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119408; c=relaxed/simple;
	bh=MX6SyBQV2e/UPmX5oD7lh1S0/KXjiG5UdXrd7/ZQWrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlmvaMq/BWAEjzKR7sHL8WGf+xhejsabTkOVP7CicMYuiiXb04vaI0flGFLxhkKmMIEObYXBjvYgM3/aMSyzG7iBnVcp+v2hkxa0KkooRKLHy/WifDW90bnfWyZDlgw9WR0AmysRQP9dqsgBmhQaZQuV6tGTVMC+P09B7D6UyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSP9CBQt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c8bdc30f7so15664315ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 15:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715119405; x=1715724205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XYu6qO5CHO9l0ai1bRXa+x+4h/eEC8RbEzVjbVWXls=;
        b=lSP9CBQtFUTwygtx1AAMnNAYmMFWYsEL6leQAT79rZNhpGAp8iQwT5w5vEV40lvDS2
         KloxyqTFGlAPF0aLFXfcEv688Pnmm0DrjaqtX6BpwehFY9p7utMLvpuDjkIpNkJOkp+F
         wNgYTtJcHkXimA38/XeenI+r28aawRXdgS/jNCst28E/fHSn1nzUc0TNnZuXq/cPnO+S
         GUk3Tz1L4n97qYkRSd2antqvRRhyvgpw8CtSmKttcSH5Ip0MM0UyhNmOtlxJzwia7K5Y
         s+7sc5TUH/NsILL79kcozhKLHmhju2ZZNyWSFtINl7OT9jrjKaXyAeI8pe5hmBU/dync
         ma/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715119405; x=1715724205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XYu6qO5CHO9l0ai1bRXa+x+4h/eEC8RbEzVjbVWXls=;
        b=mcsJcMVi/LpHKkxYenxgaQ5lYscBCInWfopDvJtPhSRMFcfRrBv0Ps5rSNxcNMPYSr
         WgoXbtbaJvb8SJ3wF5AHjYStLigHvYjQDKCh2OiPEagVqfs8gIeOVpK9DIba9abAqEsj
         rinnCRQ0MGkVp3tbsZ9IoGKx0ruckVuQnRuC3zwEJnTvzbx3A734NIS2GLwxvlaqNMvw
         YoU38wny5gnfdj1uswjDfYAQL8NO8UGvi4VePOpvahbZrjnGmcbfJsSJ/abUvI8P4Zt+
         pGwvfFwvf8ObkJ4PXjDarsAViKldnqktkLByHrK6Ld3YtxsTDH4BMK3c5p3Tsc39VxjD
         zrzw==
X-Forwarded-Encrypted: i=1; AJvYcCUQk4pPJ06tbfdzhqVhxiN4RJknSBVowid1z1oKJhvIvNYQuTCuaBMAyy2wppENNNTfmOh1MLA16sMxkt35acvXobz7XuMAdpO0ISec
X-Gm-Message-State: AOJu0YwE8iP2jVsMjmWsweicoLy6XGW12DQFbvGM9Ytt/pmTnoeGe2z1
	3Wz7pNBA4zmn1WIAr7l8O8o2BAQQ8apHq8PFnjMpzBjA+0VwMEpST4yj1lsOQQ==
X-Google-Smtp-Source: AGHT+IHeILznDlUOIRj7JtU8GNORObVZbAVb33+P8RJAsCLODYRINZy2EqtCLx4tLeU7nkbNdj4PfQ==
X-Received: by 2002:a6b:5b16:0:b0:7de:a980:f210 with SMTP id ca18e2360f4ac-7e18fd3402bmr96660439f.3.1715119404651;
        Tue, 07 May 2024 15:03:24 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id v12-20020a056638358c00b0048788df1013sm1625504jal.15.2024.05.07.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:03:24 -0700 (PDT)
Date: Tue, 7 May 2024 22:03:18 +0000
From: Justin Stitt <justinstitt@google.com>
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] ntp: safeguard against time_constant overflow case
Message-ID: <zhb5dy6ysbdghj3vhnj2s3gd7fhqg3v7xmhonkgfxp33qtc6bw@pqyhntprkwjr>
References: <20240506-b4-sio-ntp-c-v1-1-a01281aa01ba@google.com>
 <CANDhNCps8qE1a+Vp2HNgU=-vA5RwhrLd2_D0EMZiNv1j_OOYWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCps8qE1a+Vp2HNgU=-vA5RwhrLd2_D0EMZiNv1j_OOYWA@mail.gmail.com>

Hi,

On Mon, May 06, 2024 at 11:02:17PM -0700, John Stultz wrote:
> On Mon, May 6, 2024 at 3:01 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > Nonetheless, let's slightly rework the logic surrounding time_constant
> > and how it is incremented such that we avoid unintentional wrap-around
> > (even though it is extremely unlikely to be hit in non-fuzzing scenarios).
> >
> > [1]: https://github.com/llvm/llvm-project/pull/82432
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  kernel/time/ntp.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> > index 406dccb79c2b..a9f039601968 100644
> > --- a/kernel/time/ntp.c
> > +++ b/kernel/time/ntp.c
> > @@ -65,6 +65,9 @@ static s64                    time_offset;
> >  /* pll time constant:                                                  */
> >  static long                    time_constant = 2;
> >
> > +/* pll time constant increment:                                                */
> > +static long                    time_constant_inc = 4;
> > +
> 
> I'd probably use a `#define TIME_CONSTANT_INC 4` for this.
> 
> >  /* maximum error (usecs):                                              */
> >  static long                    time_maxerror = NTP_PHASE_LIMIT;
> >
> > @@ -734,10 +737,10 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
> >
> >         if (txc->modes & ADJ_TIMECONST) {
> >                 time_constant = txc->constant;
> > -               if (!(time_status & STA_NANO))
> > -                       time_constant += 4;
> > -               time_constant = min(time_constant, (long)MAXTC);
> > -               time_constant = max(time_constant, 0l);
> > +               if (!(time_status & STA_NANO) &&
> > +                   unlikely(LONG_MAX - time_constant_inc >= time_constant))
> > +                       time_constant += time_constant_inc;
> > +               time_constant = clamp_t(long, time_constant, 0, MAXTC);
> >         }
> 
> Overall, this looks fine. Though the time_status conditional is now a
> little unwieldy.
> 
> I wonder if some sort of a helper like:
>       time_constant = safe_add(time_constant, TIME_CONSTANT_INC, LONG_MAX);
> 
> Might make this a little easier to read?

How about something like this:

	if (txc->modes & ADJ_TIMECONST) {
		if (!(time_status & STA_NANO))
			time_constant = clamp_t(long, txc->constant,
						-TIME_CONSTANT_INC,
						MAXTC - TIME_CONSTANT_INC) +
						TIME_CONSTANT_INC;
		else
			time_constant = clamp_t(long, txc->constant, 0, MAXTC);
	}

We can remove the initial assignment and use some fancy clamps.

> 
> thanks
> -john

Thanks
Justin

