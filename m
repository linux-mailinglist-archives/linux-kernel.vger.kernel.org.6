Return-Path: <linux-kernel+bounces-252581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C993157C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAE11C219EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21118D4B3;
	Mon, 15 Jul 2024 13:15:24 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B81850B4;
	Mon, 15 Jul 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049324; cv=none; b=LRWCJLJNtH1Yk2KZ4s/kC6TrVwjtG1CAFdUfzZA2Qc6g2+I32Rvp3X0Hxr5oycdZQ0jC6no8eGcj3XkUKB2RkWjyDSVV1Gk4sQeAV3O3Ub6+baPDfHvkmwHEcDfgXIVSFRaCL3cPQMk02lJCNeLtxrVPKzImM9XhaGGB2g3dwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049324; c=relaxed/simple;
	bh=NDiGhLikZFXheoCYWgdbBv8oB2Fs1Q0tUVp2bO4OnJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNESuLMa7C0A0GtXB1IaCsViaCkLOlM8PSFSHZq1rX/In/I4JvErLgaFEOyw5l6L73TYW2DhmCINlcZ/vgwvwecGf9nT8gUayxUA4LXv0ZolexiBd+xnMW8lRMMBx/iMdHCxL2+VNkQ/G4fcqaftLm2x6ctQxA3DkXa337EDq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alum.mit.edu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alum.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70448cae1e0so2424641a34.3;
        Mon, 15 Jul 2024 06:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721049322; x=1721654122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNR0w8f7DgNm43Yovgh09Jc86fgc4MgJXWKIFtreEko=;
        b=T9J9ELjdDTPeuQ/BbqM6+N9M7+Fpvoo0BdzBjghN8WjNRG5Kdwn80ojG0zi5PWQOPU
         u+qD6DodVvZcTO1BF/Kx5QZsheUa2uW1I0Pn7rIj0aCCyoiRDcLAzrogp8Y/CugeTfWF
         G0R/m0XVV7lZ2eSpw1CKiWd/V111G9nvtjrrBYBGBtARuv7AvdanF53bw9elbJ7m+mwo
         D9hOPvuZAqDXylcKlQm56awR6ObxT1KzBn7uyNIfaBgDYQ8olF29WyJ2rwpT4BDiha1f
         K/f5+RwYYUTjF1Smi8j01kkrihtPaBZzeDVp3g9EB2LUj6oBhOwoZBUodVw/OlNk9Vf5
         M6tA==
X-Forwarded-Encrypted: i=1; AJvYcCUHAtoGI/E1U5CcoN6NkveBimGSIOieq/sMZ1E0oZsB+qXtsJUJEzpINRoSkfYwl7VMwURaSnkYL52tHziZorol6uCb9MrR4+aAoLmAHyz/Q4tI/zN+9m1a7nSo64Z/9nsMxU7OxZYRSBI53OeF
X-Gm-Message-State: AOJu0YynQqKCniBd7r1I3ItMPqJyzVDcR53BNlwVhEAhJtaoYeA+545o
	TUsvnXR1lNl7WUAqqWrg45xtr1Mge5FzRVCWt59dOyE7bFShpq0FkyNV71WUUrFcJsWLq55JYvb
	SfCc6SAZO6sZLZs7YU6hCHFVKyHI=
X-Google-Smtp-Source: AGHT+IHaZDYvxo07Vr9ALMufUbtJ9JDhOtTtJyaDYEF5Vq40o/q+4REDZmuFRwQEdwuzWOGgEhtlipHg6B79axpNsBo=
X-Received: by 2002:a05:6830:4117:b0:703:6e87:a7d4 with SMTP id
 46e09a7af769-70375a1f418mr26514909a34.19.1721049321887; Mon, 15 Jul 2024
 06:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb21950b-286b-4630-9052-cff9e7e56337@web.de>
In-Reply-To: <cb21950b-286b-4630-9052-cff9e7e56337@web.de>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Mon, 15 Jul 2024 09:15:10 -0400
Message-ID: <CAKb7Uvj513trzg9bVGrjcQ8CfO4anCq7e9mgbD0eZKh=zNLy=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/debugfs: Simplify character output in nouveau_debugfs_vbios_image()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, 
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Daniel Vetter <daniel@ffwll.ch>, 
	Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>, 
	Lyude Paul <lyude@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:49=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 15 Jul 2024 13:36:54 +0200
>
> Single characters should be put into a sequence.
> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D for one se=
lected call.
>
> This issue was transformed by using the Coccinelle software.
>
> Suggested-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/=
nouveau/nouveau_debugfs.c
> index e83db051e851..931b62097366 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -42,7 +42,7 @@ nouveau_debugfs_vbios_image(struct seq_file *m, void *d=
ata)
>         int i;
>
>         for (i =3D 0; i < drm->vbios.length; i++)
> -               seq_printf(m, "%c", drm->vbios.data[i]);
> +               seq_putc(m, drm->vbios.data[i]);

Is there some reason this whole thing isn't just

seq_write(m, drm->vbios.data, drm->vbios.length)

>         return 0;
>  }
>
> --
> 2.45.2
>

