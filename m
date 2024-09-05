Return-Path: <linux-kernel+bounces-317426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4996DDF6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B00281BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591519EEB8;
	Thu,  5 Sep 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOT5hunL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l9Tj357O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37A19E96B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549759; cv=none; b=RbXSyiVj5uGFHuL+jtSqpjSYcrNOj+LDspRRq1gLoVqenTTocCZfLAijoztBVAJ36zkYb5fevmJ9YHb+VCiqUaMUPyjamW/91AoUR8epHK+tHZR7fuw2CelND/GzJoToRm+1rjnsf4AHJqCTvKYkQ5fWX8lL2b1Cg72G4BrCq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549759; c=relaxed/simple;
	bh=Q4Tg8dEgkTswTB6VvQxJ4kNv8/QdAuXjJMDGmVqHWjc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jz1hXyHZu72siZhA9XSryI/6hI4MSYJ5SfTXzdDscpNByfqMF9t1RHBJ2k2xTxL0qUwFyQ92E8BnIA4hziveYM1UAHKtgp8I4WWFsAWEmmXHrn36k2XUZypKSWrJoQMA3vZCfZC07gipzsGuq9DKno9nv0da2fPNtZySVUfZOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOT5hunL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l9Tj357O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725549756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4Tg8dEgkTswTB6VvQxJ4kNv8/QdAuXjJMDGmVqHWjc=;
	b=zOT5hunL1xI7YbxxPIBQmaQ2SgbJ8GZ8mixTDS+u5CM/ZmL5AoUPHJqEtG60XjbuXkEw6j
	l6yj6F5yE1bGhygRbFpsUqC/2OledY2iw7+VoETsTkanJWvL6m0VnfEcTQBlO0DMsoj4eq
	l6Aooqmsx4rWsFuslIO7seg/PmfseqyYQ34SY5lmwO9uOTiqOcK2IvFKo7sHj0H+iwqYlT
	21+eco3vg6PtAXLl3j/HQAChcnWP9nP2mSGuFZ6EjmCo8JFgNgAU0kYJE8ka1rXVuvhdW6
	CbZiQzsuPCX85o9ctW+ebw1NP2SloIFjUuOo66qybaJ958Ld+FdmeA1YD94g1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725549756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4Tg8dEgkTswTB6VvQxJ4kNv8/QdAuXjJMDGmVqHWjc=;
	b=l9Tj357OjDMCl5vyh6arql/xekgxrfsNSslEVEF5iEwQP25xBf/RKhlkPP+N4MWRQvkgvb
	he+IKgH6s/I0BaDw==
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Javier Martinez Canillas
 <javierm@redhat.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] drm/log: Introduce a new boot logger to draw
 the kmsg on the screen
In-Reply-To: <87zfpwxqpc.fsf@jogness.linutronix.de>
References: <20240801100640.462606-1-jfalempe@redhat.com>
 <20240801100640.462606-4-jfalempe@redhat.com>
 <87o76czfb2.fsf@jogness.linutronix.de>
 <d4412d54-41b1-4671-9733-34ba1423404c@redhat.com>
 <87zfpwxqpc.fsf@jogness.linutronix.de>
Date: Thu, 05 Sep 2024 17:28:35 +0206
Message-ID: <87a5gm2khw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-01, John Ogness <john.ogness@linutronix.de> wrote:
> On 2024-08-01, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> I think I can also register one console for each drm driver, which
>> will simplify drm_log even further. (currently it would mean having a
>> circular buffer and work function for each driver which is a bit too
>> much).
>
> Indeed.
>
>> Do you know if there is a chance to have write_thread() in 6.12 or
>> 6.13 ?

FYI: The full NBCON API (with write_thread()) is now available in
linux-next.

It would be great to see a version of drm_log that only implements
write_thread() and does not do any of its own buffering with workqueue
and also does not need to track multiple graphic loggers at the same
time.

John Ogness

