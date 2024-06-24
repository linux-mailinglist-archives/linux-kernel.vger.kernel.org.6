Return-Path: <linux-kernel+bounces-227435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA11915126
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFEDB24772
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6819DF8F;
	Mon, 24 Jun 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUH3eU25"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE319B5AF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240948; cv=none; b=FPErGdBVigoURS/H3g2kAqr+EHw/9LLNgS8QUxAvCgDU03sWQfcOre4frhSLHpv/yOA2fOc1QB1D56B/EDFJ6c06yI2Cxmt/VsCsKdIeBwQd3QV+dfR7vE8BENSrATuk3IvzDwoRyYeX/Ii5/NTIdGPI3GU+nPzozUBhwHW7nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240948; c=relaxed/simple;
	bh=M3LG5IVB5EUqNrp2CKzfSaJKusPcFEBr+vN1KaXswwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlstDwNm+jYtdvnA3U1+QAlTCnldTe9QfTu0Ru+EeRZHbUVjZ9sIPbojKsvf4JGkGU02mt0EpRzVLXwZRQ0+jKy/YSwsXSBGHzROE4f4UBZNNoD1rRmojFsuyqop9DM1T1AB+7jeEyu6+UC+LqU5mAqKBkuGH7sYg5XDnKiSRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUH3eU25; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so2138743a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719240946; x=1719845746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHJZJFdKOUU7MLHBSrCKc8/j1E+l52LoDEliQjriARU=;
        b=QUH3eU25cY9lYC3FNsTuYfNoWljwyOC7pEjkFvp4HfERadjIHBkhHdYqyD85WNTZXU
         rwZTzRayKMCOrXjnJ4j9FzA+6Bv5XCfWGK7LFCpMgFDrozVP+JrRZtpPpN8rc4M/+KVL
         FjyoZY/KU3bNbO1COtrC5iHwy6/VlKzEsKtyFib7vAyY2AqBn9HlvJljoB5BEWv/+hy/
         li5v0lTx7H+SR7wz49tO1nFJboXIgFdMcLJnhemqDwe6L1wNzRzLE/KG8Bt+LYZ7VuhQ
         9ssWLIO9foPQE77Fi7xCjncON0Kg/MtMsgcqOoUPiDAW+6+Wv7ztUjyK0xNkW+Ut5Mqq
         PdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240946; x=1719845746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHJZJFdKOUU7MLHBSrCKc8/j1E+l52LoDEliQjriARU=;
        b=S6HgbbwB/peWp8Ub//6witlouTGlmbcOrpKi1Kqn0NEZX4V/2L9N4EeewIhMADBl71
         ppZunlj5Ej7JNurNpWwYXu47ryhHaTcY1Bfa9J0v4mWaXAH2BZQmyf7ZZBdjyZmS+7ut
         +nxqaz6yxHyf10UKeGISzPag044OAF4uvcc0fGZ2o5T+0S5UstJxuE00y6PnDnnfSdQa
         atAY6MHed4A9eEjUo4wHaABz7lJTh0Qml0tNw/wrfN/sJIFhR3hokg+CGMLUsVQ9tjh6
         QuNHyjHToY4qK+Pu2XlfhZGWlws78ciZB+0siUFjJXWrMxONAE3TuyTt4P3Z8VCkOU4J
         pnQg==
X-Forwarded-Encrypted: i=1; AJvYcCX6+vHK0aka7zXYXEpm2ilzcc3bwC3Z7AlHVRPo3tv1jv9Fwp6qb3rfV893fDnBwz2wb6FFdqcbYSkuHmcV4BaW9dBfkbQcXOvGS3/m
X-Gm-Message-State: AOJu0YxyhlDt2Qmjgk8bTB6wEw1IxIxKU8Khqb0tq5X/mY950nKTGzy3
	s1FzUtVpTzKELMUDssB7+jIYk2hAj2x5AipIGT+hhNle0EiA5McpDiTrtNDBiOyXUyIF7ntnMXE
	wkkTUfX9DEsvEZD+uDnvEONiqU6E=
X-Google-Smtp-Source: AGHT+IHzORMZtyHXyD8+lKuZcICDhCjfwkQcfA37HDbLUn6mRY2KeHPqti3LqEt9YPexg/TUVMutE2FgEIGqW4S5jaE=
X-Received: by 2002:a17:90b:1245:b0:2c3:514:e0 with SMTP id
 98e67ed59e1d1-2c8505740d9mr4088550a91.35.1719240945712; Mon, 24 Jun 2024
 07:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624015707.121287-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240624015707.121287-1-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jun 2024 10:55:31 -0400
Message-ID: <CADnq5_OXp3mcy16bwSJYKj+KaFbAqRP6MqNLfre=bum8Jcz7EA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use swap() in is_config_schedulable()
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

On Sun, Jun 23, 2024 at 10:22=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use existing swap() function rather than duplicating its implementation.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fa=
ms2.c:1171:103-104: WARNING opportunity for swap().
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fa=
ms2.c:1231:99-100: WARNING opportunity for swap().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9400
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  .../dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_=
pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/d=
ml2_pmo_dcn4_fams2.c
> index 7272a04b9d1d..926d45496e79 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn=
4_fams2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn=
4_fams2.c
> @@ -1158,7 +1158,6 @@ static bool is_config_schedulable(
>         schedulable =3D true;
>
>         /* sort disallow times from greatest to least */
> -       unsigned int temp;
>         for (i =3D 0; i < s->pmo_dcn4.num_timing_groups; i++) {
>                 bool swapped =3D false;
>
> @@ -1167,9 +1166,8 @@ static bool is_config_schedulable(
>                         double jp1_disallow_us =3D s->pmo_dcn4.group_comm=
on_fams2_meta[s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1]].disallow_=
time_us;
>                         if (j_disallow_us < jp1_disallow_us) {
>                                 /* swap as A < B */
> -                               temp =3D s->pmo_dcn4.sorted_group_gtl_dis=
allow_index[j];
> -                               s->pmo_dcn4.sorted_group_gtl_disallow_ind=
ex[j] =3D s->pmo_dcn4.sorted_group_gtl_disallow_index[j + 1];
> -                               s->pmo_dcn4.sorted_group_gtl_disallow_ind=
ex[j + 1] =3D temp;
> +                               swap(s->pmo_dcn4.sorted_group_gtl_disallo=
w_index[j],
> +                                    s->pmo_dcn4.sorted_group_gtl_disallo=
w_index[j+1]);
>                                 swapped =3D true;
>                         }
>                 }
> @@ -1227,9 +1225,8 @@ static bool is_config_schedulable(
>                         double jp1_period_us =3D s->pmo_dcn4.group_common=
_fams2_meta[s->pmo_dcn4.sorted_group_gtl_period_index[j + 1]].period_us;
>                         if (j_period_us < jp1_period_us) {
>                                 /* swap as A < B */
> -                               temp =3D s->pmo_dcn4.sorted_group_gtl_per=
iod_index[j];
> -                               s->pmo_dcn4.sorted_group_gtl_period_index=
[j] =3D s->pmo_dcn4.sorted_group_gtl_period_index[j + 1];
> -                               s->pmo_dcn4.sorted_group_gtl_period_index=
[j + 1] =3D temp;
> +                               swap(s->pmo_dcn4.sorted_group_gtl_period_=
index[j],
> +                                    s->pmo_dcn4.sorted_group_gtl_period_=
index[j+1]);
>                                 swapped =3D true;
>                         }
>                 }
> --
> 2.20.1.7.g153144c
>

