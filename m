Return-Path: <linux-kernel+bounces-396477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A570C9BCDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58F41C226A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C511D5AA9;
	Tue,  5 Nov 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9+mYfby";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ijc+eqIR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0B33981
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812599; cv=none; b=iETkYdE7eLdKJs8PyBPyt1vXpkgmj6U9AVwyC9vmMANpntVAypubFtdFtmhJUyPyEfAdStk/MLUp96ijXU94NVEWzF35SmvnwWhjjSzJVPa1SoZ2l8Km9yXlmrg1zVdlOqMRKtY//otaswVaLF5wiSKRBB8OvgJVMFZMARO8ODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812599; c=relaxed/simple;
	bh=KHdogWpkeY7Om37xbAy5eS+G07V9w4pMUr+kMtfrSh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HiBxuY/4wY1TczO9tzsXrWmMQK9Sv4/1eA5bke1h6ejnRb0/x3UD/n8xzruf1m3FTcnu0m5Bx3znyTZYFU4zzaI6zYDhUSkdzS7s/GmHes2qtIaQLPJyQEwiJA3R41wHU4pzcZVw5V5tVM/p//wDtNl7myx+R3KvCw0O+oErUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9+mYfby; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ijc+eqIR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730812589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPkQk0VjMWZh6rtK6XcZtd2+mZOL929NUUV2Q+vzqL8=;
	b=a9+mYfbyYIuh8oBUPQ3f4LUaOLYVpyzEQI7fsQockCUmUHymOXRBR0PIovra52AkPbN3Un
	M7qh2SnIyWY8ZpYClQ9+wYZX5W6y395aVX95PhS0CCun4ZIEKTLIMW28Q0JVAG21ox02Ez
	yfAzCkA9jwn5SNnvq+myNs4fnhncV1K26JYJqYLWDmYtVGn23CEQBk9uDwCntq6KwPQOSc
	JDBpxcNwAkN6VovocrVfDAe6wHdK6hqYLax9STtPF6oQLHX5vGVGZwLvKnmQU9ZuwyDdBd
	RAOr3+8WFlMqrm0E3lGqy/Z+tZOorj/KQmJBpEByoaHbwDSUILSeQ/cmrrr7mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730812589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPkQk0VjMWZh6rtK6XcZtd2+mZOL929NUUV2Q+vzqL8=;
	b=Ijc+eqIRga7ZM58MJd4ieLFTZQXjCRq6IyYkJmXYcfXY9ZhLabhEZK6JcFSXkQhpQFfmer
	+7FVFBYWxnfH3hAQ==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH v6 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
In-Reply-To: <20241105125109.226866-3-jfalempe@redhat.com>
References: <20241105125109.226866-1-jfalempe@redhat.com>
 <20241105125109.226866-3-jfalempe@redhat.com>
Date: Tue, 05 Nov 2024 14:22:29 +0106
Message-ID: <84fro5es7m.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-05, Jocelyn Falempe <jfalempe@redhat.com> wrote:
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
>
> This patch also adds a Kconfig menu to select the drm client to use.
> It can be overwritten on the kernel command line with:
> drm_client_lib.default=log or drm_client_lib.default=fbdev
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de> # console API

