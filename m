Return-Path: <linux-kernel+bounces-344014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12B98A29B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B34281EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA1C18BBBC;
	Mon, 30 Sep 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7it3cO5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB51714AF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699715; cv=none; b=VsP7RWGDw6ZG/IZtj2gGzVMpdsq5sYHits9NdaNjl0ZVlnuIUNoDnR+VpXyrizz3a1U26WbINL+cjLDhUDQF9e6/tGKtrCaM0r6F75u8g/ulVeRJXeD9xPRn/i3ORUgkSbj5VrhFQHpfQSHPIr/923AQ4rF/+GmnoPdF5I1DQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699715; c=relaxed/simple;
	bh=s/C80ZXJauu5ob0se426wPrjjK3UFLyWPt94kwIqKi4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Ykcsk621K3JPh0FhEmAY11DtQRVbaATfoxq/ZDTnQanRbje6MoVkSHu2SK1InrhBzjXdSm+FMax2aKXj9yZOywqXVSJ037rSCbtGAk+wyrM54wIoOV+0mstDdAoVBuZqxMD6tUHGbVcgTxkqITyE14QTqC6OgDk8xnXrT5a4EmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7it3cO5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso1223692f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699712; x=1728304512; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OGgx2QXm49+i80fK6ZIYDqvCO84UtWAPd1Twn8qWUeQ=;
        b=G7it3cO5Q6N/PKldPWZ+IIk+NEcO/96CNUOo2ZUyCJHo8x2kRvIIKS4vEeosfiIX8p
         hQ79Vd5WV6uz9LB8HFBH0WpQXHSYQRwB+LkBD/RS06HiNdCB+J251+jotvNzCohVCPDW
         8Us6S0snZEkIC1B7WGOiKw/kBvPADqPw5abP9/RigO5MiV+BioWCfTtfMojoF3nzWQRV
         avq68D+aeNe0CZ6XGTCFR0raotboUWA+xgbl4YNsitsDA5F4TQIcwJwYGACvkcvUIMyx
         46/U6xsmErNjy1o3JoWblZnj3+gipUbdoqwa/DcBwOFvDe0nuxKpJtiECbfX1YQ/ukW/
         GMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699712; x=1728304512;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGgx2QXm49+i80fK6ZIYDqvCO84UtWAPd1Twn8qWUeQ=;
        b=OH/NvtjYrrq7N+vHGI2ToYEt0AraPSaW/feGfM7j/Bl3tKl6vExI73RAJgewqpEmQX
         Q+BY+WAP6UBmoHmPmdUV9VI+sU91Oke3D3Os+UUhzcJNUxJIXmfWhMmcjQxYIo3NRqit
         2Y5/UerXwukoJUQpSNApHN8NrflKKoKKBzxA5APK/zIO0WEHg29ZOuTRkqjWy1LY6ViG
         8EnTCnV7AgG1uHuBNb+/t2Z0KjFOwjEO9Lj2qjoK+nFBeGjQ9ZEVGQYqIPoAFRT0u7+H
         dM/4oC6CXZyaR0+YzMjHoPTob3RGCv4nE34aYRhQxCCPfFQTYEpIz67RVpsFHM65Q3OM
         87iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg47DLk/zAxntPUwBUSkNgSz73WKFVuvLgbZafi2gmlVgVfmPcugzFRYNW1el8HxgMvyU15MDDAqcvviM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZVazhSAuRXOxn8zvXjeFyK44w4pSmtiOR68DbXN40vOqRm3Z
	xiB/mfJj/kkb3z6Rj38hH1RrRqXJ7Ymliwhy1QSQhg+9zovE7p7T
X-Google-Smtp-Source: AGHT+IGdxnRytaWoXEmdGqzTGQEIqbuCAatF9kA3GstJSTZy0Po9aooxiBqYhVWD0jF4P2dPbGYMew==
X-Received: by 2002:adf:cd07:0:b0:37c:d20d:447e with SMTP id ffacd0b85a97d-37cd5a81f7emr5754201f8f.21.1727699711355;
        Mon, 30 Sep 2024 05:35:11 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575dd04sm8940397f8f.114.2024.09.30.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:35:10 -0700 (PDT)
Message-ID: <66fa9afe.5d0a0220.323a97.bfb6@mx.google.com>
X-Google-Original-Message-ID: <87sethpbeu.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,  aou@eecs.berkeley.edu,  cuiyunhui@bytedance.com,
  sudeep.holla@arm.com,  jeremy.linton@arm.com,  sunilvl@ventanamicro.com,
  linux-riscv@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
In-Reply-To: <20240913080053.36636-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Fri, 13 Sep 2024
 10:00:52 +0200")
Organization: Linux Private Site
References: <20240913080053.36636-1-mikisabate@gmail.com>
Date: Mon, 30 Sep 2024 14:35:05 +0200
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

On dv., de set. 13 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> When populating cache leaves we previously fetched the CPU device node
> at the very beginning. But when ACPI is enabled we go through a
> specific branch which returns early and does not call 'of_node_put' for
> the node that was acquired.
>
> Since we are not using a CPU device node for the ACPI code anyways, we
> can simply move the initialization of it just passed the ACPI block, and
> we are guaranteed to have an 'of_node_put' call for the acquired node.
> This prevents a bad reference count of the CPU device node.
>
> Moreover, the previous function did not check for errors when acquiring
> the device node, so a return -ENOENT has been added for that case.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
> I was wondering if this should also be sent to stable, but  I have not se=
en
> a report on it, and this is not responsible for an oops or anything like =
that.
> So in the end I decided not to, but maybe you consider otherwise.
>
>  arch/riscv/kernel/cacheinfo.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index d6c108c50cba..d32dfdba083e 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -75,8 +75,7 @@ int populate_cache_leaves(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
>  	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> -	struct device_node *np =3D of_cpu_device_node_get(cpu);
> -	struct device_node *prev =3D NULL;
> +	struct device_node *np, *prev;
>  	int levels =3D 1, level =3D 1;
>
>  	if (!acpi_disabled) {
> @@ -100,6 +99,10 @@ int populate_cache_leaves(unsigned int cpu)
>  		return 0;
>  	}
>
> +	np =3D of_cpu_device_node_get(cpu);
> +	if (!np)
> +		return -ENOENT;
> +
>  	if (of_property_read_bool(np, "cache-size"))
>  		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>  	if (of_property_read_bool(np, "i-cache-size"))

Gently ping :)

Could you take a look at this fix?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmb6mvkVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlIz0P/iOz1gxRpTCXjaOBthmKUKJtPEJm
xj/aakUpA/l/uxRv3vVMs4S6h3Fv3LFL0pTqrpxpH2BKVLrhDTHhMuxLYf+TBeKI
TY3mUBUbW+YVjzvNNaaUcGjjDdA0PhWWzZUTsrQRrU2afFEJeeK8EbEPfPcMt7sI
hUIXZ3jm52W+Ifzgp+2za6cJtAodUDtYRRFb/gE3X/BmSFO2WaO0YTd0RRAoj0+M
qhe6XwfuObJ3nEKMMikqfH9QJ1tpWAX+gMRv8zbEk9GYSbKrg/8QMLiczc73gbq6
70ppXc7TLmXPO52MiJB6YeXv/TaUplPUVGde5WEbRgUqvLjQv2yEoSsVgQRhEuU6
CFzDwQU7NVEo+0x9ovZ89d8Hw1xLxGfZE0qpCL1Ir6JF8n5zMI0/eKdB893AToiV
evgkj3AuWrUV14l85jwLFDqRB7ypv3vBAkKl51iquv3jZ/uW5qdGQQRLP92SW7cZ
23yjVpxZSowcuacLebaQzPIadzU5b73isc6/szs6wefy8hOUIlpQ4fVd0dSQRyNf
Vzaxzxl3gN3ENsDVhvxjRTp4o1tu3VkZBRmczVnDAKWvmpaSwIzp4wd5VwanWiIe
LZ9UM1pCnDDQaqDyIbZA+tPNUXKEvCp0867lqeJCu8JrtpXu+EqY7r8rh/H/w02E
OKDlOyd+hvSHoGBr
=UNJG
-----END PGP SIGNATURE-----
--=-=-=--

