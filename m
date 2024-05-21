Return-Path: <linux-kernel+bounces-184956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCCD8CAE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1B31C218D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038A7602B;
	Tue, 21 May 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BTUbSOeb"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05E28E7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295034; cv=none; b=U/T30SDn+nip9Jw+TuNVSf+pVT+UWdIeS9qkaWupI+IQwvm7mLU74kfLgCF+MOq1fhsanZwpT5Vlb5P3Hxu5nfMQ6YYyMkz3cX9iJQaOeuvMTNmJjm6dG9JIB9SYpaDvfvMZr3J85Z+qPZzdErxnqOhfKQZ2YAR8BoW3G5jLaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295034; c=relaxed/simple;
	bh=Klu0gGVfZMfblIpCTCUXJjJGPJyTfcM5cThq4DA/HRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2OHoktFUCQTeTUgzBr1d4kJLHkELWPnm7qqNJyXNmrikPyqhf5RU/LCVIzSRK7895K0pjPMcL1SI5pZMpWLTo0sFAVIiLC6SPhx1EtFpy2mdqXOBmpMvCB/mbB4wKs2Dn21kGLPfyAgBrmfBX8rlvXdPoUrKkr8mA/vmKKPwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BTUbSOeb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a352bbd9so1210194466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716295031; x=1716899831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkFOGlpOKeStDNfuqkdG9T+khvpIoGQQxktttnrUnLI=;
        b=BTUbSOebTd+Sqv0Yc+PlFN9xQgdX0wWyVjDpkC3PjB41FRA9a5dJbwIlgDGVCGiU72
         X3OYXqL1DQ8SW4AmjjDTW4yuv5fDr4x+jP0xTB5nA2j3hvNA01YbKEqVE81bIEmwXXwj
         mwbjjHTy4HVc3L9OLQyVOHa9HYbByTDu3q1yfSvGYNGT1Rs1VGeyjTHZOcOMchZnR8yO
         6JPy1vcgbWQgLl5LfSAONhdSSCblhIVXYbgXUKCHvCOqjjezbPOGNRQpKHWZTs4rU90H
         NnoVkQGkXQEFGU287joUyQ33OyxBBnxtXUuVuEWf3QTDmmGpDwL2H4Ciju9IkHCW5ETt
         JMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716295031; x=1716899831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkFOGlpOKeStDNfuqkdG9T+khvpIoGQQxktttnrUnLI=;
        b=i+/jrIsICf1aWJwZ9SBpFsxxgRcrJN5hvAG63SmASrRTKY6/Rxur5YqpUJD1j6jvt9
         NiVkwozZEeC7zHa/MxapN/kRgk3U7G+qjrtvbdQW+8T1VdazjvHx3LKrHX79U+YBmQ+Z
         hCci1jGYCSYoJ10t1pAgx2tHsKQIfhJXjNKL2IfAm8NoHEZMmPs1leIt1nYg50ikOwRY
         zzJpbG1VW1LxYzFnnIMQ3XZ5AcfwVfs2bnN0d41m1SU8R/0ftvYUAY8C6DjmeLDMSeNr
         PjZexmcAaGDrddaYY15b0//FRYZxJ1ugbU6vuFe8FD4o637LznsZL837ni5k8ot+CmHN
         NIUg==
X-Forwarded-Encrypted: i=1; AJvYcCVbFOA5zT8yRWDw7Qv9nOG32R8wFCAY5N2XyQrZCxQUam7JWObEwJJ8ZSepk7UbzjW9jeZm4Gc4PzwNVPH435zGVC/BEoW/CiBi583R
X-Gm-Message-State: AOJu0YxiugzHRAcFj7faUu2i7AJfupsOvRT8Why2sc9pjv9raDbgKb7I
	S/Lr7JxTaJUuch23CSV8VUncPVRGlwOYXY9dpxuIuiQnmpVF4cFgp9KHvKNaafM=
X-Google-Smtp-Source: AGHT+IGx+uKqMOPmDdmS4fZiU9QA5JxbX3rice58bs7ue1OBEk2/fM+Wtt8aCfDy/pQWV36HyJc+9A==
X-Received: by 2002:a17:906:a05a:b0:a59:a7ea:dd22 with SMTP id a640c23a62f3a-a5d5a376cb2mr762273666b.14.1716295030667;
        Tue, 21 May 2024 05:37:10 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a5c033afasm1263036866b.156.2024.05.21.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:37:10 -0700 (PDT)
Date: Tue, 21 May 2024 14:37:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 26/30] printk: nbcon: Implement emergency
 sections
Message-ID: <ZkyVdD4alTWw2I_a@pathway.suse.cz>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
 <20240502213839.376636-27-john.ogness@linutronix.de>
 <87h6fbi5q8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6fbi5q8.fsf@jogness.linutronix.de>

On Mon 2024-05-06 12:45:59, John Ogness wrote:
> On 2024-05-02, John Ogness <john.ogness@linutronix.de> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 8f6b3858ab27..991e2702915c 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > +void nbcon_cpu_emergency_exit(void)
> > +{
> > +	unsigned int *cpu_emergency_nesting;
> > +	bool do_trigger_flush = false;
> > +
> > +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> > +
> > +	/*
> > +	 * Flush the messages before enabling preemtion to see them ASAP.
> > +	 *
> > +	 * Reduce the risk of potential softlockup by using the
> > +	 * flush_pending() variant which ignores messages added later. It is
> > +	 * called before decrementing the counter so that the printing context
> > +	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
> > +	 */
> > +	if (*cpu_emergency_nesting == 1) {
> > +		nbcon_atomic_flush_pending();
> > +		do_trigger_flush = true;
> > +	}
> > +
> > +	(*cpu_emergency_nesting)--;
> > +
> > +	if (WARN_ON_ONCE(*cpu_emergency_nesting < 0))
> > +		*cpu_emergency_nesting = 0;
> 
> I see two issues here. First, this is unsigned. kernel test robot
> reported:
> 
> > kernel/printk/nbcon.c:1540 nbcon_cpu_emergency_exit() warn: unsigned
> > '*cpu_emergency_nesting' is never less than zero.
> 
> Also, in this situation, we are allowing a brief window of activated
> emergency mode by allowing it to become !0 before correcting
> it. Instead, we should avoid illegally decrementing. I suggest:

Great catch!

> void nbcon_cpu_emergency_exit(void)
> {
> 	unsigned int *cpu_emergency_nesting;
> 	bool do_trigger_flush = false;
> 
> 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> 
> 	/*
> 	 * Flush the messages before enabling preemtion to see them ASAP.
> 	 *
> 	 * Reduce the risk of potential softlockup by using the
> 	 * flush_pending() variant which ignores messages added later. It is
> 	 * called before decrementing the counter so that the printing context
> 	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
> 	 */
> 	if (*cpu_emergency_nesting == 1) {
> 		nbcon_atomic_flush_pending();
> 		do_trigger_flush = true;
> 	}
> 
> 	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
> 		(*cpu_emergency_nesting)--;

Looks good.

> 	preempt_enable();
> 
> 	if (do_trigger_flush)
> 		printk_trigger_flush();
> }

Best Regards,
Petr

