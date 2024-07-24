Return-Path: <linux-kernel+bounces-261294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4F93B552
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC42F1C23A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FB15ECFD;
	Wed, 24 Jul 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H25L8xJ/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047F14B978
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840142; cv=none; b=UHZsSifZRxLS7wRVgWM2nvkAbXfNEMvESYBBg4i+wjGtdeKB9f7I3ERx3hS6dzxA7u68nCSx5+4l7B3UJBEUy983lmXJbbykWoQEHdsZ9LoFzLfFtrxUAN7CGqumeGHwO2JHULAZYKnAy+ocAz6nZV6LfudiXYQfzbllaAO5Z/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840142; c=relaxed/simple;
	bh=eKXhaew8aYjmDBx3Cbmef6BS8iN3X3GsWyiTBYlhNzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IV+y8Sm9xb9k4fiSgf6F2KiI8aZQKlOknWd1teslimIRkDb7IqlqEWnn+o92Rd0JNXnX78wRa4clVMQAIJTokxoszakkBD3wK53EEQ+M1F7HZPFdFAVlssmtpqICagjabtz15fKhO+GeruvcPpfDB6Wbuj+9e4l0Z35gYiwgroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H25L8xJ/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a92098ec97so7752a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840140; x=1722444940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz1eZFacofG50PzjABJcoZwyNtMnxyd2cyFpXgSDLu4=;
        b=H25L8xJ/CNCwJnf34EGkEI55adNAL4RfBEiTFAQJsWLNakf+3zJcZu2biMeCraP41G
         0XrdtYCRiiUDKwoKi6G4/P1IDvk3qSwALIV0Wik/F8hOFvmWKB6c/4b6Xi9MTso0u0PY
         bBf324eqsnwZ1ydeiaBwMkYUJ1qB0kbDeDUYNuI3BCXFSAKb8C0E4WcMsehgnXRm2MD3
         Arbvv6u2600u4ygaJ3qJtGSJZ3LfqRxCc9aTuAq46q7RsWiQ5ieuffXze4K5sjj/uNfk
         06EA5LoKJBGTl3lGq3J/eoIGXVIWZealFi6pADS3k1z1s3GlD17Sv8046Crx1kw/cVWa
         dG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840140; x=1722444940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz1eZFacofG50PzjABJcoZwyNtMnxyd2cyFpXgSDLu4=;
        b=r0FUES/U8SPhsEpkX0U71LvZ+TBep6f/t5U5Ya6K3AxLErQNYcBfP6RhyiPm+EXqre
         wQZaKVLjrQHoX9SnCDrPgQ7dGXM4wBT8i84BUoyYMD3bXqDi6B7GINY2cZVxW9jXdQBI
         5TR7D8akMY0YFiLD26VlZXO3RY8CgOpFWZW8+15EoT1/L43/2mJB5qy8LO2DNa99QcFR
         83krNAXRpPiro85UN0sjBz9TTG0mW6lh4R8kVarsoGIQlp5kkE+PpJ/MaAM3yyRaPscJ
         iqG14V2x6vRtd2UovV27f80C12vd3CB1Z3FvNnCzsnXvZVwG0AcvvqaWgiDpfLM6BTXO
         I3jA==
X-Forwarded-Encrypted: i=1; AJvYcCW9A4C5kx2JakhEMZaYQDtJl9kLhF59sGJShsypIjdRm0z5q4Jl31xDDnTyhlpDEAZhpPSnxkQ4DArR4q4oOviB2W5s5LLXmq/eFGCd
X-Gm-Message-State: AOJu0YyVdvlol6WtnR6gdavO4oFn32TOIjJN2hWVvVppTEVqguJcJQmQ
	iAxsoZ4mdLPMbypcClzxjmzQEHDii8JiPp5BtK2ATBeH9/u9jjspJxR91IEYWhRt1dSZauM04zN
	5v/UhgI0QKu8ima6kdxGVlhthqfo=
X-Google-Smtp-Source: AGHT+IEI/jYWEqsiZsqhBV9hscFEVHePulf2aw0vBqzWx/Df2tLi6FgJfCRqF8NmHRQV0P//V5uvwg4rUzgjAjaolbw=
X-Received: by 2002:a05:6a20:12d3:b0:1c4:7032:253d with SMTP id
 adf61e73a8af0-1c4727e2f31mr626089637.6.1721840139863; Wed, 24 Jul 2024
 09:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jul 2024 12:55:28 -0400
Message-ID: <CADnq5_M=Vy7g2zFCpbUEY_Gb3S7zKvfPCUxqtyT-_7ZTXatu=Q@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: use swap() in sort()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Jul 24, 2024 at 3:38=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use existing swap() function rather than duplicating its implementation.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c:=
17:29-30: WARNING opportunity for swap().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9573
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c    | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_=
pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pm=
o_dcn3.c
> index 717536d7bb30..8e68a8094658 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn=
3.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn=
3.c
> @@ -7,16 +7,12 @@
>
>  static void sort(double *list_a, int list_a_size)
>  {
> -       double temp;
>         // For all elements b[i] in list_b[]
>         for (int i =3D 0; i < list_a_size - 1; i++) {
>                 // Find the first element of list_a that's larger than b[=
i]
>                 for (int j =3D i; j < list_a_size - 1; j++) {
> -                       if (list_a[j] > list_a[j + 1]) {
> -                               temp =3D list_a[j];
> -                               list_a[j] =3D list_a[j + 1];
> -                               list_a[j + 1] =3D temp;
> -                       }
> +                       if (list_a[j] > list_a[j + 1])
> +                               swap(list_a[j], list_a[j + 1]);
>                 }
>         }
>  }
> --
> 2.32.0.3.g01195cf9f
>

