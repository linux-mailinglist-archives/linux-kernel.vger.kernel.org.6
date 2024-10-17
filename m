Return-Path: <linux-kernel+bounces-369083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3E49A18BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F138288733
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C2A757EA;
	Thu, 17 Oct 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzMD+kYS"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D99762EF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133081; cv=none; b=cjntLx0D04mo20z8zswd1dCxmy4c+MF+i7L2kFYFyxgmmtQxhXVafle/KUVFs1KL8wqkGIA6muIM+g1Gg3iGf2bpHbak6SMbNDwBrgHAtSkmaSc8WpdSjUj6OUc8AoaPfcPZncYkbrS5mhCHsZodI+CDE9Ugw2D8UDCrZDzkj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133081; c=relaxed/simple;
	bh=vanaCnwTPSViKcU9QA1kqqohhSZlMuJxQuH3CedBEBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEGKo/0vbS/Ip6VJVFS/7ULrVtPSyC5E2a79deS+oPNebpodUMDqLtk+Nt7xBpU+XI1LwgebfeVjteqE57K+gmgHA0TQh7NYp6+Y6gO5HJiJ61mVNsHgEj5BKjGLkSk1/5/l1xlVrWh0YSrgWPc/F5Wqj+8apU3q9BkFwku44ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QzMD+kYS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7180bd5b79dso114356a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729133077; x=1729737877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwYwae4eVmxbO+jRttifpBwyvivJOJJxb/xLoxHTZfo=;
        b=QzMD+kYSj2s1V9OWGKXBzKzM6No87LPwG5oBgQbOIkKqGzuaWKB/n33YdVJc7rrGZI
         TF7lMBZ+3Fw6871Uq/vZ4uj7eHM1rd8dMPUnbe1NFGOv0zkw18iRc6vTbt0NgFijQJad
         XP9CUBFLgWeDHwdjN7FBJ3MLcm1UfkxMXVuPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133077; x=1729737877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwYwae4eVmxbO+jRttifpBwyvivJOJJxb/xLoxHTZfo=;
        b=OZbZX07JDwnaU1MAPP0NIwar8FzrQPxk8KD5BaM5IgAz61pY3SYkflVyr6hm3C84Yo
         MlcaRNjZfcCbXKwpsMkJgN9UJRjfDH5w5QY6Zo3sGWcD1WniV5R4amZ4hIgDHCi72Xwy
         HgvjWcL6NqGBhZTUvkzbQnwToeoUiwisRrON0SP7GHNjfvysqFC9w/fLTKkL+JD3IL81
         P8JOKt4X9qce1KawbZPFLjKcDHp58kYKXQhdhLgOf2Zwcaf6VhTjUuPrYdJ89gZ30CnJ
         pUlBdumKL7OpphictVFCNlToflAgWD8pCbIQYJEyjA1kH0gk7g58hm+hsn9Bqs3mff99
         wOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4LUFeNhdXlr9j8ZyhxaIWuqFStzafNfrddLaywZ0d7cemGybZ+FxaxoKg9l5m0fS8Wsl2sU9w/olcCSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsxormJjsatuJxFdIerR9AXzCMXt3IbHnyBGhqwfyBpvN1QLK
	eWd+nJ8UPt6KSyosgiJWwnoZ4W4LcjRnox67TsIJ2qVeY/+JWcum9XgOMhQ4f+8HY0CRkjVrHEk
	Mqy0RsRc38MW3vr8asamL2CvHwx1vcmUOFOHab35HmmDCBUamyw==
X-Google-Smtp-Source: AGHT+IGjczde+ebuHiDXzv6UCnqtFQA/Z8nWKnV/BFtbt9cOdjCEKrw1EBoPGYwzd69OlvZC94Ly2WvETikDL9e3/rI=
X-Received: by 2002:a05:6830:8008:b0:717:f707:cb92 with SMTP id
 46e09a7af769-717f707ccf7mr6937439a34.28.1729133077325; Wed, 16 Oct 2024
 19:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
 <CAEXTbpfSJJF7W6ga9R5ns5naHgK0r=smCierau5fbLAztkjVwA@mail.gmail.com> <7713a68327a849a5b83f6acd0661bfff@ite.com.tw>
In-Reply-To: <7713a68327a849a5b83f6acd0661bfff@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 16 Oct 2024 22:44:26 -0400
Message-ID: <CAEXTbpf-oyc2UYHmnHp4qLPm7r2D5O0R4Ya4mAnDRSoOt5KGrA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
To: Hermes.Wu@ite.com.tw
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, angelogioacchino.delregno@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Kenneth.Hung@ite.com.tw, Pet.Weng@ite.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2024 at 10:10=E2=80=AFPM <Hermes.Wu@ite.com.tw> wrote:
>
> >
> >
> >-----Original Message-----
> >From: Pin-yen Lin <treapking@chromium.org>
> >Sent: Thursday, October 17, 2024 5:52 AM
> >To: Hermes Wu (=E5=90=B3=E4=BD=B3=E5=AE=8F) <Hermes.Wu@ite.com.tw>
> >Cc: Andrzej Hajda <andrzej.hajda@intel.com>; Neil Armstrong <neil.armstr=
ong@linaro.org>; Robert Foss <rfoss@kernel.org>; Laurent Pinchart <Laurent.=
pinchart@ideasonboard.com>; Jonas Karlman <jonas@kwiboo.se>; Jernej Skrabec=
 <jernej.skrabec@gmail.com>; Maarten Lankhorst <maarten.lankhorst@linux.int=
el.com>; Maxime Ripard <mripard@kernel.org>; Thomas Zimmermann <tzimmermann=
@suse.de>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch=
>; AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>; dr=
i-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Kenneth Hung (=
=E6=B4=AA=E5=AE=B6=E5=80=AB) <Kenneth.Hung@ite.com.tw>; Pet Weng (=E7=BF=81=
=E7=8E=89=E8=8A=AC) <Pet.Weng@ite.com.tw>
> >Subject: Re: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail item=
s and add MCCS support
> >
> >Hi Hermes,
> >
> >On Wed, Oct 16, 2024 at 3:54=E2=80=AFAM Hermes Wu via B4 Relay <devnull+=
Hermes.wu.ite.com.tw@kernel.org> wrote:
> >>
> >> This is a v6 patch-set.
> >>
> >> There are lots of failure items while running HDCP CTS using UNIGRAF D=
PR-100.
> >> In Order to fix those failures, HDCP flow needs to be changed.
> >>
> >> The DisplayPort AUX protocol supports I2C transport.
> >> In Order to support MCCS via the aux channel, the aux-i2c operation is=
 added.
> >>
> >> v5->v6:
> >>         -keep the commit message wrapped at 72-75 chars.
> >>         -[10/10] fix return variable being used without being
> >> initialized
> >>
> >> v4->v5:
> >>         -add more messages for changes.
> >>         -[2/10] modified AUX transfer data size judgment.
> >>                 change for-loop to do-while.
> >>         -[7/10] change for-loop to do-while.
> >>         -[9/10] change wait timer with timer_after()
> >>
> >>         links:
> >>         https://urldefense.com/v3/__https://lore.kernel.org/all/202409=
26074755.22176-4-Hermes.Wu@ite.com.tw/__;!!HtnLE8A!H06km5WNa8VgoR25MvWuNAGY=
uJGScCXQx0tQwni_NPHKwOqT4hNpaCrFZPPMVKeqBXXHTRoGj1C2pZazumE8vA$
> >>
> >> https://urldefense.com/v3/__https://lore.kernel.org/all/20240926075134
> >> .22394-1-Hermes.Wu@ite.com.tw/__;!!HtnLE8A!H06km5WNa8VgoR25MvWuNAGYuJG
> >> ScCXQx0tQwni_NPHKwOqT4hNpaCrFZPPMVKeqBXXHTRoGj1C2pZb7YFr4mw$
> >>
> >> v3->v4:
> >>         -split changes  into patches.
> >>
> >> v2->v3:
> >>         -split aux read  KSV function to a patch.
> >>         -[1/3] new in v3
> >>         -[2/3] add description of patch
> >>
> >> v1->v2:
> >>         - ignored.
> >>
> >> Hermes Wu (10):
> >>   drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
> >>   drm/bridge: it6505: improve AUX operation for edid read
> >>   drm/bridge: it6505: add AUX operation for HDCP KSV list read
> >>   drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
> >>   drm/bridge: it6505: fix HDCP Bstatus check
> >>   drm/bridge: it6505: fix HDCP encryption when R0 ready
> >>   drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
> >>   drm/bridge: it6505: fix HDCP CTS compare V matching
> >>   drm/bridge: it6505: fix HDCP CTS KSV list wait timer
> >>   drm/bridge: it6505: add I2C functionality on AUX
> >>
> >> Change-Id: Iad0c056d72abf2655081357cf40c3b0d3df916b5
> >> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> >> ---
> >> Hermes Wu (10):
> >>       drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
> >>       drm/bridge: it6505: improve AUX operation for edid read
> >>       drm/bridge: it6505: add AUX operation for HDCP KSV list read
> >>       drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
> >>       drm/bridge: it6505: fix HDCP Bstatus check
> >>       drm/bridge: it6505: fix HDCP encryption when R0 ready
> >>       drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-=
100.
> >>       drm/bridge: it6505: fix HDCP CTS compare V matching
> >>       drm/bridge: it6505: fix HDCP CTS KSV list wait timer
> >>       drm/bridge: it6505: add I2C functionality on AUX
> >>
> >>  drivers/gpu/drm/bridge/ite-it6505.c | 334
> >> ++++++++++++++++++++++++++++++------
> >>  1 file changed, 277 insertions(+), 57 deletions(-)
> >> ---
> >> base-commit: b8128f7815ff135f0333c1b46dcdf1543c41b860
> >> change-id: 20241015-upstream-v6-9f4b015fecf7
> >>
> >> Best regards,
> >> --
> >> Hermes Wu <Hermes.wu@ite.com.tw>
> >>
> >>
> >
> >I'm not sure if this requires a re-spin, but you are supposed to collect=
 the reviewed-by tags you received when you send out a new version. i.e., p=
ut the "Reviewed-by:" lines you received before your "Signed-off-by:" line.
>
> only cover-letter or all patches? need "RESEND" for same v6 patch header?

You should add the review tags to the individual patches that have not
changed since the previous review. For this series, I think you can
wait a few days and collect feedbacks from the community first.
>
> >Regards,
> >Pin-yen
>
>
>
> BR,
> Hermes

Pin-yen

