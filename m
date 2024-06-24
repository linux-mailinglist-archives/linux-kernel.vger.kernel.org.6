Return-Path: <linux-kernel+bounces-227414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AADB9150ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1491F253DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4581A08A4;
	Mon, 24 Jun 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWSgt3Bx"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6521A072C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240458; cv=none; b=eUNhCQEuxQZw1IoefV+/a/HxQJ6FfAFobFqYKkzx7oI9ypziUleoc9xU/SOZe6cQQqZXq9EAZIvPnZ9uXvlZJXM3m/aZD534ZCLTpIKbH9ma91b80DHcuf2KOoX5lMRi6OM64aYKJhT6rG0aVAWTUjqIwGArpRRoCo7hhZnOyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240458; c=relaxed/simple;
	bh=RDaXavdadY+qSUH1RITtVJuWOa+egkmXmcu3oWVz65c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPP4xF0HFxVwqBbiICeVzvJdsHSr2/I2NO63GHMe6SHe/Ov3z1hi1tTNnqvmB25Xomhdq6fibQvKW7X0o63/37D//2RKbBzCEV10lGG3lqTpjxz43k9ttYbdWJqc2XDz4GVbp4xrDTgVrD5/wC8oUCk81PO7CMUqPAkkOF6Tvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWSgt3Bx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c7b14bb4a5so3037249a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240456; x=1719845256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBn1Q+iZWIRv0A+I80kD3XYsNEFwO5sfzz2jLKLOUCE=;
        b=LWSgt3BxHfza8LAme4PoIpm868VqWHjYYQZcC02htO3o9ocEEju9UBV1vT3W2K3pRs
         6DzK08xNLMAD09cnyfGw9zgev8O5jsoDy+e7KcFYHiRhjKKk7KuLOwWAnHw+MqQoGhPs
         Djx1Tz+a36UpL/Suo9wbUMKUEmfiphaGwTKOJwfbjIBAxilMfUNPV+94Lhq1AZwZp58/
         IvrXX4qjpnUU4CdRiD3VT8Jvc/N0Tt9f4pF0IdlonZB6Zcn26bBj99Q13ZLMMDn7Malh
         qmnOS+/Xl3n7iAcCy6R9C+0as06Vr3yP/sdpsGcgTEb8k/gVDzeh7l5SS5jo2aR8DQ2i
         inAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240456; x=1719845256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBn1Q+iZWIRv0A+I80kD3XYsNEFwO5sfzz2jLKLOUCE=;
        b=JOY3gE3zeEn308YTdKOvboaVwhE2xATXppVclk+pBizcR+mFyI0duso1Dl7gbFw7CF
         +wDeO/c+gKuCUsTB0io06cE4o0LXsTB+454fCdaGkqq3/In/aIzbB8Q2oPA+s2gleqoX
         Im5ougJk0/vKCEuJa4O5AYjiCSOANvgMGBtBafCVN7tPSYgv2RPetHfxmk2VzduSU7Bb
         XYTpMZP/i8j8+M+l0kh44e6JRytJ3wz+mv1WQLeIU8oNZInNIxDfVbSuPiLoiPX+PLeM
         uJ2naJAfIEdXTVTU48cGv0TC2F5Anl3B6ds1fW3CsItpOYe7LKKG97PZy89fATYnBXvX
         slZw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc4nWwVOdnr6pyMAQNQIdTUqhUIEk+0Ya6P6twF8Bhyi8Ybj3hhm0rSaPP/jTk+4p8IGQx4UH5Wg5Dktic1YGR/LCkmafFmaK611V
X-Gm-Message-State: AOJu0Yy6RaNEYgZs/3/CLsg2/UogjeKTNpwDzHT8SH54cfY7gQusVYCn
	9vMokUnFuFzi0lrWx46ERbfRIZpkW+uaQJnJYsHe3jqQe+INPzRWoyxzUlQ7udj9fJXOaFqWrXp
	VzUdZ8J2G80NAgN4RYhrL3bJvsOU=
X-Google-Smtp-Source: AGHT+IGvKrhZtClxc1QzR2rA26guU9NSp5NVu4sGuwHBa4tzlglkdOxFnTljJBijc7tWG6aqbNG3U6xVfJPmK1zCzoY=
X-Received: by 2002:a17:90b:f02:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c8a23bf31cmr1060708a91.21.1719240456007; Mon, 24 Jun 2024
 07:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624022225.28655-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240624022225.28655-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jun 2024 10:47:24 -0400
Message-ID: <CADnq5_PzZMNmJGnxMh88owr59erSHaOZpgtwrVWjjdoNvC++YQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused function reverse_planes_order
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 4:07=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function are defined in the amdgpu_dm.c file, but not called
> anywhere, so delete the unused function.
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:371:20: warni=
ng: unused function 'reverse_planes_order'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9402
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4b86b30eddc4..1e0e33b565f1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -368,15 +368,6 @@ static inline bool is_dc_timing_adjust_needed(struct=
 dm_crtc_state *old_state,
>                 return false;
>  }
>
> -static inline void reverse_planes_order(struct dc_surface_update *array_=
of_surface_update,
> -                                       int planes_count)
> -{
> -       int i, j;
> -
> -       for (i =3D 0, j =3D planes_count - 1; i < j; i++, j--)
> -               swap(array_of_surface_update[i], array_of_surface_update[=
j]);
> -}
> -
>  /*
>   * DC will program planes with their z-order determined by their orderin=
g
>   * in the dc_surface_updates array. This comparator is used to sort them
> --
> 2.20.1.7.g153144c
>

