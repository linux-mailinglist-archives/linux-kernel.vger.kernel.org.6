Return-Path: <linux-kernel+bounces-183606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11DC8C9B46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0C1F22F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A350A6A;
	Mon, 20 May 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTBY7NOn"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD94F5E6
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200956; cv=none; b=R3YZg5HEa81idK59SnqmYIVqMVswEhMPAxFE9vZi4z9NtGuZe12fBdvybpzFBU9sGgm2Obb7c7Q9f1MdgwwiB4mZgjWphGrlnhEJckobxKzizkexPk8RZiQexpVK1Hc3EuShLDUTLIVGxo54XsZNNjSk1CmYkYCbEhTuqBuvVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200956; c=relaxed/simple;
	bh=w2v+Tu34CMn7RKVYb55dqY247JQr2d92gD+z+UlCjOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCmNuITCbspKR1U1BrlcVhfD1MAce7da6Ikn+D/aWNH/TkUmi8K+8jhL6kdyFES8XIJKLFPJHZZF4I9HvCz++vOE9aWB9w+X6aRjj17yfEDu+hD4hznsL1AmqMsAfYYvzBmhsNwpmTp3agKLpnDIyhdgkKpkk7wUFgpv54TNdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DTBY7NOn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52389c1308dso3399398e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716200951; x=1716805751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5BgnpxvIdvwCUBBX92qJk66NJ04cMwQMD5QktP8CYA=;
        b=DTBY7NOnJxKRUw6I3XYcOttLl/M+TCdOKfTfnsenrf3CWER467UhAsTmrtVYkMLZ9J
         P4Gii10ZWV/oyU9/8BvMXv/cE6IPWsBLXCsg+ioQCwq7EALqV5b9/iIX1OCUzJkHEECa
         TNe2d9LuJ8IOo3IJP9KuHI9HC/eGvBQfloHRxRvRtFYeyDJ6xLb5uqcoE7L9C3tj6WUf
         KM9eBbexDaVwcooLrR5c4/hCDhoG2efeJe+By7/vTKA98MEOhjMItppKP/3XH/zQOdhv
         k2naSeL0r6m16LEReEHgT5IPZ5gCNEUq2N+NKM2VmtmE7WBwjrfXXzd280roa4JAsKOA
         ssOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716200951; x=1716805751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5BgnpxvIdvwCUBBX92qJk66NJ04cMwQMD5QktP8CYA=;
        b=wTWt/qF+Z/5byokeQ3rJPnrEAY2cFQijHr5FK28GKYCaFEeun7kqjjl92z1QiX3s3Z
         /QCYrs0fAWB4SM1OFJKfKIyWqudYsIy48cMC6G4dDi+F6djOLJ2VXnr/WQ7FMAJS+hvE
         hrnPRwdZyzsYiR9l/gusv8sHP5SnEWM6MHiNQ8T5GdchM9GSrzF1cs7M57t878j+QsBV
         gMkEnmNo7nLiYGppjUWPlyVUrZFcqvIHOnTsjmCaGX2sD20gFzEN49Spf/0MfOSlh6WB
         UhaJTrBP3x4sDiSLpbMVc3aQKSzjJdoRUxfU6Jbtyx5i0Kg1xMuixLeoyuRrOrMIxTfE
         OHdw==
X-Forwarded-Encrypted: i=1; AJvYcCXSiJfezB/uerUd11k29uuYZxE4HWvleSV20FkJpXNXuYazdHQRAAC0M/kZEg4YI/J/ZyDAZMq+kvpHXrxdYtlOrq1/9mKN1h3UFcOp
X-Gm-Message-State: AOJu0YyTULwW0FgJOiUUkDw8ze5aHUNjdtwyAwjLyTPXXkvStNTa1gtU
	3VXxE5Mde9prm0CUXkuNH7mmlD0bh46E2DBIw1dsBSNL40FRzLM2iuakqX+uOuE=
X-Google-Smtp-Source: AGHT+IHbw7vdPZW/Q/3B127sO5ThFAPWGOkk69KJmFFZ4bAg3sJj0kVFt4UGPkQjZh5b3l81NcjHxw==
X-Received: by 2002:a05:6512:459:b0:516:d0e3:9275 with SMTP id 2adb3069b0e04-5220fc735e5mr16898943e87.11.1716200951305;
        Mon, 20 May 2024 03:29:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33dfsm4221651e87.139.2024.05.20.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:29:10 -0700 (PDT)
Date: Mon, 20 May 2024 13:29:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Caleb Connolly <caleb@connolly.tech>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panel: lg-sw43408: Fix an error handling path in
 sw43408_probe()
Message-ID: <e7dvsrbaaltfqncnlxh7fp27ffkaeylpsih45lzfsawz3vdqih@btzvr72epgrp>
References: <b8dfafaf1516b33dfc21e9ad27e31fe2a5820a5c.1716197626.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8dfafaf1516b33dfc21e9ad27e31fe2a5820a5c.1716197626.git.christophe.jaillet@wanadoo.fr>

On Mon, May 20, 2024 at 11:34:31AM +0200, Christophe JAILLET wrote:
> If mipi_dsi_attach() fails, we must undo the drm_panel_add() call hidden in
> sw43408_add(), as already done in the remove function.
> 
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

