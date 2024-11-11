Return-Path: <linux-kernel+bounces-403665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4909C38D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537B12822BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B614E2E6;
	Mon, 11 Nov 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hI2I9w5M"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5B1BC4E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308550; cv=none; b=dvfGv6iXfnjHWnGkVW5wdZrjrQSPkyfmFwCRVvgLTzRnew3c9hW1wtEYI6FL0vASeTqrSLkMGhlu3jhzHphd9/YPIgn6alozuhnFiuvGRM7cMi0ipKMQ+6Z/PAsS08pKfwbAbIIReZtfguo8RJfMSuc3oLauo3CFlOHX8lFMRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308550; c=relaxed/simple;
	bh=iA1oh/4Q/HU+BX+PmjHJcjZETPGATVMFlpvDSeenBfI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P5gqpHwmi+Hy7HctvhuAn6B3k+XJbsDpdo6hIQ5zHwIXa0BbDa7DxSm/hbL92C3H4ixkCEd8gJUCdIMCBZmDaFlAyYQU4/r+pHfp89i/Z3roaEAcHmXI9dUwP09P1MjTvXi3TaTH9vaWPjR8Bi2UboRfSfqFcv90CvFVev3n5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hI2I9w5M; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1731308540; x=1731567740;
	bh=iA1oh/4Q/HU+BX+PmjHJcjZETPGATVMFlpvDSeenBfI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=hI2I9w5M8RDQJ9SPCnpJdMlynz9MPOlq1IawmwOALy2yOypVao30nK2NHQXpSqP9H
	 0Osh5vNogDRoG46dletA5rz1DxCnG+yiUSr4xNlsQapjJ8NkWdB0umIP6FQ+tlvC5G
	 Wa+tg1A10Q3WD8Lr11mXS25bmMasUBsw0KxRIUZUizX2c1K+dsRzPQHhQFFUvFq4ft
	 sNTVWiAmBofFX/WYpqkSnN1YPE+tzNEKkf89Ng0O/hD+NbDw+ZNj1MMHIyYa+CRAQc
	 LGS2+WE+9V+Td3pwodQ9hp8eGxg9Z4Bqz1NfYpE9zV6g0KMfn6NGk3Z8d6KGaZdfJR
	 dcVOPHjciyOVQ==
Date: Mon, 11 Nov 2024 07:02:12 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C . Pratt" <mcpratt@pm.me>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2 0/1] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <20241111070152.9781-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: db2b9cebd61657804d3a9d03352bcac13811c470
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Linus and devs,

I don't want to take much of your time, this is a very simple patch.
I am concerned that it is being ignored without a good reason.
This is my third time sending it, the first being within the merge window
for 6.12 which I was hoping this would be included in.

This patch is a short and safe way to expand the current ABI regarding
the ability to set a process priority at the moment of process creation.
For example, there currently is no way to set a process priority
for normal processes made with the posix_spawn*() family of functions.

Since it is unsafe to directly change the static priority
for non-RT processes, the niceness value is modified instead
in order to result in the same effective priority as what is requested.
Any requested priority outside the effect of the niceness range is invalid.

Peter had responded with a concern that the value passed in
to sched_priority should be the niceness value itself in this case,
however, for the functions used to query the accepted range,
sched_get_priority_max() and sched_get_priority_min(),
as defined by POSIX, a negative value indicates failure.
This would also be inconsistent with other usage of the value.
Therefore, I believe this remains to be the correct way to implement it.
I replied as such and got no reply back.

I still think I have a good idea here, but for whatever reason,
this being in my opinion one of the simplest and most sensible patches
that I have tried to send so far, is being met with
mostly dead silence or misunderstanding of the situation...
So I am opening up the conversation to a wider audience.

Thanks for reading


