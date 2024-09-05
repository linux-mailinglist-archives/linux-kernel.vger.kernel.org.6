Return-Path: <linux-kernel+bounces-317230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5596DB30
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759821F27DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26319DFB9;
	Thu,  5 Sep 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtfVPB/r"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0F19DF4D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545349; cv=none; b=tPO/jW9Gpud8J8OBFCu1dI9QN/Axd04rVcnazYWTAPc3lcEPEgHCOH2qe8dCBHUjVsJ/vZQWEwm9Cmrp/a8A4SOGMMoeyaumY+pYkVyo8kbBQcuDBFoW3nyy/mJBIkgdeBBWwtiVPEEfteEV5MBQVCqklVsas7b0+3nOz3+/Oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545349; c=relaxed/simple;
	bh=hFvMxZCQz/tWSset+2x3kNBjfNOP5shqepNlxBFkZac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrsSo3HmLxkWTOASJ7b/DOliAZhmf0hG7tuTcoYOO/FhtIQzJRz7Sjcsgw86ErjffCHQuHUNnRgvLOnev16jb6F5BTUPfSBhH2B2voW0jJ5qaYbhxDYEfzpCqUkIAj4cg/QTv/ZCoTAH6Hjr8Yfz+y1hmorWuc7dO6d3I/qD1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtfVPB/r; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5dfad5a9c21so508156eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725545346; x=1726150146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GIQ46mGPoVEaUozNTovEf5oq81WmVNnl7zcm9ZEhzU=;
        b=TtfVPB/reU8FpDvkIHPSZjbpsqVurZ5CSMoyj3j2W7mxVmW4+vezmtYw8TGWWGHQi0
         yAd5ahoE0mqn7Ot+dVzU3LVsIlXKwpKwTL1phCw4MJxPxY9tMDbtBSASd7f94OcrFCqY
         At3JG3HnDAbITsiU4toTX7oU0OpzuUx94HCsoMFeLB7R3XYHkT8zXEM59SMvPILuZ5dc
         ulm5fRXT4ubKjtqFnytH/bPN1P371PlnRkw6+lqnSawK1cRZDXQQYaPQgAw8cef48EXB
         I81+aa2AVTQP2AHWJYciOVjXktZVN4x5oBN8BrV5NFQfPCQ7XFBV5BDSrQh30Pmq+pkS
         L0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545346; x=1726150146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GIQ46mGPoVEaUozNTovEf5oq81WmVNnl7zcm9ZEhzU=;
        b=COshCgc+DCpYubfKlOjGFALFLuKUcfqK8SbXT0RbxRKzFgBkGgjYxpHAUu8kkKIQz8
         ZmxfJvShDqq4x1+SL3spmf294WHqoeV//h+IpzZIliEA0+YSEMia8GhwSlkX4yBMjBxP
         esUwCFbR9S3h4IHHWforipQSzPSxq1ooiCzafNxxvc0TwuFMe3Ip67N6vMw7D+C7TmIE
         1NDgTSJrF8MTewfItOa3m9JIUMC1I+TWzctsjEdj3yicmXKbYEdzNKBBRARgsZRvWAwP
         /zIQec4d9o0P21+p68N4GcJWV3X03dxNSADe8NlyL1kAWf56DkWdapB/3HO7SwRHaYc8
         TOSg==
X-Forwarded-Encrypted: i=1; AJvYcCVaMgU+Pt/5/QgGjXCvFccB96RidvME3JBp9QRYC9tx6u+K2Bn9G+U3WMKAl45eyMMTZp0LHPHBgmNfLTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcS11eYtpVDikEpgtGDAvgpz7KtOy01PFmdgQiB/tYtaKmtkDj
	hikpio8h3iGojPZ/CNV+5NMpp4Gacb4Pe5qVs+VvQVDUat11W3VtNJemeqHBqHFoEQX69NOst5u
	3TItReOEjv/VDY9EjYQ12WGcPBXCCar/ATmHJBg==
X-Google-Smtp-Source: AGHT+IEeD6bM1S0y5bTDpYm6UGEe0nFuVGedJfI98Z9M4R/H0XdQi2pU0eCPaMGAiK6Jh+t3PwlhHpYhET8BikNE/1I=
X-Received: by 2002:a05:6870:724a:b0:270:1498:6a36 with SMTP id
 586e51a60fabf-27790167a0emr26390991fac.29.1725545346287; Thu, 05 Sep 2024
 07:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8c12aed-b5d1-4522-bf95-622b8569706d@stanley.mountain>
In-Reply-To: <f8c12aed-b5d1-4522-bf95-622b8569706d@stanley.mountain>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 5 Sep 2024 16:08:54 +0200
Message-ID: <CAHUa44H4XHOxn_=TxTUM=S6oqUNL6-kVVU2=jFPZyobzmtbQPg@mail.gmail.com>
Subject: Re: [PATCH next] optee: Fix a NULL vs IS_ERR() check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 3:17=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The tee_shm_get_va() function never returns NULL, it returns error
> pointers.  Update the check to match.
>
> Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/tee/optee/rpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index a4b49fd1d46d..ebbbd42b0e3e 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -332,7 +332,7 @@ static void handle_rpc_func_rpmb_probe_next(struct te=
e_context *ctx,
>         }
>         buf =3D tee_shm_get_va(params[1].u.memref.shm,
>                              params[1].u.memref.shm_offs);
> -       if (!buf) {
> +       if (IS_ERR(buf)) {
>                 arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
>                 return;
>         }
> --
> 2.45.2
>

Good catch.
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Ulf, this is a fix for a patch in your next tree so if you could pick
up this patch, please.

Thanks,
Jens

