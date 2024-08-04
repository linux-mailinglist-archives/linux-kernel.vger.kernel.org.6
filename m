Return-Path: <linux-kernel+bounces-273990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340F94707E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 22:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D933C1F21152
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 20:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7377102;
	Sun,  4 Aug 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iFB4P82R"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD13179AE
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804455; cv=none; b=rp68pgcunEjYqeIKhUgkRlV/nvra15PlfLgLmjH2RtRJNSm6nkw0JZVHL0xO12CkY0ubzebuxU10iJ2AaF1ZHYb4AmZGXzB/IsjPMXKeXZASUO3wqgMCqaNf00oi31ir9rDl07zdnU4S27y7y2BLlMe9SEXHDKNvVmuWzlBVHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804455; c=relaxed/simple;
	bh=G7jG61sPUDWowFvdCKFsSrRg8yz96dOn7bPperHu144=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNHFC9zs9GVjFL+gaFbudsvORUvVn6oTtaRY3TYhFPLpUiQ6oWAeG7e0P3vBwDe8ZYcFwydoEyzmdrrMcYIctb64WAfIM+YbOAoJb9nc1HUMhLp/GlWcHhk3Z5beMU5sm/ZrRuVncRWMXpQc18Xay5rOQiXioRYNPi8o88gKjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iFB4P82R; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QGZqA/Ycc9erQs51urtOJPkn4CNpRCRgyhDr8Af1FMI=; b=iFB4P82RRgZeQYgKr2C7qfRaMi
	NLniPV73dXt0vQwSuwzmuqoHHYyssDMEu5EfEEbsFXcllyxEajr1RsbbboOpHKbMjQZfuYjiAijqm
	T6UmjoJK2aoHlhL8Qc2lEb88wc0awegGMfBf1uBIJclsvss0jk01sU1E76kGC4zjDV7sQfHTWC03t
	2aUWfON4SoTXLAOPNufpnFx1IAVdGSOEKYuBn+yVygN70EvXnTC1DPgnlIeW7nlcRTxI8XLU9TNNY
	ftAMb/19PYpl4kY73nrIH+97TQtBxnJ6mHtTVEtam+fxmsb0ezh6PqY7ZeJGydEj8W1EqTemZJXgu
	Y26eCwjg==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sai89-007pEc-0U; Sun, 04 Aug 2024 22:47:05 +0200
Message-ID: <e6913c12-14a3-4c00-bf07-90a72313dd39@igalia.com>
Date: Sun, 4 Aug 2024 17:46:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/vkms: Fix cpu_to_le16()/le16_to_cpu() warnings
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, louis.chauvet@bootlin.com
References: <20240716161725.41408-2-jose.exposito89@gmail.com>
 <Zq-29RHgywzw96xz@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <Zq-29RHgywzw96xz@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi José,

On 8/4/24 14:14, José Expósito wrote:
> On Tue, Jul 16, 2024 at 06:17:26PM +0200, José Expósito wrote:
>> Building with Sparse enabled prints this warning for cpu_to_le16()
>> calls:
>>
>>      warning: incorrect type in assignment (different base types)
>>          expected unsigned short [usertype]
>>          got restricted __le16 [usertype]
>>
>> And this warning for le16_to_cpu() calls:
>>
>>      warning: cast to restricted __le16
>>
>> Declare the target buffer as __le16 to fix both warnings.
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
>>
>> ---
>>
>> v1 -> v2: https://lore.kernel.org/dri-devel/20240712161656.7480-1-jose.exposito89@gmail.com/T/
>>
>>   - Thomas Zimmermann: Declare "pixels" cariable as __le16 instead of
>>     multiple casting.
>>
>> v2 -> v3: https://lore.kernel.org/dri-devel/20240715151625.6968-2-jose.exposito89@gmail.com/
>>
>>   - Thomas Zimmermann: Use cpu_to_le16() instead of casting 0xffff
>>   - Reviewed-by Thomas and Louis
>> ---
> 
> Would it be possible to get an ACK from the maintainers? It is a very simple patch
> and it already has 2 reviewed-by, hopefully we can get it merged.

Acked-by: Maíra Canal <mcanal@igalia.com>

Could you please apply it to drm-misc-next?

Best Regards,
- Maíra

> 
> Thanks a lot in advance!
> 
>>   drivers/gpu/drm/vkms/vkms_formats.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
>> index 36046b12f296..040b7f113a3b 100644
>> --- a/drivers/gpu/drm/vkms/vkms_formats.c
>> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
>> @@ -75,7 +75,7 @@ static void XRGB8888_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixe
>>   
>>   static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>>   {
>> -	u16 *pixels = (u16 *)src_pixels;
>> +	__le16 *pixels = (__force __le16 *)src_pixels;
>>   
>>   	out_pixel->a = le16_to_cpu(pixels[3]);
>>   	out_pixel->r = le16_to_cpu(pixels[2]);
>> @@ -85,7 +85,7 @@ static void ARGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>>   
>>   static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>>   {
>> -	u16 *pixels = (u16 *)src_pixels;
>> +	__le16 *pixels = (__force __le16 *)src_pixels;
>>   
>>   	out_pixel->a = (u16)0xffff;
>>   	out_pixel->r = le16_to_cpu(pixels[2]);
>> @@ -95,7 +95,7 @@ static void XRGB16161616_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_
>>   
>>   static void RGB565_to_argb_u16(u8 *src_pixels, struct pixel_argb_u16 *out_pixel)
>>   {
>> -	u16 *pixels = (u16 *)src_pixels;
>> +	__le16 *pixels = (__force __le16 *)src_pixels;
>>   
>>   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>>   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>> @@ -178,7 +178,7 @@ static void argb_u16_to_XRGB8888(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel
>>   
>>   static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>>   {
>> -	u16 *pixels = (u16 *)dst_pixels;
>> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>>   
>>   	pixels[3] = cpu_to_le16(in_pixel->a);
>>   	pixels[2] = cpu_to_le16(in_pixel->r);
>> @@ -188,9 +188,9 @@ static void argb_u16_to_ARGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>>   
>>   static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>>   {
>> -	u16 *pixels = (u16 *)dst_pixels;
>> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>>   
>> -	pixels[3] = 0xffff;
>> +	pixels[3] = cpu_to_le16(0xffff);
>>   	pixels[2] = cpu_to_le16(in_pixel->r);
>>   	pixels[1] = cpu_to_le16(in_pixel->g);
>>   	pixels[0] = cpu_to_le16(in_pixel->b);
>> @@ -198,7 +198,7 @@ static void argb_u16_to_XRGB16161616(u8 *dst_pixels, struct pixel_argb_u16 *in_p
>>   
>>   static void argb_u16_to_RGB565(u8 *dst_pixels, struct pixel_argb_u16 *in_pixel)
>>   {
>> -	u16 *pixels = (u16 *)dst_pixels;
>> +	__le16 *pixels = (__force __le16 *)dst_pixels;
>>   
>>   	s64 fp_rb_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(31));
>>   	s64 fp_g_ratio = drm_fixp_div(drm_int2fixp(65535), drm_int2fixp(63));
>> -- 
>> 2.45.2
>>

