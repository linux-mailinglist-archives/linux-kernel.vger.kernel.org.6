Return-Path: <linux-kernel+bounces-275962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D45948C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CB91C2252D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87961BDAB9;
	Tue,  6 Aug 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eXwgULX/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CEF4FA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938383; cv=none; b=PSlECqOndhMDdzVwHtdwAhCdtXjuJ04f845zSeFmMLJUlGZ3L8HvSMrdkq1WvUb/vrKSJwb3Ymq1HNzzeVxPO02oT5q3Hv48Cx47VFE3fD8V67/Yuiy6u1CpaHSp8MiyPMVAncTjHGXvl5SboGfkC+5ZtYDMTqnmMhfKx6Qq+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938383; c=relaxed/simple;
	bh=jfYtsYosr3LNjYgSJ6LrNoysKLdpO1cyCjh/oezofIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRhYPbvb+xr3vgOT0TCrXcS+96pJsYYc0Xqu+NDSR5qkR4d569BKxdqUX/NWIc0XDzCr84NEU1VB+3jk1kgkjXuC1zhMI2258GdLjAf9iuUjccI9vD/SbSQESDGfB+o9s8M3hRWgTRCatymyUKew+OBd/6JqBr6ROHiUsFhvWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eXwgULX/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso448567a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722938379; x=1723543179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzjvGjguyvryyv7j8y2XrFN03nYhK72nEoCw8wxO7Zc=;
        b=eXwgULX/uTMOwShO/objRkMvCMt0h15MPAa2W16rYTX3OTq0IgdDQTW6O+VHLPEz1V
         /EbOoefgHfh4nySAEPaaBj/+xdxunK8NxZbTGvdMeq8X0jkRvocLSVfuYmyhexN3QsxI
         YtBoUAOUoQBNMQKlk7X5ESGQNdAdXicn7l38QFRNje+HJAj6EiA9kwW/No2Ae4EAHP1d
         KxA9VDGsyGK9mMfq4wFILrn8PnmaAgyvCmMFs/xkH0PtcfVxpchC/vExf38prDU0N9Gi
         nlp9Bb0oY3RCnyhNIIQZXj606cZS//GkmYHAJxSJmpX5wyaTwBCMC936CK1mO5IZxTXu
         nCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938379; x=1723543179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzjvGjguyvryyv7j8y2XrFN03nYhK72nEoCw8wxO7Zc=;
        b=sY7+IoJgw9Sx0atg2yfT1wustxD2x+c3g9B4+qtJ0b6+rZ4DgbC++1eoI0h65LID6R
         i4dT+Lkmfe2+hv7FPQXY4tGz2IHU5Gd1UeHmVoJCx8Vc1mDqJOvUA110f3LfJ8pl4ad5
         mgJAdFPYPsuQF5sCd05oO+u9ptP2jK+sqtDHlG4jN+U3wRb46c6Fuajvnwv8byJT+qLH
         rM1yDyPvw8cGUWp4berMnM6WLPXkKNvhWmvL5CoWRn6PBTBKmA+i+1novZRiWt2cwvog
         EboAYtdWctrMly4vuWm1IqHv3XWC295+BglDt2IeXCqGOg1SrN4VdbV7EdrOcq7K2Kjl
         fNzA==
X-Forwarded-Encrypted: i=1; AJvYcCV642m4OFPxL9rCDg0g7qB3d7246ph6NDpiZ0hVHZopA/NqzZUdHMVYXeUO1zMGxVQgFn1jc9/DtYNyENk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpm2xxtjLc/GvMOZrZnyEkXAYiqgVDtDV9WDQ1s64IKOFpIsee
	+yYG/P2SEYUeuY2AkKBwvm3bAcRE77WWtgvC31xmlvsGV51BwemQg/VLeI13N+E=
X-Google-Smtp-Source: AGHT+IHUssyTrYRnF2LuPQQU3lsc5nYpuCOT2g2ZrjhSk9LDPNezUobXQu1d9i5IhLSMpFHpVMlb1A==
X-Received: by 2002:a50:e602:0:b0:5a1:faf:e5ac with SMTP id 4fb4d7f45d1cf-5b7f540abb6mr10095310a12.26.1722938379128;
        Tue, 06 Aug 2024 02:59:39 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c25558sm5816974a12.32.2024.08.06.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:59:38 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:59:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH printk v7 29/35] printk: Coordinate direct printing in
 panic
Message-ID: <ZrH0CYDseR1b-QfI@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-30-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-30-john.ogness@linutronix.de>

Hi Linus,

On Sun 2024-08-04 02:57:32, John Ogness wrote:
> If legacy and nbcon consoles are registered and the nbcon
> consoles are allowed to flush (i.e. no boot consoles
> registered), the legacy consoles will no longer perform
> direct printing on the panic CPU until after the backtrace
> has been stored. This will give the safe nbcon consoles a
> chance to print the panic messages before allowing the
> unsafe legacy consoles to print.
> 
> If no nbcon consoles are registered or they are not allowed
> to flush, there is no change in behavior (i.e. legacy
> consoles will always attempt to print from the printk()
> caller context).

I want to be sure that this is acceptable to you.

This behavior has already been in the rejected pull request
for 6.11, see https://lore.kernel.org/r/Zp-_7R49fIHgIhaq@pathway.suse.cz

You did not complain about this particular change. But it is
yet another buffering in critical situation which you do not
like in general.

It is a bit different from the buffering during Oops. In this case,
the new nbcon consoles will still be flushed immediately. And
the legacy consoles will be blocked only when there is a nbcon
console.

The buffering here should increase the chance to see the messages
on the more safe (nbcon) consoles. The legacy consoles are less
safe primary because of the bust_spinlocks(1) called earlier.

I personally do not have strong opinion. The change makes sense.
It looks like it should make more good than harm. But it is not
a clear win.

Best Regards,
Petr

