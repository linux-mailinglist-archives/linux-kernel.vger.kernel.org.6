Return-Path: <linux-kernel+bounces-208623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11524902768
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5E0B2BCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C801147C74;
	Mon, 10 Jun 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEmR3EIJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6F14658E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038043; cv=none; b=bgkNSUYfmuaT6/fiFD9vAk+kkdKKIwaDsrwemWTFSi/d/nFKltFHjgMxiPc0sFeAqs+YLwh/YniM7zX+iu+qtrtiw9UOlLP/g1GnB95XamqYqlsGs7E0IhyREDPm/S2Ax4hcjP9jdEpKlOgpU9IBDOjbLWMGAsxp4rn4YKTgv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038043; c=relaxed/simple;
	bh=4Hj9IG1LMlzHH3A3y0qYTvhcNtKcDqLmxJ6EzjUt+qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PABKVWyoPRzn63oZeP5jz+rL2bmQdRDBK8ise98Fb3eAFVR+unIBRI3xNuOtVTrQ1oFOnrgCtA7dwW5LCRmliycdOFp6bZmt7YsEJJy81p9donBBT/XsUQwcOxGW6n6MgDF7tlcfijGPBizoX8D7lsOSBewGIJaEne9JBIck1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEmR3EIJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-704261a1f67so156028b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718038041; x=1718642841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GltpCEOROqdEZtPzqZDYIjfn931I+xP8uUPheSuWph8=;
        b=CEmR3EIJ4PoH1DfyHnjBX5hNlJ9uYuGFk88XT3SmMao9uI6Yhe9HXqP6qybWOG58NH
         fnhSlY5S46dpm4rzVDVm+NMbaXkIcTPyznOTFHXaTX/ofyA6DreOeUZInOV3JlCdgWyg
         2WGbd+J+2ugZEXDzReyiifJU272zUmi2XbvSaQR5tIO9ihLHh/2Qfybd5K0U8QqUk0P7
         PI5fL5kHL9laNZZkQq+hMaea4cWSyZGw1lBGGt5tL3pn7YOzZVCYBvk9YpYhEjH43uSW
         ++THTrMQ0oFbUjDDKsaGL1knxZCPu6MWHYQDHqec5YBNdnqyxAhH+IawtAoFdcCfP+Aw
         sEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718038041; x=1718642841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GltpCEOROqdEZtPzqZDYIjfn931I+xP8uUPheSuWph8=;
        b=gp3Zb3Rdr4Ra+3SVQFghrON7gua6BPPHNFcdUqLEljR+TVODsmA5Mni/Nbz71hsfRz
         eu2H1fJHBO+Ih0E0vsFKBEhCOQjiZ/J1PfYAIF6Dald0yhKsW6iLvnPY+aD8Mv0YqlK8
         hLM7CU4KJHpw5pnm+bANl57Uuia8HdUdXlVmEUkVY8HSEi/my+CHJbULwAOlG9skez+r
         9jBO3Wcg8qTE+ze5qFXdmkoaLHyWjsxmhP4esC+bQKY4s62dIBs1qNi8oVW/BUGh+ue4
         RqUN7UgAwv/LeWWnDlAbP6aahOAo3KDyJk/MDMSfFuCJnosR49PCnXtlMLG9Fg3EgkKX
         wD5w==
X-Forwarded-Encrypted: i=1; AJvYcCVePgDDnOvdPsNBPzvIUTs0cqNu0i6Eo4AS4RltJjBJDLJj60lmq3FKgbjKlvBQ+Kdn9lKaOFbkS0YS/FcUPMY3jGeNYE1y46LriYlO
X-Gm-Message-State: AOJu0YyiktO2lGYx9kyDXvgBwS2Gavsekr6CPi6xJXLoDnfVGSJ3+XdI
	ee+uaIVOT5KEbA1s9uEMBtuN8U9mBd3u4/ItpVdcDNffuFKDxzqHMEa76xi7Jjs=
X-Google-Smtp-Source: AGHT+IGb/lXCCC+JbIDGUdr375qb0RgEL7LsqGDkkx+quxB1SnI5zlcCI8SeIz3Y9Zc+WyklRsuyOQ==
X-Received: by 2002:a05:6a00:8506:b0:704:25de:f297 with SMTP id d2e1a72fcca58-70425def3f2mr4676511b3a.29.1718038041356;
        Mon, 10 Jun 2024 09:47:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9b34:fecc:a6c:e2bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70426cc74f3sm4045691b3a.35.2024.06.10.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:47:20 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:47:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Adjust phandle parsing issue
 while remapping optional addresses in imx_rproc_addr_init()
Message-ID: <ZmcuFRfjKRQG9OXI@p14s>
References: <20240606075204.12354-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606075204.12354-1-amishin@t-argos.ru>

On Thu, Jun 06, 2024 at 10:52:04AM +0300, Aleksandr Mishin wrote:
> In imx_rproc_addr_init() "nph = of_count_phandle_with_args()" just counts
> number of phandles. But phandles may be empty. So of_parse_phandle() in
> the parsing loop (0 < a < nph) may return NULL which is later dereferenced.
> Adjust this issue by adding NULL-return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/remoteproc/imx_rproc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 5a3fb902acc9..39eacd90af14 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -726,6 +726,8 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		struct resource res;
>  
>  		node = of_parse_phandle(np, "memory-region", a);
> +		if (!node)

You're missing an "of_node_put()" before continuing.

> +			continue;
>  		/* Not map vdevbuffer, vdevring region */
>  		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
>  			of_node_put(node);
> -- 
> 2.30.2
> 
> 

