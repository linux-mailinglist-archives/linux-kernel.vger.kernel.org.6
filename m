Return-Path: <linux-kernel+bounces-307722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807B96521B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB9FB21A01
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F61B9B51;
	Thu, 29 Aug 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/x4Xi9p"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1C18A92B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967456; cv=none; b=Aq+XOgFSzvofWGQG76YZcBdLc6psMzZc+PgJ+RjorcE9w8n4uOn+s6E3G7r/Ln5Z2NT9DdcmxMjPuGy6FIdwW448iV8vmK1QZ3AIGYSOtbZQ2i4wifl+tLZGEiaqtGVz4gLOQi2zJA4e/dv2WxZ/LEE/cTEqbyk0O7EcEhC0JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967456; c=relaxed/simple;
	bh=wSOqRBziMHB6yLF35urVPkauk4cefa2f2z8nYfsMT/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7SiqoyJsj5O+k1q4q6b7IIe2H9QBo2xHud5myS3UwgVFacer+R7MFObXN08lmeCZCZ8gUiqPhtAkgDBoxZY6SyiTizN4ZXrWGl7jD1mYqefa5FCIkY0AOgapKHvNorRj9FJYheXMwIJJ6QN6p3KnkIKYN7elUn8rhYRJUNZbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/x4Xi9p; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so112549a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967455; x=1725572255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqDs1AXQAfVToI31sahYYzMYjpkf0HNQiurR5mfvYPc=;
        b=O/x4Xi9p/TGFdHnw88ktRXT3lpKIHtxyWeVdM0PqSxuc/Y7gGM8VpAGhcLypQ1HsEj
         Et7/3SC334du2ixMCW7RY6iPeTnvyC0uWW4Rj8P/6rLqmhPu7l51Klw2hn6AMrLcvSXP
         /5viQXhdAjfZ5GuAeOUyuAKorqlRnqMe00NTsGH/kYA8de9XOTX05KynLI0zc457lkcE
         xHRpudgCOyVi1sWTt9PnfYNiMMTThly4HCOEjpjDiRMsPFxUhaNSnz7Xk3uTJMKHIPoa
         G/2g51/wORKwqyAi9MOLY/zJ3LjQegyN/G9mPC6X8swsJ3z4dmv5iph7fgB6A0cr9/ru
         hhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967455; x=1725572255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqDs1AXQAfVToI31sahYYzMYjpkf0HNQiurR5mfvYPc=;
        b=KJyXy8z6IcYntqn20gg/U9VNpCFqZEmjSrk/lM8Z48Rm2PzGRR1GQloXItJIK4G/db
         W7GSQaJ8Jid8LUm61XLcH9VFq/6pT/IF4K1vAQZe1W7vff0oLJGfvzKdPWmRfLz9au3F
         ze3qFp1ZQr9SW6sqbuFfCz4fToqAeZi2a+52eu1ad/GiSzIYqYr9kMkaCDk+w9LZsXVj
         aSSBnaQaFwxdHUetpKA61Bfq/O9pvyCPHar60+gGLlM22ESt7AScWKgOyooM45JWCdBw
         QACCS+c7T05sXhsVWEyRLuM+xaTuI0++nAC4FYosX5UihDLzLSMGeZH11Wd4FdXIR2EU
         Nudw==
X-Forwarded-Encrypted: i=1; AJvYcCUkFP62iVbljwnHdrJJQpVLi3AQHhTgQ8vVgqqUste79jRw+bDO4wWbUp22wkMmsEDuZFbD8Bx3Z0gPm5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuuzdIzBWX5eXgEkSBUa87PoNUsaYHTqp8T2vgFvq/znFrK34
	JpMRP661ELrpzDj5mE7C8U1DD/BMMzMhNI2EdTzZPSHLW9WiTg9FwBJOiruwHNOn11clvtKlff6
	aXf3pA8mW375LenKjfrd0hz0Y7pg=
X-Google-Smtp-Source: AGHT+IF7TMIVRf+RSqmC2FIwf/+gi6PfP2SWSDN8W2wiDyjbh+vA/0OZKN9uQcvOoNzVjzrsTwMTmzexHIry8tIu54k=
X-Received: by 2002:a17:902:c409:b0:204:e4c9:ce9b with SMTP id
 d9443c01a7336-20527300e77mr1308605ad.2.1724967454478; Thu, 29 Aug 2024
 14:37:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829023654.20884-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240829023654.20884-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Aug 2024 17:37:22 -0400
Message-ID: <CADnq5_Na=-KTEOJT6y8EzQdk_wewFBGs5Or1j5bfVA1wO0PTCA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove the redundant else if
 branch in the function amdgpu_dm_init()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:37=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The assignment of the else and if else branches is the same, so we
> remove it and add comments here to make the code easier to understand.

I think the code is clearer as is.  If you force IPS on, you want to
make sure it's enabled, regardless of what the default ends up being
in the else case.

Alex

>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1871:6-8: WARNING: po=
ssible condition with no effect (if =3D=3D else).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9829
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e14c0c060e1b..71624917c475 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1868,9 +1868,7 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>                 init_data.flags.disable_ips =3D DMUB_IPS_DISABLE_DYNAMIC;
>         else if (amdgpu_dc_debug_mask & DC_DISABLE_IPS2_DYNAMIC)
>                 init_data.flags.disable_ips =3D DMUB_IPS_RCG_IN_ACTIVE_IP=
S2_IN_OFF;
> -       else if (amdgpu_dc_debug_mask & DC_FORCE_IPS_ENABLE)
> -               init_data.flags.disable_ips =3D DMUB_IPS_ENABLE;
> -       else
> +       else /* The branch cover "else if (amdgpu_dc_debug_mask & DC_FORC=
E_IPS_ENABLE)" */
>                 init_data.flags.disable_ips =3D DMUB_IPS_ENABLE;
>
>         init_data.flags.disable_ips_in_vpb =3D 0;
> --
> 2.32.0.3.g01195cf9f
>

