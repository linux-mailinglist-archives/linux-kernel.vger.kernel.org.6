Return-Path: <linux-kernel+bounces-442794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48EB9EE1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A4D2840BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BC220E013;
	Thu, 12 Dec 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7z9/HE6"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A8209F41
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993610; cv=none; b=fLweLz2kyKZ2xDI/T3j5M++WIYsl1QTAqY2AsCVLX1UZv6Z9yuBLKyr8Tqr3h2WBWKrdJf0eQ8pSfn0/R4GYllT/0/H3kXGay3K6wogPMNmwg1cSnQ9Luz0dQa4YZ9f5eTfSn214cHBhGVDwx1NHcPXP0ZgUXhfY25g8UxyyP54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993610; c=relaxed/simple;
	bh=l7D9P9Kwg5KD8ibwobNO/bvD6mQ/LYiV7hTaF7WT6w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtZM3TmEk+OPzmobPRLhzaK/ElD1y4BW7UGpGHrzPrBqrCKfS9b1MJS0e9EfCz5Xw7CyOA3Mq0RAR/hPuPpOk0/z4Gn5yKRAf/NLlyRjz1vJAOgXPLYPAxuQJmq8LfQ6dOssAxW/kQKUX/DLTxZf5d5DjIxR1IJAtH6eGD1LGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7z9/HE6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38637614567so134820f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733993607; x=1734598407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcLl7kFykk32AO5ovfG3u6worF3QF2ZUK1MMUkz/PPs=;
        b=p7z9/HE6LNFyzIKTAcSw1KfQYeR6blILssxoF2xu5nyoJ5VgWyAVRbkCBcmQrhogDE
         uCemsQFQzt5XKUM2cERdm99olp5SV0ngoy5vCwwVqYNttt80NR/muHftz1OFd6g+NJqL
         MnVs/IivmMQ0hIlpfHxC+rQhnrMxA9k2Pq9WFaprdhIt3LeitXN3ILyGTRuxgBhXvUXC
         lB/nv7Dt0PGojx5fcg7hpf++B/09Iwdbt7QOLiDJTNgvzXviPhUNQOKORYbUnHba+gN3
         m12RhpxndEBynHGXffmJeP3MpEEtQRS3BU9+x+LE+v7xuFDJ82SlaP5iawEJ+OYm5Bd9
         96cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993607; x=1734598407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcLl7kFykk32AO5ovfG3u6worF3QF2ZUK1MMUkz/PPs=;
        b=oaqSTpRqlCg/wmEUUIx3fxMjDkTSlYSjRj+0P9dzA7DAoJIboUIJQkDPFISBxd4fpU
         DalXXiTJSTFe/UuDUFHWcqG4xOslLNpj48IjRHNCFQ8x3OtjXMFgrgHnoYnySHINxd/c
         WwYZ57QPZRVH6s/xIFnQDH8ryHeuhwWzd41gAtg+7w7F7bCncTyDbUWhzJqorEZ7E6OP
         ljeZ2Hn2J6WBhRFx8GI/LuJXRFEkA4hMCPD2yEqgF0INYyEwRot9kKt7aKRSRpMXvr7F
         NoMZLIyCak2x11RwpDD7+uU3kfDivpUgM4UbWQ22aTY3/RPoz0hjBqVX91gWhr8WqWUi
         bh8A==
X-Forwarded-Encrypted: i=1; AJvYcCUn6WJOp62TVXsheARrayM78gZZsJB/G53BsRHyldy+HfWTjuq2zFLt3/BITeSNzDhYjge4+nc1Nolkvro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0vrTSLtzmo35tyeOVTHSVAVSxZU/e4fWajkupVFMIRfg8yS6
	M4wKtqIQK2lEdZpErveJd41cjKsZ/yAVUziSTRrNRu3PG+m+ChUZdZ+l+OAvq3g=
X-Gm-Gg: ASbGnct+9HSvuyXU41KE6T+qFTXxtjgTWfqu682dF6aYEaQza5F0XOhi/k9vpP054f7
	PVihMcYTDgyC02ahDm6Vu9a4+DygzeJTZTRsnutEd4slLnOqgc0DEBMLs9nUtDcGuBP+8RbQZs6
	jcTddsIdkD2Aam/gi2/DdcIs1ktP1Uc3+iwCYvy2tz85fzF2CF4jBXwuLgFtJxeC4BEs/k37FaT
	raXYyOQff+gXpauz+jiHlwJmQjVNoSNDz6FVZPAWMDcKeU9ERp017XUUrh2dw==
X-Google-Smtp-Source: AGHT+IH0Mqy7glyRVhSSY/dK6s7PFVlMFUlCIyaLwLxpZzvDpBjrdEeUt+8GQ5R535mo+HypPJLM0A==
X-Received: by 2002:a5d:5887:0:b0:382:5010:c8de with SMTP id ffacd0b85a97d-3864cec5ba6mr3695151f8f.46.1733993606736;
        Thu, 12 Dec 2024 00:53:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e633sm3492675f8f.4.2024.12.12.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:53:26 -0800 (PST)
Date: Thu, 12 Dec 2024 11:53:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/6] drm/log: Introduce a new boot logger to draw the
 kmsg on the screen
Message-ID: <9fef340b-e6a5-42fc-90a3-3323d2b8175d@stanley.mountain>
References: <20241204160014.1171469-1-jfalempe@redhat.com>
 <20241204160014.1171469-3-jfalempe@redhat.com>
 <816f862e-762d-4880-9285-5a803e657e66@stanley.mountain>
 <88abb273-13e3-4969-96c3-c7d677a082d4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88abb273-13e3-4969-96c3-c7d677a082d4@redhat.com>

On Thu, Dec 12, 2024 at 09:49:19AM +0100, Jocelyn Falempe wrote:
> On 12/12/2024 08:41, Dan Carpenter wrote:
> > This patch breaks "make oldconfig" for me.  It just gets into an endless
> > loop of:
> > 
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    Default DRM Client
> >    choice[1-0?]: 0
> >    ...
> > 
> > I don't have to type anything, it just spams that forever.  It's weird
> > that it's 1-0 instead of 0-1.  Does that means something?  I don't know
> > much about Kconfig.
> 
> I can reproduce it with your provided config.
> 
> It looks like it happens if DRM_CLIENT_SELECTION is enabled, but none of the
> client is.
> The attached patch should fix it, can you try it ?
> 

Thanks!

Tested-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


