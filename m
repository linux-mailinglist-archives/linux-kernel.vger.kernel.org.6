Return-Path: <linux-kernel+bounces-334214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769997D40D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D44B1C20C19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AC524B4A;
	Fri, 20 Sep 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGSZzcyj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522D1BC49
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827497; cv=none; b=jIGQUuq7QRkd5J2YfUywquasNinp5anH514v+vvWa5YgXmfAFb948ABBvxz4uXAxGo4zeLjLvrmzrdgs8LSDCYtJf/+lTwel4Do2ml7skaP2TqiRmsveLERne4A10S/Sdr2QLv/v2D1Ppv5VFBOEU8Nf8+vJIgnp8U29okmtkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827497; c=relaxed/simple;
	bh=VcXuGjmzjp4r1UmBkiahz6D4Bi9VrjvqBy9qpCKj3eE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qQEozEN54OgJ7J5yqld+cZdM3Pcp61RlWMx0Zuk9rkZZOQQuSZ+gJJatYpioXn75BCxsMKjrIeXl6EdaR4aC+fKtu8HWvHWc05rs7ZUJT6ibk5nZh4827oa1oY8RXxvPGy10ddFVonMiP1X5MXqXtqsMeoEhV7Pr4fAy2n8qGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGSZzcyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726827494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMKDoD0tv+kTXRiIx9NBK+PaRErtxnKhBwvCBVHMwGc=;
	b=VGSZzcyjPj40TLGaY2mEOFJxtQV7g1kuD0zAzIwr8RcRGnSs2msL/5iXANyAHaFzogGQ+w
	knZ0p///qCank3Zjve0GADH2dy9HceHMaWePn4hrn2MvSJFeLnoGgDo5kVaHQ/XtB0njPb
	IKlmn8/RYhsjKqVMle+yusYTx05EX3U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-QpFkH0dlMuiTARD-5ao_RA-1; Fri, 20 Sep 2024 06:18:13 -0400
X-MC-Unique: QpFkH0dlMuiTARD-5ao_RA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8711c48990so151841866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 03:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726827491; x=1727432291;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMKDoD0tv+kTXRiIx9NBK+PaRErtxnKhBwvCBVHMwGc=;
        b=v4nV3wOEWwj8KvgoYRF1E0adLKOpGmTFXcCMoBgAv7MW5/Yt0RdovWBalc02upKmDh
         j//KXdjrb0WhaUQ9HV+kOos5ebuJTv4TJ2dS7+zCWBZHkjs+Cx9Y7URKwusc/3Vrf+Ig
         tba2G4ZyJO0EeOc1P5DrPVHn0FHFp2gIrQ+qJwApxFut1Pgyf29rPrjSyikChKo27cYH
         qZBZPLQz+BmnRCIgjaJBxHSFEc5WzqiBiqtz+UcCKcMSu1XgFgMeOKUV2+IehHlt09y+
         XgfZ0W2S5k2ddhlIPnkSGInCHJCWBA5A3BiQZCaS55QhwYQsNRkuhcfVDOW9FSV/CuBT
         x0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWLoB4bt96a8AvEAD9IeeQyYgKaZr7e/YtT7GnzVRsk3HVpdpl9w5B2WwUuzHRhw8GzNBEdXxLE120WPf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrV+p9DMfZn3s2khYuyoMUz6/fENEnjq6vGwdctzsziC0wsBM
	NTa/1K9eau+JYNIkWXab1CuLCSGcBBSJ76OygPyIRXPbeUpyvxTfXfalwYycdW8q1+rTBw/Vz6B
	A0asqe+794eLpL6+vMMAK4TXxTPWaJ+HdrnhW4oAbITKGPxLJ0lI/T49Dd85q53ka2xdF8IW6
X-Received: by 2002:a17:907:e292:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a90d55e1c15mr193034066b.13.1726827491381;
        Fri, 20 Sep 2024 03:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvdlsgWDACVvJ5d8wpVvc8ySml1xNugQgHp/mmH4bnG5wxb7C5RpIopDuytOq4AcpAymmag==
X-Received: by 2002:a17:907:e292:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a90d55e1c15mr193032066b.13.1726827490942;
        Fri, 20 Sep 2024 03:18:10 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43bbsm828363166b.77.2024.09.20.03.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 03:18:09 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Yan, Zheng" <ukernel@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Bug] premature worker thread wakeup
In-Reply-To: <CAAM7YAkHjVg5qj+6b9HAqbE_d6fugAhdCxqsOHgN06VMjbmQvA@mail.gmail.com>
References: <CAAM7YAkHjVg5qj+6b9HAqbE_d6fugAhdCxqsOHgN06VMjbmQvA@mail.gmail.com>
Date: Fri, 20 Sep 2024 12:18:09 +0200
Message-ID: <xhsmhwmj67hni.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/09/24 15:25, Yan, Zheng wrote:
>
> Looks like the newly created kthread got woke up prematurely. Checking
> the source code, path "workqueue: Unbind kworkers before sending them
> to exit()" looks suspicious. The patch wakes up dying worker's task up
> without holding pool->lock.  Is it possible that another worker thread
> recently died, the newly create worker thread reused the dead thread's
> task_struct and wrongly  got woke up.
>

Per the comment in idle_cull_fn():

         * Grabbing wq_pool_attach_mutex here ensures an already-running worker
         * cannot proceed beyong set_pf_worker() in its self-destruct path.
         * This is required as a previously-preempted worker could run after
         * set_worker_dying() has happened but before detach_dying_workers() did.

the task shouldn't be able to exit() even if we don't hold &pool->lock.

Also, things have changed a little in this area, for instance see
  f4b7b53c94af ("workqueue: Detach workers directly in idle_cull_fn()")
Could you try to reproduce this using a more recent upstream kernel?


> Regards
> Yan, Zheng


