Return-Path: <linux-kernel+bounces-440469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4079EBE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F716020B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A023EA86;
	Tue, 10 Dec 2024 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P0HPupCZ"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01223EA67
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871103; cv=none; b=nnmgvzOyyYt4RU1FDB3bYown8lejzed6XnWGO2j24kLKh2Uo1115d3akdTCmeJIvVA5xdA06hcjxMMus1cC/0/B8UXU6FZExKt5KAO1CEtklTw8eoHGVh8M0pl1819MFJJJPY6o/4eWt5F7TmMX+5tJUfl7iidnq/8ntIWDCpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871103; c=relaxed/simple;
	bh=z4+6bpseOOTD/WiP4VJ9xEYcKjeCBnFNzmYMq42PIxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQUZJLmjB++C4b2B4hVixEumI5xtqXhNvicIm9OUqGXaPPsaOb7tDdD3LsNJfsihd4F3k8eE9+G83vhctKyv3xuWFvUu1bKjknaGcUUldaXg0XEfIwomlhEjQT356TdHH5jGK+Q3zIx8jysCxe0Z2boauaUkh57oaHt3C9PECgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=P0HPupCZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e399e904940so4805999276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1733871100; x=1734475900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of5DDpOleFOvOX8j9iWLw9UYEkdTXgB6XMX5OY79lzQ=;
        b=P0HPupCZkL5D1YjvZwGVtDoPiECjiMLZFGtiOYKcHuICyqfBvkqO8Cj+JEGMRzMIrP
         5OMwVCxbFlq6DYM6sAMtUzzOLRRjWWEdaYhjB0aWHAfj+qlsJ9LY3uTa2+pJ86Y6UohI
         kYKNbG8ry7WqQeIUqtC3Q7epg2Egdn0INPNOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733871100; x=1734475900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of5DDpOleFOvOX8j9iWLw9UYEkdTXgB6XMX5OY79lzQ=;
        b=SDwX57ns931HABMSch1Q8rqWKxYOb31IsSdw+jjitd3O1lNvv/cSi6qLx1aol9oyZ4
         4SF6qkSPXFXEr//Cz+zCHanXv89q8Y/IwbnIhYAFP96IPL1WTOov5Lml2j2JGDOjTx87
         JV3dhEdEFOpxII1aRssjeocyrW8hFSNJeP1FAYdbkTK7VQpNT0HeAND2AYHiulTcHnaE
         ga4eP/DZMPzJija4BLvHbRmP9EWOQulngEGAmAB7iPSLMYDwFdXCLI5OwcJ7VkpAlzAc
         1IO9ojNXgVapydsFGOC2yvxeb+AqHDFPXZJ2HOjIa2LhkwG5ncp4YWmk20TmH5bke9Bh
         reWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5m6SkcTlVKEvHP1RaP3s6rX9veVZM3cixEkEA4XhOpcnwTATpZ5Bqib3g083wjkDPDqpAHJdlDTUkiHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLBDgYPo51XSPWnLDFB2J0xewHA/dAKavxkKdILsE4uT+c07s
	XrVXFcHYr0/dAj4Imf7EoV2Nx4g7v3RMXeaQ7WjLkyz6rPm8DmxEwZWc6VIMEizbme95VM9EUMr
	RmlHGVTI/hAHXaU/gmZxBkJDTIdN93knvNdAEEQ==
X-Gm-Gg: ASbGncsTDXlUdatvDR+mOKaNnbaxEZRayf+P7K5xYjrPmGBw+IWpAsQdRsB7+BiroxE
	npU1kzR7AAhDs4ZpaDrEVSvkahBpZ/2/CtxSN
X-Google-Smtp-Source: AGHT+IGbV0oeq+nxJsXu16SzSxYPduPX1VVqzU+lMF3Y51q8XM3CkxJyeEHqg7wjGvxVi7LtqKCG8kkaYpwciZTvMTk=
X-Received: by 2002:a05:6902:2206:b0:e3a:235a:4da3 with SMTP id
 3f1490d57ef6-e3c8e48b8e6mr1094296276.24.1733871100343; Tue, 10 Dec 2024
 14:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com> <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com>
In-Reply-To: <20241204-udmabuf-fixes-v2-1-23887289de1c@google.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 10 Dec 2024 17:51:29 -0500
Message-ID: <CAEXW_YRb4PsFgEvHW2QBDY5dxJ+aoMTn3qtj5v9eboxO3SxPLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] udmabuf: fix racy memfd sealing check
To: Jann Horn <jannh@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Julian Orth <ju.orth@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:27=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> The current check_memfd_seals() is racy: Since we first do
> check_memfd_seals() and then udmabuf_pin_folios() without holding any
> relevant lock across both, F_SEAL_WRITE can be set in between.
> This is problematic because we can end up holding pins to pages in a
> write-sealed memfd.
>
> Fix it using the inode lock, that's probably the easiest way.
> In the future, we might want to consider moving this logic into memfd,
> especially if anyone else wants to use memfd_pin_folios().

I am curious, why is it not possible to have a reproducer for this
issue, is it not reproducible and is theoretical?

thanks,

 - Joel

>
> Reported-by: Julian Orth <ju.orth@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219106
> Closes: https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=3Dobr=
imeTgpD+StkV9w@mail.gmail.com
> Fixes: fbb0de795078 ("Add udmabuf misc device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/dma-buf/udmabuf.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 8ce1f074c2d32a0a9f59ff7184359e37d56548c6..c1d8c2766d6d36fc5fe1b3d73=
057f6e01ec6678f 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -436,14 +436,19 @@ static long udmabuf_create(struct miscdevice *devic=
e,
>                         goto err;
>                 }
>
> +               /*
> +                * Take the inode lock to protect against concurrent
> +                * memfd_add_seals(), which takes this lock in write mode=
.
> +                */
> +               inode_lock_shared(file_inode(memfd));
>                 ret =3D check_memfd_seals(memfd);
> -               if (ret < 0) {
> -                       fput(memfd);
> -                       goto err;
> -               }
> +               if (ret)
> +                       goto out_unlock;
>
>                 ret =3D udmabuf_pin_folios(ubuf, memfd, list[i].offset,
>                                          list[i].size, folios);
> +out_unlock:
> +               inode_unlock_shared(file_inode(memfd));
>                 fput(memfd);
>                 if (ret)
>                         goto err;
>
> --
> 2.47.0.338.g60cca15819-goog
>

