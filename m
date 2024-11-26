Return-Path: <linux-kernel+bounces-422679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB689D9CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2878168B69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF81DC046;
	Tue, 26 Nov 2024 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJ+Ey4Wy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E4182BC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643274; cv=none; b=Y8E2ZdfWjOSeYQTMcx4dkvXu1A3Rq15aTrRo0AaxPbTMAzQEfxirz8hFY0t1Di2qOjDW0sr/6MDJuBIKFDTon1OdGB7Li/qerNN9DJhlkJ9SGoa32bcQYKXCa1puiincecFXH55FqoT4fRtBB5/PibHc6GCkSL+XinEL0XMQJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643274; c=relaxed/simple;
	bh=c9FWsB/V5e2yo49k03QPvFAwYgf4cnXWnGY2WByOrGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk+Jo8Z7Av6SIB3HvylAQBMOdB9aJEs4ShJz3HinrcwFvUyWKEBY/XPQ2KYV3sIcQUdkLdSGS23PbwZDtHO6jZwJEkZadaZW3yxA8+Ie2671x6kXI+XLVWEY/eT6kXU7pfCvDQUckUwbldFZn9+KItHzwaX6kUYfjRvsU8mss8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FJ+Ey4Wy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-212a3067b11so50432035ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732643271; x=1733248071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDbvay/L4DqS5s+ZD3GtfsWqS07gNPXpZnhapIvw3WY=;
        b=FJ+Ey4WyqEr5Ax5jka05Zoy3D5evzf2/03wXWeKyEMUsJQIu1i43mNTz/+jrIr1krT
         CzFH+cQzyr5AOHp22S+5V/nFJGcgQfGX+r7qrsaqMKbgwN9E0bMFRuCxFMhZu3qOgVEk
         FBjv+pB8Q/RrV9/Kuo7VFsFkVgXWDK7OuHXW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732643271; x=1733248071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDbvay/L4DqS5s+ZD3GtfsWqS07gNPXpZnhapIvw3WY=;
        b=aRu5tg9kcTplYacKG0LxiN1Kv/fiTEm+836c2t8BAx2ydRvWtkL//tzsZjok7EbMXR
         7pme5LNvkciIcgCVBKQuGyujiCl158YfgmFtfBGS+FeumTEkAm7KGBa7UCVuo/POYh+E
         EWTW5bCeOtdrMzTFIqYckbXd5QmYnYTQFRFC9VZKVK4HYOmC2e1hnOGqy73DaqGcndaw
         Zu3vcQK7Ht1JUEmNoWLtFtou1XsCGJTx4coGf+nl8KTxmUusT5Km6Zl3i0Qm7DwcKbCr
         fe6b4GHbigCG6PeRTbBbRfX3Cru14kFvUI1MB8A/LreRMWektH3Z7pb7BQe9tuWHuIBc
         646w==
X-Forwarded-Encrypted: i=1; AJvYcCX9WmaHzhWV4ZyEs5Cf+p+wpOpw4nSeaJIBra8Objb0YJpg7lnuaiRsvFCqGHvw+ugTk4fVLQwroI6FGWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNH4nF5GTn2rTZYKDubWWohkL6zzwMnEQWqCfnkk6LvE5EPEN6
	y1H1XOVfQJZe7YQ9SW4ZYb6WJW3Qab7y1eK4cq+wAfZndgcMK7GxzpSg/egydGqio8cIDZ7oKEk
	=
X-Gm-Gg: ASbGncvtGlrVGUXo0kxlPdo/Jz4pZgIWLpacEx8Vev4OgYbWK9XRlqZr8knEc2Sv3yQ
	yYEyLzVNxSF8mMxKa9+hCssCBbmM5Zc/MMC8W0YpZsDvgKmu3rPWANPtiE5An78mSdNdfjXZuZo
	fzo81g2sw3FAkAX5oJiIg/JDRg9y6JQ5n4yTPjRHlFBL9ruU1zHeLLbI36+ZiN8AaFVwaLTLisz
	FIVFXHhpkSC5q7p2qw/XyWROyzJS22qT2JksUvYVCf/k8Y1K3dc46675T+/5kjOFlSXYeR9Mzhv
	lpTuWNouTMd7nOIA
X-Google-Smtp-Source: AGHT+IG5+yvgwfV+EkLuBkC+F/JX+EADod+GMnlH4mE2R2U7JGaeqQtaccf7/b3Uq53iTic80S21og==
X-Received: by 2002:a17:902:f64d:b0:20c:ce1f:13bd with SMTP id d9443c01a7336-2150109942emr702065ad.18.1732643271472;
        Tue, 26 Nov 2024 09:47:51 -0800 (PST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db87d54sm87053535ad.39.2024.11.26.09.47.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 09:47:50 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f4325168c8so3322890a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:47:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH0lkTA03yLouYLG5UlhkuJC5IuoEe4xrObm/MpZImykOXxP+IGkr50UmC9p7aiTlXXQc/Jc/4vUiyK7E=@vger.kernel.org
X-Received: by 2002:a05:6a20:2583:b0:1e0:dd4d:1de4 with SMTP id
 adf61e73a8af0-1e0e0b3688emr416514637.23.1732643269919; Tue, 26 Nov 2024
 09:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org> <20240429-fix-cocci-v3-24-3c4865f5a4b0@chromium.org>
In-Reply-To: <20240429-fix-cocci-v3-24-3c4865f5a4b0@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 18:47:38 +0100
X-Gmail-Original-Message-ID: <CANiDSCufyxGARwe1haE6r46B0LZE6tgUV=iG6OyJuY0mr38bvg@mail.gmail.com>
Message-ID: <CANiDSCufyxGARwe1haE6r46B0LZE6tgUV=iG6OyJuY0mr38bvg@mail.gmail.com>
Subject: Re: [PATCH v3 24/26] media: venus: venc: Make the range of
 us_per_frame explicit
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Stanimir :

Ping!
(also for https://patchwork.linuxtv.org/project/linux-media/patch/20240429-fix-cocci-v3-23-3c4865f5a4b0@chromium.org/
)

Thanks!

On Mon, 29 Apr 2024 at 17:05, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Unless the fps is smaller than 0.000232829 fps, this fits in a 32 bit
> number. Make that explicit.
>
> Found with cocci:
> drivers/media/platform/qcom/venus/venc.c:418:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 3ec2fb8d9fab..f87e33a34610 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -393,7 +393,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>         struct venus_inst *inst = to_inst(file);
>         struct v4l2_outputparm *out = &a->parm.output;
>         struct v4l2_fract *timeperframe = &out->timeperframe;
> -       u64 us_per_frame, fps;
> +       u64 us_per_frame;
>
>         if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
>             a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> @@ -414,11 +414,8 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>         if (!us_per_frame)
>                 return -EINVAL;
>
> -       fps = (u64)USEC_PER_SEC;
> -       do_div(fps, us_per_frame);
> -
> +       inst->fps = USEC_PER_SEC / (u32)us_per_frame;
>         inst->timeperframe = *timeperframe;
> -       inst->fps = fps;
>
>         return 0;
>  }
>
> --
> 2.44.0.769.g3c40516874-goog
>


-- 
Ricardo Ribalda

