Return-Path: <linux-kernel+bounces-425311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF39DC053
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0D163870
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9915A85E;
	Fri, 29 Nov 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Me7Obeby"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFF155A34
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868134; cv=none; b=gWmdbDc6H1fSyVEfvXdn4sdokaj1C9kQZ37oENKtH5lhhq0staNMiA8N1xG/AAYqjYjzySOCeBb4FVR2cM27MiE4KgefAdgfsi4Z/Nmcxz48kQmA3Vuym8/NgAr0uP0h0Eo4AELYR9wCly2/nbPj5yFXLaPRvT7GeN4Gq7kc9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868134; c=relaxed/simple;
	bh=zuWJY3rAst21OOeQ8E+cKjoOerLMQF9e6A2PZYv9NTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST461t0sAwv3pOTuL+e9hJMrbdLiIEJfM9Tc0MbRLKHVB7o505L79BDArGeMooFkIgAQv5bOest+3owIC1g2lsZx4EI0KABJ0NFlUp4TzL98QoJKnvNNVqooMytrS26TJhx0SmaSQL3KzwASfYmUUu9FgwdVOFF2NUGTVB77T3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Me7Obeby; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee345c1bbdso903719a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732868132; x=1733472932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YQRswOrDPOFPhZSavtHysUlMBUgEPABmZ0IoJAQmEVw=;
        b=Me7Obeby22sB1uUptx5wq+a7jVmCXUp18d+DOzfDt5R65CSDMbfWH4YyvPCU1LJhgv
         metATJ1rees6o4Hz3ap3orN8w1MdKgt/w37a5sIGBFjiPx0fG1ZQYLfBtOzcPCiNtJLw
         opfHVz+NsM1m7Uh53j7jGOOfG1P0SdBuLUZqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732868132; x=1733472932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQRswOrDPOFPhZSavtHysUlMBUgEPABmZ0IoJAQmEVw=;
        b=Z4LAiI7ot2BaAxFSwy0lYT4S3q+ANXBkm4lOxuwjVE0Lqb1iiSJyQVwmdxVFhf7CJ3
         rYWLMsILavn/aTtQHZF0VsZJnxy07FGcrAvR60LE4An1450eRWAtV2dotXf5vcpoUjef
         bX9ZShdESn3K1It272y9uTncpwkjtgYXxHc8ZCbGPl0mgAUkpEcImHo3jawlQBsmh9Ab
         Ku4mTDOZIQGfWmZRXM4KpIT6IjVkW9oZVtizgRqDVQWuGB9aHzG3TKkUpKFJQmvksnEv
         /MRKCiBE1N7z45jQPg/uS81hWZcoKl3/L7zO/9C9Fw87jNB919W2YaqFJNQdSNyIrv6Q
         S73A==
X-Forwarded-Encrypted: i=1; AJvYcCUnxLwfWiZzpofRbA2X8grcFzZ0xejH049G+j2Ul3pJ/AjlAZj5G1Uyh6UIftFIEtwqd4rAI8LI02t3x7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeIYwGIsxF1dUm4a51KeGzsaC6710lr17t/eGLWuz9cPLSFN9
	DCeNT1tV488EDt+/vFM+lQcNDih103BPIaDt3nfQx7V0iDy4ygAE2f2ZdrfRYPDhk0oBMkB/HSs
	=
X-Gm-Gg: ASbGncu3uw8lNyBQnCy2T2vPH+o8wFuZ6F07Pfz2HXPc/zcaLPAwK2c2Y7eDyBDB8iQ
	gtKI7LTF1ZUmNExi2MRe7WrM3I4W1lb3YCBqC8xv/TiwZJiU8e1BKYCIfaGfBNXC9tl/cpGaXfG
	uvp81cfRs/EeA0JGt3vamso1Kjzv8HD5NzPvfZ5R5bGxIvXkQZlVAV+k0ACGCraw8EZEDL4C67D
	Zg78d8DiEwDuefmfselQQZb10VEXlLQ+XARvdnvlKpiFxzvWaOCPzlY4CmsZCR2lOaw+wWho9s9
	+GjVglRL+UgEHPWr
X-Google-Smtp-Source: AGHT+IE/XkIY3ocgQhWIr4ARo49jlngC8PdTwWb/LjkZtD7zNUyN4y+XNmWiZADxHvNZdUgxmH8l4Q==
X-Received: by 2002:a17:90b:548f:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2ee08eb1d5amr12991691a91.10.1732868131762;
        Fri, 29 Nov 2024 00:15:31 -0800 (PST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fad03e7sm4735476a91.42.2024.11.29.00.15.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 00:15:30 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so1488195b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:15:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc9+adimAptJP8ZLkUR5Qm/MylgHk05LOOdkMp9NwBCDMp2hQRjjux5cwyP/P18cz4Uz9HSZibIFT99eU=@vger.kernel.org
X-Received: by 2002:a17:90b:48cf:b0:2ea:65a1:9861 with SMTP id
 98e67ed59e1d1-2ee097e3d02mr13431332a91.37.1732868129872; Fri, 29 Nov 2024
 00:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org> <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 09:15:17 +0100
X-Gmail-Original-Message-ID: <CANiDSCuMJ4ae7AKkMvQygkmBpU0Fgx2eLdwp_vDuV_gQAzgMQQ@mail.gmail.com>
Message-ID: <CANiDSCuMJ4ae7AKkMvQygkmBpU0Fgx2eLdwp_vDuV_gQAzgMQQ@mail.gmail.com>
Subject: Re: [PATCH v15 17/19] media: uvcvideo: Add sanity check to uvc_ioctl_xu_ctrl_map
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 20:11, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Do not process unknown data types.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 5000c74271e0..4c88dab15554 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -106,6 +106,12 @@ static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
>         struct uvc_control_mapping *map;
>         int ret;
>
> +       if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
> +               uvc_dbg(chain->dev, CONTROL,
> +                       "Unsupported UVC data type %u\n", xmap->data_type);
> +               return -ENOTTY;
This should probably be -EINVAL

I am fixing it on the next version

> +       }
> +
>         map = kzalloc(sizeof(*map), GFP_KERNEL);
>         if (map == NULL)
>                 return -ENOMEM;
>
> --
> 2.47.0.338.g60cca15819-goog
>


-- 
Ricardo Ribalda

