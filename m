Return-Path: <linux-kernel+bounces-513914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B9A3502B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4D316BF57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07238269839;
	Thu, 13 Feb 2025 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TW30Dy6Q"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD1266B7B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480802; cv=none; b=QPQLH7yJGGYPAWGjuCiyzxE5CdE9jXz38vUVVkmwfJI+OIAqkVSv7KlNNHGPTOgCcKgxU46eMtvVlhWXyN4QghyfmcITxS9LXW23z1FsZeJWB259fbsRArTaEvWasqzeQ7ewgxTQZp15zHMFHQbqDXa2Wn8+23YF4hG2GrmClhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480802; c=relaxed/simple;
	bh=k9mUIBYNVf/m3XiK/9d9o923sm1DZskoR9Bay1kygxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIHUS4C04QiEyrhAiJywh7QMvM+05bob+d7GGi3rP+xDKgbDtH6pAQ7AuibI9Iw//2ZkifLb2FeDwYgLu0HlVsmNlJTSCnJ70i+ZuAl/XNvdRbzijeM4Na5mP9QvNwYNqAd13mtSYl4CPcBAHjIrZ8uVP+kiR1lE2fNng0WSy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TW30Dy6Q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-308f71d5efcso13928221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739480798; x=1740085598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmXeuchpKSKK7itV+jnu4GAZDK3KHsa9YGIjB4lMa4Y=;
        b=TW30Dy6QT95yxjWWGUnpGo/in5g4tK0AuYc+aeQ+KTlScGAhHzTxqrJPsXJCLyVG/d
         MrQGZ5P/rf2nAMOl2FVK35q7MZHZhflSE0S7x1pTKSJ281Pmjp4IDvZ/xpgkEpCcF5st
         KpkPpy0PdtBZmlkT1PhYEbNhv9Q9CdxML9JrnzSLUOtpmIDRUB22rAYnO5zHQdiJZw5J
         VntZsM+4WErwyMDfUkj8/GbOvr14jrgJL1AzhesEdCr5hQLTxnblfHwsserSsB7MxJ98
         d3JTldMRuAxop3ngGOgeZ1RKzR0RDu4Tl4qkEQPj6SAKXdx06y0/WKQniAgkE7iOTu6d
         +eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739480798; x=1740085598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmXeuchpKSKK7itV+jnu4GAZDK3KHsa9YGIjB4lMa4Y=;
        b=KDOTCvQtzueLRy2Y84Uk0QJhVqUqfLw/+ngsH8VMpSJxUyImbRJ6XzEyOMTU3xynyz
         Yyi3derh3yEf3FC+oZOF8f+bQBKqm4swUgxYKxrTgVkMDlIxPhxzIdFDHr3724d7BdRA
         taNEyaduo/MpJJxE261OAN46mgUbMx+OGRYH04aj4kfGMLZ6lBPtZCOVHpV2XEZvuaWx
         N38I6hxy4Ua4Qo97E75yA9QsxY4ON6TNdIYYMYphjHXm/st24w0kNi6mks6YUasfCwUu
         4t+TOwedlLxEr99Nx3dSqYVNJxx+snpTCJmDRkiqOqu2/SwlElesQqEwLfCcrs8uSKtm
         3eQA==
X-Forwarded-Encrypted: i=1; AJvYcCVWxEW7TShWdyIAwFRORsoxFWld69Dx+FbOIJtxn3Gs1NaFSSzbcvsULpUCGQydNnx2IMv4I2HjgINnSdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyJWsm8h7JHihtdpER2fpg9CYjF+Pm3+7gMWVrOccD54scYCz
	u7zs/Ya2UPjyHT3atCEIR0k5FtX/nRuu1rTesVT8N+GUDSQ0KP+xY0y8o4vH75M=
X-Gm-Gg: ASbGnculKPPm939EYpz5Ya6VDfv8cDHu5I1vdge7i/Bd1AkwnxI0yFoY8ZEiJrUm0l4
	mjk/wuNiytSaW/LI25IhoZ0VfbU4YizKjERtglIfefcJgezHadm1ii0IlM6K9jOvRGL/6+wWdfT
	CnK96S3GmAmEOlyzYsc/UpSwwy8UeUB3lCa/RY+z2qWt9kZ/C8Tbu82Vgh0pUBs7iRBezmlP5F3
	py9Htov9n7wJUhEOViGFK5K/UzcCP+BLG3Qx8H8fOymLqyNZkm5cdRLasvxUinzjM6KJEOiY442
	qiEyn4bwDuYRiazn4rRcwbSkPHDTaBMt7d9DKfglM4rkKz0X2M0Sh87MhAeU9XIJhpG9qno=
X-Google-Smtp-Source: AGHT+IE+Pbr51O7WuqBXkQBPlJzNzEXWSwgmC055Mxz7GAD+fo2hMYKs8st3+0i1dxoABKmhCmeD7A==
X-Received: by 2002:a05:651c:221d:b0:304:4e03:f9d9 with SMTP id 38308e7fff4ca-30903911d8cmr25004601fa.28.1739480798491;
        Thu, 13 Feb 2025 13:06:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091e04742esm109391fa.86.2025.02.13.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:06:37 -0800 (PST)
Date: Thu, 13 Feb 2025 23:06:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>, 
	Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
	Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/20] drm/panel/xpp055c272: Move to using
 mipi_dsi_*_multi() variants
Message-ID: <6zfcqybwxycywlm45ou2wges5qjb63emndmlstieck6qgzsjt4@rdb5hevlufms>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
 <20250213-mipi_cocci_multi-v1-1-67d94ff319cc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-mipi_cocci_multi-v1-1-67d94ff319cc@redhat.com>

On Thu, Feb 13, 2025 at 03:44:18PM -0500, Anusha Srivatsa wrote:
> Stop using deprecated API.
> Used Coccinelle to make the change.
> 

[...]

> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 138 +++++++++++------------
>  1 file changed, 67 insertions(+), 71 deletions(-)

This one has been converted a month ago

commit 8025f23728e9bc817495d48a04954cdee27462bd
Author:     Tejas Vipin <tejasvipin76@gmail.com>
AuthorDate: Tue Jan 7 14:55:10 2025 +0530
Commit:     Douglas Anderson <dianders@chromium.org>
CommitDate: Mon Jan 13 08:22:30 2025 -0800

    drm/panel: xinpeng-xpp055c272: transition to mipi_dsi wrapped functions


-- 
With best wishes
Dmitry

