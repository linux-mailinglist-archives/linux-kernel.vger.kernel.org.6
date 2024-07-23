Return-Path: <linux-kernel+bounces-260219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66093A4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E41C22039
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34671581F4;
	Tue, 23 Jul 2024 17:04:08 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340514D431;
	Tue, 23 Jul 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754248; cv=none; b=Q5gVy827t8PxAqdwhZHrwM/aEpQN2SrzrzUqEUqZt/4UgMcc3/OV5dSxvv8PNLAuDO0aaQOH1+rg0CoZJQZzm768lnR4s90PkrhfEfWg164MG17bfAA1EJU0hh4DBVhC0/Poo9RDmx80qlZT+7T00WIVdPCTczTYpS+1dFeIZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754248; c=relaxed/simple;
	bh=6+fkscHQNgKGVGb6qvOlCMO1VnaLS8Gb+rc0NXhVRXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnRMpEtP92hXFfxXlWG4tiB3+AwIMr7fwwwPi0xO2vwHCKw1LHEbO1S/Su2MEuRoD7Z2c/Pv4kDE5P1mJr2MCAhBKfClfY7K4Tqk9me9GnHOlrHdP88a8t1GB82/lamcd4rBjPUcTd9JtfGyNc2FuyIwYakPdRkVcqbnVih/9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70448cae1e0so3083222a34.3;
        Tue, 23 Jul 2024 10:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754246; x=1722359046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02xnxBX9SHHmM6dl/yiHqxrkZEzkCA7F2H6qwPrp+Fw=;
        b=nip4dt0b+CiEnyG/Z4Rq/upEIyitNV4a+P1A4sx/jsyCdFHrcZXFkE/NHyfritVkRz
         6wqBH5YNEfzNkicme/XmeBm3pmUu4ueHzvIv+BW2CCXp3DvhKMfVwizuI3k6P3SbIjwo
         fk8THQYr5uaLDr+WP4Cy1yEA/qyZha4GWKlz8+z1OmLMPQw0BNbsVVw5XPfsGO3e0PIY
         gmdjoLCHajGxLcGFbKCajojqmXY3lVNVPJUvaEQTbTYHxN2TLDH/MkV/3iY9iA7nEoa/
         cp9v/G0h8X34OCUlHpyGaK5ZHsX1aD83D23azJ/7p7xnditoasw0PI+Of2Dhz+7+lHAm
         VFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3J3UBiLteoIDQptmhZQjAV8pKUQDbi2LyN88b+KWkKV1DOpjaTRl5ZkCZqTAQTfBNNVnyWbUHXXYOB8ysSHrrwfE5knviiJ2JjRPXvS61R28qJRskS5xYNhac/PAwuplKXpXmigLsLFdhCzuC
X-Gm-Message-State: AOJu0YyMGXA5GDerfQAT3b4FOY7PwZyFb1g01i4Y8GqD6Q5P/P7eJd3R
	tXEyPvZfiMwM5HE/G7X7zKtAVczL8iaqxd9GQRKCwMTsL1BzBCKAVtw5pFtHN4kEo7Vbn4fD9Y8
	1WMUonxi+I/fQq+aovF+SX6HNOms=
X-Google-Smtp-Source: AGHT+IHEX97DGXPMq/CzCwVHEuhMRWmstcgLm9QWYKkHmuYX3IYZck/qXxuiBB5Ck1P7O8YAFNAoIm3C8bt8PAfyiV0=
X-Received: by 2002:a05:6830:498d:b0:708:f88a:e3e7 with SMTP id
 46e09a7af769-709009f09f2mr14914971a34.34.1721754245650; Tue, 23 Jul 2024
 10:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb21950b-286b-4630-9052-cff9e7e56337@web.de> <CAKb7Uvj513trzg9bVGrjcQ8CfO4anCq7e9mgbD0eZKh=zNLy=Q@mail.gmail.com>
 <147bde68-2b66-4e0c-890d-30571a99eee1@wanadoo.fr>
In-Reply-To: <147bde68-2b66-4e0c-890d-30571a99eee1@wanadoo.fr>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Tue, 23 Jul 2024 13:03:54 -0400
Message-ID: <CAKb7UvjE-xLBpV637qQ8DG7odnoLvaPgBK5QRThiGYZF_tgwFg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/debugfs: Simplify character output in nouveau_debugfs_vbios_image()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, 
	Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>, 
	Lyude Paul <lyude@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:58=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 15/07/2024 =C3=A0 15:15, Ilia Mirkin a =C3=A9crit :
> > On Mon, Jul 15, 2024 at 7:49=E2=80=AFAM Markus Elfring <Markus.Elfring@=
web.de> wrote:
> >>
> >> From: Markus Elfring <elfring@users.sourceforge.net>
> >> Date: Mon, 15 Jul 2024 13:36:54 +0200
> >>
> >> Single characters should be put into a sequence.
> >> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one=
 selected call.
> >>
> >> This issue was transformed by using the Coccinelle software.
> >>
> >> Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>   drivers/gpu/drm/nouveau/nouveau_debugfs.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/d=
rm/nouveau/nouveau_debugfs.c
> >> index e83db051e851..931b62097366 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> >> @@ -42,7 +42,7 @@ nouveau_debugfs_vbios_image(struct seq_file *m, void=
 *data)
> >>          int i;
> >>
> >>          for (i =3D 0; i < drm->vbios.length; i++)
> >> -               seq_printf(m, "%c", drm->vbios.data[i]);
> >> +               seq_putc(m, drm->vbios.data[i]);
> >
> > Is there some reason this whole thing isn't just
> >
> > seq_write(m, drm->vbios.data, drm->vbios.length)
>
> Hi,
>
> I don't know if my answer is relevant or not here but:
>         for () seq_putc();      =3D=3D> will fill 'm' with everything tha=
t fits in
> and
>         seq_write()             =3D=3D> is all or nothing. So if 'm' is t=
oo small, then
> nothing will be appended.
>
> I've not looked at the calling tree, but I would expect 'm' to be able
> to have PAGE_SIZE chars, so most probably 4096.
>
> And having gpu + "vbios.rom", I would expect it to be bigger than 4096.
>
> If I'm correct, then changing for seq_write() would just show... nothing.
>
>
> I don't know if it can happen., but testing should be easy enough to
> figure it out.

The vbios can definitely be much much larger than 4k. But it does
currently work as-is, i.e. you don't just get the first 4k, you get
everything. So I think there's some internal resizing/extension/etc
going on.

But I totally agree -- testing required here. Not sure if the author
has done that.

Cheers,

  -ilia

