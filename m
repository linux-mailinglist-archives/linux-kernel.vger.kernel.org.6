Return-Path: <linux-kernel+bounces-394308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01C9BAD35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBECB20D03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAF199948;
	Mon,  4 Nov 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9cyV0c9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750ED188583
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705684; cv=none; b=FlK+c+/OjXYtsSg97p9NvdnzgCnv41/Sa93YgyWAFXSdIz4wuZQjuNN5An0Ox882xH7mdnkfysvLcwHIozdZ70laaJ0RWZ/EXbisDJcGsb113Kqen9DbKl2vAFpJcp9ELQrCaCw3qak0uy1D6ZcjOgpB8v9XRbaN7TlROxgZYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705684; c=relaxed/simple;
	bh=V+dFhb/xUsIk3i8EI2tPY/v+wCP2kY9EIWEvkHTzqZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jb55WKs+Na+6ZZ8LNWNiXkoxlR7TfU9iAjchQ3ZzJZtXozUjiEMHetgFMfCno0B8DPIRT/CcQXHr/TxXXs9BqPTKc/kC1KHvM/G4+bplHRprDdM9dtHdKiONh7adbUylI6cnYZKiYcEcvC+jzngHVUbNNdQYLwzJ92PklGBfSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A9cyV0c9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c70abba48so32982895ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730705681; x=1731310481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1QHYjc5SD6CUTx4Y+pHWVkv+2RRn9R+p/OjFKFK/uI=;
        b=A9cyV0c9j3OH/cxevrZXwQ8GF2rqbcKrt8oIDjj678jXjcNSve0kAsONEAnUVJEB6T
         PN4ZGym3/sCicugGcSd7pWmDRFDDpJ4P368a5N6eJfxdd1D0qW3uL5j7iIZl24udggCv
         hhRu7EBnIJF67aNb1Z5TjyX36zurIM604X8YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730705681; x=1731310481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1QHYjc5SD6CUTx4Y+pHWVkv+2RRn9R+p/OjFKFK/uI=;
        b=GSHpB4VFIFZKLD8U6RI1Blkbd9/CkxBpMoVzHBzgZg85FLP2MUFYFbnAwsjwfrt75q
         57JM1sPqP0A8rjF9FqpzoaZ/oubYy/DIpcBheNnEt2noN3PPSMNbzexd6Efh244ApZB8
         qQK6Nk/bnECz6GAlVZicYiD1ElIYepUoDHhp+PN8MnBSl7LQ0jVOPDBH45KJY1IaZ2Ed
         qN36jYgi4y8ot7GaETS5vZjx1ev0bObOTSKQFCE7Sf+hYrQA80BKMjGbBLtKgOOd/1Ou
         iDFh4b9HOgDv4DOmPYYxXzJtpt+gqKzB9OlbFDObrGobZo0aB+VhHD9mHZ9uQeOryb0T
         qlFw==
X-Forwarded-Encrypted: i=1; AJvYcCUDA/3V9VrmVWqhcbi+fVFnkP6E0zmsSQAsJC0YISmgsE4rTMoGs2ZIqjp8CCkZ3r9pzfDfx/4+3u7Ty8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+Mc9BdtbSTBETRIK5i1Y11h3E7hjJlLQIOVzNooCIxq0thAP
	QYy+/VHrtZBnBjERHyXjqvU68e83SvKoLZ2pKvhvXA79hExDqCD0lvmvTo7DBlkKSaA1u9qlEBw
	=
X-Google-Smtp-Source: AGHT+IFNPR7qwcF2/jj4qeuMhUjT2k1XQFkvXQbSmr2twEQEW2ATufdVo8TnAs1628SQzc8IOpCVYA==
X-Received: by 2002:a17:902:f641:b0:20e:71ee:568e with SMTP id d9443c01a7336-2111af2f09amr166288165ad.13.1730705680911;
        Sun, 03 Nov 2024 23:34:40 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c49sm55491915ad.253.2024.11.03.23.34.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 23:34:40 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so1942443a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 23:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6YXK+2tdaSrOfp5YvLePd7EbTeHLV7ughZixpnJBNQtkLpifzE3dqHAQ/hUO1Z8TFYrtW82MC+4XRnHA=@vger.kernel.org
X-Received: by 2002:a05:6a20:a11d:b0:1db:e9d8:be4f with SMTP id
 adf61e73a8af0-1dbe9d8bf4amr87587637.29.1730705679311; Sun, 03 Nov 2024
 23:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104020959.637736-1-ccc194101@163.com>
In-Reply-To: <20241104020959.637736-1-ccc194101@163.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 4 Nov 2024 08:34:26 +0100
X-Gmail-Original-Message-ID: <CANiDSCtRswXbGn6WBftgCaxavX5Z9OddTc5PTAmr2FVuoGPmeQ@mail.gmail.com>
Message-ID: <CANiDSCtRswXbGn6WBftgCaxavX5Z9OddTc5PTAmr2FVuoGPmeQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo:Create input device for all uvc devices
 with status endpoints.
To: chenchangcheng <ccc194101@163.com>
Cc: laurent.pinchart@ideasonboard.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi


On Mon, 4 Nov 2024 at 03:10, chenchangcheng <ccc194101@163.com> wrote:
>
> Some applications need to check if there is an input device on the camera
> before proceeding to the next step. When there is no input device,
> the application will report an error.

Out of curiosity, what app are you having issues with?

> Create input device for all uvc devices with status endpoints.
> and only when bTriggerSupport and bTriggerUsage are one are
> allowed to report camera button.
>
> Fixes: 3bc22dc66a4f (media: uvcvideo: Only create input devs if hw supports it)
> Signed-off-by: chenchangcheng <ccc194101@163.com>
> ---
>  drivers/media/usb/uvc/uvc_status.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index a78a88c710e2..177640c6a813 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -44,9 +44,6 @@ static int uvc_input_init(struct uvc_device *dev)
>         struct input_dev *input;
>         int ret;
>
> -       if (!uvc_input_has_button(dev))
> -               return 0;
> -
>         input = input_allocate_device();
>         if (input == NULL)
>                 return -ENOMEM;
> @@ -110,10 +107,12 @@ static void uvc_event_streaming(struct uvc_device *dev,
>                 if (len <= offsetof(struct uvc_status, streaming))
>                         return;
>
> -               uvc_dbg(dev, STATUS, "Button (intf %u) %s len %d\n",
> -                       status->bOriginator,
> -                       status->streaming.button ? "pressed" : "released", len);
> -               uvc_input_report_key(dev, KEY_CAMERA, status->streaming.button);
> +               if (uvc_input_has_button(dev)) {
If there is no button, do you ever reach this point of the code?
> +                       uvc_dbg(dev, STATUS, "Button (intf %u) %s len %d\n",
> +                               status->bOriginator,
> +                               status->streaming.button ? "pressed" : "released", len);
> +                       uvc_input_report_key(dev, KEY_CAMERA, status->streaming.button);
> +               }
>         } else {
>                 uvc_dbg(dev, STATUS, "Stream %u error event %02x len %d\n",
>                         status->bOriginator, status->bEvent, len);
> --
> 2.25.1
>
>


-- 
Ricardo Ribalda

