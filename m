Return-Path: <linux-kernel+bounces-541946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D0A4C3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96421885CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7292F53365;
	Mon,  3 Mar 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIy4xSra"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A5204081
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012954; cv=none; b=IyVACtfi8mHlVTeTBdUyb/LsNAjqXMt6wAOmO0oITI81+Za2E4snFZP/N0J5FOwoMP7ksqk0x+0VVtpbkQufpYvor1Fd7wCmlB/SHlNXd82C05zWMDPh/zOF6J7Oz+ffEVdTWsGry24uK7d3zRfm4iGqoZaqrNBoQ5704tioBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012954; c=relaxed/simple;
	bh=ZTyfGZXWIcBxfTMJAaH9bSkoaURGlhqbEorrWHDOuNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpMzzm98jESUc4+T6jpxM68b9J9aoUe1qxKhCTU4r/nERY5ddbTxXIWkKIWbcW9xwl/Mhfj9qQeViiatq1cN8BIrHqrs71ftzyUcb5fAbViTNHdb0KQw6rmefatuRNMsMmCI9EnrTqN4j3/SkJ26STUURSmnoYN4DP47cwbgbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIy4xSra; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741012952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEfF1MW0qkcpRK3ia9ugAr2LLeu9A931qY1MeuqBiiA=;
	b=NIy4xSrabtrGQRzEb54JVU1ACeVzjkDVZ5LbyR8bHYuPENaaIcsg4+DgotvB08mA/mU0Yl
	N5rO1Ss1ohSWaLuONYmFHWCf4m+dSaqJZ0OiVaHMUI0fTK3ifsjf0Zd15LYC3NvrTNRXwY
	sWLLvJ7Gub3ELuqBGqPRtlXI4N610vc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-hjqVtFg6Pn-cr3lNnv500Q-1; Mon, 03 Mar 2025 09:42:26 -0500
X-MC-Unique: hjqVtFg6Pn-cr3lNnv500Q-1
X-Mimecast-MFC-AGG-ID: hjqVtFg6Pn-cr3lNnv500Q_1741012945
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf78df3bbcso119668266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012945; x=1741617745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEfF1MW0qkcpRK3ia9ugAr2LLeu9A931qY1MeuqBiiA=;
        b=qiFlm3UNeCJAVY6Bgb4EeyBZya/0iZngfuZLul8f3jKVNZEYJ9VqEhIheWXUtxKqQw
         qqGLqel8ExQtmAcpbia2gOQYm9f9nXmAoa4jeEfDAd6ESDt3gBQaA1OT7XrsXT20KQ/+
         j+vtx3TNK+Qacqgg5kVf2Hc6Ui/QBV00StGWMzHX2VTv/C3X/gvUjpZ/DTrsXxwkTQpd
         lPyI9wDWnCfwxojnZZKlukFbQgZLZgZDy255JxD1mrqp2iT9tsJi3BfR0tHnXJFnNgtO
         vCuYgeJQLsvPMtYr1WgAjObMC4OUx5MaCjQcq+ng1D8vZpD3k6gvZhdk77k7n9fnkXBj
         3+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWNPiyknE/Vdf4xWWt+ZV6eOXm3/NNMQC2NApJIN7BGeQMB2Oe0nPQeYrAF8vQGbwjx+otWiqGK2CztU4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SkiDVD6hH8meI478qNb3As8Qu3m6yTGHzRgCogddPNK1LbkS
	NaFt5uA5jSNkogMUi+14wS2/zC8Z+IzGyiIKXTaAEp5AOL2QHTfACGIdfooFpvMz2ksWniJ1j9B
	HObhD21xjWvFouFdwdktHrL6Ea2AdKkxHun3y30DxRx7rTKNIFRfuCmoxIRUZbw==
X-Gm-Gg: ASbGncuDdberyIrzlzM7UCgfj5CQUrxuJaLcTM6DqGVIcAZ+8GLLWs1wbo3DmVKmGRV
	VMIVpxDpZTFiUnATAofXm89tZQPCNINw4YMlj2x9RSd5BJZXFDLzb7UQPoA2kUwItgLUnJFjbzS
	d6glD84iGsJPIOFA3Kw+IkpmASkNeVCIYsc81/+kQk/7UxddDEnAxW7EdEUL1L5RqGAj40JqAN6
	Z1ZEGi83b1x6ri+kDE1lmrpS0PDTva/QmwWIfTgnLJ9ECaa2g5Cg8depbu9XgNhfXyDaOeDeemI
	R3QSbV3iEHQUHPjjm3c=
X-Received: by 2002:a05:6402:1d49:b0:5e4:9726:7779 with SMTP id 4fb4d7f45d1cf-5e4d6aca16amr13035761a12.2.1741012944668;
        Mon, 03 Mar 2025 06:42:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3qq/rh3zRJKlvQz3UjeYwOEwrZ3UItCTwtP6Pp9xgjIYkSO4ge+XIYy3c1OhWO9ecYtX1sA==
X-Received: by 2002:a05:6402:1d49:b0:5e4:9726:7779 with SMTP id 4fb4d7f45d1cf-5e4d6aca16amr13035735a12.2.1741012944295;
        Mon, 03 Mar 2025 06:42:24 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm6927183a12.18.2025.03.03.06.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:42:23 -0800 (PST)
Message-ID: <ec2c7bec-2519-4716-8e9e-ff86b41ebb20@redhat.com>
Date: Mon, 3 Mar 2025 15:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] media: uvcvideo: Do not turn on the camera for
 some ioctls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
 <20250226-uvc-granpower-ng-v4-5-3ec9be906048@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250226-uvc-granpower-ng-v4-5-3ec9be906048@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 26-Feb-25 15:23, Ricardo Ribalda wrote:
> There are some ioctls that do not need to turn on the camera. Do not
> call uvc_pm_get in those cases.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 6af93e00b304..de8d26164996 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1450,6 +1450,26 @@ static long uvc_v4l2_video_ioctl2(struct file *file,
>  {
>  	struct uvc_fh *handle = file->private_data;
>  
> +	/* The following IOCTLs do not need to turn on the camera. */
> +	switch (cmd) {
> +	case VIDIOC_CREATE_BUFS:
> +	case VIDIOC_DQBUF:
> +	case VIDIOC_ENUM_FMT:
> +	case VIDIOC_ENUM_FRAMEINTERVALS:
> +	case VIDIOC_ENUM_FRAMESIZES:
> +	case VIDIOC_ENUMINPUT:
> +	case VIDIOC_EXPBUF:
> +	case VIDIOC_G_FMT:
> +	case VIDIOC_G_PARM:
> +	case VIDIOC_G_SELECTION:
> +	case VIDIOC_QBUF:
> +	case VIDIOC_QUERYCAP:
> +	case VIDIOC_REQBUFS:
> +	case VIDIOC_SUBSCRIBE_EVENT:
> +	case VIDIOC_UNSUBSCRIBE_EVENT:
> +		return video_ioctl2(file, cmd, arg);
> +	}
> +
>  	guard(uvc_pm)(handle->stream->dev);
>  
>  	return video_ioctl2(file, cmd, arg);
> 


