Return-Path: <linux-kernel+bounces-348185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E098E3CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1607D283664
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24730216A05;
	Wed,  2 Oct 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYmm18Fi"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593D1946D0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899286; cv=none; b=b8PUOrvEVVCJNYjhV7MSwoettFIA41pXuZ+CXmLB1jCXJOHoQlURbD4VqNXOATZ7MVC7pLKSlc9mfdnCLyreZZlyIx1cwm3W8xZuOQ/oMr2KyVp7OFAH6Iw/kADPxtoNHy4tz1g+zhuzuvtzhfkLvrXpePNAAK5Upw+/e62MOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899286; c=relaxed/simple;
	bh=vmXz5DptHKNfhCU297MSr/SZOtqvGTgmb2tR2k5zN8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brAm/HkJAjy0Y227XdeOsnzFd2CleblsVOhFiDDtqJRW789bgrEzubS6Equ6xmMBxlOoYcBUBYEQxsoROiwAsJij9W02jcPmVNNF24Y1R4ZoS2KwgUGClj8kDqFnbUri9fxm89CYU48vfyclScICfq4np4CIf0PrU8wF12j8/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JYmm18Fi; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac187eef2so2347781fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727899282; x=1728504082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RTbP2THnQ7ZPSao3GlpGoyqfA8hmjwpPW28NYvs/R0=;
        b=JYmm18FiCbmNCnRhvauaMxjh8UpSID8+x8OM75llgHi2V4fxCLR0BT4RifhY06SDsI
         vLWqZ2XzaLBpx+qFBtMlkwvxhO1Ka9TJhloQ8J9xDgb868OWkV6MJKKLrtwVmXII1aDB
         fwaYTDzKi3TREsuh+HxaaWFUQnbiVq3j+qfqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899282; x=1728504082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RTbP2THnQ7ZPSao3GlpGoyqfA8hmjwpPW28NYvs/R0=;
        b=OKMUY9FRPyJ9wKtVSIWxdM/IXJ5j5JGswR8D6ktMSvnzzCUwS5zPJFtWFXpIEJs63B
         Hz2XbCYM0d+6e0RljtBIE77pRsJuFSKQPI4ogio5G5pf2sVIwLGZ7kSD/Foq+JZlVTrn
         ulsxVnHvmsfZ8CI+jvD3jUu+IUfIBJLvwuCQDxAcvDQraERF32LLA3T6kt/YSbw4WzUz
         Xk1YiU3916QMpQgh/qeKPe7VOiFcNgMT3gXjC8glSFdxcvOxkl/mRxMIelaZN4UwIbUt
         BXW2con/zQRjBY52IyOay8SGbKe0BiD1OhgBzv8Br1od9QGhb6wVPRQQckHA8pF39TdO
         qIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWQBlqCNifR7OAxsatXb8YG0tn8QFVIW6+bcxfLiZiQiObWhCb20i/4POyVQlPwFHCJ4Ni4Kyi1Myd17eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVhskvSO7mxOuEXfNi/WSKtyAbED+UGGewAZt+VDqBjXBzKcp
	SLDOObPbhxSwE3nddx3WcfFJ6x/cA/4nIi84FXlyTJeWKqi2Y+CRTmz8q0RNxX0iHyLfGwgoqdW
	4sg==
X-Google-Smtp-Source: AGHT+IEfC/lPg8RP4BClALuDasObc2u7Kb/aqEM19V6WxYDf6Amww8qB7jXzS38UxxVitT3k69B3hw==
X-Received: by 2002:a05:651c:a0b:b0:2fa:d5b2:e527 with SMTP id 38308e7fff4ca-2fae10a90d1mr29589621fa.35.1727899281376;
        Wed, 02 Oct 2024 13:01:21 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d46198bcsm20871831fa.115.2024.10.02.13.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:01:20 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so175595e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2zkAGAwf+B36sG+OfjcuWkbd68T562i3EIpDXv6DieTv/sJapJDAcCGGqOTIv+yIbGZuckhlLfQsHdp4=@vger.kernel.org
X-Received: by 2002:a05:6512:b85:b0:539:896e:46c0 with SMTP id
 2adb3069b0e04-539a079eaf0mr2740940e87.37.1727899279887; Wed, 02 Oct 2024
 13:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927094340.18544-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240927094340.18544-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240927094340.18544-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 2 Oct 2024 13:01:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vm-MzhNrotMz1n-iYvm_VAfyVRDtTp4yrQ=6sCTzX1Vw@mail.gmail.com>
Message-ID: <CAD=FV=Vm-MzhNrotMz1n-iYvm_VAfyVRDtTp4yrQ=6sCTzX1Vw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/panel: jd9365da: Modify Kingdisplay and Melfas
 panel timing
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, hsinyi@google.com, 
	awarnecke002@hotmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 27, 2024 at 2:44=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> In MTK chips, if the DRM runtime resume has not yet completed and the
> system enters sleep mode at the same time, there is a possibility of
> a black screen after waking the machine. Reduce the disable delay
> resolves this issue,

This sounds _really_ suspicious to me and it feels like you're just
pushing around timing to get lucky and avoid the problem. Generally if
decreasing delays like this fixes a functional problem then the
problem is still there (just hidden) and has the potential to come
back if a little extra delay shows up.

I don't understand _why_ it's important for DRM runtime resume to
complete before the system enters sleep. Is this causing the Mediatek
DRM driver to get confused? I would have expected that if the system
went fully into suspend that it would have totally powered off the
panel and then when we resume the panel shouldn't maintain any state
from before the suspend.

...so this needs to be debugged more and a real fix needs to be made.


> The "backlight_off_to_display_off_delay_ms" was added between
> "backlight off" and "display off"  to prevent "display off" from being
> executed when the backlight is not fully powered off, which may cause
> a white screen. However, we removed this
> "backlight_off_to_display_off_delay_ms" and found that this situation
> did not occur. Therefore, in order to solve the problem mentioned
> above, we reduced it from 100ms to 3ms (tCMD_OFF >=3D 1ms).
>
> This is the timing specification for the two panels:
> 1. Kingdisplay panel timing spec:
> https://github.com/KD54183/-JD9365DA_Power-On-Off-Sequence_V0120240923
> 2. LMFBX101117480 timing spec: https://github.com/chiohsin-lo/TDY-JD_LIB
>
> Fixes: 2b976ad760dc ("drm/panel: jd9365da: Support for kd101ne3-40ti MIPI=
-DSI panel")
> Fixes: c4ce398cf18a ("drm/panel: jd9365da: Support for Melfas lmfbx101117=
480 MIPI-DSI panel")
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

For future reference: please don't put a blank line between the
"Fixes" and the "Signed-off-by".


-Doug

