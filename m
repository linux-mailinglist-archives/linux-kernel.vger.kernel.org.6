Return-Path: <linux-kernel+bounces-527967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0405DA411D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC7F1739DC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5723C368;
	Sun, 23 Feb 2025 21:11:24 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62F18C039
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740345084; cv=none; b=XzNjwjPgJnufO6S9GcTv5qI7ZRW2L8IPD6PRD6y626oEW2MKrJ2kwOH64ZGoEkbSqjgAcB39qNnAjRmzPVZVLpnmKWgL1sBFOS61A+3BzkHdMYJb/vEpHrwFQD6kcfUzUu6oe8J5SqfHPxQmP97RoFGPgaSaH4PNutNLgtVNrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740345084; c=relaxed/simple;
	bh=lImTL5vWnzr5yIsTdR4fXE2f+0q2Fi45JWqnLna7WCE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPEJG0qL08M2UjL/8p81twpgniu8ULGob98ZwkFImAg2YSOlgIo90DRUhhdhYzc72C3/CtXN3eHDJdUe72IgAD6lhF4naWm63jNAJKARUzzIZ1D+ITZBv6tXpdxVx5pPlxSwkbUXnvOHgEmDgt5jI+7UWxfmgk9Z7LpyfvwQ0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 90c04476-f22a-11ef-a29e-005056bdfda7;
	Sun, 23 Feb 2025 23:10:10 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 23 Feb 2025 23:10:10 +0200
To: adamsimonelli@gmail.com, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/2] Optionally allow ttynull to be selected as a
 default console
Message-ID: <Z7uOsqky4Tw9J6QR@surfacebook.localdomain>
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223204456.1913392-1-adamsimonelli@gmail.com>

Sun, Feb 23, 2025 at 03:44:54PM -0500, adamsimonelli@gmail.com kirjoitti:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> When switching to a CONFIG_VT=n world, at least on x86 systems,
> /dev/console becomes /dev/ttyS0. This can cause some undesired effects.
> /dev/console's behavior is now tied to the physical /dev/ttyS0, which when
> disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
> and users who upgrade to a theoretical vt-less kernel from their
> distribution who have a device such as a science instrument connected to
> their /dev/ttyS0 port will suddenly see it receive kernel log messages.
> 
> When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
> the ttynull device to be leveraged as the default console. Distributions
> that had CONFIG_VT turned on before will be able to leverage this option
> to where /dev/console is still backed by a psuedo device, avoiding these
> issues, without needing to enable the entire VT subsystem.

This rings a bell of the following

https://lore.kernel.org/all/20201111135450.11214-1-pmladek@suse.com/
https://lore.kernel.org/all/20210107164400.17904-1-pmladek@suse.com/
https://lore.kernel.org/all/20210108114847.23469-1-pmladek@suse.com/

I don't see any mention in the commit message about these, have you studied the
cases? Will your change anyhow affect the described there?

-- 
With Best Regards,
Andy Shevchenko



