Return-Path: <linux-kernel+bounces-245129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5792AEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42A41C22048
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CBA54FAD;
	Tue,  9 Jul 2024 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvzzrPfG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4092381BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495637; cv=none; b=I7HMzVMKkCuxtrsMOd3ieRTejak7O0HdC7Gw5h2f6mSuEdvEENwBAyNXRcPl+8uursGI9JQfBt3Xle3HX59hZBXKuHxfAz8PCSd8hyzUTsuUzdiSGIPuIAUg6cIVNqrZusACDsQ9gX74I3cFv57daSYcd5Pf9OVmG3sPKljv/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495637; c=relaxed/simple;
	bh=XoniMY9gyeIAU1UmiYfaXz6w6RRa8ECXmSmBQOuYxLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3A2y1kVxGRXAeiiHNMxSI3gUdO6YDJIThyNgTBFL1G9zUWgKhnc3aROevM4CQU01AAWdsh7nSAEatOqLSpj85uuEcZN9mxh9iBWLcklyIuUvpKmlbzQiVvWEEd4c5aGNWB8fEidnJqZgoyP51uyzbEqbTp580sQl0cUROw/OnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvzzrPfG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso3783695e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720495634; x=1721100434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujWVI1w98XuvHWuXqXhCuvgWjqW2EVQMcC2qmsk5Z9Y=;
        b=GvzzrPfGXQ5TZ7AcGgD7xcsnMeNGJXbgOXgfMaSpwappFc4cM6l6ESXBqz60VtQzno
         2R6EEwXHuDnDCKwc1sWzhcQuMbe4sSphOhIBxPO8mIY1yZq+rhTuUsU+C1Azur/occeR
         4lDN9MYyh3OdHPb7nKabhKTi8UiwPG7Npgqgrlehlt3c+X+N4el8UCvqBtynkwIDX+cU
         zSDH0c0jtzxnQ2x+HmPh9ccOhPgtDu0RH370Iwv5FsuYDoc/F7wsH+eGWb+ZExT4w2dn
         kFrlUO4P4YUJ/3df8CK5DarHWQaw3YzcY80JlrsJdLbVRn5PgLL758DbVgXo5/myb3jp
         RfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720495634; x=1721100434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujWVI1w98XuvHWuXqXhCuvgWjqW2EVQMcC2qmsk5Z9Y=;
        b=gl6ZWNjX8zUC9ZgOhb1OPqbRSLCXvQ9cLZ9/hKzTalBCeKWOETLa8LbmcMEXbPCAJy
         MB9K1gavUJbiHVhwOPXhcp3d0MXAqpzzeJAWXAzXi+CVAJ/P9aA8oQvTWbCHEjxcRg9q
         9YqYXEHvo5XawBJkRGMfB3BxOwPRXrmkYODFN2gwnBs0j00t3edc39TY+YdISnJ/OcHs
         PNefIHpU9+BwDl1YxVE0FVmHv5g16NB2DxHFStcyBlDIlH7AgvOtrAgicHzs8aTzmRO7
         0a5oql2hDTgfFYacycmZtRwQGUnXcVJywBKdsBA1Pm5e0FS7XjaWVgGUrSRiBay01dQc
         +FMw==
X-Forwarded-Encrypted: i=1; AJvYcCU/7JhGsZ0tXvcwSGcMZjx8Pt1WNF3hMcVS+aAJJlKxxxaeYQYgLm86gprRyvc/82BQoD9HFwQCf9YdI5/l0sZtZrc06EbgZoEsxzm2
X-Gm-Message-State: AOJu0YxDbi7mHby7V3tovT0zc1iaq6vTUCgSiyG1glbPGHzjBntSAIzo
	Rk5F7hnrIJp6IGEcLU7k6pcpMghjLpbxd28SNqs6D/QSqhnxWCsLpFh1lsI737nEtpVv/ORIhuW
	Z12rGLVCNUivzocGjYID6sbrd8Bo=
X-Google-Smtp-Source: AGHT+IEbnndXVikg5q+Ou7RW/6MzUwK63agDbEJsilPeBqTBf95hARUl1QO03UyOQkjfsmWsTPOXfQa3hGOnjBggzRo=
X-Received: by 2002:a5d:4807:0:b0:367:987a:2d3c with SMTP id
 ffacd0b85a97d-367cea95afamr784153f8f.29.1720495634060; Mon, 08 Jul 2024
 20:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717155071-20409-1-git-send-email-zhiguo.niu@unisoc.com> <e1719623-a42e-4394-b840-2741975ead37@acm.org>
In-Reply-To: <e1719623-a42e-4394-b840-2741975ead37@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 9 Jul 2024 11:27:03 +0800
Message-ID: <CAHJ8P3KaWbKrGnmqmb_W9xw0k_F7i8oRK+MYscP02-k1XPyWfw@mail.gmail.com>
Subject: Re: [PATCH] block: uapi: Fix compliation warning of using IOPRIO_PRIO_DATA
To: axboe@kernel.dk, dlemoal@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

kindly ping...

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=881=E6=
=97=A5=E5=91=A8=E5=85=AD 04:13=E5=86=99=E9=81=93=EF=BC=9A


>
> On 5/31/24 04:31, Zhiguo Niu wrote:
> > Generally, the input of IOPRIO_PRIO_DATA has 16 bits. If use format "%d=
"
> > to printk IOPRIO_PRIO_DATA, there will be the following warning or erro=
r.
> >
> > fs/f2fs/sysfs.c:348:31: warning: format =E2=80=98%d=E2=80=99 expects ar=
gument of type =E2=80=98int=E2=80=99, but argument 4 has type =E2=80=98long=
 unsigned int=E2=80=99 [-Wformat=3D]
> >     return sysfs_emit(buf, "%s,%d\n",
> >                                ~^
> >                                %ld
> >
> > This is because the output of IOPRIO_PRIO_DATA is converted to "UL" fro=
m
> > IOPRIO_PRIO_MASK, which is not reasonable. unsigned int is more suitabl=
e.
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> >   include/uapi/linux/ioprio.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> > index bee2bdb0..9ead07f 100644
> > --- a/include/uapi/linux/ioprio.h
> > +++ b/include/uapi/linux/ioprio.h
> > @@ -11,7 +11,7 @@
> >   #define IOPRIO_CLASS_SHIFT  13
> >   #define IOPRIO_NR_CLASSES   8
> >   #define IOPRIO_CLASS_MASK   (IOPRIO_NR_CLASSES - 1)
> > -#define IOPRIO_PRIO_MASK     ((1UL << IOPRIO_CLASS_SHIFT) - 1)
> > +#define IOPRIO_PRIO_MASK     ((1U << IOPRIO_CLASS_SHIFT) - 1)
> >
> >   #define IOPRIO_PRIO_CLASS(ioprio)   \
> >       (((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
>
> This change is safe even if the mask is applied to an expression with mor=
e bits
> than an int because of the integer promotion rules. Hence:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

