Return-Path: <linux-kernel+bounces-518074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D5A38987
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7266166711
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5318223700;
	Mon, 17 Feb 2025 16:39:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448D21D59D;
	Mon, 17 Feb 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810351; cv=none; b=m7bWqRo+QLp3YXtLBmK3EOA+JzE2NWAkI36d8p74W61UL/3q1Def7xXTu6ZB8ig35zFuvJ+rMmkuL36+4xc0GUB9XYzs8JT2BJAk5yMGJeHiR+vDEG4lJDBm6bEZgv4MJOseL8SoALAz8XO2veNfHwq92QprnoCeBUwIr58dgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810351; c=relaxed/simple;
	bh=NWvuDyabTJWpoyeI+onyTDh+4s6cY1tIzANVKIrYKMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzODmCT7C8esYwjPKy8TTjKqEEblB1BvaFzXPvttoNBTFZcolRtry/cQu43Fu+Bfk5diYcrJDaSDfaJnYgPO9pYS42Qc648F+eidxKBw5qYYGpKECH/Z7nuAG9ZRH9cFbh4RlCBaGtFwqsDxHcrUscNrrs7ThMrurZk0lXPsMlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2836C4CED1;
	Mon, 17 Feb 2025 16:39:09 +0000 (UTC)
Date: Mon, 17 Feb 2025 11:39:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <20250217113929.5c205c53@gandalf.local.home>
In-Reply-To: <789b56973c0e6419a6a44210a18d1b31d0daf8e6.camel@redhat.com>
References: <20250213090819.419470-4-gmonaco@redhat.com>
	<202502141516.OkUInaxw-lkp@intel.com>
	<789b56973c0e6419a6a44210a18d1b31d0daf8e6.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 12:15:31 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> > > =C2=A0> 503 __do_trace_sched_set_state_tp(current, current->__state, =
 =20
> > > state_value);=20
> > > =C2=A0=C2=A0 504 }=20
> > > =C2=A0=C2=A0 505 EXPORT_SYMBOL(__do_trace_set_current_state);=20
> > > =C2=A0=C2=A0 506  =20
> > =C2=A0 =20
> =20
> I honestly don't get why this build failed. The function __do_trace_
> exists since cff6d93eab00ba ("tracepoint: Reduce duplication of
> __DO_TRACE_CALL"), a while before that it was just a macro and not an
> inline function, reason why no one so far used it directly.
>=20
> Both failed builds are based on 4dc1d1bec898 (where my patchset is
> based) and there __do_trace_ does exist.
>=20
> Unless there's a strong opinion not to use it although the compiler
> allows it, I'd consider the two kernel robot results false negatives.
>=20
> Or am I missing something?

It's because you should not be using the internal macros of a tracepoint.
Just use the tracepoint itself.

I replied to the patch.

-- Steve

