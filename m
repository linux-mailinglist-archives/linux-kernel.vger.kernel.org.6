Return-Path: <linux-kernel+bounces-318442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05BF96EDF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7BF1C23C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5EF157493;
	Fri,  6 Sep 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlrdBnFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gn4LBVGY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69E75809
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611234; cv=none; b=KUDdzK8iRCQJwqyLf56A/hEq9W9F9UtxpJnz+fXeE2kEIdkHLkh/T2buspK1LZB7Vx/j436Ml+eDIuHXxKy7unzvXMVHuH2GNzpT1stdXoK7Jo1QJOt3UtHionqd6cJtc8cPlSf/oOlZFGgnbCvc4PCYpBQTRQWYdKU2hxZdBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611234; c=relaxed/simple;
	bh=q7T46boPo+QW1TnhEgoqaAC98w/kAha4TjnLlHO2ylo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYx/51GPIPcU/ugFve2/zDPY+ebU4FGXjfO2HxNh+A69TLH7lpUvDbMToOrt8DDtHF6XmOWYwPoxWlEpiKxaJB3E/JE/BqUEsk6D3jMs/nlO82jIfPcnbDUdS+qTrd8Od5aJqi+Vlgq/psODgMtL+fbJPx5iMmny09bpHYYSf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlrdBnFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gn4LBVGY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725611230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbOCgxy0nHupgffVDYBsbW7CnT3lHShcJuXBEkpffQ=;
	b=MlrdBnFCL2qo10JYfYN2Z01QU2k2UjNl7YwVkHf7LeMSyguIqDJCCo9iI37qBbIxJOFvcy
	/ajxoBhfu45n0p7Ht/naoezemkdXGg30dsyQJRHPzufMjkvMttXCJRa0Ko1seJUHTJp1Cr
	ec2fU/IPwmjFF+3/jubA51E/LW3PEijc1iaH9YplCBf53vPlBM03EVOre92dN7a0wBKUAp
	JT4FlhTSdM22SNEa2P6b9ypgeyiiQ7eZwNQIpW1kvvecz0ygbMzNNdEqyIjwPS/KFwis6w
	C3fWd2DyBQvyPXIbgTV/+JFxEVmYjQgGtKiNojRtrJCE62RyvJmZGiELpC9KXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725611230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJbOCgxy0nHupgffVDYBsbW7CnT3lHShcJuXBEkpffQ=;
	b=Gn4LBVGYxPZJDbum2aPH6zTSEQQahNdcQvfzfMNIqQ22qBjL9IC2X2S5lciEtz5KFgLEva
	7KSoNHMLUoieV8BA==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Petr Mladek <pmladek@suse.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <a421b31b-53ad-4f56-88be-66a7d4c3bb61@redhat.com>
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
 <87zfpwxqpc.fsf@jogness.linutronix.de>
 <87a5gm2khw.fsf@jogness.linutronix.de>
 <a421b31b-53ad-4f56-88be-66a7d4c3bb61@redhat.com>
Date: Fri, 06 Sep 2024 10:33:09 +0206
Message-ID: <87seudchlu.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-06, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> It would be great to see a version of drm_log that only implements
>> write_thread() and does not do any of its own buffering with workqueue
>> and also does not need to track multiple graphic loggers at the same
>> time.
>
> Thanks for the head-up.
> I will rebase it on top of Linux-next, and adapt to the new 
> write_thread() API, it should be much simpler.

For drm_log, your write_atomic() callback should be NULL. You only need
to implement the write_thead(), device_lock(), and device_unlock()
callbacks.

Your device_lock()/device_unlock() callbacks probably just need to
lock/unlock your mutex @drm_log_lock.

device_lock() is already called when the write_thread() callback is
called. So your write_thread callback really only needs to call your
drm_log_draw_kmsg_record(&dclient->scanout, wctxt->outbuf, wctxt->len).

Please let me know if you run into any issues. We probably should write
a document "HOWTO write an NBCON console driver".

John Ogness

