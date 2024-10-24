Return-Path: <linux-kernel+bounces-379200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497139ADB59
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B80282000
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACA171675;
	Thu, 24 Oct 2024 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+LcUAIy"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BC1714C9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747136; cv=none; b=m+nNsvPy0wz2WBP5UhCps5BBBuRA5Oeua+YA4+9yjPRn/PKRMLyMS8WvZLPch2vK3KYoXaQaMyGgmSgnZY9zdnFj2AsF5z0W1OLbDCOsiY+7xkmPTMbr3PQxn9RTGb0QmAV43Ifa4oyVK1/r+dej09y1PQRRWB8abxXJo625izg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747136; c=relaxed/simple;
	bh=4wryGJdPZPSgiK9KfM5uPcYoI+0WvBG8ErZbhqowjLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ/mwhLTtvATMw0yPl25Qa4t2b1mATEtjWne6mzuxfQJOPG9apHFjS4/lBbCUAI2waP31gK9VEqVVY4rcDp+gzZeeK7QNPlCU5fu0sv+eBqoZK7TqcLZFte0NDGZhxX681R81fw7qaA3aGhuCEM8f0OeUhKySs22WuY7l1i0M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R+LcUAIy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bb39d97d1so3365935ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729747133; x=1730351933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jKEg2243kXoC9Im0p/j3HIvMls8ifezUgEQW9hAaE4=;
        b=R+LcUAIyUtaNdl/QlPcyqdxcdcD4lIcg8ck9tBxfctaLLz6X5ZVVbvz9mUQzHf1haN
         EwvOqFKk/47cK72trD6dvS33mVfyvQywMOB8657Lky/lfPMIKekP8iTE2uHLQIlZFkm1
         A5vzzcyyXmZIbLPpodG3CaS9/sjKY9TbMQrzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729747133; x=1730351933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jKEg2243kXoC9Im0p/j3HIvMls8ifezUgEQW9hAaE4=;
        b=sU5POHKMxcmAPumgHs1ygaBLx0Hd7yPmnsHOMM4ElaAsfeEwhrZUCwkY/fnLkfnoze
         fyvTYMk3W67wXVrHvf7xwdEOdR9Mbuf/F4E754CC9Ub7rkbUXftG1lfXm66NaNfy39AW
         nbtk83IJbD9+ZFFuyBSwFqscC/Kyi7Ov3iYyGD1LWNZ50B5bhNJwI+59+6WlzP4ilNmI
         lj5opW0mRpYg9/VKjfoM6HJVlWQJZlsIkEbT2xNVmMu0yjqJl50svxFTmB+HZ86FkZCB
         Uwx2ydpdhPLoIVz1LHqRUTv0IdVSAegi/CPAb6fLc6kOnk5zT9PlOD92F4dUn/nu+Wkt
         GbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+ew3Bf2xt+UiecRikJoCNs1wYh+RG/nCKWmqFrF/s06a/2ZfQ1WX/pEPZ/tFCIS1JWPCmQuCYTLHM43c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkZqrvjm769hr/29wffveOxnY0XLMVCpJ2vnWpqSaOjchCJoK
	b+TdNqjBiMJ9BeajpjqsDSBM9/0O6GcMBS6pI8F/sv4coJi7xxLssLmrso9JuMEiTaXD1WLwyBQ
	=
X-Google-Smtp-Source: AGHT+IEQv4YCgzeDGQJKN5wO/d3Vg2tYw1rW3vllVltis4r1knqJO1y70vEU5N4fss4f72sN4mUjig==
X-Received: by 2002:a17:902:d510:b0:20c:f648:e39e with SMTP id d9443c01a7336-20fa9ea9470mr55471075ad.58.1729747133039;
        Wed, 23 Oct 2024 22:18:53 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee8a1bsm65527635ad.61.2024.10.23.22.18.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 22:18:52 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso37585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:18:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVv2mWZ+HbVy9g0DGRITdiRXQfGSGr3DFe1Z6fN17DiPIYWPP6KJIkJX6F3uW8ZcGlcTTcJmHcLeS7DBY=@vger.kernel.org
X-Received: by 2002:a17:902:ce8f:b0:20b:6c3c:d495 with SMTP id
 d9443c01a7336-20fb78490b9mr1168895ad.25.1729747131720; Wed, 23 Oct 2024
 22:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023052444.139356-1-senozhatsky@chromium.org>
 <20241023052444.139356-3-senozhatsky@chromium.org> <20241024045836.GJ1279924@google.com>
 <20241024051335.GK1279924@google.com>
In-Reply-To: <20241024051335.GK1279924@google.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 24 Oct 2024 14:18:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5ACxz-3icNH_CwWxWj5OyKdg89mOkNadYKa=YTVDRYRLg@mail.gmail.com>
Message-ID: <CAAFQd5ACxz-3icNH_CwWxWj5OyKdg89mOkNadYKa=YTVDRYRLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: venus: sync with threaded IRQ during inst destruction
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Thu, Oct 24, 2024 at 2:13=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/10/24 13:58), Sergey Senozhatsky wrote:
> > Date: Thu, 24 Oct 2024 13:58:36 +0900
> > From: Sergey Senozhatsky <senozhatsky@chromium.org>
> > To: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia
> >  <quic_vgarodia@quicinc.com>, Bryan O'Donoghue
> >  <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
> >  linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/2] media: venus: sync with threaded IRQ during in=
st
> >  destruction
> > Message-ID: <20241024045836.GJ1279924@google.com>
> >
> > On (24/10/23 14:24), Sergey Senozhatsky wrote:
> > > Guard inst destruction (both dec and enc) with hard and threaded
> > > IRQ synchronization.
> >
> > Folks, please ignore this patch.   Stand by for v2.
>
> I think it probably should be something like this (both for dec and
> enc).
>
> ---
>
> @@ -1538,9 +1538,25 @@ static int venc_close(struct file *file)
>
>         venc_pm_get(inst);
>
> +       /*
> +        * First, remove the inst from the ->instances list, so that
> +        * to_instance() will return NULL.
> +        */
> +       hfi_session_destroy(inst);
> +       /*
> +        * Second, make sure we don't have IRQ/IRQ-thread currently runni=
ng or
> +        * pending execution (disable_irq() calls synchronize_irq()), whi=
ch
> +        * can race with the inst destruction.
> +        */
> +       disable_irq(inst->core->irq);
> +       /*
> +        * Lastly, inst is gone from the core->instances list and we don'=
t
> +        * have running/pending IRQ/IRQ-thread, proceed with the destruct=
ion
> +        */
> +       enable_irq(inst->core->irq);
> +

Thanks a lot for looking into this. Wouldn't it be enough to just call
synchronize_irq() at this point, since the instance was removed from
the list already? I guess the question is if that's the only way the
interrupt handler can get hold of the instance.

Best,
Tomasz

>         v4l2_m2m_ctx_release(inst->m2m_ctx);
>         v4l2_m2m_release(inst->m2m_dev);
> -       hfi_session_destroy(inst);
>         v4l2_fh_del(&inst->fh);
>         v4l2_fh_exit(&inst->fh);
>         venc_ctrl_deinit(inst);
>

