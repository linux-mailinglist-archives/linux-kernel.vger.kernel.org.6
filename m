Return-Path: <linux-kernel+bounces-348187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC698E3D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1ED728296A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F598216A02;
	Wed,  2 Oct 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ax7dQn72"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106715252D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899361; cv=none; b=FgtmNnBKQKzqNqu3+fRWcmtS0HUavEpyumE5raeWohmvTMW6Seg/6REwEcSMkxC4HwlpZVniGDQhDfP2oQju0wLQeXO5Sx6OrqJwtG5SGgGVU8S/gQOmcVv1ik3aapzDy/nSwmZBaWSqCpQguhOSEAu35XMLMJgrNbasHgw24OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899361; c=relaxed/simple;
	bh=cPEWC+ms1931EI6qBFNLg3svt4urmza+0m6lhnuFJ08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxzjhqkvJ5VIkDkmuwVFNqBVcZWMIvovZpHT+soc8mp4iBuH5gOrgTpqSZzw+QeZu9x5tlRRvT0CIAlnJZU51HFM2vjcrnqsW/0zpjU8eyfahUkIBIrw4+cZCEahLDAYS3+5bRsy4HTaZvD5IzsmOaOrJ8AfcnmZ0lD5G7o9JeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ax7dQn72; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf481587so1701821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727899356; x=1728504156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91dAvx/GtXFhViAEPrc2ya71jT/cwYu2QCMwf3YXBnA=;
        b=Ax7dQn72zCLPmHlTksSw2utU4HofSSRho626Pb+8+tUVIdfzD6KsqfNM2uu7nMFc3j
         6siQRlgrUVVL7H+/ui1gmEMSubtvQjk/0txiTjvZPZ2RhKTkRQPg0N/mOZazgLuonDe2
         PNInfed9uaYwsyJNqzUXHmURv0LNdPe1pPRJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899356; x=1728504156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91dAvx/GtXFhViAEPrc2ya71jT/cwYu2QCMwf3YXBnA=;
        b=pyEYn5KjaE+93mZ12U3pHhLif3WSIR7vSUv1ivGEcex4QbEvpZvBSD+UqsfHO7iZag
         r4X5/HcuiVO5Ns8NQFvEgddJ/UdlOQ9wq3ia0k3gzNQBdUaJ0SKHu0FthnJJDlZuNiW7
         0sbdiqw5T1ONoI42H1WIFuMBEwBbN45Akwt7Ng+GM1z8xgfkwEMux6BN5jt1Dq7EJySD
         yYlJTWCY7juAQ2/sYUMRLqEyhc679FXsZI7OTopmsk07x6cbJMJ2qxflqvdic3M41eJG
         fyGbmS/kPb98HmnTw832kfp8LvszudfvLTdJQucCTnlrhQfuTvcZJnq4/VmX0NEMI7oy
         wtEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlkQrFbWZ+gNEX+BtjydgP7xgGAifetKeSovj5N0aGsExvk7d6xsgMrMRJDz5XExFsFDScx1oIPMHtllA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQIVw6g0D4h1v1ReGMq5pKq4RBgr5bZ/7v/RPkwZgEr1F+FCB
	wrOgWzLG2cWPXqjqf0mGZA1Du0MXHdJX8Nzbd83/IOa0wy2U0ctTTX+JCOdAlxq0veRZkntQ5ZG
	EwA==
X-Google-Smtp-Source: AGHT+IHdz9vsOYUh1/5Q2XvlPCShmyix2iDhkMjvzzMVIC70klNgZDpRd7RxiFq6lv00zLg+LUEzSQ==
X-Received: by 2002:a05:651c:204a:b0:2f9:c0be:3b14 with SMTP id 38308e7fff4ca-2fae10ab4aamr21729821fa.42.1727899356171;
        Wed, 02 Oct 2024 13:02:36 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fac9a55538sm13030601fa.16.2024.10.02.13.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:02:35 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so2100901fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:02:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAjHWss/kZhQw7Gw4XMVrJ019tdd8SsGw2iWfvkiZQi8IZmOouU6K8Qho0P1ma/ZQxoN3thAD2ziY3DQs=@vger.kernel.org
X-Received: by 2002:a05:6512:3b1e:b0:536:56d8:24b4 with SMTP id
 2adb3069b0e04-539a065eb21mr2856666e87.5.1727899353357; Wed, 02 Oct 2024
 13:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927094340.18544-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240927094340.18544-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240927094340.18544-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 2 Oct 2024 13:02:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WTOCNtvvT3Z-5-7eRnFt4Um9R+vq2BB+V7DhWngsKrWA@mail.gmail.com>
Message-ID: <CAD=FV=WTOCNtvvT3Z-5-7eRnFt4Um9R+vq2BB+V7DhWngsKrWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
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

Similar to patch #1, this sounds very suspicious and I think you need
to root cause the problem and submit a proper fix instead of just
playing with timings.


> The "backlight_off_to_display_off_delay_ms" was added between
> "backlight off" and "display off"  to prevent "display off" from being
> executed when the backlight is not fully powered off, which may cause
> a white screen. However, we removed this
> "backlight_off_to_display_off_delay_ms" and found that this situation
> did not occur. Therefore, in order to solve the problem mentioned
> above, we removed this delay, and the delay between "display off" and
> "enter sleep" is not defined in the spec, so we reduce it from 120ms
> to 50ms.
>
> In addition, T14 >=3D 120ms, so we change
> "enter_sleep_to_reset_down_delay_ms" from 100ms to 120ms.
>
> The panel spec:
> 1. https://github.com/Vme5o/power-on-off-sequential
>
> Fixes: e4bd1db1c1f7 ("drm/panel: boe-th101mb31ig002: Support for starry-e=
r88577 MIPI-DSI panel")
>
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Similar to patch #1, no blank space between the "Fixes:" tag and the
"Signed-off-by:" tag.


-Doug

