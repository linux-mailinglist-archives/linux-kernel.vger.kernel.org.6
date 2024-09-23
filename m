Return-Path: <linux-kernel+bounces-335449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2897E5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF3CB20989
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33918B09;
	Mon, 23 Sep 2024 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BzW2k26p"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593B17996
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071678; cv=none; b=NYOooJpIkm1oN/Kjzlpyeu/8BhZQnp6zHLCVdnyqjVLw/YlLjSd+5PDnF3CehA5qo7lImv3Nf4cHLNMnVYxvGRe2aB3csjGRtUfui9PNlV4u3YAFKPj4AtEzENvAe+ZS7AoRtdrUkb2t1+ZZAzvQnQHmu+1f3kHIm7ORj1+iqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071678; c=relaxed/simple;
	bh=G3enpQSCpJDlnfNEBv0DcEbUfgDaeO75AF82NJ/37lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxTjYWfhCuiCeRvgV7BxK01+NiKMLPjVwaqbOmTv7RFdod0cLQbjnOo0JRKLxahJUrwQAI6mDa8I8I86bPzTi+VLp2EbeWjc2nZf1hWWaMj7C7N2asploOjdIwviLJarTPqF8urW07MRN9jzUPSNLZCfE7WWe5z99iQ26HvKzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BzW2k26p; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-537a399e06dso208389e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727071675; x=1727676475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCmO/YTjAtYJXPPaJsx5QKtYsIvj2q2oYXd++xIla/8=;
        b=BzW2k26pz/Z01taXd9LL4YkiTRGNlnaNz/4w/vGs/zzGLPjdFn5Wd8bz0YEfsORaW0
         ljXXNZR86eUdAAuvBgrfVSr8Oe8c7srIBnjvznuqVCh2WGMiiTxVb4/lHuWLobnaYsdq
         WCgFgLM8iVShsk6LMuN3AhUdz4hFS737xR3AscRWDmCh6MLKrluAw094kW60VwumLRYj
         L+1KndwFHbljwrVs/PJg+RTLXXSTohkmKJUlnaSsPNqDFZvaDkae6aS8Nq5YbO9vf3Wk
         2V7crwxDagugGwnVRjTwWodlZ8K8NEck1iY2BLCgtZ/rVdpAvZesYFa8jVBjpZrWl37j
         lEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727071675; x=1727676475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCmO/YTjAtYJXPPaJsx5QKtYsIvj2q2oYXd++xIla/8=;
        b=ORaEQFQqk2lyryTxu0He3/pBZvp2+KwLkjYRY8FciePUHHvjz2Vu1Nwp51RNtgAbwo
         TlMFJxkDP5wo/vPDPAb+nSalsaYtJulSJWEyoLQwiBkDRcepf7+3KKmflL0zujQiPShH
         9YkUi04GhdCmlWTDmmq5UtVI3HPF3UMiK0AQk6Z22aARbkOkHWfpkjkfEuI7hPTWZ7dz
         IFTTKW9PgfhMdCSjsjQF7ZT3BqEIh7cXXRz6DE2hokaYxBxlfvGv9T6v5i15KzPiYgRX
         u4isfwk+7D9u4UUrbOg7ti1krk6HrAvUvY49fa1yjsZCy/wfyBTtrYdruauSidzOiBNg
         MlDw==
X-Forwarded-Encrypted: i=1; AJvYcCUqgUGYvzcYA22OsS3E1b85XM3gIae6MTw2zoa14dUMe5HzVabMsgkVeU0oh+PfIPZf8a0L/5cpbc9tG7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+rM6PORxpUetmKqnfDd4lbh0T7Gwoy2k2vAEsN490rBchVab
	Wodw7AaggIWwXNryRYST88QfmOfFBWHYKhaXdiVg6odrAWBj7YGs0CoxoYsCbx8=
X-Google-Smtp-Source: AGHT+IE9nytSnroJiHN9xKcxla1q+HIPMXUfGMJEkQjc2qU3zMNEUmMCLyZt/tDAoafU+Yd8PgQ6Yg==
X-Received: by 2002:a05:6512:39c9:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-536ac2d0514mr5129471e87.5.1727071675372;
        Sun, 22 Sep 2024 23:07:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046624sm3172932e87.62.2024.09.22.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 23:07:54 -0700 (PDT)
Date: Mon, 23 Sep 2024 09:07:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikandan.M@microchip.com
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, thierry.reding@gmail.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dharma.B@microchip.com
Subject: Re: [PATCH v2 2/2] drm/panel: simple: Add Microchip AC69T88A LVDS
 Display panel
Message-ID: <f4z2egmrcoh7kih2pyr3mq7fzuwtvod6vxlzzim2iw3ly7jcr3@2uxiyzlfixhp>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
 <20240919091548.430285-2-manikandan.m@microchip.com>
 <zognzunciriytm3uvoolxjsvu43v3m2lnctsz5swusnmm3aj2z@ag7zkncccdmf>
 <83e9d20d-f294-4303-b570-816ebc989bcf@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e9d20d-f294-4303-b570-816ebc989bcf@microchip.com>

On Mon, Sep 23, 2024 at 05:50:22AM GMT, Manikandan.M@microchip.com wrote:
> On 20/09/24 9:13 pm, Dmitry Baryshkov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Sep 19, 2024 at 02:45:48PM GMT, Manikandan Muralidharan wrote:
> >> Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
> >> Display module with LVDS interface.The panel uses the Sitronix
> >> ST7262 800x480 Display driver
> > 
> > AC69T88A seems to be a module name, rather than a panel name. What is
> > the actual panel name present on this module?
> Both names, "Microchip AC69T88A" and "MPU32-LVDS-DISPLAY-WVGA" are 
> present on the display module

Which panel was used for the module? I don't think that Microchip
produces LVDS panels.

> > 
> >>
> >> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> >> ---
> >> changes in v2:
> >> - replace microchip,ac69t88a-lvds-panel with
> >> microchip,ac69t88a
> >> ---
> >>   drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
> >>   1 file changed, 28 insertions(+)
> >>
> > 
> > --
> > With best wishes
> > Dmitry
> 
> -- 
> Thanks and Regards,
> Manikandan M.
> 

-- 
With best wishes
Dmitry

