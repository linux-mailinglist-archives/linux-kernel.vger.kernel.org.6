Return-Path: <linux-kernel+bounces-330294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A25979C33
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16F0283ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86113AD03;
	Mon, 16 Sep 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AwjEfGu9"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A417FE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472642; cv=none; b=XUMQ7FkVhbtA1mh+WiLLkMGb1I+0n0/mL6/O02WAfhBvoeabzIvlB9pNC0MVegz7+3v7s+UkqbgYkDGql5ZzKXyMdlOIv+NuOElZIchCRLkhDiYTbsgRGY6ngKDcJwmxmHgp4Lk5PZqm6SRF/faoixTUfATDQOKd8emV5rs0QHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472642; c=relaxed/simple;
	bh=Jwo5385ZMQkzh2acu9QOPGz519eFiMFZ5iFwMBETOUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd2AJmIh5R3JwRxPSLMc2z/IrW1Gks3JDCEI8Rt7cJnbSLhDB6fp+tB6/jhgyHIheeH1ovaDtgTkaSbZVzQZCp8asJBnKDytA943a8zDi3EL+v3FB1ITqZjkRVOqZmeJ1neHQks82l6Ki/Obl2hF6ejMv/xYs6G874WsHFkupeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AwjEfGu9; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bd3bf3b4cso1811856137.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726472638; x=1727077438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E75Wlgna/GKE3PiZfSh3okspmyAQgbNKnoUlsHO6GkU=;
        b=AwjEfGu9XzpxZ9ZrNsufh4PiDk3e0Y/i14o2UXUG6+8icyhAIAnmAD0oHheVG3YiXf
         6oo3pRdXIInjx5a4p9HuiMD7vNvAXI1s16K1BbY86hWymzmkrd9OONgsGqXAxQLUVbKQ
         3e8guQumrCrAtHtAmF652znL9laeM9mUom48U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726472638; x=1727077438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E75Wlgna/GKE3PiZfSh3okspmyAQgbNKnoUlsHO6GkU=;
        b=QoxAHE9AF9e9D1P+4LoXvpFHDNA8zkesRPkjViXkeO0OW+0a9bQm3ESuXQmCxCOOm4
         Dr6D5TLf0sr2zlEP9qa4eLyAHR4qyN05Xy/qMxPMZcsHNxgK7fqC7DIL2cRNPHuU0/QZ
         SCyHWTyUE7U60a2+KUher6zgRsfSEXgRBvFErdh8TyJIxbpqOMwfNcPvEzOSG6hJK/cq
         ehZt+Cf5nLVq4DWRbVJK1pHm4Scc42zrqaFxNQjroSfW7W8VVgRVA3yeOZmUMwH4TpOz
         PoXfJ1Yt7LvjNtOw2Vh2X5JNdJ6e7q/3s9w6SKb6OFOtvJaCHdFCJ7jcPZRpjb9nJiyj
         jSBg==
X-Forwarded-Encrypted: i=1; AJvYcCVUf+L2SeOI3mpYgzP/t5tLGpfdhmt9IliApTe5N7egjnVacxd3nReAFGaYupi4Mt/RpJAw6VEvL4sfkK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSsY9gRPcyAe62lxFPClWmfBM2rcPaeaA243iBCbc0bs1Ycdj
	X8BoEdZwaHeyhVdAy+jBdWNvdBtyb1PNiaLeOG4/zHtniGV11Ory0gD91akQOMfMQoAE8jt+1qB
	7CQ==
X-Google-Smtp-Source: AGHT+IFfdCAoGgLmSm52IxMICWIPh2BHMaYix+obNfBwAAC/iztA2B9VIyUu2Sc+iU5R1+bOln+1kw==
X-Received: by 2002:a05:6102:c0d:b0:49b:e3fd:b6d0 with SMTP id ada2fe7eead31-49d4146813emr12480055137.5.1726472637753;
        Mon, 16 Sep 2024 00:43:57 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49e6b11c2c2sm689578137.6.2024.09.16.00.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:43:56 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846db33f4e5so979734241.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:43:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZaC1YBCDVzxB0IzCZVIBchqeBP4qW2C0QoSggG+LU8C9G1oioDWGUT5VH7FryVI2e07hIk9h05WEcCbE=@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:49b:cfe3:a303 with SMTP id
 ada2fe7eead31-49d41482bddmr12555482137.9.1726472636170; Mon, 16 Sep 2024
 00:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914034341.897197-1-tejasvipin76@gmail.com>
In-Reply-To: <20240914034341.897197-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Sep 2024 00:43:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vap-_tYLQVNP8xz3O=k1b=ziBsV23DGMC0m1EkbzNhiA@mail.gmail.com>
Message-ID: <CAD=FV=Vap-_tYLQVNP8xz3O=k1b=ziBsV23DGMC0m1EkbzNhiA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: raydium-rm69380: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 13, 2024 at 8:44=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the raydium-rm69380 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Fix whitespace issues
>
> Link to v1: https://lore.kernel.org/all/20240907140130.410349-1-tejasvipi=
n76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm69380.c | 93 ++++++-------------
>  1 file changed, 29 insertions(+), 64 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel: raydium-rm69380: transition to mipi_dsi wrapped functions
      commit: f70181b3bdec6b8a166c6295937c4a8a5322515c

-Doug

