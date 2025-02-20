Return-Path: <linux-kernel+bounces-522862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5BA3CF56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410571896F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8901CAA6F;
	Thu, 20 Feb 2025 02:26:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281801CB332
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018406; cv=none; b=IjybTWyNLetP0lKocm+1tnhODchgBz/+tc3TV/87IwaS3wosYE+bCtVWUovr4hEt6g4KmfFwI9rjSe0NtcB3cAg0KzW4gN9QvpxKwoF4Hb90bJL2xRJ4QQ6TbaQPvGboJ3hly+l16/gSW0/4P05bWYuHtf2WfTumWbaDFGgL60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018406; c=relaxed/simple;
	bh=qdKwxrR2wkRzl3Y+bBAGfWcwFN7urfhAU58o5SuOrjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hShfUdUsWuo5JTqLK+EwuSfsTQJGQe+UZJGMtjtj2EfgwztHt2tMe/qGgbU54jW04usU++PUB0Ax0umIfPI8cgdYdPtTDmeYje3O7FYNEUlm1yMsUxuQC2GQ/UMQpNTgVCclXSc12h8Q38KVJoW23oxrQ7gEn6NE7aJcx44IZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB23C4CED1;
	Thu, 20 Feb 2025 02:26:43 +0000 (UTC)
Date: Wed, 19 Feb 2025 21:27:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, Linux
 Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <20250219212708.78b93a84@gandalf.local.home>
In-Reply-To: <9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
	<173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
	<20250219112308.5d905680@gandalf.local.home>
	<0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
	<20250219152435.35077ac3@gandalf.local.home>
	<db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
	<20250220075639.298616eb494248d390417977@kernel.org>
	<d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
	<20250219204153.65ed1f5e@gandalf.local.home>
	<9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 21:15:08 -0500
Waiman Long <llong@redhat.com> wrote:

> Writer - setting them:
>=20
>  =C2=A0=C2=A0=C2=A0 WRITE_ONCE(lock)
>  =C2=A0=C2=A0=C2=A0 smp_wmb()
>  =C2=A0=C2=A0=C2=A0 WRITE_ONCE(type)
>=20
> Clearing them:
>=20
>  =C2=A0=C2=A0=C2=A0 WRITE_ONCE(type, 0)
>  =C2=A0=C2=A0=C2=A0 smp_wmb()
>  =C2=A0=C2=A0=C2=A0 WRITE_ONCE(lock, NULL)
>=20
> Reader:
>=20
>  =C2=A0=C2=A0=C2=A0 READ_ONCE(type)
> again:
>  =C2=A0=C2=A0=C2=A0 smp_rmb()
>  =C2=A0=C2=A0=C2=A0 READ_ONCE(lock)
>  =C2=A0=C2=A0=C2=A0 smp_rmb()
>  =C2=A0=C2=A0=C2=A0 if (READ_ONCE(type) !=3D type)
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto again

Do you really need the READ/WRITE_ONCE() with the memory barriers? From
what I understand, the compiler can't even assume what it read is the same
after passing a memory barrier like that. So there should be no reason it
can reread the memory location after a barrier.

-- Steve

