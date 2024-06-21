Return-Path: <linux-kernel+bounces-224889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CD91283F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2846E1C211D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E92C697;
	Fri, 21 Jun 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BaJQ3Lcc"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F71C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981065; cv=none; b=TnN/xZaetsqpWSjZILM8O42eenJZeNaRkppoNlMeF2ZAi3Tjy8Dyw3jSRDaRNsQORYDiSR92o1QDsgfFoOcrg+rZGpiuCJHX1H43bYxPwb4TiyeG3r1RflmttbkqEMRRJa/XZmyWCFb4BkBtHmP3uvVWAnY76sdfWh+81lELsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981065; c=relaxed/simple;
	bh=wdVc0IzzpVY6bFZ5RLs2sBL850E7DdthQN0J8Ud6wZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9Q7ioQ9MeO+19liZecMMOU2oY1RGdtanUozEfi+hH8LAcDuM3ekrDaRBcxNAHybED3yC71UNpwzBkAzerQ0ift4g2tyHd41MZtTclrbAxThDh26wSfDiUeeRiVrtqvYpkV9ymqEO5UIBgbVGFPpr4XcbwJ9ZZnaAK2l/LQVXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BaJQ3Lcc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so25144531fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718981061; x=1719585861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ats5UWlP1CXkPHuaBr8eYJrF2DI0tWGV0LI0pqaQDWs=;
        b=BaJQ3Lcck2A3/wdEZNm6Bw1AyKia5mcTkCmZRCAGgWHSH8hAyL5E+J0OCKzt3YHMBl
         brTKrvDTeHnp2gsWSrYmMbzOoCAKd/e58VGL+6pEREwXVJz7xkz4c9VFcuql0hVS18Wp
         Zzq5xZQCdotj9Ml83d84OYZFZZIA9lUbXjeHuidSsom/he/WCzBNRH1pf7Z97f6n+laI
         Qr38ge9a63J9GS7TihKg77rKG8A+fzQeSQz52SEtlBeyVDhz8CpZqtzsLXT214P5yG2e
         jvdeh8wjzYrM1bswTkqkAev97gcOOrLftcbG1b11IivD+YfT2bP2jD9yDGUonRNlSIAB
         Raeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981061; x=1719585861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ats5UWlP1CXkPHuaBr8eYJrF2DI0tWGV0LI0pqaQDWs=;
        b=TwEhqGzGYOTI2/xk2J/wvKMbcaoY+/85gx4AMb9iPvaWPN7gs2qQ0/NwoAuQnUg/N6
         VRmVmMTbopWNV4mvTBLkCutZRCw3m+LPgFEmP8eRVmtUnATYs160IuRsfmfd7pxbFtzj
         FPsj/3r+S6d1tblxJK+VYA/BjSvr127p+RvJXIk99q4xxG9SYWJ9cDZ4EuVwYukDGqDj
         g5age1pSO+h0HzWi8fTvN5d8CwHl8jIrO+ljwdZthoStkjgrIflqsV1VHDj4momA4gcA
         9C+zZexz+BbegluvUNkJGXGgTZVIh5ee0z5le6m01900nmnOC7RWbe/jurwBUeC6rWvz
         qeEw==
X-Forwarded-Encrypted: i=1; AJvYcCUCEW3YkrwKftTYjX37+7NJKSrl5c9Y4BYvEGRKvjM3QiLzx1es2NVa5CDCw2iHnDSps7H6c+pZBrlpVkc/V1UsJDQaOroynbuRwHUZ
X-Gm-Message-State: AOJu0YxLRqQL2huTItr4Mjt4l8sIIZJoZLatfXMMF4FDw5JUyPkAgCF5
	4EAtyBMm2NW1dtRzibT2Gd2mD9dlsWkPiao/C4MobkpeKcrWETlGuyjDQ6T0n1s=
X-Google-Smtp-Source: AGHT+IEshMnsi3QWTuoEeaN0MSgghrRb7Fj1ZSBqc4V276uLBC1sm4eXx7Dtwk4dL72aq2DQHHpY8A==
X-Received: by 2002:a2e:9088:0:b0:2ec:63f:fe91 with SMTP id 38308e7fff4ca-2ec3cee12f8mr57893561fa.38.1718981060810;
        Fri, 21 Jun 2024 07:44:20 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a62398sm1676963a91.12.2024.06.21.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:44:20 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:44:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Fixes for console command line ordering
Message-ID: <ZnWRup3MvcVQ4MX8@pathway.suse.cz>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620124541.164931-1-tony.lindgren@linux.intel.com>

Added Linus into Cc.

On Thu 2024-06-20 15:45:25, Tony Lindgren wrote:
> Hi,
> 
> Recent changes to add support for DEVNAME:0.0 style consoles caused a
> regression with the preferred console order where the last console on
> the kernel command line is no longer the preferred console.
> 
> The following four changes fix the issue using Petr's suggestion that
> does not involve calling __add_preferred_console() later on again, and
> adds the deferred consoles to the console_cmdline[] directly to be
> updated when the console is ready.
> 
> We revert the earlier printk related changes, and then add back the
> DEVNAME:0.0 functionality based on Petr's code snippet. And we end up
> reducing the code quite a bit too this way.
> 
> And we also revert all the unusable serial core console quirk handling,
> it does not do anything for the legacy "ttyS" named consoles. And then
> we add a minimal serial_base_match_and_update_preferred_console().
> 
> The reason we want DEVNAME:0.0 style consoles is it helps addressing the
> console based on the connected serial port controller device rather than
> using the hardcoded ttyS addressing. And that helps with issues related
> to the console moving around after togging the HSUART option in the BIOS,
> or when new ports are enabled in devicetree and aliases are not updated.
> 
> Tony Lindgren (4):
>   printk: Revert add_preferred_console_match() related commits
>   printk: Add match_devname_and_update_preferred_console()
>   serial: core: Revert unusable console quirk handling
>   serial: core: Add serial_base_match_and_update_preferred_console()
> 
>  drivers/tty/serial/8250/8250_core.c  |   5 -
>  drivers/tty/serial/serial_base.h     |  22 +---
>  drivers/tty/serial/serial_base_bus.c | 116 +++------------------
>  drivers/tty/serial/serial_core.c     |   2 +-
>  include/linux/printk.h               |   5 +-
>  kernel/printk/Makefile               |   2 +-
>  kernel/printk/conopt.c               | 146 ---------------------------
>  kernel/printk/console_cmdline.h      |   7 +-
>  kernel/printk/printk.c               | 122 ++++++++++++++++------
>  9 files changed, 112 insertions(+), 315 deletions(-)
>  delete mode 100644 kernel/printk/conopt.c

The patchset looks ready for linux-next. And I have pushed it
into printk/linux.git, branch for-6.10-register-console-devname.

I am not sure about the mainline. We need to fix the regression in 6.10.
The change is not trivial and rc5 is knocking on the doors.

Unfortunately, the patchset intermixes reverts and new code.
So that it can't be used for simple revert as is.

I am quite confident that the new code works as expected.
It changes tricky code but the logic of the change is quite
straightforward.


I see three solutions:

1. Linus could merge the changes directly into rc5.

2. I could send a pull request after it survives few days in
   linux-next.

3. Or we rework the patchset. And do pure revert for 6.10 and
   add the feature a clean way for-6.11.


I personally prefer the 3rd solution. But I am super conservative.
I guess that most other people would go with the other 2 solutions.

Best Regards,
Petr

