Return-Path: <linux-kernel+bounces-272850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92859461D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A7283827
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890B136322;
	Fri,  2 Aug 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqXpFn5O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4F16BE02
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616363; cv=none; b=LGIWvKZMFv1EP0ZevuvwBBc1Pc7+CQ+Hb3NdNISde/D1kn2qGj0xtCePDL7pTBg1vuAt87pylm9ZPunGwRqli9k3xjgHZ83tzuNnBa2r/diE+2btRhrkc0UiQERWch5P+A55csgpVZGIijquHD9vAfUAgUlW/nwcUGIIpQ3Kxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616363; c=relaxed/simple;
	bh=bNI3xTLKjKEyzNH5ETMZ/ZHBcz7ckWEogweag1D5ouY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MwZ7RZsuDiEWrG3dmWLG/aphD1z+uoSFL1PBR5twykt7mAFGZskQUvWxBQmPZ753KF/kdiZQPs4yHkEZrjsP/L75GhAwEKtshKSKf2FbFaMc8qfK+Q28+o9AwGa3o2LlW6CFeBj/z7EqtqVjggugzOfqdJZZrrqUskXlRQTzAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqXpFn5O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722616360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNI3xTLKjKEyzNH5ETMZ/ZHBcz7ckWEogweag1D5ouY=;
	b=QqXpFn5Ot8u/lWLLcPudH5BK41vw2GnrHmTR9wW8A6R+e6oCVgrdGynRgBjXwZQmutZaMe
	wVmkrpWmaih4PO7MoHzgQvOsGieAKEcSG7Pdm7LLiwkkdbfTIv44p5rsCcCfYbkRTLp+hV
	xqyQIryOUqj5/8HY/bmCbzxDwYtpk70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-gpNdKtbzMbeKf3JUwfRlXA-1; Fri, 02 Aug 2024 12:32:38 -0400
X-MC-Unique: gpNdKtbzMbeKf3JUwfRlXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428ec88e02bso3223605e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722616357; x=1723221157;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNI3xTLKjKEyzNH5ETMZ/ZHBcz7ckWEogweag1D5ouY=;
        b=Vf5Podus+xQ9xABkueWTtKBI1PZbdK94NbE91Sgjb5+/YV7paF6in9KAZYD/obDreX
         UyP1cFiS86BMD6JKR+pBYh11ETwlRWmNlnFqis98lui07jHPthW5Z8VnBCg47no10vxS
         JxLqSH0jizMlyQ4c6Zwb2RHhcFwUkmebks6RPt8os9nyzIGoJ2FnaCPIeq+xLQYSab9H
         jvr8sigyVxcWiBeCh0+gWlNGRxM0KmvlOTozqS3h/NJ2wn0vAA8mt8RgBwSKJD2WuxPa
         mp0WMwTrWgE5HDCnPJzsPwqdhugkDKvwOWAV6BfOfxaRZD3ciasULl5OCAyM7U/3t1H2
         qclg==
X-Forwarded-Encrypted: i=1; AJvYcCVzQXq0cMje3ViX07z6KS9PsOOGfhzugZ2xVbviRCxsS1oARR1BLb0lGmSvq0UXHfaDMiv6+3M3kfuBbHaxY0AQoEFrGK5e+y9hM2lw
X-Gm-Message-State: AOJu0YwxJ387jR0IwXjC7RsOw2n1m60blvhVRNLzXVypZCyhcsvjUDeq
	UVMPk9WxPRjzOk2D7DqhOhElH91A9wvim03VmJyzyLcS/qnnZWU1M94n7gQJjnW8FxTfrb5ncb2
	RVmbLkOsww6GOPwD/Ec81AcpQNt5uKTtuKPPuXqU2lw4n8SRLkwZMsAF/e0Y9bA==
X-Received: by 2002:a5d:67d0:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-36bbc17ec0emr2983388f8f.54.1722616357440;
        Fri, 02 Aug 2024 09:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc9Z0Y6OmAtVcS9kf9be+JuNbTSlplNL35nQRceH1xWNu6hrgZe+Qn8MJtM3/0Gh1FkwevFA==
X-Received: by 2002:a5d:67d0:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-36bbc17ec0emr2983364f8f.54.1722616356947;
        Fri, 02 Aug 2024 09:32:36 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c2fesm2323398f8f.16.2024.08.02.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:32:36 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
In-Reply-To: <20240802145938.GK39708@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <xhsmhjzgzt2er.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240802145938.GK39708@noisy.programming.kicks-ass.net>
Date: Fri, 02 Aug 2024 18:32:35 +0200
Message-ID: <xhsmhh6c2ubq4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/08/24 16:59, Peter Zijlstra wrote:
> On Fri, Aug 02, 2024 at 04:39:08PM +0200, Valentin Schneider wrote:
>>
>> On 27/07/24 12:27, Peter Zijlstra wrote:
>> > Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
>> > noting that lag is fundamentally a temporal measure. It should not be
>> > carried around indefinitely.
>> >
>> > OTOH it should also not be instantly discarded, doing so will allow a
>> > task to game the system by purposefully (micro) sleeping at the end of
>> > its time quantum.
>> >
>> > Since lag is intimately tied to the virtual time base, a wall-time
>> > based decay is also insufficient, notably competition is required for
>> > any of this to make sense.
>> >
>> > Instead, delay the dequeue and keep the 'tasks' on the runqueue,
>> > competing until they are eligible.
>> >
>> > Strictly speaking, we only care about keeping them until the 0-lag
>> > point, but that is a difficult proposition, instead carry them around
>> > until they get picked again, and dequeue them at that point.
>> >
>>
>> Question from a lazy student who just caught up to the current state of
>> EEVDF...
>>
>> IIUC this makes it so time spent sleeping increases an entity's lag, rather
>> than it being frozen & restored via the place_entity() magic.
>>
>> So entities with negative lag get closer to their 0-lag point, after which
>> they can get picked & dequeued if still not runnable.
>
> Right.
>
>> However, don't entities with positive lag get *further* away from their
>> 0-lag point?
>
> Which is why we only delay de dequeue when !eligible, IOW when lag is
> negative.
>
> The next patch additionally truncates lag to 0 (for delayed entities),
> so they can never earn extra time.

Gotcha, thanks for pointing that out, I think I'm (slowly) getting it :D


