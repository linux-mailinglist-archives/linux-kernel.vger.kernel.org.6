Return-Path: <linux-kernel+bounces-427778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FDD9E0596
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0964E28B153
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF420CCF1;
	Mon,  2 Dec 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yw4Ai/Iv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BC20899C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150764; cv=none; b=S1+dBx6HdSBtKFzlfo6zhEB7P7llbf5pB0mRg6zQiPYbi/jGOb6cL3T0t7Klcl77XSEx0YcHKrkRRp4i4gETaNl4qk5yM6QCavloJlIa46OTx8Yx9upB5UXiDdO3Lc2q+GrEnj+oP5DpRgzJmsCq5xi8aX1IrDYadhkZ6s9sYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150764; c=relaxed/simple;
	bh=XEG1RcerCs7zfuWQTNGzh5BC5VO3k1qcRF/ckT5aKsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmExi6FmChIhNxSnp7JKQvP8b84QCrR7PmSoIRgzAEic/zlLeakAe46ahUEVJrUbT71h39X5LAwRIEiMfCHnw+HZSvkaHpikY4H//5I78T2MAYY3oHL+6Jjhqiq40cM4Q9/7mRWBuaeYzu09Okl2EcVGN0V9510L3bBO7QiDZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yw4Ai/Iv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/n54QHe1NzMvOrCOYdJyhQRev16QpKhheU+kQiQcBU=;
	b=Yw4Ai/IvWwVRqRX+NxzENVg1UvEaSTLh+KZoVyL04hpYU/P7En6D4dAAs7fIyHAzhu8yVH
	mEtdSbtGsRtUHRYoFae7XAg7UhssDq/9JC0y94BGH+p1WtM9Jwm1+J+RgGrgT5slGXVOYH
	JLnUwc5BidPJRjawgUS2QnCyaNonGdE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-kQor_MqqNJW5b9Ydg2IjYQ-1; Mon, 02 Dec 2024 09:46:00 -0500
X-MC-Unique: kQor_MqqNJW5b9Ydg2IjYQ-1
X-Mimecast-MFC-AGG-ID: kQor_MqqNJW5b9Ydg2IjYQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa53f3b322eso438252066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150759; x=1733755559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/n54QHe1NzMvOrCOYdJyhQRev16QpKhheU+kQiQcBU=;
        b=C3c0goFc+7i33ovEywQ8P3Wvo3R0/cZf1nAuONUM1tWWiOFAfi1y0lrX706OmIBJaz
         ySMB3yPKqJGTeXJZ0CJMLZZ3LwNIFElf1RDVJ955p1XDteH1qwaiOpEfH4Y8WLH8PfVv
         IfgTc57OtUmWhSc6H1sJIDu+an6I4bxid6XTXOLBAJv+XF75xID5gDru+EuC8+3kd8Xw
         Tpu3Q+xqafrlzPaKeJQ/r6om+NDO5eQkMHxhBvifBTA1SrLc+eop/oAtfZIzLeFDCcPD
         rql+EZZymDs0iulW+0vBTEbmkziW301xe1UZSocbtx555tE8hCIK5rNEtxmFHNicmFaC
         CbMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Qhn5wK/HEqjDZ2OBZacR6bu+fxv+8RawB81LSH5WSsHzjOfM1XWy45X5Lh33vc6reO3cxLFlF85Ar7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59SPj/kS57nujImgGaDwcAsJzuTu0P5E4/zCAOIe8rrmt41r1
	ZWpGWZ7waD1ldbsip3ZCpheOhrnMWOgqr+BhQ26OV8Mkt3qZqU8iY+EcnlKm/n/u/Oo3ruDM3Yj
	KAQ7Oc/7m4Dwh3VKmp/gHO3bIPCsl+i82FeMskHT7gGyGjfpH0CGswCY4uTYtjg==
X-Gm-Gg: ASbGncsl6i6vXJjXpAnt75aY8Fi38UyUdtxfvxDTG+Ltd6OmftX0/1lPV1jGa+n0KFK
	KBwjHe8mTV/eNqNl5y49jk1F+ik5UZOznmQAdYKnnN2OHObd3UHYoaR9675ZcOjZcKW6I+MZ8vh
	YoIpI69fiqf1Cjs/DxW+QT2hO5ni8KftNONbVW15jG/dIm2qc+BHw03KSrBmG1LBI2Ec1zCvc07
	RBFNHMMDadd3a0RJmv4rrW/C+LwfsSOToq5dtU0qF9i/mqYTIMlvg==
X-Received: by 2002:a17:906:3188:b0:aa5:1cdf:7bfd with SMTP id a640c23a62f3a-aa5945058bbmr2041914066b.7.1733150758898;
        Mon, 02 Dec 2024 06:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8HqwPhXUO9252fmA3AzlzqGEYvuYGwKNOG5zyj1I7gJ6jPWtLqvor8xH6GhcSZADZyL1TlA==
X-Received: by 2002:a17:906:3188:b0:aa5:1cdf:7bfd with SMTP id a640c23a62f3a-aa5945058bbmr2041908566b.7.1733150758467;
        Mon, 02 Dec 2024 06:45:58 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a777sm515948666b.154.2024.12.02.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:45:57 -0800 (PST)
Message-ID: <67f78128-dcc0-4253-a6f7-5905ca375b06@redhat.com>
Date: Mon, 2 Dec 2024 15:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] media: uvcvideo: Flush the control cache when we
 get an event
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-5-6658c1fe312b@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241202-uvc-fix-async-v5-5-6658c1fe312b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> Asynchronous controls trigger an event when they have completed their
> operation.
> 
> This can make that the control cached value does not match the value in
> the device.
> 
> Let's flush the cache to be on the safe side.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index e90bf2aeb5e4..75d534072f50 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1672,6 +1672,9 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
>  	struct uvc_device *dev = chain->dev;
>  	struct uvc_ctrl_work *w = &dev->async_ctrl;
>  
> +	/* Flush the control cache, the data might have changed. */
> +	ctrl->loaded = 0;
> +
>  	if (list_empty(&ctrl->info.mappings))
>  		return false;
>  
>


Thank you for the patch.

I'm not familiar enough with UVC yet to really have an opinion on this one,
so I'll defer reviewing this one to Laurent.

Regards,

Hans




