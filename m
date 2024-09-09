Return-Path: <linux-kernel+bounces-320971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257499712C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52701F2166F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4A31B251A;
	Mon,  9 Sep 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OX0nj0dG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4291B150A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872381; cv=none; b=APmOIhhYsm2zzBYPQ5PXGIxXvtsEtmQbd75rNUUfRGYckTsRnt14uuXFtAsZHVEptHF5jIkNrAdwoQ+zVDC7bBM4BiFkGordTKaMbs7bwNNTH+QjfVPcdwRpSTZDU6GzKjE/EvNm3jPwDm5O9mENBbrPSA7981zdTOZxOcZss/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872381; c=relaxed/simple;
	bh=kYwMWMOUYoJZKPWDz0p/NGGwuUGLl3O/po+hhV/ySR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMlxeRBpihRX90T4lbsPlMrQcKLd157ic4YWd387MIpNX/WBtUXPHKMJE5ejbfOflcyMmFlZJgNemMGJOu8X4aoVMPIA0jzaUKW9IJiVPn+y/jscY6UJnxU1d1I/LAuAGHqVwK5q25ayhHes6h/SQ/sUnk6ciBOv5vYDisLmyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OX0nj0dG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365aa568ceso3352833e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725872377; x=1726477177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S2UE6lFQFIaK4OtJMbVxXJXe1O9tXNFiR7Twawdri0=;
        b=OX0nj0dGgRdvSkuZQ5TjOckTvUotgw3dbzW5U2/jndT7AirIr++Fdd96ED4OfWDrNy
         WUoeckGeo9efcgyrsx/UlCw63zi4fHQG/xR0piYRKX7BfCiEAmyE2RAM8FVwTmyihDBo
         eSyDR/NVNj9epuYiqN6JC6W88VP/BJlw0YPA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872377; x=1726477177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6S2UE6lFQFIaK4OtJMbVxXJXe1O9tXNFiR7Twawdri0=;
        b=ItFaavWT77e2cUkRolJR85toJYqXLsDsuinezave6FBTPThC53E+XTuSQAhS+HYhoV
         ZhENaGbmaiWmvTd1bXxmZNth47Oq/NjrAQgX6AQ2GRn0ZVuXU/mB1JSg2gS63D54DVow
         CNs1vdKn1K7PFY9MIbB5iTAKJal32z+9udjWJBJNrTjHNxGW04TjavtZ75JWEwxYXm2G
         ixxAk3FJSw6HCuOjyRgZl9UOUxIEbk4WUmhdJOoFXg/on9YKwO52uh41q78KKEO+g/jy
         YdkJiu906L0EcDw7UuCNiVI5ASe292CSZzvsceQ9TSw7YFMo5cM9PZ157yVbZjqfF4iM
         2SDw==
X-Forwarded-Encrypted: i=1; AJvYcCXoDFA/oaDZ7ZCECsyriGTgEvT+DZ88SO+70KjEM6BtMvIus+BYq9rUo2c0DmuBl3oE6i6beDeafqI1bbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAlylllrmftL/ZU33AfXAtSrnQzDyzJvi5pgonuJyVEqfBK5H
	mTCnZNcSs8RefK9NZcrOcWp71ZVcASnzs7vpCtGkd1K3yXvrUYRDFReLfW++aB/N9rsJejMK8vk
	VfABe9xvxqB2xrAFXqVeNadQyuolP9UKmgCHA
X-Google-Smtp-Source: AGHT+IEV5KHTyM42uPsdDXbjleRs4adAC8RAMwKOrUjz4iDm20YabVneezv8rJGiE6wMjCx8MJoPuYEUF0lSIgN32s0=
X-Received: by 2002:a05:6512:3d89:b0:52e:933f:f1fa with SMTP id
 2adb3069b0e04-53658818d02mr6743959e87.61.1725872377196; Mon, 09 Sep 2024
 01:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com> <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
In-Reply-To: <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 9 Sep 2024 14:29:25 +0530
Message-ID: <CAD2QZ9Z_rpDAyeJGBDxx8vqq7nSAuiktTTCxYHUu1QtA42afew@mail.gmail.com>
Subject: Re: [PATCH] block: Fix validation of ioprio level
To: Damien Le Moal <dlemoal@kernel.org>
Cc: axboe@kernel.dk, niklas.cassel@wdc.com, hare@suse.de, 
	martin.petersen@oracle.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:15=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 8/28/24 17:28, Ajay Kaher wrote:
> > The commit eca2040972b4 introduced a backward compatibility issue in
> > the function ioprio_check_cap.
> >
> > Before the change, if ioprio contains a level greater than 0x7, it was
> > treated as -EINVAL:
> >
> >     data =3D ioprio & 0x1FFF
> >     if data >=3D 0x7, return -EINVAL
> >
> > Since the change, if ioprio contains a level greater than 0x7 say 0x8
> > it is calculated as 0x0:
> >
> >     level =3D ioprio & 0x7
> >
> > To maintain backward compatibility the kernel should return -EINVAL in
> > the above case as well.
> >
> > Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definitio=
n")
> > Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> > ---
> >  block/ioprio.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index 73301a2..f08e76b 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -30,6 +30,15 @@
> >  #include <linux/security.h>
> >  #include <linux/pid_namespace.h>
> >
> > +static inline int ioprio_check_level(int ioprio, int max_level)
> > +{
> > +     int data =3D IOPRIO_PRIO_DATA(ioprio);
> > +
> > +     if (IOPRIO_BAD_VALUE(data, max_level))
> > +             return -EINVAL;
>
> No, this cannot possibly work correctly because the prio level part of th=
e prio
> data is only 3 bits, so 0 to 7. The remaining 10 bits of the prio data ar=
e used
> for priority hints (IOPRIO_HINT_XXX).
>
> Your change will thus return an error for cases where the prio data has a=
 level
> AND also a hint (e.g. for command duration limits). This change would bre=
ak
> command duration limits. So NACK.
>
> The userspace header file has the ioprio_value() that a user should use t=
o
> construct an ioprio. Bad values are checked in that function and errors w=
ill be
> returned if an invalid level is passed.
>

OK. Thanks for the detailed explanation.

I agree, to use unused bits, functionality (return value in this case)
will be changed. If applications are built using Kernel headers of
v6.1 (doesn't include eca2040972b4) and later only upgrading Kernel to
v6.6, because of the changes in return values applications may have
some sort of regression.

To make the software backward compatible I believe, unused bits should
always be ignored. So that if in future someone uses it, it should not
change the behaviour (return values) of existing software.

- Ajay

> > +     return 0;
> > +}
> > +
> >  int ioprio_check_cap(int ioprio)
> >  {
> >       int class =3D IOPRIO_PRIO_CLASS(ioprio);
> > @@ -49,7 +58,7 @@ int ioprio_check_cap(int ioprio)
> >                       fallthrough;
> >                       /* rt has prio field too */
> >               case IOPRIO_CLASS_BE:
> > -                     if (level >=3D IOPRIO_NR_LEVELS)
> > +                     if (ioprio_check_level(ioprio, IOPRIO_NR_LEVELS))
> >                               return -EINVAL;
> >                       break;
> >               case IOPRIO_CLASS_IDLE:
>
> --
> Damien Le Moal
> Western Digital Research
>

