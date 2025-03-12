Return-Path: <linux-kernel+bounces-557471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7183A5D9A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E84E07A9240
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A623A9BA;
	Wed, 12 Mar 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEBzLpcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997423A9B1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772189; cv=none; b=pDkBoLvb0lpyGmUGtNSpppxw4Fn95bBmoxAdnOfJHXCDSoIE2Y9iyYbMTY0b80Brmz1eTw3YmZ2TAgK+D8SCMyFGgu9CTZMCb3ZNdtcz+iiqRpJ5h010dm+I900kTYVluxrEPdqHNRKaDcUZSj5E/nvSpXrr0wfM4jIaJnVK7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772189; c=relaxed/simple;
	bh=8PCB/qX+omXHOsFHBh6+ImDcq7aHjwbUaKNYTgAx65M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiXTNHMIBxRYVZz9hk8QrKEybnnAoBBJKs55B7k42t+ylSDjNZeI+jbw4X3fJPqcRV3fLyTpZ37VPzeCamWV7I0LjbR/gYg17s4KxJfPseMgLzj3aAC0iqetQYP1SD3wj0LDIDtaeRI7bw2s71VkcpPZdeeSihussPOWlb05Jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEBzLpcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA38CC4CEFA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741772188;
	bh=8PCB/qX+omXHOsFHBh6+ImDcq7aHjwbUaKNYTgAx65M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEBzLpcbPuj4e5LEPxjlMn5ET6BzLahR0WZPFffQnWR0rtFt8wO6JlM9UtruojUPn
	 p/NW6fh1grHD0hWfmEwgleZcXQSatUauD+3F2xfYIBLoOb9l/EVqGGrNr8ttO3XVTh
	 kwZgRoB214xmiw4XZtRf2D5ndjGqyTxwSeRRcqU0p9qWrlNOv4I3c2l3nO3LbPnNhz
	 dvHyaaJl6J+VqV3LCLN2WI4HU+O0m3z1vcNkGGHD7/XpOSyhkSmPiR/jjV6f9Liv+S
	 SN+fcz/eZYE20DMy/RaG89CGZiddoH6Ua9eGCBb67ggGOkOn0jsJm4roxLD5WTCbpk
	 +B8B+DyNYVt8Q==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fedf6aaed2so7024047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:36:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrK0ejIjHD26xhDRUeybJfiNbDZVZhd13bMGXf2r0O5PL5rUDMhKJYTuILpvh8Wx/WPUJVYJhy++X+Gz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nT7a75dSvbTcLs5Cfq7QoxAbKqJZL7AqMsYyn4ugzd6Xs8gz
	Fq8VPa9qH73DNvLTS1V8vHr2tipEzlPaeolFLyJajsVp6hNSDNGCmPQPfvNPBP3s4bmA7zl2Fvw
	9YSB5V6veN637Rxyy7pMkn9VSJsPPTNH80gyhNw==
X-Google-Smtp-Source: AGHT+IHS3can8YTqoJneu0xqWWYflo47tYvjFtQtHgO34GoAaFcy5Te+GS9aJB6DmOJN+G2yDVqsacbPbmbCFOL5/7M=
X-Received: by 2002:a05:690c:2e0a:b0:6fe:8fe:f5c2 with SMTP id
 00721157ae682-6ff0a2ab572mr69759157b3.8.1741772187605; Wed, 12 Mar 2025
 02:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312090132.1624445-1-nichen@iscas.ac.cn>
In-Reply-To: <20250312090132.1624445-1-nichen@iscas.ac.cn>
From: Robert Foss <rfoss@kernel.org>
Date: Wed, 12 Mar 2025 10:36:16 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7k=fo6V5Mqp_yOkaW25rhTYEgAdC+fCfB_72q9ObKuxw@mail.gmail.com>
X-Gm-Features: AQ5f1JqTE66ahaBB-lj6ixl6TplWwGh5gTDicN8Z2hQ9Cq7gqe8waoTJ4QjaNVY
Message-ID: <CAN6tsi7k=fo6V5Mqp_yOkaW25rhTYEgAdC+fCfB_72q9ObKuxw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Remove redundant 'flush_workqueue()' calls
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	yuanhsinte@chromium.org, jani.nikula@intel.com, xji@analogixsemi.com, 
	robh@kernel.org, sui.jingfeng@linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:02=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
>
> Remove the redundant 'flush_workqueue()' calls.
>
> This was generated with coccinelle:
>
> @@
> expression E;
> @@
> - flush_workqueue(E);
>   destroy_workqueue(E);
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 0b97b66de577..591ec8e5b642 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2771,7 +2771,6 @@ static void anx7625_i2c_remove(struct i2c_client *c=
lient)
>
>         if (platform->hdcp_workqueue) {
>                 cancel_delayed_work(&platform->hdcp_work);
> -               flush_workqueue(platform->hdcp_workqueue);
>                 destroy_workqueue(platform->hdcp_workqueue);
>         }

Reviewed-by: Robert Foss <rfoss@kernel.org>

>
> --
> 2.25.1
>

