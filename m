Return-Path: <linux-kernel+bounces-298696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1370295CA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920282819E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3516DEA9;
	Fri, 23 Aug 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XrrroSvo"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E271BF3A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408359; cv=none; b=m9gAIAPQ2TYHU7odAsjXoPIAIcQkOjrh+dHiTxIWflWQMnOhH1jeEynN3zq0BhkkKjfvoiYBD6wPb7hyPj6d4gYXwWIeOZpBJ+K1WCkO13MW7WcgydIfJkfeNZ3lo0vq14WyLAhPtv+vvAAYsIpMMaUoKeN2pLrk6JcjKlLzIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408359; c=relaxed/simple;
	bh=X/D/qMiiuGO0ronE509FN5+oXDtqy5xTneS7ccPkNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljNNk0AYleV2CYkynG0Wfc2U7uXXDi6LEcYZj6Vjk5JTPfIkQUXdObLqno0zvzxU3+aKf3PQ+jtIpaB28qs8P/j/cx9mvjPLS0/FDikm8s4DjSAbRUVADX4e4RvBmgmmeWKiGxysXLCFrlGi2LOmJ2rHALtUTP0JvZxcWdAdRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XrrroSvo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8695cc91c8so186542266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724408356; x=1725013156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+OwBGXAKI3slwnu8cHyC1RBirAmeMtlNDQazpCvmqs=;
        b=XrrroSvouHdnc4FMwEZS/VxxmUFEQu0rqml7+0fvmbc+p6n4Mzmw8CV1yK8BOvjALX
         lYU0JUF4JxC4D3hQoW80gcn7Lv1DqLTJ0da32nJy/LqzJlZt1ZTjylO5uLobjAp43Ijh
         cVZmh2T2f05Cd4b6zu8UHFUfHi4oKOXqZPMNlYt33MgT62KHhGgvytkQ+Gdb14+Ax7G8
         oH1h1KEwXlGMTNQy31mRY2kf0hLuRZI3FtsoHLUJu3g3HFudkgElPQWsT745xJGy6Axs
         k5SzSafv86fcuAlDy4IE95NHClexeyuby+Es5JSiDQXMpSyX9qxrHDeBVPwjIHGuYt0o
         SBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408356; x=1725013156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+OwBGXAKI3slwnu8cHyC1RBirAmeMtlNDQazpCvmqs=;
        b=POi8zYfeY5j+GoM7jNClCDSEtUY9roR5/Q7aioVl3QgQKJgX/615caggPdwFt/Buye
         UBiQ1QW/lDYW/6fkh/ZGrfxUZ/j34D6fSUj/2WYxnX2J74Q3gQbMDtzjGqBOIrfmPKvp
         szl810fTpLJI9s2zHz2NlWKXpbrHxwFvcm1hiQAvmD9UCEc5/6FrVtfNpOcAK523DzaW
         7Qlhp5imub6+uT57uPetVlaCLQ5G3CUfrq8ok6cbRDYoyoiOgYW1Gk8KC4bIID1YwbS3
         6pPMOybm3uOFFGkj8p1O7DCGwmhVARwbOZ7gBk55mB0iKAyGwVxgtPc1bm11lNVu2XkV
         8GpA==
X-Forwarded-Encrypted: i=1; AJvYcCV7RYHB37pQHSLXdk/g6JLH6S3FDWjpt508WVgxE1Z654dygO9LOaW5boxxHTZ2YlrkBM9d8t6nt9+QYA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztensBRoYKooHWdpPICArB3Aw2+pwx9oxZYbRLqVAMyX7K21bK
	/gHlfGGQ8ikmVCZ9gtJ372odihDHBA3kjphYqrB5T6yVAWSrKmYY2+tikJzPlNV92+a+XuSkCHy
	x
X-Google-Smtp-Source: AGHT+IEo30GnXKdJ4sC1bDm/LneYdoi1ivUXSW/M9AGDE0GOCSZOUVWi8eIabw3msHPiiEAsNm0NTw==
X-Received: by 2002:a17:907:971d:b0:a86:8f2c:5cfa with SMTP id a640c23a62f3a-a86a518a3c8mr123988666b.14.1724408355739;
        Fri, 23 Aug 2024 03:19:15 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f62f1sm239092266b.218.2024.08.23.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:19:15 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:19:13 +0200
From: Petr Mladek <pmladek@suse.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <ZshiIdUFQs4CKW2t@pathway.suse.cz>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>

On Thu 2024-08-22 12:32:15, Derek Barbosa wrote:
> Hi,
> 
> TLDR: plain, vanilla 6.11.0-0.rc3 is slower on flush and 
> does not print traces in panic/crash context consistently.
> 
> 
> The purpose of this email is to share some findings with regards to the latest
> available printk changes, in comparison to what is currently available in the
> "mainline" upstream torvalds tree.
> 
> Specifically, there was concern regarding flushing, flushing speed, and ensuring
> that viable information can be displayed to the user in critical context. This
> email also assumes that [0] (and the rest of the thread) has been previously read.
> 
> Moving on, I've been testing the printk code present in the linux-rt-devel tree
> for some time, and have been honing in on comparing behaviors/interactions
> between a stock, regular kernel and the linux-rt-devel tree. 
> 
> The kernels in question are the following:
> 
> 1. a stock torvalds kernel, 6.11.0-0.rc3 
> 2. a linux-rt-devel kernel, 6.11.0-0.rc3-rt2, which has the "newer" printk code
> 
> As a note, 6.11.0-0.rc3-rt2 DOES NOT HAVE CONFIG_PREEMPT_RT ENABLED.
> 
> I will refer to these kernels as "new printk" vs "stock printk".
> 
> I've also attached the configs for these kernels.

Could you please also share the kernel command line? I can't find it
anywhere.

Especially I am interested whether it:

  + wanted to show backtraces on all CPUs via "panic_print" parameter.
  + did a crashdump or a reboot.
  + used also another console (graphics).

> --- Test 1: John Ogness' Console Blast. ---
> 
> This test uses a script which calls itself to create a pinned process for each CPU. Those
> child processes will run in infinite loops of show-task-states via
> /proc/sysrq-trigger. This generates lots of contention on the console. After
> some time, we use the sysrq-trigger to crash the machine. 
> 
> The success condition would be to be able to view the full crash backtrace via
> the serial console. 
> 
> For each of the kernels, 10 back-to-back trials were performed. 
> 
> In the 6.11.0-0.rc3 stock kernel, we did *not* observe a trace on crash. There were various
> other traces scattered/nested throughout the show-task-state noise, but no full
> crash backtrace. At times, there were upwards of 13k dropped messages.

Do you miss the backtrace from the panic-CPU or non-panic-CPUs or
both?

The dump of the backtraces on non-panic-CPUs might have been affected
by the regression fixed earlier this week via
https://lore.kernel.org/r/20240812072703.339690-1-takakura@valinux.co.jp

Did the system reboot in the end?
Or does it got stuck somewhere?

> In the 6.11.0-0.rc3-rt2 "new printk" kernel, we observed the success condition on each run. At
> the "end" of the test (the crash), the full call trace was visible and presented
> to us via the serial console.

I guess that it is not the problem with the non-panic CPUs because
v6.11-rc3-rt2 in rt/linux-rt-devel.git seems to have the same regression.

It is great to see that the serial console driver transformed into
the new nbcon console is so reliable.

Still, it is strange that the stock kernel is so bad in this test.
console_flush_on_panic() ignores both console_lock and port->lock.
There should be a good chance to see the messages. It might break
"only" when the console driver has been stopped on a non-panic
CPU in a state which would prevent the panic CPU use the driver
even when locks are ignored. Well, the chance of a breakage
is likely bigger when the messages are flushed also on
the graphics console.

Anyway, thanks a lot for the testing and sharing the results.

Best Regards,
Petr

PS: I still have to think about the other results. But they seem to
    be less surprising. I am most curious about the so bad behavior
    of the stock kernel in the first test. I hope that we did not
    break something in the patch handling the legacy consoles.

