Return-Path: <linux-kernel+bounces-187334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4728CD057
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0826CB21E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57671411D6;
	Thu, 23 May 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAbDqDQ5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6D13F453
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459938; cv=none; b=Kfqp7XBbyjm3Smyo2Pyvitlj7DxgB5P+0sKVPsmPHqQzFJUr1keCRGbW0wXP+d7LhZtGd/mpuDC8zNmjcN756945VuJFTDvNLwyvQ4wfjBwXMLzO7tF2aKSakINYCWwuSJfVLD0mge35Lp6jMUSNGqIVOxT8b0c/QLN4dLPu+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459938; c=relaxed/simple;
	bh=7qYk3nhcej1wrZJb9D0jf9PZ7Z4vN9EkOqPyNt6ofBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAmD+FAbPKFhDmqPup0JMgFzoFoahiCk1ZoRwfyX9rNyk2iuIJ22Gf75HBMrAw9xaBcrvPoQHbbRsJBE7y3lm5Q28nnECtrAKLS64YJkNauLKh8/SMjzRSP1SCDkM7Yyc5aQK0fxisw9lP8gkXPwJ5zr3f3QDPJIFWaBbGpggj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAbDqDQ5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f57713684so9036230e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716459934; x=1717064734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0Y/Ql63/IxwaJL+O/h+E6/ion+Rk9v6vnf8eimobm8=;
        b=wAbDqDQ5plrdgEgnRvwbWiOGE42EGXPV/bMvDMI5DSR3xTKEllKa0SqYnVwQ9xUwx3
         +W5tHNyEt4ceN5+JBV1F+pNqvtvAvQBvWWp00G4xupivZ7XPVpKiRh2DSToahFdtEMlO
         IRbSarKYsKf4mVMG90VLw4+ZRcBY0ctbxUDuri6BikW6s2cQlqykZCCym2GTCVG7wOq2
         TxLgYTqGXW3Uk0J7RK6SguvwDUiosucz9UXRt33uvZw63BaZxm0amdIWgRsr3hhD2ccd
         VwCvQQDUMFUIbVmHKGGYUs7n+n+MMHBUBztmfSMxb/yIoKv5ZZCjLU0jJ6ge/6wm02Lf
         IGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716459934; x=1717064734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0Y/Ql63/IxwaJL+O/h+E6/ion+Rk9v6vnf8eimobm8=;
        b=UyqhoQ7NVGI9/IBL9U8CESG8Y5fPkQIIOIJ6ZmYPRxjobhPh7saZhyrEpyKexNRibC
         cln5mjG/zSepRz/qVTKPToPXegRRx51j1x439C6UcpkTXhqr9a3SH31Wx1b/cvWDeimr
         d6IUZSgF5LmRpaNNddYuSSCQpUQd0JlMwhY9CCVVBEaQ8nILPCjecvkup9iTcacoYGgM
         /nCwzF5RxsoVlmJomCyu84eMhIX2db2SZ8GujJ3g4VIoh9c8s6mSMtmAZqOTfW5JbHpD
         /b7VJJS7xYDEty6gksIs1AaxteMd3Pw0Xcj+qu07/2dwuksoGv8QV80Rbk8Ohv0gytuu
         VtZg==
X-Forwarded-Encrypted: i=1; AJvYcCUgPkVGQs+Pow5ebVpkTo16FoHHWVCZf9muBeZfhzeJqVG+9I2YcSsh9EPhcnNaWqS2ndTH850A2lg3satQPQy5GqZygNjXvQgdMl8B
X-Gm-Message-State: AOJu0Yy0XhU009SyecGtcUqbcjnFoD/d9z8DNW2UAXoD4ZEMmca5La66
	lhu9GzocXB6/IKnQVfQ9RWXOJlKLCVm/hjCulrykXm5mygnbRiW5YYe9m5M1Td0=
X-Google-Smtp-Source: AGHT+IG3S9HxgA+BRyKc+tEiIJocVHkYeAAUZVOvMSsA2E8b2S+QZ7Z9TP78uV3Je9C7031yrjAtlg==
X-Received: by 2002:a19:5208:0:b0:519:2a88:add6 with SMTP id 2adb3069b0e04-526c0782f50mr2886400e87.55.1716459933553;
        Thu, 23 May 2024 03:25:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba739sm5323969e87.101.2024.05.23.03.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:25:32 -0700 (PDT)
Date: Thu, 23 May 2024 13:25:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v14 20/28] drm/tests: Add RGB Quantization tests
Message-ID: <pruqf2ou26m7i7ez2p6rgjdfbzkngqyuwfv3bnx5d3jzxce3af@sa3d467uka3d>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-20-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-20-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:53PM +0200, Maxime Ripard wrote:
> The previous commit added the infrastructure to the connector state to
> track what RGB Quantization should be used in a given state for an HDMI
> connector.
> 
> Let's add some kunit tests to make sure it works as expected.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 355 +++++++++++++++++++++
>  1 file changed, 355 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

