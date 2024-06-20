Return-Path: <linux-kernel+bounces-222940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6042910A39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FEB1C2305A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669E1B0129;
	Thu, 20 Jun 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iybkP5VE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F871B0104;
	Thu, 20 Jun 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898184; cv=none; b=ZmKOH/ZL8Vr4wGj3MtkrP+dfPALuLmO1EuzSfbG0BD9P7/T1BqHVtNNhfo6WQKP+iGwXc8La+FTJXRGPaxtEzHCzy5VPVBHEhnWm+h16K0pJF5mHSGfgPFdhAkbg/d800fd1pBZGVjyRHZH0jMwHny2Wg2+pQshK2OkqCmLyCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898184; c=relaxed/simple;
	bh=cR6djxH09Ea4TNlofQrMPziUOAf3QcLsBQENcOtnsSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObRFSdObHSSksoyw3sYZIIYK96x9L2poYY+jFQ9Gdx+Ck50WogkAqpXhr/QvchO73WaIhhDz69Fk8FO621hMBcvPu48FPP13NZ3us/Cfk4du3SbND7LDt9eq3z7KA9Q3k3Aow1zuAaMIbE80B97bvDs4VPPtqgxMp2RW1+fyQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iybkP5VE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d10so8645465ad.1;
        Thu, 20 Jun 2024 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718898183; x=1719502983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6+cRiKVZO9FUYX5aSKkhl/XU8fhmFH+Uqj0NqNLjzY=;
        b=iybkP5VErJDvp8YUEywM0iMyyYzbrMq7J1A+zldcYVkEFB8QuQNK0wWkOnZ8vrdhwx
         mcWsMMqhY1CQuZlaEnEq1q0czgh2tjJNSaLZjXvWZeVMYbQs/KILA4ruuv7cmHuTCOi6
         u/L91FtxbydoyDXxWyEeXhYsIWMM4X8N6ZHeCEG9tBLXgSuWb6/6lk27wBTP691HGU+f
         r5iDKJwonLF/wEIcu4oyliQrPkx+3+rgTMAYS0O9h50ytn3tfSTABtLTrc09CZESapHl
         M8pBiJEqSmh0cPvcFR7mde0gjv+yZayhog5mlHfgPb0fSXj/32PeZB3s68NWAgfZ84S5
         vfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898183; x=1719502983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6+cRiKVZO9FUYX5aSKkhl/XU8fhmFH+Uqj0NqNLjzY=;
        b=gDFjLlEMhgHdCtpvetyC0afNurs4gvLeY9aW1rlNRX1lhzS4t62PxfJEpu2KbV5Fm5
         qydFRSjeTOjMjK0ydZry4ynbhow7SZwQT5D4KNGQ9P/h00FzcWCBoq0krC8gJKTBZlXz
         EyAdchPFwvvnRiHo0YeRguqxNrHJBFQCtPVzEHh2L36anLJ/DNdPwDipFCg7BINotFLU
         9HC32t3NTtPSBOYI1UaOrfL11e4MXWbHSW4IxvcOnnc2KSDoNKJfYyz99d4nEO1pbmlJ
         gdj0mohMNHAe2/bQlapH05D4ly39CkwgzRGehQVluVci+o2L/AwM+mUTBVB/lbVRFXla
         HGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVljZRRaFzUjd2FvoBbL2DPMHS0YW6EwQjGvdBI+XBs66A6+lSddKqpPWXyPTvYfnWlwEsUEhVfFLSOrT+IOPzwoLA2UNjG+cNPsJXUaJ3y5/3ZV8PnE0lFSAjvVqsWOP3VfKB6OXn4ulgFLkx9
X-Gm-Message-State: AOJu0Yz/6iHvR+1+WJ8jb/S19Yqmrfhw9ZgF5WMtz30s/nhojuEsT8kI
	eSrRmFLOn3sKbsUtJHI+r9g7OU8KQij7plTk20t0PfUk9U67s9HbrlP5EX8d3ayLEQc6NqqPezP
	jMXJ/EwpaJjbhhlmS/9OU67SJkMJNjQ==
X-Google-Smtp-Source: AGHT+IH/qGtmd25WWTOZkSnnwAfm5sy2oxl3ao2SCrYKmj2x13c+PTut6ES6liqOyIzzDab8A2DfeKmumSKaGaV3ZlQ=
X-Received: by 2002:a17:903:1cf:b0:1f9:8cd9:96c9 with SMTP id
 d9443c01a7336-1f9aa45a571mr60134705ad.46.1718898182576; Thu, 20 Jun 2024
 08:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10510733-a59a-4419-afb5-e75fdd802794@moroto.mountain>
In-Reply-To: <10510733-a59a-4419-afb5-e75fdd802794@moroto.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 11:42:51 -0400
Message-ID: <CADnq5_PsUNMG6FmH40fb_AetaGjhBf6S0Yd41ewAaai=eec_nQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/kfd: Add unlock() on error path to add_queue_mes()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yunxiang Li <Yunxiang.Li@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jun 20, 2024 at 5:07=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We recently added locking to add_queue_mes() but this error path was
> overlooked.  Add an unlock to the error path.
>
> Fixes: 1802b042a343 ("drm/amdgpu/kfd: remove is_hws_hang and is_resetting=
")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index d2fceb6f9802..4f48507418d2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -230,6 +230,7 @@ static int add_queue_mes(struct device_queue_manager =
*dqm, struct queue *q,
>         if (queue_type < 0) {
>                 dev_err(adev->dev, "Queue type not supported with MES, qu=
eue:%d\n",
>                         q->properties.type);
> +               up_read(&adev->reset_domain->sem);
>                 return -EINVAL;
>         }
>         queue_input.queue_type =3D (uint32_t)queue_type;
> --
> 2.43.0
>

