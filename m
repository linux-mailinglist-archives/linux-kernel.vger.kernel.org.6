Return-Path: <linux-kernel+bounces-397131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E409BD723
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C99B213AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE61FF5EC;
	Tue,  5 Nov 2024 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ULDKOT8E"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382471CB9E6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839182; cv=none; b=DrBFRVF/xnspFDXsUmV+BqTgET6eeJZ4x+/JPKVbTM1f2pHUEyM1zIPR99xLwKJkptI7hG5727CB1eb4RWec4+fJ2vLSLgyk5RnYNCJDmfSoAcpUT6PrLkrbX9SOTSMXDsnKKH5MW22/BK+pAWSVy1NPJsvXFlOvzM42X+fAJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839182; c=relaxed/simple;
	bh=AP0IOhU8NvRP6bDtTW0h4Wnk0Mt6i7DqReZJD7vQUV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNgX76DQAl7Qj+56nEzUOnkXqPzD1a9ojoQUrm30YoiuVkdVSgBy56HYEwOvwX9vLZA9CefqTTeoC5J6ysAISAPG4gRYNAuSneaNr8rBMSjmr+JDwoSgJMDZbivUP7981v8sIzK4CMAy5vnKRl8PU8iC+qrDYDe3i7/77eayLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ULDKOT8E; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ede26dc527so1009726a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730839178; x=1731443978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvwCHyx85+PGiQyoEYuGS5FrhSe224LT8dAEEohoTs0=;
        b=ULDKOT8EL2q5/sh3V31Scl4jZO9zDct/cbDy+jeGBj6JMTGIxhrLsNV4uy+kzF6k5e
         HRT6mZPDpS4uF5ctEkDP1VG5QlEwHsoVV5QSgwVkCnWaCo6TIc6Xz8Q4T4NI32NzwP8z
         SzV+xYHaCKmZENZ2HPU/Zp2fQk/grD6rulJXNmcSpNfmcdN3QzTPtIjl1L7hUyBrvWCR
         +aW/A2vr5qU50KKJXoOA5cdYQxWDNOwg11c1s6P7bNPQPrNC7OLh4uHpCjfHj/jXpE0j
         CR2YpQ90ME9zs55Wnvfw+k/ROHj7BlCXdClv7wn1ZU7SAZ9DgLHP61OjUCwEwQ1gNsZB
         3r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839178; x=1731443978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvwCHyx85+PGiQyoEYuGS5FrhSe224LT8dAEEohoTs0=;
        b=Lx3GZdCR1sUi9Nvam1NycFA3Nd43jOs1Zft5YhzSHTdm0vRWA53M2AOySn363DXGNV
         yq5cjGDJ+5nmlSiZj7WDMom5mTZdy7EKFawijjU+S2JAhqxyI0tBLId1Q/iDyPOqzTrx
         kFo7U5aMwiUML4JVM1Sman9UHhm3d+RRlpy2YtCPmDW8vNA6ZjF+jQDT5c3YzJ8X421d
         jBgm6BVKYl5WX9pS5Pv6f3/k+Wvn/bPeYeRhK9kUkz2ovJZFSeXYWzkx18W8/d4iTpqE
         ihJLP7kfVXcLQMUuY6HD9nma4qbFe8lXGrgwdfLE421lAjcJrOECT0vwN9NZkg7pBB0R
         DeGg==
X-Forwarded-Encrypted: i=1; AJvYcCW7l2TfhH3IcWFskts6isp7d11t1HSssYxGDn4ScMG4P72G22vo/mmyHIliNj9K+xnEvLnfkHqlygLkOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybZRzL90yI+cB7kuCRqmhT77IZwQqt9BEj6i3MUcULdg6NFkZt
	YdDWi3Ga3RnYqXD3UjLg5HFennzl7yPHykCMQoE7LA587aVOXE10riP75SjdL1Dio/ONln8XGYb
	HNioTftXXDM/Kcn1KK29rEX+JX05zsc+LIODWyw==
X-Google-Smtp-Source: AGHT+IHydo3dvYseE4V3ot530A+l25Ui7y8eZ0+u5OkSZornws/UsK1beyFnhkms9q0xUowlmqfaMWRUCo10Btuw7LY=
X-Received: by 2002:a05:6a20:1590:b0:1cf:37d4:c50b with SMTP id
 adf61e73a8af0-1d9a83da986mr27372240637.4.1730839178412; Tue, 05 Nov 2024
 12:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR12MB7195C97EB164CD3A0E9A99F9DC552@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20241031163436.3732948-1-csander@purestorage.com> <ZypqYHaRbBCGo3FD@x130>
In-Reply-To: <ZypqYHaRbBCGo3FD@x130>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 5 Nov 2024 12:39:27 -0800
Message-ID: <CADUfDZqFjjsdWpJ2=NvC5Ny2r7PyLWv4LEREEEk7=RzW-ZosYA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] mlx5/core: Schedule EQ comp tasklet only if necessary
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:56=E2=80=AFAM Saeed Mahameed <saeed@kernel.org> w=
rote:
>
> On 31 Oct 10:34, Caleb Sander Mateos wrote:
> >Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet
> >to call mlx5_cq_tasklet_cb() if it processes any completions. For CQs
> >whose completions don't need to be processed in tasklet context, this
> >adds unnecessary overhead. In a heavy TCP workload, we see 4% of CPU
> >time spent on the tasklet_trylock() in tasklet_action_common(), with a
> >smaller amount spent on the atomic operations in tasklet_schedule(),
> >tasklet_clear_sched(), and locking the spinlock in mlx5_cq_tasklet_cb().
> >TCP completions are handled by mlx5e_completion_event(), which schedules
> >NAPI to poll the queue, so they don't need tasklet processing.
> >
> >Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
> >overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs
> >to be processed in tasklet context, so it can schedule the tasklet. CQs
> >that need tasklet processing have their interrupt comp handler set to
> >mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that
> >don't need tasklet processing won't schedule the tasklet. To avoid
> >scheduling the tasklet multiple times during the same interrupt, only
> >schedule the tasklet in mlx5_add_cq_to_tasklet() if the tasklet work
> >queue was empty before the new CQ was pushed to it.
> >
> >The additional branch in mlx5_add_cq_to_tasklet(), called for each EQE,
> >may add a small cost for the userspace Infiniband CQs whose completions
> >are processed in tasklet context. But this seems worth it to avoid the
> >tasklet overhead for CQs that don't need it.
> >
> >Note that the mlx4 driver works the same way: it schedules the tasklet
> >in mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
> >
> >Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >Reviewed-by: Parav Pandit <parav@nvidia.com>
> >---
> >v3: revise commit message
> >v2: reorder variable declarations, describe CPU profile results
> >
> > drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
> > 2 files changed, 6 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/=
ethernet/mellanox/mlx5/core/cq.c
> >index 4caa1b6f40ba..25f3b26db729 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> >@@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
> > static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
> >                                  struct mlx5_eqe *eqe)
> > {
> >       unsigned long flags;
> >       struct mlx5_eq_tasklet *tasklet_ctx =3D cq->tasklet_ctx.priv;
> >+      bool schedule_tasklet =3D false;
> >
> >       spin_lock_irqsave(&tasklet_ctx->lock, flags);
> >       /* When migrating CQs between EQs will be implemented, please not=
e
> >        * that you need to sync this point. It is possible that
> >        * while migrating a CQ, completions on the old EQs could
> >        * still arrive.
> >        */
> >       if (list_empty_careful(&cq->tasklet_ctx.list)) {
> >               mlx5_cq_hold(cq);
>
> The condition here is counter intuitive, please add a comment that relate=
s
> to the tasklet routine mlx5_cq_tasklet_cb, something like.
> /* If this list isn't empty, the tasklet is already scheduled, and not ye=
t
>   * executing the list, the spinlock here guarantees the addition of this=
 CQ
>   * will be seen by the next execution, so rescheduling the tasklet is no=
t
>   * required */

Sure, will send out a v4.

>
> One other way to do this, is to flag tasklet_ctx.sched_flag =3D true, ins=
ide
> mlx5_add_cq_to_tasklet, and then schedule once at the end of eq irq proce=
ssing
> if (tasklet_ctx.sched_flag =3D=3D true). to avoid "too" early scheduling,=
 but
> since the tasklet can't run until the irq handler returns, I think your
> solution shouldn't suffer from "too" early scheduling ..

Right, that was my thinking behind the list_empty(&tasklet_ctx->list) check=
.

