Return-Path: <linux-kernel+bounces-548352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F82A543C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A1B18873D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A21DC9B1;
	Thu,  6 Mar 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARW7dJud"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69A1DC19D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246449; cv=none; b=Ou4q8BG/qGnQYU/zaXLkUP0oIbqsUWzmBFnvGTXfIS97xK//eN+bdS5/mu6GDHyBvUcnqJicrdAx0ucLahfbP3xx4gBx1uvYBcQVmuZWOrbyPgbJqXlTCPHYnNOUdbWeQ2w7Sob3szFNKyJz2VarDsh04jnLfnhMp9qZ1L9jNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246449; c=relaxed/simple;
	bh=0LDTCIPCOzThsMW+gihtxsHaA6H6blGWjv4MVg/8hn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKww24BZeobZurku85uKr0/NLkZz2bUTcovhTVzGPyKYtM4MpvWQ56P+bVvPlxLJIN/DWjkGrHmJHjkaaX4q3NaIhylj2HKSS/tB8rKo5l7X+lPfyYMVTJxzKqO8FnPl6mVg1wfaTCuvOkycbzenMwk7bQdgLsCENw6W94ZVoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARW7dJud; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso446831a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 23:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741246446; x=1741851246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LDTCIPCOzThsMW+gihtxsHaA6H6blGWjv4MVg/8hn8=;
        b=ARW7dJudkm+onwyBb/2D6H6S7I6VcDpko9xWLK2DBTadepmJB6XISAuOWfc6xjpHNy
         diGZToVw2GTx6pAhsCtUfgBD43P1w6RLIqjnIASuNtAfhdt8Lf98W+WqIMhTrjYAtEU4
         EwdjlRbCJTp3ff+TC52QsViTB3wsIhmeKfy+siIAKjUvxDWufrgcpdXoQLnc4IppIUM2
         MUMpS3LCdXRSC/VrDv/Ea6n9CYqloh0Kgy0u7KORgdx7NvFCpoUVvVWqNiXSRoCReiSi
         i1hlCCdKvOQEtDkfdwDTiigIohMphlyntrgILQcn+89Z+WYypQswqDYOeww5+LPKFuG7
         Azbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741246446; x=1741851246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LDTCIPCOzThsMW+gihtxsHaA6H6blGWjv4MVg/8hn8=;
        b=otLgRV2H77JbUyeUaHOj7DxGTtdy2QHSVNtULr5sQ5HPHlIIrR6xKBwtaNinpKe/qG
         5l5BagHPg7X9tByiHttgR94TyGaVVCsPH36AG/HLsi6RKJD5TJRMwApeBXeNHR6a830H
         saY/LdD25vYEJwDnQ4t625niIcN/BwuItCzeFZnjqpBuRwmkyv1Hc/KOCQzEyJ7iqS/7
         UdENsGzTWQXZa2fD+wcb2D/1f3PP08bf+Tgbxwz0iu8OBDok3TRK76Z7Wv+A6r0yE86U
         VQ9h0+vdncZ9zxC9GwoINBTEFKP85YywxZeo9tN+X4GzVUAzsHYIDBwXW70WzlQE7NYc
         P/cg==
X-Forwarded-Encrypted: i=1; AJvYcCWq7C9avPDkoWCrWE62Sj8q7Ne3xRpEuMyHx6RP2oZI6ptTa+61Ng3QY2PrcNvx9sc7Zchopr65ZOspQMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTvY9BMVHGK9JYJwezvRNJzF0+4EYc87w45zSJkxuGMpQK9Wlx
	zoCFVAYYEl5rFlLKsCykJfiehh+RfJbQtYqwcc/xGs400NppmzYjjHVX6ItfMSSm8tO/jsMix8d
	qCt/FLBaVt3tg0U4tUn9c+gGnqq0=
X-Gm-Gg: ASbGncs4EIb2rcUNLPkll9BkBJV83Xng9bq10Ua8PbUAgEiXHeazi/825k23IGQKVvX
	Vhktm98m8cB+SXV2AJIGH/mHAF8OPGfqnueogldZ3bZDcLKl1F9poxWkfRNsFuC0w5kMjJ+VcIK
	yYpM3aHNJXrjQB/UvFD1H42kpEvnU=
X-Google-Smtp-Source: AGHT+IF4QQHy39PPivemdVdx3U6W+lhhE9KQcBxY0pQxWHT8P11U50Bv+k/yKjlPKe+VsplE+cLICFFWPJevwOMc+fY=
X-Received: by 2002:a05:6402:5109:b0:5e0:8c55:532 with SMTP id
 4fb4d7f45d1cf-5e59f3a2351mr6448162a12.4.1741246445966; Wed, 05 Mar 2025
 23:34:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303105241.17251-1-xuewen.yan@unisoc.com> <20250303120021.GA11590@noisy.programming.kicks-ass.net>
 <CAB8ipk-pmSGoaxtMGhcvn7MmSEibvQDbCDgjp9iEDTzG5=_L7g@mail.gmail.com> <CAKfTPtBahSErKvd5y698v7+EZYGkT95dbO0LumZAWD=ut1vj3Q@mail.gmail.com>
In-Reply-To: <CAKfTPtBahSErKvd5y698v7+EZYGkT95dbO0LumZAWD=ut1vj3Q@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 6 Mar 2025 15:33:53 +0800
X-Gm-Features: AQ5f1Jp8s8PfEzTJQAIYFegwHGzGqAOO4d7ydbFEaQ6If2meX-zhf08IQWnCug0
Message-ID: <CAB8ipk9pq_=CoZdC6qyautMySqTSL6eDKgyaRe1V0wvG655atw@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Wed, Mar 5, 2025 at 4:17=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 4 Mar 2025 at 02:56, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > Hi Peter
> >
> > On Mon, Mar 3, 2025 at 8:00=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Mon, Mar 03, 2025 at 06:52:38PM +0800, Xuewen Yan wrote:
> > > > Delayed dequeued feature keeps a sleeping sched_entitiy enqueued un=
til its
> > > > lag has elapsed. As a result, it stays also visible in rq->nr_runni=
ng.
> > > > However, sometimes when using nr-running, we should not consider
> > > > sched-delayed tasks.
> > > > This serie fixes those by adding a helper function which return the
> > > > number of sched-delayed tasks. And when we should get the real runn=
able
> > > > tasks, we sub the nr-delayed tasks.
> > > >
> > >
> > > Is there an actual performance improvement? Because when a runqueue
> > > looses competition, delayed tasks very quickly dissipate.
> >
> > At the moment, I don't have very detailed test data. I've been
> > studying delay-dequeue carefully recently, and these are the issues I
> > feel might need modification as I go through the code.
>
> Patch 1 makes sense for me but I'm less convinced by patch 2 and 3. As
> Peter also mentioned, the state where cpu_rq(cpu)->nr_running =3D=3D
> cfs_h_nr_delayed(cpu_rq(cpu)) is really transient as they will be
> picked as soon as the last runnable task will be dequeued
>

Thanks for the comments, based on your and Peter's explanation, it
seems that patch2 and patch3 might not have any significant impact at
the moment.
I will also test patch2 and patch3 later.
Thank you again!

BR

> >
> > Thanks!
> >
> > BR

