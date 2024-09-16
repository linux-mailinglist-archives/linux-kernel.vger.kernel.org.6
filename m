Return-Path: <linux-kernel+bounces-330512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD5C979F85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF97B23087
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE0154452;
	Mon, 16 Sep 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi+2QqYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55BD14D29B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483060; cv=none; b=KmQEuk0rAbZLJlGIVugKJ7Ct/eWtlxtYEGqKQW15EhdQBLOBKd7GY8ZOydYuEY8XEIiAkcS/Tnr/uxzhkzKgvuwEtN4Iw/dFBiC6uVXSd7OSZ+Z3kDZyRCxrgKWTkVfIZvMBifmPaPuMuXMKWpuAaLWteAGzAvHuOxX1I5d2lPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483060; c=relaxed/simple;
	bh=P2KQGR7EXPM94ax8edp9oKQsLIadoOZ/jHl07AfggfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u8aSm8Tg0OPk/R1Jp+9w3yRaXSlvnEYoEms0NT2aeuKftLa56msYY2SUn2UcSkQzzLj9F7DHBXtdpDHgdpjGP7LBRvOpNsF4YvlY1V11t5VzzAyFeGBjbaMAf7B10BcOdoQnHUO7yAQRSVCJvUoITtT7kPTe0IbH2b1KIjgUpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi+2QqYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A9BC4CEC4;
	Mon, 16 Sep 2024 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726483059;
	bh=P2KQGR7EXPM94ax8edp9oKQsLIadoOZ/jHl07AfggfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pi+2QqYx84IcBorzbtI+U/xE/lGiaBgz3HVozDXG8ywM4HjoIGMaUHCKByqNljiv8
	 R9aOFu5QZRBHOVsS6W1MdYAxstWdYT46mKnl9DwK/JcmzHVzbq/pYzrWgY4VcDtrzq
	 ERQqcrp3GCknXITRt7i9kvTBwBtSWSCAXJWrgnmQYBDA8vbuztic8t1auFO5mKzhB2
	 E3A7x2Nn55M5+OoouV/e/mQNmzn4UyLZgracF1Cyi8qURLgdUnY9R900h44dz6WmBO
	 x3g/Zif5mySqzY46XplP0Qdc4yT2bqY60U750xV+2ejWOr6S2wBbJZgJ/0e/cqGQDf
	 92HGXRg36ZNiw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Kalesh Singh
 <kaleshsingh@google.com>, chenqiwu <qiwuchen55@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: arm64: stacktrace: WARN_ON(state->common.pc == orig_pc) in
 kunwind_recover_return_address()
In-Reply-To: <20240916102741.GA13899@redhat.com>
References: <20240916102741.GA13899@redhat.com>
Date: Mon, 16 Sep 2024 10:37:31 +0000
Message-ID: <mb61pmsk7natw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Oleg Nesterov <oleg@redhat.com> writes:

> I don't know the details but people report that
> kunwind_recover_return_address() hits this warning.
>
> I know absolutely nothing about arm64 or kernel/trace/fgraph.c, but at
> first glance this code looks broken:
>
> 	kunwind_recover_return_address:
>
> 		...
>
> 		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
> 						state->common.pc,
> 						(void *)state->common.fp);
> 		if (WARN_ON_ONCE(state->common.pc == orig_pc))
>
> 	ftrace_graph_ret_addr:
>
> 		...
>
> 		if (!idx)
> 			return ret;
>
>
> given that kunwind_recover_return_address() passes idx == NULL to
> ftrace_graph_ret_addr(), it should always return ret == state->common.pc ?
>
>
> Perhaps this connects to 29c1c24a27 ("function_graph: Fix up ftrace_graph_ret_addr()")
> and I have no idea if something like the patch below makes any sense.
>

Your finding is accurate.

It has been fixed in upstream by c060f93253ca ("arm64: stacktrace: fix
the usage of ftrace_graph_ret_addr()")

See: https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/kernel/stacktrace.c#L111

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZugKbBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nU0XAQD2X6uLg0VyJNcwY/L5WcIDB61aPU1y
mRy5eiriORWjFgEAtBeRZmqeajKlWSyUFfaNZcjqBAr6G7ndhjcujPv6KAI=
=gAQR
-----END PGP SIGNATURE-----
--=-=-=--

