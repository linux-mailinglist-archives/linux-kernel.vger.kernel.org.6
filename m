Return-Path: <linux-kernel+bounces-427197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB49DFDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3ED1638FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DC1FC11B;
	Mon,  2 Dec 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGXsDuTf"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5B1FC10F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133597; cv=none; b=Wk4cx5awh6kfuOfhtXt6AskyT2lCgNuClyK2hxnDG50Xboz0o2ZaLw4EuOLkxyAqRDD4TnJHHq905Wa55phSO38QbmnukX8smGOIOrxN/gO4/hwedqY0uOANYEabGglTu2JA+TtH2/jTS640j0jFFbZzSOZFw3PmexWI+eUXrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133597; c=relaxed/simple;
	bh=xjXDHmOoyT920CnRfPbujcsiMsKVomb9jx5nAtfHOnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmQC6sAPCh+4Fdxfse02xM0wZOm/gZ1wtoVKj6HFAIuM5QG1+JB8Xbkw9huPEFTA5FnZAutSVA9mfCbE/z8f+2ltnjLL+6AIUyIV5DfL13J9bk+V/MWu22zbKdjJLZUmd/wQHbXspS3iN5Lou+OrvGUQyaJpx4XZ2YHkwalOYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGXsDuTf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3059038a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733133595; x=1733738395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ/1u6g8pk+83BAgwBDyyH5pkwtcZwTpJey++iKaJvE=;
        b=qGXsDuTfWpVkV7H9JJxTkqVu+LI73LNKdtG/0666310AEfx5FJunOaom50g/0jD66y
         45pTmTGcAyRmKMrOU4yvYiYFaNpPaN0jwtZ18LCowNc9RrBMlqWRd7W/NSiQ8aETak2m
         msDysRJwv9RyHPcHGL2buLS4f5pOttWoiJB2Y7qLUOrAQYID/3qfjkTlydr+0TZOvu11
         OM2lpaFlg6O4xlCd6OB+QlLW+OYzP4hIuBDohviQIWVaHwkVRILzTt/2XQ561lthwXLE
         sPI3GACs/wSywOnNPyGlkLkeSAYRkGQP8u5bZM6J4ShUcRNUCTo2dkNow+e5Y6v0jcJX
         JaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133595; x=1733738395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJ/1u6g8pk+83BAgwBDyyH5pkwtcZwTpJey++iKaJvE=;
        b=KnYw0XlsahktQGk1LeeWcL7tyOef+xkeIgWI0zf+ejvf6qw5zEkKR5ueQyEbvsgfvd
         azQqd12jqwfCPRyZwGsJ/YgRKjkgy/GV/w8wWgBMGWMkLBMi16nOEbDcc36pE6cOxQA2
         gs2IxIbph2Q3SQ4ur+szfTsHgu5Xm43zSSaQSUVANs1NjWRUEd8ytNH5bwT9/fCVVElg
         g2y2j10XIgKPgKI1vfgp1KtVDVYNM+gz/VsPDY1yHGDg3WjgaQruhE+/SGqxYaKDM6Ft
         Ap5heJP92hv/zxf2et0TB1lacn3RtgZF3cIquGwChyFKBh4K6D3cgARcVvBuhJdeyVTv
         SF/g==
X-Forwarded-Encrypted: i=1; AJvYcCV62ZFtDnLSHik3zS1VKs1zx8/EyJPuvgt+z4LthXMuOM4SPCyWMfyqFjp7tQLs8Z1P0taTve97c8hwvR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpnFboVoo6PfayRC7jCiCRIwpSOldlg7BjyazUi/srbrC4V5K
	LW+YXGG8EEaUQo4ODwWdEXdEsytBB4SfR/n2dzrnDRY2xRUy6mBxsy4sk212bSOgxTJVZInd6bi
	oJGrfz/1YHt5mqiJ5mCxd9dA/Z8jKB2jAfIP5sw==
X-Gm-Gg: ASbGncuMhUmHESA7OgSGCwssjpu70XlahB7UaP1KU4JtiAJHkLDwb3zOvvXEY3anBWe
	f39rZ/9IEW+2nXZY3OinTvwDgunCguz3DMMQCCY14UGNnNgorVblQqWhDyUt5
X-Google-Smtp-Source: AGHT+IEJ1AfpPSIiSNF7Rn/zgeNO2HiUOf3rL2cLPifqqADRQOxIzXVb9Bp2L2ASN7xlOKkxa71ES5OwFPswU7hyFhM=
X-Received: by 2002:a05:6a20:430d:b0:1e0:d24f:743b with SMTP id
 adf61e73a8af0-1e0e0b10809mr30683113637.21.1733133593760; Mon, 02 Dec 2024
 01:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de> <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
 <dacfbe5d-a730-4643-90a8-1c38cb6780da@arm.com>
In-Reply-To: <dacfbe5d-a730-4643-90a8-1c38cb6780da@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 10:59:42 +0100
Message-ID: <CAKfTPtAmidDzBRE7UGqodaVfyge1M9D0Q8M_EX2ojqYW2Y8V=A@mail.gmail.com>
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: Luis Machado <luis.machado@arm.com>
Cc: Mike Galbraith <efault@gmx.de>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 10:23, Luis Machado <luis.machado@arm.com> wrote:
>
> On 12/2/24 09:17, Vincent Guittot wrote:
> > On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
> >>
> >> Greetings,
> >>
> >> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
> >>> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> >>> lag has elapsed. As a result, it stays also visible in the statistics that
> >>> are used to balance the system and in particular the field h_nr_running.
> >>>
> >>> This serie fixes those metrics by creating a new h_nr_queued that tracks
> >>> all queued tasks. It renames h_nr_running into h_nr_runnable and restores
> >>> the behavior of h_nr_running i.e. tracking the number of fair tasks that
> >>>  want to run.
> >>>
> >>> h_nr_runnable is used in several places to make decision on load balance:
> >>>   - PELT runnable_avg
> >>>   - deciding if a group is overloaded or has spare capacity
> >>>   - numa stats
> >>>   - reduced capacity management
> >>>   - load balance between groups
> >>
> >> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
> >> runnable seems to have an off-by-one issue, causing it to wander ever
> >> further south.
> >>
> >> patches 1-3 applied.
> >>   .h_nr_runnable                 : -3046
> >>   .runnable_avg                  : 450189777126
> >
> > Yeah, I messed up something around finish_delayed_dequeue_entity().
> > I'm' going to prepare a v3>
>
> Maybe something similar to what I ran into here?
>
> https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/

I'm going to have a look

>
> >>
> >> full set applied.
> >>   .h_nr_runnable                 : -5707
> >>   .runnable_avg                  : 4391793519526
> >>
> >>         -Mike
>

