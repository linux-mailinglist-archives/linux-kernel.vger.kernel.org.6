Return-Path: <linux-kernel+bounces-421957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B84349D9298
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CF4B25902
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F4B194AE6;
	Tue, 26 Nov 2024 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skxwb2c6"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABA19995A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606666; cv=none; b=Bm+sXpM3l4gILepZ7vrFZUAjb+dOMyxlbHgojNTIR6QW1GWyANmuEvebar1urSQ8MNvCnUD+vfbHBv670RmjE2IX80lVsYX15jLnfcHLv/e9ldhzP/rzxQ02IlLR7tiWKyp+qtgPz/Tt3qKkMMHDpWBCSMvNqfHk0EWYF4QQKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606666; c=relaxed/simple;
	bh=8jDEKxLSsx1rwZXC6X2DbXk2k8+102jufOYFQJxOPis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj22q28F7R4Fm1+AmA39W5ZjD77vTMPizjKNaP/KGiH7ZT/NlOIByumsnIjVzT0HQ/q4nTsSR85ohgwHuJga5bzB2XTU2cHiSKBSbhaAx/iXWGu6XSogdIospBf7ezhVQnN/RTP1YJCNYfxMSdTcIM4ESXZnuy4XFpE+ZDVSL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skxwb2c6; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee676b4e20so54071577b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732606662; x=1733211462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzJ8y3qThHAT3ji1jGc3KKyhMYzUDWpdeImJOBfn8s8=;
        b=skxwb2c6/CfrR08MOcrKW5f7IEBEqTvCH1ZLCZ49XTPZMBcOaRhEPgP7WpbH6u0/uR
         mzwL+XA7d6hPiThiMBN6xNdatsXtH+tVrlxB+AjsLUZVi56dVqx8GYPqartCZt1/MqeJ
         M6ZX8x/8a15rQ3zcOGE9jgpGkymFiXq5aJ3XaIDVYxNXZVKQqOoxIOlXfPNoezZL9eL/
         PMUuYZRY8Zm59mzH8WTGIUUroZqwdLoaj77ps3GbpJ4Iv1ekTivd9cAmhwSEVjbyz/A0
         0kMbhp04wIwVtZq1y2GZyjkYs1aWfizScnyLflZxmEWiu+4a5fq0MEwcXCmUL3MEBdr1
         +xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732606662; x=1733211462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzJ8y3qThHAT3ji1jGc3KKyhMYzUDWpdeImJOBfn8s8=;
        b=tg7NdBBnqixcq36AM9jbeHnH+rZOex9zLtWZDVN53kQZIR9otEhtOIQnqeBuVaRggK
         OwFxWhRY3s8YL7wvcT1Wwf4uH4zVLEfCItZvxxmirtXWbKg3DWTZk7w9DfXLs0m30a62
         YNXujcwx8CkPWgihX6Igb+drLr02e2xHqTgqj09Otvel5bg2nT1SsXWprHbp7ycrKvFR
         au2nKIj7MwhnfGSiP7IUKvWM1Yvo7kyFAg1FYZ94WPGnfzCdvpdONixm/u6qliqVMlmA
         FtOhoGdc/gkcGgTWPbsTxr5oO3x0RAh+2HoVbr2P2tokDFBJHg1OcSJiUCdT1htVkN/b
         mlxA==
X-Forwarded-Encrypted: i=1; AJvYcCWacDlVSFEd6ljA0h4IdsXKzNT8D3d3AZvUhHTHOH3cgBh4BNLYM/YLMLx8TnU6pqO1RGuTl/2xfon65ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhsh/RR4wBPjNUeE34egm9vbbZ7SuWW5VHUEpQhsvTxIU6q2c
	Eg5TRY9bgpnpaayEpgyCx4d8nkMV6SXZJ9ZQxuUNRSXzhAdWTQJw9QA0SfJlICsCfS5ylXQKuVT
	fAGtABCDXtplIy1vCI0Zm1K8pmfe9aFLE17IK4Q==
X-Gm-Gg: ASbGnctEZEX47bP5cf1GtLEF3XCaZS7GO+QAsuX91mNNHRpnqVXWKJUj1VfRz++LOzY
	lSwuAfEmJGuJgjgSCCTuKaNftbps+A3I=
X-Google-Smtp-Source: AGHT+IG25CYHixpJ7nOq5l+BobwqKzKUEHt9Mf8gk84f32pc2M+oiSy7++GIyqdSuhvD+RneIJuhEgFfvcnF51MQCdY=
X-Received: by 2002:a05:690c:3386:b0:6ee:a70c:8727 with SMTP id
 00721157ae682-6eee0a2f97cmr145845267b3.41.1732606662315; Mon, 25 Nov 2024
 23:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112170050.1612998-3-hch@lst.de> <20241122050419.21973-1-semen.protsenko@linaro.org>
 <20241122120444.GA25679@lst.de> <CAPLW+4==a515TCD93Kp-8zC8iYyYdh92U=j_emnG5sT_d7z64w@mail.gmail.com>
 <20241125073658.GA15834@lst.de> <CAPLW+4=kuHze3=+g80CsY6OkLno5gyjRfMWLXTFHu3N_=XcmqA@mail.gmail.com>
 <20241126065253.GB1133@lst.de>
In-Reply-To: <20241126065253.GB1133@lst.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 26 Nov 2024 01:37:31 -0600
Message-ID: <CAPLW+4=0Ojg58pa7iFkgY=5S6wr-dYseJVvXL466W+ROAh0r8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi Sam,
>
> please try the patch below:
>

I can confirm the patch fixes the issue on my side. Please add me to
Cc: if you're going to send the fix. And I'm always available to run
more tests on E850-96 board if you need it.

Thanks!

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index acdc28756d9d..91b3789f710e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -685,10 +685,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,
>
>         prio =3D ioprio_class_to_prio[ioprio_class];
>         per_prio =3D &dd->per_prio[prio];
> -       if (!rq->elv.priv[0]) {
> +       if (!rq->elv.priv[0])
>                 per_prio->stats.inserted++;
> -               rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> -       }
> +       rq->elv.priv[0] =3D per_prio;
>
>         if (blk_mq_sched_try_insert_merge(q, rq, free))
>                 return;
> @@ -753,18 +752,14 @@ static void dd_prepare_request(struct request *rq)
>   */
>  static void dd_finish_request(struct request *rq)
>  {
> -       struct request_queue *q =3D rq->q;
> -       struct deadline_data *dd =3D q->elevator->elevator_data;
> -       const u8 ioprio_class =3D dd_rq_ioclass(rq);
> -       const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
> -       struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> +       struct dd_per_prio *per_prio =3D rq->elv.priv[0];
>
>         /*
>          * The block layer core may call dd_finish_request() without havi=
ng
>          * called dd_insert_requests(). Skip requests that bypassed I/O
>          * scheduling. See also blk_mq_request_bypass_insert().
>          */
> -       if (rq->elv.priv[0])
> +       if (per_prio)
>                 atomic_inc(&per_prio->stats.completed);
>  }
>

