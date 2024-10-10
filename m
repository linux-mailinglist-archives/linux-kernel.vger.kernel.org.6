Return-Path: <linux-kernel+bounces-359318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B2998A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912F51C23BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81541E8830;
	Thu, 10 Oct 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAtfvM6K"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA51E7C24
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570739; cv=none; b=rop7uXWZ98eDZR8Fxft86W4rtgVW/BEUXNNemYSaquORk5bg+6SqVUvncdGY98ukXawmrzWituhT9n7Za5PTEPLx6NdA+lDKglSKWFJg9o5had/gk+9aFNdjSdvwvRmSc7xe+203uj32R/yTCoizBrTZL02yHkCorgnZ5W1dc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570739; c=relaxed/simple;
	bh=eXEcb+LttdGoqQbBLgSFIJSM93/M1T2H5gMKCsyKr3s=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=aA50PkwgipA8IEQqRjuMv5/gTxbqLss0QkBs8nBwFrSejmxADLgRsZIbOWgOGt4WAl3gDJ80hs740gV9K8Zqjnx9dmiCPhcnjx+AMQ09HeeqOg/er+cVWWgRGa89INer4CboqH32uVkuHDs12I7W8LwLYYhWTUKNGjPhHFdBxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAtfvM6K; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1223280f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570736; x=1729175536; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5BqFF1kShnLdfIkmmhnA62yxXMrCInucJIhLb6IgEoU=;
        b=CAtfvM6KOfNwSVZ4cED0GlOZes0hCpqXHMxipePy/lwG5B3PJtR234pCanhbRdNih2
         g9Tk0N7eDkhP8xefthuLAhXhjDd68J8JZcGh+1kOufE8wHoTOM+eXqj5DqnReG2b27/Q
         2mwrDL/1jbTuXznViYKtAPA9yACWH8L82MYIiYA55L7k+2T8ciEQtlwWZQTVeOTXtVyU
         NdoYkD5bkmwscVjrfWN4DQGhL6/YMAnTGLBpOvFPHoNzNydN+TLk1FzX4uqdFh+QDOdN
         0bABKRcnSrR5+hG4TZe7zDvWdJmJUMGeef2IBqEYibkDm8ZEvBH1Mwn6lBI2cFBcZkeh
         2orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570736; x=1729175536;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BqFF1kShnLdfIkmmhnA62yxXMrCInucJIhLb6IgEoU=;
        b=lh9xyjydcexE1UJXPKRLvTfNPxnio71uLv0REYvz/uG8aFYBUwthbCJ77I2hP3YGY7
         jkYaGtcb8FdxokqkpqLdK69DdYnwd8owj/+HXT4j2wYVmSqDkCh2XtAq9bx3Ppkaf6tW
         zOotPeBAyjJp37Sb0cWJRmzQNxJpXzezVj0X/p9wEuTu5pR+coMP09anuFfrA2K8AU2I
         pgHYcs8EISS9jpn1Xn0JWRFyDe+nbwhaEVsE4LpVPb+yiOytEvo4zVY1xFMtU2UjWsdC
         4gwxTUiN+sqLoSEZ4fWM4wQg6lRSutlv8LGKsP9NPKg9dirP1zAzo72GuneGktgvroS6
         4jOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCDY8qApXskm5w3QFtoIdiz2m08bRfEJrDwLPPcZFW+CaawxxBdDrXaOAcwaXkAPrj1fUU7n0qSEp555E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxC2y765JVHmQS09x0OjdbHU3X6sdsxxkpTYQqvmaxd1WUivTm
	j+VyGqwuguJTND42YDWI9atudCjwEVtwDqA5WJ8NTExbncuMb+/c
X-Google-Smtp-Source: AGHT+IFjCN7XMO8Qmt6W3DFGtzJZJ6QcZGFDSdosEG4Z+7DkJm/t4YcaTpuYGVnGjkZ2NRhvAH4Pww==
X-Received: by 2002:a5d:5c85:0:b0:374:adf1:9232 with SMTP id ffacd0b85a97d-37d4818f6e1mr2576759f8f.19.1728570735416;
        Thu, 10 Oct 2024 07:32:15 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a87bbsm1713289f8f.4.2024.10.10.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:32:14 -0700 (PDT)
Message-ID: <6707e56e.050a0220.140074.4dfc@mx.google.com>
X-Google-Original-Message-ID: <87cyk89ggi.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com,  aou@eecs.berkeley.edu,
  linux-kernel@vger.kernel.org,  jeremy.linton@arm.com,
  palmer@dabbelt.com,  cuiyunhui@bytedance.com,  sudeep.holla@arm.com,
  linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
In-Reply-To: <dfe6a69e-03e6-44ca-a801-9fcdfe4efb70@ghiti.fr> (Alexandre
	Ghiti's message of "Thu, 10 Oct 2024 14:29:39 +0200")
Organization: Linux Private Site
References: <20240913080053.36636-1-mikisabate@gmail.com>
	<66fa9afe.5d0a0220.323a97.bfb6@mx.google.com>
	<670535de.7b0a0220.311e0d.f680@mx.google.com>
	<dfe6a69e-03e6-44ca-a801-9fcdfe4efb70@ghiti.fr>
Date: Thu, 10 Oct 2024 16:32:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dj., d=E2=80=99oct. 10 2024, Alexandre Ghiti wrote:

> Hi Miquel,
>
> On 08/10/2024 15:38, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>> On dl., de set. 30 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>
>>> On dv., de set. 13 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>>
>>>> When populating cache leaves we previously fetched the CPU device node
>>>> at the very beginning. But when ACPI is enabled we go through a
>>>> specific branch which returns early and does not call 'of_node_put' for
>>>> the node that was acquired.
>>>>
>>>> Since we are not using a CPU device node for the ACPI code anyways, we
>>>> can simply move the initialization of it just passed the ACPI block, a=
nd
>>>> we are guaranteed to have an 'of_node_put' call for the acquired node.
>>>> This prevents a bad reference count of the CPU device node.
>>>>
>>>> Moreover, the previous function did not check for errors when acquiring
>>>> the device node, so a return -ENOENT has been added for that case.
>>>>
>>>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>>>> ---
>>>> I was wondering if this should also be sent to stable, but  I have not=
 seen
>>>> a report on it, and this is not responsible for an oops or anything li=
ke that.
>>>> So in the end I decided not to, but maybe you consider otherwise.
>>>>
>>>>   arch/riscv/kernel/cacheinfo.c | 7 +++++--
>>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachein=
fo.c
>>>> index d6c108c50cba..d32dfdba083e 100644
>>>> --- a/arch/riscv/kernel/cacheinfo.c
>>>> +++ b/arch/riscv/kernel/cacheinfo.c
>>>> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>>>>   {
>>>>   	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>>>>   	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
>>>> -	struct device_node *np =3D of_cpu_device_node_get(cpu);
>>>> -	struct device_node *prev =3D NULL;
>>>> +	struct device_node *np, *prev;
>>>>   	int levels =3D 1, level =3D 1;
>>>>
>>>>   	if (!acpi_disabled) {
>>>> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>>>>   		return 0;
>>>>   	}
>>>>
>>>> +	np =3D of_cpu_device_node_get(cpu);
>>>> +	if (!np)
>>>> +		return -ENOENT;
>>>> +
>>>>   	if (of_property_read_bool(np, "cache-size"))
>>>>   		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>>>>   	if (of_property_read_bool(np, "i-cache-size"))
>>> Gently ping :)
>>>
>>> Could you take a look at this fix?
>>>
>>> Thanks,
>>> Miquel
>> Hello,
>>
>> Would it make sense to have this fix for rc3?
>
>
> Sorry for the late response. It probably won't make it to rc3 but I'll ma=
ke sure
> it will in rc4 :)
>
> First:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> And it needs the following Fixes tag (but no need to send a new version, =
b4 will
> pick it up):
>
> Fixes: 604f32ea6909 ("riscv: cacheinfo: initialize cacheinfo's level and =
type
> from ACPI PPTT")
>
> And about ccing stable, I'm not sure what could be the impact of this bad
> reference count (some warnings could appear, etc...) so as it is a small =
patch,
> I think it's worth backporting to stable.
>
> Thanks,
>
> Alex
>
>
>>
>> Thanks,
>> Miquel
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

Nice, thank you!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmcH5W0VHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlxsgP/2MRJSAk0VX/i/9zIUWrYaAcS7jX
5pZRu4AgvEwQZNSAROxwl93Q2rchJ2wsvElMfhF71Yd2olLdlODvpkgi+l3xnF03
GxiV1Z6TuTy7mii2/5SPOq58DWq8UxSv6bHBRxDcLBKl2LFd4L/nkCECbDwXaW7w
zeqiGZ9pgAWi8GiC1UZSzcupt58jyHonuuFZy43b0JHEZyV7/gZCPefvVsv26bZh
ndhygpfuk6JxQaJ2CQXyCz88uO7ultRnb0NDPhT3pTAaiBuFyHdpqNYjPSRyN+tf
BO0X8pJJqOD1MUu7Xw8cpfMYslMs9jo3rLeq1+3n0H2OMlnySwHMkbgwFjWoR/8g
Ur/mlXOyuydTH67IfBdfxO/b+2utFfH64a08z5z9oD44E7W15IEq9bw5HXdPeIk/
b1bwNhG1R533Ys1seO2ZYDmXHKveo0s+tg1PR1CBx1EloqUrSdQwzXfiEIweeijI
YzMB17bsisRnAvCtAbNd+v0v89YMS/aBMNjr/YdGgFZg3qoMSWmRt9m0lyyLo5jg
AyLlyOcJiqD0B6o49RNGql5Qu/XgMThqQmhK+gm3YaiM1DWG/sRh6SULf2B4o+ld
RHLADEJyZWN5YBoy8MCs4PcRvhI0vquwUnTL6Mi5FFKLfTHraBfYwYqDp8Wfvrw8
rd9r+kMYU245MCh1
=dXUu
-----END PGP SIGNATURE-----
--=-=-=--

