Return-Path: <linux-kernel+bounces-261486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B80393B7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF211C24198
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291616B72B;
	Wed, 24 Jul 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XqWIrsQl"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F84A18
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852247; cv=none; b=A+cSHtJx8cvnQHakYJ3rnFTAuCljKN6Ort4reJdBaW7O4UXqk1F3d1aETjIZGXtR2c6Kf+ComSldSCEROJjo/L4HniFAHgAN3epeKBIwLHY0waJxsnZBzk76V3tb4/xtPpPMsBXF6/4dbvMNFwvaVhmh6HyKz1LuZ05lmidNytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852247; c=relaxed/simple;
	bh=R6mhB/EJlm6UnPgt1pXvishVPTuBOdUPi6XjkyBjMzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkDt2QDY4N3Fd88wE2/W4RqN/UUYLWWPiJNVCdgJHGcQse5zF1vueX4cTzuM1J5O70ayLjn798aig26YUnDx22hYRpiNy2y+XvN53uhhPlBSNUxmjFNNSFcqvmSoLbO0IYE4GnnITeoDV6jdBzh30jnr8MpB5PekayXIIRc84FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XqWIrsQl; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721852244;
	bh=R6mhB/EJlm6UnPgt1pXvishVPTuBOdUPi6XjkyBjMzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqWIrsQl/Fhv6a6u0XKe8hIrq6qNac9TNSZE0eZWM9Tl62qWi8vtKCj1vKqulcL8H
	 zahdDIGVtVadC0Qnj+TTrZww+1lZkEr8AN5uyloMmLPLajS6Wj/b+0wtU+t+6TBgTa
	 uAdu2lrfK9VRyNtRaqXtdberakogLYrWOfse4SwnuNqBsiW69yWYUfieIvdiec//I+
	 VGL2Ot9TmjS4EssKtZduSOHwmsu0z60JDtZ8vhzvl8oGqUoG1WOIAAVjXi5d3Lp8vf
	 u9kZVE5V4HmGVBJ6w+E4XdkT6gMHu7wjXxmQJiVxqnMrnu93QnrDcUrh3ZJwTJGTta
	 ywVFkxu6VTW4Q==
Received: from [100.107.172.5] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rmader)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F0153780530;
	Wed, 24 Jul 2024 20:17:24 +0000 (UTC)
Message-ID: <48989a76-f2b0-4cbc-80f0-bfd0d4c44bcb@collabora.com>
Date: Wed, 24 Jul 2024 22:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: imx355: Parse and register properties
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, jacopo@jmondi.org,
 sakari.ailus@linux.intel.com, javierm@redhat.com
References: <20240723185856.92814-1-robert.mader@collabora.com>
 <4rkbs3adnnxalbi237u5anydgm326nvu2ztgiyzufpl6r23vc5@d345nvc4zdqc>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <4rkbs3adnnxalbi237u5anydgm326nvu2ztgiyzufpl6r23vc5@d345nvc4zdqc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jacopo,

thanks for the quick review!

Should I send a v2 for that (adding V4L2_CID_CAMERA_ORIENTATION and your 
RB to the commit message) - and if so should I first wait for more 
reviews or is that unnecessary/unlike to happen?

Regards,

Robert

On 24.07.24 09:31, Jacopo Mondi wrote:
> Hi Robert
>
> On Tue, Jul 23, 2024 at 08:58:56PM GMT, Robert Mader wrote:
>> Analogous to e.g. the imx219. This enables propagating
>> V4L2_CID_CAMERA_SENSOR_ROTATION values so that libcamera
> and V4L2_CID_CAMERA_ORIENTATION
>
>> can detect the correct rotation from the device tree
>> and propagate it further to e.g. Pipewire.
> Well, yes, that's a consequence. As long as Linux is concerned, this
> serves to register the two above mentioned controls.
>
>> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
> Thanks
>    j
>
>> ---
>>   drivers/media/i2c/imx355.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
>> index 7e9c2f65fa08..0dd25eeea60b 100644
>> --- a/drivers/media/i2c/imx355.c
>> +++ b/drivers/media/i2c/imx355.c
>> @@ -1520,6 +1520,7 @@ static const struct v4l2_subdev_internal_ops imx355_internal_ops = {
>>   static int imx355_init_controls(struct imx355 *imx355)
>>   {
>>   	struct i2c_client *client = v4l2_get_subdevdata(&imx355->sd);
>> +	struct v4l2_fwnode_device_properties props;
>>   	struct v4l2_ctrl_handler *ctrl_hdlr;
>>   	s64 exposure_max;
>>   	s64 vblank_def;
>> @@ -1531,7 +1532,7 @@ static int imx355_init_controls(struct imx355 *imx355)
>>   	int ret;
>>
>>   	ctrl_hdlr = &imx355->ctrl_handler;
>> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
>> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
>>   	if (ret)
>>   		return ret;
>>
>> @@ -1603,6 +1604,15 @@ static int imx355_init_controls(struct imx355 *imx355)
>>   		goto error;
>>   	}
>>
>> +	ret = v4l2_fwnode_device_parse(&client->dev, &props);
>> +	if (ret)
>> +		goto error;
>> +
>> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx355_ctrl_ops,
>> +					      &props);
>> +	if (ret)
>> +		goto error;
>> +
>>   	imx355->sd.ctrl_handler = ctrl_hdlr;
>>
>>   	return 0;
>> --
>> 2.45.2
>>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718


