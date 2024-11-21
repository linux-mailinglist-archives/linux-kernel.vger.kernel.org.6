Return-Path: <linux-kernel+bounces-417178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581EB9D4FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100781F217DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B3915689A;
	Thu, 21 Nov 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2kc6pZF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE655C29;
	Thu, 21 Nov 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203739; cv=none; b=u+vyNoaVfZsk9w8Skgp93u0NBrxgmvciTOAAVVbi9E+3G4IHd+WUHqt+DVsxPU0ibXeuMG/FPZoysanlrmrgmm8N+p76RyBbP1KBpz/bd2PZz0EIe2yf6FGLwDt+xWsGVLV19tc8mA9sHo3lYGcZFG432IKkrfcRVIX1GkNuIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203739; c=relaxed/simple;
	bh=GVGwFx/zshxcMNMYN5YiokER9KAej7IMOk2196UwSqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7un/gUxPjc6eDe3hCtbFQxH9mx8yz7iTwmBjyRFfYAijGuyM3Z325ZwCcGYgRTUuAkkMMb5Cw7d/TF8A9Q8/Tskeb+kcSJb5BTMYyalOa607rnDgccRYPz8P02ehHP8+W65lsetpBG0cCqhmxSbvHBCOcG23h3IdG/chAUYwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2kc6pZF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d5e309dfso33831b3a.2;
        Thu, 21 Nov 2024 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203738; x=1732808538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQSpT9bmaRTRYEXJVSo+BnSr44G1gB51FRi8tOTD2dg=;
        b=M2kc6pZFa1AX4RK/8B18sW1iZjli1w/RYS0ImY+IE2PmagsBIzr1Rf2T5eMqjXx3kk
         aLnw/V7twQ+fEORyoGHkNkdJv2l1VR12URJ4l5QMlsfs79JM0OHvkoiC8mlxZOdgJ0Yz
         BW7QcTlaD2y8BmGjjYm6+Fc7MM96zG8FmOgwUfJzN3ufPRZH1b1MTvsqfwjNQL/4kQYI
         aUfe1x4hYP9yLpLa7+g1YFGVJhRfZlVGLyU5UV1MN4dxw//ig71GKKfsFv83bAGDLtSQ
         DIUMvSuoKlQDWmD33WxQ4mLIHw+0IZzDiucDmzwbWeiIBTQMltysBy6S4rmtWQ27Debf
         0oiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203738; x=1732808538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQSpT9bmaRTRYEXJVSo+BnSr44G1gB51FRi8tOTD2dg=;
        b=vf+qJevwCcnB0qN8ROkmOnwFTlYZBXslxDU0h+ZSWY1DF/0taC1zZarUU0nTUAOMk0
         uvWC/WwGMoBFK+9Kz5IytdnjhzBdiCmnMATBEQM1xWEL2PgUcifr/IBmRI+5gB0udUpd
         hVtIM+YrdXSWE84lEZYWysgy0qQbx6JPoCC8BY0gy0u6ByPVdYnKNMTFdftcY3mIT8ou
         LbQ4b6CSwyDbEcE6EUoAPIwR2Xoe0/bLSqXmeQEiIPIiioa5f9E1+AtybQV2DF/iityM
         qMF5L3iY79D1NXQjUqcHNogd6P0XE6hNe9p9Ovtj2/zNzgAMUYvcsBs/2ydHfRRYJ3Ha
         /leQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSXhUpOy+nvR900j01dgeCIpVXButYPwPm8nISUQRiG4WiklprQgzdrXCUurbRj73VwH8jl5kCpglMkmk@vger.kernel.org, AJvYcCVjXZjtL5oramxM4WeWtE6RXvAYfvinthEllWMRWVb1psQrXdjNCqRUnZb83hT2VH8TbWN3kTIlPGBb8HGeeUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgV79eCBxGSDHfu6A7UxKodDuZxA5z90N+YdUPAD0BJGlXCX8
	nPMxlPPjjlHO3RUKki+ibb3NnhGanDOauX0qo4mVYBi41P8Bj70dqM3RXWS92p+8lZgasLY2xpe
	JWnmtvxlZFxyTVyvTnlnTMkptCyk=
X-Gm-Gg: ASbGncsXbBcf0t86WS/WolNMRjBD+zeFA4XIa0wl8sQNIrx+17+cet2lhZ7hB361ghu
	6CQSzYUinlSZdWGfS9qZ4603k6M76orM=
X-Google-Smtp-Source: AGHT+IEa4XS/aPX09o9Gf1pNHRKm6CMplBWWo0+kJxEqOaNThCKWOQIJeVjor8T23Yi1+3FbTFs8YQUmuTIn9frlbn8=
X-Received: by 2002:a05:6a00:ad84:b0:724:bf53:34a6 with SMTP id
 d2e1a72fcca58-724bf533648mr4054740b3a.7.1732203737604; Thu, 21 Nov 2024
 07:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6584a62da5436ffd726d68e5dbdaf5eadde8af9d.1732047767.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6584a62da5436ffd726d68e5dbdaf5eadde8af9d.1732047767.git.christophe.jaillet@wanadoo.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2024 10:42:06 -0500
Message-ID: <CADnq5_ONUa=8g6qKqFHDeiNNeJ7QidyReGhNYoxBzPX7B36EJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Fix an error handling path in vega10_enable_se_edc_force_stall_config()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Evan Quan <evan.quan@amd.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Tue, Nov 19, 2024 at 4:02=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In case of error after a amdgpu_gfx_rlc_enter_safe_mode() call, it is not
> balanced by a corresponding amdgpu_gfx_rlc_exit_safe_mode() call.
>
> Add the missing call.
>
> Fixes: 9b7b8154cdb8 ("drm/amd/powerplay: added didt support for vega10")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> *Not* even compile tested only because of missing "hwmgr.h". I've not
> checked on which arch it is supposed to run in order to cross-compile.
>
> This patch is speculative, review with care!
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c b/=
drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
> index 3007b054c873..776d58ea63ae 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c
> @@ -1120,13 +1120,14 @@ static int vega10_enable_se_edc_force_stall_confi=
g(struct pp_hwmgr *hwmgr)
>         result =3D vega10_program_didt_config_registers(hwmgr, SEEDCForce=
StallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>         result |=3D vega10_program_didt_config_registers(hwmgr, SEEDCCtrl=
ForceStallConfig_Vega10, VEGA10_CONFIGREG_DIDT);
>         if (0 !=3D result)
> -               return result;
> +               goto exit_safe_mode;
>
>         vega10_didt_set_mask(hwmgr, false);
>
> +exit_safe_mode:
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>
> -       return 0;
> +       return result;
>  }
>
>  static int vega10_disable_se_edc_force_stall_config(struct pp_hwmgr *hwm=
gr)
> --
> 2.47.0
>

