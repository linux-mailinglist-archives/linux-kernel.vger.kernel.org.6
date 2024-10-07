Return-Path: <linux-kernel+bounces-352838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723099250C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C0628135C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3E1537C8;
	Mon,  7 Oct 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiE8/2ks"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39195733A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283348; cv=none; b=palgBLwoM15Crdo+aD1BqP+NX6B/Fw/nyleNGbVzaj+N1V+so04HakdZdDs65CDhEg5iK5etPGxIdGEXEk1todk+NxNCvqK+PhoqjpeUTUlV3V+VaKBQbtlMGUDEA3SZLwhJ/jrHHujwAcTpyVGEMfB95pUAMkk/Q1BTxOhP9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283348; c=relaxed/simple;
	bh=4ZGte62oUhr0vF6ZH5/ldDiS9M27dFsB3ekE4AMJzmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWEiDexw6id5IPEZqjWfylQZFOxS9KytE+vHQyZ35ABQAB9JnX11uUJUjRcvxxqs1vFFF1+G3tzx7UhucW5MAFMwg+y5xly+h9xPPTVq8y/0oK0XC4Mgq0w30THef5Z4RP3P8iDDRE14JGc1bZvFfxapz0W6QlneTEkD3g/HO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiE8/2ks; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df8585a42so940041b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728283346; x=1728888146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj6sHJOwTphfQYCsayNKaZz8MVlGIFX3ejJ1aKVfljk=;
        b=XiE8/2ksQtZG6zfFsMcKMIvA0I0vE4JvE/dtG7WypnEHpk8ihsYhQw3fpUBamA32Nt
         OTTiEkc72Lrn1knrZxjOq62S0Tc3kDI08CsgpBi6oBYr3+RsOYNy873atkiLPPL5IsfQ
         rMa4WuswnV2RSKBg3QOXwq4sG7WAcTXGY+mhTtgVh/ZEdYg8fU6z5zpHxHhoDPfKOOdk
         rjsva6ktkspoaTv7y5Cb1UzhvFpgTRpVQqcMCPq2VcjuvvMi49CnZ38HpJP7bB1t8in8
         LNMDKDfYHDKO7OnCeEDuoiasyzzJbvyBWUunJitQgwMhd7SbQuMweOBRbv2ZnjqfnsKV
         rekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728283346; x=1728888146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lj6sHJOwTphfQYCsayNKaZz8MVlGIFX3ejJ1aKVfljk=;
        b=XVP3MomSP9juzZnR3y0ibxGxRjE10UgOB0CeQwrzLo8wy8cwq7920kJmya+uXS1iw4
         tHg1Lv2DYQwxWSTe5ZPchCKoxmv57qQSA1GntB+PRIiBk8+J6i/uVpZHKOnbailZORSR
         a2cSQyOcFul7ZEmtnmaTAoxckbJA9xFsbmB6NbbflDnFvvUJQ9//NPhufmkGXggGZDsU
         B7SGpivVyaivZuiFFZ44YwrZpAC710OjZ/ceBeE3onGS3L8d5jzBfmf0u9EAqlHRk3NO
         waLm3Njpps1y9vyzIHi4VDu3/CutFV5P26ijw3ScklsIizMeLc5iHg5EFxjFWOi1LJ2L
         TQpg==
X-Gm-Message-State: AOJu0Yx3Vj2pMdXNK4qnKgN5tBmAKPlOME5g/R0PCb6baagpRfzwi28f
	avtWCJ0QzAKlq2hI3hbJqrn4oJFUpbJNTZHp9d0fv6eSQSso8EPTtql7ml9VMbPPWQDE8FEJ2PJ
	0p6icWZkWOLURhompVNDlnkXqI3dhoR2wtqNYxw==
X-Google-Smtp-Source: AGHT+IHGPEyEtm46gYWvtWApVuAB4L0ZSvbJAlMGCu0ho+0CfXRE1CHOQ4GiB05B/xtSuJZ8OnxdKAir33bK8aeoi64=
X-Received: by 2002:a05:6a20:2d22:b0:1d2:bc91:d49 with SMTP id
 adf61e73a8af0-1d6dfabadffmr16423346637.31.1728283346174; Sun, 06 Oct 2024
 23:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005005245.829133-1-zhouzhouyi@gmail.com>
In-Reply-To: <20241005005245.829133-1-zhouzhouyi@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 7 Oct 2024 08:42:14 +0200
Message-ID: <CAKfTPtD7TPYcPcwHxC_n8PObZMgqxU+9=U-F6yJbP0=cLAB8hQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Fix typo of head comment of ___update_load_avg
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 02:53, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> The head comment of ___update_load_avg illustrates the principle of
> PELT divider. "unwanted oscillation in the range [1002..1024[" should
> be "unwanted oscillation in the range [1002..1024]".
>
> Fix above typo.

This is not a typo as 1024 is an excluded endpoint of the interval.
Some may use [1002..1024) but both [1002..1024[ and [1002..1024) can
be used

>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> ---
>  kernel/sched/pelt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a9c65d97b3ca..565171fb2138 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>   * When syncing *_avg with *_sum, we must take into account the current
>   * position in the PELT segment otherwise the remaining part of the segment
>   * will be considered as idle time whereas it's not yet elapsed and this will
> - * generate unwanted oscillation in the range [1002..1024[.
> + * generate unwanted oscillation in the range [1002..1024].
>   *
>   * The max value of *_sum varies with the position in the time segment and is
>   * equals to :
> --
> 2.34.1
>

