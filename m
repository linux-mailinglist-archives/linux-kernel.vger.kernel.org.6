Return-Path: <linux-kernel+bounces-311539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB5968A37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B45B22F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901741A264E;
	Mon,  2 Sep 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAUWYhyk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F051A2644
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288229; cv=none; b=dBbUy0bMwDE84Yrd06WaHJ3Rh/NaxL9c0KTPWunxyBX2W6q+zwVVqTlRFu1Gxi1nO+gpINl5CQHgWfcJSC+LiFXHejfUcCRwNKHLod9omGW1t2RpT07q+YdAJ6i08cWLSkZeINmEZJK4wbrnvZaa2tBTHA+tIHtLwXTBjjJA4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288229; c=relaxed/simple;
	bh=JF4dhqTJSFmyNFgmZgqyjkKlHlOhNF1IGzCfM9eHi1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ej9m5i0dJfhMDgpvMdNCNEcQOxd8lGfSx8KeGivcpyNk21SPwrBakzz4mDMMihjOtiEcoIuXEnm1Nf+Xi2619n56hOPcIIOUca3/cFK0LZ0ia4py85j6snN2sbtg4yYhDF4MBmLjfN0OBe+UFIQasQ5A1YHwo9lxLR6rZ/H+JbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAUWYhyk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5718211a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725288225; x=1725893025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFRFdizmhc2CJwy4/CKQA005aAYjoT9/YpO+LeBpeuY=;
        b=IAUWYhykwTlnxOO3oRslB4tXArEJX6FAZWA0EnwUeZO8jl8OMI3U6bHvCdNJTFc9Xc
         8WPO9HzpbrXhvpxVtIV2DRgDE+zAhT8qgLlZsUjyE9UBBNdXz43iTSQ2aDV7TPAOYlAX
         Tvsk7JNPtaV8Z8fOIY2Y6IwbueM+T2LAP4JmqWpCgTH6A8L4NXV8oZqzQfbNAZi8Yb3A
         /VbXOSBqqhf7lhblSQL8wsun1qcOmw6S5D5a3XDLEmCs17aNeY4zwyqGSUI5Q/yRtqhv
         fAY69hpxg2VSFnijjEDia+kVjMhMTmeMCBVdmqw+RqDCd237zNW2ogTZXHB0PZs+8Nz6
         huZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725288225; x=1725893025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFRFdizmhc2CJwy4/CKQA005aAYjoT9/YpO+LeBpeuY=;
        b=Jp9KBJMkyiZ0/DrxmjBJN/TzDCjL+QfIOM5LW3iQEfB4WO/JeU3aG3MNC96D5jbL1R
         dqezZEv1foECHWqrBrot9teSfaURL9E5zQZktKTlt5Lp23PgVMrxcKC8D7FTFGbiqaqh
         LreKoUq/PTHQXpVjQObWxDgulb38uF/vzxru6/xqCE6BKfBRG149EtOGRmjgibisQ/QQ
         4AIHrXnw1y30v7cafMw14ob2IR+imtYeIzYMKuiIZT+MJ7JYTJS6BqgjXZfzJn1guvwV
         SHFvuvnVLdkHauF/5ah7WXyHtVSIX+gKlp329wm/fH+013hYxZk+e+AtISTNHDpS3x2A
         E8OA==
X-Forwarded-Encrypted: i=1; AJvYcCXhy/JlWCutACgSg4WkNGA7lUZqkqDCLEXmGZ9y9jPgihuVjNuXuJi/y2DGKWzVStsEkHdsD+AzES7I5+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjyUgSqbvNWjBeCFhM7eaQv5tnGXctOhKeAoSSiidyg/KdPpGo
	1Dhk4CxEexnSDZWxs2ri3a/QecJYwt3W+kl4OlBT5sjxeDxp61Oi
X-Google-Smtp-Source: AGHT+IFVrmcQ2LyLLYhiHo5LRdWuFIggl65+Wa6I1kVeqYevDcItonWteNGDfQxRBC1yUAzXhRpMfg==
X-Received: by 2002:a17:906:f5a8:b0:a7a:9226:6511 with SMTP id a640c23a62f3a-a8a1d3268cemr29177566b.31.1725288224997;
        Mon, 02 Sep 2024 07:43:44 -0700 (PDT)
Received: from localhost.localdomain ([31.19.114.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968e9sm563655266b.120.2024.09.02.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:43:44 -0700 (PDT)
From: raoul.van.rueschen@gmail.com
To: tjakobi@math.uni-bielefeld.de
Cc: Rodrigo.Siqueira@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	sunpeng.li@amd.com,
	raoul.van.rueschen@gmail.com
Subject: Re: [PATCH 1/2] drm/amd/display: Avoid race between dcn10_set_drr() and dc_state_destruct()
Date: Mon,  2 Sep 2024 16:43:36 +0200
Message-ID: <20240902144337.18223-1-raoul.van.rueschen@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
References: <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> dc_state_destruct() nulls the resource context of the DC state. The
> pipe
> context passed to dcn10_set_drr() is a member of this resource
> context.
>
> If dc_state_destruct() is called parallel to the IRQ processing
> (which
> calls dcn10_set_drr() at some point), we can end up using already
> nulled
> function callback fields of struct stream_resource.
>
> The logic in dcn10_set_drr() already tries to avoid this, by checking
> tg
> against NULL. But if the nulling happens exactly after the NULL check
> and
> before the next access, then we get a race.
>
> Avoid this by copying tg first to a local variable, and then use this
> variable for all the operations. This should work, as long as nobody
> frees the resource pool where the timing generators live.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
> Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while
> keeping DML and DML2")
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++------
> --
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 3306684e805a..da8f2cb3c5db 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3223,15 +3223,19 @@ void dcn10_set_drr(struct pipe_ctx
> **pipe_ctx,
>  	 * as well.
>  	 */
>  	for (i = 0; i < num_pipes; i++) {
> -		if ((pipe_ctx[i]->stream_res.tg != NULL) &&
> pipe_ctx[i]->stream_res.tg->funcs) {
> -			if (pipe_ctx[i]->stream_res.tg->funcs-
> >set_drr)
> -				pipe_ctx[i]->stream_res.tg->funcs-
> >set_drr(
> -					pipe_ctx[i]->stream_res.tg,
> &params);
> +		/* dc_state_destruct() might null the stream
> resources, so fetch tg
> +		 * here first to avoid a race condition. The
> lifetime of the pointee
> +		 * itself (the timing_generator object) is not a
> problem here.
> +		 */
> +		struct timing_generator *tg = pipe_ctx[i]-
> >stream_res.tg;
> +
> +		if ((tg != NULL) && tg->funcs) {
> +			if (tg->funcs->set_drr)
> +				tg->funcs->set_drr(tg, &params);
>  			if (adjust.v_total_max != 0 &&
> adjust.v_total_min != 0)
> -				if (pipe_ctx[i]->stream_res.tg-
> >funcs->set_static_screen_control)
> -					pipe_ctx[i]->stream_res.tg-
> >funcs->set_static_screen_control(
> -						pipe_ctx[i]-
> >stream_res.tg,
> -						event_triggers,
> num_frames);
> +				if (tg->funcs-
> >set_static_screen_control)
> +					tg->funcs-
> >set_static_screen_control(
> +						tg, event_triggers,
> num_frames);
>  		}
>  	}
>  }

This fixes full system freezes when taking screenshots at low framerates with VRR enabled on an RX 7900 XTX.

Tested-by: Raoul van Rüschen <raoul.van.rueschen@gmail.com>

