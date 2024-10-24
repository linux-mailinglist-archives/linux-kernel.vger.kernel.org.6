Return-Path: <linux-kernel+bounces-379228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739219ADBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89951F22560
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7317BD3;
	Thu, 24 Oct 2024 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5aLoK2k"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C9170A1A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749967; cv=none; b=FiIgWfIdnhVd9I5qnN93J4jWL53t0RbN3kFPiTFXNSKgsbVjawU+pTFYF8Iv7wPDdji1RiP4NcTasP1sHbhqIMzko2EJyGuX76CY9xRaFocyWynKQSId7hM2hTfH6cK2hj+SZixls7enSprjezvQGM2pBiV2dc9y4ocC7FcFf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749967; c=relaxed/simple;
	bh=hsMyPamrToP/NpISbu4aoadIHqTQJ2ZJa10Ia/hvNJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ossW2cfX1y5Q0scndpq44Mcqmxv3voywbsYJNMhAfFVCVZ4p0/+1z5augNQgaszU4EWAR1tQW8BiSG3YGUtH3nhveMUX/MOrXh8eeem3QCd+HJu4R+LdkK62MLvN2Da6xW46yaVEQGl6itzEWM+blQYyeYvww5QkiTpOljg1VHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D5aLoK2k; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71ea2643545so435299b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729749965; x=1730354765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O04ycheBIb1ii7gY4+sKk/4mPmTT0uGH3ikEcn/v4s=;
        b=D5aLoK2kbpxEGw7B2uGALUnbW6dK1S8ftU8o/JxsMHQok+SmfWUV++ndWp41h63fRq
         BxRLtYceRjgEI1aFFL09jxlXB6cotd4FfIdgsPD3XUBHSWbsrouW6qKit4mEo1HDECQ8
         dJN8dZk8r88LWaiULNC4n4ALq/FBSG/x/IKb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729749965; x=1730354765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O04ycheBIb1ii7gY4+sKk/4mPmTT0uGH3ikEcn/v4s=;
        b=CzSH9nHXxPO+eA8nWGxjX5goMRUOewA73gL0KkghoxSSQO01BxDoQUKbTrxN49fiqT
         wCJJ3h2E4C0h5ufBd7P6T0363P9pkoPVkH2wGhL71jF+O7CU2pg5aMlmLlDWxQzHEfLk
         WLGh2mhilrd291o39o+D6eRCG6MZX5cHuoVhUOZ2yAkie1t8FXDuCfZnH/qjUjzWpvPG
         XQUyGHp94hJa6jo/OMJh0SZV3p2wJwVPtjxfPSwCm1j3MHsLb+JHK6Ix+Naa6bw43i0m
         oAaMkYjSoTn9hqujt464UgYRw2LItZSZ1ajp7MGNWUQ7QbiBclR1TVxhqOIthB0OFJki
         g8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBkwEnVPJptsmnZqsS8+sMc1DLpIwo21wDPg5hu2Wq0KEuEky93QZsJXwKMCMRcRG6xu7sXALYViL+JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDgshqsGARXARjzkwM0NmnOA8wM1CTK25XQHetByJGyjI+JKJ
	fgoXVrXwueRSN+StvmFPqJ3iWV/dMOj5ERdb9goNovn1wNA5DCmyivuI+Cs3L3cUoTQoYA6m5Q0
	=
X-Google-Smtp-Source: AGHT+IEfT5bYJUV+rsOjeeE2OkE+lsEqJkHBzwHAzvzZqSjgVg9D32cSnk1/OXDPG7/LyNhySWe1pQ==
X-Received: by 2002:a05:6a00:3e29:b0:71e:6728:72d5 with SMTP id d2e1a72fcca58-72045e774c5mr1087538b3a.15.1729749964580;
        Wed, 23 Oct 2024 23:06:04 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131393dsm7221110b3a.37.2024.10.23.23.06.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 23:06:04 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso41285ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn3oUOXzBl+3XcxKsocGqv8sEbbKHmFs9TfHvsCBO2OYr9hhnr+bigQcUaFN7cwDYIBluO7fvWAnHe+o4=@vger.kernel.org
X-Received: by 2002:a17:902:d491:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-20fb5f2bbbcmr1897585ad.8.1729749962756; Wed, 23 Oct 2024
 23:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023052444.139356-1-senozhatsky@chromium.org>
 <20241023052444.139356-3-senozhatsky@chromium.org> <20241024045836.GJ1279924@google.com>
 <20241024051335.GK1279924@google.com> <CAAFQd5ACxz-3icNH_CwWxWj5OyKdg89mOkNadYKa=YTVDRYRLg@mail.gmail.com>
 <20241024054639.GL1279924@google.com>
In-Reply-To: <20241024054639.GL1279924@google.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 24 Oct 2024 15:05:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CuNUKv2vEMzJA5dj5ZK6nyg5XBPy_EF3BdUON93TyfTw@mail.gmail.com>
Message-ID: <CAAFQd5CuNUKv2vEMzJA5dj5ZK6nyg5XBPy_EF3BdUON93TyfTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: venus: sync with threaded IRQ during inst destruction
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:46=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/10/24 14:18), Tomasz Figa wrote:
> > > @@ -1538,9 +1538,25 @@ static int venc_close(struct file *file)
> > >
> > >         venc_pm_get(inst);
> > >
> > > +       /*
> > > +        * First, remove the inst from the ->instances list, so that
> > > +        * to_instance() will return NULL.
> > > +        */
> > > +       hfi_session_destroy(inst);
> > > +       /*
> > > +        * Second, make sure we don't have IRQ/IRQ-thread currently r=
unning or
> > > +        * pending execution (disable_irq() calls synchronize_irq()),=
 which
> > > +        * can race with the inst destruction.
> > > +        */
> > > +       disable_irq(inst->core->irq);
> > > +       /*
> > > +        * Lastly, inst is gone from the core->instances list and we =
don't
> > > +        * have running/pending IRQ/IRQ-thread, proceed with the dest=
ruction
> > > +        */
> > > +       enable_irq(inst->core->irq);
> > > +
> >
> > Thanks a lot for looking into this. Wouldn't it be enough to just call
> > synchronize_irq() at this point, since the instance was removed from
> > the list already? I guess the question is if that's the only way the
> > interrupt handler can get hold of the instance.
>
> Good question.
>
> synchronize_irq() waits for IRQ-threads, so if inst is accessed only from
> IRQ-thread then we are fine.  If, however, inst is also accessed from har=
d
> IRQ, then synchronize_irq() won't work, I guess, because it doesn't wait
> for "in flight hard IRQs".  disable_irq() OTOH "waits for completion", so
> we cover in-flight hard IRQs too.

Looking at the code, synchronize_irq() internally also calls
synchronize_hardirq() and that in turn waits for the
IRQD_IRQ_INPROGESS flag to be cleared before returning [1]. The flag
is set by handle_irq_event() before most of the IRQ handling is run
and cleared at the end of the function [2], which makes me believe
that it would actually ensure all the hardirq and threaded IRQ
handlers would be waited for.

[1] https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/manage.c#L38
[2] https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/handle.c#L20=
2

Although I guess it would be the best if someone confirmed that,
because with all the IRQ handling complexities of SMP, nothing can be
certain today. :P

Best,
Tomasz

