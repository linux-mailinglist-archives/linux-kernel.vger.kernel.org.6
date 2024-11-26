Return-Path: <linux-kernel+bounces-422785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910999D9E20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5339E283D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8331DE4FF;
	Tue, 26 Nov 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwrCHZsv"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15C28689
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650983; cv=none; b=VfxItLb5L/65pWB4mKZeY8B5FIIbPqieJbIacgpYWAGl4QWHsauw7byyMM2ScK8zmemP4LajJJt4fOBuebTXTNURYOkCVrT57KeqxaShMFPsxvH3q7tDFHwJ14v4fSv0YO5WDqSwToBNuDoqHpX1thPARr+wNtPCVexrHtBVZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650983; c=relaxed/simple;
	bh=CnPyU878cAd2q7CiM36at45iid2quIRMW89B75UPW4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNisNbtgnD6iL1Om/7j6C49wuHI2u4XS/qx56HBtOE/rusI/unQvn5Z650e+nAkORcKJGb+NItdmDU4KW4hks9U0ldd3o06xvI0VKvzAyLQuWqnjhAfO3EuDLrIE8P5AkvA6EAmf6QasOuRZOwoY2lk3mftxjQ59eGHcOltfsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwrCHZsv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffd4c03a32so3746841fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732650980; x=1733255780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAXLnsJ9MnYPTn/qVkCr7dLpK+5QPdDJCLD6D2e1H24=;
        b=GwrCHZsvZFnohRN06XoP0c1Y1+4hb2aMBBEQz8vq/7etOzcc4aqwXyw5NU778Bmled
         BFxptcUDYg9U83m0asq0GEQ5WBtj+LeTXI69CR/bu6zG2ZHjUDFcy1ep0Nfa4FnX2P69
         J2mShOV87chCMbZVw9HQ2YNSQ5YYndv8mTnfOon/0Rp8nu1qFZiheS1TfTnZguB4q0mG
         3q9l5jOFy55+iJvFl0P7d2WTWECMTUIu2jQ8lhgwjVD027K7IGF3iNKQTrogbVe+LD8g
         hk7UueVeN3x+pnLT4HhRzgsXOpAQHK4edLUUIHIY8a7FIJvtol8URVrGdtvGXybhf9/h
         pNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732650980; x=1733255780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAXLnsJ9MnYPTn/qVkCr7dLpK+5QPdDJCLD6D2e1H24=;
        b=xA+LR5kh1JEixLM0kHJN097nA8RsaIJ4EFnSd630xgIM6FoeZHNupYcjrmnjmq9emd
         vl5vcNJAVpMnhVgToHloW6h/CJ8EfdSw9tydJhtMlqfToDsVJ9n3waGG55e+PvEAFEwd
         Io69Lk6A+pv5PHJ30l+Z/4202TbAiuO/qpwq98K6dMIuQLhK85/5iOBrq0WbR6Ct9lVn
         pEgT7meaBuHQcBCJnhX/FQXP1U04v3gRjaXOjB4c5WFlKIsNEZxfET5h0xEdFcLkr99H
         7uQeUv509CCuHN1VrVrDXc9I2IzciaYTkyKXDq0ImUq+LRD70jJjE3dAsy/xRs859pQE
         V1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXJLTB5pjll3noNOdt1CYXa0qX7ejD2C+H05ZWszc5tzbXfEehYGCLs3ygelbTVfqfSu7anmPNra3V/T6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoG3TmHUhEsez8e2SgHtFINcD9xw3xymMQmq3OQ46tymZtTOW
	agyAVPeJYSyDSmyy90JOen+LLJHUFXu0lnhMSV6jp4zEeTuIs37JpqkNQFBOtopDcKEifl6f38+
	pyrFkBIDQj+HPb0AQmBdG0+uuwEk=
X-Gm-Gg: ASbGnctHxQMPwO+X0dHPXC4/oMfmXXLZTUxVSdKfmja1aGcG28ufNkcoi9Ffzl3u7En
	EjB7qFwKo2ZjTeSSsyU322g1HGSLh8m53oUe6vHaCY1YPZrIphSFO+dH7Ecl6
X-Google-Smtp-Source: AGHT+IHi2viNGov/xAOg7tpvDDkEV2owpY41NuPUMpQ26y5S2VsCewxUWleNfs91G5yA6IaVNhsUcEKTvMZUQaAAVq8=
X-Received: by 2002:a05:651c:502:b0:2ff:c016:f293 with SMTP id
 38308e7fff4ca-2ffd5fffcb5mr1895361fa.15.1732650979492; Tue, 26 Nov 2024
 11:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119153941.8307-1-advaitdhamorikar@gmail.com>
In-Reply-To: <20241119153941.8307-1-advaitdhamorikar@gmail.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Wed, 27 Nov 2024 01:26:08 +0530
Message-ID: <CAJ7bepJ9vd8s4Yd+HpvGyZG3PE8oK8YPMFxtkPRO-W-t-Pe63Q@mail.gmail.com>
Subject: Re: [PATCH-next] i3c: master: Fix potentially uninit variable
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would really appreciate it if I could get some feedback on this patch,
I would like to know if this approach is the right way to proceed.

Thanks and regards,
Advait

On Tue, 19 Nov 2024 at 21:09, Advait Dhamorikar
<advaitdhamorikar@gmail.com> wrote:
>
> devinfo is uninitialized if the condition is not satisfied,
> add an else condition to prevent unexpected behaviour.
>
> The variable will contain an arbitrary value left from earlier
> computations in `i3c_device_uevent`.
>
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>  drivers/i3c/master.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 42310c9a00c2..7594d3793eb0 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -284,6 +284,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
>
>         if (i3cdev->desc)
>                 devinfo = i3cdev->desc->info;
> +       else
> +               return -ENODEV;
>         manuf = I3C_PID_MANUF_ID(devinfo.pid);
>         part = I3C_PID_PART_ID(devinfo.pid);
>         ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> --
> 2.34.1
>

