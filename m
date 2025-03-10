Return-Path: <linux-kernel+bounces-554510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88206A5990B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6021645A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93975189B80;
	Mon, 10 Mar 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QynXcZ7k"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D419D8A9;
	Mon, 10 Mar 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619011; cv=none; b=hs5W9BVIgKRmFpSjh3F/sGnsLH0m1tX13HtEaiPClt2CbhpourudPDXlajsWznL3V/JCYO0vX8GSF5nTwF/KHa2F5G3rUL9vkcgj7GCBX+H2pmx3rLJK2De5cXE2Vs2LQKAbuY4hJhzi5XT6ddNaDDDNsfa8gZgW3+6HAdeOh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619011; c=relaxed/simple;
	bh=qHOlMVOSQWZyR+1T7W2LmKujsTHuLbGrbmBhJNI0i1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrjmX0uM+q0IWVPaQO1mCUt3utLb4kr/hFfGs1zlUqUmuFZBAx0N629zm1wmxURntacwsQ0ueRxnFvnY/E8X/QiOgmFweKYYiaFLN6re4TzU855Ic+67u7rA7YR6bf7rkA64Pm8CExF47cdqDzBCQovH4bcZv0246znyKTu1pIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QynXcZ7k; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so1206538a91.1;
        Mon, 10 Mar 2025 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619009; x=1742223809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJOdMi7TuJtokqVht55QzyLtEZiNv+1M/RG0LMYucBg=;
        b=QynXcZ7kb539KDfLo3uE9WBB+cc85Np8B4DMXW34VB9pEfMrtBw1RiLONATZ1DQXg1
         GQv31r6IigNIzpOJnYamMl7nGO5vPyibC/jPkvvPFD8eexPObe3aB0o5gg5hyrJtQfIW
         qxWCvZwST8xFpu15fpoImV39SEgJ7YaM9qYfv29MDG/H09ZTtaosRjg153l1yuZyGF+W
         l3auF+jXoeDKjcTnYhyTYi2LVSAdvvHpy9Jn1/F8i0qvUGGxTlI4OoYPfBc5wL1k009z
         zpQV7fVGTQ06XiO1pVvfFqxOgvhGiSL+eMUMKzmo3HEiv32ZKzgYiop41KwliTooA8jM
         KBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619009; x=1742223809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJOdMi7TuJtokqVht55QzyLtEZiNv+1M/RG0LMYucBg=;
        b=kglxx1W7Cl640tVYAVU89bw2cfuZbYe7734QUV/8meuX+JrfNpDCkUxOH1Mfr0A6+f
         6lE3j8QsR1Mxn9fbCfiRYdq4ICCTYn6xdUY9kmZPahFNkKU04iSLRP2b7zXYXEoA5qTR
         fZMIhu6h+cnPmRni/igMqZN+pvWqvj8J6/gq7MW1U1YSBjzsWaWbq5wRn4wVZN2uGOjN
         9Wb+wGBzNS3ul5vZXsUN+K5VBUMWfJX3b5Y4ZJqyOndcsgJgvhTb0ZJyhgIK9lIgVnQE
         mudXNkvGxoREdiMx9RQd8Zt9CbBHv2C8jOyfkZeY1U67c63bbSmA+6Zf7m/UDT2zWykJ
         ERlw==
X-Forwarded-Encrypted: i=1; AJvYcCWKzKXDuA2JAoPCtTiOMTxmu8xsPYNEI/ZHJqGffUO/ianouCIuQ2Eo49rnmbZzwXV1TusNbCtGrOCmOrHsldY=@vger.kernel.org, AJvYcCX2wAUwFR0m8OFvBUfhs01kooEnePwOk+wx2Gp+lV6hfEaLjMQxECZNXcaujuvzmuhCxEzDSB3uoNMkzf5o@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF0alckWADGaOZwRtD2N7gI4akldl2F/6Alz4xq66A3G8VYCc
	J1B1M0TvEcEt1YtFtEUbYUpMBJcZvEbEJUGS9pMIO6nxBtmW13Q/3kmxUMV7+ZHh3yTp8P84yj+
	bdcBHq7iQo/eoc91uzgj6vGtvrlA=
X-Gm-Gg: ASbGncvPThB8fqMQkHB5refcaetBpVj+Ia3DjoROkYiqh2MK5AHTaY3C/A1TGy6NYDF
	FMIZgjtK35swOEnYigalLJD4457tBMxhNHFe4TwcZF3GQcduuP0pATS8CPB9bPTsomOC9uvGyVv
	+Tm7I4NsgqgNbj+tbMXugvocN/N1EdxgpK7SX2
X-Google-Smtp-Source: AGHT+IHDWjvbsImoIvEZ8NiG696nfaDNI6yarD9NR7psbuORnZuZ4bAHU5Szn7yUD4MzuaZiF/MYlkPQ025P9W9WkVQ=
X-Received: by 2002:a17:90b:4c51:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-300ff94c15dmr50225a91.8.1741619008631; Mon, 10 Mar 2025
 08:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ece8324f-0d58-4c83-adca-7187f730c56f@stanley.mountain>
In-Reply-To: <ece8324f-0d58-4c83-adca-7187f730c56f@stanley.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 11:03:17 -0400
X-Gm-Features: AQ5f1Jp6LUX-uLM6Bz9IEwc8fZsKBb7jSG1dspE9kwAMpt4MWUT1TRhw3ipvpKg
Message-ID: <CADnq5_Mn0Mqr4vbiLCGAgUa-rxa_YfM1=vSCtQsByquwN8oMFA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: delete stray tab in kfd_dbg_set_mes_debug_mode()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  thanks!

On Mon, Mar 10, 2025 at 6:48=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> These lines are indented one tab more than they should be.  Delete
> the stray tabs.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_debug.c
> index 12456c61ffa5..ba99e0f258ae 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -357,12 +357,12 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_d=
evice *pdd, bool sq_trap_en)
>                 return 0;
>
>         if (!pdd->proc_ctx_cpu_ptr) {
> -                       r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
> -                               AMDGPU_MES_PROC_CTX_SIZE,
> -                               &pdd->proc_ctx_bo,
> -                               &pdd->proc_ctx_gpu_addr,
> -                               &pdd->proc_ctx_cpu_ptr,
> -                               false);
> +               r =3D amdgpu_amdkfd_alloc_gtt_mem(adev,
> +                       AMDGPU_MES_PROC_CTX_SIZE,
> +                       &pdd->proc_ctx_bo,
> +                       &pdd->proc_ctx_gpu_addr,
> +                       &pdd->proc_ctx_cpu_ptr,
> +                       false);
>                 if (r) {
>                         dev_err(adev->dev,
>                         "failed to allocate process context bo\n");
> --
> 2.47.2
>

