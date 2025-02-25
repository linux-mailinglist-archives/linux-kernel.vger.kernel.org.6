Return-Path: <linux-kernel+bounces-531226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC6A43DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DB016CBE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BA267B18;
	Tue, 25 Feb 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FcL3YFbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0qVbW/6+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FcL3YFbE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0qVbW/6+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE7266B5E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483540; cv=none; b=oOGekOnNpcojeWM5wJW0Ex76Rne3VnVb0WGn8Yx9Q5CylVx4nI5Bo49/IajonI6iMxaNUz/zzTMK/Bn+AoXtWG0WlAwCFIqcQu0H/PS3oFDNCWMFdJj1aAt2F2AUDKIs9xWwDEEuq5xb/MTIUEWk0mY778gSPrKVouYYjOu8HkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483540; c=relaxed/simple;
	bh=oTQLEnucV542M6ZP7k68h/PprEj6H6WKWkGdXbGouV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTItwQmpMtDFwlBXzz5+wCisU6WsTxcKZ7B6aBot9PbSzNJDPX86NXeTeRnvA8clthMMx77tswLOXxNu7mVZk8kHgg+uv/ifUVOnONiTZIY+thBZv4SjpfDbP4evfrVy7UIMw4QzhPFr4pSV62oEYlUBXaBddn1wPBWy+4bAEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FcL3YFbE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0qVbW/6+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FcL3YFbE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0qVbW/6+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 304B321166;
	Tue, 25 Feb 2025 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740483536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9ABMn7Jnj5cUGatJDRKKEvt77TfWyRb9+YXDUVL7Yu0=;
	b=FcL3YFbELTx/aoLFqOZ24dpe6vTz+A7ywqjE2yHsCtjrT0lI3hvZuYnqDrKbGkgAvDjBsY
	g+RV8AwwEBu5/HAj84arrCNVdq7u1+lGyKJ0v+pq1pyD1FgfC7AFxxdbKvZCYxyHBlcSMe
	MXezsJCWwHjFlI1gsmnyEJrDx5P17z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740483536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9ABMn7Jnj5cUGatJDRKKEvt77TfWyRb9+YXDUVL7Yu0=;
	b=0qVbW/6+Xz6goX9bcZCpXGXPLU5P9zeiDr6Ny5P+j6tAHOONtpAuNmYS+iWS89F6qIYx6e
	5SZRnnSrp0mR++CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740483536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9ABMn7Jnj5cUGatJDRKKEvt77TfWyRb9+YXDUVL7Yu0=;
	b=FcL3YFbELTx/aoLFqOZ24dpe6vTz+A7ywqjE2yHsCtjrT0lI3hvZuYnqDrKbGkgAvDjBsY
	g+RV8AwwEBu5/HAj84arrCNVdq7u1+lGyKJ0v+pq1pyD1FgfC7AFxxdbKvZCYxyHBlcSMe
	MXezsJCWwHjFlI1gsmnyEJrDx5P17z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740483536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9ABMn7Jnj5cUGatJDRKKEvt77TfWyRb9+YXDUVL7Yu0=;
	b=0qVbW/6+Xz6goX9bcZCpXGXPLU5P9zeiDr6Ny5P+j6tAHOONtpAuNmYS+iWS89F6qIYx6e
	5SZRnnSrp0mR++CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE0C913332;
	Tue, 25 Feb 2025 11:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oyCqMM6rvWfoPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Feb 2025 11:38:54 +0000
Message-ID: <0e6817b1-d52e-407f-bdb9-93919f849edc@suse.de>
Date: Tue, 25 Feb 2025 12:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] drm/vgem/vgem_drv convert to use faux_device
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
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
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
In-Reply-To: <2025021028-brigade-create-37de@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,google.com,huawei.com,gmail.com,wunner.de,kernel.org,riseup.net,arm.com,ffwll.ch,quicinc.com,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi

Am 10.02.25 um 13:30 schrieb Greg Kroah-Hartman:
> The vgem driver does not need to create a platform device, as there is
> no real platform resources associated it,  it only did so because it was
> simple to do that in order to get a device to use for resource
> management of drm resources.  Change the driver to use the faux device
> instead as this is NOT a real platform device.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Should this patch be merged through DRM trees?

Best regards
Thomas

> ---
> v4: - api tweaked due to parent pointer added to faux_device create
>        function.
>   v3: new patch in the series.  For an example of the api working, does
>       not have to be merged at this time, but I can take it if the
>       maintainers give an ack.
>   drivers/gpu/drm/vgem/vgem_drv.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index 2752ab4f1c97..260c64733972 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -32,7 +32,7 @@
>   
>   #include <linux/dma-buf.h>
>   #include <linux/module.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>   #include <linux/shmem_fs.h>
>   #include <linux/vmalloc.h>
>   
> @@ -52,7 +52,7 @@
>   
>   static struct vgem_device {
>   	struct drm_device drm;
> -	struct platform_device *platform;
> +	struct faux_device *faux_dev;
>   } *vgem_device;
>   
>   static int vgem_open(struct drm_device *dev, struct drm_file *file)
> @@ -127,27 +127,27 @@ static const struct drm_driver vgem_driver = {
>   static int __init vgem_init(void)
>   {
>   	int ret;
> -	struct platform_device *pdev;
> +	struct faux_device *fdev;
>   
> -	pdev = platform_device_register_simple("vgem", -1, NULL, 0);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	fdev = faux_device_create("vgem", NULL, NULL);
> +	if (!fdev)
> +		return -ENODEV;
>   
> -	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> +	if (!devres_open_group(&fdev->dev, NULL, GFP_KERNEL)) {
>   		ret = -ENOMEM;
>   		goto out_unregister;
>   	}
>   
> -	dma_coerce_mask_and_coherent(&pdev->dev,
> +	dma_coerce_mask_and_coherent(&fdev->dev,
>   				     DMA_BIT_MASK(64));
>   
> -	vgem_device = devm_drm_dev_alloc(&pdev->dev, &vgem_driver,
> +	vgem_device = devm_drm_dev_alloc(&fdev->dev, &vgem_driver,
>   					 struct vgem_device, drm);
>   	if (IS_ERR(vgem_device)) {
>   		ret = PTR_ERR(vgem_device);
>   		goto out_devres;
>   	}
> -	vgem_device->platform = pdev;
> +	vgem_device->faux_dev = fdev;
>   
>   	/* Final step: expose the device/driver to userspace */
>   	ret = drm_dev_register(&vgem_device->drm, 0);
> @@ -157,19 +157,19 @@ static int __init vgem_init(void)
>   	return 0;
>   
>   out_devres:
> -	devres_release_group(&pdev->dev, NULL);
> +	devres_release_group(&fdev->dev, NULL);
>   out_unregister:
> -	platform_device_unregister(pdev);
> +	faux_device_destroy(fdev);
>   	return ret;
>   }
>   
>   static void __exit vgem_exit(void)
>   {
> -	struct platform_device *pdev = vgem_device->platform;
> +	struct faux_device *fdev = vgem_device->faux_dev;
>   
>   	drm_dev_unregister(&vgem_device->drm);
> -	devres_release_group(&pdev->dev, NULL);
> -	platform_device_unregister(pdev);
> +	devres_release_group(&fdev->dev, NULL);
> +	faux_device_destroy(fdev);
>   }
>   
>   module_init(vgem_init);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


