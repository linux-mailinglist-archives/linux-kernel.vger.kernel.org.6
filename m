Return-Path: <linux-kernel+bounces-547504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351ABA50A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C6F18891AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65825335B;
	Wed,  5 Mar 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7u8ZoTr"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80862512EB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200515; cv=none; b=Ho/BQQXx+1/GQgnNkH/QeAwuQl/INjAIAs2GeYITJb0T7QKBalediicBSUvZLQTRES05eJ64MHfSiIlj0FrhGdEP4fxErrY/AGJEptz1TqJ4+rB9NuFZch4Nj9haLEuCx614EH3xzB1rjd0Q/jSqBESs4qt4Fpweo1gWhf9tJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200515; c=relaxed/simple;
	bh=C11VRQlXgloAHIxlkDazcBVWyuIx7+EUap5lDdoh7tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOEpSYMqlxpeN6NGnJgZXi8CG/SqfagIWLx68kVV2286oF2xgKx/+KwdcmqWoFlic6ExrzpWqTOca/JpdSSqJhSIW3SHWl88bnRm+jgszTZ8BpJc8vl2SI1OSSPH0uO/o5Mz6XoS83z+tEHMBai9wT7kh6pqozljbJDmuRl5bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7u8ZoTr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so203474a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200513; x=1741805313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLW0d7wXv47ixRls1JtfTqesQTLc2Su7rB4a8OZt/Z4=;
        b=a7u8ZoTrmtulIZnzxm4ORVqSKmSnDMNBGd/+PGvCC6k6jpQVuZ6frEfG9HwTFfk13O
         kxMEv4r80JpZi2KdlXuPUXdIt7KnRIndiydN4zMPm3//kwasVeXgPSC4Cwy9wF7MFvA1
         W1sxF0ppjMQjtZo1fXYRDIMZca/m+e4mvwt9EU0BDIzUWMdO01vtdgtqLX5zeLBleLDp
         ewl1za/Q6UGfRv8Zv/d755gZloN9cu7D+y2/JYg0cGZlDbiFId9HECNKwxu5n5332ulI
         klcqsNOx0kfK9dUHiw1EzvQZBggNRGUJoW6Xqmnw+i/2E9kh/pWxzSyishipvrn4cw6F
         oZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200513; x=1741805313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLW0d7wXv47ixRls1JtfTqesQTLc2Su7rB4a8OZt/Z4=;
        b=eF5f1pzKBPJCxxcNyEsBtkq5I7/bTcNx8L4gyTrwMJ6wtGyYSRw3K0Y9m1SXdC7X5s
         jpgEh85tLG4/0Vw74pyIk+Om7hDw4g8kCp2QRNeh6+n2sMgRjKw1HE58MMgY93MHLtG3
         aJIuTUmEQSpmUdQLvRCcSEL/M0M2t/x29ATYwV0VFICpoKy0/zXwhsIBM2VsOZ5ufhzj
         zLuzsgCJugEZ9mpFQFcx2N6/4ogSkFPkqfsL1gzj9QR+T9URTiKufwjXJ4I9brFOMPCY
         nCC3WJHEyEpSKNJnprFy//+SIiZvicFJMbHqs+Znau8ASFrDLrHU2EzrR5EA+dv3jrFP
         8wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX4rSh/bsZe5ybcbJLFgWN/xXHx4H1bPq1uY8s6UrnJbHWO96N7ISRDqMDJgOdHjpI4DZeHflpq3+tydA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWrwEReJ01jVyoK1+uJb3kkH36yol4oWdaBihzFjUcTbiZ3Lh
	4WSRfVldpvDc5VUAw/BhVW6A9jJ72EehYKztIx07ny4RpvJ2LYOVkzU3jQ5WWDdPT2VLi5BAkEc
	Pa03JmL96b/p+JL9hhC3RJLq+u3A=
X-Gm-Gg: ASbGnctsNXO2FI5seGAlI77y9hvoeKroodWvQV9792iNbTsReCi9PBPMJbmNPXsQ5zT
	m+yBY13uP+DfA2hY+LjQONb3gTJMhY4g2nYeEb5F8odztl+F+sCsjGcyYsOHkvRoQBfSh2TkqWN
	W7StSjRthJq5xAQtDnrZu9OJwSAA==
X-Google-Smtp-Source: AGHT+IHNy0Uh0i/4Vrewjh6yuoSTfhZDAoTT3pE5NxHvmoBeQzOjLRKXO8Aq7wY5/pRC2taKbqHofwdvOoPmBHTX1JE=
X-Received: by 2002:a17:90b:568b:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-2ff4be6c73amr2014043a91.7.1741200512864; Wed, 05 Mar 2025
 10:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305104057.3416-1-hanchunchao@inspur.com>
In-Reply-To: <20250305104057.3416-1-hanchunchao@inspur.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Mar 2025 13:48:21 -0500
X-Gm-Features: AQ5f1Jroiidha8Du4iLEC0d4NUHuwmGgvoqBM2eAEDIOIX64Uk9J5X65ktxjK1w
Message-ID: <CADnq5_MveLhZFX0qjp5=RsK1FV5n1jM13giX3BA4Lz3vXvsVKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix inconsistent indenting warning
To: Charles Han <hanchunchao@inspur.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, Jesse.zhang@amd.com, Hawking.Zhang@amd.com, 
	mario.limonciello@amd.com, tim.huang@amd.com, Likun.Gao@amd.com, 
	kevinyang.wang@amd.com, dan.carpenter@linaro.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Mar 5, 2025 at 5:41=E2=80=AFAM Charles Han <hanchunchao@inspur.com>=
 wrote:
>
> Fix below inconsistent indenting smatch warning.
> smatch warnings:
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:582 amdgpu_sdma_reset_engine() w=
arn: inconsistent indenting
>
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 42a7b86e41c3..1037a2f9e3b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -579,5 +579,5 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id, b
>         if (suspend_user_queues)
>                 amdgpu_amdkfd_resume(adev, false);
>
> -       return ret;
> +       return ret;
>  }
> --
> 2.43.0
>

