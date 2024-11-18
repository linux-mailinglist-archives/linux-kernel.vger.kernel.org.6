Return-Path: <linux-kernel+bounces-412518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2139D09FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C142827B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D413AA4C;
	Mon, 18 Nov 2024 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNHLe9tq"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45C322E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913429; cv=none; b=uaAxy2PjdWGxMVDSawz1u+e7RzxcbiE2uDSXi0MPz6UwaJQqmkMud7HzAyG+uocZw5G2dHsbnhEnd1LIMXvKE3OxOyCZUrPZXT5TlWdGvtjIpjmRFKpVjcvTZ7itYhBGoOneom9uEFdiyl/6dbUFtXGWqWAMsMQShNsnSMNeLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913429; c=relaxed/simple;
	bh=d1e4eZjC8SC8rU1hW8U3lxcUMIYZETjRd7XIDiOv6OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=px1lJaHqhJ+6gZpTSGCwFLyeHZSK+Ob0JSSHdFFxHiOSqJztp+QRZU/nMu9Fp4kmRnFJiMNdvY7SDRyZNkPSose3sZm+bueY0qK+M0TOSQWmbdxzjOib24SVlljLY8cJ59i0MWdz/lu/40OiJlJ7fwZimHKAk4wuPWkLADpBsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNHLe9tq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ee676b4e20so19782347b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 23:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731913427; x=1732518227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLPV6VvTQgCuByNHMKVl9QG7CmMBn7jYkbg8c2F0yrQ=;
        b=fNHLe9tq5BiErcaEWaEiBs5BvVoufJhPYNny4GyIKyPU6kzxGtGnFitnEkmIc3+CAv
         4RKAOpu+5j3OKbxC9nWKNSkOJkEApQXX+RYKvCWj+5zaY/k9yWY+plVt/BF9cUqYKHTD
         whTuqXxio/FMq79JoejlvZk5H5ptkKcJcq9KlR4xuJSWSeCE9bLKo+NqKBoXEDZFmK7H
         blNG46KR15odWiNYPEcvoaRNjOyqvi/5t7qAX1xypVT+E0EU3pZgbmOJ/qDGMapqGxNW
         6Po8vCCexuvpdWQnpzFSXTAH3N8NqBmvgGNzKVeD7nLLjRF7T7stcJHp/NKfTM8xNVIM
         4m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731913427; x=1732518227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLPV6VvTQgCuByNHMKVl9QG7CmMBn7jYkbg8c2F0yrQ=;
        b=xAxJpYDVAqaxMTqHSwcBcZzQwQH4qEJ1XflnwzwoFT+6a/9CFO2PZAYRjjZ6MTKJ84
         ivPNiXQuUA5S0rPG8r2AIe+p6YFJvtx/nN6Jqfrt4A2Z3fK6j0SfrRTwKPKCnGwKOesj
         cVh5lZ9dT4CYuGbO7Bk8J4rzmTkn2+oBcATVPCFgn3R3/Gl4DnhjBPXMXes+1PJG4ANl
         TnI4pjoy5m9L49Jib30zHUSaojydh2UShEEJXFDKAFtGnDdu3gpL22FOCbiVbKlgrXDn
         TkeG6BwLMBpjLmuru7acdViyXojNfgGt/Ymkon2XkCSmpq+tIqjxj5/ZoGloGIasBxoz
         leNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlgrErKFsIf1s5a43oPg3RIjTVxAsLowD2mOH25vqJnZU1X+43XuppsKuuQZbBgOhoIoaZpmluviXdlRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKELzSS6aQz1t7/JjiHl2I3iD1ziBAWuwpUyNx3ElwOUbSQjz
	0krl6UiIPyjBR72MAnO2/bNND4Azqsc6+J1r1YjtW6YHVEC6lpA6sxXzK0w1n2kxiJNmHrJA9Gg
	f8ficVToJUrreOnH/8pXgcx42IKk=
X-Google-Smtp-Source: AGHT+IGl7r9eTTY6DbGjkT8AzG4rZwLNXHhz58BMG08MWeCm1Ep0CHhz/nibBtdCGAr6NSzhNQ9l56WyOwchQRHJKWs=
X-Received: by 2002:a05:690c:f06:b0:6eb:3f6:bc20 with SMTP id
 00721157ae682-6ee55cf4bcbmr117127367b3.41.1731913426798; Sun, 17 Nov 2024
 23:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109013819.5952-1-danielyangkang@gmail.com> <065b2dea-0c0a-4961-ac18-2ddd62f0b808@kernel.org>
In-Reply-To: <065b2dea-0c0a-4961-ac18-2ddd62f0b808@kernel.org>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Sun, 17 Nov 2024 23:03:10 -0800
Message-ID: <CAGiJo8TbZPpOBqrGRf3ofXk-TxKQD88Z1YDjM4L8VXV5ccv0Og@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: replace deprecated strcpy with strscpy
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 5:24=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/11/9 9:38, Daniel Yang wrote:
> > strcpy is deprecated. Kernel docs recommend replacing strcpy with
> > strscpy. The function strcpy() return value isn't used so there
> > shouldn't be an issue replacing with the safer alternative strscpy.
> >
> > Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> > ---
> > V1 -> V2: handle strscpy errors, changed prefix to f2fs
> >
> >   fs/f2fs/super.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 87ab5696b..4721a8a8f 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -5,6 +5,7 @@
> >    * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> >    *             http://www.samsung.com/
> >    */
> >   #include <linux/module.h>
> >   #include <linux/init.h>
> >   #include <linux/fs.h>
> > @@ -1158,7 +1159,10 @@ static int parse_options(struct super_block *sb,=
 char *options, bool is_remount)
> >                               break;
> >                       }
> >
> > -                     strcpy(ext[ext_cnt], name);
> > +                     if (strscpy(ext[ext_cnt], name) =3D=3D -E2BIG) {
> > +                             kfree(name);
> > +                             return -EINVAL;
>
> How about?
>
> ret =3D strscpy(ext[ext_cnt], name);
> if (ret < 0) {
>         kfree(name);
>         return ret;
> }
>
> > +                     }
> >                       F2FS_OPTION(sbi).compress_ext_cnt++;
> >                       kfree(name);
> >                       break;
> > @@ -1187,7 +1191,10 @@ static int parse_options(struct super_block *sb,=
 char *options, bool is_remount)
> >                               break;
> >                       }
> >
> > -                     strcpy(noext[noext_cnt], name);
> > +                     if (strscpy(noext[noext_cnt], name) =3D=3D -E2BIG=
) {
> > +                             kfree(name);
> > +                             return -EINVAL;
> > +                     }
>
> Ditto
>
> Thanks,
>
> >                       F2FS_OPTION(sbi).nocompress_ext_cnt++;
> >                       kfree(name);
> >                       break;
>

Thanks for the feedback. That does look much cleaner. I've applied the
changes and sent v3.

- Daniel

