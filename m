Return-Path: <linux-kernel+bounces-297799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FC95BDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BB728576D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4486A1CCED8;
	Thu, 22 Aug 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD1bgWRZ"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7311B815
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349681; cv=none; b=Mge4pkbbQXel2l8VcMlvqqM55fWUwaj1R2XwcGCUcLx9wAXUm7Kl2oJARxcqWwlS0ab/STrfI/5iq+FsqNVLZmabWFixg7+V4G4mPmlb/BBRFxLlHDM+NIhKRcW2OdG+z/06Y4bPNtsEDzcii/Xk0FkSq8RsG5DcPYvpEqA4hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349681; c=relaxed/simple;
	bh=L2gBEG3NCfCgV+x0q47gqWJd9ZbFlV7HMeSISxd7E4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bdrhag9sx82rLUjCAB6oj8ucHqp5vD0Onzy2m2wTIs8QZxEOc+9Q/03bmWoLPkRnND4BKiNiXQfhgQ9K0bNG3b9pkepYQ0V6zdcFkjAlYO8dGNw1nkEu0LEJOn8zb/qNokbmZFEvf9X/VtRkgdFI/6xOKchOp1l8I7ZsKIXgNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD1bgWRZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7cd94fb88cbso90116a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349679; x=1724954479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IGkb+yvoWKgY6f1pKvffTMPxwTT5DeP9+ZQzFPPBbU=;
        b=HD1bgWRZl9sEcKQmbHNde8AdyNGWtbDlouUgmwtM0FEn+IxqJmhH6LcbQBjczowggM
         Xphsi7n9pMdY/DxixF3jCZc0vie7jHHAYEvBn7oPaksIX/md5wb+3ixCKw4KlY+dr4DL
         tuYQiTewJpQszdP0VobELr4ETDJLzZU1BMAXoYjgjePjGR3BhW8zyu+tJwyASx53Ixji
         DHPx4ipEB4R7EEVja6W3+sl1xPIBc5VkiYz0cE5ToRTgyQPpIdceTPo/Qgj60EyKsOc6
         AqCuvuA9LzsVXEM5VtnEuvzcSWXlpvJ7GJ/q1+jSvWrw73jwlTV3OydWkRRhnioBcDBZ
         KqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349679; x=1724954479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IGkb+yvoWKgY6f1pKvffTMPxwTT5DeP9+ZQzFPPBbU=;
        b=tJiP3ZDEK0y3jtpvPopoXBoXvpj2kxxmeZ92AnR7qQ4EWdFabfkvt/HLuIyJM56eWB
         OB92fMvV2lEPfqtTOIVCw6+L4hf8Bpz63cUF91BfpiFn/lnfFdvyyIxfNHjghs7wBUPF
         W8NoBwtQtIzl2qT2sRGaoxz0fZLEaGSKreXY1QcsxMgTupY/d+XBxxrqCpc8kj/c/0I4
         6h9hmP2CbrqNdzqJBjhgahrkbLa/WoL4U+gLGOf062sQiPnESlhboGyq44VMoNr4eqsu
         vtLo/2iHw6krVv1+BPfNk7yl2ZQS9WlSMi4vCxF1SRtA5Pm0jyYkB4qczzXyBU3b/fVy
         CmKw==
X-Forwarded-Encrypted: i=1; AJvYcCWszQPcjnMdC0JPouXEMCgPRmWmh2+keDfpPjoKtWLD+ASh3FJkcuKddDQTDBPeQNYgHQVqV49OsQ8fgDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkbbsXKkxYA7XoNV0wkdIDP48M5bZH1bMiLLsKMYU9IM6JCd0
	Gu4cGzN6K1uXYSintYvJSSXdOOaZXsznFULMkwEaZ4JcIFL40iqyiT6CSVodnPOKCgXGBvt1yHB
	E/3lNsdvcbj2/7WdOVawG6BYDrX0=
X-Google-Smtp-Source: AGHT+IEovfL7TTOHMHNjGi8FsQAT5DlUHXGCRkJP5OX/etAXNtr9pPnu3WMIst/rhzDkrMbsVVDrJ036rcwViaA+mt8=
X-Received: by 2002:a05:6a00:2342:b0:70d:148e:4bad with SMTP id
 d2e1a72fcca58-714234680ebmr4544467b3a.2.1724349679359; Thu, 22 Aug 2024
 11:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822015819.3356282-1-ruanjinjie@huawei.com>
In-Reply-To: <20240822015819.3356282-1-ruanjinjie@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 14:01:07 -0400
Message-ID: <CADnq5_Pm9GHaFWLUniQ608CNMPMSBpNdh2JW9-AcKyEM18KE9Q@mail.gmail.com>
Subject: Re: [PATCH -next v2 RESEND] drm/amd/display: Remove unused dcn35_fpga_funcs
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, nicholas.kazlauskas@amd.com, 
	Charlene.Liu@amd.com, chiahsuan.chung@amd.com, hamza.mahfooz@amd.com, 
	sungjoon.kim@amd.com, syed.hassan@amd.com, roman.li@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> dcn35_fpga_funcs is not used anywhere, remove it.

This will lead to warnings about unused functions.  The fpga specific
functions should be removed as well.  I'd suggest compile testing your
changes first to catch these types of warnings.

Alex


>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Remove it instead of making it static.
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> index e2d906327e2e..15977c2d256d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
> @@ -1068,13 +1068,6 @@ static struct clk_mgr_funcs dcn35_funcs =3D {
>         .is_ips_supported =3D dcn35_is_ips_supported,
>  };
>
> -struct clk_mgr_funcs dcn35_fpga_funcs =3D {
> -       .get_dp_ref_clk_frequency =3D dce12_get_dp_ref_freq_khz,
> -       .update_clocks =3D dcn35_update_clocks_fpga,
> -       .init_clocks =3D dcn35_init_clocks_fpga,
> -       .get_dtb_ref_clk_frequency =3D dcn31_get_dtb_ref_freq_khz,
> -};
> -
>  void dcn35_clk_mgr_construct(
>                 struct dc_context *ctx,
>                 struct clk_mgr_dcn35 *clk_mgr,
> --
> 2.34.1
>

