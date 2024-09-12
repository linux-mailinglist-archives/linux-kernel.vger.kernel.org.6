Return-Path: <linux-kernel+bounces-326678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D209976B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD38FB2159F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7A1B12C2;
	Thu, 12 Sep 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbehUcRl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="85PBOx26"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3121D52B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150283; cv=none; b=lXlEtwhdbXIOEbjhPxDEijLTPPvYm+XXIrygYkc2w4Jz7DkK0NKQgTYeM3PC/GHMMlZUy8yJ70+kzY/1fOdaYYyrmslHOmqQlsaX0C/5ID4o1iScKOoimr+Eq62dszxELMlfdVENmVKYlbnrvfz6RkzBYtiKc5Jmz3DJ+0TrgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150283; c=relaxed/simple;
	bh=WRWSfhgldGzLaWg+BbR4DVYe7vYOz61Bb5d6nrad+lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSmcU4KSDkZ5zAeoNo52PZUje+5PsSqdvbwgPlz1uH7G1TXk0DoZ90ODAxdyXTlvnTztgsEOAOSJUpXD2rjFoViobDETlT3Icsd47gkbthOBq1P9XF07HtsDWrcdkLtdpESIrMdBNkNQ7JiwIPYBuVw/g11RWeRsvdf1u8Z1Bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YbehUcRl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=85PBOx26; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726150280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BmQQn0NA7A3HI6f1goHSPD5Aj/1Se9SJOMQU+5q5BMQ=;
	b=YbehUcRlxZcSdo5Y0dF6Se8GM+qSQwyeeQb5GTwLEHG4/rkxv5sXDtzm3i1on3JbIp8ZDs
	syg3HqOYYf2c592xFZnAGn43OBKmUhJ98nWcxQSrnTt3WNJdUFSB2GUAEUzPGwIJ8fggfv
	7D4xO/L3jmRivoXdbq6tpwz/5a9Ok/3hK3cGZZJW2T8Gp71PEH9QPzwmS3g8fH0dY1x5oM
	vE+S1Ne9H/ytoQL0i70NwoGoxFKAy5kZQb7ITWHslB4ge7i556IPLCfOAqUmRnOaBoh8lb
	TfuubwCXS3zXsu5DZoiAX4uepoQKy0AxwbvMMSWms1pQ3Rf3fv4xJFoVMtkBlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726150280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BmQQn0NA7A3HI6f1goHSPD5Aj/1Se9SJOMQU+5q5BMQ=;
	b=85PBOx26vkTENLN2s5DG+kjBS1IdzrtdYgcfJxebHNu6/e0TtEBEsP6iiixzfNgpjIe2WI
	uQ0bSrxtrvJr4cDA==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v3 2/4] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
In-Reply-To: <20240910070733.156127-3-jfalempe@redhat.com>
References: <20240910070733.156127-1-jfalempe@redhat.com>
 <20240910070733.156127-3-jfalempe@redhat.com>
Date: Thu, 12 Sep 2024 16:17:19 +0206
Message-ID: <84cyl9c67s.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-10, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> drm_log is a simple logger that uses the drm_client API to print the
> kmsg boot log on the screen. This is not a full replacement to fbcon,
> as it will only print the kmsg. It will never handle user input, or a
> terminal because this is better done in userspace.
>
> Design decisions:
>  * It uses the drm_client API, so it should work on all drm drivers
>    from the start.
>  * It doesn't scroll the message, that way it doesn't need to redraw
>    the whole screen for each new message.
>    It also means it doesn't have to keep drawn messages in memory, to
>    redraw them when scrolling.
>  * It uses the new non-blocking console API, so it should work well
>    with PREEMPT_RT.
>  * drm_log can only be built-in (and drm must be built-in too).
>    The reason is that, if you build it as a module, then a userspace
>    application will be more appropriate than this module.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de> # console API

