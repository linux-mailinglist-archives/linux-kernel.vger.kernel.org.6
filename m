Return-Path: <linux-kernel+bounces-437946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA299E9AD6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41C82810CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D282D78C9C;
	Mon,  9 Dec 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjSlsd20"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5137082D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759186; cv=none; b=P4V7R9G7/6Y2Hw3BwFEm+Hhq7lBP/6ZQh0VNVaZrnsqjlTAsla4oBihF6wkNWH3AIgYI+AFnjRjV74fcxiLiJ1445fRpOMr6wrGqDvS8VyTze3uFadD1WzX7TvrNzPQGiCMcm86ZwyXYCZd1uiL6BV4EpIoKwvwDzHkImfoLALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759186; c=relaxed/simple;
	bh=16XQVuXrm7heIQNAWW8/FKiBbVn3H/SEfdz7ylWY++M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0M6aqtDeFoSYdgH6mH/Z4UBI54SYwmJkDVOJaJ0+ORa4PO8Fcs6A90OxT5bLsUwl7loobrD2WUdORzJCu92hHGMvhIZ7F85b6HamMznDgw4sbs+//Hh1J+m1FM6OSABwIEOb6eUPbrIZVKxBI6h95D+9qJAsdWCZJELUxQHH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HjSlsd20; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso3857599fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733759183; x=1734363983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIBoNya5F3528yu6D0VO0h8dLQcbx0JCMNsWGtDPRn4=;
        b=HjSlsd20C0Uni+XXftGFoYZ7GTHPFsrSpssYUxqsNMOkr+aQ8pEl1N7+ZTWBTvGt8C
         fALZU78dpyhN37zWJy9ywlKrfbjwremsCjhm2bhuo9R4lv4CH7So90Z4avNTayWyP7IG
         fViEcrkAZ6FifjJIhTzK983ula4VTJ7/QwV0loF8ZVGCV0u3M9dx9JGY94/TwYjQS+iY
         /hOgtRrYj4JbRFMepENIupeNQuoNWHJagvF+tjgGHKx3+v9/+lOIOxugwtPgYgURiGU2
         87ooJMydry4gZmSDLwk9i/7JDXClKGrOTYQEvEHlBKPT+5GkxtQFLqxjXRaIZwMVGsMf
         fCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759183; x=1734363983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIBoNya5F3528yu6D0VO0h8dLQcbx0JCMNsWGtDPRn4=;
        b=OkKkfPYX4RNX9oBW/libBR62hmp9+WCCvLvsiMNDXWWEDaKVhAPS+hHs9VwyzSdU69
         dcW7MYVKbfCR6sRscFBcnM3Z9aXw1LZuoXwBffQ1CdAlAW0L4aqz2JqQSbizy8SLb71L
         V57e9NHNC874D4jIC/iboXg26NVDa/GHP+tRbkWrBvWAwEB/0yfpc8lLrYJ8XXMj4MtB
         onAYFBVq7W8QDaq1rb+5sNX6EBSY/NLLqbFkVYmF5nzcMYe+1tEyM3gtbe5nQiUzOEgt
         nxehQQ2Cd1kKN9MfHk294Whs8FNIXC5scXlEa2ee+WVftGKHlIgNEalrlv1RitKA/q5O
         wqRA==
X-Forwarded-Encrypted: i=1; AJvYcCXsHsKugT8Za91kdYwCM+pnS0apnh0YJXXs63tEkvDFLCwccb+U/N15k4YOHUe4pLTAhGkjUMpE9CDNsJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLL2X1zkZXjZvg1TdtgIdxWHmf1q75kQNjCtYxji/QOs7o74i
	gbqLC2XSxaEvbE8pqNHmLqqRqyJy1tA7HKCGCNqrwAhU0ZvL9LlsOjrQZ2bVcaCcyYpw2NA+Br+
	UhQZQ7iLonEW407Hwzsk3b6ytPoRK78K6PaU+gQ==
X-Gm-Gg: ASbGncs4UzONUPNTCoOtso3csq095umSdzNCaozlnPGyQ7SGMDOzq8KJB7SyfoDs/NR
	C83LMCU+WroxgeuEDVs9uF+WI+vWhptSD
X-Google-Smtp-Source: AGHT+IF1o73cL/hkXkpDgTjpBseh1lIQoghf7scLZZsZtFEUASpgWKzjjo/5hEzx3ArXf5bTX7ur0fjawQEbNDCPoWE=
X-Received: by 2002:a05:6870:ec8f:b0:29e:7f5b:b003 with SMTP id
 586e51a60fabf-29fee606389mr567415fac.22.1733759183312; Mon, 09 Dec 2024
 07:46:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com>
 <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-2-f502ef01e016@quicinc.com>
In-Reply-To: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-2-f502ef01e016@quicinc.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 9 Dec 2024 16:46:11 +0100
Message-ID: <CAHUa44GxY=nZP9O6XpO-nRKJ_wUnK66h-QEnFPJ9myFGydBZYw@mail.gmail.com>
Subject: Re: [PATCH 02/10] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF
To: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

On Tue, Dec 3, 2024 at 5:20=E2=80=AFAM Amirreza Zarrabi
<quic_azarrabi@quicinc.com> wrote:
>
> For drivers that can transfer data to the TEE without needing shared
> memory from client, it is necessary to receive the user address
> directly, bypassing any processing by the TEE subsystem. Introduce
> TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT/OUTPUT/INOUT to represent
> userspace buffers.

Internally you allocate a bounce buffer from the pool of shared memory
and copy the content of the user space buffer into that.
Wouldn't it be fair to replace "without needing shared memory" with
"without using shared memory"?

>
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  drivers/tee/tee_core.c   | 26 ++++++++++++++++++++++++++
>  include/linux/tee_drv.h  |  6 ++++++
>  include/uapi/linux/tee.h | 22 ++++++++++++++++------
>  3 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 24edce4cdbaa..942ff5b359b2 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -381,6 +381,16 @@ static int params_from_user(struct tee_context *ctx,=
 struct tee_param *params,
>                         params[n].u.value.b =3D ip.b;
>                         params[n].u.value.c =3D ip.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       params[n].u.membuf.uaddr =3D u64_to_user_ptr(ip.a=
);
> +                       params[n].u.membuf.size =3D ip.b;
> +
> +                       if (!access_ok(params[n].u.membuf.uaddr, params[n=
].u.membuf.size))
> +                               return -EFAULT;
> +
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -449,6 +459,11 @@ static int params_to_user(struct tee_ioctl_param __u=
ser *uparams,
>                             put_user(p->u.value.c, &up->c))
>                                 return -EFAULT;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       if (put_user((u64)p->u.membuf.size, &up->b))
> +                               return -EFAULT;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>                         if (put_user((u64)p->u.memref.size, &up->b))
> @@ -649,6 +664,12 @@ static int params_to_supp(struct tee_context *ctx,
>                         ip.b =3D p->u.value.b;
>                         ip.c =3D p->u.value.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       ip.a =3D (u64)p->u.membuf.uaddr;
> +                       ip.b =3D p->u.membuf.size;
> +                       ip.c =3D 0;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> @@ -751,6 +772,11 @@ static int params_from_supp(struct tee_param *params=
, size_t num_params,
>                         p->u.value.b =3D ip.b;
>                         p->u.value.c =3D ip.c;
>                         break;
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT:
> +               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT:
> +                       p->u.membuf.uaddr =3D u64_to_user_ptr(ip.a);
> +                       p->u.membuf.size =3D ip.b;
> +                       break;
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
>                         /*
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a54c203000ed..b66e611fece4 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -82,6 +82,11 @@ struct tee_param_memref {
>         struct tee_shm *shm;
>  };
>
> +struct tee_param_membuf {

I would prefer tee_param_ubuf to better describe what it is.

> +       void * __user uaddr;
> +       size_t size;
> +};
> +
>  struct tee_param_value {
>         u64 a;
>         u64 b;
> @@ -92,6 +97,7 @@ struct tee_param {
>         u64 attr;
>         union {
>                 struct tee_param_memref memref;
> +               struct tee_param_membuf membuf;
>                 struct tee_param_value value;
>         } u;
>  };
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index d0430bee8292..fae68386968a 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT        6
>  #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT 7       /* input and outp=
ut */
>
> +/*
> + * These defines memory buffer parameters.

user space buffer

> + */
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INPUT 8
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_OUTPUT        9
> +#define TEE_IOCTL_PARAM_ATTR_TYPE_MEMBUF_INOUT 10      /* input and outp=
ut */

TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_*

> +
>  /*
>   * Mask for the type part of the attribute, leaves room for more types
>   */
> @@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
>  /**
>   * struct tee_ioctl_param - parameter
>   * @attr: attributes
> - * @a: if a memref, offset into the shared memory object, else a value p=
arameter
> - * @b: if a memref, size of the buffer, else a value parameter
> + * @a: if a memref, offset into the shared memory object,
> + *     else if a membuf, address into the user buffer,
> + *     else a value parameter
> + * @b: if a memref or membuf, size of the buffer, else a value parameter
>   * @c: if a memref, shared memory identifier, else a value parameter
>   *
> - * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used=
 in
> - * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
> - * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NO=
NE
> - * indicates that none of the members are used.
> + * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, membuf, or valu=
e is
> + * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
> + * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYP=
E_MEMBUF_*
> + * indicates membuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the=
 members
> + * are used.
>   *
>   * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
>   * identifier representing the shared memory object. A memref can refere=
nce

Please update the comment above with UBUF and ubuf as needed.

Cheers,
Jens

>
> --
> 2.34.1
>

