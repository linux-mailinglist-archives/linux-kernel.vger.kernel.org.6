Return-Path: <linux-kernel+bounces-368810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D59A1528
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B898281EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E261D3633;
	Wed, 16 Oct 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gXQS21vQ"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C81D278B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115543; cv=none; b=J5mCpeybou9o+A6yvmsqHZCD99oehlJEJWyu9DkSI/DAftda5+3Thc/Sfaxl+kqtOhAl9wobDPjX9jAm/h7BfB5StLWxYvqH35v5A6O2SOmIzKmNTJJi7Sdu4KJkGwGBp51DwFNL5fG3V0jDIoq1Pn9J1cwlumsixpSQfAWl14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115543; c=relaxed/simple;
	bh=Y3muvgVmJCqAAU17DG/5wUwI8+9xq+M0EWweOsJUB+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5eOzbHaW8NH+hWQmusc1vf8Gno2SEI7bHcwMGcSSHHnrjNszih877Q/73oYthlZvMJM0lYgjUZ6chXN1SAsCHHWR115Y1p2N6CE0FISjCulzv+5MKfpBHEYPqz3hSghqrhcIdW0E4lKrerYm/K9dShRRJ1lgQHEsv66eC7E9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gXQS21vQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718065d6364so145189a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729115541; x=1729720341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5DTUB5GnpyaeFBfW4aLHPqs9cBt4Whkge9o9U0fQHI=;
        b=gXQS21vQxIRExt1imIMIKMmo2Qxb/LsOcWSRfFqE9w+7sIezaSUj2vDl8ysae5t9sa
         PthGnF8/fLavEHkmDroO+Vr+IMSOJ8S9ymFvmy9q8HNxXVh73Hpl+FTk4BXEohKb/v+T
         rsjnvOzHjEdK7JDRv7BtX8vdjt7lnsmfE9Wus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115541; x=1729720341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5DTUB5GnpyaeFBfW4aLHPqs9cBt4Whkge9o9U0fQHI=;
        b=DUxXVzIRXh+nyA6/WACEzcuQjBiCq38z3ln3MK56HnY9JRlpQ1YQjMwivlgqxVABfG
         FdC2usa5gI2P46TOzjk8jFsM2Qpeimpgf58kFxFZmHDs4bxwvDlcS/g+dWWviZq40X3c
         vvxT84bo4sChDzk9rudh0XfoWJm76BZSTUxO0Udi29zK9th3Be9UvBvZY0uGLjcUitBV
         yGiLoGuuaoCrEuNQaFzj5rHL1Open4WT7OssjKjF3SFTncMOJYYsU+J/AOaDMonptq6/
         R8xz/spqBsm4+pCB/yl3l0mof4cdRfD+HY0gL0n9h3prw72TRlQLji04nH2DJFKqnRms
         N+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUByEjTz+NAtdCjssMzvk6pZEyqOZEPAZoZH+0ao0/9ARtyAtti9kSQB/rwRty9X8hrRCKFNpawMIdudIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFDGfXUgJAdApi9MpVO3lIde26bKVPQXfbj6ApmnhtQlx/2Q4
	PeZPEEHpR4+foQLPjFAy/KqXbBjje4354/vvWrigu90D4eu0K44iZ3rzzZz4MzOZWoQyNJIt9wn
	93rT/GjLNjAGszO4qI5feehiV9Vac0/OJhjd2
X-Google-Smtp-Source: AGHT+IE7RS2K0RmzSXETL5iGnY3q7rCF1rjKdi3zRgyFiH16uN5b1c6ruvNbCcnCiAsBXO8EUw8a76+9j/5br4+3Y6E=
X-Received: by 2002:a05:6830:6013:b0:718:678:56e6 with SMTP id
 46e09a7af769-718067858a3mr3325173a34.3.1729115540911; Wed, 16 Oct 2024
 14:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
In-Reply-To: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 16 Oct 2024 17:52:10 -0400
Message-ID: <CAEXTbpfSJJF7W6ga9R5ns5naHgK0r=smCierau5fbLAztkjVwA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Pet Weng <Pet.Weng@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hermes,

On Wed, Oct 16, 2024 at 3:54=E2=80=AFAM Hermes Wu via B4 Relay
<devnull+Hermes.wu.ite.com.tw@kernel.org> wrote:
>
> This is a v6 patch-set.
>
> There are lots of failure items while running HDCP CTS using UNIGRAF DPR-=
100.
> In Order to fix those failures, HDCP flow needs to be changed.
>
> The DisplayPort AUX protocol supports I2C transport.
> In Order to support MCCS via the aux channel, the aux-i2c operation is ad=
ded.
>
> v5->v6:
>         -keep the commit message wrapped at 72-75 chars.
>         -[10/10] fix return variable being used without being initialized
>
> v4->v5:
>         -add more messages for changes.
>         -[2/10] modified AUX transfer data size judgment.
>                 change for-loop to do-while.
>         -[7/10] change for-loop to do-while.
>         -[9/10] change wait timer with timer_after()
>
>         links:
>         https://lore.kernel.org/all/20240926074755.22176-4-Hermes.Wu@ite.=
com.tw/
>         https://lore.kernel.org/all/20240926075134.22394-1-Hermes.Wu@ite.=
com.tw/
>
> v3->v4:
>         -split changes  into patches.
>
> v2->v3:
>         -split aux read  KSV function to a patch.
>         -[1/3] new in v3
>         -[2/3] add description of patch
>
> v1->v2:
>         - ignored.
>
> Hermes Wu (10):
>   drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
>   drm/bridge: it6505: improve AUX operation for edid read
>   drm/bridge: it6505: add AUX operation for HDCP KSV list read
>   drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
>   drm/bridge: it6505: fix HDCP Bstatus check
>   drm/bridge: it6505: fix HDCP encryption when R0 ready
>   drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
>   drm/bridge: it6505: fix HDCP CTS compare V matching
>   drm/bridge: it6505: fix HDCP CTS KSV list wait timer
>   drm/bridge: it6505: add I2C functionality on AUX
>
> Change-Id: Iad0c056d72abf2655081357cf40c3b0d3df916b5
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
> Hermes Wu (10):
>       drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
>       drm/bridge: it6505: improve AUX operation for edid read
>       drm/bridge: it6505: add AUX operation for HDCP KSV list read
>       drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
>       drm/bridge: it6505: fix HDCP Bstatus check
>       drm/bridge: it6505: fix HDCP encryption when R0 ready
>       drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100=
.
>       drm/bridge: it6505: fix HDCP CTS compare V matching
>       drm/bridge: it6505: fix HDCP CTS KSV list wait timer
>       drm/bridge: it6505: add I2C functionality on AUX
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 334 ++++++++++++++++++++++++++++++=
------
>  1 file changed, 277 insertions(+), 57 deletions(-)
> ---
> base-commit: b8128f7815ff135f0333c1b46dcdf1543c41b860
> change-id: 20241015-upstream-v6-9f4b015fecf7
>
> Best regards,
> --
> Hermes Wu <Hermes.wu@ite.com.tw>
>
>

I'm not sure if this requires a re-spin, but you are supposed to
collect the reviewed-by tags you received when you send out a new
version. i.e., put the "Reviewed-by:" lines you received before your
"Signed-off-by:" line.

Regards,
Pin-yen

