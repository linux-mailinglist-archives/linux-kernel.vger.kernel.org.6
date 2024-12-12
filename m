Return-Path: <linux-kernel+bounces-443527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779D9EF514
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2310F1941E14
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06D1221DA4;
	Thu, 12 Dec 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X10fCbuw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F122A7E4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022555; cv=none; b=TZcHTnIGP+tWZfK3T9QMfbMXj7E6DoQvSsvg1iqZL0O4jgGXSmH8cnDDc7ElPef8eJdbvBOBnZU9Wb4Q0jFh/b/4oqhBn6baZCtRXwISaanzCLgRcEO4AMuCPpgIaBxdpr4F9lK4JGtVxERqD6CHZr8POzEVzyx3UdGe8r8yHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022555; c=relaxed/simple;
	bh=DUPLTJqY4Ur6JMhBNFg0MXDhKiTFzB845Og83/T4KD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvRvtigWMBTCJODqIg8ufVGhLWklCqHT8R/kXfPKaQZIGXbaad+9q3doIiDazdvtxNpOlgSWlTqQNNKMMIHRcO7Ke+ATaRlaFUwQD8tbs6ZTMQloB+bE2VgnoAkfQD4THF9hWDz4PGQaerBu7u2YAGaLY79949Wd/UxCBUenozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X10fCbuw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162f968cd7so1417815ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022553; x=1734627353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzlIoW7L3/4b18+N+ENiSNhzaS6ksog5gbyke7Oxry4=;
        b=X10fCbuw7ryHxjLXOu+At/Wyi1w6kKJmWPS0L9gVLBUHEz52FxodvblIQTWkzFduDg
         ak5fA3UD0b9q/BUH83wJG/Kov7BU9YdRWq2FXWrVWKbgj+UFkjxMs8obqS6p8KKWaldC
         0oxMCrhijKDDvS2CUEuRXkDrATqgGXaCJMfTDC6jCfjyLp8A1nuux2bvp4TPEWJLhAxE
         XWHcb0fTji0XIo1/vlLOwU3nBMPbvdOowY92Y2T6VbPAoUfghUpxpAY6v93QYX8SPaTA
         PP1i+uAonkBJPhlhgNLqQyLG03p94VcT2/K8lohkvujj0gBbfKz/9vGTFXXnL6lTQuPK
         UTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022553; x=1734627353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzlIoW7L3/4b18+N+ENiSNhzaS6ksog5gbyke7Oxry4=;
        b=cueCcyV42LV44vjSJmlwXZqCp1MorHOVyIZBVsyqM2fStATxGA5BzY/Px/W8hvJCCx
         VS6btDhQ8fNxIl/lD+xo9PcsRUiaRW/O6yLEzCFZ2r++gcg4lxgouaj+bO/D3wNc7haQ
         dVCKZSUtlLEeGMVd3nKkE1w0WFogrmFA74F4zuMYe6V1xuo2N+RthgQVQM9AUL/9v0sL
         Be8Tr4tq8nai1OgdYegjBVDWfP/Z5+oR1LuoMUyXjRmBfmjn8yOvyKt+yVQ7TFbjeE+6
         /bUB/Zv8DzePDdPLFsZ9+tBhHyS2SIXRCgdT/JRDgTtFX2ju1oYQ2YSjobU4GuJvijb5
         TPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHMy9ELNdaby05xR3/fFt6HlZgF+lWG4RVFd+JO10YuhowLDNw4sVZyM87gg8AMuZuPnbU3+JBPLDkwR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmghv8vqArHXCNVYZ7/LBjOCHe0L3Sq8tOAjo9pRc61XM5IIar
	Q6+lDqvvgaRFGV6pon8TWietI/ELddIhLI88vQ3owJYhc4ZqSMfIo2eztpfia7RlGMAuKoKcVoK
	Nuq1bvrJnQVQMbMLepZB6OkGg3ZSidg==
X-Gm-Gg: ASbGncvgP1JT/k5hElOt+B94huQLpqNpSD8QcQYK75oMe7zwTke84wiMQ3XUrIlnv0f
	2tfGwyV/SBnq3ibM9mfyT2BRsBOn4SFCUOPoQzg==
X-Google-Smtp-Source: AGHT+IF+Mlf23HjLPaz0/T9fZnjcn4ERaK3oOO0keRJwk9CUb+mw8/2C78O2JyWTd+4U016kKdzujVlhA989rq5VYMI=
X-Received: by 2002:a17:90a:d993:b0:2ee:f64b:9aab with SMTP id
 98e67ed59e1d1-2f128048ed8mr4161251a91.6.1734022552742; Thu, 12 Dec 2024
 08:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212014717.14286-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20241212014717.14286-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2024 11:55:41 -0500
Message-ID: <CADnq5_MvwHrnyr=0smZ7PqG8JqD1eXv55iK9kUi1qHtVHsE4Rw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: use swap() in update_phy_id_mapping()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Dec 11, 2024 at 8:47=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use existing swap() function rather than duplicating its implementation.
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c:185:47-48: WARNIN=
G opportunity for swap().
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c:125:53-54: WARNIN=
G opportunity for swap().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D12335
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index 309c7999faa6..6fdc306a4a86 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -120,11 +120,8 @@ static void update_phy_id_mapping(struct amdgpu_devi=
ce *adev)
>         for (idx =3D connector_cnt; idx > 1 ; idx--) {
>                 for (idx_2 =3D 0; idx_2 < (idx - 1); idx_2++) {
>                         if (sort_connector[idx_2]->dc_link->link_enc_hw_i=
nst >
> -                               sort_connector[idx_2 + 1]->dc_link->link_=
enc_hw_inst) {
> -                               aconnector =3D sort_connector[idx_2];
> -                               sort_connector[idx_2] =3D sort_connector[=
idx_2 + 1];
> -                               sort_connector[idx_2 + 1] =3D aconnector;
> -                       }
> +                           sort_connector[idx_2 + 1]->dc_link->link_enc_=
hw_inst)
> +                               swap(sort_connector[idx_2], sort_connecto=
r[idx_2 + 1]);
>                 }
>         }
>
> @@ -180,11 +177,8 @@ static void update_phy_id_mapping(struct amdgpu_devi=
ce *adev)
>                                                 }
>                                         }
>
> -                                       if (swap) {
> -                                               aconnector =3D sort_conne=
ctor[j];
> -                                               sort_connector[j] =3D sor=
t_connector[j + 1];
> -                                               sort_connector[j + 1] =3D=
 aconnector;
> -                                       }
> +                                       if (swap)
> +                                               swap(sort_connector[j], s=
ort_connector[j + 1]);
>                                 }
>                         }
>
> --
> 2.32.0.3.g01195cf9f
>

