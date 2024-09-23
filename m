Return-Path: <linux-kernel+bounces-335623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3897E834
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359E7B21615
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C1194120;
	Mon, 23 Sep 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EQzkkGdz"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27924AEDA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082503; cv=none; b=Ej9EFluLfz5wXEy1ZAPyCpScGyxJeqWvmuaHW9m24V0YSXj6GVoSIimxrmgC7mZzV9mI7UGnPCL01G5tyciuHrjx6syKqbZbBlIV/zVUGFw6bkL89iLfBhC9wNkikXZx9BIg0+Ipf28PSI+tkn7LfpIya/xgTIHpCw/1YrIeUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082503; c=relaxed/simple;
	bh=HPlA+B04ZRzeplKMW1vzpCM4N9lRQ38Hiyk6YoLnAIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjgUGwdHdpsJzMpmSOYtcK3b/ysAl3ZXbyJEKoRipTC08zbD0ZsQOdfpjG0UVUCDOvgiKbJcBcNcfyCkyCc/HiiTWCcVxF/gPn3cqr2FG+atDQrOw9P4q5U+wMf0eU+nw8slrdVtdM+//M/UoVh+AnXiGAEGI0y+hV+rS/z3+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EQzkkGdz; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-501269674daso1119216e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727082500; x=1727687300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0Ef2pUJCIL3aYIls9LM/0/HuZV6sRLvGWfXRnJJRsg=;
        b=EQzkkGdz6iDUm2WkOKO8GafqAEHc1P6MWWAqmYShArgTLf8qtjX8nu8XdafmmzRWvb
         it0pMFjWCLWEMgHsC6aqYlav91uSpFkbSDHnz+aNaDQGzYPNNPTVKR0DGr2UY+aLWeGW
         uLoAwDZN4QUlF1dY1kcZZ5vHoK28R3OPXJgkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082500; x=1727687300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0Ef2pUJCIL3aYIls9LM/0/HuZV6sRLvGWfXRnJJRsg=;
        b=H4RdqoBM0cKWmrfwtp/D76dI6aNJQ7Pb4RePTLBRSFheYgS+qKkOAJSkT2G3riCsD6
         f/gyN04mBLxy4wfPS7EKVlOuXN6R1/Vb1AfQm7y5NHNbU3f3mMmwu+PQSA7/FytpRpe9
         TBBTYyIsuQx4TwyLpa8W2Myu3ciZqGQteQ6fFIle0f95VDyLD2FEuL0I7Y9MJAF8BMDk
         RLFH4chw3WuImc/GLnvADa91RGirTkshIZx3XHdtbZo9shLsasN9JNLG320pSnu2g61j
         YILv4vsaXiOHFAk0w3FfFzF0YcyA2+JS0+qw6EkBMR+vNJnxgU0TAXxEzJ8jXhawspXu
         9bfA==
X-Forwarded-Encrypted: i=1; AJvYcCXZFBErdUTkdllWgTOlN6ljpkjKflpGy32eWPsvSICiepNmyd0sJTY4eg0ZG7hJmVTjNvIFTVdtKjs3ebc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vSqPCKpelB5lOmqzZotPWqgU8MEkDkjOH75HRxnpSwgOBKHN
	4yZW7iSMBcKmGzTRseYo3hPXHRhyOgua+QXCI64CdUtiQVPDSa3z8orAABk2Jbf6KmZHfRpp0Eg
	=
X-Google-Smtp-Source: AGHT+IE7a188NsdGtVoTiRKz9d/r0gm4sW3zoBCsimVZztdOSgodrKTaZMj51XZfmLcWNennkw92PA==
X-Received: by 2002:a05:6122:134b:b0:503:9cbc:772f with SMTP id 71dfb90a1353d-503e0286c90mr6149433e0c.0.1727082500109;
        Mon, 23 Sep 2024 02:08:20 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035bc6b837sm2629334e0c.49.2024.09.23.02.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:08:18 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-846c0a741cbso924546241.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:08:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXr0dOvJ4dC5faGS1vThvROlkELEojhrr71ZWmLiaBD7ffRm5XvOJlbmCTtUSOmtzrkS/whocP2cgk27i0=@vger.kernel.org
X-Received: by 2002:a05:6102:5088:b0:49b:a93d:3d0 with SMTP id
 ada2fe7eead31-49fc7511684mr6579342137.1.1727082497908; Mon, 23 Sep 2024
 02:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831055328.22482-1-zhi.mao@mediatek.com>
In-Reply-To: <20240831055328.22482-1-zhi.mao@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 23 Sep 2024 17:07:40 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh76iKhMV4roBe4mLTrq-eHqz-3-fYWzNcWAETvj-JETA@mail.gmail.com>
Message-ID: <CAC=S1nh76iKhMV4roBe4mLTrq-eHqz-3-fYWzNcWAETvj-JETA@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: improve suspend/resume switch performance for
 GT9769 VCM driver
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, shengnan.wang@mediatek.com, 
	yaya.chang@mediatek.com, teddy.chen@mediatek.com, yunkec@chromium.org, 
	10572168@qq.com, ot_xiaofeiw.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhi,

On Sat, Aug 31, 2024 at 1:54=E2=80=AFPM Zhi Mao <zhi.mao@mediatek.com> wrot=
e:

Suggestion for the new patch title:
  media: i2c: dw9768: Use runtime PM autosuspend

to better describe "what" this patch does to the DW9768 driver, not "why".
Also there's nothing to do with GT9769 in this patch.

>
> Chromebook camera AP can switch between video and photo mode,
> the behavior corresponding to VCM is suspend and resume,
> it will cause camera preview is not smooth during switching operation.
> We use autosuspend function can fix this issue.
>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/media/i2c/dw9768.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/dw9768.c b/drivers/media/i2c/dw9768.c
> index 18ef2b35c9aa..7449d29df901 100644
> --- a/drivers/media/i2c/dw9768.c
> +++ b/drivers/media/i2c/dw9768.c
> @@ -374,7 +374,7 @@ static int dw9768_open(struct v4l2_subdev *sd, struct=
 v4l2_subdev_fh *fh)
>
>  static int dw9768_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *f=
h)
>  {
> -       pm_runtime_put(sd->dev);

Call pm_runtime_mark_last_busy() to update the power.last_busy field
for autosuspend to work properly.

> +       pm_runtime_put_sync_autosuspend(sd->dev);

Use pm_runtime_put_autosuspend().
Don't switch to the synchronized variant without reasons.

>
>         return 0;
>  }
> @@ -490,6 +490,7 @@ static int dw9768_probe(struct i2c_client *client)
>                 goto err_power_off;
>         }
>
> +       pm_runtime_use_autosuspend(dev);

Add pm_runtime_set_autosuspend_delay() before calling
pm_runtime_use_autosuspend() to avoid rapid power state bouncing.

Regards,
Fei



>         pm_runtime_idle(dev);
>
>         return 0;
> --
> 2.46.0
>
>

