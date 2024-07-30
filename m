Return-Path: <linux-kernel+bounces-267352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734A941094
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235851F22619
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9719E808;
	Tue, 30 Jul 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnFfT25d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0C18FC82
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339348; cv=none; b=oxa9AvGA+jONy3cY5DNqstg1e5JCclsEuQTG2+06/nWBdXw6KLMPmZMjG8qTuho/WobMZ0SvSP3Eq5H+IdSn8z9bqAmvP/RT46gFK/i4fAbiz78ca9g3dgg9TaYEbbw2iVrjBvUshlkq+NQUWm11wAoX4ND96TPoXX4k4iTTxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339348; c=relaxed/simple;
	bh=QuGx/cfgbpy+UDC/SMjDueR0n2vdbpL7mFmj7Sdj8M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoDry7R365YYlc64atmYDnSbuN5giCZkjROuJyILIqzhNurny2sW+ngq6tLMVh9+QFAxc00qalWjKAaKPGbjmAOX2EbKWSFRZVeiUPh+q6QIUxHd8AG8pkEUCgFEtSDZdZ6uO5Q08RxvHLVZkH3HbCf533Nq6Ns17XkdT725fus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnFfT25d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EF1C4AF15
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722339348;
	bh=QuGx/cfgbpy+UDC/SMjDueR0n2vdbpL7mFmj7Sdj8M8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bnFfT25dT4wKLkt4Vk1uoutR+SM0e24bqowcermTIFbjhl2y/71pFNTXmdZDhgnDE
	 TqpQZ5kSopjJ8mAwiU4+6BPPi23H9YmDnlxYm5gJeb/p6991S+BWAWxSiQbKoGz84D
	 8gk2JRQbkj8UldYrDaGdbAQi9VPtaFUDR3JXHBDk6A2XIYzbKEKEPop5uesnP2IhAb
	 ogX0DfwQe0EnO701vinESDaO9oHAs57UazliJXsT5XRYC8i2OiqKf8LcpuZ9+Z3Vi6
	 vc1wU46kGPCGPcTnn5eRxx3Te49iUUaoSZymLrgxbWDukdSdTkQKMjeGaBRH9H2wXr
	 jSd+/hq7X06Kg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66ca5e8cc51so33849587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:35:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNQfeH0CTxHOcjJ5Yr7E2NiSFKVLk1v8qNphT0jf32S7cY+/NSy6a7kyO+yj/i8h3WhTMLFhSEBxNvGa/2LsfD5HVGG5AIxgJygbax
X-Gm-Message-State: AOJu0YxhhA+8okX+SzVrHM94IjMlW5OSGJAbCskcsguxZwAHmbiKU8bO
	St/hc1Mp0XLeE5fgSLUDjChwGb3/96t7IARNUki/6yvKGZ6biHdAJeSHJZiC5/svmXhKwpL0gjr
	3wiLHi2FlTZ2MnKmlZSjTUbFk0QvjI7h8dxAknA==
X-Google-Smtp-Source: AGHT+IEXZhkCqRyUyEyxTHFbtZAKND/cdRQlkpUzzuZrzlEMTWVBtNPZMpw+/ALQOHM7BlhfWq0bh9W0/8U1+/SzMZE=
X-Received: by 2002:a05:6902:2b0d:b0:e08:5b14:dfb0 with SMTP id
 3f1490d57ef6-e0b544f4aebmr13391934276.28.1722339347522; Tue, 30 Jul 2024
 04:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
In-Reply-To: <20240701-lt9611uxc-next-bridge-v1-0-665bce5fdaaa@linaro.org>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 30 Jul 2024 13:35:36 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5=VmahLzVYEYfp6TAe=w5pB7hgaEy1SN55s7fsUkyoLg@mail.gmail.com>
Message-ID: <CAN6tsi5=VmahLzVYEYfp6TAe=w5pB7hgaEy1SN55s7fsUkyoLg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/bridge: lt9611uxc: require DRM_BRIDGE_ATTACH_NO_CONNECTOR
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 8:20=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> There are no in-kernel DTs that use Lontium LT9611UXC bridge and still
> require creation of the drm_connector by the bridge on attachment.
> Drop support for !DRM_BRIDGE_ATTACH_NO_CONNECTOR by the driver.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (2):
>       drm/bridge: lt9611uxc: properly attach to a next bridge
>       drm/bridge: lt9611uxc: drop support for !DRM_BRIDGE_ATTACH_NO_CONNE=
CTOR
>
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 103 ++++-------------------=
------
>  1 file changed, 12 insertions(+), 91 deletions(-)
> ---
> base-commit: 74564adfd3521d9e322cfc345fdc132df80f3c79
> change-id: 20240625-lt9611uxc-next-bridge-5827d9b17fc1
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>

Snoozing this for 2 weeks, since it is removing functionality.

Reviewed-by: Robert Foss <rfoss@kernel.org>

