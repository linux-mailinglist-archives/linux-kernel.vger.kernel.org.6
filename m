Return-Path: <linux-kernel+bounces-225370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E622912FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69FD1F252CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2317C231;
	Fri, 21 Jun 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuALIoNl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D4208C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719006280; cv=none; b=eMYyU64yzM0/5fQJL9LTlfuYjemFBBcEgeNUgoRB9GUFCrnA1CT2xwR1goJndAI8vSmxl9qjNugSaggDT5iZTeC2jkxpJrzN76WKzjMcsJ17C4qx+zIqT+MPuT8HSbV57w4a9/vRJxdA0vsEbvuRjh/9/fwWVM2hgJbe1J+Ax/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719006280; c=relaxed/simple;
	bh=tcu4ngi27FvyBPGcjEAz1+16ucBwSxInwJOXk1JJg/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ypb5x9LZBh+X7P6NwvRGtdUBrGHYxgs+fzUqxmnO18OPecpqXdfYaFTxH6REMYU3hi9AyBP1NYo8w7WXFsG0eIPmqWeVemi4OpedoKIZZ7UYmskzzZrYf/umpezqIlM9GgGf8teIEN9EDsHZKnpB+zA6SnyVi6HSqDrVggmZ8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuALIoNl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cd628f21cso1251154e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719006277; x=1719611077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uqrF3+ai/cjb9cIpwJW8lMs7SIa0ZkESmSmmWesSvE=;
        b=QuALIoNl2gzj555HFPppBd1cN0q3dn3Fgv1x2hWU0Z1BHEtNrhpQgqCwC0WLEfIAJe
         /V73BtwpIsh84L1B9fw7WMcvmoaXrZvZyQf52GJ9a5k+g3BQiFtAwt0Hoily+X7/vzkH
         B6WJ9EqgXFoMWsdpYTXFqsBgYLwOkw6XNUE3NoQE3QARBexUFPW5FZnuePJcTcS7RO2v
         8wAEWg+B/MqEVucdMby/rjLNPokyQsWPXssTlQEfx5yzPPp/cl0tCo+AJ+7ik2PF8g1h
         ptcF/JfxxWBqXQ7zykKyJwT0IlM9bkt77O0cdNhFbK5Nl4OxM19jmpNYCIR9WUgLSOum
         8RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719006277; x=1719611077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uqrF3+ai/cjb9cIpwJW8lMs7SIa0ZkESmSmmWesSvE=;
        b=BWJNipumNdN31VxVYei5wt2BupyaByxMCBI4ZrYAfkOBMYcVGyRlCJ/qaP0I33x4oi
         f0cIXV8CNvaB1Huwi4gOh4/rgVOkcUKIrnA1Ea0UtghRqVCuzkXid8FOUH2cULliKhmE
         nlMVPu4Lal6PDAiZMwrzHrenP6nHlklDGerasPnR3g0YPnk6tvHBw5Vu64fnlzXhG84P
         HKsAYrI1a6VvOxpvySiVIhs4iBSHVNUHtybZarOKoeUEaVNVqehA6WtUHRCe71VmLlj+
         qlJvySxkYE8CQvOoSbWOU/QGQFGMe6p3BnegLRbbpcPrs8X3GTJtdu4Z6OOJqUAW9Iz4
         bS5g==
X-Forwarded-Encrypted: i=1; AJvYcCWNRAebeUM1JmhAB6Kscz5E2aFzdxuWJk0GYL5HTvcTH/c+tptmrbRbGskgS/qMc9YOUJbGjzKlwFpDmzvTpV2z9pZugAB9tBhDuVK+
X-Gm-Message-State: AOJu0Yz4vga1hsRGq/WS0930qQNvODdIqedpmF0xa1BAEkzrlwcCRdNk
	4hmqozTuHSRbywWB9Ti2yy5mCS7b+QKWThOnvlZgiEPJspowAdpDWsL4mgCyNmE=
X-Google-Smtp-Source: AGHT+IFl/V3yW8CJCWsS/UIq8YVxYKhV++rCKzFxbM9PSDfSHyU9d/4C0cWaowOPOYRtgogZXIxAGQ==
X-Received: by 2002:a05:6512:3b90:b0:52c:cb77:2b8 with SMTP id 2adb3069b0e04-52ccb7702eamr6425124e87.5.1719006276605;
        Fri, 21 Jun 2024 14:44:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd7079478sm300520e87.153.2024.06.21.14.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:44:36 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:44:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel: ltk050h3146w: add check for
 mipi_dsi_dcs_enter_sleep_mode
Message-ID: <znfhystpy6litynlgdgvc5h2plgbirec6ykkv64y3kb57lan4a@tuazxhuszpus>
References: <20240620074720.852495-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620074720.852495-1-nichen@iscas.ac.cn>

On Thu, Jun 20, 2024 at 03:47:20PM GMT, Chen Ni wrote:
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 6ea4383b9214 ("drm/panel: add panel driver for Leadtek LTK050H3146W")


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

