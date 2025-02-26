Return-Path: <linux-kernel+bounces-533295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF85A457F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082BF7A2E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758201A2C0B;
	Wed, 26 Feb 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vNjTUIvl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OqEUzyp9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vNjTUIvl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OqEUzyp9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4D258CCA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557919; cv=none; b=PBNjBiatbB9hiHHSYbD5z8P2MCTL9OlKT+synW2i3+70Yf9W3jcabFjxr/rr4byaU0lqUEPMnvDu4XlbsVdHJPA4BBD7bT9S/gAP68Cxtg2XdBrGOZMIJSEjfy/3XrqP/xKCud5SejhSvVGDqZ1RNvIwWDcmRNQ6HcAx5Qw8TAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557919; c=relaxed/simple;
	bh=7iQXZFPV8xaSN9B38yfM2ZoDn4nINFBTgcSUh0agD3o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OnOHSXINTVgVlRkFBWLaSXFRBMP1uwHkfHu2gHdoffqa9ukm0D1/Az+E6ljdwYmh92yATSpAFktxVIvh/aQGF8ulQLWuSoHr+mJ5KT2LK+dGA9NYWuqRyjtM0iHOEAPj9XhaT1ySqDTk+dq93AqrRHwi7JX92WJtH3AijtMhmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vNjTUIvl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OqEUzyp9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vNjTUIvl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OqEUzyp9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57FD51F387;
	Wed, 26 Feb 2025 08:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740557916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zAlwoLueuQSfuS2e6jssod8JXQot5CofYgSqId4LaO8=;
	b=vNjTUIvlVLOjhS5WuAxG1Nvz0L7NFNHV6PO76Yd2ojxVdS4EJbYCod+owWW2Dy5YVJ5YqM
	3GJcYgyXuweUieW2IUFSDEsW3RGb5HZYqLEaAeOPBYbAy9Pjm6E6P9W4E1ki9jxw/o8aJ+
	zPWFd26EeTY74TQp4yuwAwEvr4QX1cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740557916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zAlwoLueuQSfuS2e6jssod8JXQot5CofYgSqId4LaO8=;
	b=OqEUzyp9CDDDRXhcUy+GRNY/ZY2sNBqTu7kYpUAdrCOpepSpOLLX64M4tD5LzroCJR2sCW
	yXbeg+upsmJvrCBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vNjTUIvl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OqEUzyp9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740557916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zAlwoLueuQSfuS2e6jssod8JXQot5CofYgSqId4LaO8=;
	b=vNjTUIvlVLOjhS5WuAxG1Nvz0L7NFNHV6PO76Yd2ojxVdS4EJbYCod+owWW2Dy5YVJ5YqM
	3GJcYgyXuweUieW2IUFSDEsW3RGb5HZYqLEaAeOPBYbAy9Pjm6E6P9W4E1ki9jxw/o8aJ+
	zPWFd26EeTY74TQp4yuwAwEvr4QX1cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740557916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zAlwoLueuQSfuS2e6jssod8JXQot5CofYgSqId4LaO8=;
	b=OqEUzyp9CDDDRXhcUy+GRNY/ZY2sNBqTu7kYpUAdrCOpepSpOLLX64M4tD5LzroCJR2sCW
	yXbeg+upsmJvrCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24BF1377F;
	Wed, 26 Feb 2025 08:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kX3SKVvOvmcgQwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 26 Feb 2025 08:18:35 +0000
Message-ID: <08b1a062-739d-4db6-95a3-11e5ebe8623f@suse.de>
Date: Wed, 26 Feb 2025 09:18:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] drm/vgem/vgem_drv convert to use faux_device
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Robin Murphy <robin.murphy@arm.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Zijun Hu <quic_zijuhu@quicinc.com>,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <2025021028-brigade-create-37de@gregkh>
 <0e6817b1-d52e-407f-bdb9-93919f849edc@suse.de>
Content-Language: en-US
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <0e6817b1-d52e-407f-bdb9-93919f849edc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57FD51F387
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,google.com,huawei.com,gmail.com,wunner.de,kernel.org,riseup.net,arm.com,ffwll.ch,quicinc.com,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,intel.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 



Am 25.02.25 um 12:38 schrieb Thomas Zimmermann:
> Hi
>
> Am 10.02.25 um 13:30 schrieb Greg Kroah-Hartman:
>> The vgem driver does not need to create a platform device, as there is
>> no real platform resources associated it,  it only did so because it was
>> simple to do that in order to get a device to use for resource
>> management of drm resources.  Change the driver to use the faux device
>> instead as this is NOT a real platform device.
>>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: dri-devel@lists.freedesktop.org
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Should this patch be merged through DRM trees?

Louis mentioned that the vkms patch will goes through DRM. If no one 
objects, I'll merge this patch there as well.

Best regards
Thomas

>
> Best regards
> Thomas
>
>> ---
>> v4: - api tweaked due to parent pointer added to faux_device create
>>        function.
>>   v3: new patch in the series.  For an example of the api working, does
>>       not have to be merged at this time, but I can take it if the
>>       maintainers give an ack.
>>   drivers/gpu/drm/vgem/vgem_drv.c | 30 +++++++++++++++---------------
>>   1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c 
>> b/drivers/gpu/drm/vgem/vgem_drv.c
>> index 2752ab4f1c97..260c64733972 100644
>> --- a/drivers/gpu/drm/vgem/vgem_drv.c
>> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
>> @@ -32,7 +32,7 @@
>>     #include <linux/dma-buf.h>
>>   #include <linux/module.h>
>> -#include <linux/platform_device.h>
>> +#include <linux/device/faux.h>
>>   #include <linux/shmem_fs.h>
>>   #include <linux/vmalloc.h>
>>   @@ -52,7 +52,7 @@
>>     static struct vgem_device {
>>       struct drm_device drm;
>> -    struct platform_device *platform;
>> +    struct faux_device *faux_dev;
>>   } *vgem_device;
>>     static int vgem_open(struct drm_device *dev, struct drm_file *file)
>> @@ -127,27 +127,27 @@ static const struct drm_driver vgem_driver = {
>>   static int __init vgem_init(void)
>>   {
>>       int ret;
>> -    struct platform_device *pdev;
>> +    struct faux_device *fdev;
>>   -    pdev = platform_device_register_simple("vgem", -1, NULL, 0);
>> -    if (IS_ERR(pdev))
>> -        return PTR_ERR(pdev);
>> +    fdev = faux_device_create("vgem", NULL, NULL);
>> +    if (!fdev)
>> +        return -ENODEV;
>>   -    if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
>> +    if (!devres_open_group(&fdev->dev, NULL, GFP_KERNEL)) {
>>           ret = -ENOMEM;
>>           goto out_unregister;
>>       }
>>   -    dma_coerce_mask_and_coherent(&pdev->dev,
>> +    dma_coerce_mask_and_coherent(&fdev->dev,
>>                        DMA_BIT_MASK(64));
>>   -    vgem_device = devm_drm_dev_alloc(&pdev->dev, &vgem_driver,
>> +    vgem_device = devm_drm_dev_alloc(&fdev->dev, &vgem_driver,
>>                        struct vgem_device, drm);
>>       if (IS_ERR(vgem_device)) {
>>           ret = PTR_ERR(vgem_device);
>>           goto out_devres;
>>       }
>> -    vgem_device->platform = pdev;
>> +    vgem_device->faux_dev = fdev;
>>         /* Final step: expose the device/driver to userspace */
>>       ret = drm_dev_register(&vgem_device->drm, 0);
>> @@ -157,19 +157,19 @@ static int __init vgem_init(void)
>>       return 0;
>>     out_devres:
>> -    devres_release_group(&pdev->dev, NULL);
>> +    devres_release_group(&fdev->dev, NULL);
>>   out_unregister:
>> -    platform_device_unregister(pdev);
>> +    faux_device_destroy(fdev);
>>       return ret;
>>   }
>>     static void __exit vgem_exit(void)
>>   {
>> -    struct platform_device *pdev = vgem_device->platform;
>> +    struct faux_device *fdev = vgem_device->faux_dev;
>>         drm_dev_unregister(&vgem_device->drm);
>> -    devres_release_group(&pdev->dev, NULL);
>> -    platform_device_unregister(pdev);
>> +    devres_release_group(&fdev->dev, NULL);
>> +    faux_device_destroy(fdev);
>>   }
>>     module_init(vgem_init);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


