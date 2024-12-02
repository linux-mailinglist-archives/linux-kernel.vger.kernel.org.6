Return-Path: <linux-kernel+bounces-427482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7759E01E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9137628402E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C020966A;
	Mon,  2 Dec 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erUebo8G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744721FF616
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141434; cv=none; b=WRlABH4+1qSqIvos0QyKMO8raBeoEomvaTkfTq8Ein+9fq8ml8LDnWOL1r4nMhqVcbJ8+7Uc1Xa3PsuSaaz9sZ0bNC7xp1V2w/WmZH2UkLH+6HDo5/TQc9/6A3c72Ku2klPo+3kZlXxaZlYiVlmFv3mEadJXeyqZzLy81FLbYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141434; c=relaxed/simple;
	bh=W93w2iskkN4COyZsUX+DkNlu0dj+0ORm4iFu8L4bXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSIXi/N9IQ/84HevwE8LjNQsB9i5mT7rBnwogqefwaK0EWK+xW9hAaO5EOmyKQaxvsC7y8CrSS0HqSKb6PPwWv/JRLz3qmntq14hzdIbDtjFjbEyKpSjnrj0nEl2qbaOC6MCJRgFnhPfaZhpzHe0jUWJTbOWSw6wZh3pEw5qVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erUebo8G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733141431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6qY7PVOq5h194UrFoW4aw9ArzfwrvJdPz/Jk2VRoAs=;
	b=erUebo8GqEw7YuMZuMMRp76WzpIUqD0lxRU1hFNX7nXjVEIQq0OI5xNZQ5YEM9bpYVuGLi
	VjfhHBAI7GZ7ngsS59febEnK2t4f3VLdEYN51cOeEQ4hjog/ia4cgCKx+KBrEzRQPSl2se
	oVba/iI7JR3Vjh6farMMh6N+BATnwSY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-x5CbcIQwMOedSq0CPzAEwQ-1; Mon, 02 Dec 2024 07:10:30 -0500
X-MC-Unique: x5CbcIQwMOedSq0CPzAEwQ-1
X-Mimecast-MFC-AGG-ID: x5CbcIQwMOedSq0CPzAEwQ
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53dd88b5b2fso2503211e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141429; x=1733746229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6qY7PVOq5h194UrFoW4aw9ArzfwrvJdPz/Jk2VRoAs=;
        b=gMpf9Ug9cjyAN5z2E8kyQY/v3l+5kQFAqQUdwtLCs7U/TQH9l/JRYOYOQaeVzKVkYZ
         LyeMxThINYTft7TqVWshXdfJsIRIoW8mm7y3jK576w/uCzG7m9HMNyB7Bu4TBeJbqdWc
         0xkUfswOTDtH1mNTBThEeA+ajdevhtAWr02d5emIxrimgPjpcFtV0uqFSxkJcqffLNKJ
         DVSeux6EsKf5K9z2U3fgRCgSU/OOZ3B5uq2DpNF6l+Xys5sYjmkuSxlWwforVoQa/+TK
         2Ep+Y+m4UtrTTa0DtbqwAl0q4MhbNz8PHYe49OrosFxAfDvAdtY5wNZtkGOphe+AKjlc
         bp1w==
X-Forwarded-Encrypted: i=1; AJvYcCX4Nhzq7Ftqq8vXpsCJoUM9+yoIGGURiGXMLnkxGQ3i0703W3BBsasbXOKu9z6MjI40Lzm383Pk2IrXjyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGj/xq0Ody+WQlSxlJvVpWdk3dr9uShGTGUNly/Q40MKweyga
	fv2u1lUapILWhHi9DZI7hunWRlYO4qvc75rqMUlWIK4IrS61NiQtpI8IxUcyg7VKgfAfDmtLHw/
	PMxNP4GqAlqk38ergVFIEmRJH5nppxSigzQnK3qFkvDcrc4+23UPKRNab6g7kQw==
X-Gm-Gg: ASbGncsgzniIW+pimrwVOjq/5t9Z0mleu0wixjG5v1UBfT+tQR4lG08I3pfmlJoBm0/
	0Z1jowfZoy+YyHHWysWF1M7vj0LPnJzj2YdA49Emgpw4Ou49gvU1XawLpw8GVgfLLm1ZoB5A+ax
	WYdWWXlBvy8V+tjuD5QynJZKANNIzNNgSScXlGdGZ8LvG2G0Me/qG9AObB9gKTGTq98dJjP+Ivr
	ZkxYNqJKI89DVzEzv9YiF8OrJ2fOBsxiO0fqDYUjKdn8SWw9XztKA==
X-Received: by 2002:a05:6512:39d2:b0:53d:ec9a:138f with SMTP id 2adb3069b0e04-53df0112687mr12242480e87.57.1733141428821;
        Mon, 02 Dec 2024 04:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8J8fjQi9JqmWpQBpvyAF2nP+kOTR9hNLINjX5y9jxd1A2CsOXHqU2sieZeV5EqjZWpXw19A==
X-Received: by 2002:a05:6512:39d2:b0:53d:ec9a:138f with SMTP id 2adb3069b0e04-53df0112687mr12242446e87.57.1733141428422;
        Mon, 02 Dec 2024 04:10:28 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c0e3csm501899166b.12.2024.12.02.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 04:10:27 -0800 (PST)
Message-ID: <42d06183-107e-4945-b83c-72be857c2067@redhat.com>
Date: Mon, 2 Dec 2024 13:10:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] media: uvcvideo: Implement Granular Power Saving
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, stable@vger.kernel.org
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 26-Nov-24 5:18 PM, Ricardo Ribalda wrote:
> Right now we power-up the device when a user open() the device and we
> power it off when the last user close() the first video node.
> 
> This behaviour affects the power consumption of the device is multiple
> use cases, such as:
> - Polling the privacy gpio
> - udev probing the device
> 
> This patchset introduces a more granular power saving behaviour where
> the camera is only awaken when needed. It is compatible with
> asynchronous controls.
> 
> While developing this patchset, two bugs were found. The patchset has
> been developed so these fixes can be taken independently.

Thank you for your patch series. For now lets focus on fixing the
async-controls ctrl->handle setting / dangling ptr issue and then
we can look into the rest of this later (after we have also landed
the privacy GPIO and UVC 1.5 ROi series).

Regards,

Hans




> ---
> Ricardo Ribalda (9):
>       media: uvcvideo: Do not set an async control owned by other fh
>       media: uvcvideo: Remove dangling pointers
>       media: uvcvideo: Keep streaming state in the file handle
>       media: uvcvideo: Move usb_autopm_(get|put)_interface to status_get
>       media: uvcvideo: Add a uvc_status guard
>       media: uvcvideo: Increase/decrease the PM counter per IOCTL
>       media: uvcvideo: Make power management granular
>       media: uvcvideo: Do not turn on the camera for some ioctls
>       media: uvcvideo: Remove duplicated cap/out code
> 
>  drivers/media/usb/uvc/uvc_ctrl.c   |  52 +++++++++-
>  drivers/media/usb/uvc/uvc_status.c |  38 +++++++-
>  drivers/media/usb/uvc/uvc_v4l2.c   | 190 +++++++++++++++----------------------
>  drivers/media/usb/uvc/uvcvideo.h   |   6 ++
>  4 files changed, 166 insertions(+), 120 deletions(-)
> ---
> base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
> change-id: 20241126-uvc-granpower-ng-069185a6d474
> 
> Best regards,


