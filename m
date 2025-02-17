Return-Path: <linux-kernel+bounces-518061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F9DA38949
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE921886DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F922540C;
	Mon, 17 Feb 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC781AQ3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16919224AFA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810069; cv=none; b=ZDnVVGsi4QJODDEitNxDPV2TwjUA3ewcoo9I3K/s0fE5LxcMPU4mRUBluNqZo9ejPHTm5LWSPUZQZr8ReELDQgKts8/XF38sC81BKkQarqExPfdmu2pb1CnMUCSOGDiyfAmaBZzrQ+UHVTToPVJaAPr9oUyA8BVr9TrDx1W7nVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810069; c=relaxed/simple;
	bh=sSDHAvOfCJs7TmK3HxAQtKqme6c3Swk42wJhlWBbM04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5VQmYQALr+GtzuA+j1zltQpgY1KhrQET1b4znbo+3KskVeJ37FIx8LcWcgg0UL/NzmeXZufylEmoJXcQsB/VOWKUHyJPUXZSlzlmYJbqasOtufZmrx3iBDd49oTx6849C/gYQanGyqRa9FqeoVkDSBYBli5S7syUyE71ow804A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC781AQ3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso50088645e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810066; x=1740414866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlEc/1DhhuQ6PXgaEU0RmiNtz94/GUUPYpvE7Dfmipg=;
        b=iC781AQ3icrH2qSY+3WR4ptwjVJxI4xfHUTytstnHf1HUIc+Kp/kqpZrp5AUKG5cO2
         6dcUcfuKGsFnjPdfZbiNVGPXfR07vxm+GXEaKDnr974O1DOZqJVZjgGaPgqk/xCURl0O
         XeM97IpU6LwzL3IYycrWeS2VfkfSwkVNRBfYwRv/CevTPc0BH/+mU36kZD50QSitbhnk
         WmNJU0SgcmVoJ7K58tpUyQhBiI02wuKFBX+A3qDGI0ng07izUxpAlXYyP29W7MovpSOO
         BCgO8uoxLMx/SLbpqOFTqos9B662FwS9QXlx1IxKrkeWTdK27Dohijkfs2OdbuQ7Y3qU
         dUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810066; x=1740414866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlEc/1DhhuQ6PXgaEU0RmiNtz94/GUUPYpvE7Dfmipg=;
        b=QzCQPkie+MFLZcMvA6CVOljjS/Gix6CIUjDp56sAtU1oCLaNRulT/5vq9d7HI/Yzlh
         LBeem0PTx81QtsuetaAenhphWt//Rt+qzwrO8tE838E4keCnqWYiNnTih4tTIFiNC74d
         3J1pu1I7WYkEMWmO7yjjRDdK9J+Vzj2pEnldT2192SyDMKYUoNGZTpG7dhFzdPx2C+qP
         AqQd4WpvnJNpi27VWHqRWGfro2scAedc+aArtjKbllKoaDWN460CM6B71069vyJ+U3c6
         6L+m35Lf/6knWvXopxQDc0KDgj9InGIfZfgIR8YZKTgaQ3eYIsu9KKiMdkLNT7HB9q1g
         uvtw==
X-Forwarded-Encrypted: i=1; AJvYcCW3OffwWgUJoref2sD1nO6rG9Z49InTV9+vuD1qz2p32GWxJijk6SyO2N9be9eMFuo+X5iIdcvPP9z0+Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5tLlqKeHG1HtLtuXz1657CvOE2c9Fk+8Yphf+bFu2qe0SKiQ
	1e8q+fOboba5sbKbm6znXqxBbnoueAarkRqhkASIKKfdgeCA3D5x
X-Gm-Gg: ASbGncvLLfysqsU94XvkNnbIfAarCLmdHwrzfTv6azhcZkIslU2f4TxOVUk9DpEhW/c
	Zgs1ZXV54zXb5Q5R/YB3PoUe+b56AodEulLj2hc4+sQ/RBxRGnJxaXnt7cQYqedeG85ZDuXvmQ9
	LQWKrohMM607xIbSekmjqKGpEgBxnBTKfVQbN1sklpI7EF739a8uH5X177t9sNAIOV4JfgKQ8vg
	AZ0I5VXX2M7xeas/jCVmb+TXFs80oc7IQqejow3ieEs1yYgOlLZucQRHBCzHrcGXqLVw2anjEMx
	BEBgoNFAIKgOgeY=
X-Google-Smtp-Source: AGHT+IFMADmMY55Rroim8nNi4dr7lMdcl4XT7qcZvO7BoawuPszaqx+VZtHAReeiQxnTw3eLfeBMEA==
X-Received: by 2002:a05:600c:3b8c:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-4396e716f3dmr90733195e9.21.1739810065996;
        Mon, 17 Feb 2025 08:34:25 -0800 (PST)
Received: from fedora ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm124645735e9.11.2025.02.17.08.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:34:25 -0800 (PST)
Date: Mon, 17 Feb 2025 17:34:23 +0100
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] drm/vkms: Allow to configure multiple planes
Message-ID: <Z7NlD8kWkUxojYWy@fedora>
References: <20250217100120.7620-1-jose.exposito89@gmail.com>
 <20250217100120.7620-9-jose.exposito89@gmail.com>
 <6b29064f-104a-4f9c-a9f6-8f4a862dbcd7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b29064f-104a-4f9c-a9f6-8f4a862dbcd7@bootlin.com>

Hi Louis,

Thanks for the quick review.

On Mon, Feb 17, 2025 at 04:45:37PM +0100, Louis Chauvet wrote:
> Hi José,
> 
> Thanks for this new iteration!
> 
> Le 17/02/2025 à 11:01, José Expósito a écrit :
> > Add a list of planes to vkms_config and create as many planes as
> > configured during output initialization.
> > 
> > For backwards compatibility, add one primary plane and, if configured,
> > one cursor plane and NUM_OVERLAY_PLANES planes to the default
> > configuration.
> > 
> > Co-developed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >   .clang-format                                 |   1 +
> >   drivers/gpu/drm/vkms/tests/vkms_config_test.c | 140 +++++++++++++++++-
> >   drivers/gpu/drm/vkms/vkms_config.c            | 127 +++++++++++++++-
> >   drivers/gpu/drm/vkms/vkms_config.h            |  75 +++++++++-
> >   drivers/gpu/drm/vkms/vkms_output.c            |  42 ++----
> >   5 files changed, 349 insertions(+), 36 deletions(-)
> > 
> > diff --git a/.clang-format b/.clang-format
> > index fe1aa1a30d40..c585d2a5b395 100644
> > --- a/.clang-format
> > +++ b/.clang-format
> > @@ -690,6 +690,7 @@ ForEachMacros:
> >     - 'v4l2_m2m_for_each_src_buf'
> >     - 'v4l2_m2m_for_each_src_buf_safe'
> >     - 'virtio_device_for_each_vq'
> > +  - 'vkms_config_for_each_plane'
> >     - 'while_for_each_ftrace_op'
> >     - 'xa_for_each'
> >     - 'xa_for_each_marked'
> > diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> > index 6e07139d261c..fe6f079902fd 100644
> > --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> > +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> > @@ -24,6 +24,10 @@ static void vkms_config_test_empty_config(struct kunit *test)
> >   	dev_name = NULL;
> >   	KUNIT_EXPECT_STREQ(test, vkms_config_get_device_name(config), "test");
> > +	KUNIT_EXPECT_TRUE(test, list_empty(&config->planes));
> 
> Instead of testing directly a "private" field (planes), can we use something
> like:
> 
> int count;
> vkms_config_for_each_plane(config, plane_cfg)
> 	count++;
> ASSERT_EQ(count, 0);
> 
> So we don't make config->plane "public".
> 
> Same comment for connectors, crtc and encoders.

On other calls to list_empty() and also list_count_nodes() and
list_first_entry() we are also accessing "private" fields.

I'll create helpers in vkms_config_test.c replacing the list_* APIs with
iterators and send v4.

Thanks!
Jose
 
> With this:
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> (sorry, I did not notice this on your v2)
> 
> Thanks,
> Louis Chauvet
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

