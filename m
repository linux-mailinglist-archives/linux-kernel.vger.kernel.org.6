Return-Path: <linux-kernel+bounces-416004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5229D3F12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DA5B25581
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327CE19F424;
	Wed, 20 Nov 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0udoYSb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGriwE2r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E61F931
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116576; cv=none; b=dpyiumRqjHSS/ZN2tnLvJ1mQtNdwDkxqN3jC9cm6JVtgyzm/sZNV/sWijXDwlJifjV5mj+RS/gDJ1JBiTXg1ERRW+Xp2JfSg9XCEVdBoiF14csgIi5i6Z4r9eeAQq53ouZ3Cslt5uKIjI7Rctf8nYaGUdcOG/RlGxSd00by91wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116576; c=relaxed/simple;
	bh=0sYuBJXRBlYh1MBKqXti/QWl9Ne4kI9jLLhLsWs+AMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oh0GO6npLWKfiAhAjhQWKZ+e5jIXMbJAv0wQlc1nIw2Y7PWud9BBSVEFGodvQl+Aw9nhZKctMZHGdUNmu66X4g97ywnB45w2nB2SuzEcCuqVsvSvbVBRFiHxr3UYtiKG0Ig/7uKkBBZC3WLaJgQ4lio/laXhcYeaqHqnectqE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0udoYSb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGriwE2r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732116573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sq0OSJ3Aw1pI3hgGt8CPbUUUOS/N62zZGOchTV9fwq8=;
	b=s0udoYSbo/88vPy4sONXi3EHUB3HGgcJKHD1U8WWrilQbQAi22LgL4I417P7Gcu498JgJ+
	mlHxNr9xklnawlcfBEoANvF0G+BLfxUsAc79WqeLUnZ8BBkFJYhHVPIlQI7SJ8zDzxMnTK
	eNipax3+44OueE08L+bC8bdP/yq+yp1vtfDcI+XDTb4FkaBn586FXCJ1T1m7iL071jhAty
	G8amjxq7a82Vvai29o/++TT6s09idwWqkI1YbHLadXKBIh0kp7zmbk36+NFgp+aS/S7W3O
	pb6D7iFYux7qhxMfdjjlsCyQVnRgvGXQA+m957fLlmr0MKlxRNOHgvRjFxI8Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732116573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sq0OSJ3Aw1pI3hgGt8CPbUUUOS/N62zZGOchTV9fwq8=;
	b=YGriwE2rVRVnCZ7zp4voApsaNn0jKnhDVcCckr1xZBYGOyOeU9TnsMtxfrEJHglQkz1z0h
	iDIf2VoMjmJifoBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Chris Down <chris@chrisdown.name>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tony
 Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 06/11] printk: console: Introduce sysfs interface for
 per-console loglevels
In-Reply-To: <Zz34GgmFbuZKQOzG@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <2024111508-native-subtype-2990@gregkh> <Zz1tOxW6PO_2OeSA@chrisdown.name>
 <84frnms3c3.fsf@jogness.linutronix.de> <Zz34GgmFbuZKQOzG@pathway.suse.cz>
Date: Wed, 20 Nov 2024 16:35:32 +0106
Message-ID: <84ed35rkir.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-20, Petr Mladek <pmladek@suse.com> wrote:
>> +static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct console *con = dev_get_drvdata(dev);
>> +
>> +	return sysfs_emit(buf, "%d\n", READ_ONCE(con->level));
>
> Honestly, it seems that everyone agrees that the READ_ONCE() makes
> some sense. I do not understand why some many people wants to remove
> it. I personally prefer to be on the safe side.

OK, then please also annotate the data race to keep KCSAN happy:

	data_race(READ_ONCE(con->level));

From the data_race kerneldoc:

   If the access must be atomic *and* KCSAN should ignore the access,
   use both data_race() and READ_ONCE(), for example,
   data_race(READ_ONCE(x)).

John

