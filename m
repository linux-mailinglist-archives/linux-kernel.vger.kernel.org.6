Return-Path: <linux-kernel+bounces-283372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9194F1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA5D1F23271
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42B183CD6;
	Mon, 12 Aug 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ss5sasqU"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719F130AC8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476463; cv=none; b=QPkZugjSZrfdzU81/KzG486ds5d4/3EUwoiYqTKNX59jsoijR9tpkp1D5apYyg0dhd5irI4qMurLTljCIk7xXEp8B152Orqs7OYHvP+u74MNmJRSeu3EJTOJokkQjUbMoRZsTHz2Uw8mNBAOmByHS0JNoql30hjeJp0q9CIh0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476463; c=relaxed/simple;
	bh=A+A5/qtg7nweFLqvxQbCSszlaP6zzqUFAX0dNMt8wqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieZq0OqOn71TZe7Jgs8Sb94rhtXvgPcWC5KO8ga9zPV4vTJ6pyy8VjlDJmZ0BbbddeHF5r/Uj4Qw/AFffgACpK/+kLtqVGdyIk51aoNd4LYR0IbRV73Y3XSKY0fdkRsInO2HCpXdQAJK+4jAyr0cM32iKMe3OjCVz3C2ukhZ7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ss5sasqU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-68518bc1407so43293197b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723476461; x=1724081261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmdptg1/tyPFbhndZvQOWlGVVuGmVhoQEjYbJCzYHfw=;
        b=Ss5sasqUWtXG63YaYs4FQmIq7B9E44DOnd348iyfJrXxt3P9ThNNINtiNDwudzFOD4
         Y8rffF2cOCOJHbXc6uP/EltbUt2ImVv9gwaYOW4tUb+kI4ajvG+ikN6uYLioGzDtIpsr
         EomTMnSx87BnLxc8lR8tVmCuvd+NAzy7xiQ69BH7uaZDk2SOXTYg6tXkED2eHghwBIZy
         Y79q5WpTP4akByx1pKjOBULMAKSLduofX9LH1tB6QtBvirNrxOTwKXT6hGai4AwTFs3L
         YFeehshl1+Xb5ieOoxT3bfJy/qDLWxdityIgGGLmTymxlateQ58zEHfCqWkCql/xzMN5
         +stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476461; x=1724081261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmdptg1/tyPFbhndZvQOWlGVVuGmVhoQEjYbJCzYHfw=;
        b=Yfbxma+I6w96Jfuti7d0Z7m88IH0KOwdsZMTba2LNac2LeJXqYVL4N5YOJpMW3OXTA
         oBt+TzaBrbWoh2WDGBw51gAlT/pAYjVvvzKZcv+ux89emH/rS+iKYBThdn7+CsbUG5Rr
         uSj7c75K1yBS9Au5msiYUQzyD8ttXpo7K836t/P33pd1pha/G6dZq0LaZF6z0rDUei3Y
         TvV3vSDxJMBjPHQDpfpfl8bEELaQBmSsMUzdqanG2tFRHQ5YPEIlohKHLg1MIoLOFffw
         HxtEUiP4ntNZIt1PtkPnATn6/tV76hJGSuy4OQdJzPegFhLhzrY+DucTTe+C9pa1HKX8
         5lVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5ioB7qvXQThDk/Qxo9ZOFQqWux2KAuVFk+1LcE5g+WM+EYs6Wko2dHmyHfbWPtuXGenk1s7/vdA2Jrr6ibLIjSU55vDli5+tjmro
X-Gm-Message-State: AOJu0YzYH14nU4hC7Fe8DhlfUxzaDskkXbhjV89WQLTRHg9T87FLnOXu
	iFiql14y0fX97whWS9Til0EzIZDTbwwWZdZuYshAXf/RSCP73ZCycKeCD9ifaGc3+xdvZ5wnKQj
	ktY8dqgMVRDR40MWqFctfNesjxI6EKNrIgC9/
X-Google-Smtp-Source: AGHT+IGTrjh8TSkmkypNTI0dBHCTUrRP3dQJZfw7vDTGhaLT9vmR4W8VsOJmhTfQtQEp+pwDN1X0jPRCs3GGTrc7WJU=
X-Received: by 2002:a05:690c:f8c:b0:652:e91f:a1bc with SMTP id
 00721157ae682-6a971146f58mr9062257b3.3.1723476460758; Mon, 12 Aug 2024
 08:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
 <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com>
 <be0be869-4daf-4530-b90d-6dd6c27c8736@suse.cz> <CAJuCfpEMyRATp+6Xhe_XX-8hPKzONKonWbt_Jnkyp-wOJkN9ng@mail.gmail.com>
 <CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com> <CAGudoHF=oPXU1RaCn3G0Scqw8+yr_0-Mj4ENZSYMyyGwc5Cgcg@mail.gmail.com>
In-Reply-To: <CAGudoHF=oPXU1RaCn3G0Scqw8+yr_0-Mj4ENZSYMyyGwc5Cgcg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Aug 2024 08:27:27 -0700
Message-ID: <CAJuCfpFHyzCwGov7YzrE1UDc+0jxKjfm_Kcn3NHR=NXPma3PnQ@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Mateusz Guzik <mjguzik@gmail.com>, Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Liam.Howlett@oracle.com, pedro.falcato@gmail.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 9:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Mon, Aug 12, 2024 at 12:50=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > Ok, disabling adjacent cacheline prefetching seems to do the trick (or
> > at least cuts down the regression drastically):
> >
> > Hmean     faults/cpu-1    470577.6434 (   0.00%)   470745.2649 *   0.04=
%*
> > Hmean     faults/cpu-4    445862.9701 (   0.00%)   445572.2252 *  -0.07=
%*
> > Hmean     faults/cpu-7    422516.4002 (   0.00%)   422677.5591 *   0.04=
%*
> > Hmean     faults/cpu-12   344483.7047 (   0.00%)   330476.7911 *  -4.07=
%*
> > Hmean     faults/cpu-21   192836.0188 (   0.00%)   195266.8071 *   1.26=
%*
> > Hmean     faults/cpu-30   140745.9472 (   0.00%)   140655.0459 *  -0.06=
%*
> > Hmean     faults/cpu-48   110507.4310 (   0.00%)   103802.1839 *  -6.07=
%*
> > Hmean     faults/cpu-56    93507.7919 (   0.00%)    95105.1875 *   1.71=
%*
> > Hmean     faults/sec-1    470232.3887 (   0.00%)   470404.6525 *   0.04=
%*
> > Hmean     faults/sec-4   1757368.9266 (   0.00%)  1752852.8697 *  -0.26=
%*
> > Hmean     faults/sec-7   2909554.8150 (   0.00%)  2915885.8739 *   0.22=
%*
> > Hmean     faults/sec-12  4033840.8719 (   0.00%)  3845165.3277 *  -4.68=
%*
> > Hmean     faults/sec-21  3845857.7079 (   0.00%)  3890316.8799 *   1.16=
%*
> > Hmean     faults/sec-30  3838607.4530 (   0.00%)  3838861.8142 *   0.01=
%*
> > Hmean     faults/sec-48  4882118.9701 (   0.00%)  4608985.0530 *  -5.59=
%*
> > Hmean     faults/sec-56  4933535.7567 (   0.00%)  5004208.3329 *   1.43=
%*
> >
> > Now, how do we disable prefetching extra cachelines for vm_area_structs=
 only?
>
> I'm unaware of any mechanism of the sort.
>
> The good news is that Broadwell is an old yeller and if memory serves
> right the impact is not anywhere near this bad on newer
> microarchitectures, making "merely" 64 alignment (used all over in the
> kernel for amd64) a practical choice (not just for vma).

That's indeed good news if other archs are not that sensitive to this.

>
> Also note that in your setup you are losing out on performance in
> other multithreaded cases, unrelated to anything vma.
>
> That aside as I mentioned earlier the dedicated vma lock cache results
> in false sharing between separate vmas, except this particular
> benchmark does not test for it (which in your setup should be visible
> even if the cache grows the  SLAB_HWCACHE_ALIGN flag).

When implementing VMA locks I did experiment with SLAB_HWCACHE_ALIGN
for vm_lock cache using different benchmarks and didn't see
improvements above noise level. Do you know of some specific benchmark
that would possibly show improvement?

>
> I think the thing to do here is to bench on other cpus and ignore the
> Broadwell + adjacent cache line prefetcher result if they come back
> fine -- the code should not be held hostage by an old yeller.

That sounds like a good idea. Mel Gorman first reported this
regression when I was developing VMA locks and I believe he has a farm
of different machines to run mmtests on. CC'ing Mel.

Mel, would you be able to run PFT tests with the patch at
https://lore.kernel.org/all/20240808185949.1094891-1-mjguzik@gmail.com/
vs baseline on your farm? The goal is to see if any architecture other
than Broadwell shows performance regression.

>
> To that end I think it would be best to ask the LKP folks at Intel.
> They are very approachable so there should be no problem arranging it
> provided they have some spare capacity. I believe grabbing the From
> person and the cc list from this thread will do it:
> https://lore.kernel.org/oe-lkp/ZriCbCPF6I0JnbKi@xsang-OptiPlex-9020/ .
> By default they would run their own suite, which presumably has some
> overlap with this particular benchmark in terms of generated workload
> (but I don't think they run *this* particular benchmark itself,
> perhaps it would make sense to ask them to add it?). It's your call
> here.

Thanks for the suggestion. Let's see if Mel can use his farm first and
then will ask Intel folks.

>
> If there are still problems and the lock needs to remain separate, the
> bare minimum damage-controlling measure would be to hwalign the vma
> lock cache -- it wont affect the pts benchmark, but it should help
> others.

Sure but I'll need to measure the improvement and for that I need a
banchmark or a workload. Any suggestions?

>
> Should the decision be to bring the lock back into the struct, I'll
> note my patch is merely slapped together to a state where it can be
> benchmarked and I have no interest in beating it into a committable
> shape. You stated you already had an equivalent (modulo keeping
> something in a space previously occupied by the pointer to the vma
> lock), so as far as I'm concerned you can submit that with your
> authorship.

Thanks! If we end up doing that I'll keep you as Suggested-by and will
add a link to this thread.
Thanks,
Suren.

> --
> Mateusz Guzik <mjguzik gmail.com>

