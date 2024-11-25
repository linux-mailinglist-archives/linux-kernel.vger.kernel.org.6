Return-Path: <linux-kernel+bounces-421687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA39D8E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E616AEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50C1CB31D;
	Mon, 25 Nov 2024 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SLcs1C5I"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BD1C1AA9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573993; cv=none; b=JU5+bJ5G3E1y4AIR513xFd8u0J/asKNs9kOX1xJ2/mIE+31tTn8Y0h32fOuQ9sUOmWgLZEO/U27FCdvbg/Y3gcB1xuoWmXqwLQ+0eRqvwSU5FCkfgGKUBXXvejF4H/4ozA/oqKfNg4xoYfSCown3gpktdb6kx4kUi3cIRfc4wZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573993; c=relaxed/simple;
	bh=tbINTU/Dl97JGtIyL/9GsACDD+Xncink5kZ9VmwH+Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQq/WeoQ6FQnG8raiZqGyIBi8qdlW3OGFmPfAeebqMoFeOdb7gLyyBBBVIBNf4wUTtR0s5MR+pV1WIEXCgUKLY85qEcP1b2f6EHLZ5wXrxjMrFl7ovOvxT+CXxDngn0XEMJinmOsEEaIIJ5twPr/peD+6iol7GCXz3pgiOlukFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SLcs1C5I; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B396JNk2S3O9embWWP/GtQqDR3zSeL68MQw2q9D629s=; b=SLcs1C5IOSGowt0/ST8LpfNyuw
	gSLDpIDB+32l3Hmmj7uhwjKxBE7R8oPnK/Itvmu8XoZVtvYSmaFkTf8uN+qLcAjV5ZD2vaJLv9PMU
	F7sZqrq56VphD0buzl6qu+Q5BQW/+EORLLeOyk7OmcROJCip1ndgEYi6HyKt8Re+IrcrKQeL00UbT
	FEIDNTwcQ7repYr2V4Hj1tUtIFk1tv4mCYlHUJxDJqd6jkRplpCrKVKfxmr1eCSkU3kO2aZvq7+au
	CRT52FmpXVGvE0q62L5AZgfgKTq2MbCPkiHDjRWBBCrOK/4ygne5T+obzEyesQe9m5BWx69Zg/lRx
	HTTslVmA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tFhda-00CsrK-Ml; Mon, 25 Nov 2024 23:32:58 +0100
Message-ID: <53db4581-5db7-41a2-89ae-694324f8db83@igalia.com>
Date: Mon, 25 Nov 2024 19:32:51 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] drm/vkms: Switch to managed for encoder
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
 <20241122-google-vkms-managed-v5-2-1ab60403e960@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241122-google-vkms-managed-v5-2-1ab60403e960@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 22/11/24 13:27, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create encoders. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_output.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 570823ecb28f589e6323036590ec05a2f633bc9b..ab9affa75b66ce9f00fe025052439405206144ec 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -13,10 +13,6 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
> -static const struct drm_encoder_funcs vkms_encoder_funcs = {
> -	.destroy = drm_encoder_cleanup,
> -};
> -
>   static int vkms_conn_get_modes(struct drm_connector *connector)
>   {
>   	int count;
> @@ -84,8 +80,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   
>   	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
>   
> -	ret = drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> -			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	ret = drmm_encoder_init(dev, encoder, NULL,
> +				DRM_MODE_ENCODER_VIRTUAL, NULL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init encoder\n");
>   		return ret;
> @@ -95,7 +91,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   	ret = drm_connector_attach_encoder(connector, encoder);
>   	if (ret) {
>   		DRM_ERROR("Failed to attach connector to encoder\n");
> -		goto err_attach;
> +		return ret;
>   	}
>   
>   	if (vkmsdev->config->writeback) {
> @@ -108,7 +104,5 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   
>   	return 0;
>   
> -err_attach:
> -	drm_encoder_cleanup(encoder);
>   	return ret;
>   }
> 


