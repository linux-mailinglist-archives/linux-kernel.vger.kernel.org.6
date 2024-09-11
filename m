Return-Path: <linux-kernel+bounces-324272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF7974A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF38D1F26042
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEEE7DA9E;
	Wed, 11 Sep 2024 06:41:21 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC477DA6A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036880; cv=none; b=mtFEDfkg1APceNe96i9pwqdHmAgt/s1ISKcCx2wuvGesUmViqhmX4zjv3JeB/aEJ0H/LfOzCTSiw5ELLttoyBnvNxJkzulraOzq4aiSClkI3fRBUyCoAFg6wZ5kx+AHwSqXAoxrzZLZiGfdRVUL+bFg042/WkgjvtaJ9O5ORhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036880; c=relaxed/simple;
	bh=VNkBoTXDNpN2027vlm5qFF/ED/ecncxcAB8MPx/U4FE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eqSLi3A1iUYqL+XxTRLjFUPUhZ4imbuYDeCOEOXiw+tKiX1S0cMjsL+YrNlXgJ7hG9uyOLHQ65HJ6qxGPtPD4ybziqb9kbS79ADlcbYx8N67xKf9++vC1oNMALnrzLUJq4MVDQv/dI4vIzJSm8x9neFUD8uoFDMu+A4lur9O95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 6C98CA13CC;
	Wed, 11 Sep 2024 06:41:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id C031D20010;
	Wed, 11 Sep 2024 06:41:07 +0000 (UTC)
Message-ID: <ece8c4be2d489703fdd6962b16ed573d3b83cde0.camel@perches.com>
Subject: Re: [PATCH v2 09/15] timers: Add a warning to usleep_range_state()
 for wrong order of arguments
From: Joe Perches <joe@perches.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>
Date: Tue, 10 Sep 2024 23:41:06 -0700
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>
References: 
	<20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
	 <20240911-devel-anna-maria-b4-timers-flseep-v2-9-b0d3f33ccfe0@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C031D20010
X-Rspamd-Server: rspamout07
X-Stat-Signature: 783bwnbyyezakg956q7dsaaci3f5c9tf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18J/SBHHjWAmsYASqJl7XOID6/WdwSSzDk=
X-HE-Tag: 1726036867-640440
X-HE-Meta: U2FsdGVkX1+Lbs5xr7fdN9Kg/Hf73qqwzXGaFL+/EanipoJuDJ8+MhYsj17VL/vepnJm78MXBljc3jEU8heDXbIx6DhsoVUKtsTUuVlHhcKDCcgwwYmLqnJIneIiES+DlFFPgOKOhsg0APzd0nbRSjALo+YL7LgJmVsAP/G5hOiI0RTHPSfM/Gd6dgYQK2h7VGgmrKPcZBgjxJco7RJfdR3IVCjIPKiFzafiOHT6BGVNM4Bg6/fD7l/k1YFS5wCG/krW7XSqZeJnP7BJy6ULDFExDyZaPsKy84JBvSWiNYIsXt6XTTM4192M2xSLcJcLyiN5DRHnjV/mBmWwZEdt5d+wAFCZxIWFc3kyy2LYRUp9xKAkam+DoNxw3DhkhrIFhjDhDOMKALtjfh1ZQPgqB/XOznwncDLHmO8wrVnXikL9y13IYtHl+tgO5deXqwAyGmQcvhURqIQyluXhDtTZ6g==

On Wed, 2024-09-11 at 07:13 +0200, Anna-Maria Behnsen wrote:
> There is a warning in checkpatch script that triggers, when min and max
> arguments of usleep_range_state() are in reverse order. This check does
> only cover callsites which uses constants. Move this check into the code =
as
> a WARN_ON_ONCE() to also cover callsites not using constants and get rid =
of
> it in checkpatch.

I don't disagree that a runtime test is useful
and relatively cost free.

But checkpatch is for patches.

There's no reason as far as I can tell to remove
this source code test.

Why make the test runtime only?


>=20
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/sleep_timeout.c | 2 ++
>  scripts/checkpatch.pl       | 4 ----

>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
> index 21f412350b15..4b805d7e1903 100644
> --- a/kernel/time/sleep_timeout.c
> +++ b/kernel/time/sleep_timeout.c
> @@ -364,6 +364,8 @@ void __sched usleep_range_state(unsigned long min, un=
signed long max, unsigned i
>  	ktime_t exp =3D ktime_add_us(ktime_get(), min);
>  	u64 delta =3D (u64)(max - min) * NSEC_PER_USEC;
> =20
> +	WARN_ON_ONCE(max < min);
> +
>  	for (;;) {
>  		__set_current_state(state);
>  		/* Do not return before the requested sleep time has elapsed */
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..ba3359bdd1fa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7088,10 +7088,6 @@ sub process {
>  			if ($min eq $max) {
>  				WARN("USLEEP_RANGE",
>  				     "usleep_range should not use min =3D=3D max args; see Documenta=
tion/timers/timers-howto.rst\n" . "$here\n$stat\n");
> -			} elsif ($min =3D~ /^\d+$/ && $max =3D~ /^\d+$/ &&
> -				 $min > $max) {
> -				WARN("USLEEP_RANGE",
> -				     "usleep_range args reversed, use min then max; see Documentatio=
n/timers/timers-howto.rst\n" . "$here\n$stat\n");
>  			}
>  		}
> =20
>=20


