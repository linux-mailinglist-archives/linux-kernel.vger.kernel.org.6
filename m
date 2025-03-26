Return-Path: <linux-kernel+bounces-576587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1EA71171
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7861747C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC24199FB0;
	Wed, 26 Mar 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIljvMZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308F13AA2A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974307; cv=none; b=I88vlKVBk6dcCLhdkNjhsrR18T3nMOsXS2oNi+GbAfoWJSERVqoxcJCN5c7JxlTB7a4IKzvi+xj1/GdWDRzyzkNj6K36TRY0yBXZ3CnDs3VlEM0XGohrRA2qJxnVW2unXCYzWnKA9Jo4rShekZK7sd81Shxn010GTglQOjl85Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974307; c=relaxed/simple;
	bh=U/ix21jM9DUFTm6EMFGrUBD3KSofxsSAbOoQuucde7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNqWLChoayW/Mmgt03PjHSwGJdoJmCqa++rgc8QFiqDDqdvtujV+mjleILrkYi85VDscpQLKYY+4i5TxDbBptyCkaGthgsSIv+UfWIIpGHQ/joOvokyvUmpftgSpkihshZUOm5UGJzW7gK/+IjnBiq9zrt9cXW1uhgXEZXqgNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIljvMZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742974304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U/ix21jM9DUFTm6EMFGrUBD3KSofxsSAbOoQuucde7Y=;
	b=VIljvMZASt4uN7qpd12sz1R67nIOYNrOzg9sM/Y5BIvelD4SeMeuzx3gJ5bT/jp46UitbL
	B1fWc1++R7z0+QCzxFD5jc0DRPPPvMFlAUxuk6JiB55Tm6CG4k59UBxPxseXx/BqI8h92f
	XjwfdOhyLYj9yQa0OHdo5Gf7VU3VlvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-ciga4ZBoNKy_l5t9MKALBA-1; Wed, 26 Mar 2025 03:31:43 -0400
X-MC-Unique: ciga4ZBoNKy_l5t9MKALBA-1
X-Mimecast-MFC-AGG-ID: ciga4ZBoNKy_l5t9MKALBA_1742974302
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so51923615e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742974302; x=1743579102;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/ix21jM9DUFTm6EMFGrUBD3KSofxsSAbOoQuucde7Y=;
        b=IkfPfBhUvEcpe1aldD71Xk+elcGuAVyGyE95AbjbVQ02CZ7PY9IfJyvhRtF2LhU8z1
         fSwsbPUFhrs/6ZlwzQZRxqtQxUSksqdozsleLKWSwbYEAVdEa0KHjNzPtUtNOrfXgEQB
         CklW3rJvRwGz2p59KBWNQuxClrLpVHS5tcnhT4lG4xP1MrMA1xHxSIHBT4ZRAHAj5Fh9
         fZh8xWSb5ZaASTyq3brNMbyIff53ogN55Wlx7cvyyuxMdkFYiqwdkkrtmvivOLooL1AN
         SDk6/P0sPJ9NiPWyWcVSPrU3r+oDv91CkjU7Kmra7kJ4IkXhemmbQgD6ITwwuFFf0kFJ
         aoaA==
X-Gm-Message-State: AOJu0YxjoZFlqHlXghQj5UE/gAvygxB+tua61o7wUnb0fwagvbTybiir
	+gzYD9OiiuVdiXHLiXkQYxpk5rh/uLkKyXtltOX2ckG4jGjbQJXosE3+X6IKuRp50sWWaRMxzut
	lAwlW/pms+2GfajdQSK8G9fY2o0S3F+v0rRGMy6XJLWtaat9tYjgb8+DCIUCxee24XRE6crjMrW
	mMJg0DUd3a2wDGz8EiZriWyLcENvZAgR5u02PTfca0aDlfOzh2ZQ==
X-Gm-Gg: ASbGncvMsFde/VuJW4SH/NuRhF/t5rNcACwev+GELYKEfqB8xA3oZHiyiz9JJJxeR/X
	PvWHg7GK2D74LNAQG6benz57SguG6K6wfrvgB9wZ2fTFjNm9F/a2ZVWto7sYmVOxtyHMk8qg8E1
	9Tf/Cq66uGVG1qAs6Yco5KgI2DgmSxcQv0Ad2uVqFuukFHflWg3vq9rCcFWkQTyjkwjrzefhOSB
	KTiwmRdGHje+2k3ksoS3WXKby2rJwhkiR2dctCIwV99RIbWQ4woT6chEgtRaO62qziFtAImDNS0
	R+QWcfJ9959GdFC3WkKMmGcNqzQxCE5J+H9JvPnj2g==
X-Received: by 2002:a05:600c:3110:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43d509e42bemr163708895e9.2.1742974301563;
        Wed, 26 Mar 2025 00:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoHVhTC9AXxsZi58B/glRUfe9MKODsU3521LBPXk7lnfqN2vv0w9lqV2Uk734u8EIp2pRz+g==
X-Received: by 2002:a05:600c:3110:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43d509e42bemr163708455e9.2.1742974300953;
        Wed, 26 Mar 2025 00:31:40 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6651sm16027541f8f.75.2025.03.26.00.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 00:31:40 -0700 (PDT)
Message-ID: <b0b6e10b8651ed59051e426c187ed64b785c4b8c.camel@redhat.com>
Subject: Re: [PATCH v12 0/3] sched: Restructure task_mm_cid_work for
 predictability
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
Date: Wed, 26 Mar 2025 08:31:38 +0100
In-Reply-To: <20250311062849.72083-1-gmonaco@redhat.com>
References: <20250311062849.72083-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 07:28 +0100, Gabriele Monaco wrote:
> This patchset moves the task_mm_cid_work to a preemptible and
> migratable
> context. This reduces the impact of this work to the scheduling
> latency
> of real time tasks.
> The change makes the recurrence of the task a bit more predictable.
>=20

The series was review and, in my opinion, is ready for inclusion.
Peter, Ingo, can we merge it?

Thanks,
Gabriele

> The behaviour causing latency was introduced in commit 223baf9d17f2
> ("sched: Fix performance regression introduced by mm_cid") which
> introduced a task work tied to the scheduler tick.
> That approach presents two possible issues:
> * the task work runs before returning to user and causes, in fact, a
> =C2=A0 scheduling latency (with order of magnitude significant in
> PREEMPT_RT)
> * periodic tasks with short runtime are less likely to run during the
> =C2=A0 tick, hence they might not run the task work at all
>=20
> Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
> sched_ext classes as it is supported by fair, this is required to
> avoid
> calling rseq_preempt on tick if the runtime is below a threshold.
>=20
> Patch 2 contains the main changes, removing the task_work on the
> scheduler tick and using a work_struct scheduled more reliably during
> __rseq_handle_notify_resume.
>=20
> Patch 3 adds a selftest to validate the functionality of the
> task_mm_cid_work (i.e. to compact the mm_cids).
>=20
> Changes since V11:
> * Remove variable to make mm_cid_needs_scan more compact
> * All patches reviewed
>=20
> Changes since V10:
> * Fix compilation errors with RSEQ and/or MM_CID disabled
>=20
> Changes since V9:
> * Simplify and move checks from task_queue_mm_cid to its call site
>=20
> Changes since V8 [1]:
> * Add support for prev_sum_exec_runtime to RT, deadline and sched_ext
> * Avoid rseq_preempt on ticks unless executing for more than 100ms
> * Queue the work on the unbound workqueue
>=20
> Changes since V7:
> * Schedule mm_cid compaction and update at every tick too
> * mmgrab before scheduling the work
>=20
> Changes since V6 [2]:
> * Switch to a simple work_struct instead of a delayed work
> * Schedule the work_struct in __rseq_handle_notify_resume
> * Asynchronously disable the work but make sure mm is there while we
> run
> * Remove first patch as merged independently
> * Fix commit tag for test
>=20
> Changes since V5:
> * Punctuation
>=20
> Changes since V4 [3]:
> * Fixes on the selftest
> =C2=A0=C2=A0=C2=A0 * Polished memory allocation and cleanup
> =C2=A0=C2=A0=C2=A0 * Handle the test failure in main
>=20
> Changes since V3 [4]:
> * Fixes on the selftest
> =C2=A0=C2=A0=C2=A0 * Minor style issues in comments and indentation
> =C2=A0=C2=A0=C2=A0 * Use of perror where possible
> =C2=A0=C2=A0=C2=A0 * Add a barrier to align threads execution
> =C2=A0=C2=A0=C2=A0 * Improve test failure and error handling
>=20
> Changes since V2 [5]:
> * Change the order of the patches
> * Merge patches changing the main delayed_work logic
> * Improved self-test to spawn 1 less thread and use the main one
> instead
>=20
> Changes since V1 [6]:
> * Re-arm the delayed_work at each invocation
> * Cancel the work synchronously at mmdrop
> * Remove next scan fields and completely rely on the delayed_work
> * Shrink mm_cid allocation with nr thread/affinity (Mathieu
> Desnoyers)
> * Add self test
>=20
> [1] -
> https://lore.kernel.org/lkml/20250220102639.141314-1-gmonaco@redhat.com
> [2] -
> https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com
> [3] -
> https://lore.kernel.org/lkml/20250113074231.61638-4-gmonaco@redhat.com
> [4] -
> https://lore.kernel.org/lkml/20241216130909.240042-1-gmonaco@redhat.com
> [5] -
> https://lore.kernel.org/lkml/20241213095407.271357-1-gmonaco@redhat.com
> [6] -
> https://lore.kernel.org/lkml/20241205083110.180134-2-gmonaco@redhat.com
>=20
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.org>
> To: Paul E. McKenney <paulmck@kernel.org>
> To: Shuah Khan <shuah@kernel.org>
>=20
> Gabriele Monaco (3):
> =C2=A0 sched: Add prev_sum_exec_runtime support for RT, DL and SCX classe=
s
> =C2=A0 sched: Move task_mm_cid_work to mm work_struct
> =C2=A0 selftests/rseq: Add test for mm_cid compaction
>=20
> =C2=A0include/linux/mm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 17 ++
> =C2=A0include/linux/rseq.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 ++
> =C2=A0include/linux/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0kernel/rseq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++--
> =C2=A0kernel/sched/deadline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/sched/ext.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/sched/rt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 -
> =C2=A0tools/testing/selftests/rseq/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0tools/testing/selftests/rseq/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0.../selftests/rseq/mm_cid_compaction_test.c=C2=A0=C2=A0 | 200
> ++++++++++++++++++
> =C2=A012 files changed, 258 insertions(+), 32 deletions(-)
> =C2=A0create mode 100644
> tools/testing/selftests/rseq/mm_cid_compaction_test.c
>=20
>=20
> base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a


