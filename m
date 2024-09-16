Return-Path: <linux-kernel+bounces-331120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1631297A8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB34A28A7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74300146A9B;
	Mon, 16 Sep 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMkYxT0H"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853121CF96
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521742; cv=none; b=K40IIXvGnV7Az4tpbZc/nfpjPmOpp+Zhb/SRzGBFApXx3qvqRaWcFGawaIRizuebtcgHrnZBE3ESPo06X63SCi2bhwl/5j41KcDeTMiIORrzA9ZlHvFVpu0Ze6S4Z8l/hym+Fy2He/PoJ7+hwcx2hLrn8h7nvzQHQ+86LBSJlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521742; c=relaxed/simple;
	bh=UUvGSDf0wNLSz822Gf+YGiMdaMeNvcmMtU9CGTucF2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI19ZHfEq/EF63hbhLoYn+AP6y/Qz+nxWVTb61dJnk6OtDkPP8OJ4SIpGOJ5Rb5ypzT8HFpNEdQd3hP3ic+2eybuSLLg3vew0a7wnDqkNs4uqXwEkqLe2dGHU1TQjnEqkzIVc2t6xLM40v12gojWZAHIxNmx5EL47OwX2UYbjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMkYxT0H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055548469aso2576535ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726521741; x=1727126541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnZ+w3zQ4IHZ8UMqW7Wlzbtf2x6KfNdPBGv/gNGn4hE=;
        b=NMkYxT0HnnH7D4SI3+l8sKGxzt6SyXd7CVWjGbWSitWS6gmXFIYbuGDX1j6qUzRC8V
         0u2Due8fOCppY92ZcS4sUyZ2SzqSogyrPhAho03A8weyW2hmAWuYKIaZCBaQdRQZ8JCS
         Eey1Ar/TdmUtvNohD26vphYzMuM/lczLUPEkH6x+7fDO+uadEIuIeEhU/c+Vr9Nyyb2G
         +Vu0xzKFVaBvXFHpfc2z2QyGxFuMXkR6Us+g9JOquEttujuRincsQmOLaYb1XF9f0BKB
         k6QZDngT/X+PP7fQeTKdwXCykmhIdKdy62/HvpwCRt7PfhiFFr9S8tQ3ylWJWAC260dv
         Pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521741; x=1727126541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnZ+w3zQ4IHZ8UMqW7Wlzbtf2x6KfNdPBGv/gNGn4hE=;
        b=CMHsJ5I90MtY3CDp/StoTBOQPQvvbBdTYYrSyVaqB6Xc/0isM3YvKVGKLPtqcoe4+u
         LTXB5ahS2JI58EwAvFUTUqBzOoTcmm+44caUpYSyOqLSWQJAQTWoYmtzMGIBfsHuAiBU
         4bkWz3v6/E9hIy2t3bgeaA3npbAixjutNC4jy39YoSM2qZ6e66+7IqnfanT4mKjhxPIL
         r/DW5zDEsg3JE5Vr5uGLdjyzNzlCrWsjq8dkHQ7KcX/uBlzd7SZzhi58NvXI/tMriiNU
         Y9/MKFNkDJgN0t80CAzVbVFGlJEK72RflDgu3Ay2pPoJ2totQmItDJI3vn5MHFSTFj3q
         lX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0wde+FNfkHp5/xaQ31jPF/6axLPNu51acL65Fp9ZMU7LTBsOlWfHirIptonNr+vYo0CxUjv/N5r6qlE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQYHAc1s+zBzLR2AwqqMMyluK6NZ/yOc5x0TrX0xkG3BhEutW
	QLj5RTVEf/J9tX+1k4UWb5RlV/YA822mb9/hLrqoSsPcJ8H8VTFOa6dalfHwe7NqaPhRvMwar+M
	quFyxuGqvQpBOBleBAr58tWGr8Qs=
X-Google-Smtp-Source: AGHT+IH5SjI+U0A7P/wtoSude0aArR/OHyFC0Phr5mIxCQoIJV8kcO5I/Gdj3ckinVYf82EStXGIVhanMBob4xTNuA0=
X-Received: by 2002:a17:902:d2c1:b0:206:99a2:b058 with SMTP id
 d9443c01a7336-2076e35fdd8mr105279965ad.5.1726521740510; Mon, 16 Sep 2024
 14:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915140144.36988-1-linux@treblig.org>
In-Reply-To: <20240915140144.36988-1-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Sep 2024 17:22:08 -0400
Message-ID: <CADnq5_OGNOfDkpGumipdpwJBCa1_UCB0NHQQ5otnPrH9b=_V8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused function bios_get_vga_enabled_displays
To: linux@treblig.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>

And applied.

Thanks!

On Sun, Sep 15, 2024 at 10:19=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> bios_get_vga_enabled_displays has been unused since
>   commit 5a8132b9f606 ("drm/amd/display: remove dead dc vbios code")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 7 -------
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h | 1 -
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/d=
rivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> index adc710fe4a45..8d2cf95ae739 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
> @@ -78,10 +78,3 @@ void bios_set_scratch_critical_state(
>         uint32_t critial_state =3D state ? 1 : 0;
>         REG_UPDATE(BIOS_SCRATCH_6, S6_CRITICAL_STATE, critial_state);
>  }
> -
> -uint32_t bios_get_vga_enabled_displays(
> -       struct dc_bios *bios)
> -{
> -       return REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
> -}
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h b/d=
rivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
> index e1b4a40a353d..ab162f2fe577 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.h
> @@ -34,7 +34,6 @@ uint8_t *bios_get_image(struct dc_bios *bp, uint32_t of=
fset,
>  bool bios_is_accelerated_mode(struct dc_bios *bios);
>  void bios_set_scratch_acc_mode_change(struct dc_bios *bios, uint32_t sta=
te);
>  void bios_set_scratch_critical_state(struct dc_bios *bios, bool state);
> -uint32_t bios_get_vga_enabled_displays(struct dc_bios *bios);
>
>  #define GET_IMAGE(type, offset) ((type *) bios_get_image(&bp->base, offs=
et, sizeof(type)))
>
> --
> 2.46.0
>

