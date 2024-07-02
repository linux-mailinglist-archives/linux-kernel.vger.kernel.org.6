Return-Path: <linux-kernel+bounces-237872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FBF923F22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703DB283DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1351B4C3E;
	Tue,  2 Jul 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TRxOWj+b"
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F71B5839
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927461; cv=none; b=RL4yxO5sKrAJXLM7x4jvu6NRjuJhioNf1HsK/P7qvbeAWcvkBVOiQHkKCN5/Z1QS7X8GreQlsemjIkFgpOS1WZM/mLsqbCMonotTujkHyCNLdjFX4gnMTGKjLHSK2C+8+eU4wT9wPegSlYiGPY3d775bZZsrST5yzz/blIyg06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927461; c=relaxed/simple;
	bh=UGsVZ0LacmtLpDZ/slxBkScj6Se5vWnN2xh+dmG0GXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CImTm/ec8W2LGNlFFTIHAJX/qH2DwiRzpxfBVsFCT9x6P3XWXTTk67rzhg4fhbvNwX7+fQEcH9016nF8rORz2f/dDkptf3zASHSVBbY1BjFjrgjGN4GfosaYoLToILDtoFEO+p2Jm/yILMYvFzbidgmtt0QKrzB4X94GO4eAJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TRxOWj+b; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WD3123C0hzvBv;
	Tue,  2 Jul 2024 15:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1719925222;
	bh=Ic/kjYsPEipQ9NHrPvcvu6Sb0kBMtH0ZUyIbOE9nIas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRxOWj+bskt0EHK1FIrQpZ64bwJIQz7yI1XvZC8jTCNbyMC0q/jJDDfbw3Zf7PDet
	 bG5sJZb9hO5p5B3AMUmZBGdxk4Ow6FOwl2HpnRxNkRiUpvxm2QEyMtUK2OYDOsow4T
	 nHO3QOtE7hiDtrkc1+Y/2iyMBccQ7NcoIi95iGaM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WD3114kzCz153h;
	Tue,  2 Jul 2024 15:00:21 +0200 (CEST)
Date: Tue, 2 Jul 2024 15:00:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Li Wang <liwang@redhat.com>
Cc: gnoack@google.com, paul@paul-moore.com, linux-kernel@vger.kernel.org, 
	ltp@lists.linux.it, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [RFC PATCH] landlock: fix minimal required size for
 landlock_ruleset_attr copying
Message-ID: <20240702.Auya5Chaipho@digikod.net>
References: <20240702094745.96521-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240702094745.96521-1-liwang@redhat.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 02, 2024 at 05:47:45PM +0800, Li Wang wrote:
> As kernel commit fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> introducing a new field 'handled_access_net' in the structure landlock_ruleset_attr,
> but in the landlock_create_ruleset() it still uses the first field 'handled_access_fs'
> to calculate minimal size, so that made decrease 1 is useless in LTP landlock01.c to
> test the too-small-size.
> 
> Test code:
>    rule_small_size = sizeof(struct landlock_ruleset_attr) - 1;
>    tst_syscall(__NR_landlock_create_ruleset, ..., rule_small_size, 0)
> 
> Result:
>   landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)

Interesting, this looks like a bug in these LTP tests.

> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Paul Moore <paul@paul-moore.com>
> ---
> 
> Notes:
>     Hi Mickael,
>        I'm not quite sure if that is on purpose to use the first field or kernel
>        bug, can you take a look?

Hi Li,

Yes this is on purpose.  The handled_access_fs minimal size check should
never change for backward compatibility reason.  User space built with
old headers must still work with new kernels.  This is tested with the
"inconsistent_attr" test in tools/testing/selftests/landlock/base_test.c


> 
>  security/landlock/syscalls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..f3cd7def7624 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -198,7 +198,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	/* Copies raw user space buffer. */
>  	err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
>  					offsetofend(typeof(ruleset_attr),
> -						    handled_access_fs),
> +						    handled_access_net),
>  					attr, size);
>  	if (err)
>  		return err;
> -- 
> 2.45.2
> 

