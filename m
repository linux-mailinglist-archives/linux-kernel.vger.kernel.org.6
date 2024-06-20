Return-Path: <linux-kernel+bounces-222927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF8910A08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267C71C21070
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330CA1B143A;
	Thu, 20 Jun 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/XyTFaS"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AFA1AF6B7;
	Thu, 20 Jun 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897840; cv=none; b=jpdAxXRu6q11hHxDnkKCyXcb8NYLQcblTtXVzM57y8XMEglCpPROoU8gLaAQJezDOSdb9vkdba12z4SKp/shMOVZesAr3pzOpJ4/BQqdF2CvSVUXK2uLDpo0pMAFINI5BaJCxUY0Ud2m2LPob3qEpNVskR8cgUhi9cM/vgfm0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897840; c=relaxed/simple;
	bh=8wpoUZH3SR3wSuMlTkrUQr+OoR64UaEjTJ4j4qsZPAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug9/N1sWWEHgFWlBEh2hrdYktUgSrqq8c0s88ORpDMvs1C9LbkiwAsprIN2dwOjSLACh6LCXwyXU8KhY5vr1rNyXI+RbCmKs9u3RTSkKzA9QpfAd75ascaqCdcQdue1QOjhcPQvWFy6I36NNMeJQqGBY70W/wVBazJxQqE/uneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/XyTFaS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-713fa1ae9a7so669050a12.2;
        Thu, 20 Jun 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718897838; x=1719502638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uAJa9cd+U3ByOgDIj6AuFYi+T/LG4WllhhWOF2SAZo=;
        b=W/XyTFaS1i07Tx+siKrpkV4SVB19G+fQTsfxz89XskK2RZry9Whq1NdkctAgvWRnfR
         cDQ02rO4twdsMHG/UPzJ0ww63NengFHcPHM3azUv8V0mKYbHXdFooJ26d+mmOr+KUxiG
         u3Lehthy+yAhNV3Ot+wcfQ2Q5swCtUXQ+rZhkpSaPGjgORz+PMpjCD7vnqyyAzjNr5J4
         29ifqDz9WdaQIkvCuwmVIlJiQDghNf9hO7wcQGVsLApKQOpELNJNG7nnkuRN2/wNNsG1
         WyslKaWlZnC8Ka/haL2NBonJNxIbSLUR3+PeZk/M8SjaJt8AbFRS5fzUyQCGIwGGn54e
         effQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897838; x=1719502638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uAJa9cd+U3ByOgDIj6AuFYi+T/LG4WllhhWOF2SAZo=;
        b=K44OtjOHinPJtJ/COw8dXgieq3IwLnwK6Hmp41D4N8VsFWDinQN4a/NoAq8J7vlTBg
         W/y1pIYGPynMv92biTT8zxP5xfRCXe6CQYqdMTJdaxROYUo0F8e1vt2HHkWE3LbTGg5u
         q/K9xk5bXGEgYIZLHMWf+NQ/1WYB5IjlgAg1egGpYMfhMDTyPs8GNMWsRTly2CYdpQ9L
         BU7jLpWnUv4dCNq4Doe/QWuD+uKpukMjbKonLt4LPNryYJlnP7cFE3eXuO70eZ56lZhE
         I1nlCpKF5h/sJoB6IbpVQcqGU50qc4NpzThKA4xcF7TsZqILRb6F6R09YzP0Ga+Z4uQ+
         WrCg==
X-Forwarded-Encrypted: i=1; AJvYcCXOgIpcnGBt84O7A7ChVImVh8KgeeOID6BIlJfcWphUyW7uPJXQ/YcftUoW9iEIeG0BBYn1iEqKbx1NsEhZViZBIwLbRYgXm81274IyrIN6QEB5g6t2YoTvS572ly6kf2bCQo06NIA9sD3o1JXu
X-Gm-Message-State: AOJu0YzeUUM2bbFpwfyWQNCglv8sG8sFi+tRiZ3xqY03yrXYNffw8DHc
	er6Hj/D8JXqF/U2avo5d4ovbGzYe9MVC6SDEJA8IWdpiX4sxDOM6R15p2l5+bHe6/3eb84IrpYi
	mb3HUAdBOhVgrgmg8tMx7F98AlG0=
X-Google-Smtp-Source: AGHT+IHSa5FQ71JMRXYJyNnf8Gm4yVBhH8IUXZ/P53BWbl/sQt3VuXb0a7WwZrfoKndyPecNdx8rJ7qCoEk/iEFq384=
X-Received: by 2002:a17:90a:2f45:b0:2c7:aafb:8e3c with SMTP id
 98e67ed59e1d1-2c7b5afc252mr6219918a91.18.1718897838148; Thu, 20 Jun 2024
 08:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a57a9d8f-40bb-4cfa-9dad-4f93a1f33303@moroto.mountain>
In-Reply-To: <a57a9d8f-40bb-4cfa-9dad-4f93a1f33303@moroto.mountain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 11:37:06 -0400
Message-ID: <CADnq5_OeVWwL2UfR0a5eE5TYaQo4QySvTennYJdGQ9r-ajDwWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up indenting in dm_dp_mst_is_port_support_mode()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alex Hung <alex.hung@amd.com>, Wayne Lin <wayne.lin@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, 
	Agustin Gutierrez <agustin.gutierrez@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Hersen Wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Thu, Jun 20, 2024 at 4:49=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> This code works, but it's not aligned correctly.  Add a couple missing
> tabs.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 48118447c8d9..5d4f831b1e55 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1691,7 +1691,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                 if (aconnector->mst_output_port->passthrough_aux) {
>                         if (bw_range.min_kbps > end_to_end_bw_in_kbps) {
>                                 DRM_DEBUG_DRIVER("DSC passthrough. Max ds=
c compression can't fit into end-to-end bw\n");
> -                       return DC_FAIL_BANDWIDTH_VALIDATE;
> +                               return DC_FAIL_BANDWIDTH_VALIDATE;
>                         }
>                 } else {
>                         /*dsc bitstream decoded at the dp last link*/
> @@ -1756,7 +1756,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                 if (branch_max_throughput_mps !=3D 0 &&
>                         ((stream->timing.pix_clk_100hz / 10) >  branch_ma=
x_throughput_mps * 1000)) {
>                         DRM_DEBUG_DRIVER("DSC is required but max through=
put mps fails");
> -               return DC_FAIL_BANDWIDTH_VALIDATE;
> +                       return DC_FAIL_BANDWIDTH_VALIDATE;
>                 }
>         } else {
>                 DRM_DEBUG_DRIVER("DSC is required but can't find common d=
sc config.");
> --
> 2.43.0
>

