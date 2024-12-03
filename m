Return-Path: <linux-kernel+bounces-428772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C79E1334
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F42282CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C78183CB0;
	Tue,  3 Dec 2024 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7DTYh0O"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4C166F1A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733206106; cv=none; b=TWaAUnCGc7SbJBRYFVrT/de70ZAmGWVeEQ+2Ux88XLnM8rQIs3pjdFtRg1yreupbHFXhvBb3fUWgcvbLG0gpKV2Y3QELq5TQL6W7MmuUHKK91eHbPT5Fu4vIVM1/NeQDaZ1rslZ6LMWy4+POyjd8Wcn4UgjwLQN17ra2oT9c4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733206106; c=relaxed/simple;
	bh=Hh6BAEouEDw0EPsrElNnkVGZN4MmNxeODjFaD0hUmjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNjnnxwkySN/ZnUNxwXhM1yaxawGcOW0H4RAM+kTT+D36KndWAu4DG3x9zUB8ucY0qfjf33BlBMUSJCeWaFElwnViXF4JWJKw7p/ySe4XqUnPfP8VzYkHc/cImQoMaZZqcVGnHpzGPpki77u82dyJAsy0sni5/qcPFGAjCbMiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7DTYh0O; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85bb7b18f76so407334241.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733206104; x=1733810904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5FWY0Nn/U1BbBcshrHCk7r8rsx81FA7skO7Jzi9rtY=;
        b=F7DTYh0OmVfi3TsCo8FCiulAgOrn9CXlWh61m7jWbeHniaSi6gbBNSwlSVL/+bfLzg
         GvHCFSv5GnysuQV2HbS4JKnu4wU7IZ3dFVFuZVMB5VWsBEStHNzP/dyM5blfP9WED9Pf
         wbrSTHqmdBDQI4vAJs+3vIkfCrhNECqFDmGur6lQKLneHbrIl0bD3srnmaRzBQPi4phs
         OeFzUpUJ/FHIlzQzMwEWhOkh7X7/5cSVXVAO2LZtd8aHqvhuf8sEffuLiVbN/p2gBKMz
         tEQvLK1CR0yjatHUIyAlWst9RhshT/B4U4lRjDRjGtWLW20oNh7Zc/bIoDFfw4BQnkHz
         MP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733206104; x=1733810904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5FWY0Nn/U1BbBcshrHCk7r8rsx81FA7skO7Jzi9rtY=;
        b=WuymmP+lcDeRlwgKw596/IANmvDlJTAIM/QJCrqWEjtAij8XwJCn5BCyBy6dUi3BMh
         WMwLq3Aw0oIT4XT9OAzp9rv0E9IVZufKpzfjjFaOkera/AWQCsLjYmtlbaWqr0ESnbR3
         Xcyz0pxwhDDJ1xTqzfIVcVTgvyosp5H5/pmB+eX/uxP9XllCxP8O8iTgoDESfAmjqJPu
         eRP3XzzIrVfa/XomN0DeGHloSPegBGkYileQUSVPmAkJhE59OtII/KfT7LhKyH3ZbL3R
         4eq+DTrFb9R6hUmSELU+51QEMNUazH3z/9mBSfwB8AkAmskhcfVsBIf0xvQrTXEwdS+B
         0TTw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YGveTFe9LIMyjY1Ed6JHiqSlkn2ji9By1jlF/TNCqXS43TKE/2pjSzrwmukVRSnY3Z8j49J/VzUU/KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTL6GDOwjORiay++eWj4ghxWB+ZGoVjowwYeSIMK2Sio+Wavu
	DZar/Q5tH/JO7B9GqkpuAmyMqZDwD75ggz+spXLAsRv9o2Mo8aKQCPdp+h3r5Tpxr9sWT+gj615
	lJTOknnP1bZeAcSU1E1Y62AD6bwrFzBh+v90CHg==
X-Gm-Gg: ASbGnctWVS5HmenvDITz+iwHJs8QwrdZlfSQmhqAnCqH1Te8nERNBDAE3SBqvFdkhla
	RgDkfrV08TglENJmef7tRjLQ55Qj78rxu5g==
X-Google-Smtp-Source: AGHT+IHkmC1uBpmNQgy2m3DIPWz8teYLuBF5jLIR+q8V9HX9PWb3cjGJT+Mt12Y/NruuNCCXZcbmJMLiR/v/cOksrnk=
X-Received: by 2002:a05:6102:304e:b0:4af:4eda:9957 with SMTP id
 ada2fe7eead31-4af97251baemr1973748137.18.1733206104151; Mon, 02 Dec 2024
 22:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
In-Reply-To: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 3 Dec 2024 11:38:13 +0530
Message-ID: <CAFA6WYP+x41pZ8s3NN+MwA135ELJMBDkMrffjX4LaN4vpunsqg@mail.gmail.com>
Subject: Re: [PATCH] optee: fix format string for printing optee build_id
To: Sahil Malhotra <sahil.malhotra@nxp.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Varun Sethi <V.Sethi@nxp.com>, 
	Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 17:17, Sahil Malhotra <sahil.malhotra@nxp.com> wrote:
>
> There has been a recent change in OP-TEE to print 8 and 16 character
> commit id for 32bit and 64bit architecture respectively.
> In case if commit id is starting with 0 like 04d1c612ec7beaede073b8c
> it is printing revision as below removing leading 0
> "optee: revision 4.4 (4d1c612ec7beaed)"
>
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e9456e3e74cc..eb51dc18f32d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>                   &res.smccc);
>
>         if (res.result.build_id)
> -               pr_info("revision %lu.%lu (%08lx)", res.result.major,
> -                       res.result.minor, res.result.build_id);
> +               pr_info("revision %lu.%lu (%0*lx)", res.result.major,
> +                       res.result.minor, (int)sizeof(res.result.build_id) * 2,
> +                       res.result.build_id);
>         else
>                 pr_info("revision %lu.%lu", res.result.major, res.result.minor);
>  }
> --
> 2.34.1
>

