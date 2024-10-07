Return-Path: <linux-kernel+bounces-352694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127329922C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D08B1C215EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC712E4A;
	Mon,  7 Oct 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kev009.com header.i=@kev009.com header.b="tuIpb769"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315AEEEC9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728268382; cv=none; b=oEvespimO4wbMzdiJUbniiUoQYPcqKEw2JLoXkIUU2ob2BEnPv/8vkc5iZN1rAbRDa60qw7tfdcK1Rk3WOZSFGrvEOt6sKu/PRMX5v7u/+VClqdQTSK+G3/Ag8GnTr3gKU8nb+7nfpjbYkuo3Az6jxWjaHQoM2+ZE2VCiuj6uQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728268382; c=relaxed/simple;
	bh=UmYzWjwwdRldGzMtasrj0iUPzywF33QHaFRM8bXmb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc3Tzkidt8zN1IxKuufzktbHldZT0DtZX3osblG2Q2XI2tBTrOUKVmwg5eZB+NGiSildwNlL+ysvncN5CX6xXp2chSks+2azBmlJZfL0yw1+tZp+aldcsX9VzkKiRSzMeZUydvVs9c16eDKyH+kRLmxu1dBP01koVP500uFyPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com; spf=pass smtp.mailfrom=kev009.com; dkim=fail (0-bit key) header.d=kev009.com header.i=@kev009.com header.b=tuIpb769 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kev009.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kev009.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45d8f76eca7so41537431cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kev009.com; s=google; t=1728268379; x=1728873179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIagNj3XBeiwbes7ESay7OedVVX9YeO+j3SWRSuWDgU=;
        b=tuIpb769p5oD0BWU9SUrJE4RyPonSCiDvwzOKjzffMGJDU82HUKHq4lzCS/ioKYOrm
         QDXVeJV6LQjGIWPMtPKHYfrf4AEIiyZpWU3He1FOCy/6WqsM0rud7fQP4UtlJDBTZCq1
         ZjzQRzllrHWRp3q6Q9zICqXpK/uhznT/YuZoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728268379; x=1728873179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIagNj3XBeiwbes7ESay7OedVVX9YeO+j3SWRSuWDgU=;
        b=FstMMJoI+j0BPEPDIsrhKYeHhW79xUUsJYHK3tFB7LzMwbdnodv0Zt2YojCi85Ro9N
         uYdqKyYTog4me/0wECfY/2GhYS9K4dntBiXWNEZSP7M3WZN34okrD38DioOVUlCvq5zO
         VYhOD6QKtV+1z8xkidl6s8kygx+xqgClj88OR/FBjjQBzsKwnaUO4ueAPb8dnPCpxnwW
         1/QTAkCOYYGVqkad8zfeR9pSIfJ845mLGp2gzoHnRw+bzTvqo9/m5pg2AnpV2jerDpGU
         8NzHmknrNaqWbtyRLKBR5KCvG9yLBynF/KzfTyOq6LPMVqXNOhTYbQr3ML8NtDLH+R+J
         s9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCW8bPDF4eP5UEWPI7dQmyRoiAU324uEEyX60O89vDXZ52DRAxUzDcw2PXuEnbWMhtbrJoMd9oK2HO8gqiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMocSwE2sX6eyTYd6V8XgL7TxIy3tynIxOHxrHwcX5TSzikFB
	wkL/J/Q6nzg17ugETB35P3nTrr0y8IDAPQHszGvZ0wWJgxX+rBm5/nBUXWaLPYo0oIlmDodvn6D
	52HjWU/TwJq1c8F6uku/niGnJZMrtBbfvqcyc
X-Google-Smtp-Source: AGHT+IGW6ESRO/rs7JsIqpNrzr5mR+Qf6lp+llFyFWrhgLaCLuuBhqRYKgzRWQDEQknxfpZf58As69biVB1biwW3opY=
X-Received: by 2002:ac8:5792:0:b0:45b:1d3:d9a8 with SMTP id
 d75a77b69052e-45d9ba85fdcmr172235491cf.27.1728268379057; Sun, 06 Oct 2024
 19:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801210155.89097-1-kevin.bowling@kev009.com>
In-Reply-To: <20240801210155.89097-1-kevin.bowling@kev009.com>
From: Kevin Bowling <kevin.bowling@kev009.com>
Date: Sun, 6 Oct 2024 19:32:47 -0700
Message-ID: <CAK7dMtDiL16JAXvTuTv3fOL5JNkMOCyjr6tVx44uDMKQxVnwqA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Print digitalSignature and CA link errors
To: dhowells@redhat.com, keyrings@vger.kernel.org, jarkko@kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Hopefully this is pretty self explanatory, it just increases the
diagnostic capabilities of using the keyring erroneously.  How do I
get someone to look at it?

Regards,
Kevin


On Thu, Aug 1, 2024 at 2:02=E2=80=AFPM Kevin Bowling <kevin.bowling@kev009.=
com> wrote:
>
> ENOKEY is overloaded for several different failure types in these link
> functions.  In addition, by the time we are consuming the return several
> other methods can return ENOKEY.  Add some error prints to help diagnose
> fundamental certificate issues.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
> ---
>  crypto/asymmetric_keys/restrict.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> index afcd4d101ac5..472561e451b3 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -140,14 +140,20 @@ int restrict_link_by_ca(struct key *dest_keyring,
>         pkey =3D payload->data[asym_crypto];
>         if (!pkey)
>                 return -ENOPKG;
> -       if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +       if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
> +               pr_err("Missing CA usage bit\n");
>                 return -ENOKEY;
> -       if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +       }
> +       if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
> +               pr_err("Missing keyCertSign usage bit\n");
>                 return -ENOKEY;
> +       }
>         if (!IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX))
>                 return 0;
> -       if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
> +               pr_err("Unexpected digitalSignature usage bit\n");
>                 return -ENOKEY;
> +       }
>
>         return 0;
>  }
> @@ -183,14 +189,20 @@ int restrict_link_by_digsig(struct key *dest_keyrin=
g,
>         if (!pkey)
>                 return -ENOPKG;
>
> -       if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
> +       if (!test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags)) {
> +               pr_err("Missing digitalSignature usage bit\n");
>                 return -ENOKEY;
> +       }
>
> -       if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_CA, &pkey->key_eflags)) {
> +               pr_err("Unexpected CA usage bit\n");
>                 return -ENOKEY;
> +       }
>
> -       if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
> +       if (test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags)) {
> +               pr_err("Unexpected keyCertSign usage bit\n");
>                 return -ENOKEY;
> +       }
>
>         return restrict_link_by_signature(dest_keyring, type, payload,
>                                           trust_keyring);
> --
> 2.46.0
>

