Return-Path: <linux-kernel+bounces-263124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A646F93D155
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B55B217B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6317836A;
	Fri, 26 Jul 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvVTAn+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05D7F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990785; cv=none; b=oTQC4a8Io8wJWL5BRT+aoUWYkLFui6TfRcVhHbg6E9mpWe5viAg6ruK8m7jnWuiO/MN8qt0UDeroXQuOV7uGqrqqBa2fTt418AHdsmSFLuYOnHfwgQjnkgReGBU4PHu0lm+I+bTskQGweYrEPLxaQ1PbkOffnoRPsS/U7EqmLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990785; c=relaxed/simple;
	bh=Y/uWYa9WkZyo/qF+wqEDQCaKs7CwOAxvOpcsgt+6F6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCdfc9L0fXZeHv3oRNES5F9fcYFeLBIrHycZa/qex0kUEAtcCqGY0WFgKTHrdw7DPc5qvziU9fuAWRe9EHtEN9QDk9WIwxlPUY6xrIv91Nve5eaHfc1BxIdlEt9lSoGnTsjV2N6YOHH/l93l0m7WjGozNWWifV7tVeWT1kf2t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvVTAn+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721990781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s2wg5bMEXdXwAAajlrAz7LLcE+418LBbf1n+LXoQgBU=;
	b=BvVTAn+XuJaiyISKR6TkiX90ETaXwmOe+NlptHOpeIDIKy5x1auxGxzOmxgWms+PXbBbYW
	hkrzfFPgTGka5xmGBOyMofPwQ2pz2sf2aQfcQLcv4rvDO2EimJHE0S2c2XwyUegNXl4tct
	jvJUFIuPK9YDDLFYQJF6suLi/Cb9cWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-RIzM5CNAOMqZ2tT4gm2vgA-1; Fri,
 26 Jul 2024 06:46:18 -0400
X-MC-Unique: RIzM5CNAOMqZ2tT4gm2vgA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 655361955D47;
	Fri, 26 Jul 2024 10:46:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7AAC119560AE;
	Fri, 26 Jul 2024 10:46:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jul 2024 12:44:35 +0200 (CEST)
Date: Fri, 26 Jul 2024 12:44:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zheng Zucheng <zhengzucheng@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime
Message-ID: <20240726104429.GA21542@redhat.com>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240726023235.217771-1-zhengzucheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726023235.217771-1-zhengzucheng@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/26, Zheng Zucheng wrote:
>
> before call mul_u64_u64_div_u64(),
> stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.

So stime + utime == 175138003500000

> after call mul_u64_u64_div_u64(),
> stime = 135989949653530

Hmm. On x86 mul_u64_u64_div_u64(175136586720000, 135989749728000, 175138003500000)
returns 135989749728000 == rtime, see below.

Nevermind...

> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	}
>  
>  	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> +	/*
> +	 * Because mul_u64_u64_div_u64() can approximate on some
> +	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
> +	 */
> +	if (unlikely(stime > rtime))
> +		stime = rtime;

Thanks,

Acked-by: Oleg Nesterov <oleg@redhat.com>

-------------------------------------------------------------------------------
But perhaps it makes sense to improve the accuracy of mul_u64_u64_div_u64() ?
See the new() function in the code below.

Say, with the numbers above I get

	$ ./test 175136586720000 135989749728000 175138003500000
	old -> 135989749728000	e=1100089950.609375
	new -> 135988649638050	e=0.609375

Oleg.

-------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long long u64;

static inline int fls64(u64 x)
{
	int bitpos = -1;
	/*
	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
	 * dest reg is undefined if x==0, but their CPU architect says its
	 * value is written to set it to the same as before.
	 */
	asm("bsrq %1,%q0"
	    : "+r" (bitpos)
	    : "rm" (x));
	return bitpos + 1;
}

static inline int ilog2(u64 n)
{
	return fls64(n) - 1;
}

#define swap(a, b) \
	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)

static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
{
	*remainder = dividend % divisor;
	return dividend / divisor;
}
static inline u64 div64_u64(u64 dividend, u64 divisor)
{
	return dividend / divisor;
}

//-----------------------------------------------------------------------------

// current implementation of mul_u64_u64_div_u64
u64 old(u64 a, u64 b, u64 c)
{
	u64 res = 0, div, rem;
	int shift;

	/* can a * b overflow ? */
	if (ilog2(a) + ilog2(b) > 62) {
		/*
		 * Note that the algorithm after the if block below might lose
		 * some precision and the result is more exact for b > a. So
		 * exchange a and b if a is bigger than b.
		 *
		 * For example with a = 43980465100800, b = 100000000, c = 1000000000
		 * the below calculation doesn't modify b at all because div == 0
		 * and then shift becomes 45 + 26 - 62 = 9 and so the result
		 * becomes 4398035251080. However with a and b swapped the exact
		 * result is calculated (i.e. 4398046510080).
		 */
		if (a > b)
			swap(a, b);

		/*
		 * (b * a) / c is equal to
		 *
		 *      (b / c) * a +
		 *      (b % c) * a / c
		 *
		 * if nothing overflows. Can the 1st multiplication
		 * overflow? Yes, but we do not care: this can only
		 * happen if the end result can't fit in u64 anyway.
		 *
		 * So the code below does
		 *
		 *      res = (b / c) * a;
		 *      b = b % c;
		 */
		div = div64_u64_rem(b, c, &rem);
		res = div * a;
		b = rem;

		shift = ilog2(a) + ilog2(b) - 62;
		if (shift > 0) {
			/* drop precision */
			b >>= shift;
			c >>= shift;
			if (!c)
				return res;
		}
	}

	return res + div64_u64(a * b, c);
}

u64 new(u64 a, u64 b, u64 c)
{
	u64 res = 0, div, rem;

	/* can a * b overflow ? */
	while (ilog2(a) + ilog2(b) > 62) {
		if (a > b)
			swap(b, a);

		if (b >= c) {
			/*
			 * (b * a) / c is equal to
			 *
			 *	(b / c) * a +
			 *	(b % c) * a / c
			 *
			 * if nothing overflows. Can the 1st multiplication
			 * overflow? Yes, but we do not care: this can only
			 * happen if the end result can't fit in u64 anyway.
			 *
			 * So the code below does
			 *
			 *	res += (b / c) * a;
			 *	b = b % c;
			 */
			div = div64_u64_rem(b, c, &rem);
			res += div * a;
			b = rem;
			continue;
		}

		/* drop precision */
		b >>= 1;
		c >>= 1;
		if (!c)
			return res;
	}

	return res + div64_u64(a * b, c);
}

int main(int argc, char **argv)
{
	u64 a, b, c, ro, rn;
	double rd;

	assert(argc == 4);
	a = strtoull(argv[1], NULL, 0);
	b = strtoull(argv[2], NULL, 0);
	c = strtoull(argv[3], NULL, 0);

	rd = (((double)a) * b) / c;
	ro = old(a, b, c);
	rn = new(a, b, c);

	printf("old -> %lld\te=%f\n", ro, ro - rd);
	printf("new -> %lld\te=%f\n", rn, rn - rd);

	return 0;
}


