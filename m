Return-Path: <linux-kernel+bounces-427757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EF9E056D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D3428942F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9AB21D5A3;
	Mon,  2 Dec 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V87mOW6I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC49209696
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150042; cv=none; b=ruPwS/6xE19firDfNlNLSh0ANHrWipaDcwtDJrXIS1D7S7rwmX3I45vcul0e5JSBwOJ5tBoxs3rXyWR+P1DC/7KqPz4WSw5NOgDi6NBdCVX40HY6bTt8eN/yAnQwQ+bdvqRM8EKi7+J0nmsonjM5Zl9hPhamMG7pdO4DSZBwyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150042; c=relaxed/simple;
	bh=pPSluDrPZolihQ9FF0FDY4FMT7vtIp8TVNy3EC6ESfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suJD8Jxg9KGmsdFRV3KJuWbdYHjshiG5TKSu5KCT2owThwL9hFlkS0BnEDiGebPF2EACYUZuBafEc4sKTOOIEi12MceYaz9271Ckoeg9Pi1hGr5bX6/SC36QUabVxGhgmS9gfkTi9U6UZDMn/KLPQLjUYWtkvUa9m6NqTTulrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V87mOW6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6Xej+sefl62+HuZJ02rOMvYBMjieqyUp/Rq6GPi75M=;
	b=V87mOW6Il4PA4jmBa4MRvyMBObr7f0EwxpjR1hwGBlMVSix/CtRJG49PArTVW/uYa3upqt
	w99qsjewTTaet0VCvgd1Qm6MibPxA3vFAyC9gbW7ScGfKIcm0JwAzPVK5mrREtvTUDoxHk
	OZeuOUMY6gxKwtvaG79E4+c2U27W684=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-bJb8vHtWPvyEaz724cqm9w-1; Mon, 02 Dec 2024 09:33:58 -0500
X-MC-Unique: bJb8vHtWPvyEaz724cqm9w-1
X-Mimecast-MFC-AGG-ID: bJb8vHtWPvyEaz724cqm9w
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d0d341cc43so1088894a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150037; x=1733754837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Xej+sefl62+HuZJ02rOMvYBMjieqyUp/Rq6GPi75M=;
        b=eUDU4+KUpymFq/i4Idr3ZwkLnvqn0gKHEf3TDQCVEklseirEve5jRKa3L3LhQ6Pw6n
         r8BsNoUiK/jaW08FwUOF1NPDeCWIhZNiUYnpmXIZvkmt1KB1Z/SVLze50Sob2IpVdcM/
         b0Jh1H/g7u73fidO5FHagEo6AnsNoilYaoBTy5jZpO4YfBi+8/RLB2sN52KlGEEoV6uM
         0kMGazRnyzWnJf8bpvn4ZxxhFBnvIkkLfYv2dVEz+lIUANVZBp98fCULeEcxFhdzHz6Y
         F6OQImFficyQaAmbLIq3d3kz3//G4rRzSVEv33nRpIfL41fzqSw/jtokZn0BFEm+C9SW
         7bsw==
X-Forwarded-Encrypted: i=1; AJvYcCUKgz0UREaGC2iS8DeyR/mhEIjuXB3L8lSA7yUEY/qMC/BGfhyKvqlWn8ZQvd/nykkXYtaL1R0M3DTyiFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/H4QN2qz766X/vqGd53bC0FNSpRmtRRBBkbaUEab5BkkYSXW2
	Vf1XtohdlxhQJGEOnSpgiQP7vlUi1en1gTC1lNQYG9Wgyk1r4qMhAlA2WSQ+M4VV+/27JekKtak
	WMoPCgOz/MW1IYqrmhV5uYaqEFdJm2nvgUL7Fclp4isckgWOPVOzWumJKDlmnsQ==
X-Gm-Gg: ASbGncvEzXstzLvN0S7M8ZM1j637Z7xF80/W4H0MkSR67ymY2l6ljVymbUszYvfAOm+
	3fVJ6JoGx4OCgL65r99XOMh+HB5Fl0ofbQtbomkY7+WHc308VaGy+m7FkO4FIq+62za7w//PLX9
	mIgYEAWrj/Vk/LcTb00o3n/DG4yAg2dUUlCAGNktNk4BUSVoJ6/BpXJGxjh6r0pQX6OZwNgI5SG
	333yyDdG4oCTmn2bpr5Ek5VTNaZk76OoLwbHHfme3K87NLLNa1HeQ==
X-Received: by 2002:a17:906:3114:b0:aa5:427e:6af6 with SMTP id a640c23a62f3a-aa580ef3240mr1773025266b.3.1733150036761;
        Mon, 02 Dec 2024 06:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPHol0jCmNI2H8UjxKDJtgKrB4os1/jOlRU53xbQS9RZk2bYe0rO/MZNOZt8QSSYzr7GbqJw==
X-Received: by 2002:a17:906:3114:b0:aa5:427e:6af6 with SMTP id a640c23a62f3a-aa580ef3240mr1773021766b.3.1733150036328;
        Mon, 02 Dec 2024 06:33:56 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953f7esm512624166b.191.2024.12.02.06.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:33:55 -0800 (PST)
Message-ID: <6acfcc52-c547-4823-b8e2-4555ddc64085@redhat.com>
Date: Mon, 2 Dec 2024 15:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] media: uvcvideo: Only save async fh if success
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-1-6658c1fe312b@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241202-uvc-fix-async-v5-1-6658c1fe312b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> Now we keep a reference to the active fh for any call to uvc_ctrl_set,
> regardless if it is an actual set or if it is a just a try or if the
> device refused the operation.
> 
> We should only keep the file handle if the device actually accepted
> applying the operation.
> 
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you, nice patch, better then my original suggestion :)

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll let this sit on the list to give others a chance to reply
and if there are no remarks I'll merge this next Monday.

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4fe26e82e3d1..9a80a7d8e73a 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1811,7 +1811,10 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
>  }
>  
>  static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> -	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
> +				  struct uvc_fh *handle,
> +				  struct uvc_entity *entity,
> +				  int rollback,
> +				  struct uvc_control **err_ctrl)
>  {
>  	struct uvc_control *ctrl;
>  	unsigned int i;
> @@ -1859,6 +1862,10 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>  				*err_ctrl = ctrl;
>  			return ret;
>  		}
> +
> +		if (!rollback && handle &&
> +		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +			ctrl->handle = handle;
>  	}
>  
>  	return 0;
> @@ -1895,8 +1902,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  
>  	/* Find the control. */
>  	list_for_each_entry(entity, &chain->entities, chain) {
> -		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
> -					     &err_ctrl);
> +		ret = uvc_ctrl_commit_entity(chain->dev, handle, entity,
> +					     rollback, &err_ctrl);
>  		if (ret < 0) {
>  			if (ctrls)
>  				ctrls->error_idx =
> @@ -2046,9 +2053,6 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  	mapping->set(mapping, value,
>  		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>  
> -	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -		ctrl->handle = handle;
> -
>  	ctrl->dirty = 1;
>  	ctrl->modified = 1;
>  	return 0;
> @@ -2377,7 +2381,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
>  			ctrl->dirty = 1;
>  		}
>  
> -		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
> +		ret = uvc_ctrl_commit_entity(dev, NULL, entity, 0, NULL);
>  		if (ret < 0)
>  			return ret;
>  	}
> 


