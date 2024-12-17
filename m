Return-Path: <linux-kernel+bounces-449936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789429F5859
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CF1892E10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CCF1F9415;
	Tue, 17 Dec 2024 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgDm9/xl"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD08208CA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469577; cv=none; b=SU7bkqLU6XyGG1n4Ra7t+HuWzL5wYZbgH2k3ZY676U+RgzolE8BFr38VijOntEBZc15SMvtbtVi4VTAqTnygX2mhFpYTF3FVGR8sujN76yCiAXbyP9KTy/Cm2nPy/LQVlUGGFkzVsMlRy6rz+jd/+V6VztRFXxVTkqKfc1y/Czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469577; c=relaxed/simple;
	bh=6qlXxJi3agOUwBKNi/u3zqvbXW1tDjFWCw2pIu/MgMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppS0hyIBTLivjgTkCCf/ja8JWPvaqqldOuWaKJr3tNc01TORZYRVdlMaNeGiVy7ALViaD71V8jRONIBInrGHLSHH6OXndY+YCOVTPNn1SNwV1DJvXqMfmnYVI3t1MTM4FozffiThkPP3FWAwT0n/hQCWyDUT5zZeam8dGh984Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgDm9/xl; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e63e5c0c50so76755b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734469573; x=1735074373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cflQO+toJDY4hL9E804PbdzjCkRBwT2MAiPv73joRis=;
        b=cgDm9/xl1DVA82t4NDk4MmjasHUNL2h71eBvdwD+1qzwfiWvFt3t1J+thWcNIgdDvq
         gqfQFEJRgBUb7D4fB13NMD2FR7+PJDse410xdXIoi83ScDwjCIxjCOV6TbMRmM9EwC2c
         I0X6aWVJFHvII0bXm8uc+31OZ0Ys4/MIYK51gneMl5FcXjaPgbdhWCvErd/E5eHlKa5d
         CfItYNuaYXMBqK8DTJYmehRmgsITqDR0b6EEdN0C1BWhEgZKRIU8uXst1lgeMyBMZ+3D
         k70z2tN620KTPuHwfaBPwFNZCWxAh/L5bifS3UYufxZWcQY3xbXCEBVMGUmRIXRIzxwk
         j2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469573; x=1735074373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cflQO+toJDY4hL9E804PbdzjCkRBwT2MAiPv73joRis=;
        b=C/nne5WDfAq9bUEPixoTs/Hobwui1hoyrwGYEDklhIZQW3cUEv45yKqU7aM6efwt3d
         rEH51MeexrTgFc0Sqg1ZRjFmAXgAx6aSaEHn6EXbYZLTa04Sc0Xne3Fx2MMhJfJTsFGo
         dcLbM7qu2XvHdTJQj8KGXBizFS/Bf3szjtW2Xoqlm2/JMEeYUy/4MCFmZuZsS+IdYk72
         /ANu/DIgviCutL/D9e/zr+6RQckpoEn6vMdIV434wGEbj2vbe07/javp0Xzo7cTmj5z0
         +C3kohypwcs4k7dPoSWA+IF0qf4n8xCjUyk76ck+PIojVw571u3gjk+tBZRKwweYENSw
         uScQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAexYOyPHV7gxlJFskO6/MsUu0Yaj7vJP6UfqlDhrM7WwX09rFCLxNXmJkZtSrCaSujDijGzI5xCvhdEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykquq25EN67gl7RtwADs1KbcY1b21wp7uVU6boXWimS4xLov+a
	nCPI5gkLeUFYU2O4g/kiEpb7HsGxiHo2riFaF+C9pCz5IOf+itpbhXsJuBy2/k0kFZUGBlPzmlQ
	5hwg9c2La7iGwF0TcZQrQD+k5gCT2Z4yiqY7wYw==
X-Gm-Gg: ASbGncvhOJkrrsp19VVmpswojIcrJBZgyPKPnw8WMGWsBBtmDs9jF/xef25XrptIaqE
	Vw2X3eh4iy2toXnRddAGVqIWDCsg5IeP5Or5EQwc=
X-Google-Smtp-Source: AGHT+IHoNBzN07EMubEL5yr8JsuPWWxFWP29/+5ADp8df0GmbrKqqjNXb1yFwWz7DGy3Pl8z52M6hKxMOqCTF42Hues=
X-Received: by 2002:a05:6808:1982:b0:3eb:5547:b9b with SMTP id
 5614622812f47-3ebcb3d3ff0mr2285990b6e.16.1734469573393; Tue, 17 Dec 2024
 13:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
In-Reply-To: <20241129114648.3048941-1-sahil.malhotra@nxp.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 17 Dec 2024 22:06:02 +0100
Message-ID: <CAHUa44Gs8T+hxkmVr2ap-HKB9QHkPB14-O2S6BvLrkEhP-Rw9Q@mail.gmail.com>
Subject: Re: [PATCH] optee: fix format string for printing optee build_id
To: Sahil Malhotra <sahil.malhotra@nxp.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Varun Sethi <V.Sethi@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Aisheng Dong <aisheng.dong@nxp.com>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sahil,

On Fri, Nov 29, 2024 at 12:46=E2=80=AFPM Sahil Malhotra <sahil.malhotra@nxp=
.com> wrote:
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

I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e9456e3e74cc..eb51dc18f32d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1272,8 +1272,9 @@ static void optee_msg_get_os_revision(optee_invoke_=
fn *invoke_fn)
>                   &res.smccc);
>
>         if (res.result.build_id)
> -               pr_info("revision %lu.%lu (%08lx)", res.result.major,
> -                       res.result.minor, res.result.build_id);
> +               pr_info("revision %lu.%lu (%0*lx)", res.result.major,
> +                       res.result.minor, (int)sizeof(res.result.build_id=
) * 2,
> +                       res.result.build_id);
>         else
>                 pr_info("revision %lu.%lu", res.result.major, res.result.=
minor);
>  }
> --
> 2.34.1
>

