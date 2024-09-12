Return-Path: <linux-kernel+bounces-327007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A6976FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC27B1C23E04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535B1B9826;
	Thu, 12 Sep 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmKPB7QI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10B1891B2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163066; cv=none; b=Yy6sr1PitQceFm/+/CvbtMDjMVp2jRTDAhpS9wG5GN0/+S0DC6Nchn6FryPsfhFbjyZcKsqwLBBW6MZpW9QD7h9zRbsPuDfm58pkFg2WFTIEbxx2np78+0xvehgHJx69HAhV02oBgG+vZ75dzn9IqQc23NKfQVe7lXsb6SPV/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163066; c=relaxed/simple;
	bh=gxZmHSEYnWuBC8lnfmpoU89YNh77vBwAbza2FnMveMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gow63y+DM1sAGGHEHTCSQmLPUKXb2Vdb7hWtD2RsYHk9edZkfok/gi9cDA0daYOIvDLP4FxosJYGXbiXPMJWCN7SkC82YdtxWymXfotkpmD/KSqzubgWodfDvQouPVnkT8OFK4uxiB4qw9YY6H+BRmnrFHe9FN8Lo+QFmEiOHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmKPB7QI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so239545b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726163064; x=1726767864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmU6NvTipUQnAiMPxFvqyNnajVhcXQqIALppHUS/BJg=;
        b=SmKPB7QIIyY8BdzW0lnxBChIt/YesHJkRf65CU4DPdoBwLcgPARfEEGkEq0OD6yvhO
         L5ur6rErfkLbe2DzlygOTXZG8DozsY1tO8+1l/IkU7uWsnUwyg2kY0zQqffN8ZYTmeuP
         HeOGFJWZxRNJyRYuv2e5CVVzt95wZM5CJkAqCB3D40g4DrNboklMG9yEeu5be5MNzZ2V
         pmVMsdAlCu+cFvjUYMkZPSZg13wKZG8UtIkq15LRSRlFfrO/j+10ri+JC1NFUvc34VSw
         rLgh0k+rju+GXIs849OrE55ewLnk1oRbFxh0wbWdIFFiwkY9KebZ+OW062+Ux7IYZDKN
         NxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163064; x=1726767864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmU6NvTipUQnAiMPxFvqyNnajVhcXQqIALppHUS/BJg=;
        b=YMxt34otPld4uoZnw5KI92w6jAbM2JdFh3Knkemc1wxE3e6hYcv1GkorYNjWqILk1I
         jbxPBl5XlYcc9eo/Eli0TPLgozkgHGd8HMv2D3xpvaz/WMJBeDP1L0BlC9bSZ5BjiqGP
         kbKphXLhT6R7usOI1s2qEUIXh9fOmjZHi3Jpf4T44tD0wARDiuf0824UzfCnrFBBSlNl
         Cvczjwr2oHe89OIHVmugSJ6Ur4nKd2rDj1uMSKBzsds9t3lfYDRxxokclF0hF0pxgdRS
         l4mLBoGhoYTfPQGYblbCHmPv9Y59CT1fDW29hx4FX2kEtghnzxWNNNVcdVh8qjdI+oO5
         6LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZtuDndga+TOd07C3IsVQ8Vs0JlwxIVDb3pBiJowzr21b+I0X0Af0R9QWNgTvfEL+yNX4+YHHdiHABOSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzTTogkOHAtl516BK8JiWeOZKIr3IP3vMUZmhME7EFG7xkOUW
	o09vOYjfCn2STRCV1aEhkO42YmX7PR4JXio+Mz5/ftbYapPG7AWw9vKeNFwN/YF8PLuYRuI0obF
	oa24V9hZYm9MOErb2R7ZjvCGRYm8=
X-Google-Smtp-Source: AGHT+IG209VaJCuImRMuJYeZV5NozAtI44FMbqkT1gHEYTv8Wh4lzDw/X8yzuCj19xqZszR5qNKIcfOpuifWFLrsjTA=
X-Received: by 2002:a05:6a00:6f53:b0:714:2051:89ea with SMTP id
 d2e1a72fcca58-71926055d75mr2296000b3a.1.1726163064013; Thu, 12 Sep 2024
 10:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912014850.1016005-1-liaoyu15@huawei.com>
In-Reply-To: <20240912014850.1016005-1-liaoyu15@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Sep 2024 13:44:12 -0400
Message-ID: <CADnq5_PXfv-0DY3V-QnoWL27TyrrQtec7UWEuteQwECa=TLpqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
To: Yu Liao <liaoyu15@huawei.com>
Cc: alexander.deucher@amd.com, xiexiuqi@huawei.com, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	sunpeng.li@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:12=E2=80=AFAM Yu Liao <liaoyu15@huawei.com> wrote=
:
>
> Remove unneeded semicolon.
>
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>

Thanks for the patch.  This was already fixed.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_utils.c
> index 92238ff333a4..7595355281c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
> @@ -421,7 +421,7 @@ unsigned int dml2_calc_max_scaled_time(
>
>  void dml2_extract_writeback_wm(struct dc_state *context, struct display_=
mode_lib_st *dml_core_ctx)
>  {
> -       int i, j =3D 0;;
> +       int i, j =3D 0;
>         struct mcif_arb_params *wb_arb_params =3D NULL;
>         struct dcn_bw_writeback *bw_writeback =3D NULL;
>         enum mmhubbub_wbif_mode wbif_mode =3D PACKED_444_FP16; /*for now*=
/
> --
> 2.33.0
>

