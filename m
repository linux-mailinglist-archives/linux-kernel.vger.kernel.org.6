Return-Path: <linux-kernel+bounces-538304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F86A496E9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDDB174947
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1325D1E1;
	Fri, 28 Feb 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raxQR0X/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80A25D209
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737850; cv=none; b=Q/4sjueGOOf7lyqpRqS7ZbhYggqXa+kFzHowIUAl8wrYRjxMayf1qVTdHo52NI0JX56+Bg+ZZdEY8t7w2e0xLP/eLs+xymj33HEuMkqUqKuruEiaqgOAEHruQ02yD65VlK1LnczHmLT/apg9zoYyV1SGdvF5VX7FvYOTMyY3Jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737850; c=relaxed/simple;
	bh=b9yW9aKaAj0vv2X4pBwVEAQJxZ6g3pOXCix4VsedwdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw0YmdNsf1oELGVlGS6/eKdyoJx9LdcQMMTymdH09cpIRiutztkhDAMwrm2jw3SKWWBpmYyYhyET4xrqlWmQdWJz5LDBExQpIAOxUSK3PyuuWSfDx4xdpa0WqpNdlrwAKEvvvmgkU/FVoIn15W/st2BAnhJAuiOjBhi9uxxOj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=raxQR0X/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5462ea9691cso2075882e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740737846; x=1741342646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtF5m7Eo7tw5lbKf+07cY2Tp/XNLgGV8I/BZlAp6LwE=;
        b=raxQR0X//11z6BewOta7agfUypiDhK4ApQngGZqwK+M/3S2fl4OV8WSIpzq8OPdwtN
         YMmQnIEa9idk8m+Lg15ITcP+7txroImhd/spu9J3hzPt3njZlZwwSTDZirviFGVvLHq4
         LgK3UXtjhnpBiFWB9hFhw+Az+OVik7TZWbmJiK2v8nLlICYhec6ODatU4mwlSTiBT7uT
         HBUPBrWymsDYnxgmvn393qOrpJmFlLV5kpTHlZDCwp84Gge5dB621/Mf77BlTB1ughfd
         TNY0ZcBQPYTPA/zp+C/AcVMGgL70cvPpL2bmzR8DQzYARGqDIbSjL75siqrpZiEfpR9L
         nbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737846; x=1741342646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtF5m7Eo7tw5lbKf+07cY2Tp/XNLgGV8I/BZlAp6LwE=;
        b=Lov8NQRQBDDKkaBSCCMxF5S3e4li5JsypH1JXpy4jBSpHS/h+QAPe61oC1xLw7TPgg
         fX29R4pxzyqaC3ICP8gp1Oh3RETh4SP9N0BqF4hvY0e/mLuzB6Ktcu6wqzBYB/ubiEnu
         2UDD6Ox4JvQN9AsHsg03Fwcrim9wFpObegoalU4FK4aAwfxhwDGxsbfOps0J9RTMZ1Cy
         7ig0hsa1BxGTPS1muagmHV3c0oHHWdJIYivmG1QgzUAjog7bRsXewzlEUsop/Zhkldk2
         /AiA9/cbdzgaYuGWKR6uzh03sf/Mq8ac8HaP+C/b8/3ZL+oTBSdUwZDO3uFTjPfg/HqA
         8vgg==
X-Forwarded-Encrypted: i=1; AJvYcCX2lM6VJymPVxiOt50d6eivo3c9moxcDEAREYByZ/lOSbfG6ggkxeXli0Rnyp4Zy9ZCbWLZ50Y639hVn98=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsIvk7znSfRcAmNv3qD770UtQ3luoFSnDZSoooSOc9vNjCPTK
	aV+RFCKlKQ3qC+Rg2S8WMvukphD0YVfVEmT7aH7A650AO6JMIPf4LJMX33+3OgQ=
X-Gm-Gg: ASbGnctmIavObLlo032JCBmcnFRUdVeSzXRMSgqJ46CzaXPymAfwSnmtggn8wi1ZqJb
	KX6EwDE7vQvugu9KlMU9F73eHY0+XsDkhkoUUZeK/ci0RfIQJHW2SHIkDc0zfx7AdLvZJCUyGAx
	JKhOjdMQ4w4hqpq/ASTUSXIRFk/zOcDfnRLBgKDK943pfty2yH+HIZYiwt1Ws2OrEh8OIxaXg2D
	GHJJKExkBCuImLcSvvKiA5Fy3+22uJMyGc9UyuG4KpIBxuO273yPCBSMr7Q/EI/kYYDO/D8eN7P
	TNZu4L+6BsbcemLpw1jIV4KxSHhci/xkWIGgV9OtLSvXYoE13RqFZoqj4QB7geSUWSPNsyMFxUZ
	8UG330A==
X-Google-Smtp-Source: AGHT+IGumV9C8K5BUf/QNt3duu1Cz/DHryWxGnIRVWU5r5VemArqgE7BiCYNujMBRO+d3tj1JXx2Sg==
X-Received: by 2002:ac2:4641:0:b0:549:54f7:e54 with SMTP id 2adb3069b0e04-54954f70ecfmr305434e87.50.1740737846015;
        Fri, 28 Feb 2025 02:17:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cc9d3sm440219e87.224.2025.02.28.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:17:24 -0800 (PST)
Date: Fri, 28 Feb 2025 12:17:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J . Wysocki " <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/qcom-spmi-temp-alarm: drop unused driver
 data
Message-ID: <u6h3ekbyhlscbf75wz5zc7pusizky4o34i5h3uluch5xi22oba@x7y4mhohlvgx>
References: <20250228082936.5694-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228082936.5694-1-johan+linaro@kernel.org>

On Fri, Feb 28, 2025 at 09:29:36AM +0100, Johan Hovold wrote:
> The platform device driver data has not been used since commit
> 7a4ca51b7040 ("thermal/drivers/qcom-spmi: Use devm_iio_channel_get") so
> drop the unnecessary assignment.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> I noticed this when doing some rework for pm8008 last year that I have
> yet to finish.
> 
> This can go in meanwhile.
> 
> Johan
> 
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

