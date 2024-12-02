Return-Path: <linux-kernel+bounces-427773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57019E0678
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3787016B8C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71520898B;
	Mon,  2 Dec 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwdwMYU3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02784208983
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150695; cv=none; b=ZNTxZep9TLbHp6SwQ3Yf9LCShCO2lLD7ElnDNknO1orWW8IC2UpMbppGJwHCxVffZX+9VhCaFDfcbNVpp011JRyosV4IRO783Emlz07/dF3w+GLzKd1RIxI2YX8v5GusHYII/gElw1G282xTNKJqLLbJYIFWc0ixiIuna2pZBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150695; c=relaxed/simple;
	bh=P6WMno8wkJc6FpiCbZ3RKjUDqJawl4a3n5Y+JpdjnQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxiDiQDX++BxZugY1suoz/+DvQpPhrgJBJSRzn79uTzx2T0Vqjsw3ZbgPaIwzSYjDjtZjN/qzOz26N5s5A7VJJpqFntr0pEaITmZRbtZGAsP2HOxaocU3Ca6has0WM3qqZHlqcvlxJYHJJtLWlT3Ht7DdkEZ2ECSQkq6rz/2FKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwdwMYU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYLdp2sXBF6M9dc560NKGF40r2p0eqAZE6J+ajfFVJ8=;
	b=iwdwMYU3xSfNvaVzmhmhZFCM8vBd3lppgfpKbpEun0WpLyb6Ebnsoz2KUjuwAGKdUKLTVp
	fZVY1BA7Wimuacje7Q99jlssF4Acpp/cvTOo6bxX9pF3qmjzaiB26vSnRoC0Z1Osm1UIyQ
	7vpoZBeVykV54rzcse3H735e7/+hDNQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vBS88R_3N6SIejlxN5LtQA-1; Mon, 02 Dec 2024 09:44:50 -0500
X-MC-Unique: vBS88R_3N6SIejlxN5LtQA-1
X-Mimecast-MFC-AGG-ID: vBS88R_3N6SIejlxN5LtQA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d0ae45646eso3334436a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150690; x=1733755490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYLdp2sXBF6M9dc560NKGF40r2p0eqAZE6J+ajfFVJ8=;
        b=LjecII/FBPitkNfwMQXvYSdJMo77d6fZvC1W71FC3MDGfIZoCFoxaH/IrGAhaSmE4/
         BUAVOO8cDzTOca8xvyl9veWl0akIhyUyYO8SLeoszlJ2CVezBtq7BGmzUZoVJu4fbdaD
         ZxVGZyHuw1gLrG99UmlleAX1q70LWH1zXb3Z1dJEeVs+y6GRGcWceejsEIq2sgB81YqP
         A7RfrbEPbNmF2er3yffDuxVna1HvJkf3XndB/50g3wm6hAkDNoVgVUXaZxC+k6B21n+Q
         zHYJ0nlUFDqDmpEtURtY319bmtHk0YE2BZch9RRFblDcY6Vy+PmNeO9b5bWvKIXCHYrS
         54rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZK71L33Z+zqLEnYBNA7BSbbKMVofn/Tb6QApO+Mhlk+HeOh5CxiKvOGSDk1t24mKOAwxgvBXXYvtk5TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNy0sY3iS73kDzF6UI3OVg37fhPQqULJS74x4w111czAJmoS3
	hphJEq/M0/sPeojC9j58cRaJfh74ZztDc+yvg3SE2KInyYM+IHZZb+CYnrOH288VBvRGGvVmePN
	2/JW5x9gJA0NH1LB2QB7vUy6zuH4WdPmUuuDd86R6gZVGCWb6vLuG1g/WCnrbtw==
X-Gm-Gg: ASbGncsvTfWuvyZ441dFBbTzpS3su64XehTyIIT7IYOfkf6IpyWRzkObPhVYv5EeQVt
	AI2Dp03ByrVbwCQh5sfv/A8btinp7Hd3sGGog++MjNMu+jiMIpu6827XPLNIaip3b3Kre8IQd1r
	GNciiVDKLeCPBqXVX+jMLDkanDmxYNT4WtOzQuuQHyAKqvfMn/WhyDmRYRBn9zTWc6bTGsrX9vT
	tvDm5c4rfVMm3tSzJpy0wTxE9ZIC9CuEFV6Y/ucvyeUdONahE9taA==
X-Received: by 2002:a05:6402:35d5:b0:5d0:b51c:8483 with SMTP id 4fb4d7f45d1cf-5d0b51c8732mr13566951a12.16.1733150686626;
        Mon, 02 Dec 2024 06:44:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgjSPpPOWOYT+FbBn1eUx9lLaAIfbqlbSYEUIqBPBGycl8xuUlXajgumOG7/U9Szq5WSRwow==
X-Received: by 2002:a05:6402:35d5:b0:5d0:b51c:8483 with SMTP id 4fb4d7f45d1cf-5d0b51c8732mr13566786a12.16.1733150684566;
        Mon, 02 Dec 2024 06:44:44 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b8aeeaf7sm3798271a12.30.2024.12.02.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:44:43 -0800 (PST)
Message-ID: <34084caa-13a4-40c3-aa81-ba17513add45@redhat.com>
Date: Mon, 2 Dec 2024 15:44:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-3-6658c1fe312b@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241202-uvc-fix-async-v5-3-6658c1fe312b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> Make it explicit that the function is always called with ctrl_mutex
> being held.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index af1e38f5c6e9..576e3854be91 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1980,6 +1980,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  	s32 max;
>  	int ret;
>  
> +	lockdep_assert_held(&chain->ctrl_mutex);
> +
>  	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
>  		return -EACCES;
>  
> 


