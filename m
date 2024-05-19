Return-Path: <linux-kernel+bounces-183296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A088C974C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622E828120B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CE371745;
	Sun, 19 May 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7lNp5g0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262B6BFD4
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157682; cv=none; b=FKLk1PdRkMTPCPkWZef9qf9uU/as/0dtumEQONdUuU6QIdYqGD937GyrPGGKXCsJopTaym0ajlNh+Gjt3Wwwk/wzO2+wHHJxQKnBb92fMGvo057kOs5AzOjBOUjX7YoVMZ8fAfU8206Y8TV//z6arvfYBjPNrz1qagIoDeBwT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157682; c=relaxed/simple;
	bh=xWzZahK1fJ0VnDkxKLn/8pVhsSctmeuFlgGFw70yuS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubRrzcVjBi8U2hiqWPiD5kkGP6K6VKLwRFgrXsSXbeBW+NPEXlbxLe7on/+FMsM2S7/6qSKTMaVgtxRUDl362UF02nRImtq+yi4hTw0JZylvShVvvZoewDMrzuvgRZgoe2G26ksE+a+8OYF7IRaQZQb2u2bzmdz7Kq+6lIlGcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7lNp5g0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso4855978e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157679; x=1716762479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXDdcRRTfODpXRQ/anh1Jb88k/SxpaOdAv6cFEMztOs=;
        b=n7lNp5g0PL2RDJJ7y/QgqdEwK1cSU0igTQstergj0mqb8dbSmf+hdxsT5sMSQPmaHI
         qH0/cz/+ZCazLHcwBcOmKJnuTdRnXNpwQBuzreTwxnIz7a8Kwx2TKqcX+60ioJCp6hY6
         CHDkr9C3urCos/uy9xqIlj1+LCrVbQB6oaAEDk1sJsD5YsO7jkMr8gvpduiH/fgsAz+2
         56muH6EI8NRitPx1R9UyK8SeIwuVZfhoE5Kxh8ylnxj5PqDwIA9LCZl4///0n8FD9AKf
         WLAK2CpmNEMf/jLrghejzFAVZYOPPg1odzo/zFDw6hYNMEzjDcVwPLojcbhQNlLsxvNW
         zrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157679; x=1716762479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXDdcRRTfODpXRQ/anh1Jb88k/SxpaOdAv6cFEMztOs=;
        b=DU735mFthUZ3G0B5KeBLfWBAixybaGtBfFlOp3rCBTAoRpMRwIVhkUgrHsM/2WYyBR
         YGYQoIHVjHdicc4Yl+xcD0Q+q8YZV4p4Rykhr/nlCZFDMJFRkH8DE4vyKIZGukFvkb0K
         4wb6dbTmmYQlsN+xxN8ZbrjPtuPME//H4ULap6IhF5HI3sIrBCeFkqGW0/zmoVj2i4Il
         RBwJMw0LOpbo1bDwLXT1v4WF2OG5TuwHi0Hev/DDGPfNiCUGnGHh8yV0CJkny2BQtwfp
         ebq4jfcDIdt6SOmWEYMRsDzV11OvCylKPbxzmx275Z7dWRRgqt4u2/KO8ReRMdM0ZJkz
         cvoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnWfTbVGMCgCvytG3lfaN69h68YsqIxiTw4gWOsBl5eL68Ng+ijAUmt2tp3XOb3W3vSVV34UYapWm1pKn3sdnbkQCQLAbcgF1lqken
X-Gm-Message-State: AOJu0YxK3twjSemXRSS4vVtNc9IyiVQa4ut3+WY3t1b4T6eaPcA/l96y
	g9boLYHnTpGMwrbDJdOrkJ6D2gT1NaVFN3iHpJZTs4Ow6UYADPDMLKq9bPup2YE=
X-Google-Smtp-Source: AGHT+IEntu5zdsMbV+cV0OiaWajiTtFHQuKXfMaceEgIpZ35ws2Sx+nESoMa4dAIjfwGFUbrTAkKyw==
X-Received: by 2002:a05:6512:2204:b0:51a:c2ec:72f9 with SMTP id 2adb3069b0e04-5221016e7b2mr20491321e87.49.1716157679456;
        Sun, 19 May 2024 15:27:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-523b261ad51sm1465981e87.224.2024.05.19.15.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:27:59 -0700 (PDT)
Date: Mon, 20 May 2024 01:27:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] drm/panel: himax-hx83102: Check for errors on the
 NOP in prepare()
Message-ID: <pdq7u4cuptuhnugbn2tqxddg663ngqy5udmngpshh5sqvtavnn@sd3wnjxruflz>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.7.I3fae28745bf2cacd8dac04d7a06daea50e233f46@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.7.I3fae28745bf2cacd8dac04d7a06daea50e233f46@changeid>

On Fri, May 17, 2024 at 02:36:42PM -0700, Douglas Anderson wrote:
> The mipi_dsi_dcs_nop() function returns an error but we weren't
> checking it in hx83102_prepare(). Add a check. This is highly unlikely
> to matter in practice. If the NOP failed then likely later MIPI
> commands would fail too.
> 
> Found by code inspection.
> 
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

