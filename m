Return-Path: <linux-kernel+bounces-529391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DDA424C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037C019E0829
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6962A8D0;
	Mon, 24 Feb 2025 14:51:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2E1514CC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408677; cv=none; b=BCEIxN0QhBg+cZu9rJTqTO3Qzo01no/EGG3ItZTv+hJu0NqI2F5bz5LfVkq1sd/zsCckulmvu/QN0PpvMTghFaZZsg2FzCHHOFytrnSsrOslYa77R8af6D7Hoy/z8gD0U0RT6xyE4byLItQaHfmkjIIi75wN+/SHOJn1RAYzJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408677; c=relaxed/simple;
	bh=cwf3jm6aMSVc6JQ7dhTsI7esG32Jh5GKjdebKYnF47M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjbVO4VVW9yaGnQQVFhGIheODUp/W8ZeyAl4lqX4HqAy99iXsOceL95VMqfE6DeZl+n4JY4ctFPE6EqC0kUvzipHqIVlR8Wb3kI4JvGFqYftI0t4345DvE9g28XGNDh6OOj1IMIkOva3ThqfwGmP7GbUYT9j+wKcYFCQze0M9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB3DC4CEE8;
	Mon, 24 Feb 2025 14:51:15 +0000 (UTC)
Date: Mon, 24 Feb 2025 09:51:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250224095151.73e809f8@gandalf.local.home>
In-Reply-To: <30f8fa10-4527-4e03-91c6-638834412466@redhat.com>
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
	<174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
	<fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
	<30f8fa10-4527-4e03-91c6-638834412466@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2025 14:53:28 -0500
Waiman Long <llong@redhat.com> wrote:

> >> =C2=A0 +
> >> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> >> +static void debug_show_blocker(struct task_struct *task) =20
>=20
> I think the easiest way forward is to change it to "#if=20
> defined(CONFIG_DETECT_HUNG_TASK_BLOCKER) && !defined(CONFIG_PREEMPT_RT)"=
=20
> to skip this feature for PREEMPT_RT right now . Otherwise, you will have=
=20
> to deal with the rtmutex code.

If this isn't supported by PREEMPT_RT (yet), then just make the
DETECT_HUNG_TASK_BLOCKER in the Kconfig be:

	Depends on !PREEMPT_RT

Don't put that dependency in the code.

-- Steve

