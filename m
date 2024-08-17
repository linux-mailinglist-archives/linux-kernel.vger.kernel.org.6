Return-Path: <linux-kernel+bounces-290869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECD9559E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3AD28229E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6658155A4F;
	Sat, 17 Aug 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kqv6IFhU"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD4148833
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723931786; cv=none; b=kb/axdQ0obQ3xWprzClARIPoYTMjPzIvoAkFxL+PflG3bAoJP8fa7yGrvMJlhatMrbjqPf9otQHSNzdZg+qLbqFcPMoutWaTBJOS0+6IS3hx+/SA34Lcn3UxHaFGZ8uQzxpjXsQVssOJyj1yfSDBr3/IEn6ehR1GrrribOsAArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723931786; c=relaxed/simple;
	bh=OQ8snOqmgBERtHIQ1m1COfYzvDwJZVvqgE1hpTTPhuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRQlYGVFZKFUjZFCI9LeLEyyzyJqYH/cCgrCvk1iywmXaRdc5q3nc6y/7bb6Z8E2+Qg+nn3OfVK33UDy8SS1sExXqZKTBTBn67RdvGgJsyTOcc311DVsiyZzaFetOqBjO0LsiCjTB7AONrxJZpgbYviI6pZ/EG4ILBRclUL8+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kqv6IFhU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371941bbfb0so1193207f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723931783; x=1724536583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayTvnxM2SN4JsrF4cmubZjlo6ifk27suwMqK96Mex/Q=;
        b=Kqv6IFhUqAXZetJtzteyTgZXqt+BtKW46PExXbsCF28JFaZ+IIWJ3ghtrsF4GW9vc6
         Y4vpg1fklqncBDuAlmN5PsTNss8FTH/Jy4aSEFZOzW9guJxxTS+umiUpAjcuA2MReBzr
         dtfxQIcz4rOkg4Ol+wLV1B17tpIdUbMVXUE70YhEoPk8LxjMyU292j86w1JdafyzYMZD
         95cqSnVt24xuN6AFyIQJ4xvBXa5z7j0nDQ6CnjZ65v7f0IbOOhq8ALQIHvZDgw72bJ8G
         08OYYnSc7h5SmLm1aAWLiRpl5LfW+R2LQ70weF148AKn5sxhR7lOW7T1aR9kw26WY/a5
         V8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723931783; x=1724536583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayTvnxM2SN4JsrF4cmubZjlo6ifk27suwMqK96Mex/Q=;
        b=NmLuPJKAB7ZIoy0y2qomykx+a+eZ+bCA0zNbjMHhKj98MF2rPYReUKJntGEc7L9tMN
         LwF8HMlAy/Gb7S1OQ3/Puw+55wI1sF9fLpoJ25U0jC2vY/dCo9O1Cr3vFWeGn4IKnASz
         S2gWDcolPAjrw7H6SZLkfDtSHrmjQGiJX/gnRSlWr3abSk1pp8+mNzzj7s+8+wOppvyr
         J/NSlqOp5JtO9kk1TaHTs6HMn0mnypagHXcfMyCnjJGbPU1p8lP1GUm+cSEpSbwGe21o
         DS6jyep3rfhl8raKy+Iqr54eM2fS52en6p0J0uR3yCGqYK4jeezTB8vprcW0iHF3eJoR
         Idjw==
X-Forwarded-Encrypted: i=1; AJvYcCU4bu7wTRu9gPtZj1k/ciVbn3IkTEUVNDERAv9IDlXJPW7CNo+LsImr+T9Vyf8Dee3UaQ6+q5p/jMJyvg4fERgeJCs8Al5mlWN08WWE
X-Gm-Message-State: AOJu0YxLlYJRprykeJTc+pKp+QdrNoyP5h6hU4CGDKwIzCq8XZNwDwt3
	LlNwzMkhwnU3Kt9EhhMXfj1gM24EIktpoFgzboyZiQHTU3ritrEMoX68waUhdCNzCsEKU1h2HiS
	VM4Bvig5hFADfow5VAPMGYotVKiWYNBJnOqZW
X-Google-Smtp-Source: AGHT+IEtfcqyfJ1n3XdKoUXRqszDCY0G/vSixlQv6nnGd6wzuHkQYFK9j0HqO/S+nBFf3zxmvb+RlVFPKFtsJ0pRtBI=
X-Received: by 2002:a5d:5110:0:b0:36b:bcef:b393 with SMTP id
 ffacd0b85a97d-371946960e4mr3761228f8f.57.1723931782503; Sat, 17 Aug 2024
 14:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813222548.049744955@infradead.org>
In-Reply-To: <20240813222548.049744955@infradead.org>
From: Joel Fernandes <joelaf@google.com>
Date: Sat, 17 Aug 2024 17:56:11 -0400
Message-ID: <CAJWu+oqkWmT0Pa8h7Bs32zHJqO45gaoYkP_95sa7xc8Ki2SJiA@mail.gmail.com>
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi,
>
> These patches apply on top of the EEVDF series (queue/sched/core), which
> re-arranges the fair pick_task() functions to make them state invariant s=
uch
> that they can easily be restarted upon picking (and dequeueing) a delayed=
 task.
>
> This same is required to push (the final) put_prev_task() beyond pick_tas=
k(),
> like we do for sched_core already.
>
> This in turn is done to prepare for sched_ext, which wants a final callba=
ck to
> be in possesion of the next task, such that it can tell if the context sw=
itch
> will leave the sched_class.
>
> As such, this all re-arranges the current order of:
>
>   put_prev_task(rq, prev);
>   next =3D pick_next_task(rq); /* implies set_next_task(.first=3Dtrue); *=
/
>
> to sometihng like:
>
>   next =3D pick_task(rq)
>   if (next !=3D prev) {
>     put_prev_task(rq, prev, next);
>     set_next_task(rq, next, true);
>   }
>
> The patches do a fair bit of cleaning up. Notably a bunch of sched_core s=
tuff
> -- Joel, could you please test this stuff, because the self-tests we have=
 are
> hardly adequate.

Ah, you emailed my Google address instead of the open source address
(joel@joelfernandes.org) so I missed this. I read open source patches
only on my open source address.

Anyway I was wanting to read this entire series. I shall carve some
time next to test some of the stuff as you mentioned. For core_sched
I'll have to find a device that still requires the core-sched
mitigations (which I believe we still do).

 - Joel

