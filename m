Return-Path: <linux-kernel+bounces-395140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB129BB90B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06278283001
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0371BD4E4;
	Mon,  4 Nov 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="daeSv8Tg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqNqZMao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B61C1B85C9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734377; cv=none; b=Ce5STeP7rrugqtkFmU6mUhTbamf+dHNU5FZwbKlSOwnDgmEJipY0nhg9NZezZ+Y8l21ogTKYa3fYV0M+sIIfNhcCIgFOKb4T8HID2E7r7ngCxzZ7ZOBEkSEW5ycAyH7g+a0zR96GiEPSZZ9cMesvm9nEKn1SRKYNdO/aFia7ZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734377; c=relaxed/simple;
	bh=2QC0Bk9OJEyHVHN98ZgrsyfJ80PseBVAS8n2MGRAkbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMRL85lt63WNGmFFptl1v0ONGjZpr4JPuFcdjFYKM1T9+MyAh63E53QM7VyGAw722Xtthz0azUmZrS/vs3eaw5mC10UjYOYG14T1GKnMBx7un5vBlH5WXDQfiwejoI2NPhyowTOWHqeQJenrj+w/d37oFm2enxGw/Ovp+WNVkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=daeSv8Tg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqNqZMao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730734374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC0Bk9OJEyHVHN98ZgrsyfJ80PseBVAS8n2MGRAkbE=;
	b=daeSv8TgZ7xUmG8BTCmaQePdaALze5WlrjITCDmHwhXIUJrkLv198NZSwZesNKGq7Jtmjq
	pCcmBcImbEs2yjvLlTz75oJmPsfcySaNWB/ZWYcEeOUUzYQatm4r/O8ZNP/8MWItfDElCc
	gCISbBgHtl6nDb4xGzZNiCPg8n14tnc+fjwrYMagSSxdxTJgEbA8aWBz6lG5aMijVKSmkN
	ZV9K/+b22XzzpjbE+TmeXtryQaGIamCre9+W5c0ZRwIC3ZodYkRVG3fWCGGcuU4qluEhJS
	5O03alLzK1lmkfQUsFR/WDIJztLgAOxrxH9nIaYKxenfKX2L6HtVLvttm/9U9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730734374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QC0Bk9OJEyHVHN98ZgrsyfJ80PseBVAS8n2MGRAkbE=;
	b=AqNqZMaoJ2vVi6NRGqEZuTp+ac1oMg1xnbuWnO7eJtuZcWGRDLRJ1mZ/ydUMu94Kkz0ysD
	IEN/eW61I5+vdEDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
In-Reply-To: <ZyjXB52dbhjZEHp6@pathway.suse.cz>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
 <84o72vcm46.fsf@jogness.linutronix.de> <ZyjXB52dbhjZEHp6@pathway.suse.cz>
Date: Mon, 04 Nov 2024 16:38:53 +0106
Message-ID: <84ikt3c8uy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-04, Petr Mladek <pmladek@suse.com> wrote:
> I wonder whether console_start()/console_stop() should really
> manipulate CON_ENABLE flag. It might be historical solution when
> @console_suspended was a global variable.
>
> But it has changed with the commit 9e70a5e109a4a2336 ("printk: Add
> per-console suspended state").
>
> It might make more sense when console_start()/console_stop()
> manipulates CON_SUSPENDED flag. Then it would make sense
> to rename them suspend_this_console()/resume_this_console().

I worry about letting console drivers and printk.c both modify this flag
during normal runtime. One might clear CON_SUSPENDED too soon and cause
trouble.

CON_ENABLE and @console_suspended were always orthogonal. Moving
@console_suspended to CON_SUSPENDED did not change that relationship.

IMHO we should continue to keep them separate. But your point about the
console not being registered is a good one. We should update
console_stop()/console_start() to only operate on @console if it is
registered. Since those functions take the console_list_lock anyway, it
would be a simple change.

John

