Return-Path: <linux-kernel+bounces-441690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E49ED298
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0BA188736E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F81DE3B5;
	Wed, 11 Dec 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ypN9Alzh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StwaHTUS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A11DE2DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935715; cv=none; b=Eg21MKEGfggnr6JCNRy59FJ7Ve1ABIhvLcleixNF6uq1QP7Q7gULBhC5GjQr4P3grPHgYv4zPouSl5197CLpHXd+CpzspCPja6QT7DBt8qQ4gr9L4Emb5JBZ56LoMXHxD7oAjuH0oFpCMIaCLE9tS1st0r/2S9VYmlvPmOlShwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935715; c=relaxed/simple;
	bh=dZQn6bNebmkTVowYXzlCP4OqDVKd8SLhTUV0Jy/ZkWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ecbxliBdvLAb9ADqP+1Bp2FRlYN4gIHihO1+FL2imR9AkljpS7vNDl+9n1UJcCMpnLMI8XnjxFE/DM4jfLy9nucIfZNcq10QMCb/RmF8rBx/pPQBA9PqHf7omFP+nWAzzf1ZCdtrVljwH1KbJ/55YBBzWrKRjc8UjNeSYQMf7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ypN9Alzh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StwaHTUS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733935712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJb/RFSUIH3bjqq9oUd+OecysTAROn+D7Lpyi9kGlQY=;
	b=ypN9Alzh9rp5eCvcOfy+r9Ku8VAW9cCW+y+Vt/ZpFjmutSamMb8W7fv7pJDLSJCT45mAN6
	tZ/65mwhhBp70oxEb7HPnjheSeiA/eXdsrCybbob+Vnih7JrfAEUnSrjrT6d6pcUuOS6ru
	xzV2GNRM+zuNAXhT2AAhj/NK83pRUI/IUCnHOOJ4U+P+wa90s/Zs6LGutRkp2D9z5r3f1x
	pHDZWrFYjQJrudWu3ty7NYzizpa5aRhUqo2ymnlQ/A2PZTne5SbN5e21MpHae0RkovwzIa
	Oq8AHmjMhAgWz2QhhJWcqlLjyYrPligtruzGOs6SEZ0Z+DkyD0tnEkBA6zwpGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733935712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJb/RFSUIH3bjqq9oUd+OecysTAROn+D7Lpyi9kGlQY=;
	b=StwaHTUSBGJFHOC/WWH9nthhCfANsulhU/wK2xEfQ1mPXrG1a40iwLdexFovezy/z24kEo
	HL0pGdoAQwR9owBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Rik van Riel
 <riel@surriel.com>, Omar Sandoval <osandov@meta.com>
Subject: Re: [PATCH printk v1 2/2] printk: Defer legacy printing when
 holding printk_cpu_sync
In-Reply-To: <Z1mpxhCU-WpaKJIt@pathway.suse.cz>
References: <20241209111746.192559-1-john.ogness@linutronix.de>
 <20241209111746.192559-3-john.ogness@linutronix.de>
 <Z1mpxhCU-WpaKJIt@pathway.suse.cz>
Date: Wed, 11 Dec 2024 17:54:31 +0106
Message-ID: <84frmu2mjk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-11, Petr Mladek <pmladek@suse.com> wrote:
> It might be worth adding a reference to the original report
> to show that the problem is real.
>
> Reported-by: Rik van Riel <riel@surriel.com>
> Closes: https://lore.kernel.org/r/20240715232052.73eb7fb1@imladris.surriel.com

Agreed.

>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> Fixes: 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and regs")
>
> Anyway, it looks good.
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>     I could add the above mentioned references when pushing.

Great, thanks!

John Ogness

