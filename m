Return-Path: <linux-kernel+bounces-574960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B0A6EC03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E7E189648E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18571DB375;
	Tue, 25 Mar 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzQYtn4C"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE41A5B8B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893021; cv=none; b=GpMYUxw3yGfa4st7i31dNxyfePSQaqNMyoLxYv3X5qrq+gGQnlpufsyYUpMFVs8o1rvuezVEwPX3xDr3KHElLAV9y3P6WpIz/f7zOe9dPkYQhY0RmkKekXieIwxMTkuRiyag+7DGr2yYA3u7uvkgW6yfXu1nXgBMXI34hjKqGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893021; c=relaxed/simple;
	bh=vshuMyCYFLJDvNpL15NUMHq/rID0RlGfkcQcA8Uhlf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5QtAj8ngq/JKpSdPn+rMGQYK+k6Tyvo01k6J+5M9FDlXm3dmQDd2be0RiR4ypvafmOt76liNiwEOzZaARA9potb2S0hYhrVCIXogaA+y9wywDJHK6NyFozTIqiAphifQEi0ywQR9jSJ5ouZxCdE/cG8Zy6x0GAnBpAVwTB/VFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CzQYtn4C; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54954fa61c9so6127201e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742893017; x=1743497817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pekDRC5ZiCfjtVPCurs814x3fMwzvDjR3anDXf5w15E=;
        b=CzQYtn4CUAFPz+Vlgl7EyeMkCq0HY4n25vcD5VrspQUwOctGoYOwllnr5Qc3d4apg/
         Ec08bTvQbc2E/06MJLI7iWrHQq/rhg/R5EgcQqWQy8FKwYs2MCooKBz4RQ3t1SQvqWhk
         TUQ3DZJtqNu9OLpGrxa6IJxtedi3WyjRgqpBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893017; x=1743497817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pekDRC5ZiCfjtVPCurs814x3fMwzvDjR3anDXf5w15E=;
        b=EFEnUYCovTnnN4a54LNK8C3hf5IC+A/Px+KbU7Zu7Fh6t9gy40hFj/+akOlEbbSKtt
         tIaNDKSL/FV7Nmiaz4AwQC3tyf+BnLvMvSy58f6ln+jCq+vuF0ieUhkqNjp8zrr5JXcn
         IaUjIorMGtgB2ddlFDNmSqwg3M0Ybkn2MYSKRFM/P/5QkR/Q03eVuSfMPMrsNvgSskIp
         K6Awru3isWBZhgXbKrUrn/XQBrXqYe+INUcingmWIQZv8rM4m4VhHt7PMrTT6IJ+mlJd
         SlKapUCahOSs0+fBjbR13gGe3uI+F2qkVihilQYgeP82KOnv/SGZNiH/TA70mS3MM/ZK
         2kLA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+wTnQ+Hbrh+cdVtYjh26QdPrDlNzgZn7iv6Xq4CAJ5GXp1Nue4VNEItRhVcyDdqwBJOr6PiUe0HCX4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeZIARY1z5pODyNh9pNktwdHyBF5J34rrbb08zsDKZzXplkVy+
	h1OtTDuN2BWyGUMp3vfqVAoX2hGQ+OQ2GNx3Aacw5o7o5cXxjkKez6t33rAxpQcySADkRi2VQQA
	=
X-Gm-Gg: ASbGncvLhKHeuYVf1lc8sdOKGMlVgmS4klMRSUeLLssVuW330A1Pk77E70hvS2dV+/7
	kJ86pdSQMzNsN5/azBQXpIWPwdlpkW2ktaDRLApqft6Uydv3lt7YZyiWK7T8T8BbsCVw0bM+FdK
	MR1tcHORZqgPp/aSZXgKdrPwThsC0v8CJxUG0qfqk9LK5hPsDGwQvvQ0G4Rk+WzZbaLNn/wdy0i
	/fHBo5eg6ryMfQUxRgYVFH4EuHEMcmzGWaJY2CtxX2iwLXV8MDXHRnijmNrIXDH8jIAVYUDT9gM
	+jDaGvvq1OYM+F1I0muIrsJ0608VnScLwMsMgJdx48abMLwcKFwXhaDydyvPhPkEiEirbf2XThY
	UDXT6W8k=
X-Google-Smtp-Source: AGHT+IETh620lzHTOurRzXKupeZlv8rnH1AU4tDktRYBc+mtlIVN7s1ABzLHtd/BIHqetcQaqdZqGw==
X-Received: by 2002:a05:6512:31c9:b0:545:5a5:b69f with SMTP id 2adb3069b0e04-54ad64799edmr5028347e87.9.1742893017180;
        Tue, 25 Mar 2025 01:56:57 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54adfb11328sm1165635e87.214.2025.03.25.01.56.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 01:56:56 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549b159c84cso5979200e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:56:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUlhz1R4joXIzRLwX/j2URMsezzFZTcID5EDbz4A5FKE+88uViNIb484utftpCHIkTwHvOi+7qSAyaAcw=@vger.kernel.org
X-Received: by 2002:a05:6512:3401:b0:545:56c:36c7 with SMTP id
 2adb3069b0e04-54ad64f58a6mr6508739e87.41.1742893015961; Tue, 25 Mar 2025
 01:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67e26157.0c0a0220.36adcd.506e@mx.google.com>
In-Reply-To: <67e26157.0c0a0220.36adcd.506e@mx.google.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 25 Mar 2025 09:56:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCsvEke31SAgXhs_sXEN7d6fXrwuhJFsi2mzESq1Jc8pxA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp8blAGxVvtPz5mzFh1PiUzr5gC4lO_rNwm9J5fxVQkAwlMwA1GEUsRJ4M
Message-ID: <CANiDSCsvEke31SAgXhs_sXEN7d6fXrwuhJFsi2mzESq1Jc8pxA@mail.gmail.com>
Subject: Re: [PATCH] media: Fix invalid link creation when source entity has 0 pads
To: gshahrouzi@gmail.com
Cc: laurent.pinchart@ideasonboard.com, hdegoede@redhat.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Gabriel

On Tue, 25 Mar 2025 at 08:55, <gshahrouzi@gmail.com> wrote:
>
> >From 307209d175be0145e36b9cf95944e2e62afeab11 Mon Sep 17 00:00:00 2001
> From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> Date: Mon, 24 Mar 2025 19:45:55 -0400
> Subject: [PATCH] media: Fix invalid link creation when source entity has 0
>  pads
>
> This patch addresses the warning triggered in the media_create_pad_link()
> function, specifically related to the check WARN_ON(source_pad >=
> source->num_pads). The fix proposed adds an additional check to ensure that
> source->num_pads is non-zero before proceeding with the
> media_create_pad_link() function.
>
> Reported-by: syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
I cannot reach that URL
> Tested-by: syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com
> Fixes: a3fbc2e6bb05 ("media: mc-entity.c: use WARN_ON, validate link pads")
Shouldn't it be? :
Fixes: 4ffc2d89f38a ("[media] uvcvideo: Register subdevices for each entity")

> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_entity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> index cc68dd24eb42..5397ce76c218 100644
> --- a/drivers/media/usb/uvc/uvc_entity.c
> +++ b/drivers/media/usb/uvc/uvc_entity.c
> @@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
>                 source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
>                        ? (remote->vdev ? &remote->vdev->entity : NULL)
>                        : &remote->subdev.entity;
> -               if (source == NULL)
> +               if (source == NULL || source->num_pads == 0)
Shouldn't source->num_pads be the same as remote->num_pads?

Are you sure that your kernel does not contain?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/media/usb/uvc/uvc_entity.c?id=41ddb251c68ac75c101d3a50a68c4629c9055e4c

Regards!

>                         continue;
>
>                 remote_pad = remote->num_pads - 1;
> --
> 2.43.0
>


-- 
Ricardo Ribalda

