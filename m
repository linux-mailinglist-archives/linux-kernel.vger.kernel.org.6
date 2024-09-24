Return-Path: <linux-kernel+bounces-337387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9498496C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD8FB2378C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84481AAE24;
	Tue, 24 Sep 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/zTa+QS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79C1B85D6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194657; cv=none; b=M50zNjGZ98e58+fzeJ+FNtjktBIWFSoqKB9nVyaupLsaxrN4kDf7x0Aw7oqbqGGCjNIftOg1FY5g7VItJ6r+FZycZDggNy8tkn9aVjV7/FU9T+3I/PnYy8fbtzqQCxvQVJ7cYb1Uvktovu4yTDho3duCE3arSrDP/gbndNV7Ih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194657; c=relaxed/simple;
	bh=vKaiyS+UyhOvXDkE3P9rbcqydY01BV3qBK9nQ5kCbJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N42Xrzz5kDa6k9aBDo7vlyUGfvrHgIBz56b89PlS9PORPPewquKB5ERxE0pNMPi5cZKtQG0jPpIJLK6RStRW452g+tX8V9RjsoN6wji4NGBf5FFkkCmWFm3dUPQlbppbRBDlrucancJmvKloGjasKCVCUES/uFG2d3K8FFmo/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/zTa+QS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2058ba82fbfso2936195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727194655; x=1727799455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kssHnqH80Xc0+QcoY5MDsbuxwut+7UFnPYXFFQ2LW3w=;
        b=S/zTa+QSAH86Lm6BSZ8CYN6VZ/E5dnX8OJl8PxGZuvyKCzJ3X8gBQ8ouUnqah82/lE
         V+iP5i5tJAlhcTfbxDNs21MMgs/mnPFyo5n8Akj63VNgbH+qnkZkfb4bHL2VElt/g/Gv
         WP/N545i6xWUcsYRX2pa67f+OvDYpn3yNg7b/gouHeU3zbGhZAcZvzTARTyKjAJYZJRU
         sF9de83QLkGpmSpPQebOCAyqA9ee3wTMb/JxSfAcK9oGeFIdJxvxdgRYOy0zMOY7nonH
         vpUFOGXLGIAeFD2jLJsrKhiDcpX5gQk42ZpQXPjwKbxBDxG2IMqbDp1Q1hCuy4jbsVuE
         iSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194655; x=1727799455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kssHnqH80Xc0+QcoY5MDsbuxwut+7UFnPYXFFQ2LW3w=;
        b=XJc6h9kYi2ERnrvUjkaLOwX0f9g6Go2nsKpLMMg77cc9vJhY2sKXWGn4j/MiGGRg/N
         oZnBQ5syEl7WuoJCPXDarYyOiZF3VcLtF0F3sCik7hjZB9PGlEexgJ7BuY7x+i8yoKeH
         jeLV0Ql3QXokW3FyZyKvrPmNZRezKgt//HU4f/kKjPClVl+mwSVCpSniv20/dwyV2R+t
         7oTLzQ7n6KUYcQ/uhfqWByNvmGszU+COx4sNBt2q54aTWt8qf3xNvZGGi6DwwXL/RKLH
         ubdW34yLbjEv+L6jTxmOeyO11E+VSJ343PXXI5i/fSvXu+JJoR1Pj9VxHz9E00WeK3JY
         rJjw==
X-Forwarded-Encrypted: i=1; AJvYcCXoyuOx9rPYp9a9WxxhJWVhw+Q7gtzEbhuKnrXDegA6hQKigg0st9NQs3utmzwWQHpK/0uRBRRs61SSiuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjjOMzNFvnNoxRASsp/IZbbmozPj68T2Gbfz+y6nCew+cET0r
	Y2QQxXjXxGivgvFZ3gyA3Qz5/0CT1vqaGCZVncudhB+dOFFt1K7l3FQzCCDGpg4FbnbJWTN3LdM
	wjJECy9wl5T/9Dt981cnXG/yXCAU=
X-Google-Smtp-Source: AGHT+IEjr/ZA9arb2W1VbQpNXq7KzjZDWz97ypC8TzPzWYevu/QK1ETv4A5nORi+wHtGJbAGUWsP406zUHHotaNpYEo=
X-Received: by 2002:a17:902:ec8b:b0:205:8820:fe1c with SMTP id
 d9443c01a7336-208d83dff51mr99001215ad.5.1727194654872; Tue, 24 Sep 2024
 09:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920214342.14792-1-v.shevtsov@maxima.ru>
In-Reply-To: <20240920214342.14792-1-v.shevtsov@maxima.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 12:17:23 -0400
Message-ID: <CADnq5_OQShrB_RbYVVfFfQjTYZ=DfooH6B-BeMZ3DZt3OPxgMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix typos in several function pointer checks
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alvin Lee <alvin.lee2@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
	Dillon Varone <dillon.varone@amd.com>, yi-lchen <yi-lchen@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Chris Park <chris.park@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Tom Chung <chiahsuan.chung@amd.com>, George Shen <george.shen@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Samson Tam <samson.tam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sat, Sep 21, 2024 at 3:48=E2=80=AFAM Vitaliy Shevtsov <v.shevtsov@maxima=
.ru> wrote:
>
> Fix several copypaste mistakes in *_disable_link_output() functions where
> an improper function pointer is checked before dereference.
>
> Found by Linux Verification Center (linuxtesting.org) with Svace.
>
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index d52ce58c6a98..c2364cb66d0b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -3258,7 +3258,7 @@ void dce110_disable_link_output(struct dc_link *lin=
k,
>          * from enable/disable link output and only call edp panel contro=
l
>          * in enable_link_dp and disable_link_dp once.
>          */
> -       if (dmcu !=3D NULL && dmcu->funcs->lock_phy)
> +       if (dmcu !=3D NULL && dmcu->funcs->unlock_phy)
>                 dmcu->funcs->unlock_phy(dmcu);
>         dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTE=
R_DISABLE_LINK_PHY);
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> index 4e93eeedfc1b..5b6cf2a8e38d 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
> @@ -478,7 +478,7 @@ void dcn314_disable_link_output(struct dc_link *link,
>          * from enable/disable link output and only call edp panel contro=
l
>          * in enable_link_dp and disable_link_dp once.
>          */
> -       if (dmcu !=3D NULL && dmcu->funcs->lock_phy)
> +       if (dmcu !=3D NULL && dmcu->funcs->unlock_phy)
>                 dmcu->funcs->unlock_phy(dmcu);
>         dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTE=
R_DISABLE_LINK_PHY);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index a36e11606f90..84153682af1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -1384,10 +1384,10 @@ void dcn32_disable_link_output(struct dc_link *li=
nk,
>         link->phy_state.symclk_state =3D SYMCLK_OFF_TX_OFF;
>
>         if (signal =3D=3D SIGNAL_TYPE_EDP &&
> -                       link->dc->hwss.edp_backlight_control &&
> +                       link->dc->hwss.edp_power_control &&
>                         !link->skip_implict_edp_power_control)
>                 link->dc->hwss.edp_power_control(link, false);
> -       else if (dmcu !=3D NULL && dmcu->funcs->lock_phy)
> +       else if (dmcu !=3D NULL && dmcu->funcs->unlock_phy)
>                 dmcu->funcs->unlock_phy(dmcu);
>
>         dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTE=
R_DISABLE_LINK_PHY);
> --
> 2.46.1
>

