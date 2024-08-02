Return-Path: <linux-kernel+bounces-272801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E394615F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0377F283D98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07C1A34AE;
	Fri,  2 Aug 2024 16:06:45 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7361A34CA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614804; cv=none; b=SxnchKxTyV5VEF0crERS7DXWfMUTa5AivND9Dax0DnzAQRC2dv+FPbJglFes4b26Mj9YJA9E9EJPswQyA15PlwkeSEPBIuhObhsUZECsmtDRpRmLsSZTuVpGLQNfiBh0I/h79ufR/jAOzCXvaqO5AKh66L27vYMctjSnW2fyNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614804; c=relaxed/simple;
	bh=BBL1nzxq3HA9H2ov3xyYeuHlmDlYV3KxeNa9ypWkDVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8AGoWxyaqHOnM/GOQ9U2dEbH9Jrnm5jBZxUW4olwG1TkIV17nUzVJTC0coPE68wXgtZPiR6kZS/i+J6KVBZ+DBA30mVEcUXqB/6qh6VigTt8CQalsKQ9otUMdk+ImRNqOin6gSBWwpyyixXRqkuXXUerVyY1zeJjxnPBmenNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sZun9-000000006w9-052N;
	Fri, 02 Aug 2024 12:06:07 -0400
Message-ID: <bc6cf2940cee5bf3414616051c821c0b17dd61b1.camel@surriel.com>
Subject: Re: [PATCH misc 1/2] workqueue: Add check for clocks going
 backwards to wq_worker_tick()
From: Rik van Riel <riel@surriel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Breno
 Leitao <leitao@debian.org>, Anhad Jai Singh <ffledgling@meta.com>, Oleg
 Nesterov <oleg@redhat.com>,  Jens Axboe <axboe@kernel.dk>, Christian
 Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,  Chris Mason <clm@fb.com>
Date: Fri, 02 Aug 2024 12:06:06 -0400
In-Reply-To: <20240802003046.4134043-1-paulmck@kernel.org>
References: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
	 <20240802003046.4134043-1-paulmck@kernel.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-08-01 at 17:30 -0700, Paul E. McKenney wrote:
>=20
> +++ b/kernel/workqueue.c
> @@ -1482,6 +1482,7 @@ void wq_worker_tick(struct task_struct *task)
> =C2=A0	 * If the current worker is concurrency managed and hogged
> the CPU for
> =C2=A0	 * longer than wq_cpu_intensive_thresh_us, it's
> automatically marked
> =C2=A0	 * CPU_INTENSIVE to avoid stalling other concurrency-managed
> work items.
> +	 * If the time is negative, ignore, assuming a backwards
> clock.
> =C2=A0	 *
> =C2=A0	 * Set @worker->sleeping means that @worker is in the
> process of
> =C2=A0	 * switching out voluntarily and won't be contributing to
> @@ -1491,6 +1492,7 @@ void wq_worker_tick(struct task_struct *task)
> =C2=A0	 * We probably want to make this prettier in the future.
> =C2=A0	 */
> =C2=A0	if ((worker->flags & WORKER_NOT_RUNNING) ||
> READ_ONCE(worker->sleeping) ||
> +	=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE((s64)(worker->task->se.sum_exec_runtime=
 -
> worker->current_at) < 0) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 worker->task->se.sum_exec_runtime - worker->cur=
rent_at <
> =C2=A0	=C2=A0=C2=A0=C2=A0 wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> =C2=A0		return;

What is the code path by which sum_exec_runtime could go backward
in time, if the TSC and sched_clock() jump backward?

Might it make sense to check in the place where sum_exec_runtime is
updated, instead, and catch a wider net?

On the flip side, the run time increments are "fairly large" in
number of TSC cycles, while most of the negative TSC jumps we=C2=A0
have seen are quite small, so even that wider net might not catch
much because of how coarse these updates typically are...

--=20
All Rights Reversed.

