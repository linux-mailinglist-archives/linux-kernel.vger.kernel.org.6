Return-Path: <linux-kernel+bounces-427517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF29E0235
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF8F28304C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E201FF5F9;
	Mon,  2 Dec 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnpOSNUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A21FC0FC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142576; cv=none; b=ozbx/n+A2sp/6R5dAvrHtMCuWb6SHFSbes2AB4UmMa2QGY4/3lSOA1EP0ypr9aBw9497rBBvkkxrhVpX2p98Vg3FbdrHBIEDJGSFp5lTWQgitKqlOYSzsDuvgR5ScOVCi9lT+OR/CvyUuqL14ZwBxSno/uiEqR1ovTF90UO+NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142576; c=relaxed/simple;
	bh=aNiRtLbOimTkWCo2rlAD0jQGj9rz6eMaM3ZI18vJbMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjGafPC/DqAzqEFYKflt4EyFD23wM9ePxfrGIwehbOFusP2BkanWflGLfccVeARtEdZlDiYBsCUFN0E0kOkfoSimbqUUyyQd8Kh3CVeK+YIdY1iSyDUSCqdOyOm9JhDaWBmsQrEV7v2Wuu73jlPj+mOl6ubl5pj2Y80SWvCsa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnpOSNUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733142573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8oQajwWGK2SYHd+94BnqtL/H4hap/syqF+etOfzB6k=;
	b=AnpOSNUy6LNxb/isZPraHB2/NqorKx9Jquo8WAHtydIbxIjFwE9wYEq4Cx9zf8ygypWcKa
	4R8FzH6bEowD+3yrQAQY5MnQBBUdFH48d6DU/PlAa9JkQPGqA4EJN2K5q2YUdZuwSfB7gX
	MkGJ6kVlYBkp5MXvsNm+3VBys/rXXqE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-zShq_ITmN0Okv6lBWPi58g-1; Mon, 02 Dec 2024 07:29:32 -0500
X-MC-Unique: zShq_ITmN0Okv6lBWPi58g-1
X-Mimecast-MFC-AGG-ID: zShq_ITmN0Okv6lBWPi58g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa53d22f651so257143866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142571; x=1733747371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8oQajwWGK2SYHd+94BnqtL/H4hap/syqF+etOfzB6k=;
        b=srN6yinaQtJrur0wZEn1NHKF40G7/igu97Fuu3PU7HZoymbigeCWmb5m1DF8zm3kSf
         LoBfZZz3FcdXJGN/t3/vo97UQ30ILzXqjmaZ5UQJlYvXB6dvLmR7U7zXAerBb49Qp8B7
         sHruttsrCftOOFh6DKh27oLwcFYpddlxX/OTfibEdYwvymM8vVjgth+9gBS1rDmtYHjQ
         29S0/IUNGP7p+lW/nPuyT/hWI9vM0XGWz/lszvmGMUy0mUXxAySXvckz4+LnjyWxjucn
         D73O2aG+BG4mqDGVKByuFjjMt5ImzeHKwRVRDlNuq/kUvcauMkesBvdfNIEG8fYWzb8L
         G2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhnySb5pcQ/v99HAyExGwtyrBJ9wgHrZ172IHl4s/LiL8kq2iSYAauNtOoZAlJg9HtQhk2GQlgIX+4M5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlgbh3MdqBnBh94Se48gRzuHDjQeRb6q1WdvWyz2TPvceX8Iw3
	Us0j7OduxJsZW9kOsI0hv4O8P/uI+gSlzmHUFFOIiJBYaT1w3B9CsvjjhluT2FuwLRI4AMhWjNH
	AJBiNOjOBW1ASxnHRKHoq6orO5K+LTK9S1zyR4CmdCXcvAGCOQ4Hc7av39JX2WQ==
X-Gm-Gg: ASbGnctX1K8EYvBbPG2CLw0KaoUYFaBKHIFcfdDjm+VkGAq/HMGM4TsUXGu4febUqLp
	qCGpmFv0mhDHNAdVoLjQhwSlxw5LRKDufgpiAZH5dntkOJ9IHkN4tTTvcrTooJ1X7CZtCgwLHf4
	W/hm3qJj4s3x/LYO0uEwYslB2p0oU3/kf0Yb+GpsvL82SbxAp3JeVEDu9WVZvsP58Kt8cVKw9Mv
	tEHVwQruRUPytX5gMX1Q7TLCK73B1yIOYo7Qznwoi1Nl7JIngyUMQ==
X-Received: by 2002:a17:906:318c:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-aa580ef0e02mr1922320366b.3.1733142570723;
        Mon, 02 Dec 2024 04:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSFIk8p9vy3zMXG9JnW6z6GRYhLTcuhYCujduAfv14X6b3tuHYI6lnj/f7QICv4Gb+Pk8CEg==
X-Received: by 2002:a17:906:318c:b0:a99:7bc0:bca9 with SMTP id a640c23a62f3a-aa580ef0e02mr1922318666b.3.1733142570355;
        Mon, 02 Dec 2024 04:29:30 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6dd9sm504136066b.92.2024.12.02.04.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 04:29:29 -0800 (PST)
Message-ID: <bb195fae-1794-4936-8874-3233a28dfe51@redhat.com>
Date: Mon, 2 Dec 2024 13:29:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: uvcvideo: Remove duplicated cap/out code
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241129-uvc-dup-cap-out-v2-1-596cb9bdd5e8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241129-uvc-dup-cap-out-v2-1-596cb9bdd5e8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 29-Nov-24 8:28 PM, Ricardo Ribalda wrote:
> The *_vid_cap and *_vid_out helpers seem to be identical:
> - Remove all the cap/out duplicated code.
> - Remove s/g_parm helpers
> - Reorder uvc_ioctl_ops
> 
> And now that we are at it, fix a comment for uvc_acquire_privileges()
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Unless I miss something, cap and out helpers are identical. So there is
> no need to duplicate code
> ---
> Changes in v2:
> - Add missing acquire_privileges.
> - Also remove helper for s/g_parm.
> - Reorder callbacks.
> - Link to v1: https://lore.kernel.org/r/20241127-uvc-dup-cap-out-v1-1-1bdcad2dabb0@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 162 +++++++++++----------------------------
>  1 file changed, 43 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 97c5407f6603..42f0f8a89865 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -26,6 +26,8 @@
>  
>  #include "uvcvideo.h"
>  
> +static int uvc_acquire_privileges(struct uvc_fh *handle);
> +
>  static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
>  				      struct uvc_control_mapping *map,
>  				      const struct uvc_xu_control_mapping *xmap)
> @@ -361,9 +363,11 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
>  	return ret;
>  }
>  
> -static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> -	struct v4l2_format *fmt)
> +static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> +			   struct v4l2_format *fmt)
>  {
> +	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
>  	const struct uvc_format *format;
>  	const struct uvc_frame *frame;
>  	int ret = 0;
> @@ -395,14 +399,20 @@ static int uvc_v4l2_get_format(struct uvc_streaming *stream,
>  	return ret;
>  }
>  
> -static int uvc_v4l2_set_format(struct uvc_streaming *stream,
> -	struct v4l2_format *fmt)
> +static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> +			   struct v4l2_format *fmt)
>  {
> +	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct uvc_streaming_control probe;
>  	const struct uvc_format *format;
>  	const struct uvc_frame *frame;
>  	int ret;
>  
> +	ret = uvc_acquire_privileges(handle);
> +	if (ret)
> +		return ret;
> +

The original code used "if (ret < 0)" here and so does this patch in
uvc_ioctl_s_parm() below.

Please change this to "if (ret < 0)" for consistency.

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



>  	if (fmt->type != stream->type)
>  		return -EINVAL;
>  
> @@ -426,10 +436,12 @@ static int uvc_v4l2_set_format(struct uvc_streaming *stream,
>  	return ret;
>  }
>  
> -static int uvc_v4l2_get_streamparm(struct uvc_streaming *stream,
> -		struct v4l2_streamparm *parm)
> +static int uvc_ioctl_g_parm(struct file *file, void *fh,
> +			    struct v4l2_streamparm *parm)
>  {
>  	u32 numerator, denominator;
> +	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
>  
>  	if (parm->type != stream->type)
>  		return -EINVAL;
> @@ -461,9 +473,11 @@ static int uvc_v4l2_get_streamparm(struct uvc_streaming *stream,
>  	return 0;
>  }
>  
> -static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
> -		struct v4l2_streamparm *parm)
> +static int uvc_ioctl_s_parm(struct file *file, void *fh,
> +			    struct v4l2_streamparm *parm)
>  {
> +	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
>  	struct uvc_streaming_control probe;
>  	struct v4l2_fract timeperframe;
>  	const struct uvc_format *format;
> @@ -472,6 +486,10 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>  	unsigned int i;
>  	int ret;
>  
> +	ret = uvc_acquire_privileges(handle);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (parm->type != stream->type)
>  		return -EINVAL;
>  
> @@ -573,6 +591,7 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
>   * - VIDIOC_S_INPUT
>   * - VIDIOC_S_PARM
>   * - VIDIOC_S_FMT
> + * - VIDIOC_CREATE_BUFS
>   * - VIDIOC_REQBUFS
>   */
>  static int uvc_acquire_privileges(struct uvc_fh *handle)
> @@ -685,11 +704,13 @@ static int uvc_ioctl_querycap(struct file *file, void *fh,
>  	return 0;
>  }
>  
> -static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> +static int uvc_ioctl_enum_fmt(struct file *file, void *fh,
>  			      struct v4l2_fmtdesc *fmt)
>  {
> -	const struct uvc_format *format;
> +	struct uvc_fh *handle = fh;
> +	struct uvc_streaming *stream = handle->stream;
>  	enum v4l2_buf_type type = fmt->type;
> +	const struct uvc_format *format;
>  	u32 index = fmt->index;
>  
>  	if (fmt->type != stream->type || fmt->index >= stream->nformats)
> @@ -707,82 +728,8 @@ static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
>  	return 0;
>  }
>  
> -static int uvc_ioctl_enum_fmt_vid_cap(struct file *file, void *fh,
> -				      struct v4l2_fmtdesc *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -
> -	return uvc_ioctl_enum_fmt(stream, fmt);
> -}
> -
> -static int uvc_ioctl_enum_fmt_vid_out(struct file *file, void *fh,
> -				      struct v4l2_fmtdesc *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -
> -	return uvc_ioctl_enum_fmt(stream, fmt);
> -}
> -
> -static int uvc_ioctl_g_fmt_vid_cap(struct file *file, void *fh,
> -				   struct v4l2_format *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -
> -	return uvc_v4l2_get_format(stream, fmt);
> -}
> -
> -static int uvc_ioctl_g_fmt_vid_out(struct file *file, void *fh,
> -				   struct v4l2_format *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -
> -	return uvc_v4l2_get_format(stream, fmt);
> -}
> -
> -static int uvc_ioctl_s_fmt_vid_cap(struct file *file, void *fh,
> -				   struct v4l2_format *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -	int ret;
> -
> -	ret = uvc_acquire_privileges(handle);
> -	if (ret < 0)
> -		return ret;
> -
> -	return uvc_v4l2_set_format(stream, fmt);
> -}
> -
> -static int uvc_ioctl_s_fmt_vid_out(struct file *file, void *fh,
> -				   struct v4l2_format *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -	int ret;
> -
> -	ret = uvc_acquire_privileges(handle);
> -	if (ret < 0)
> -		return ret;
> -
> -	return uvc_v4l2_set_format(stream, fmt);
> -}
> -
> -static int uvc_ioctl_try_fmt_vid_cap(struct file *file, void *fh,
> -				     struct v4l2_format *fmt)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -	struct uvc_streaming_control probe;
> -
> -	return uvc_v4l2_try_format(stream, fmt, &probe, NULL, NULL);
> -}
> -
> -static int uvc_ioctl_try_fmt_vid_out(struct file *file, void *fh,
> -				     struct v4l2_format *fmt)
> +static int uvc_ioctl_try_fmt(struct file *file, void *fh,
> +			     struct v4l2_format *fmt)
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_streaming *stream = handle->stream;
> @@ -1212,29 +1159,6 @@ static int uvc_ioctl_g_selection(struct file *file, void *fh,
>  	return 0;
>  }
>  
> -static int uvc_ioctl_g_parm(struct file *file, void *fh,
> -			    struct v4l2_streamparm *parm)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -
> -	return uvc_v4l2_get_streamparm(stream, parm);
> -}
> -
> -static int uvc_ioctl_s_parm(struct file *file, void *fh,
> -			    struct v4l2_streamparm *parm)
> -{
> -	struct uvc_fh *handle = fh;
> -	struct uvc_streaming *stream = handle->stream;
> -	int ret;
> -
> -	ret = uvc_acquire_privileges(handle);
> -	if (ret < 0)
> -		return ret;
> -
> -	return uvc_v4l2_set_streamparm(stream, parm);
> -}
> -
>  static int uvc_ioctl_enum_framesizes(struct file *file, void *fh,
>  				     struct v4l2_frmsizeenum *fsize)
>  {
> @@ -1543,15 +1467,17 @@ static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
>  #endif
>  
>  const struct v4l2_ioctl_ops uvc_ioctl_ops = {
> +	.vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt,
> +	.vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt,
> +	.vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt,
> +	.vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt,
> +	.vidioc_g_parm = uvc_ioctl_g_parm,
> +	.vidioc_s_parm = uvc_ioctl_s_parm,
>  	.vidioc_querycap = uvc_ioctl_querycap,
> -	.vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt_vid_cap,
> -	.vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt_vid_out,
> -	.vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt_vid_cap,
> -	.vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt_vid_out,
> -	.vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt_vid_cap,
> -	.vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt_vid_out,
> -	.vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt_vid_cap,
> -	.vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt_vid_out,
> +	.vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt,
> +	.vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt,
> +	.vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt,
> +	.vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt,
>  	.vidioc_reqbufs = uvc_ioctl_reqbufs,
>  	.vidioc_querybuf = uvc_ioctl_querybuf,
>  	.vidioc_qbuf = uvc_ioctl_qbuf,
> @@ -1570,8 +1496,6 @@ const struct v4l2_ioctl_ops uvc_ioctl_ops = {
>  	.vidioc_try_ext_ctrls = uvc_ioctl_try_ext_ctrls,
>  	.vidioc_querymenu = uvc_ioctl_querymenu,
>  	.vidioc_g_selection = uvc_ioctl_g_selection,
> -	.vidioc_g_parm = uvc_ioctl_g_parm,
> -	.vidioc_s_parm = uvc_ioctl_s_parm,
>  	.vidioc_enum_framesizes = uvc_ioctl_enum_framesizes,
>  	.vidioc_enum_frameintervals = uvc_ioctl_enum_frameintervals,
>  	.vidioc_subscribe_event = uvc_ioctl_subscribe_event,
> 
> ---
> base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
> change-id: 20241127-uvc-dup-cap-out-6a03c01e30a3
> 
> Best regards,


