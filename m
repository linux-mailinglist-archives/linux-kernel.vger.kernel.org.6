Return-Path: <linux-kernel+bounces-364045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF199CA72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0592812AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6F1A76A5;
	Mon, 14 Oct 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Enr1Xx8T"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AE1A725A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909769; cv=none; b=TtJ4XCjCB0Q6gWCVVbVDdrL6sA8ksrKHwRXlTfft/9XLZrBF7eR1jIsRO3vLBAcqKFiMdALG7bg4zBgjPZ+vSWkqemIFaL2ToqJdVd+U9c5F/KMVwrnRuMty10MP0PlSInWAKLRmw2QBEkLcTKFp8XW20jqYog8hqckHH8hLNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909769; c=relaxed/simple;
	bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nS5s4cPvzXp79nnr1/m9GAPLGSJhLAu+er7Y7Ob5pC4Y8086vp2fXJzY6mbOBDnPYaFutjxDQtQOWs5LR0PKuVdKsxkcgytaPODDSy97gqOgsF9dIs9yeau3IM5r9fp79ryGomqP4xzOj+zdfiDKPLKX2vyYvE3c4K69uP/0KKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Enr1Xx8T; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso2628155a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728909768; x=1729514568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
        b=Enr1Xx8TBkG2p30Cp+qpmEyzShsjfQJpRR/Bfwot3q+GNOPkDoyxyOwsmU7f6qCltS
         0ItpdrmqEPDXc1ht4ylz0F0F4gQWNu0ZRVVa8XSM+6TqK51d1cyyXXqNv6xKaQh9M9em
         xooX5HkaGJVZl45yjAZsnOM4RjJIH6EeuxgISXY6NfYzgUcjshPy//kn/qE9wS0D4yGp
         f8CQmhvgmrnqxBA9pM7v8rI3KTAaagaaFmpW9KgJecqo9M2I9/ES7HJZgm8puRSZJgKe
         0ABqHvAPTNkQhh3lHCHoCyAEGAifQ3MN+chS8yKWOHuOnq07LgqsKrND6Bfr9mvKbmfF
         zSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909768; x=1729514568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJGl+8wX1EZ9yO8oCw96wVlkUots97NzABVWJYyJnq0=;
        b=H68oLvoGtLjsuKUut578bpLrSdaYOuqJxaFDX5XkpmbmE6LcQDhpWVw9qMnxZXaS5N
         d+mte2/RJWKuF9Udeqy1JTrutTGrxx3xovDEM8Qk+24jei1SPDrhFOqK1DQe9bISd8G2
         s3jd612+pQwAQaPy8BBq7oebxd2MGz5Xz0T1Lrsk+g87R+vGkx6qUBPIjVX/GpbjOEVr
         23PnR7xmocPnFp1l1pLZ9Hb2rD6sT/oQz8vQ5W4ecregZJcBcceMKuA27dXocac2k/MF
         itzXSEgDhwovOMp5PMcXjG4BjSaqADUOjfG8N0uGkwcjnew8galowxslO8hVswVwvvNM
         ZEwA==
X-Forwarded-Encrypted: i=1; AJvYcCVKu7s43IFuRkacWmEe+nvCxSIlCoHR9ayezhKxROgm9KTEu0dg7pz9+bplMfKTiLGib+XPn9USJivk7YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8b9VkwqeXKMNhIwII4n/GfT6iao6CaJwlA+9w7Q2do3EnJTBh
	2+CakstJJDmrT8YFow9dWbvuE1JfMrdg2GIcm/3kAldgVLVUG5rGBklepKbpWvTibrXU1l28M5U
	D9+ZeCJi1cDkhOZtkQAEmuvVZQPhLT+byvKMHfo80DGuHrF2XKqFL
X-Google-Smtp-Source: AGHT+IHqsr/P4FQKdWTxi0rovMGf9JyEsX7S20eZuyXx2VDQ/rgWFXmVREgt+5mWhxTduWqegrfMu+idUtZLsLcHJU0=
X-Received: by 2002:a17:90a:5588:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e2f0a49376mr13518183a91.12.1728909767291; Mon, 14 Oct 2024
 05:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb595.050a0220.4cbc0.0043.GAE@google.com> <CACT4Y+ZQzOQZqGZ17KsPmsTNTtZx1k8iQDdpggdEhBqoWBo3qg@mail.gmail.com>
 <CANpmjNP=7q2aX2O5_HVLvW9PnqAM79FpN-Oer-TbG_rAz5B5kA@mail.gmail.com> <CACT4Y+asVHVjKSC3YxwdeoAwxhWzp1K7hU4spdxQjN==N34+eQ@mail.gmail.com>
In-Reply-To: <CACT4Y+asVHVjKSC3YxwdeoAwxhWzp1K7hU4spdxQjN==N34+eQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 14 Oct 2024 14:42:07 +0200
Message-ID: <CANpmjNO9LKPvyPaebk8JcGEg5jjkm6iz3x6hPqsRLgOetkzSnA@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KCSAN: data-race in _free_event /
 perf_pending_task (2)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+e75157f5b04f8ff40e17@syzkaller.appspotmail.com>, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 12:30, Dmitry Vyukov <dvyukov@google.com> wrote:
[...]
> But that task is later using 'current' to do something with regard to
> this event:
>
> /*
> * If the task is queued to the current task's queue, we
> * obviously can't wait for it to complete. Simply cancel it.
> */
> if (task_work_cancel(current, head)) {
>
> Is this current wrong here? So it may both not cancel it for the real
> owner, and cancel something else for itself (?).

That's fine - task_work_cancel() looks for the event in the passed
task_struct, and does nothing if not found. If the task_work is owned
by another task, task_work_cancel() will never find a match, and this
is a no-op. The later rcuwait_wait_event() will wait for the task_work
to complete in the other task.

