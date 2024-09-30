Return-Path: <linux-kernel+bounces-344798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1398AE54
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4C61F23BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62471A2C1C;
	Mon, 30 Sep 2024 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JV5zepgu"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5561A2542
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727989; cv=none; b=OQYnAb8nMl/0y5i0KYL1EqQyvimeMhEAOWx9nHyxV0Uo4CfW4j2lEYNKTggnn4d9atELA3+XnT+ahsXx2CNyYQA14MDBk/rjxk7APtsMHdxFee/Vdt7KJdIXkCw8wX2tm3KREwKdPID6OEjQDjufqkWzkVgmvnY7WfAVPYl79vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727989; c=relaxed/simple;
	bh=iN12jBWIBPt4ZjRokpXJbA3PwarMWLKZN/NjEv7jR88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2U05ph8zyQTPmTp6sQyduIBSnh/ZVRTryhWcqN1IESRkghhjqVvENcH90WMwaWr7JaSwvWpSDYutobtknSlz+H/7Yj61yDhNbzW/uTX6u/GHutJMzTgY+S62MjXhil357fIASbeca2sOyJT+3kz4Pc4MKIEWEp2h1sOI2y+ooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JV5zepgu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-536552fcc07so1585e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727727985; x=1728332785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN12jBWIBPt4ZjRokpXJbA3PwarMWLKZN/NjEv7jR88=;
        b=JV5zepguEs+lie21qd4umo38CbmLDThqKyI+QLybcnM8I7GmgYjChuix4wTIKM4Izr
         a7GfltXhGCJVmkunyJQcXGZjZKGSTunTLZ5FBh0ks5uAU1sTSOEwjgtNwseYLdvjOWpk
         2etr9+0vwYC5t5iLiyvcRAWCZ52tcoXSbCyURMffBeoYZNznKPssXWjC5W9vfKGeWuIe
         KPlxdOUD3Rdcglh933RU3X+bd+CBCgt1r/r7Rbzh55DsvFR2La1iLm82jLTRKZjl1gQj
         W/o2A1+ehH5CVQHaS3oflA6ysx2uGQJ0IaP52RUWl3xRX/u7vBjBTn6jmikSK6+bWDqn
         /Osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727985; x=1728332785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN12jBWIBPt4ZjRokpXJbA3PwarMWLKZN/NjEv7jR88=;
        b=sP4t1hB2HrG96zkNd8gCcaCCUoyQpphwCA85KwwIDfXtw67mlmoAJ9Ja9ZLCMnqlfa
         iaJGaOYGmYVQoeZpuuA9Gc+mMNTRHzHO+5fCq6yP/8WHfm7OLvTacZ/0LPqJilDt/4XX
         6ij+ohCwNSTIySd3djQV2kq+6qxUbj3nl9nuBmdLIADSCI/5PmIe0tvaavsNhp8GpqaF
         +EhiLvHinNkyyBw7ko9lWyhjNxsphFoU875IbQ6kDsbFPUD2kgqC2NRqRxaGGgkjSpnv
         21961ZMzynBYu6MbYQD86C6W9RkJNTDk8WsTs9n1f04NJz0Q4iw565W1yB7VLrYFOBZ7
         wXpg==
X-Forwarded-Encrypted: i=1; AJvYcCUXq0+g3j9KGWyAaMAACGYYMqkvaEYjbkjNlsDqQXSul1NEC5EL1RbEK//BhSo4ANbWJ8MuhYSj8h5QfRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXUDiRs6w8PGoRYJ+N4yl2FnFf2NvbhZGl7f4W/UcNNaw9MS9
	pyznfq34WPk4nzji1lNxrzqnTde+J0PcIm/XA415/kTzFT4Vq8FETPFt6LCPsAgqy7ugSIjV7f3
	nwzjIZ+vDod8OUklqDuEuDGyYbgUiALjqTJH0
X-Google-Smtp-Source: AGHT+IGb2l2Mandyy76hdzVp/weW4ysWHdiLk43iAubTG54V0Dkt0vgsfjMMnpolOkMjfNOukyP8smf0P1lMz3Cmey0=
X-Received: by 2002:a05:6512:b29:b0:538:9e44:3034 with SMTP id
 2adb3069b0e04-5399ae2c1dbmr118605e87.6.1727727985225; Mon, 30 Sep 2024
 13:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829220427.2764399-1-joshdon@google.com>
In-Reply-To: <20240829220427.2764399-1-joshdon@google.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 30 Sep 2024 13:26:08 -0700
Message-ID: <CABk29Nv=Gj9H0dfvdV0E9us+jBnysoPXYoO-Rkn46rwGtg7=hA@mail.gmail.com>
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:04=E2=80=AFPM Josh Don <joshdon@google.com> wrote=
:
>
> Commit 8f9ea86fdf99b added some logic to sched_setaffinity that included
> a WARN when a per-task affinity assignment races with a cpuset update.
>
> Specifically, we can have a race where a cpuset update results in the
> task affinity no longer being a subset of the cpuset. That's fine; we
> have a fallback to instead use the cpuset mask. However, we have a WARN
> set up that will trigger if the cpuset mask has no overlap at all with
> the requested task affinity. This shouldn't be a warning condition; its
> trivial to create this condition.
>
> Reproduced the warning by the following setup:
>
> - $PID inside a cpuset cgroup
> - another thread repeatedly switching the cpuset cpus from 1-2 to just 1
> - another thread repeatedly setting the $PID affinity (via taskset) to 2
>
> Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumask"=
)
> Signed-off-by: Josh Don <joshdon@google.com>

Gentle ping to bump this in case it got lost.

I've also collected the following:

Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Best,
Josh

