Return-Path: <linux-kernel+bounces-299365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B3395D3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88EF1F23273
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57E187855;
	Fri, 23 Aug 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNdMcp5X"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC7187FFC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431173; cv=none; b=mVjPzr5lLV/mRY9q3patmWtyfV+JDVZ06nLs6XiDXjmZW22ImNAG7CRgzdt/4IhB4z2w4/h+nJyEWXV/Su1uXvNQASYl2MaV1GCqeQdWxg8xq8z0/GUZ2yov4YM1P7kkOAyNZorUgZ1vQ/mlepG/KcRLBredUGGrOuh+F5SwMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431173; c=relaxed/simple;
	bh=x/iVjaRhtMiCgFAqQDyRPeczrMr0AZDLCf0AQSu67z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/Gk8bB6t5vOlnCYyn07jHIj0hPcbw4xXKpU7QVh83k4o26pe2IZxICABPDpIwak0E8f8SEH9fLFaitFKPq585dwOurxPXTblxsJcyVY7gaQZU3MUsq6Rtu8RLI2yvhYsqcNoX2mZFe3RuWr2rn6u8LiVhWQRWSWfuT/UlGpdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eNdMcp5X; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-273c8514254so1612112fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724431168; x=1725035968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2dFEu4a4aZPz4t5jV1whaeQIxhf8Zys0zAb0G/bCQQ=;
        b=eNdMcp5X/x/1D/KefzRIM27WbqnE0aMFI0m4kQ9JS/zcl80e4o2fJHnTSsCzFHcDoK
         VrGHLrO0RPNsDIPzG2mm/4t08dkBSS6WccUglfGlDaqiDIB+nFChIeZHtEBrS8/gIl9T
         nRAUgvtc0EVLjVw2APKOSLp9HUYrHYoUEbkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431168; x=1725035968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2dFEu4a4aZPz4t5jV1whaeQIxhf8Zys0zAb0G/bCQQ=;
        b=hlnXDG+O5KaQ8uldzss3AbpOtTo7XBp3Bl0hix/mW8ahllA32P25swoi/9ZjQHtQ2q
         8SUVN1B1OjgII1jEg0d9Ju+2lRuOqeoukYDU/Mnax+j9ZPOmVp/J8w74x7UmnIjj1UNl
         /ljtrCbB3E9fYtwCLeiOuy+EiIwdDwB7pRljGc6uk3nZ8L9CX200C6ulJEghOndWN2Oy
         CtZnx7dQNYuncj473Nbpst9Z50VDHScG1oo72mhp/o4359D8c4DT1dzTcOFjRokY/m3t
         Hm2bwL2/8EmkMqSXGRZmR9pV+4Ob7xmyWr4SBJVQXziMrWKNYGUWSTENWI0ptROpA3Vs
         tigw==
X-Forwarded-Encrypted: i=1; AJvYcCX3sMqEiNsQoCCAJ21ok+1zGpccSu+WcuMJlG5BPHwcz0IWGnOyeORlh0Xc1+8SvgZfYFLDCLwu7dwHkoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCNj8PL1cnuPQbL1Vsi7fTusPKBFu3SZW/E2wfseB2T+aVBxQ
	gTflCZTSRbeQC52+u0XQLRceHPUUy2tnX/IN9tbpns+q8ruusMPZEEVQKa7laGC0lXnBqoLQEyY
	=
X-Google-Smtp-Source: AGHT+IGmqw3bg6aIXGjokpWULQms1xFAPgOn6uZmZCBdgqyVOd/wART66wqg0C492e09ljg6XgKhZA==
X-Received: by 2002:a05:6870:568c:b0:268:952b:d2a4 with SMTP id 586e51a60fabf-273e66a04e7mr3137209fac.32.1724431167807;
        Fri, 23 Aug 2024 09:39:27 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-273ce996b37sm960820fac.3.2024.08.23.09.39.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:39:26 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093d565310so2103069a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:39:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQCiW2Fzo6JUwt3J5pgjsHStGyI6e/fDjUwfJ0+EVMRQNEHWnzu8S0RwayHjR3TBUgRApjP7UhYEE7H4o=@vger.kernel.org
X-Received: by 2002:a05:6830:2706:b0:70a:9909:ff2 with SMTP id
 46e09a7af769-70e0e9a9b0dmr2464035a34.0.1724431166278; Fri, 23 Aug 2024
 09:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-drm-panel-edp-add-boe-ne140wum-n6g-v1-1-7bdd3c003514@linaro.org>
In-Reply-To: <20240823-drm-panel-edp-add-boe-ne140wum-n6g-v1-1-7bdd3c003514@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Aug 2024 09:39:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZ=RQ8iK2qfa+BWJsJ_EGFP697qOsN-bAXFeeyhAM-Jg@mail.gmail.com>
Message-ID: <CAD=FV=VZ=RQ8iK2qfa+BWJsJ_EGFP697qOsN-bAXFeeyhAM-Jg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: add BOE NE140WUM-N6G panel entry
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abel,

On Fri, Aug 23, 2024 at 5:16=E2=80=AFAM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> Add an eDP panel entry for BOE NE140WUM-N6G.
>
> Due to lack of documentation, use the delay_200_500_e80 timings like
> some other BOE entries for now.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

This looks fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I started getting in the habit of requesting that people include the
raw EDID of panels in the commit message when adding them. Any way you
could post a v2 with that info? I just imagine this might be useful
someday if we ever have another instance of the type of issue Hsin-Yi
had to fix in commit ca3c7819499e ("drm/panel-edp: Fix AUO 0x405c
panel naming and add a variant").

-Doug

