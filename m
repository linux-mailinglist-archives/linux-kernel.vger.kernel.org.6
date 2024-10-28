Return-Path: <linux-kernel+bounces-384580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C69B2BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8CE282BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BF1D356C;
	Mon, 28 Oct 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z3uwQ5rK"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B371CC8B2;
	Mon, 28 Oct 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109045; cv=none; b=HLPs20UzBW09vvez8NLSP4itYU/SHRyL8oCYBfdeieRE+zIKFSDMPqfKBBTZ0I4QQbGGWASSaoW3CpuQPlPHmD00QhIpwJbvvuKLbQgUYAH3YD8h2cbKSCQT8ZuYFVI9vZwZOPs6nL8bLC5BL6zRiIWdEzpof4t1AopRfhZxDdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109045; c=relaxed/simple;
	bh=ODx4FLHcP/vNnIHruibCcYFMQhWqWuYNqzd3qqRr5Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsagM2AbBtGSnwI6SwW9PUVxtlvPJNjpYSS3K+qknhHNf1c6TGVQkqn5ICE30/UnHjfLlcDVCuPJZhcbEu8hMD9ozYPnr7M33GV2Xol/tiafnYpyd3r0X4d4UMZ6b+J2xOUioKdkhdMx3Nyg19tydE8F2yBTNR4meyvP7b+mgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z3uwQ5rK; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C7E940009;
	Mon, 28 Oct 2024 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730109040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ruWVrrdgwZg4KfUdgZhCywnGpkovTfIl1NmWeerMU=;
	b=Z3uwQ5rKVQ6Kh9PHzk0d4sxl5wA0KD3uqjB3kYxP7kczmLEwD6zjab3VoBAp3l4DPwLgBB
	BdX0EYBTtj+XeUAAAPQfsXs/PD+INQxN+Ywh3ZT32HhUerA9nNPhJdAuakyd4hnpuyIbmg
	3wqgGGajwfG8QY5u+6W3M1+CbFM4VpNRBcZY+PLjnX7R73iQdSxpSDZI2xhTdN0GEGksdY
	v1F/GyU3NcozqnwZvgi8XVdbLnu6uRMIZ42Ed3anszkQWtz0FzjYVdaWWddhfNZ3i4gv3Y
	rIBjsvF/t/yNN/WLFrPzraGWyYplyH6jhZ7vlRX/LJNlp2yIZCx/b4qcmS0z4Q==
Date: Mon, 28 Oct 2024 10:50:37 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v12 13/15] drm/vkms: Create KUnit tests for YUV
 conversions
Message-ID: <Zx9ebb1sEehlM150@fedora>
Mail-Followup-To: =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
	arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
	Simona Vetter <simona.vetter@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
	Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20241007-yuv-v12-0-01c1ada6fec8@bootlin.com>
 <20241007-yuv-v12-13-01c1ada6fec8@bootlin.com>
 <d33f982f-f4ca-4bb2-9454-9d01a927d8b5@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d33f982f-f4ca-4bb2-9454-9d01a927d8b5@riseup.net>
X-GND-Sasl: louis.chauvet@bootlin.com

On 26/10/24 - 11:49, Maíra Canal wrote:
> Hi Louis,
> 
> On 07/10/24 13:10, Louis Chauvet wrote:
> > From: Arthur Grillo <arthurgrillo@riseup.net>
> > 
> > Create KUnit tests to test the conversion between YUV and RGB. Test each
> > conversion and range combination with some common colors.
> > 
> > The code used to compute the expected result can be found in comment.
> > 
> > [Louis Chauvet:
> > - fix minor formating issues (whitespace, double line)
> > - change expected alpha from 0x0000 to 0xffff
> > - adapt to the new get_conversion_matrix usage
> > - apply the changes from Arthur
> > - move struct pixel_yuv_u8 to the test itself]
> > 
> > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/Kconfig                  |  15 ++
> >   drivers/gpu/drm/vkms/Makefile                 |   1 +
> >   drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
> >   drivers/gpu/drm/vkms/tests/Makefile           |   3 +
> >   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 232 ++++++++++++++++++++++++++
> >   drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
> >   drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
> >   7 files changed, 265 insertions(+), 2 deletions(-)
> > 
> 
> [...]
> 
> > +
> > +static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
> > +{
> > +	const struct yuv_u8_to_argb_u16_case *param = test->param_value;
> > +	struct pixel_argb_u16 argb;
> > +
> > +	for (size_t i = 0; i < param->n_colors; i++) {
> > +		const struct format_pair *color = &param->colors[i];
> > +		struct conversion_matrix matrix;
> > +
> > +		get_conversion_matrix_to_argb_u16
> > +			(DRM_FORMAT_NV12, param->encoding, param->range, &matrix);
> > +
> > +		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, &matrix);
> 
> This should be `argb_u16_from_yuv161616` as you fixed in [1].

(I suppose you talk about [2]?)

I understand that I change this function in a future series, but [2] is 
not Acked-By yet. I prefer to have the opportunity to merge this 
first series (with yuv888) quickly and to work on [2] later (I have less 
conflicts between [2] and the rest of my work on configFS).

If I get a Acked-by on [2], I can merge the two commits and directly use 
yuv161616 conversion functions.

Thanks,
Louis Chauvet

[2]:https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-6-d47da50d4674@bootlin.com/
 
> [1] https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-5-d47da50d4674@bootlin.com/
> 
> Best Regards,
> - Maíra
> 
> > +
> > +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.a, color->argb.a), 257,
> > +				    "On the A channel of the color %s expected 0x%04x, got 0x%04x",
> > +				    color->name, color->argb.a, argb.a);
> > +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.r, color->argb.r), 257,
> > +				    "On the R channel of the color %s expected 0x%04x, got 0x%04x",
> > +				    color->name, color->argb.r, argb.r);
> > +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.g, color->argb.g), 257,
> > +				    "On the G channel of the color %s expected 0x%04x, got 0x%04x",
> > +				    color->name, color->argb.g, argb.g);
> > +		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.b, color->argb.b), 257,
> > +				    "On the B channel of the color %s expected 0x%04x, got 0x%04x",
> > +				    color->name, color->argb.b, argb.b);
> > +	}
> > +}
> > +
> > +static void vkms_format_test_yuv_u8_to_argb_u16_case_desc(struct yuv_u8_to_argb_u16_case *t,
> > +							  char *desc)
> > +{
> > +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
> > +		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
> > +}
> > +
> > +KUNIT_ARRAY_PARAM(yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_cases,
> > +		  vkms_format_test_yuv_u8_to_argb_u16_case_desc
> > +);
> > +
> > +static struct kunit_case vkms_format_test_cases[] = {
> > +	KUNIT_CASE_PARAM(vkms_format_test_yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_gen_params),
> > +	{}
> > +};
> > +
> > +static struct kunit_suite vkms_format_test_suite = {
> > +	.name = "vkms-format",
> > +	.test_cases = vkms_format_test_cases,
> > +};
> > +
> > +kunit_test_suite(vkms_format_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Kunit test for vkms format conversion");
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> > index adb1228e5201..0b201185eae7 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > @@ -7,6 +7,8 @@
> >   #include <drm/drm_rect.h>
> >   #include <drm/drm_fixed.h>
> > +#include <kunit/visibility.h>
> > +
> >   #include "vkms_formats.h"
> >   /**
> > @@ -247,8 +249,8 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
> >   	return out_pixel;
> >   }
> > -static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> > -						  const struct conversion_matrix *matrix)
> > +VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> > +							    const struct conversion_matrix *matrix)
> >   {
> >   	u16 r, g, b;
> >   	s64 fp_y, fp_channel_1, fp_channel_2;
> > @@ -278,6 +280,7 @@ static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel
> >   	return argb_u16_from_u16161616(0xffff, r, g, b);
> >   }
> > +EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
> >   /*
> >    * The following functions are read_line function for each pixel format supported by VKMS.
> > diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
> > index d583855cb320..b4fe62ab9c65 100644
> > --- a/drivers/gpu/drm/vkms/vkms_formats.h
> > +++ b/drivers/gpu/drm/vkms/vkms_formats.h
> > @@ -13,4 +13,9 @@ void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encod
> >   				       enum drm_color_range range,
> >   				       struct conversion_matrix *matrix);
> > +#if IS_ENABLED(CONFIG_KUNIT)
> > +struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
> > +					   const struct conversion_matrix *matrix);
> > +#endif
> > +
> >   #endif /* _VKMS_FORMATS_H_ */
> > 

