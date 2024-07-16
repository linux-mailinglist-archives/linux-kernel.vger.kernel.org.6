Return-Path: <linux-kernel+bounces-253798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE8932723
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D1F1C2220F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095119AD73;
	Tue, 16 Jul 2024 13:10:29 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29F13D8A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135429; cv=none; b=sTengVbqQOIcr6nhuDf/B2SdovceKc+yzU1NNB02/5VUWNyMHsWr5ib3RgFKGpGktmcNDHGe0bO5kFKUgAnJO/bGrNETJDvWStyiHAjrnwXNYx11wrjUptDeXHtl8ZLsWE5wqVHx5jG7oX3qK5MnuObqm06T2/0vzwNG/RuwHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135429; c=relaxed/simple;
	bh=OluVpnZFdHz1fo1jJWCHZCa2/HNvaWiuKoODXv7wYbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5irKus29ss88ziObOzULXqew4h3jT+vadHzfhaR1P0lQ/09Ptr4NJnaHNwpQFoJKsAH0exNnNOrtAYTtAJqfaFqU1jif2o2dn+r5dqj/hkY3ASqg/+B87L7kKSeu1Cukrt3Hv0RZJ9aUOUfndsk1mYrd0vrUEeQtvlRsbGmANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sThwX-000000005Ph-08yi;
	Tue, 16 Jul 2024 09:10:09 -0400
Message-ID: <f1fe524a8892acf032d8ddabda036c89a3cffce5.camel@surriel.com>
Subject: Re: [PATCH] smp: print only local CPU info when sched_clock goes
 backward
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, neeraj.upadhyay@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, Leonardo Bras <leobras@redhat.com>
Date: Tue, 16 Jul 2024 09:10:08 -0400
In-Reply-To: <20240716090443.GQ14400@noisy.programming.kicks-ass.net>
References: <20240715134941.7ac59eb9@imladris.surriel.com>
	 <20240716090443.GQ14400@noisy.programming.kicks-ass.net>
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

On Tue, 2024-07-16 at 11:04 +0200, Peter Zijlstra wrote:
> On Mon, Jul 15, 2024 at 01:49:41PM -0400, Rik van Riel wrote:
> > About 40% of all csd_lock warnings observed in our fleet appear to
> > be due to sched_clock() going backward in time (usually only a
> > little
> > bit), resulting in ts0 being larger than ts2.
> >=20
> > When the local CPU is at fault, we should print out a message
> > reflecting
> > that, rather than trying to get the remote CPU's stack trace.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> > =C2=A0kernel/smp.c | 8 ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index f085ebcdf9e7..5656ef63ea82 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -237,6 +237,14 @@ static bool
> > csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1,
> > in
> > =C2=A0	if (likely(ts_delta <=3D csd_lock_timeout_ns ||
> > csd_lock_timeout_ns =3D=3D 0))
> > =C2=A0		return false;
> > =C2=A0
> > +	if (ts0 > ts2) {
> > +		/* Our own sched_clock went backward; don't blame
> > another CPU. */
> > +		ts_delta =3D ts0 - ts2;
> > +		pr_alert("sched_clock on CPU %d went backward by
> > %llu ns\n", raw_smp_processor_id(), ts_delta);
> > +		*ts1 =3D ts2;
> > +		return false;
> > +	}
>=20
> So I've seen some chatter about this on IRC and was WTF, seeing this
> patch I'm still WTF. What is going on with those machines?!?!
>=20

Unfortunately this particular behavior does not appear to be limited
to a few bad systems. The distribution over time looks as follows:

- 1 day:     N affected systems
- 3 days:   3N affected systems
- 1 week:   6N affected systems
- 2 weeks: 14N affected systems
- 30 days: 29N affected systems
- 90 days: 72N affected systems

In other words, we are not looking at a few "repeat customers",
but at a large number of systems that show the backward TSC
behavior a few times, and then not again for months.

N is a triple digit number, so I'm fairly confident in these
numbers.

If it's any consolation this seems to happen on both Intel
and AMD systems.=20

The only detection code we have currently is in csd_lock_wait_toolong,
so there could be a lot of cases of the TSC moving backward that
are falling through the cracks.

Most of the time the TSC only moves backward a few dozen, or a few
hundred nanoseconds, and backward time past a few microseconds is
a very long tail. I have not sliced this data by CPU model, and
don't know if the distribution is different for different CPUs.

The code in question simply loads one sched_clock value into ts0,
and another into ts2:

static void __csd_lock_wait(call_single_data_t *csd)
{
        int bug_id =3D 0;
        u64 ts0, ts1;

        ts1 =3D ts0 =3D sched_clock();
        for (;;) {
                if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
                        break;
                cpu_relax();
        }

...

static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64
*ts1, int *bug_id)
{
...
        ts2 =3D sched_clock();


I don't know if it matters for the CPU that csd_lock_wait_toolong
gets inlined into __csd_lock_wait.

On one particular system replacing the rdtsc() in native_sched_clock()
with rdtsc_ordered() did not help, but that system sees frequent
negative time jumps of 2.5ms, and might just be broken.

The MTBF is high enough that I'm not sure whether always using
rdtsc_ordered() would be warranted, and I don't know whether it
would even help...

--=20
All Rights Reversed.

