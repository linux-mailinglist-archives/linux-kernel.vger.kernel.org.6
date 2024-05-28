Return-Path: <linux-kernel+bounces-192016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDA8D1745
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E41C22FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43615666E;
	Tue, 28 May 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e9r3NpKS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA75156237
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888644; cv=none; b=Dor2VDpL0Zw9yd0z2RaW+tkDs64OxAv8UQdDvLfmIpc8oXmQ39mMguDIt+DmkrAVEFGBiCtuJZbsVFmJf3tJ2h6VN0pkhoWf/FabXldk5UocHaCEofwn9yI7xlvbqXu1Xocosd8Frk7wusZYu6sFPaMElCo1dx5kloMTpbZuPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888644; c=relaxed/simple;
	bh=wqdC5IoqUi29zHmY+/VyVvjloIr5d6gERcukjbV6Sig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEYebTmJwa+lFnChG9R1T+u7XxMHAV5H36XWR8kIj+LVqq2ErIgJp4ceXHXpk4kOSwyI5EaLcjoyyzIBiFRH6wuxwzqLplYiHm2cPlFLpZvUyp7Al7xhlO3c7QZH0eZKeSxkiu1mIWTnf6BLAcl9VcKK4ImWPgvp8PfxtS7Oz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e9r3NpKS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so655648a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716888640; x=1717493440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAFxvssdEN/NILerDSeYxsl3o70tV+mEhjEYQyqzpcI=;
        b=e9r3NpKStMK6ThfHYRDGg0rEGDIN3jqWnbXKHINwSBTh89GaXBbE8sETLeoz7asilv
         nNNJgQwniESYyut0D5XyiOhbLT8dwrM8kfGCvOTvBI5YuybpwaQ7kJ/n0z6afvwW4Nml
         A9hlTs7fpZ/1OzskzQQ9/A+AoH2PGlPVMsEzXPURj0UOwnvlTKn+8xbeJoqIfVT4OFSB
         1XoQpPbmkmc7PDvkMoD74NnbXypyC8rNxdj48KaFLLPMegqvgHDLgfOewGYVu8d7U1Pc
         h6nCNR1O1v+QQeBrZZ6vwLQ5+YagVctJIEnviQ0AMZ5uJITuAvsDTcEafpgt9VJVIGfr
         hLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888640; x=1717493440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAFxvssdEN/NILerDSeYxsl3o70tV+mEhjEYQyqzpcI=;
        b=KcgxVGStG2z36XKoQXnzwpv8byPw0CUrxg0aaCsNnrqpCExy2t7brQB17txPWi5V3o
         d0hgqD3rupHRknUF6I5cUDIjZrdLFP4iwvgxjytv5d1aR048FFAsg3ug78sFWlw6IOC4
         3qVKyRNpomaYDINgWrDEU5Wd83akAehtTh7Gg1FjR4dRxuRcpju7wmvbau+MEbJqZIXM
         IVphEhs451ofHySnO8hhnYDFzLUZIaVfa3db+JI3j59zBEQc388jyiWmoiBpJMOqp1uW
         +SUeNozGQ+AoNvHIlrva2Zzn8wP+jwA0lscrK/0vtYF95oYHFFQZZ1WZN8QD0EBGeIh2
         x6UA==
X-Forwarded-Encrypted: i=1; AJvYcCW1IZWNjumcaVe7L6LXJ4d+6GJkU7JsaZmjabTTI1cc9F0z78nlxJfb358KScB22AkQ0gVV72AB0/s+fL1xfzErL5wUBxDEaX0E3T8u
X-Gm-Message-State: AOJu0YweqT2eFAbrr4GSLeaL6FFEji/tq4gg7AZGTA+d+w8TpRw7s4zX
	7Cp8qRZRhNIPYXeTA3H3Pkh1RxObgIAtZKteM8DfxUHtT+ReXXyfK9JMlgklOc4=
X-Google-Smtp-Source: AGHT+IHcmZcKKIU5RqMNNxVQCxWbTrTgFGKQR54FgPAbv7dKP3or3v4+NGw5gYHsRzmyvhp+0bf1dg==
X-Received: by 2002:a17:906:2dcd:b0:a59:9a68:7283 with SMTP id a640c23a62f3a-a62641a572dmr617544166b.12.1716888640034;
        Tue, 28 May 2024 02:30:40 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a634b0ec497sm36651266b.116.2024.05.28.02.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:30:39 -0700 (PDT)
Date: Tue, 28 May 2024 11:30:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v6 19/30] printk: nbcon: Provide function to flush
 using write_atomic()
Message-ID: <ZlWkPVzdZC6ktQVH@pathway.suse.cz>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
 <20240527063749.391035-20-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527063749.391035-20-john.ogness@linutronix.de>

On Mon 2024-05-27 08:43:38, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush_pending() to perform flushing of all
> registered nbcon consoles using their write_atomic() callback.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> only flush up through the newest record at the time of the
> call. This prevents a CPU from printing unbounded when other
> CPUs are adding records. If new records are added while
> flushing, it is expected that the dedicated printer threads
> will print those records. If the printer thread is not
> available (which is always the case at this point in the
> rework), nbcon_atomic_flush_pending() _will_ flush all records
> in the ringbuffer.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> fully flush one console before flushing the next. This helps to
> guarantee that a block of pending records (such as a stack
> trace in an emergency situation) can be printed atomically at
> once before releasing console ownership.
> 
> nbcon_atomic_flush_pending() is safe in any context because it
> uses write_atomic() and acquires with unsafe_takeover disabled.
> 
> Use it in console_flush_on_panic() before flushing legacy
> consoles. The legacy write() callbacks are not fully safe when
> oops_in_progress is set.
> 
> Also use it in nbcon_device_release() to flush records added
> while the driver had the console locked to perform non-printing
> operations.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

