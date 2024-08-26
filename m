Return-Path: <linux-kernel+bounces-301403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D310995F015
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5391F239F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F115539D;
	Mon, 26 Aug 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwJcvjwV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE68154C0E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672683; cv=none; b=ExMi0++lc/2z0zKHh8d/rUuHAHHs3JAxX9Lo6y5/AWMxyEL2xfdMD3JDC+1V9EDeIhN5bjfOkPIkbm2J8Odw6TJb4UMZzucHDpZ3rxCW+xBbRym58wcdtlLvDhBuBQxHqe9tOnHXBspUbtthjLhWklDUGn/QB9UJBblYkJRv5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672683; c=relaxed/simple;
	bh=QMoiVkem092bBrW+vcjJE8l/rIxpqA/yoiRitJ8s7MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Blh3jJ72PutrBgv6ZGoTw2D9hcinrdJisyLCjM/Ij2FNXn5WP2v0lLfRif1HZcuWgZvEztlG+DG29/ikB68ucKmI1gdw9aKUna9IIkQ5CEkSYXpK2OX37Y7G4pE1B9+W+ViehyQBRx0nkkFcyCgQ76MLXBSJsrZ/H8X5TXujGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwJcvjwV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724672680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMcvCAYN0TBa/AYjsCCHKi8+uqeaC3C3bN4VRG7FPiI=;
	b=dwJcvjwV1AST/iHYVf+NQExL0+lx+gCRl7ZMUGWifmRMUhRliKcOi7QT+dMkjldZVMBwA3
	Yw6wvI0XdS/SfKKGpLtVB0q3EBplmdNsVqyWVLM5L8ST/h68jTl6m9xus0p0l2p5VgmhI8
	5s8poOoKJ5BW6ScpNiSgNtsLE22aHaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-vTLaK6D_PdeufhvCJ9KgkA-1; Mon, 26 Aug 2024 07:44:39 -0400
X-MC-Unique: vTLaK6D_PdeufhvCJ9KgkA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718e6956bfso2874584f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672677; x=1725277477;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMcvCAYN0TBa/AYjsCCHKi8+uqeaC3C3bN4VRG7FPiI=;
        b=tMR/9tkws2PbzBEMG+3nb+x8V5LZ+2KYE8DZ1zRmjgLWViQMTBvWS1sRryCmnxLP9g
         MVevdR2/cZMGe9IfnBeBq4jr9k9ckmivk/1VXQ+wTQZrIbZELVRETqf5Jd2ZdIo5Vbyx
         G/THMlPggPeRV1DJOVSWf6wpiMP+y90aPGNmD2A0/zxiXa1dJeFNljlSKzYFdAwlhmQe
         y0NIaVaV5sRgRH+XH/WLqHmHvEpjsR8tQQ8CwsULyeJ4lk09XBILuOdO0j3FG3f8CeaG
         sxv00DjT4YfxGqXO6ox41Gm9mSjPp0HMsljh2G7MXgDvUUYfhhEynLsAALY3zII/OFu4
         bPag==
X-Gm-Message-State: AOJu0YynDqcnFs9/U3yn5H4xGFwHcSu770RrjWUPLSXwxer64yvYaDju
	irJ60OI7bzdJs1mF8rC/KfshcharfHL31RlRs8gV95ytr62llNaRiNEbDyrJ9IsjVoEMW6oN/G3
	rnnb1fgWjcos1SL7KOhH16EWttiDw5Ri3vj6RRjH1rZpcXmbptES/aurM4ycvA4gQ3L+AZg==
X-Received: by 2002:adf:f8ce:0:b0:36b:a404:500b with SMTP id ffacd0b85a97d-373118ecd49mr6807929f8f.51.1724672677576;
        Mon, 26 Aug 2024 04:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECF7Yhz3U9aDF5Z9hdecPK4g6U9TUuM+pe3fmYCQy8Hv15W+MeDoHJfCmQZoIKXMB0iw/MiQ==
X-Received: by 2002:adf:f8ce:0:b0:36b:a404:500b with SMTP id ffacd0b85a97d-373118ecd49mr6807910f8f.51.1724672676770;
        Mon, 26 Aug 2024 04:44:36 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef815d2sm186355345e9.24.2024.08.26.04.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 04:44:36 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
 linux-next@vger.kernel.org, kernel-team@meta.com
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <20240823074705.GB12053@noisy.programming.kicks-ass.net>
References: <c28dbc65-7499-41a5-84d0-991843153b1a@paulmck-laptop>
 <20240823074705.GB12053@noisy.programming.kicks-ass.net>
Date: Mon, 26 Aug 2024 13:44:35 +0200
Message-ID: <xhsmho75fo6e4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/08/24 09:47, Peter Zijlstra wrote:
> On Wed, Aug 21, 2024 at 02:57:16PM -0700, Paul E. McKenney wrote:
>
>> 2e0199df252a ("sched/fair: Prepare exit/cleanup paths for delayed_dequeu=
e")
>>
>> The preceding commit is very reliable.
>>
>> Only instead of (or maybe as well as?) introducing the dequeue_rt_stack()
>> bug, the 2e0199df252a commit introduced a build bug:
>>
>> ------------------------------------------------------------------------
>>
>> In file included from kernel/sched/fair.c:54:
>> kernel/sched/fair.c: In function =E2=80=98switched_from_fair=E2=80=99:
>> kernel/sched/sched.h:2154:58: error: =E2=80=98__SCHED_FEAT_DELAY_ZERO=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98__SCH=
ED_FEAT_LATENCY_WARN=E2=80=99?
>>  2154 | #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED=
_FEAT_##x))
>>       |                                                          ^~~~~~~=
~~~~~~
>> kernel/sched/fair.c:12878:21: note: in expansion of macro =E2=80=98sched=
_feat=E2=80=99
>> 12878 |                 if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
>>       |                     ^~~~~~~~~~
>> kernel/sched/sched.h:2154:58: note: each undeclared identifier is report=
ed only once for each function it appears in
>>  2154 | #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED=
_FEAT_##x))
>>       |                                                          ^~~~~~~=
~~~~~~
>> kernel/sched/fair.c:12878:21: note: in expansion of macro =E2=80=98sched=
_feat=E2=80=99
>> 12878 |                 if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
>>       |                     ^~~~~~~~~~
>>
>
> Oh gawd, last minute back-merges :/
>
> Does the below help any? That's more or less what it was before Valentin
> asked me why it was weird like that :-)
>

Woops...


