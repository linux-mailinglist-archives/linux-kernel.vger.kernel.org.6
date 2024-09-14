Return-Path: <linux-kernel+bounces-329453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047F979195
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D8A2845EC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC91CFEDB;
	Sat, 14 Sep 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EqFXdrlx"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F8210E9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325081; cv=none; b=cVJRGsc3T1gFgX0AJwGZ3YjrrRqOWqcmSLZ8oA8kj4R8HdQHBo8ACnKIO2Vd0pgrrPtP7rJ+rlLWEmYlmeqxvyI8M5ccXf9skVU8iW1Rqr5SDR0F+cZXPuxRH74O/h19EMIcAZC/qqIybPIjSZXTnORxO0xD3weGxnDTV4Sbnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325081; c=relaxed/simple;
	bh=eDmbSYr/29LOECwYoLWHr95f/FGhTJ9MDkRBYjODs/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkaeDC0SXbiGNcwiJRiY+0R24eTdQLu2GNf/39hFZm7hiG2M+I2STRrCIFmHBGpS7claumXzyKdiat4rQcJFRPqhKEOXakm0+PLCvoi95fztH8OoqkH1Wn2tjX4RRPNDV+h//0T0wJlMmPfrThhXXgtDpTCmeKXAM8n6TshmC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EqFXdrlx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X5Yq56Prkz9tDK;
	Sat, 14 Sep 2024 16:44:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1726325073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihSJ9eF4ScrNd9BOfaQDzUXZj/8RZhBWCPJuGCfS0ZQ=;
	b=EqFXdrlxdQ6rsT3KnO5yBD4xwPzuUalpJb2o2+7Ub8HK+QTu9k3ROi0oU3OxCBT8vH+By7
	xZgW2B1Z9gGQie0vzhLjixm6mbk6ZBy/Dykl9EvhUQfOzFXziUQfITgkaakZ9NtDEoyQ2Q
	fIBTx0RIirLVRKW2MMMQoE/scsQ9+cDJx020mqDrcBfR7UdL2+xbH/UHFD8Hif3Q8F5WKZ
	47HKnU+wfNSQh2yT9sXna8CSAJ1zRk/fTWdsEjsS8eTyFFzGyQFJ9bfdMVKZCiHL3g48ia
	4RaNa5lo83TzhCP4tvgJERDEbSqLgWC85jPGvhEJN/hpIHTcpVdq+9qeHiwa8A==
Message-ID: <aa44441a-fca2-476d-9ad9-c4eb69a5ae83@mailbox.org>
Date: Sat, 14 Sep 2024 16:44:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
 Asahi Lina <lina@asahilina.net>, Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Danilo Krummrich <dakr@redhat.com>, open list <linux-kernel@vger.kernel.org>
References: <20240913165326.8856-1-robdclark@gmail.com>
 <fa243d3e-abe2-47d9-928f-70e24065baf1@mailbox.org>
 <CAF6AEGtFJu5DEuA+Urv7zdrsO-zV-y0o0wQnTdGojTNjwwRqNQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <CAF6AEGtFJu5DEuA+Urv7zdrsO-zV-y0o0wQnTdGojTNjwwRqNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y15k1xc6apq5unq74trq3f3cycbg7zzq
X-MBO-RS-ID: ee693a0b81cceefaf31

On 2024-09-13 19:28, Rob Clark wrote:
> On Fri, Sep 13, 2024 at 10:03 AM Michel Dänzer
> <michel.daenzer@mailbox.org> wrote:
>>
>> On 2024-09-13 18:53, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Fixes a race condition reported here: https://github.com/AsahiLinux/linux/issues/309#issuecomment-2238968609
>>>
>>> The whole premise of lockless access to a single-producer-single-
>>> consumer queue is that there is just a single producer and single
>>> consumer.  That means we can't call drm_sched_can_queue() (which is
>>> about queueing more work to the hw, not to the spsc queue) from
>>> anywhere other than the consumer (wq).
>>>
>>> This call in the producer is just an optimization to avoid scheduling
>>> the consuming worker if it cannot yet queue more work to the hw.  It
>>> is safe to drop this optimization to avoid the race condition.
>>>
>>> Suggested-by: Asahi Lina <lina@asahilina.net>
>>> Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>  drivers/gpu/drm/scheduler/sched_main.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index ab53ab486fe6..1af1dbe757d5 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
>>>  void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
>>>                     struct drm_sched_entity *entity)
>>>  {
>>> -     if (drm_sched_can_queue(sched, entity))
>>> -             drm_sched_run_job_queue(sched);
>>> +     drm_sched_run_job_queue(sched);
>>>  }
>>>
>>>  /**
>>
>> The entity parameter is unused now.
> 
> Right.. and we probably should collapse drm_sched_wakeup() and
> drm_sched_run_job_queue()..

I looked into that as well, seems fine to leave them separate for now though.


> But this fix needs to be cherry picked back to a bunch of release
> branches, so I intentionally avoided refactoring as part of the fix.

Fixing up the drm_sched_wakeup caller(s) when backporting doesn't seem like a big deal.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

