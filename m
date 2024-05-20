Return-Path: <linux-kernel+bounces-183887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF678C9F67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5C91F217B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E46136E0E;
	Mon, 20 May 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgaTwL/c"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717514D9FE
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217938; cv=none; b=WcHAlA9+4ZILQJtZbGQL2pryGaUNX/EZnRB2M2vxyRdU77ESNL88RfMrNxZC2QXapl5YJJXzfw1/pu5zqg+fI0L/cB21a/4SepXSncoGhrr92XSpFLahsvoIxwv5DeYlkRDelHFGS8GmtC33IekroNVY7i2gxQv3JjU4JXIrV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217938; c=relaxed/simple;
	bh=fNL+MIkF/dECnsy/X1AE/tXFth6uO/ktmVSweAz8kUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSARw3wAS0dLQ/bUDXeCSspUBW/RmtgLlU+k4AXTchgqmEZh8yVnTGrNe1CI9x4K+XX5Xmddc5it18Ef94TNsKu4HjARVRA24zrqUipfKC5u4odX9AUEVJGK+qCA7B3hShcR5ahetBass/OIkxR++o/wFuhHBCAN0VaMlwQZw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgaTwL/c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed835f3c3cso10263835ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716217936; x=1716822736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz2DF7y1Qr5mH4wb4c2w0AUoZg9A/thbi3cZqGi2HnM=;
        b=DgaTwL/csYn7OS2vDID4MP3atv3STY6Gd0eZ8+jz2cNyCi4ySqe97ekiCMPIiRpEBO
         tgxUi+gxBjj8lxKRAMVVtp3ao4z+V5msisvKKKXaRDPtg8udY9M4yL10Uy4DRZkc6C1N
         rbxBz6mDO9YYUDPm6S39oKWpOnKzzfyCwwzlC/8kZzE2s5ACUD6jwVWkJtMkHsRMEbl8
         sNs1iUi6lXxzUOBsavVUzNpPFMyoer1Md0UnSJoHoGNpQYl1DzTsSXsU5HNojFC7kJqI
         HVmcmyEb3fO8ryTmpp17R3YOEszq5sKGWep8h+M0tbUucx5/l0yYz5ZqCFhE54GXbEQ2
         NcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217936; x=1716822736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz2DF7y1Qr5mH4wb4c2w0AUoZg9A/thbi3cZqGi2HnM=;
        b=RxSw01ZSvn77GWfUYCLuTyScOtqfogXz3A+OH8imhePf41WbMHzX6nCNv5T8VcN1Ff
         ln6b/uecddFwmCFcL1kxE4ZkP34l+/FgLyZmEs5f40ML9NhToDld6DzMYLSVeftXlC2K
         qyErVat5daOdV+lPza8/q+MDkagVfei+AimzYWve9BylR1ZfxNX85hwXq83+F2t8d3oQ
         jgvpSijMEtgPYv8kt9Lcu4kiQTDhSFB+0S6qyFiUJBbpTAfh5IWpzK8IqHNcS0IK1REJ
         YHvNbHEebqRHTQW5dOCsJcDM+4k0IZTtZi5kLDXV70/vtyGyvAxz935QhZA6vFV7r6tt
         NqZA==
X-Forwarded-Encrypted: i=1; AJvYcCUDQbd8HxqTvP//0jfvRQCDB76KzfmxqVBFH3v43m3z7FBBq4gphvarQ5idaHrGw3D9YpB3s0isZIIN1UZHsOnXUtkUFsKobTwzKnqw
X-Gm-Message-State: AOJu0YyC8N8ziB3JoKaaS2jSUWNCxm3DVpwcdYXGu7X9U2eXOW7ymlQ9
	qQXiDGdbnkcSpaWXUfY5lRp/M8ZXBLFeFffPxasPUjc/C2M8ozuHWb76byLt8O6KrjSOK+sT96a
	LCxndp7eeHUlZD1xeUdIYTMJ06v4=
X-Google-Smtp-Source: AGHT+IEVcRvxcDC68E699ppW3ZebEFtvfHkfkJZmo7cCBgvWqWCG855W+ec0A4hUDM8jqcLX3i9PK8jreumPYZwOBjA=
X-Received: by 2002:a17:90a:cf0e:b0:2ae:cffa:9b2c with SMTP id
 98e67ed59e1d1-2b6ccd8e06dmr25209675a91.44.1716217935699; Mon, 20 May 2024
 08:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517233548.231120-1-linux@treblig.org> <20240517233548.231120-4-linux@treblig.org>
In-Reply-To: <20240517233548.231120-4-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 May 2024 11:12:04 -0400
Message-ID: <CADnq5_OwD0=y2UKJ3Ajp54_dGzs-LCwLe1wtcqE19r5qpLzrCA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: remove unused struct 'dc_reg_sequence'
To: linux@treblig.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Fri, May 17, 2024 at 8:12=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'dc_reg_sequence' was added in
> commit 44788bbc309b ("drm/amd/display: refactor reg_update")
>
> but isn't actually used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_helper.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm=
/amd/display/dc/dc_helper.c
> index 8f9a67825615..b81419c95222 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
> @@ -91,11 +91,6 @@ struct dc_reg_value_masks {
>         uint32_t mask;
>  };
>
> -struct dc_reg_sequence {
> -       uint32_t addr;
> -       struct dc_reg_value_masks value_masks;
> -};
> -
>  static inline void set_reg_field_value_masks(
>         struct dc_reg_value_masks *field_value_mask,
>         uint32_t value,
> --
> 2.45.1
>

