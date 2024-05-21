Return-Path: <linux-kernel+bounces-185237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973038CB281
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9D51C2157A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566F482D0;
	Tue, 21 May 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv/bR4xK"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D528DA0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310428; cv=none; b=uCL8RJNolCyhnRnaj9UBayIdysmF9CJ/SwNpg9xoC5cL7FQ6bSlcFshHQFLy4oe/R2uTIRWqu5pNGVJssf9iJTR6NuHC8qVFx9bw7j1F3RP4NmBbzVc1Vkk2Lfd9kw+WE7W58ds/uIU5Z5Q7npqunmwHlaeKl0pujun02f0n+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310428; c=relaxed/simple;
	bh=XmDn6eN0uzf15c6j3/qpL6cU4Y/ehn314rlUK05MXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN3Z4NVrJVJrb4+x4Er+3sYofb+e+g7XG5/4vDDEW3+ERiabwQsHewxNK10aXL+3Y4l41Xa8f6CIH33eypxhdm7iga69ziFgx+TSshzYgS1yV+iGji3ENG7pLM5cPBM4kFDZZOv/mEFQ/hOKED946DRJFJh5prMW1u3A9NiYiYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lv/bR4xK; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso503337b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716310425; x=1716915225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1mM1g0xrjA2+TMpOMuz+nMei8rdJzFNTaJUyTE9ff1o=;
        b=lv/bR4xKd0F/fSIjQI9jztJob1jRijjPHTQNQ+J8uzpy9FlAaumUhV0YxSkk21MbiN
         jXqbZk+RzrX3w3tIZi+hHgwskvqHmJQs47XUhNRCeb3XlyFHjFk87S8SWkN1rmnZlNhd
         ZJiaCDPzKERpGHbLxGgIH60UtmV1LkAGKyFGlUWLjjtpCELp0kwHDpD3Wj7/tc9BTKi4
         AMde0/GpUZEa7lA4HlRHpCFAZuIzhqaETXACvrtcRNVttdcayC1kmFAO9pekAl4XMT1i
         k47KOzAQcwpFUoqssIYXSq76mCzWYZ68uhA3iQi864BdaMJ+NQXtPoSw9ADzwr2crCus
         Nlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310425; x=1716915225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mM1g0xrjA2+TMpOMuz+nMei8rdJzFNTaJUyTE9ff1o=;
        b=ZxmHVkKB56aXx8eMsonr3nqHB1SW2c6KorEemZ+Vzl5SssTQ1R1P65L83VsqVD8dj3
         DKACOWS/X5mPxFICM7o6q/oQosNgs9BmBJD8AC//s5L/kUdkfkRsJRm13pPo5IA2OxQQ
         sdm6rprETngiwj1e+s0LTTPwjTONbLx8Obwiq5V44ZNuwltQuAi4IRWjoc7iOsz6IQa+
         Wk8/ulCyEvWbNMVQC4RYTLcxb0/NRc2Tj9MbcGGVccuQnnk0IGXQv7vz91BD4af3QOcm
         y8BjWqxHDKcKLXsBkaSONnMCBiTIeFgVXfwmo1DnsfR/TuIBpWiwth3bVuRzwCWocxqW
         DD3g==
X-Forwarded-Encrypted: i=1; AJvYcCXj4TV1M5R4pr+f3dPkk8J4+rWRD6jUSXXHp52NH9GMHOljEdBxzmSO5j4vi5Zz3HFz6vwroO/84ByhZBeLwhldREZTZ1Uu/W4fo7dr
X-Gm-Message-State: AOJu0YzFdcLXnhEzMdf7jAEWhSB/AZgU/I9Vtd9TMT7QNaZWKboGKTMo
	4JJdFjNyEHkeSluarFNmTt21BFHXCJhmGrh3IjtvVtgo301eYPQ0+ZXhZr+Rcb4=
X-Google-Smtp-Source: AGHT+IHhV0gEhBAlCrDzmhUFkEADtc9n6dtJk4+JERFEyQ+wIpi754KQsmFo/JDNnXvh6Bc3efJ+Pg==
X-Received: by 2002:a05:6a00:10c9:b0:6f3:f447:5861 with SMTP id d2e1a72fcca58-6f4e026b8f2mr33863693b3a.5.1716310425549;
        Tue, 21 May 2024 09:53:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:df1a:22de:40b2:f110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f80absm21017394a12.65.2024.05.21.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:53:45 -0700 (PDT)
Date: Tue, 21 May 2024 10:53:42 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: char: fix rpmsg_eptdev structure documentation
Message-ID: <ZkzRljZlpCFDOyBx@p14s>
References: <20240517165654.427746-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517165654.427746-1-arnaud.pouliquen@foss.st.com>

On Fri, May 17, 2024 at 06:56:54PM +0200, Arnaud Pouliquen wrote:
> Add missing @ tags for some rpmsg_eptdev structure parameters.
> 
> This fixes warning messages on build:
> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or struct member 'remote_flow_restricted' not described in 'rpmsg_eptdev'
> drivers/rpmsg/rpmsg_char.c:75: warning: Function parameter or struct member 'remote_flow_updated' not described in 'rpmsg_eptdev'
> 
> Fixes: 5550201c0fe2 ("rpmsg: char: Add RPMSG GET/SET FLOWCONTROL IOCTL support")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 1cb8d7474428..98d95ce5b6fb 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -52,8 +52,8 @@ static DEFINE_IDA(rpmsg_minor_ida);
>   * @readq:	wait object for incoming queue
>   * @default_ept: set to channel default endpoint if the default endpoint should be re-used
>   *              on device open to prevent endpoint address update.
> - * remote_flow_restricted: to indicate if the remote has requested for flow to be limited
> - * remote_flow_updated: to indicate if the flow control has been requested
> + * @remote_flow_restricted: to indicate if the remote has requested for flow to be limited
> + * @remote_flow_updated: to indicate if the flow control has been requested

I will apply this patch next week when rc1 comes out.

Thanks,
Mathieu

>   */
>  struct rpmsg_eptdev {
>  	struct device dev;
> -- 
> 2.25.1
> 

