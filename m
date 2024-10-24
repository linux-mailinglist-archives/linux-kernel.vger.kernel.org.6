Return-Path: <linux-kernel+bounces-380753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4D9AF591
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91990282CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD221730D;
	Thu, 24 Oct 2024 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWZzH3NV"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C562170BC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729810105; cv=none; b=CzyjeQlSFKRVkZdWcGLmGUmvdxwnrMgJt9jgySQh5O82PfpO7TjXUOQKKI8ZsST1VqfbEFlmrxwdWdjX1vjtxnyn21TyxPzIqW2flanlY89zdHhURVsPKrfDJ9bERPwo5W//0vin8rkttmKfljkQr20/hxLHv6meAgXa1Bb1sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729810105; c=relaxed/simple;
	bh=Ukb48MbgfTQZMqzPei5pcjBQ6CWNkxKIlhtDbb2wX/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afe6z2CKo4CsaPq0eDJ2Lqo3cm+XQjBRitDQOxmuosXq+Z4OrkMt936lJCnzGA/oumoHSyxnuEUvMtmY5W3U0grxVWccQcuu85lCawFJEg45Cd+P8eMjEWE/oP44f/sRGcyjxtAtHXTyZ4cP8GgIdlK/wg7G1GN/l0M4VFQTwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWZzH3NV; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e7e1232648so14636837b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729810102; x=1730414902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/Z+jjExSA5CCQ4WEZr8l+D1Xo4iPnJUgr3jBICvfIY=;
        b=GWZzH3NViVyAdGDMg+0KiqGB5iTFuLiuoQDuesw5qYOdAhRbzDNPm8qaqzIojp3CpC
         PSjlp+9edM2GStVfTgetVrn2mOt5GkxmDE9nqxvpWXPKDEzbRL9kGPclVJ05t8RukREu
         9w6GeMzMwzDad5tlgbRvRI9dqlmLC5WEl3gbd+udAlnMTkHZ3Re+4tWADH1mSi4skveH
         jJ0UtINl9ULme/JdCeuIejb7SV/8KM+0ESfJ3cA5TdbWJLDUQSoXDtCkissc5Gxid/2U
         FGNfmTrVl6Pj1bT+7leDK5TSya690xNs/HR145Y+W6J3BsHvX+dqYMeZ4+N4A4aRtSJy
         bq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729810102; x=1730414902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/Z+jjExSA5CCQ4WEZr8l+D1Xo4iPnJUgr3jBICvfIY=;
        b=r5oV9npb/OMZtb1rg51ifpQFwFZMDMxNZLd0XPSgaRRt8FsQA+cpXyDC7HG0f0rjpZ
         rmLrjgXVM+sF2wFPUBeoyYIuLHIuvVW7hnFN8kpMEPFAPgOeiTnXHR7cMscYSqA5Ob2C
         GzxO+YD0r8bsWN6Q6YfYJqwC2U/AJVNRojhpx5oFThJ5Vae0xeduTMnJjP62CTpUDuR2
         ipIxiloW79UvyM8wIm9Xygd6Wp4X5VEDMjJ0O5fBYHQY/KZtduyDGsoe5E4nYg0bA43i
         cCIMdzqI5AF/qzg6wd23a2RLhFgPCJu3MykczHxFw+6/E11NMRmYUIgFNHTf+XEKZNAT
         hzbg==
X-Forwarded-Encrypted: i=1; AJvYcCXOHLSr73zKXKbsD0wtN9zNqNwebJdTxU1pVm+rIdzUpbDdnu3Jh28W92f7JBxZWsv5gujj+FTaoEWe9PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ooRxvg5MqIPVPY8kuSDVMNKWyCXhze/J6HwBiS+7xiFmUNZe
	w54c7T3Lai8I/8kFsdYbOlJDim8cQSwjddlD83fLfOnX84kCLwBrgDFOvAh5l+vCelQWCDy0Cbw
	Q4CQsWgWku6C49WwzccpZLGGxbY79xok/5WdYwA==
X-Google-Smtp-Source: AGHT+IG8a1evX3pUMYQzPD37tjSh3GWuUu5Da9194oAm8qjpTw4RNmsj2GMQjQ0uxWRM3qN24pvQ7I/LyGVxhkY+c0s=
X-Received: by 2002:a05:690c:360c:b0:6e3:7eb7:b600 with SMTP id
 00721157ae682-6e7f0fa4044mr95131627b3.43.1729810102335; Thu, 24 Oct 2024
 15:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com>
 <20241006135530.17363-2-quic_spuppala@quicinc.com> <20241023212834.GB3736641@google.com>
In-Reply-To: <20241023212834.GB3736641@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 00:47:46 +0200
Message-ID: <CAPDyKFp5z=72eUudLXKD84eSVgPp7gGGJCtUKZeczMb3J68oew@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] mmc: core: Add vendor hook to control
 reprogram keys to Crypto Engine
To: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_neersoni@quicinc.com, quic_gaurkash@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 23:28, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Oct 06, 2024 at 07:25:29PM +0530, Seshu Madhavi Puppala wrote:
> > Add mmc_host_ops hook avoid_reprogram_allkeys to control
> > reprogramming keys to Inline Crypto Engine by vendor as some
> > vendors might not require this feature.
> >
> > Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> > Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > ---
> >  drivers/mmc/core/crypto.c | 8 +++++---
> >  drivers/mmc/host/sdhci.c  | 6 ++++++
> >  include/linux/mmc/host.h  | 7 +++++++
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> > index fec4fbf16a5b..4168f7d135ff 100644
> > --- a/drivers/mmc/core/crypto.c
> > +++ b/drivers/mmc/core/crypto.c
> > @@ -14,9 +14,11 @@
> >
> >  void mmc_crypto_set_initial_state(struct mmc_host *host)
> >  {
> > -     /* Reset might clear all keys, so reprogram all the keys. */
> > -     if (host->caps2 & MMC_CAP2_CRYPTO)
> > -             blk_crypto_reprogram_all_keys(&host->crypto_profile);
> > +     if (host->ops->avoid_reprogram_allkeys && !host->ops->avoid_reprogram_allkeys()) {
> > +             /* Reset might clear all keys, so reprogram all the keys. */
> > +             if (host->caps2 & MMC_CAP2_CRYPTO)
> > +                     blk_crypto_reprogram_all_keys(&host->crypto_profile);
> > +     }
>
> This should be a simple flag, not an indirect function call which is
> inefficient.
>
> It could be a bit in mmc_host_ops, though based on the existing code maybe a new
> bit in MMC_CAP2_* would be more appropriate.

Thanks for commenting Eric. From a principle point of view, it sounds
like this makes sense to you too.

When it comes to the implementation details, I agree with the above.
Perhaps MMC_CAP2_CRYPTO_NO_PROG, or something along those lines would
be better. Unless the callback is intended to dynamically allow the
decision to be changed, but it doesn't look like that in subsequent
patches.

Kind regards
Uffe

