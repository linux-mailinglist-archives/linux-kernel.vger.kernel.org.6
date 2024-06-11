Return-Path: <linux-kernel+bounces-209687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C7903967
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E7A1F237C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28417967A;
	Tue, 11 Jun 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0Dbvq0h"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B654750
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103572; cv=none; b=q56dx2Qw6qK5Fy3bJsGDf0FmpLeJ29XF7+v37MeH3UmsGtk/QfTc3vTOpIhJ1TeeywgssplkuOAt0DB5y4dr3MH1sDbXFHYaCPrKdVJqryB/5d7s6isB/uvNf4EXqMZnrVlo8KP9RFzH7OxDDgImYsQfD7EtAgJvJu6b5fzDrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103572; c=relaxed/simple;
	bh=26mD7gFcrlTrCcZaeSPSv2aaUfvx6qeHtXPe10BW/Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuAvw5ZokVj5R8l5bqWVSlpNmeAlG7loWqUY05v0j09SBpW/BiUZki+LFuVkg7qOj+iSWLjAgMCm6YIgmaI3OxumhPDzmYgG6n1ZYql8CdG2mKh5lm3DuocNyM/92qpYa0ERxDPRnUKoqU66O9uGD9yU8mmc44Tmq0JzygwVOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K0Dbvq0h; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-60585faa69fso3756796a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718103570; x=1718708370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gU/oXOU/myRviSexRf2kOSn+x6mea7RInjfMG2luRA4=;
        b=K0Dbvq0hzE/HWq/vLPPTLYpDMa+Teavw71dVCtwPO6HFysR886gV5zid+Jxn2qGjNO
         2XKC3YGtu2Z2iqzlrsVtb92qt5AGBsvDp66PAMZsV2nKUnO2vKlVJsQu2ucIUl8BLzMf
         Xbysje6wzz4Hw5U51FOsiBydoKvuF4M0GrCMtAoEcjYi7sArIczSRQkNCDMrEFZcWJVR
         Y/Nt0pz1LnK43y89oHGFDbqOXGFn7oqlcqMY8QrVX9lIDt8Xsfpm+Wfnrxb3ML2krUrF
         ZGiUZI89kZ/Gy3oVAi8TeE6+eNkmLOmW7KGgnRITqKYdUZ2pAKb9bBp6a+w2QsPqxe4D
         KREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103570; x=1718708370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gU/oXOU/myRviSexRf2kOSn+x6mea7RInjfMG2luRA4=;
        b=fVR1k3tiUWlwIL+4xWFsiE8A1dOAu93/iZ2kMv3eTb3YeeVgpxrqvVpcQg5FbS9mTV
         7WYqHNZ/+ScTffFNvhbjpQdEnwkQzkCI/tSSWlkIjomCSw5mDmVcpqnSZLiNkmib2INe
         vceHkUUHSiA/iw4OeMF42Q37Vh2qm+aa1Wunsn9LsqANSE56MJEqvWF3u3gsoYlBNvkJ
         bJWiImqL1MNvO7kmOzRtghxnZIVNsl/L3I8dVJwDm4LvMPgZxnexHkQKlY3b8KcuRj7U
         wmSGNUCtykFEG41E0C0AOQHtc86S5KxBus9mJ66KMR4VnWkdTL3yRPc85zOivvB1NeYJ
         WUIg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/neAhP1U0rv5sP6myzvexu3+KcHiC/UvSDfzZ3BMNBx1pn0sDisp4Ck1UEiIpmyGm/eMpvpPCGyTJYfiu3yHw8Seo8G6yTJLnyz6
X-Gm-Message-State: AOJu0YycElJHRbAJOjRoB7Tu7wNpI4+MOP1eMxKLWsddllCIwdT01yEB
	EHpRFA6dDZDthjWbjtl1b8JHxI8auD1fsL3j7OW/m6OYAYYxLs6+4A4rmFLMydA44wYT56HAiKL
	BF002Kdz46y3QlBgLcAErj+aEgqozot8Ai/tgpQ==
X-Google-Smtp-Source: AGHT+IHPXUILkyGlnDrQSaaPt8UY4FCwHEwdN/m1hSCIe9CM6m7znS0ZCiuxAj3BPHYoDfeY/dm7N5Z8A9KdtSm/6X8=
X-Received: by 2002:a17:90a:4ce3:b0:2bd:801f:dabd with SMTP id
 98e67ed59e1d1-2c32b476e5amr3227898a91.3.1718103569740; Tue, 11 Jun 2024
 03:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603091805.858-1-pugaowei@oppo.com>
In-Reply-To: <20240603091805.858-1-pugaowei@oppo.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 11 Jun 2024 12:59:18 +0200
Message-ID: <CAKfTPtDhXVc4HVeRJzgf9o1n9nOrXM=SgKSru3cynLngFPdxSg@mail.gmail.com>
Subject: Re: [PATCH_V2] sched/fair: updates weight of cfs_rq before
 update_cfs_group() in enqueue_entity()
To: "Gaowei.Pu" <pugaowei@oppo.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 11:18, Gaowei.Pu <pugaowei@oppo.com> wrote:
>
> From: pugaowei <pugaowei@oppo.com>
>
> we should update the weight of cfs_rq before update_cfs_group().

update_cfs_group() updates the weight of se that is about to be
enqueued on cfs_rq so the current order looks good for me:

update_cfs_group()
  reweight_entity(cfs_rq, se, shares); //se->on_rq == 0
    update_load_set(&se->load, weight);
      se->load.weight = weight

account_entity_enqueue(cfs_rq, se);
  update_load_add(&cfs_rq->load, se->load.weight);
    cfs_rq->load.weight += se->load.weight

Have you faced some problems in particular ?

> Ensure that we can get accurate shares of the cfs_rq when its
> weights changes. we can find this work was done correctly in
> dequeue_entity(). so fix it.
>
> patch_V1 :
> https://lore.kernel.org/lkml/20240531030833.3375-1-pugaowei@oppo.com/T/#u
> trigger a warnning below because of the changing order of
> account_entity_enqueue().
>
> [ 0.400603][ T0] ? __warn (kernel/panic.c:693)
>
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
>
> [ 0.400603][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>
> [ 0.400603][ T0] ? handle_bug (arch/x86/kernel/traps.c:239)
>
> [ 0.400603][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>
> [ 0.400603][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
>
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5256 (discriminator 1))
>
> [ 0.400603][ T0] ? place_entity (kernel/sched/fair.c:5182)
>
> [ 0.400603][ T0] enqueue_entity (kernel/sched/fair.c:5328)
>
> [ 0.400603][ T0] enqueue_task_fair (kernel/sched/fair.c:6785)
>
> V2 fix the warnning and keep the lag without inflating it when it is
> the first sched_entity queued on the cfs_rq.
>
> Signed-off-by: pugaowei <pugaowei@oppo.com>
> ---
>  kernel/sched/fair.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..2fb1fbcfdda3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5190,12 +5190,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          *
>          * EEVDF: placement strategy #1 / #2
>          */
> -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> +       if (sched_feat(PLACE_LAG)) {
>                 struct sched_entity *curr = cfs_rq->curr;
> -               unsigned long load;
> +               unsigned long load, se_load;
>
>                 lag = se->vlag;
> -
> +               se_load = scale_load_down(se->load.weight);
>                 /*
>                  * If we want to place a task and preserve lag, we have to
>                  * consider the effect of the new entity on the weighted
> @@ -5252,9 +5252,13 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>                 if (curr && curr->on_rq)
>                         load += scale_load_down(curr->load.weight);
>
> -               lag *= load + scale_load_down(se->load.weight);
> -               if (WARN_ON_ONCE(!load))
> -                       load = 1;
> +               lag *= load + se_load;
> +               /*
> +                * we just need to keep the lag whithout inflating it when the se is
> +                * the first sched_entity queued on cfs_rq.
> +                */
> +               if (!load)
> +                       load = se_load;
>                 lag = div_s64(lag, load);
>         }
>
> @@ -5304,6 +5308,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          */
>         update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
>         se_update_runnable(se);
> +
> +       /*
> +        * we should update the weight of cfs_rq before update_cfs_group.
> +        * Ensure we can get accurate shares of the cfs_rq when its weights changes.
> +        */
> +       account_entity_enqueue(cfs_rq, se);
>         /*
>          * XXX update_load_avg() above will have attached us to the pelt sum;
>          * but update_cfs_group() here will re-adjust the weight and have to
> @@ -5318,8 +5328,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>         if (!curr)
>                 place_entity(cfs_rq, se, flags);
>
> -       account_entity_enqueue(cfs_rq, se);
> -
>         /* Entity has migrated, no longer consider this task hot */
>         if (flags & ENQUEUE_MIGRATED)
>                 se->exec_start = 0;
> --
> 2.17.1
>

