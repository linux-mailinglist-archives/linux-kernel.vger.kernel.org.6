Return-Path: <linux-kernel+bounces-541869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08501A4C2B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD5D3A6F58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21E2135BB;
	Mon,  3 Mar 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXo6ZpCB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAE1F4183
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010577; cv=none; b=MEh6MiuYjDiWWXDTF/LYcJ9ejcme+K686FNIG591nMeYZwHtGYfqudEJV4jd7dO7Cp/FwvGQVt3E4rlLHbyuq8d3cdJN+EO7em7IkNu8u+EQh4gC/FvBsMdhqXr6eHVm5uOf0SNFbf9E8QVmfC9/oHHCQRdFmRVdtPFGe2upF4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010577; c=relaxed/simple;
	bh=8bsnmvfAjGVIH7jOIPIvwYWB4Jv48r1mXeOXEvLWalA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIkzx1/KZpy5RKP5y/Xz3FsVYTukESaMWgg6bW1fZzd8oa1+n1Y/hm6AMlmZQIe1/MKk/DL6szaL1QtcSnVVCwZKER7Tt2SIwnhk1h1PdjtSFACebiMIBCWXIt+emE2HGMQUQHa3SsCKWCXV2R4C6Z1igFlrM+ImklnQBbnnE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXo6ZpCB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741010574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJf4/zflZHu3IQNiMQ3lCM++w7NvTFqB4KzbfcfdNWc=;
	b=eXo6ZpCBdM4wTCNjto6X6xqZ6s7GlLmHcHgtaibm23n0rrJnVRsvOcnIW0cWb4FqpJvQoL
	pmZqEPXEW0nNlFzNDrV2CX4xoBoINJLQUQqdQtx7iX7+DlD2VVTfjY9lfD5UQDdtUm/IXk
	ef+DSgHSI5YbP9oilFv31yvAksDxI7E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-CnpfCvq3MsSyvw0Ms34RgA-1; Mon, 03 Mar 2025 09:02:52 -0500
X-MC-Unique: CnpfCvq3MsSyvw0Ms34RgA-1
X-Mimecast-MFC-AGG-ID: CnpfCvq3MsSyvw0Ms34RgA_1741010572
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so4711761a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010572; x=1741615372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJf4/zflZHu3IQNiMQ3lCM++w7NvTFqB4KzbfcfdNWc=;
        b=c7sibV2kNaLhJxxCvKrs9YAZ3NFlIPRXohNhEGBydyT3/IiG/7+Kf6gMlOU3D98+Cn
         NHwBImRg4fP27c8d+HvtBLw/aPeKc9w+JcOqaXslgS75Vw77vY2xbyCCFceBnbFpMFjc
         DFiPk0raKu0j5Ui3tjwHW4qilZCXzqHGpBytymSTM+WIbHmedJs502wNPJTEUs2+sX7S
         bRJwVUBKcD6w0Bka1WkmFhgj5px12OP2o6rHZHrg1L+Ey5Vmf7UGj+toXBYbBMMmZjl2
         nxmqQMOfnLIfZnv3XSD/MV/bi4V5EDV3BbXWUKVleTpXhfMDfbMQlUq5c+QmPFbVC0pC
         wzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYoKzV1Uv8kQRbG9kiJ/DJfdx59CfOxi172ApwoJSPNDCa9CuB4Q1Z1zyfaAZOpp062Im4aZ7UyPh0XiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP2xL0FCeRjAULGu4ED9FfFoiP0UmNYTothGYLcz8zm773Qn/
	50K35AbttX+aVW5QyW0tSkdLuoGX5jEF2dAn7bQPK2vn1Zb8ow7FdGNUnnBvMAHhsSbdJ9D1Oxa
	Z4hhx0GGOfBdqdirMypRVrmN+13FgHO1GJ0fyFVkb6NdUWjxkojBUBBnSituBzw==
X-Gm-Gg: ASbGncsHD2DNdpW6dEgvlMn1a3tWCCL1v8CQasUCjntNGDYG0IddYOUEia06FMNj6R0
	bx4c7JjqNoy2r6qRAUTGjyn8h8K/RCec6vgeK/DQoGN+4UYpJEi7VNzxPabJT49Su8mtmQ8oTge
	JoYQ1yCF5byLIjmoVEj5cKHA+9ZV6SDlSGexGmxAgE0owdErE7LKkEyGNI8sdzJptG/QLZJC4DA
	tAwhS4WTAFqHCphOnczefsZupOyOlIuvVn3tmKSy7LAllELdS1ZPOmLjYH9dBIrfmwzdVzDd8NE
	IKShHTj5uAsZoSrU5bU=
X-Received: by 2002:a50:cc0c:0:b0:5e4:d75a:573e with SMTP id 4fb4d7f45d1cf-5e4d75a57fcmr11163820a12.32.1741010571399;
        Mon, 03 Mar 2025 06:02:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZex1kQMieQKb+N4I4vdhl4budP4Re7r9POsYiHbgSvRvwVYw9B/430caOfAXmTSRcCnWdow==
X-Received: by 2002:a50:cc0c:0:b0:5e4:d75a:573e with SMTP id 4fb4d7f45d1cf-5e4d75a57fcmr11163779a12.32.1741010570844;
        Mon, 03 Mar 2025 06:02:50 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa13sm6798255a12.7.2025.03.03.06.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:02:50 -0800 (PST)
Message-ID: <5d229e8e-f4b9-4589-a978-e80848678e38@redhat.com>
Date: Mon, 3 Mar 2025 15:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 16/17] media: uvcvideo: implement UVC v1.5 ROI
To: Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda
 <ribalda@chromium.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
References: <20250203-uvc-roi-v17-0-5900a9fed613@chromium.org>
 <20250203-uvc-roi-v17-16-5900a9fed613@chromium.org>
 <6944a221-b0b4-4042-9d4a-98a0cc806116@xs4all.nl>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6944a221-b0b4-4042-9d4a-98a0cc806116@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3-Mar-25 14:32, Hans Verkuil wrote:
> Hans, Laurent, Yunke,
> 
> On 03/02/2025 12:55, Ricardo Ribalda wrote:
>> From: Yunke Cao <yunkec@google.com>
>>
>> Implement support for ROI as described in UVC 1.5:
>> 4.2.2.1.20 Digital Region of Interest (ROI) Control
>>
>> ROI control is implemented using V4L2 control API as
>> two UVC-specific controls:
>> V4L2_CID_UVC_REGION_OF_INTEREST_RECT and
>> V4L2_CID_UVC_REGION_OF_INTEREST_AUTO.
>>
>> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
>> Signed-off-by: Yunke Cao <yunkec@google.com>
>> Reviewed-by: Yunke Cao <yunkec@google.com>
>> Tested-by: Yunke Cao <yunkec@google.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> ---
>>  drivers/media/usb/uvc/uvc_ctrl.c   | 81 ++++++++++++++++++++++++++++++++++++++
>>  drivers/media/usb/uvc/uvcvideo.h   |  7 ++++
>>  include/uapi/linux/usb/video.h     |  1 +
>>  include/uapi/linux/uvcvideo.h      | 13 ++++++
>>  include/uapi/linux/v4l2-controls.h |  7 ++++
>>  5 files changed, 109 insertions(+)
>>
>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
>> index 17a7ce525f71..1906ce5b7d50 100644
>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
>> @@ -358,6 +358,24 @@ static const struct uvc_control_info uvc_ctrls[] = {
>>  		.flags		= UVC_CTRL_FLAG_GET_CUR
>>  				| UVC_CTRL_FLAG_AUTO_UPDATE,
>>  	},
>> +	/*
>> +	 * UVC_CTRL_FLAG_AUTO_UPDATE is needed because the RoI may get updated
>> +	 * by sensors.
>> +	 * "This RoI should be the same as specified in most recent SET_CUR
>> +	 * except in the case where the ‘Auto Detect and Track’ and/or
>> +	 * ‘Image Stabilization’ bit have been set."
>> +	 * 4.2.2.1.20 Digital Region of Interest (ROI) Control
>> +	 */
>> +	{
>> +		.entity		= UVC_GUID_UVC_CAMERA,
>> +		.selector	= UVC_CT_REGION_OF_INTEREST_CONTROL,
>> +		.index		= 21,
>> +		.size		= 10,
>> +		.flags		= UVC_CTRL_FLAG_SET_CUR | UVC_CTRL_FLAG_GET_CUR
>> +				| UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_GET_MAX
>> +				| UVC_CTRL_FLAG_GET_DEF
>> +				| UVC_CTRL_FLAG_AUTO_UPDATE,
>> +	},
>>  };
>>  
>>  static const u32 uvc_control_classes[] = {
>> @@ -603,6 +621,44 @@ static const struct uvc_control_mapping *uvc_ctrl_filter_plf_mapping(
>>  	return out_mapping;
>>  }
>>  
>> +static int uvc_get_rect(struct uvc_control_mapping *mapping, u8 query,
>> +			const void *uvc_in, size_t v4l2_size, void *v4l2_out)
>> +{
>> +	const struct uvc_rect *uvc_rect = uvc_in;
>> +	struct v4l2_rect *v4l2_rect = v4l2_out;
>> +
>> +	if (WARN_ON(v4l2_size != sizeof(struct v4l2_rect)))
>> +		return -EINVAL;
>> +
>> +	if (uvc_rect->left > uvc_rect->right ||
>> +	    uvc_rect->top > uvc_rect->bottom)
>> +		return -EIO;
>> +
>> +	v4l2_rect->top = uvc_rect->top;
>> +	v4l2_rect->left = uvc_rect->left;
>> +	v4l2_rect->height = uvc_rect->bottom - uvc_rect->top + 1;
>> +	v4l2_rect->width = uvc_rect->right - uvc_rect->left + 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int uvc_set_rect(struct uvc_control_mapping *mapping, size_t v4l2_size,
>> +			const void *v4l2_in, void *uvc_out)
>> +{
>> +	struct uvc_rect *uvc_rect = uvc_out;
>> +	const struct v4l2_rect *v4l2_rect = v4l2_in;
>> +
>> +	if (WARN_ON(v4l2_size != sizeof(struct v4l2_rect)))
>> +		return -EINVAL;
>> +
>> +	uvc_rect->top = min(0xffff, v4l2_rect->top);
>> +	uvc_rect->left = min(0xffff, v4l2_rect->left);
>> +	uvc_rect->bottom = min(0xffff, v4l2_rect->top + v4l2_rect->height - 1);
>> +	uvc_rect->right = min(0xffff, v4l2_rect->left + v4l2_rect->width - 1);
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>>  	{
>>  		.id		= V4L2_CID_BRIGHTNESS,
>> @@ -897,6 +953,28 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>>  		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
>>  		.filter_mapping	= uvc_ctrl_filter_plf_mapping,
>>  	},
>> +	{
>> +		.id		= V4L2_CID_UVC_REGION_OF_INTEREST_RECT,
>> +		.entity		= UVC_GUID_UVC_CAMERA,
>> +		.selector	= UVC_CT_REGION_OF_INTEREST_CONTROL,
>> +		.size		= sizeof(struct uvc_rect) * 8,
>> +		.offset		= 0,
>> +		.v4l2_type	= V4L2_CTRL_TYPE_RECT,
>> +		.data_type	= UVC_CTRL_DATA_TYPE_RECT,
>> +		.get		= uvc_get_rect,
>> +		.set		= uvc_set_rect,
>> +		.name		= "Region Of Interest Rectangle",
> 
> According to how titles are capitalized in english, this should be lower-case "of".
> 
>> +	},
>> +	{
>> +		.id		= V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
>> +		.entity		= UVC_GUID_UVC_CAMERA,
>> +		.selector	= UVC_CT_REGION_OF_INTEREST_CONTROL,
>> +		.size		= 16,
>> +		.offset		= 64,
>> +		.v4l2_type	= V4L2_CTRL_TYPE_BITMASK,
>> +		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
>> +		.name		= "Region Of Interest Auto Controls",
> 
> Ditto.
> 
> This string is also one character too long (the control description string is at
> most 31 characters). Suggested alternatives:
> 
> "Region of Interest Auto Ctrls"

FWIW my vote goes to the above one, rationale:

1. ROI is unclear
2. "Ctrls" with the _s_ over "Control" as this is a bitmask which allows
   multiple options to be set at the same time (so not a menu style control)
 
> "ROI Auto Controls"
> "Region Of Interest Auto Control"
> 
> I can make the changes myself, but I need to know which alternative to use for
> this string.
 
Regards,
 
	Hans





> 
>> +	},
>>  };
>>  
>>  /* ------------------------------------------------------------------------
>> @@ -1473,6 +1551,9 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
>>  
>>  static size_t uvc_mapping_v4l2_size(struct uvc_control_mapping *mapping)
>>  {
>> +	if (mapping->v4l2_type == V4L2_CTRL_TYPE_RECT)
>> +		return sizeof(struct v4l2_rect);
>> +
>>  	if (uvc_ctrl_mapping_is_compound(mapping))
>>  		return DIV_ROUND_UP(mapping->size, 8);
>>  
>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
>> index 6fc1cb9e99d1..b63720e21075 100644
>> --- a/drivers/media/usb/uvc/uvcvideo.h
>> +++ b/drivers/media/usb/uvc/uvcvideo.h
>> @@ -543,6 +543,13 @@ struct uvc_device_info {
>>  	u16	uvc_version;
>>  };
>>  
>> +struct uvc_rect {
>> +	u16 top;
>> +	u16 left;
>> +	u16 bottom;
>> +	u16 right;
>> +} __packed;
>> +
>>  struct uvc_status_streaming {
>>  	u8	button;
>>  } __packed;
>> diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
>> index 526b5155e23c..e1d9f5773187 100644
>> --- a/include/uapi/linux/usb/video.h
>> +++ b/include/uapi/linux/usb/video.h
>> @@ -104,6 +104,7 @@
>>  #define UVC_CT_ROLL_ABSOLUTE_CONTROL			0x0f
>>  #define UVC_CT_ROLL_RELATIVE_CONTROL			0x10
>>  #define UVC_CT_PRIVACY_CONTROL				0x11
>> +#define UVC_CT_REGION_OF_INTEREST_CONTROL		0x14
>>  
>>  /* A.9.5. Processing Unit Control Selectors */
>>  #define UVC_PU_CONTROL_UNDEFINED			0x00
>> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
>> index f86185456dc5..cbe15bca9569 100644
>> --- a/include/uapi/linux/uvcvideo.h
>> +++ b/include/uapi/linux/uvcvideo.h
>> @@ -16,6 +16,7 @@
>>  #define UVC_CTRL_DATA_TYPE_BOOLEAN	3
>>  #define UVC_CTRL_DATA_TYPE_ENUM		4
>>  #define UVC_CTRL_DATA_TYPE_BITMASK	5
>> +#define UVC_CTRL_DATA_TYPE_RECT		6
>>  
>>  /* Control flags */
>>  #define UVC_CTRL_FLAG_SET_CUR		(1 << 0)
>> @@ -38,6 +39,18 @@
>>  
>>  #define UVC_MENU_NAME_LEN 32
>>  
>> +/* V4L2 driver-specific controls */
>> +#define V4L2_CID_UVC_REGION_OF_INTEREST_RECT	(V4L2_CID_USER_UVC_BASE + 1)
>> +#define V4L2_CID_UVC_REGION_OF_INTEREST_AUTO	(V4L2_CID_USER_UVC_BASE + 2)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE		(1 << 0)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS			(1 << 1)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE		(1 << 2)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS			(1 << 3)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT		(1 << 4)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK	(1 << 5)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION	(1 << 6)
>> +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY		(1 << 7)
>> +
>>  struct uvc_menu_info {
>>  	__u32 value;
>>  	__u8 name[UVC_MENU_NAME_LEN];
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 974fd254e573..72e32814ea83 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -215,6 +215,13 @@ enum v4l2_colorfx {
>>   */
>>  #define V4L2_CID_USER_THP7312_BASE		(V4L2_CID_USER_BASE + 0x11c0)
>>  
>> +/*
>> + * The base for the uvc driver controls.
>> + * See linux/uvcvideo.h for the list of controls.
>> + * We reserve 64 controls for this driver.
>> + */
>> +#define V4L2_CID_USER_UVC_BASE			(V4L2_CID_USER_BASE + 0x11e0)
>> +
>>  /* MPEG-class control IDs */
>>  /* The MPEG controls are applicable to all codec controls
>>   * and the 'MPEG' part of the define is historical */
>>
> 
> 


