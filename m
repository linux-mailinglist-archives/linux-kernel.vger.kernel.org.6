Return-Path: <linux-kernel+bounces-183289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A78C973D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBE1F20ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC173173;
	Sun, 19 May 2024 22:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryCGgTsu"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F286EB62
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157570; cv=none; b=oqr8Y3OMk630wofqENtKmM5GLNbudc3qudmngtBIKhqGzjf7SvZqaOD+ooiFN4TUv53duLEtp9qnQjq/21I3dXBtK1eMAc47FHjY9IDfv9Kp8H3p3LCaQT/6rhh3Yqevfi1Bhixc5X6uW8QBtMpmXigeNLmjMlzcIrgpDcn7feA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157570; c=relaxed/simple;
	bh=9tsQVsXkYAR/JXd8InHKzknLkf0H+ZfY0HgqfGFD+HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFuGp1kROoDYdUreIA6ftHnnwMHxJP1xxxnR1Iep9HxcoqS6NccFivb2YsGZ4pXUJc0bRZpRp0jI6YYijkiVN6B9NRD+07J1NBXwjd9t2kvngGG+z/eP4+8xfCoV8GkfWQGn3gLMBBy4yDxfQGYBN9aPuUXpt1+ForBChdN/HFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryCGgTsu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5210684cee6so2951704e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157567; x=1716762367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/u++8bFOJXJXg3s1d2RW1md24+mQv56EN7QzDG+NR8=;
        b=ryCGgTsuOUTdkBrl9p7C+iqK+AcY3GH2T+wtsmwjxR26BJrjxJlqHXLnksikmb1i8m
         Ucy3quwRcq0Br+w/+KTCINqki18KnmzJTJzMI0MQQuz1/Nq3GOyKhlBV/xGbZ+ciGFmX
         klz+4pqr2xxrsWIUTyhOwMeDsOPeV7mt6No4qSWeNgoJtIOyshvqGG3jdTpF1VH306P8
         o2ThfRSQBD5Y0p6Uq1ROUsF3dWdp5C3cfZtURb4zTOZIDwKGDSRkDGKuUKgdPx6MfsQb
         w4n0xcEvSCQD7mlBfnUhzioV5tgbIPdHKq8pFm6qbSWLBTFKqcU1plJ0cWkqBXUuzM3E
         qbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157567; x=1716762367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/u++8bFOJXJXg3s1d2RW1md24+mQv56EN7QzDG+NR8=;
        b=vYhk8OTgX00NQNKtGhSKDzMyNnnayxoyPwEd2aXvj6//225tv6g/UlbbA4e9fyAVX8
         IclRUQgM7SujHr18kWZm5HpQizP8U7uWZ0DaFe4dj1Swe0evlDaOEvMQpgs48ziAzEAz
         h/1vlre9Vcp0LmkvYJg4mi4VLYVUFL0ZghXmDM2fRA04u2KGpKGLO/5TAZiiOHphJWpM
         lb8aav6f7sgVbJG/0ltinUQ2o7MAoHtPt1vgOYtKWPbTbDl3bLntDcjyVEkmlOxyB3Km
         sbuj/dNVVwCNP+3dW0zWreon/M+S2vm0eEPmxEwXWwPivNjKTNs2PEPEq06kyo4Rtr08
         rEtA==
X-Forwarded-Encrypted: i=1; AJvYcCUv+iKJbqSsn5cmiioZb1ynuiA/Pu5LyC5PP37KF3TN9XbKZtGTeDxlrcvyv/P5oyVB7xV/ASW/bsmLIksBLQTWgkuDK3Urtl4l5YMd
X-Gm-Message-State: AOJu0Yxzrs7YfkVkyNXr5gViE+L7DC/VQoDksutKbaapZA874yAoQu+J
	4wWa1H4qywLG7bSNaj769zrQsEJWXgCUNYIqQKQhiDpnMU0b1h8Zbcqu0zywqik=
X-Google-Smtp-Source: AGHT+IGQia4SqEUkbwCkX709KmSNyhDWioQI0WkTu6egjizDz5WsQ+KjK82NteBuNryfZ5+wqhg5hA==
X-Received: by 2002:a19:914e:0:b0:51e:543c:a45d with SMTP id 2adb3069b0e04-5220fb6afd8mr16210701e87.20.1716157566952;
        Sun, 19 May 2024 15:26:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3418sm4047465e87.152.2024.05.19.15.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:26:06 -0700 (PDT)
Date: Mon, 20 May 2024 01:26:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] drm/panel: boe-tv101wum-nl6: If prepare fails,
 disable GPIO before regulators
Message-ID: <mge77nka7mh3nslbaoxpecnbmukv2z2rjk4rqpqo4r6nxo2733@nrhdblvxajuk>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.2.Ieac346cd0f1606948ba39ceea06b55359fe972b6@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.2.Ieac346cd0f1606948ba39ceea06b55359fe972b6@changeid>

On Fri, May 17, 2024 at 02:36:37PM -0700, Douglas Anderson wrote:
> The enable GPIO should clearly be set low before turning off
> regulators. That matches both the inverse order that things were
> enabled and also the order in unprepare().
> 
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

