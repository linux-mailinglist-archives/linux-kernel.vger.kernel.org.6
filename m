Return-Path: <linux-kernel+bounces-394585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4889BB178
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6348B1F22BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD399199FD3;
	Mon,  4 Nov 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ovJRJ/T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfPAEvmB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7864C6C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717203; cv=none; b=jmFnouoLRCPw4ZXj4HfwFP+MgERvssgM4VRrn18D/xKfjLfKc84QASVkRf3P5uT+ZwHbpTNCGZ/QdCStBqQNBf+unD1VRcBJolUZwJ3V79+h+dYiGC2MQjwGTpqvRQI7za12PopciJNHxWIANDbqkVGaaJmco+u3mr0X49og8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717203; c=relaxed/simple;
	bh=2g+BpJSnA23h+nF/OUwvVUZ6TsRw1CAPZJyoEyUGDXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVw3nIZoYx4SiSgdB2FdmXW1PDoPMoC1vr/ltQui5Q+/qbqsXVGEtiPiN/no0ZM7Fi2qa8b3KHSWkzejqYOV3hAINnayHExRNeltWi4B8K/6dF8A5pSDkEvG1/S1slY4dMq1w3HFCS0tmtcNGqXUSRVVnTlPdjJjiBcDm3vJvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ovJRJ/T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfPAEvmB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730717194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUMq9d/Y/ah4RgFgHvJiQ6t1sVUNjgH2DIyO/HDYra0=;
	b=1ovJRJ/TBkp7r3/PUwP9+odLJ39BlWZTIS/0NdCR92N2FTvB5jtyF2CI07zGwxK5Er8dFf
	lVl58oqFRdTuTa/xkQqhktnzG4tilhVUsY/IqY3Q3neCIyNfPDjbKOrqCp6laEPleyjUC0
	ykjdVCyJB492DT+wzPIqAIyaOdYIeC6hehXmzMvefhSyfWvo6gPq/Sdyv8iTf/4me4RcKI
	ZBqIHczL2eevHojSZWJIAYqX3Vmc99TVkyP0/T9i/qwIgn68rEmW5kRS4gubS6GFufda+T
	RMMqvKzi2uYzT2P+ejTDQwckQtwA/9xB3883JypMV+QyFepN5JQUkigtxUlx2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730717194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUMq9d/Y/ah4RgFgHvJiQ6t1sVUNjgH2DIyO/HDYra0=;
	b=ZfPAEvmBmdqXqhY0/Fy+yfJ4atEMo8/7475YTV5JyDS79wAY3X11OGPqy6XBZeEDFG3B4S
	mBaDtegd+X1UDhBA==
To: Jocelyn Falempe <jfalempe@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Javier
 Martinez Canillas <javierm@redhat.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, bluescreen_avenger@verizon.net, Caleb Connolly
 <caleb.connolly@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] drm/log: Implement suspend/resume
In-Reply-To: <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
 <20241023121145.1321921-6-jfalempe@redhat.com>
 <Zxpa2zt1P9Avy4Pm@pathway.suse.cz>
 <27c1a6bf-d1e4-469f-a0d4-3e74ab0d0a07@redhat.com>
 <a6c00956-3733-43a1-9538-aa2758d2b4a3@redhat.com>
 <ZyT7MScAsHxkACfD@pathway.suse.cz>
 <d5c8ea70-8596-42a1-8688-0f6131187b73@redhat.com>
Date: Mon, 04 Nov 2024 11:52:33 +0106
Message-ID: <84o72vcm46.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-11-04, Jocelyn Falempe <jfalempe@redhat.com> wrote:
> I looked at what serial drivers are doing, because they can also have 
> their clock gated in suspend.
>
> Would calling console_stop() in the suspend and console_start() in 
> resume work ?

Yes. That is what it is for.

John Ogness

