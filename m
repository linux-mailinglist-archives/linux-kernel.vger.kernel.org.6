Return-Path: <linux-kernel+bounces-267647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE019413E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17231F24675
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EA1A08B6;
	Tue, 30 Jul 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umcs4q74"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3468623
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348572; cv=none; b=HwjILlVajwtom73bGcPrwnHjFsaOTnIQQZ89usK27cKtV54NZEjZSLU8jNS4d+MOvnNWWbc48LE60uqAPsStOELp3PyDB/webJn8DtJohvM5YZZu5Y3NgpOXErJXsdhMTSk6qEuIxIrpLEUNzrf4sZfMeUZAsOfq6Khb4R9M7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348572; c=relaxed/simple;
	bh=8KdfWYe00oFaSreHDo+9R5LqRefFgQsvndyhNhVo6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTqGkZR01KMd4Uvpk5cVMYnBhQxHMCnRJwrhkL5wqDr5wTSHKHN5yfb2KhjHPpacxcT5dksrq8kMJPyarRt1jhYmxy4kWKz/k1V7t3mXzbQe9sY+XA+z11wi24doJ4wTAsynaJK1r0wOGpv5RtbOGJO6LxVJyfQfN53FQmJWHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umcs4q74; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so55759321fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722348569; x=1722953369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAEM9ctJ2LCO1h/CKfcm4zgElIlWA+z8iuPE30GRH/s=;
        b=Umcs4q74J5E9YqPbS8njKbiCEQWTr3rwB6ClLciWw7Tw+L3lzomR0XSjknTPThGfXB
         fmb37AbaSKrXFkV4LeaBqH5y75iYrCYeCI1c8zELx457yYuCGScgu9GQyKnt9xEe7MlJ
         zwomeW1ZvTSIL5M7jvPn9IyE58vbXaN5p2D4C3ayQYT5pbazGW2rHPj4Js01+K4r5Q7U
         9zhorSFJh5XZZgO2JWgORBbZ0JljE0BlNNc6p54+KTkXk8/sZaD3+2Iy2sL/0T70w+vx
         1JJ9bE5DH1/QNCX7Hm0zgOukeySQS9ahb1BVLLxIYtf2bFbAn0tv++sK/THC3IygQ6jI
         bzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722348569; x=1722953369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAEM9ctJ2LCO1h/CKfcm4zgElIlWA+z8iuPE30GRH/s=;
        b=Rcq/Y6ghSYshMF8si03dusXgeDwI7NWLmmmOoermEJEwGl/IchrYMtR+V0lqZ79uK1
         Zoz/Ed/PxizXMURGn21Rx1stwqQhVt+BRKRGHvosI5Op1A7q5jKAQOKRLUBiSQoWFG6b
         9NSmyIk8vHhdaVlN1Lvnc8Kg+epFdjzswrXAkoA9Mu+hK6S5y6kt2pFopnoE674/Hzkf
         NqaYHZp/1D8uSBECCgrrGwl1NU7Q0gcMLONwi/MRWGmw+d45Qt8T/fUufe2QQJgZydwk
         oatQb+9JpD+ONHCxpPgJMB+XPXrHoHVEytyUrkTXjbQR6jeFl4G4TZcqzhxh+BuEu8Dv
         v7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTgSYA2EJlifmLp52f+Cy5v+1crx+Rchanu/MvipY0+hu9UpL+5Ql/jN7QD0NpXK8oUu8Bw9qnDOJa4AtHRt44JMaEkxgrBPqxyZcV
X-Gm-Message-State: AOJu0YwTCcbUdHd1V6FJLKUlLvO4bzU7Cc3csOerhv+dvVkd99oPR5j+
	j7X6CXArVOG27lVeczxVCpRTjVlDEMg6N9Y5RKQ2Jq/m2uKvsojhIhRXY3Vkea/uKpJqlC4ztc+
	1vZtkxPso6tI44T8gV78HRK59s80=
X-Google-Smtp-Source: AGHT+IGribPyo8RciGBgcvwdQMsvA36qdoaMnvSfkx9bkengomf0ZQ0vzIeJ6mbsZ1m2rHhZPiY/8nEm4QP5gqL4HVM=
X-Received: by 2002:a05:651c:c1:b0:2ef:2016:262e with SMTP id
 38308e7fff4ca-2f12eaa152amr75582411fa.0.1722348568694; Tue, 30 Jul 2024
 07:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726104848.2756962-1-leitao@debian.org> <CAC5umygxnq=h1H2CCeprzaggu_A4DxZia3EEBTYk7sb72OnQFA@mail.gmail.com>
 <ZqdaAn0s8J3fZ15u@gmail.com>
In-Reply-To: <ZqdaAn0s8J3fZ15u@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 30 Jul 2024 23:09:15 +0900
Message-ID: <CAC5umyjXX7OkLLAusz5wLtNm+f-B+Vo90szHtJjh_C4fSEw+NA@mail.gmail.com>
Subject: Re: [PATCH] fault-injection: Enhance failcmd to exit on non-hex
 address input
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, leit@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=9C=88) 17:59 Breno Leitao <leitao@de=
bian.org>:
>
> Hello Akinobu,
>
> On Sun, Jul 28, 2024 at 06:00:14PM +0900, Akinobu Mita wrote:
> > 2024=E5=B9=B47=E6=9C=8826=E6=97=A5(=E9=87=91) 19:50 Breno Leitao <leita=
o@debian.org>:
>
> > > +exit_if_not_hex() {
> > > +    local value=3D"$1"
> > > +    if ! [[ $value =3D~ ^0x[0-9a-fA-F]+$ ]]; then
> > > +        echo "Error: The provided value '$value' is not a valid hexa=
decimal number."
> >
> > It is better to write error messages to standard error rather than
> > standard output.
>
> Agree. I've sent a V2 with your proposed change. Thanks!
>
> > Other than that I think it's good.
>
> Thanks.
>
> By the way, this file seems unmaintained by looking at MAINTAINERS.
> Would you mind if I send something as:

No problem.

> Author: Breno Leitao <leitao@debian.org>
> Date:   Mon Jul 29 01:53:44 2024 -0700
>
>     failcmd: Add script file in MAINTAINERS
>
>     failcmd is one of the main interfaces to fault injection framework, b=
ut,
>     it is not listed under FAULT INJECTION SUPPORT entry in MAINTAINERS.
>     This is unfortunate, since git-send-email doesn't find emails to send
>     the patches to, forcing the user to try to guess who maintains it.
>
>     Akinobu Mita seems to be actively maintaining it, so, let's add the f=
ile
>     under FAULT INJECTION SUPPORT section.
>
>     Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0748d6bd0c4f..11f3ef0b5ffd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8388,6 +8388,7 @@ M:        Akinobu Mita <akinobu.mita@gmail.com>
>  S:     Supported
>  F:     Documentation/fault-injection/
>  F:     lib/fault-inject.c
> +F:     tools/testing/fault-injection/
>
>  FBTFT Framebuffer drivers
>  L:     dri-devel@lists.freedesktop.org

