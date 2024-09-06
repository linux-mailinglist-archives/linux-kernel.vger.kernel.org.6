Return-Path: <linux-kernel+bounces-318283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E174896EB11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C899B22FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61F13D891;
	Fri,  6 Sep 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoSxQTAE"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C03B1A2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605724; cv=none; b=rD/r7zrxMHKTT8Lub9mfHqJgsacPOWHnQDmWPw3pkLdIEpUBNQZzupMUuMRK4b2469Hbk9dVgme+Rbwp0UbfTHGIB3+7+Y2HZJmdoAPwVlGXiuScorZnzFvEci6ZzY1XK3aFb70Ss9BM+mpThY/sRSKGpQZ98Rw+CtBenW/meew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605724; c=relaxed/simple;
	bh=U4A/RhZeNl+GUz6XJGEQcg9fm+vV2FspPeumUQ5Mzg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJbxQ9aZRh3y0+HsjRaCszkmu9iI8bJvPXwkvRIhij6OCfRoIDaDcCplZLtXl8+gOcnqxMoMNVz4bO5vyE0YxzIVpM1F7JUCVDZ5AppkbqhJjDL/sFo4IAQCNM+H9C0+9D3GxL41NVjDbs33BqwOgc10OPuowcLyGfwZHBd+Pto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eoSxQTAE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso1195725a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725605722; x=1726210522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huHKGDZ3UgRGgzHxJUJOt9ZFGl88WlPFklP0aoVFPDM=;
        b=eoSxQTAE1M89XhUORnSuJVLITEzb2DqcPS5iEAlJwoNEB6ZvwYhUFEsHctgO80P7pt
         Vupy/3qDOQrwkZ1BxDclb558L9QPiiyOaJM8T9300oMv7+eqT6YJrwUKIsWi26aAAxuh
         9yuCmvBU7qBi8y6Z0GHaD0IAmMnVrjfYo4EicEi+nO11dhy3rirebHM9Ze3JdVTH7V5z
         jKlVeAHfHsthwqSZgUBTo+RKNpAobsO7d7aUDjOeg3QWkV4tg/isysM57ZMhHrEEG9lo
         OzWF+8NMlHiF1CGNW6CDEvQfFfOa6iGvM7B1wYlUewR+bSkMBS2zl+0/ZbGW7i0d4c0y
         VFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605722; x=1726210522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huHKGDZ3UgRGgzHxJUJOt9ZFGl88WlPFklP0aoVFPDM=;
        b=R0jxnCmknp+UJvNed6lIJgbpHaJ90IwvkBF6BWKQmt7PJhuIOkxaMed5FsQKDKg+fq
         bFTvkCoy9jHZlbzU4h/TQF9wfsGf62KnCF/T3UVxe/NEWcCeCgTVkMtf2d2ZW2pLKxiK
         A91VRvFygn56TXxKK+QQnUpD9XBtfhVJZje/ZaOr5U3p/tLNWnbNwS0VYL7jB1nRgk19
         X11A19m4pLBLKSDaap5nFxdBr1Co3rfqLkbYtoFKPUUw0VW33kZASCJrsH2v/kKiB96V
         8MPDFqdV697tmU3PMtDZiT6cJP7Z4Lri6AWrd88BgTN/1rzcZGgdqpZL2dLVKwGpUTHq
         C0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SH3fl16ob0pN+7kGzT8Pb6lyw9FHRlBA1F2Ne2cv7TjDyGsY6JVnRWIDhwmNaVkUcad4Zqc8XZ7xpBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6o/Ed84/1xzwNKYT6s1JpU4iNlTH/CLbPwDAV8biHAN9LLH/O
	KRNsO73p58VVCDp4u7Ug4w4CmixLgh2mHkJzelzMQXaVOyJTpqu48HX+qE6GQthhuh/nVsLz4rB
	4seoNUhc3NPnFIWehHGW6Dxm2LKnhoBYdnkbrpQ==
X-Google-Smtp-Source: AGHT+IFmJcDO0jhegX+m6PPcKlPTv4keOVNPxdykyyQ4uwXdgN/R+yfCd6e5P6VHcza5aJa7KkkUHCUsMeR5eTb2jz8=
X-Received: by 2002:a17:90b:1bc9:b0:2d8:9253:dffc with SMTP id
 98e67ed59e1d1-2dad5018d6bmr1913694a91.19.1725605722447; Thu, 05 Sep 2024
 23:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-3-vincent.guittot@linaro.org> <e2b7e637-3977-4c06-9a95-88fc53bf4d82@arm.com>
In-Reply-To: <e2b7e637-3977-4c06-9a95-88fc53bf4d82@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Sep 2024 08:55:11 +0200
Message-ID: <CAKfTPtDHTrXmXuJsC9OEwib2brFs87YMjrkVcH=eb08GRwVw+A@mail.gmail.com>
Subject: Re: [PATCH 2/5] energy model: Add a get previous state function
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, mingo@redhat.com, 
	mgorman@suse.de, peterz@infradead.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, vschneid@redhat.com, rostedt@goodmis.org, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 11:20, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Vincent,
>
> On 8/30/24 14:03, Vincent Guittot wrote:
> > Instead of parsing all EM table everytime, add a function to get the
> > previous state.
> >
> > Will be used in the scheduler feec() function.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   include/linux/energy_model.h | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index 1ff52020cf75..ea8ea7e031c0 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -207,6 +207,24 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> >       return nr_perf_states - 1;
> >   }
> >
> > +static inline int
> > +em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
> > +                       int idx, unsigned long pd_flags)
> > +{
> > +     struct em_perf_state *ps;
> > +     int i;
> > +
> > +     for (i = idx - 1; i >= 0; i--) {
> > +             ps = &table[i];
> > +             if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> > +                 ps->flags & EM_PERF_STATE_INEFFICIENT)
> > +                     continue;
> > +             return i;
> > +     }
>
> Would you mind to add a comment on top of that for loop?

Yes I will

> Or maybe a bit more detail in the patch header what would you like to
> find (e.g. 1st efficient OPP which is lower).
>
> It's looking for a first OPP (don't forget it's ascending 'table') which
> is lower or equal to the 'idx' state.
>
> If uclamp_max is set and that OPP is inefficient, don't we choose
> a higher OPP which is efficient?

I use this function to get the capacity range of an OPP at index idx.
uclamp has already been checked before when selecting OPP idx. Now we
want to capacity range to know when we need to look for a lower OPP

>
> I'm not against this function.
>
> BTW, I wonder if this design is still valid with the uclamp_max.
>
> Regards,
> Lukasz

