Return-Path: <linux-kernel+bounces-325970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28D976095
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C1B285387
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2018890A;
	Thu, 12 Sep 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSB+qi3N"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6722119
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120222; cv=none; b=lHO9+c0vQ6pGFY3qdYrxi+QBHahA44oULqhWvyfPTk+QSAvrrPWqcoCbAqcIEKxdC40nSRtLPLQ7I9Bs+OEwhMNaWsG4bLWqrKVOj0jbhTU7wUT8hjT7GrkYBF0YVHdRKBmIB8D50QqMEz09UPy1ehnPlHcQpf32lK/PH9kregY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120222; c=relaxed/simple;
	bh=jPagxh1QctUbn8z4DmD4MmtMBVYdURYELOaPTpUig0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awffclU91Lnojb0ER6P4ubbLy2aqU296olTYeH98y3hXuO+nu2NybDm8ec4OIV1z8P2rVEDKQ1mVw2x09r9E2omKPosAETKClPVY5PiCZ3YyeF+KzFFDq0TlMGZUgKvvCKka48v9+bAVkoMu3yxv+7qFZt6Avn3M5/LO0tZyW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSB+qi3N; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e1c8a6afa7so825339eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726120220; x=1726725020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw2u1x2ZsZhOm6grLl0lyn93jYQjPNNlRFvwR4K3Uk4=;
        b=sSB+qi3NXSwDXoG0SR45bQ2tRkh25L2gVVHibAGwKsX5aPwCU2YnV+Nelc26NkOcGx
         Nz/1mdVuSY6Z80V/KeoiRtVprfK313JldC9YFHuMEzYGj3gQi/LzAtM+wRFcNZHUUxnd
         09XAEYItslFgqjVBn9RWYUowFIVc/sqtIdvE1Sw4esTruw9gK58+bAzcvtCrvSnuWDRy
         2z+n0XNLNcviikCm8EyShbt5brqsB7t7fWi2kPpXTnkWv0ov02RaaM5T6vWeTOOyFZYT
         nQXmztFNtwfq4TjtE2km4kEAKsXUTnabTqV/td1HJNKMAYdKxUrILEQvsXsjMnSpUDhU
         cECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726120220; x=1726725020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw2u1x2ZsZhOm6grLl0lyn93jYQjPNNlRFvwR4K3Uk4=;
        b=R+y8bv83ech63A+s0XHw75VJ1XHK1Ku8oXbJR/wNzEe8gLSiLXqQ1aauqmqji3vOq7
         Ci6bnv4zGTLf8krsvApqagsHlAcBoriccF19YuYoNrygd07WcpdW6j84A42RtTNIRJ2f
         Hf7jbCCRpGswRgXaY9Lg8fA8wU/hOmhZO+DWh9FFz5YNyDVTUR6dENeJ1m1aBefmrMzI
         ZScBglTCiB8JQSVC99GUyau6wQfpgD5NGKGFFWs8h7eiZhZIVh4GgKXOzABGpK+8PANq
         zEOaIxanKxu8DIvkjDLqf7K68g/8YUiAw+6P9nEIjQkL/rdH4XQWb/X8bz0xznhAASv8
         KKrA==
X-Forwarded-Encrypted: i=1; AJvYcCX3eh5MsAHdAh+YtMoLlEZijJJ2551VlDuYCwrkj0396GJIP0pHNlcgO1LkL6XCjOzMxehlATT9dnz4VV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThuhImxvf7/eUhqOG8Y0ulqHz+W3/LDi8oQTtif42fnE5XoDH
	xWqeFk9l5mqBWf56ZnZUUW1JAwQ9Dzu7mMyOkIDbY6W9AyicabUST79WrNW7DQ5td6zuC9AeAy2
	XahB782TT4+gWL1qY3W5YVe+52ay9GH2jueGo9A==
X-Google-Smtp-Source: AGHT+IF34XxlusBtIC/EMndCmBpCudogBTcdy1u5SHEo3pqIrR4CkLbEeUU+WOFO7sk9XkhQbIGjSQEnEpjm+0ZsdyI=
X-Received: by 2002:a05:6871:3399:b0:277:ec3d:cd21 with SMTP id
 586e51a60fabf-27c3ea39800mr795369fac.13.1726120219645; Wed, 11 Sep 2024
 22:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 12 Sep 2024 07:50:08 +0200
Message-ID: <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
To: Rijo Thomas <Rijo-john.Thomas@amd.com>, Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace the custom approach with the %pUl printk() format specifier.
> No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tee/amdtee/core.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Thanks, the patch looks like a nice simplificatrion.

Rijo, Devaraj, does this work for you?

Cheers,
Jens

>
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index e487231d25dc..d3201eff1b74 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/uaccess.h>
>  #include <linux/firmware.h>
> +#include <linux/uuid.h>
>  #include "amdtee_private.h"
>  #include <linux/psp-tee.h>
>
> @@ -172,21 +173,11 @@ static int copy_ta_binary(struct tee_context *ctx, =
void *ptr, void **ta,
>  {
>         const struct firmware *fw;
>         char fw_name[TA_PATH_MAX];
> -       struct {
> -               u32 lo;
> -               u16 mid;
> -               u16 hi_ver;
> -               u8 seq_n[8];
> -       } *uuid =3D ptr;
>         int n, rc =3D 0;
> +       guid_t uuid;
>
> -       n =3D snprintf(fw_name, TA_PATH_MAX,
> -                    "%s/%08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.=
bin",
> -                    TA_LOAD_PATH, uuid->lo, uuid->mid, uuid->hi_ver,
> -                    uuid->seq_n[0], uuid->seq_n[1],
> -                    uuid->seq_n[2], uuid->seq_n[3],
> -                    uuid->seq_n[4], uuid->seq_n[5],
> -                    uuid->seq_n[6], uuid->seq_n[7]);
> +       import_guid(&uuid, ptr);
> +       n =3D snprintf(fw_name, TA_PATH_MAX, "%s/%pUl.bin", TA_LOAD_PATH,=
 &uuid);
>         if (n < 0 || n >=3D TA_PATH_MAX) {
>                 pr_err("failed to get firmware name\n");
>                 return -EINVAL;
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

