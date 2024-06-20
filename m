Return-Path: <linux-kernel+bounces-222932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9EE910A18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39797285EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0E1B010F;
	Thu, 20 Jun 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYsc2dZn"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F21AF6B7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897947; cv=none; b=VfYkSivDiGXM/bbJTFwZJYryr2PIsvpxAArVbqI+6pi4/m3WrGuTfoqDKI0leREJ8qFNhMrDd0l6BKxohcL4s/jiQBCt+x2Fqj1j2AHGOCJt/NllAiy13mity2bRP62+kIi3qDR5lFsh9wXzEJljT/lnf4Mxng+vXB5cr/w45oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897947; c=relaxed/simple;
	bh=1V9gNsQjKpv2yYe/rkkbiCZy1LW3+Gs4HPJP/SDy7Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGFHqrZQInGHzvM08mbV9W9SPi2aLspVjEhfQVguhA+mYdK8qupqTyWoph1kunL8nMM944KYQHaYBlhZ1mW97VNoQsTPcAEamwKE1K2SP1eMOntBhdtJKlf6E9usIaGMmGC8YYMbeeDITv2HDlvZPOHIX6DEfruby2m43GVnqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYsc2dZn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f480624d0fso8123805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897945; x=1719502745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZiM+YF32yo4nDHQ3wUnYbNN+W5ZP8TEo860NNMId04=;
        b=UYsc2dZnHMnVXGqyuRDnRtf4qHMP6REURkrZH/mLT3LPbLOt/Wl3ZmeRMdwisDLdEY
         k94gH++NTXOAEf1XA25gDbbLYzrau28uREM/+hUFJeg/V0XLqSwaRqibmS5nMkno4d8c
         0LNEHyHnwcg1XReWfg++E9Vw7BOI48lRGBKG90QP8/eUEKdio8e2CF+A6WGgxCaNdM6H
         eZS5gCc+WWTL6WY39xCVZXd3Eqf9CpZwMx11fPuE4UBrFiVMyjJJXm7JQez2EIbtymIB
         p39ozT0WONZuHPQ6oCJ35K5lywlNcPthZ9/ch/sD6HXWtFWBNyTtbarqOwyoXBZWcYlF
         QFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897945; x=1719502745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZiM+YF32yo4nDHQ3wUnYbNN+W5ZP8TEo860NNMId04=;
        b=vlbyQSBLgNOkA3uoJHZmr8NgE6ORDOGA8fIT6Ue74SSskNA1DHv2oblLOEqd4mQjN0
         rGfAHy9XM1ACwLst23iQnBXJ88mF9zM/kH9SYjXmKtO9shzgT2eKOqtIe/N90LEFoxDx
         uAYvitzNnY4QR8hwf0TT7OIw9WGaf+3LCKj7yBEb3DfRvFlCuSDTPpkl/XhOmWr4P0DV
         2DFSVF1trBdBw2RZth0624zKy6xSA5Jd+kfzBnZqghGHQ/M0c3ZwwksEAsDBttvTzpKr
         dBEcnPH0OUsEFHAOT2FTAdTnFkH5+zuz71YDD+NgDHU8zVP9Ux4aYxmig2Jbgle3esr5
         8Oyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZIQ5nzuDjv+npbzmEPM2MV6C2Wm0iqPu+1qppqp17o7otzhvYea0Er3CKtZ2xtFhdBUyfNJ8Cs5AuSUeIXmr5wJG+wXzXBd6Z8eq
X-Gm-Message-State: AOJu0YwhezNu1LY5lkOSAvs/pCw3+s654GeQ5m7ri5U3xAHwgfbXUbbQ
	t8pbhfCLx5n8Sewp35cXh/8OJH10QGFxWjkIVxX2tQ5kGetwJ12qUuSmJlVaf7wQZw/eqHU5TOQ
	DmDUUt/5Mhvr45GGjPUUrZ0Qe+wU=
X-Google-Smtp-Source: AGHT+IFs4cCXaYXfPLL4tEu5sHew2ZyfUuFoMGlVDGBf4hJXj5XH8xm9DX67le0YENHbSqeP4ZMKfz7PIq6kLoBgW/o=
X-Received: by 2002:a17:902:d382:b0:1f8:6776:7ab7 with SMTP id
 d9443c01a7336-1f9aa412402mr50450385ad.24.1718897945494; Thu, 20 Jun 2024
 08:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 11:38:54 -0400
Message-ID: <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove redundant code and semicolons
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

On Thu, Jun 20, 2024 at 5:07=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_share=
d.c:3171:2-3: Unneeded semicolon.
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_share=
d.c:3185:2-3: Unneeded semicolon.
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_share=
d.c:3200:2-3: Unneeded semicolon.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9365
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2=
_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dm=
l2_core_shared.c
> index cfa4c4475821..1a9895b1833f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_s=
hared.c
> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_bytes=
(enum dml2_swizzle_mode sw_mode
>  {
>         switch (sw_mode) {
>         case (dml2_sw_linear):
> -               return 256; break;
> +               return 256;
>         case (dml2_sw_256b_2d):
> -               return 256; break;
> +               return 256;
>         case (dml2_sw_4kb_2d):
> -               return 4096; break;
> +               return 4096;
>         case (dml2_sw_64kb_2d):
> -               return 65536; break;
> +               return 65536;
>         case (dml2_sw_256kb_2d):
> -               return 262144; break;
> +               return 262144;
>         case (dml2_gfx11_sw_linear):
> -               return 256; break;
> +               return 256;
>         case (dml2_gfx11_sw_64kb_d):
> -               return 65536; break;
> +               return 65536;
>         case (dml2_gfx11_sw_64kb_d_t):
> -               return 65536; break;
> +               return 65536;
>         case (dml2_gfx11_sw_64kb_d_x):
> -               return 65536; break;
> +               return 65536;
>         case (dml2_gfx11_sw_64kb_r_x):
> -               return 65536; break;
> +               return 65536;
>         case (dml2_gfx11_sw_256kb_d_x):
> -               return 262144; break;
> +               return 262144;
>         case (dml2_gfx11_sw_256kb_r_x):
> -               return 262144; break;
> +               return 262144;
>         default:
>                 DML2_ASSERT(0);
>                 return 256;
> -       };
> +       }
>  }
>
>  const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_ty=
pe bw_type)
>  {
>         switch (bw_type) {
>         case (dml2_core_internal_bw_sdp):
> -               return("dml2_core_internal_bw_sdp"); break;
> +               return("dml2_core_internal_bw_sdp");
>         case (dml2_core_internal_bw_dram):
> -               return("dml2_core_internal_bw_dram"); break;
> +               return("dml2_core_internal_bw_dram");
>         case (dml2_core_internal_bw_max):
> -               return("dml2_core_internal_bw_max"); break;
> +               return("dml2_core_internal_bw_max");
>         default:
> -               return("dml2_core_internal_bw_unknown"); break;
> -       };
> +               return("dml2_core_internal_bw_unknown");
> +       }
>  }
>
>  const char *dml2_core_internal_soc_state_type_str(enum dml2_core_interna=
l_soc_state_type dml2_core_internal_soc_state_type)
>  {
>         switch (dml2_core_internal_soc_state_type) {
>         case (dml2_core_internal_soc_state_sys_idle):
> -               return("dml2_core_internal_soc_state_sys_idle"); break;
> +               return("dml2_core_internal_soc_state_sys_idle");
>         case (dml2_core_internal_soc_state_sys_active):
> -               return("dml2_core_internal_soc_state_sys_active"); break;
> +               return("dml2_core_internal_soc_state_sys_active");
>         case (dml2_core_internal_soc_state_svp_prefetch):
> -               return("dml2_core_internal_soc_state_svp_prefetch"); brea=
k;
> +               return("dml2_core_internal_soc_state_svp_prefetch");
>         case dml2_core_internal_soc_state_max:
>         default:
> -               return("dml2_core_internal_soc_state_unknown"); break;
> -       };
> +               return("dml2_core_internal_soc_state_unknown");
> +       }
>  }
>
>  static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
> --
> 2.20.1.7.g153144c
>

