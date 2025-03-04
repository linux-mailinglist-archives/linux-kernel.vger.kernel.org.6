Return-Path: <linux-kernel+bounces-544373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0653DA4E077
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AE0188AF97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88033205518;
	Tue,  4 Mar 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c5tSVXPQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DB204F7F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097753; cv=none; b=ucc5iJED+XTh+kfGXfqfLp+xGH0u7XCfPoOvPugV95erJi3CayWRB0clrLukeswhRfT7+aRk+Fn2HTnNpA2J2KOV8+BuDDgBk18vSRm7WNH2Dl+dPmqM91czFcIkdMn8gwO7Mb3FQzau3DtYaPbh05EBHHLK1fxdNeJqfyBdh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097753; c=relaxed/simple;
	bh=OWbyWcaJIZ0DY0rTIb06QodEHDPze3VezyuT2BnH9nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj27uBb1T32t++SzS6SgnMKFdsE4eBy2IjPAsdiD+OcVgK4kSDSLPr4fBiUTmqVQ20orduR1jmfiyN7/xxxwjhkBojlZ8vjTnVFHnH5uU7T1MnOH+B3hSEDlo8DG7DEwlt2XuDzk2QT065dg48zhw9BIUh76cFAjE032MovxbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c5tSVXPQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390eebcc371so2372322f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741097749; x=1741702549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNP3hD1Q1pQX05cPhjBWln1QM3ctecM9Z8JWqdjxuDk=;
        b=c5tSVXPQ4YThs5wvevDIGnohjzPCWclcOuTJDcBF7Z6j6ZY7FDovr2TLIQCKTbohr4
         JtbHmhJPq8SaGCQCr/YfnFNNZSd0RVAoNXwuYkCuovy1ifjMxS6RIhm20v4rFnZpfBQI
         eeBcwG2ecuupOnuOPo8Sor5vZl1JD4XsXoyIDmO9nIebpp/JOvmAlmjxRDr0TNA1CTF5
         K8ALpEMsg8Qn1xWfp57pcCcl9DUez7m6rnu4Cr/cY+HykG2+vEeFhQPTfHcrIaUAtbxp
         kJF1MCdkk/UyChPyJ2pWHl4amO4wEOnK7e8hsrnG2Nn3C6VGF9JDHrwDqTZU0UUfELQ9
         QeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097749; x=1741702549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNP3hD1Q1pQX05cPhjBWln1QM3ctecM9Z8JWqdjxuDk=;
        b=CXhpSqPLwY5i44BFW5DdG7SU4kI0wcV+NtECzNLWecvNvheJKHYKOueF3HdvHYpE5Q
         QFjsgjdiMtyYISmeX75sTwBsyT1/DnM4EGJYtGMuPge2i5HbWGcr3qTwqumbYrbllMy0
         Zo8ugwj1zjDqa2lc64nu36YQ6qbalilfPgg6Dw9SogKrL3KFnH7ae6WDUw7P69wBbiiB
         GkD/9dnmfQUkkXp754/l7aiuYBwywaztXc5+2j5frmxmjZEJbeZuiKl3cnY9AsfIcibh
         zVR8urkNy/da64/GtSS+PxFTF0hKgtrszYyCxi2Psk8deU8KtOpkibG8RamGdaUvOmyS
         80Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWr0fmmx8cIri98+eOk/wMbc6iXNBiq19+rgxBQ3PnL4MrXk1dCf5g5IpZhkgZNs9jtnpyvqXNzJhlFRBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRiv7hn/GARyRfQsXiuktfweDxI4C6gCEDlgmEn0YE1Tl4Wtb
	G2rVR4jkTOCu4VXvAHZagIVipAMuRg9be+5vjwby8cMQVqEmU4lSoqdNmWXv3Ts=
X-Gm-Gg: ASbGncvwYitezYcDuQ5es7MyZoOoeuImbXCuj0yQSt0r3qmYV9/4gtCNCQbviQ0hjLS
	iB8JWZxEhU4uR6h5i5B2CJpJVrXdbda10e3rgcS4E8csL2Ya9GWWwJCHOAuFvIeNGohZ0Pvx6dQ
	vUq1n1oqjxnJmhgq2t7Lew63dlEs6cVAX4VH2gRTlFaFPib8MWCoCPbG7vShBbu9o3cb80WojN/
	dqSmOXVyh1e/g4tT99AcFzKCW9nHCVFfGx4lYb3dD8REtG+bNe/Y7TZsLzZzP8+/XJ1rT6epabC
	yG2a6g0/3clsveb54G1KEpqYOvYQPgqRSA==
X-Google-Smtp-Source: AGHT+IG2r+8xjemvLM9md5Yy9n5NZipZ0QAPxrqURtNs47W9xHwvfHFMkq0NcCbxuxlgvHk73Xl74w==
X-Received: by 2002:a5d:5f4f:0:b0:390:f394:6274 with SMTP id ffacd0b85a97d-390f394636fmr14103025f8f.52.1741097748232;
        Tue, 04 Mar 2025 06:15:48 -0800 (PST)
Received: from pathway ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm225903425e9.30.2025.03.04.06.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:15:47 -0800 (PST)
Date: Tue, 4 Mar 2025 15:15:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Donghyeok Choe <d7271.choe@samsung.com>, linux-kernel@vger.kernel.org,
	takakura@valinux.co.jp, youngmin.nam@samsung.com,
	hajun.sung@samsung.com, seungh.jung@samsung.com,
	jh1012.choi@samsung.com
Subject: Re: printk: selective deactivation of feature ignoring non panic
 cpu's messages
Message-ID: <Z8cLEkqLL2IOyNIj@pathway>
References: <CGME20250226031756epcas2p3674cccc82687effb40575aa5fa2956e0@epcas2p3.samsung.com>
 <20250226031628.GB592457@tiffany>
 <84ikoxxrfy.fsf@jogness.linutronix.de>
 <Z78eGNIuG_-CVOGl@pathway.suse.cz>
 <8434fytakt.fsf@jogness.linutronix.de>
 <Z8b-ljGnw57GpJb0@pathway>
 <84ikoorj53.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikoorj53.fsf@jogness.linutronix.de>

On Tue 2025-03-04 15:05:52, John Ogness wrote:
> On 2025-03-04, Petr Mladek <pmladek@suse.com> wrote:
> > I mean something like:
> >
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -2143,7 +2143,9 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
> >  			 * But it would have the sequence number returned
> >  			 * by "prb_next_reserve_seq() - 1".
> >  			 */
> > -			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
> > +			if (this_cpu_in_panic() &&
> > +			    (!printk_debug_non_panic_cpus || legacy_allow_panic_sync) &&
> > +			    ((*seq + 1) < prb_next_reserve_seq(rb)))
> >  				(*seq)++;
> >  			else
> >  				return false;
> 
> Ah, OK. Thanks for the clarification
> 
> > OK, I propose the following changes:
> >
> >   + rename the option to "printk_debug_non_panic_cpus"
> >
> >   + do not skip the messages in _prb_read_valid() when this option
> >     is used before the non-panic CPUs are stopped.
> 
> And of course:
> 
>     + allow non-panic CPUs in panic to store messages when this option
>       is set

Yes.

> I would also keep the dump_stack_lvl() implementation as it is, even if
> it could lead to interweaving of backtraces. Anyone using
> printk_debug_non_panic_cpus should have CONFIG_PRINTK_CALLER enabled.

I agree.

Best Regards,
Petr

