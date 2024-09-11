Return-Path: <linux-kernel+bounces-325437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6209759A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0119F1F22619
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFF1B530A;
	Wed, 11 Sep 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJOeYiO3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE51AED2C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076531; cv=none; b=FJVORurxTVh2iKUUvWXuJbSmj8ezP5ZwXFyOn9AEBfpG0XhM/N2+X04nFoLb2r77q58Kt+3iNb3OhhKlrOiyt11PMGGW2R49ep65ZhV8dj1ma0bZNZalTxrptl+copOeJrrPfO8yFaAGXlmpflVTHIBgO1p9alRSC/PMtXNJg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076531; c=relaxed/simple;
	bh=dn939sn++fwvDrb1mRwiAH6VwkMwvdG2HxDigWI+AlQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OVm+8WYrBREwIC+kjMtnF0j9f1w+r1LN5s/ViiS0WEGm23SSkGJSMYeVEGEftDSX+vlq+qt3rhGzlyjDiKAZUzxLcLX1d5XwegN4ntHfUk0sOp3EJxyTnWWLuHBt4YGTU6186vXlvK9rlcFHXUe7uERr7M4TbN7/f4a+NzRbF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJOeYiO3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4b832fb63so3314617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726076529; x=1726681329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=706YIr0bgBd+SdWWT5lCJ2ip0tLuVrI+pXTkacc4ei0=;
        b=aJOeYiO3GcI0JykcTKTC3C/OML1+gF9uFFooNCGF9VRphwK6eTGjQz1b4QxQq0wXWS
         2d7Cup/I5gv0QJcTWXJljtB2ccYrrwlOYJyz6dh+bNgm36fj+/iBfp3oVIDMES2nLfxO
         87kmbSlG+Yb74xaHd/pUfSUvcgSJF/90K+U+Bvt6DJNSB4Ia9YmUuX7YKhZ8RoOLWX/3
         336+GDiNncXmTJyjMU1nNUrZbwDmgt3z4/PoIoIrEW+5XAp0DYgxbdUn5D3SqW6Hk3SF
         MPH0WsEQbD5TwbuTs/MCSbuxAYuDG4OBIIEbevLox7jw7pSSKfhOPg6/+85WbHYGn1a8
         hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076529; x=1726681329;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=706YIr0bgBd+SdWWT5lCJ2ip0tLuVrI+pXTkacc4ei0=;
        b=U+gR0xzo00seOdmTQbbqsr1pPNvmOvI1nDpfBwQ3toO66PUBYguVfzu5ZI7G2DBxAC
         8wNLog0ORUn5xs+9U0wvqm+eQG4krzp8qI7BlqC02MTt7sJDFa5FJQgJzQKhmr/1VJu0
         KY4JINBeeQplSiQ+JcGSgiBozAeXAWJzueIj5+qSel+ZHPmBs3I3jkDo9cjcYuzLsPVr
         nZ1w2toldTTt9ViMn/ucTe4UFEmAbzHnfduXrBvyOQHCFLvLk4bIx4S6UH9FUYPAd6qb
         Y38WYGim60+hKbZpnzU6j4wZja09zbk56581/vyQUTfkqA9vzHcXA5E36dGNKXs1cej2
         YhPw==
X-Forwarded-Encrypted: i=1; AJvYcCV50vI0tN0iOhxifpfdv0ZcOSTRe/qNRsXLn9NsO+Y84q5Exj9K2kboKNUYO6OsX610yh/ujtAzLQHiKow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODPFBMr7kOK762g8+a1nionnYG3L1qm0O2Y9UH0z0kbu58puR
	6dMonDs4wl4df5qHsmVvm8jarKQu8htYx5GJ8bnGHaaVKEdC1zHbzA5Wmzdph8vwi/zm/vKvrLE
	X4pGmG1VWm/WSzpHKNRJQjw==
X-Google-Smtp-Source: AGHT+IFvlmwQkSjQLxVucUW7uRZBOX25a6vFDWduRsiEd3MV5YuAAx1lfuAly70GDxykiYb30OJnJ7h7mzdG3bMQWg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:fd0:b0:6d6:bf07:d510 with
 SMTP id 00721157ae682-6dbb6b9d655mr6437b3.6.1726076528473; Wed, 11 Sep 2024
 10:42:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:42:07 +0000
In-Reply-To: <ZtmOENs5qveMH920@J2N7QTR9R3> (message from Mark Rutland on Thu,
 5 Sep 2024 11:55:12 +0100)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv7z2cck0.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 5/5] perf: Correct perf sampling with guest VMs
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, oliver.upton@linux.dev, seanjc@google.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, will@kernel.org, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Wed, Sep 04, 2024 at 08:41:33PM +0000, Colton Lewis wrote:
>> Previously any PMU overflow interrupt that fired while a VCPU was
>> loaded was recorded as a guest event whether it truly was or not. This
>> resulted in nonsense perf recordings that did not honor
>> perf_event_attr.exclude_guest and recorded guest IPs where it should
>> have recorded host IPs.

>> Reorganize that plumbing to record perf events correctly even when
>> VCPUs are loaded.

> It'd be good if we could make that last bit a little more explicit,
> e.g.

>    Rework the sampling logic to only record guest samples for events with
>    exclude_guest clear. This way any host-only events with exclude_guest
>    set will never see unexpected guest samples. The behaviour of events
>    with exclude_guest clear is unchanged.

> [...]

Done

>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4384f6c49930..e1a66c9c3773 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6915,13 +6915,26 @@ void perf_unregister_guest_info_callbacks(struct  
>> perf_guest_info_callbacks *cbs)
>>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>>   #endif

>> -unsigned long perf_misc_flags(unsigned long pt_regs *regs)
>> +static bool is_guest_event(struct perf_event *event)
>>   {
>> +	return !event->attr.exclude_guest && perf_guest_state();
>> +}

> Could we name this something like "should_sample_guest()"? Calling this
> "is_guest_event()" makes it should like it's checking a static property
> of the event (and not other conditions like perf_guest_state()).

> Otherwise this all looks reasonable to me, modulo Ingo's comments. I'll
> happily test a v2 once those have been addressed.

Done

> Mark.

