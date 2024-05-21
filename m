Return-Path: <linux-kernel+bounces-184678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9B8CAA76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EA31C21A50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754E057881;
	Tue, 21 May 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/AnxtBw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2241BF31
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282225; cv=none; b=pJ4cuRDlIIFPeShuIq1AvFNGqqFRbkh7JELgqDaZ44t/WgqA16qVGQ88XyUjnTBw69bt1CbQa/74iXfC5GkqySLVaM6jquC8q4R+sRTdttEW0mPfClkkKkzBM2meW0/GpOHrJMtMEiL3DiY3//JVmTJN0P9DYkpPoFeDy2bswiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282225; c=relaxed/simple;
	bh=WwubyTck14hSYWNd+EZHq+sIN0JioSBlvg43BrUZZ3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WqS7t9Oo6p12OutE2boYWJk/aTia3Rb1sCVTn+WM3bSiYnbGohSda2WYPWC+R1P9ZwDOXCcbeVdm3DZVlNiB4mdoallic7vtRtelaAXPhs3gacYhpyfzDxgrHzy9v3Fj3VQP0qXDaMOIqSxGu4OuCmUp9gYXTJg5CtdtbqjmDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/AnxtBw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716282223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh7W8N7Kjlu+sUoloK6kktcE+ERzsp6+vlPGr92bmBc=;
	b=N/AnxtBwSe9NXPfQNlj6KsmMMdCg6LsLqyO067buGSNQcn99rJfHGWpou+VLtocsUPC3kt
	j0JXklvf8dCWaphmDQlRRYSWSEObsNMl9b7PF2AczI0tqgdOKULXKanVqSQbftnpFbGm50
	VMXdElzCNiQ8jJYn2z1N30wr/jL0+sM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-flggU6naOaeznaJwlYCUJQ-1; Tue, 21 May 2024 05:03:41 -0400
X-MC-Unique: flggU6naOaeznaJwlYCUJQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5a8f3bc8e0so430888366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282221; x=1716887021;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh7W8N7Kjlu+sUoloK6kktcE+ERzsp6+vlPGr92bmBc=;
        b=qnwAOxDbcAOraorU9Eabl0IeCZ5rsB9t78zAlCmZd5Lk6mZ5I7XPcaAmd+UHM4KRzT
         IhQ/gslB35J73NfC+xZxKl9LVFdiNhwP3FllcEo2oNZtMWZrJhKUOLYeEc1w/ceuLncJ
         nVkg91RdkZBhgtBcERv+h+L8BpM2mWJ+jS4XBAUHXeolJxZvi2lkDsGYbptcWZk4vYaS
         YJutxDZcPf63nQdHSpnIboY2dFs0HQ0wexfsk726gaeFYT5db0ythLeJPYT11PRYqXIF
         /Qs0oGzcug2s8OeRXY3v4mcL3z7NgNm49wRvA0u3mU5Q6Pp3NTH1oxE5RiBuoRJfK8Dh
         2jCw==
X-Forwarded-Encrypted: i=1; AJvYcCX8bx5OZ9uMeCihviZV47u4L+7xGG5eX8JSvEszXShIdLMRCzck9smTnZuZ8dC+3dRlDKoRUoek8PwyN7VvzbgdfBShi10wJHLXb86N
X-Gm-Message-State: AOJu0YwxZk+jFW9JmqsnSWRGTp3Sadb49Dqvbb4sfGxd63jfB5MblhI+
	Jw7mF58PBIMzG4kr05YAr/PVnhmC4p9C79p5gNGAYMrs15Da/7oDoV28Fg1R7bJi0huHw/nqsiS
	foZqJ0UdvH4/pJKPP7fsciWNnmDwiJuJIwH9yAibSpi+il081DzyiGHyePzgVzw==
X-Received: by 2002:a17:906:97c8:b0:a5a:a2b6:ba8b with SMTP id a640c23a62f3a-a5aa2b6bf6fmr1116718566b.0.1716282220784;
        Tue, 21 May 2024 02:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqKRsunIxFaw1bjjhsPptQS1sOpnXosxR5QnsbZTH38nqbmmFGPIDoOXWZ5Q5DFr5QtCfCg==
X-Received: by 2002:a17:906:97c8:b0:a5a:a2b6:ba8b with SMTP id a640c23a62f3a-a5aa2b6bf6fmr1116716766b.0.1716282220404;
        Tue, 21 May 2024 02:03:40 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a51eea36dsm1334475466b.58.2024.05.21.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:03:39 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, mleitner@redhat.com, David Ahern
 <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar
 <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <xhsmhbk618o4y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20240415113436.3261042-1-vschneid@redhat.com>
 <CANn89iJYX8e_3Or9a5Q55NuQ8ZAHfYL+p_SpM0yz91sdj4HqtQ@mail.gmail.com>
 <xhsmhmspu8zlj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CANn89iJRev5Kn_jEgimDfyHosmiyYeaz2gHRGS2tcFC-yMbGaQ@mail.gmail.com>
 <xhsmhbk618o4y.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Tue, 21 May 2024 11:03:38 +0200
Message-ID: <xhsmho78z7d05.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

On 22/04/24 16:31, Valentin Schneider wrote:
> Apologies for the delayed reply, I was away for most of last week;
>
> On 16/04/24 17:01, Eric Dumazet wrote:
>> On Mon, Apr 15, 2024 at 4:33=E2=80=AFPM Valentin Schneider <vschneid@red=
hat.com> wrote:
>>>
>>> On 15/04/24 14:35, Eric Dumazet wrote:
>>> > On Mon, Apr 15, 2024 at 1:34=E2=80=AFPM Valentin Schneider <vschneid@=
redhat.com> wrote:
>>> >> v4 -> v5
>>> >> ++++++++
>>> >>
>>> >> o Rebased against latest Linus' tree
>>> >> o Converted tw_timer into a delayed work following Jakub's bug repor=
t on v4
>>> >>   http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org
>>> >
>>> > What was the issue again ?
>>> >
>>> > Please explain precisely why it was fundamentally tied to the use of
>>> > timers (and this was not possible to fix the issue without
>>> > adding work queues and more dependencies to TCP stack)
>>>
>>> In v4 I added the use of the ehash lock to serialize arming the timewait
>>> timer vs destroying it (inet_twsk_schedule() vs inet_twsk_deschedule_pu=
t()).
>>>
>>> Unfortunately, holding a lock both in a timer callback and in the conte=
xt
>>> in which it is destroyed is invalid. AIUI the issue is as follows:
>>>
>>>   CPUx                        CPUy
>>>   spin_lock(foo);
>>>                               <timer fires>
>>>                               call_timer_fn()
>>>                                 spin_lock(foo) // blocks
>>>   timer_shutdown_sync()
>>>     __timer_delete_sync()
>>>       __try_to_del_timer_sync() // looped as long as timer is running
>>>                        <deadlock>
>>>
>>> In our case, we had in v4:
>>>
>>>   inet_twsk_deschedule_put()
>>>     spin_lock(ehash_lock);
>>>                                           tw_timer_handler()
>>>                                             inet_twsk_kill()
>>>                                               spin_lock(ehash_lock);
>>>                                               __inet_twsk_kill();
>>>     timer_shutdown_sync(&tw->tw_timer);
>>>
>>> The fix here is to move the timer deletion to a non-timer
>>> context. Workqueues fit the bill, and as the tw_timer_handler() would j=
ust queue
>>> a work item, I converted it to a delayed_work.

Does this explanation make sense? This is the reasoning that drove me to
involve workqueues. I'm open to suggestions on alternative approaches.


