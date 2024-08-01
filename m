Return-Path: <linux-kernel+bounces-271115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D769449B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033122874EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79D8183CC4;
	Thu,  1 Aug 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cagmzj07";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/t4N75zz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F216FF48
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509509; cv=none; b=jNC3EBSbJDK2CbGRlQORjVeJ+yUWPJnFGajOCmaNNs1w7/NCRUBQ8yl2z7joFgdiC7PS2oaiT0NaBipzIb6qFk5fRpXJFkch24yEdBivCSzA7f2LSfu+J+oYuOWHdXLogpkzRNDFVCrxeIs6LkYjNlezan2qG3KMMY4pkGUTWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509509; c=relaxed/simple;
	bh=T8eD1W7WVKXjhMCF+YU9xd0Rm+hfrj0/t4kwxqoiZ8M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pug67jRO37lDrJ26ITqTqxS32k9GHX9PyW0fyAS4KemIC5kh1lRR3/d3xphTuEvWcgWsL9D8IGAQv/zwbUCVtA2kijhAElTPPgPev9SEI1mS+yKgocvk8VViv3SO6PyO/vWT9mZ4MuxEUdHLdXuhFGDBSzUYWt87C3vtDRrBjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cagmzj07; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/t4N75zz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722509505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZKTOOlZVI+YrqeoR4euLdbDErwrHIjykpDdt+xf1z8=;
	b=cagmzj07Lcs7RLrazer5vQvdhLoWMu5sPBJqjyTR5FHZtZH5bmXGUzPKj0AQUYgzWh06BQ
	BVUttSh1PgZrCOa4n0xlYyZJ9GqLFG9pWSVEYgtqsN7acD+LpccmOnvHgwJK540MXLbK+J
	JZD2iGQ8D5eUvuSGUivRwUCBoQXSLjw26IY//7J+35AiHb6Iu/bQxXaKGTwLqLZEkbRR0e
	xLSPOlcDE/GTM/JGLqiYkBc5gfcrGMDIkA32G+kH2Otmnh8SXPfhb9G3PNbpafPoUHwgBc
	q6ZS4v0QzVaDsejBXQ5OPqAFXUAesIo+ykfTodG1H7ogUcRc/Gb89IawmAvAXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722509505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZKTOOlZVI+YrqeoR4euLdbDErwrHIjykpDdt+xf1z8=;
	b=/t4N75zzBw+EuLRI2I7Nan98hfqU5E7CSvATRHZlXPvMN8V/nH0FXf8zY6minxvxYBaABV
	jp5JmZtFUvHsK4CA==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <20240801100640.462606-4-jfalempe@redhat.com>
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
Date: Thu, 01 Aug 2024 12:57:45 +0206
Message-ID: <87o76czfb2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>  * It uses a circular buffer so the console->write() callback is very
>    quick, and will never stall.
>  * Drawing is done asynchronously using a workqueue.

For CON_NBCON, neither of the above points are necessary. You can draw
directly from the write_thread() callback. See below:

> +static bool drm_log_work_draw(void)
> +{
> +	unsigned int len;
> +	char buf[512];
> +
> +	len = drm_log_buf_read(buf, sizeof(buf));
> +	if (len)
> +		drm_log_draw_all(buf, len);
> +	return len != 0;
> +}

For CON_NBCON, this is essentially your write_thread() callback:

void drm_log_write_thread(struct console *con,
			  struct nbcon_write_context *wctxt)
{
	drm_log_draw_all(wctxt->outbuf, wctxt->len);
}

You cannot implement a write_atomic() callback because the console must
be able to print directly in NMI context and must not defer. But
write_atomic() is optional, so you should be fine there.

Disclaimer: Only in PREEMPT_RT patchset at the moment.

John Ogness

