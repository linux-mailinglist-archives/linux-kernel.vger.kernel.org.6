Return-Path: <linux-kernel+bounces-420947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D529D84A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29ED2851CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4F1991C1;
	Mon, 25 Nov 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oxc3piw6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC617DFFD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534859; cv=none; b=u5Fy6RqjzzxUeldfxpFRYTU4PSHi0LTB82yYQmclnYQSg5okWuXWc7mD2ZZPdeA7IEcTeTPbbLu2juBcEUsfFcxK/+DhYzQ6H+mUQ/xNtvPfUNIl9oGB2t5jn3hV1YnqKaPQO/cfHhF9pRnVTIHF4fP9LrXbfC4ol4McsKnJQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534859; c=relaxed/simple;
	bh=IZ7RAJrWHPGd5SAlQW1VbMKLcYyV1OEzAUU/YZlPS8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwHXsI5du2d246cRksLzsYYjU12xgAhQJyBCFOp0aJUVq1u4UiSZLYfTIFe7FDL19E2Is4cVXP5v14ISMmHbCoW7Ig5EDpLiKg5mE/8nwV4U27eZSoSJ/n/TVg2SRSa/nTrcX9aoqZxFbWcX4ViWtlCEHc4XXYJ4H/W3l75g9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oxc3piw6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so160867566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732534855; x=1733139655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ7RAJrWHPGd5SAlQW1VbMKLcYyV1OEzAUU/YZlPS8U=;
        b=Oxc3piw6sv6iZWvdmIlao0RZaIh2vKqNhkaT5SKJv2ibjNmPTko1bcZeoKJQjmvGMJ
         bcGkHBDc7HXe4387hrdSus/Qx1k8Vm/0r3QYddXiOQDhk0UC2tGgC6EM11mDKTY1FhRi
         zMIeU7JeCtMSnQ7Izp72mhSMNwD1WrpK2nVJJ0VEDzXZ77HUhIME4YBcfL9V/opZpn+S
         13ZoqRGBLHch/IUcMKagQpSXedRbBiIcNU/+PkpQkUky2MuZzF65wHir33kSDzQ9uzpC
         zBQGVS1FCRmEZ+JJO6j06OKEQp3y9JFnfpdpj/KoQ7iVDGpJf5XiqGFqfC07grNsGiQR
         awrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534855; x=1733139655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ7RAJrWHPGd5SAlQW1VbMKLcYyV1OEzAUU/YZlPS8U=;
        b=TQNMy6ZFe2JnvXyviuvUtxFRGseNdkcwf6XHnt2MdNga8AgD9oVbyOyjXO/rzMxa62
         n66mtJWrSI9fiBEIxLyCCqbjkMY7jiEMvuOUKU0qNSaHhxVjaXsanQOtqQNsBNjnj4wZ
         lv9tuKbQwwavE3HMB9bn2QXXr2ADCJDQkfgotcjF9l8QG28S5BINxIPB//D5AWdioJU8
         KT895iMobTHXlDF3NlAru1GWx4CdDhVDaBUeQEZqlBVu9ETAWaWKgCltbj+xZWpRsFfq
         5CVBNjtC/EC90w+RGqThFNN9gEmLYUH3VclVNp1oMUBDIofrO7nbH6POVbuch7h1WRjC
         9GTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDjbRgtcpBmk/0FVVSkdijzLQwzU5xyBhsaoa0nKhipkZzws/pjW+gaY7AMhkLh3HPj/rZ0etIpCUfld8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJTFakyocL/mLxfe16r6PuNeHt5nKjutc7TiLa8CofBsSBIPKB
	XzKd5i81ORgxpGsN7aYChsXkTS95kP/BRpLUSjq96BOtPhALnz2Jiq7Kj+bZYPisjT/JE/22p7D
	d9Q8s4qhwFPSOPOytrjiZf6grDecXzpMxB35Clw==
X-Gm-Gg: ASbGnctW/nvM183YHN/yUiFailAbxAluCaWxqMqcjUy0Bpujd6hCPxhYg/0UQTcTAzM
	Bx50fmv3cJKzAd1k6GeKxGhpBhdqU4w==
X-Google-Smtp-Source: AGHT+IFk4zrHYHYPotVR3J/Utck40BuZFP5wCCmZOmAvQz1ezOSjvFoTP5wC/kKdBk+FRaO27EYR1J+Zg6na7ZpnoRk=
X-Received: by 2002:a17:907:7847:b0:aa5:d7c:2acf with SMTP id
 a640c23a62f3a-aa50d7c2dbdmr784007066b.12.1732534855535; Mon, 25 Nov 2024
 03:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122152856.3533625-1-neelx@suse.com> <20241122154253.GZ24774@noisy.programming.kicks-ass.net>
 <CAPjX3FfDTdUvMCDJCP8tAeNeaYSWj9mSsrMmE=VP0kWAdJTSVQ@mail.gmail.com> <20241125100108.GH24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241125100108.GH24774@noisy.programming.kicks-ass.net>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 25 Nov 2024 12:40:44 +0100
Message-ID: <CAPjX3FdTe=5sA8M6GjjNYSGRgJY42z_n+AnJC7ZSBwY=XLTFJw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: properly serialize the cfs_rq h_load calculation
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:01=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 22, 2024 at 06:33:31PM +0100, Daniel Vacek wrote:
> > On Fri, Nov 22, 2024 at 4:42=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Fri, Nov 22, 2024 at 04:28:55PM +0100, Daniel Vacek wrote:
> > > > Make sure the given cfs_rq's h_load is always correctly updated. Th=
is
> > > > prevents a race between more CPUs eventually updating the same hier=
archy
> > > > of h_load_next return pointers.
> > >
> > > Is there an actual problem observed?
> >
> > Well, that depends. Do we care about correct (exact) load calculation
> > every time?
>
> The whole load balancer is full of races. And typically it all more or
> less works out.
>
> I mean, the worst case is typically a spurious migration, which will get
> 'fixed' up the next round.
>
> Only if behaviour gets to be really bad/stupid do we tend to try and fix
> this.
>
> Now your patch didn't look awful :-), but it would make a stronger case
> if you'd done it because you observed it doing stupid and it now no
> longer does stupid and your workload improves.

Well, the original motivation were crashes reported on s390 before
commit 0e9f02450da0.
That commit addresses these crashes but not the failed load
calculation. This patch addresses both issues. As a result it makes
the scheduler more correct and deterministic and less racy. The
question is if we strictly need that or if we are happy with it for
the price? And the price looks quite fair to me as the lock could be
acquired only once per jiffy.

Note that the load calculation fails more often than the observed
crashes. Crash is just a special case of a failure depending on the
actual cgroup hierarchy and relation of where are the tasks racing
being woken within that hierarchy.

