Return-Path: <linux-kernel+bounces-415411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D09D35B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904B7B23684
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250816EBEE;
	Wed, 20 Nov 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UhohduDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKBYursc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9516DEB5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092192; cv=none; b=nbz5AcLf3Y2OSoPatOrwVyY4UQ4dkZCInAZpkuyrJKPa8YW4omC2E/Ck5ieABReOTiGGFeihN8s3WmFRf0dAo9jr4qpc1dhfefoEGWEjygm4WnKwdnNFDn/yR33ePCqojbPN3Hwu1Lf07yzjOfxF/Jj4/C7ZArJQb6m8NSxqYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092192; c=relaxed/simple;
	bh=2V0QlM/l/vxXYjj8+iCoy+pP18sFWM7SaVMdSzKb6r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RT+p+0+yv2+LWOkLMdxQ8KIH2EF+xYI2tTDNdzkgEdcdQezj5HOBAGBU4FC92Ls7WiQ5DmHv0tEps5phdNNocUQOOwKJjrh19bHL5WzvoN9oabkokXSJnDghlRTG7pdlVY/NSFHVYTwLnM96RG3Ab4kAB0L7VlqboqdqKOKlb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UhohduDx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKBYursc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732092189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ods0T5WhLc4FK3lnBA/S2/RYdBuV+J0PgZsNmc+Mddo=;
	b=UhohduDx9N9rw9czT3phT9Ldqx7NwJbLj0C6UZaI6nfR0+v1vTuTSUHAo2WIEJjjmsEuOs
	OZT3quPnPkHU2B6NS2a+hn1zm+Nk4XOlQHYoQ4zoQRuAlkWS/fdq8aYG5z3po/n2Y/rpJk
	A0P3SHUJVeAGriA2ozULOSTb6PT7kS1S3w8n6uJbrHjwrAnCa+Q+x0IfQlC5CWIVXiHoBz
	+a+RpKgFaSQMet8bk1uTl1yt+9GCscPFhmyzzFSKUjPuhBWl/uSQvbbozMJwHlO1CSI+ox
	ju0MEO4uwtvnjfYxTOhociNzUov5c6CAmFefzKD7IsVVHY72XmydUThioYZp4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732092189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ods0T5WhLc4FK3lnBA/S2/RYdBuV+J0PgZsNmc+Mddo=;
	b=rKBYurscZDJ8i+WvAxDTP0sLJ83XPTpK3tzijTncJYcPZ10/OzmTti3+V1JbgxS7XCX8Qt
	Ui8Yc/Toax1SD4DA==
To: Chris Down <chris@chrisdown.name>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tony
 Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
In-Reply-To: <Zz1tOxW6PO_2OeSA@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh> <Zz1tOxW6PO_2OeSA@chrisdown.name>
Date: Wed, 20 Nov 2024 09:49:08 +0106
Message-ID: <84frnms3c3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-20, Chris Down <chris@chrisdown.name> wrote:
>>> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
>>> +			     char *buf)
>>> +{
>>> +	struct console *con = dev_get_drvdata(dev);
>>> +
>>> +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));
>>
>>While I admire the use of READ_ONCE() properly, it really doesn't matter
>>for sysfs as it could change right afterwards and no one cares.  So no
>>need for that here, right?
>
> From my reading of the code it looks like we need this to avoid
> tearing.

I cannot imagine that any compiler would perform multiple reads to read
an aligned field of 4-bytes. Particularly since this function only reads
this one field.

At most it is kind of annotating lockless access to con->level. But
since it is not using data_race(), it would still trigger KCSAN with a
warning. I recommend removing it.

John Ogness

