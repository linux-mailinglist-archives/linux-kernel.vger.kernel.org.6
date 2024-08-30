Return-Path: <linux-kernel+bounces-309241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 359259667FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36B6B26385
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05771B3B34;
	Fri, 30 Aug 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z27MDVWy"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900671B29B1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039030; cv=none; b=t+UzMS6GnZ5MLtSIaY1qk8mSFdiwMFa6EEOBrAaGZqN8Ezm/pUDxJZxc8MCI8dGkEnlH2RFNDxVmP6Qsoy2aABOpI/0Bbo9HGGpHjo45eEzEl0CXkqy1sZe90H8fpSFPOF3NKBqCt+DexTjn975IeBzCntunI5H8u+mz262amzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039030; c=relaxed/simple;
	bh=t/gX8TghUNFhH+xAeofIx+megOyf+QWmN40xrmErq20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqQVzen7Px/N6onvIl3eXt46BPyxFqsfaG2QkeTF+9bJPNsWrbDf09XDNjPNMpVvD8GpHskhKfh8tCx9MzeaTEC/a2CVRYwJ7Yzgbr2p3bNjPKIO7+c9+qiLZ3VuNNgemEDjJ4SUArv3IZWkVyn5GykV1jYPlhKHk9NUoWl0vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z27MDVWy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso23556691fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725039027; x=1725643827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7kv16siDwfK3cNtrOwlV7JlLqmUs6I0SGZ377RNGlI=;
        b=Z27MDVWyo9N7ZcHp4hdWHl2DIZk5bFXOuJLa/UODzZGDw6hcokQRRI9cnQgPmRF4eH
         TpyJmyo6BlKT/6UA+BTBplDGftsn4YildkhZOgb11XvwQ4ebO2rWY2E5SUhR0ZCwkB6E
         iknQV/wVynJFPuE5/W5mu5hh9tdi0Jm6T0FW5/nSk1estX4DEkV4M1BCTcLIPT76XeM4
         GGsetDUl+qYyDwn50RQmZlOnRrfSiZ3SjuYE/pDGJy3nDtaoV1B8AxPVQM/ZUFv9gTPw
         ZRed6/C7gQ0lirySxKNzetU/pjFxLmeRxQ6eYKs6UELhm/kAgKGY27F4pVAx6vr16lfR
         Dq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039027; x=1725643827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7kv16siDwfK3cNtrOwlV7JlLqmUs6I0SGZ377RNGlI=;
        b=GYlEu6AaZ/Pcc5GdhHP3QwmKQQQz9E7cydS16S2mH0xD28OPkLkyUcX+GVtCq2iZZU
         7BV+8SrmoUD7CPZP5q41sWon/VTA8fyO7zZiuxrq4SFf/pIbAawDYgepaIVu4opA7wnE
         EpmdgReJnVxpBvcUPwrI/OceI6qAr/iqfovr0k8ZpUEA8YnfplGlQBuQChY+TXvjSQOY
         MYsImXjpZwSXLbmldIDT17jzfgXePsrIleUs2xO8+eBCKeFeYpNWHKHidxxO+eai1rdv
         8bvdNeSjVMxpsRfUxpWkEvy78qaAYuf9AuE8xDP8M4uH9f5hZrHl8avQ5HSeJOgNE12i
         d0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD1sxZK8Ye390Bm4cccXstkN9XMcL8R2SGqQ5r5Q9xbHqkA4MkcWzKI9QwpVUGgSFrnLN4QhstgZ9e2Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnWGyPEZwz0+Ji8MHZoHZzJqdQdEWRgCa+WzM4JebTor+sV2W
	USNrWzn7ucvDzYG3qCYMfZl+JrrJyd/ombAxyavfvZabD9EeuERqvNY0t/PdEog=
X-Google-Smtp-Source: AGHT+IED4Psr1BL432CC60H3RvrsjHLW0W4GmeFM8QN3szVFGBfiw71vi/Kp/pEwJCAsMWry57rj4A==
X-Received: by 2002:a2e:4a01:0:b0:2f3:ee44:c6de with SMTP id 38308e7fff4ca-2f6103f6589mr41983431fa.27.1725039026198;
        Fri, 30 Aug 2024 10:30:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614eff4a9sm7634651fa.31.2024.08.30.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:30:25 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:30:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH 17/21] drm/msm/dpu: Adjust writeback phys encoder setup
 for CWB
Message-ID: <v24nclowcrwmomhh6rszv4qbz4ydjf55f5llaoltzoh32wf7u6@dpxcmoz7rumr>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
 <20240829-concurrent-wb-v1-17-502b16ae2ebb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-concurrent-wb-v1-17-502b16ae2ebb@quicinc.com>

On Thu, Aug 29, 2024 at 01:48:38PM GMT, Jessica Zhang wrote:
> Adjust QoS remapper, OT limit, and CDP parameters to account for
> concurrent writeback
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

