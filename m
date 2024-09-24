Return-Path: <linux-kernel+bounces-336928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F303C9842B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9541C228BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF415DBBA;
	Tue, 24 Sep 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeZCj5vA"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C981AB6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171601; cv=none; b=ULUd3bH+1stejw1CfPcTX7DO06ri02CpAjMaxjkCZuaHdsQNmImY7fTlM3vLGtYY4SwB6OlF+XQZEriVHu94hSzVxcqtEj+ToLoo1Xt+mE0ZyZV/0fD5WYxH0ZtARmQb+y046WB8ODMtWLDjDwLXDCnOtGqAUuMQEPGBwZF9LqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171601; c=relaxed/simple;
	bh=gpDa5jV7LLHIboyhuFDseiP0jRBBnTJL6fUDy3U7O84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2sqYTrmruUSKrzlqDiRoMTB5w86oXwTqFEGJIr5oeUJ6kMUYka667C9RWBI+1cZxCXWGPdisxFE561TZsE0CMNV1LGCg1Ri1n0dnyuTHK9Yd/LNOjftTSbHjV3OxH8kZqht/CgFGdiLKzHzvtyVtXqntDeCSc2SXMuqMPXIC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qeZCj5vA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-537a2a2c74fso1623216e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727171598; x=1727776398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1B1OazfrIYcqDgljo11L7/3HINNwsrbuT9cs/Fij7g4=;
        b=qeZCj5vAQdf64bvrMuQ7CaDVhk9mK8IQswL/+0AuVTTt8EHEtFt5eEub3RHN3j6mXB
         8pno29XkqGafZOx/pbwXjlE/O9MQOCJVCZKFSMU2pRkWw1Ng0FdEO3/AC/OkgQi7/W12
         qrf20KXcXnT5Dk7tIHrBEE4l7PSIvunIRg34KcabPxkIvSdlQNyS5UmdjxrXymPGpHm4
         n7MKuFWb6y8KfzYmWVkXXXNHaJ2ujOvirV7kwV+L/vgzB8HlUNDyy1HHFlLMjEYgoXmp
         e67ZWQZwahKhep5IpRVmFk0wHA5la+lFs9lhbYmMUDR5FtFLM+M9X3d4ceQW0mr6KCiP
         wT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171598; x=1727776398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B1OazfrIYcqDgljo11L7/3HINNwsrbuT9cs/Fij7g4=;
        b=YusJe1xT6wc6mrZeDt4mc9skThIAlkJPLCQygb4DFgkaT7Lwyl4S4vctve/I1KoLXh
         kWLubqcS9jvWXLMymzeAyqXrNOn9XIQoDYL2BNOJj6rMELHWafwIgRvoa000Nc1f8xtP
         TXg93pnGw+K2je2zeoI+uC76ZstVyI+J45u8wNkoMa9dCQdc3C2axvG4WJDk96W8CpCj
         3/jptL8r/edNFdzvNtpwWc8+l0yeaanmT3ACjHgQWvmtTnIJZR4v7OGXcCNPMZ75jPdY
         ybrR0L4xsAMJZlnAMGOgeoVO+q7XVnphHR9frzoMXfg59OZAc6bnD62jTFL2qSVASFVU
         KevA==
X-Forwarded-Encrypted: i=1; AJvYcCV/3ZJECVhouyaF4bee9xJZg5zWBmuoitEnRZURbgRpi4xFswGf7d4p665N7UCPXJtXjfC+m9dpseIZun4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYn2Kwisg+E8L9gS8nvEstA90HKt9uvD44R8YwgPf9gdOTDdN
	1Af7l4kOkIFj/YzpcJrfOSjUfgf+hrciMSZT9JbjkrT+BTwpbeYub9PH7ofrU1s=
X-Google-Smtp-Source: AGHT+IHNdJNovm4z94ZHcR5kxQYpSRslhVpX6h8NUrYQWYFmX6wptEro/DaYvlFqeizDV/AiP8vjQw==
X-Received: by 2002:a05:6512:696:b0:52e:fef4:2cab with SMTP id 2adb3069b0e04-537a6512cd0mr866098e87.2.1727171598188;
        Tue, 24 Sep 2024 02:53:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86490dcsm155318e87.239.2024.09.24.02.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:53:16 -0700 (PDT)
Date: Tue, 24 Sep 2024 12:53:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: ili9881c: Add JMO LCM-JM800WX support
Message-ID: <bplvcvwvtwzxa4drmohvb7qac7j5cyucpww5paru4e4drlexoe@hzvabm5tgxcd>
References: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
 <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-3-22a5e58599be@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-3-22a5e58599be@geanix.com>

On Wed, Aug 14, 2024 at 03:10:37PM GMT, Esben Haabendal wrote:
> Add support for the LCM-JM800WX panel from JMO Tech.
> 
> The init commands are based on information from vendor.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 228 ++++++++++++++++++++++++++
>  1 file changed, 228 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

