Return-Path: <linux-kernel+bounces-182214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6878C882F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CF61C2210A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E247490;
	Fri, 17 May 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OxH4fujh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2228FF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956824; cv=none; b=I9fd+g7wnfCFHjirNpC86MggQnhYzUz6kaMDuJjp6hWnCG3FUr7VXYTRwjBJUoz0UgVVrbQd5wOKOk6XRzrMiGMf3hLnMJWhQVwyIwQuQ0WE32GcvNzYSqihr+POwRnX5TuORzQARSMwofH9JcvG9O6EH8lZbco1gHyJLeVVf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956824; c=relaxed/simple;
	bh=MbXIwTAyTgQNMyEW8b50nZ3msi8UQOUvoY26I7l2kEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL0rabHLLE26dJ2rn7yDni5rStZMZCzA4prLPb0C91JRuhdcYL9vNe3LoGmiCcVHxqmy8U+2ewQMact3/NZTNhFZW/VQVw3PPMnLjhfh/kxe5NZW+y5iyvJeky7EvAXyjH6vevZQiVAG2SeSSwcFI8ux//DiSTc9up3QgNC1gkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OxH4fujh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e7144055c7so2660781fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715956820; x=1716561620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmMqNW6OY6DguA/rCN2USSW4FvKOZoylsSTlZPNM6yE=;
        b=OxH4fujhJIEB5l5WF8pjDMUVRcRx7WQ7PZsoKmG7/s+A2z+tI5NEuqJZ1iy1u7YCuL
         Jz1F++bPHjzOTWBgbz9q8X68a5QvuN2ywUSKr45h7GKQ8rjb+7tUmZE0SY17JqCmr8+5
         RLSOKLwjWgM84U2tiriaQ4bJxCwI4vTedMv/QFsd+wt5dVtq9Uxv6yB3UQOXzivlKIvF
         jB2o4kBtvgVot+G2E40GjSXfvbUsmjLrY53994yH3CamEi4Zho1TCwef2YHWE6EmGizI
         e4GgKHBQ5iCS+tAybo67VIb7wqLXjY05SzHE7VZeGM9i2nQt9oPb4l2kd9ldcUHBc+38
         5Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715956820; x=1716561620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmMqNW6OY6DguA/rCN2USSW4FvKOZoylsSTlZPNM6yE=;
        b=nYP0hIO8UP2x0o9v+Gj4mUqMZ8Ilmq2JO/is8/uj0Wj566Qn8DJZ8CQkAkoWy46mXX
         9ZV53QQUm44J7LWpk8tDlYXquyeOA5jCL3m8hkBAecVAt689K1YO5uzH7LQWnKMrYiro
         XYztIlv1sljKoqeT0FOaGsTdNTn6zOFkQeAZL6dburWfDid0pnmT5QLtgr7H8LGkX3hv
         0YXVMh/Qj1xXsaRWKmtBz45VXOV9LRtWIMDlOm7UhUnRBIqvDZ1UbyCFcXUJdVJB+4PA
         0YJhOYWf1qvF9vzwcZ+COysAVGS94Pr0C6ftJEBzIAR329hmrxZOJW6cxX5CjtbpaW4n
         MYDg==
X-Forwarded-Encrypted: i=1; AJvYcCXdQnNeX0dj1hkTKUxnRCcOmBcbE/8vERQfj6tHJUf/H3bkuRn3I4/oyA0Bsejci419O7qrzQffxSEvbqOO0lSC5ERRPfY81U1AXNnx
X-Gm-Message-State: AOJu0Ywhz40mf9eg+V95uZ7L3FSWpjhgXpu355o1iUiw97i/LgHicLD2
	CRiJqmLmtzxtdl1KfWWBN6j0aB4WpH2lIaQsD0ow7R8Mx7I7k/mbZPLw33+E8k4=
X-Google-Smtp-Source: AGHT+IHWdcaJPVE2MqmsmLIq+skXSguavFWfPtgPhSzqR8d5dzXxdFmPcCj2aPUPlLY1zFZHqGIPKg==
X-Received: by 2002:a2e:8449:0:b0:2e0:3132:94d4 with SMTP id 38308e7fff4ca-2e51fe53f21mr138317551fa.16.1715956819900;
        Fri, 17 May 2024 07:40:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200a8e6846sm248650515e9.15.2024.05.17.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:40:19 -0700 (PDT)
Date: Fri, 17 May 2024 16:40:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 06/30] printk: nbcon: Add callbacks to
 synchronize with driver
Message-ID: <ZkdsUjP9CLCdY0kw@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-7-john.ogness@linutronix.de>
 <ZkdcFxW-e9LVmMd8@pathway.suse.cz>
 <87bk54y1vl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk54y1vl.fsf@jogness.linutronix.de>

On Fri 2024-05-17 16:06:30, John Ogness wrote:
> On 2024-05-17, Petr Mladek <pmladek@suse.com> wrote:
> > BTW: I wonder if you use AI for generating the commit message.
> >      My experience is that AI produces longer fancy sentences
> >      which might be good for a novel but they sometimes hide
> >      the important details.
> 
> I do not know if that is a compliment or an insult.
> 
> For the record, I do not use AI. The "long fancy sentences hiding
> important details" are coming from a sober brain... mine.

Ah, take it as a complaint then ;-) Complicated things are just hard
to explain.

> > My attempt of a more strightforwward explanation:
> 
> [...]
> 
> Your version does not mention why the generic code now needs to use the
> driver-specific locking, but I suppose that does not matter (and only
> adds confusion instead of explanation).

I removed these details on purpose. I think that they will be
easier to understand with the code.

Best Regards,
Petr

