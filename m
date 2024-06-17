Return-Path: <linux-kernel+bounces-217584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D93290B1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5D71F2A4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7301AB90A;
	Mon, 17 Jun 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RSuya5hQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2851A2FCF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631389; cv=none; b=OreFJMQO1EIStxjEP3RbmHgG3a7e5Q6++REEFVqupysBs0S2LWXy3BFZWv7JOuzW8PHSulKeWl14dByxbA2KNw+N6bjJvVu5mEh2ZR9NWWOTsx6rJ3eNwRe23p0TCdFYCmfFt5O/YlBFq0HRzdT1B2WdBcRQl9HQd5gJaWtb0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631389; c=relaxed/simple;
	bh=fkadhAyonb7RymKr0Hwj9qGiWcoaWFoudlddldfbojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhiR/oIfFQf5owtDYySGlvGL4BN+0vp1g3mHIgcVf+GlMv0E6t2XIWXLpMuwB0DLA1yIXTMi3sxJqAbJdqwa7WGu33zVY7lsPJwy4cfyQkQ6qG47P7VxKD8SU3PEHZSiFFkNEPoe2gjGgCVeosJmQ1vHcIn662c3D/X1xaX4yxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RSuya5hQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so36322125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718631385; x=1719236185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FTQb5W5/GJ/Nb4LvauMZmPKUHXtT9dcXAWj/SvSDY=;
        b=RSuya5hQGrSTTwFtuBl6/rYKn0k7rEetc7C6wa05py67lGIzR/fbqmVDhimOcIRaBG
         7RwakKGjGsMaKVOboJFC1+LESpkzRkTnjQwfH378O35qHiWOTFjjAOKkNUFyIFD51xuq
         PvKe5njleoOP0wDETKSDt+r+pkI3CowbJKFegbDGnnyu16ZcPs4UUvMLcdQCj/x3u1S3
         koGIWbpIAQd8CT0x2B7O470E4HLeXjA7XaQ97LZaW7rxx2WIEerzzYf8iSMqFO+c0mkJ
         1wdWiaJTV1Yj/gG26UtsjDtglxY0mWaAw95ta7iRSb5y1xj9/dNB+61jVBGJmhgDlTP5
         0P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631385; x=1719236185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+FTQb5W5/GJ/Nb4LvauMZmPKUHXtT9dcXAWj/SvSDY=;
        b=n7nG7ijQNts+4uwZFK5G0C9f8OzhBHhtxELiyi/JqdcCosvsgd9ExTpZr8fNo5xVkQ
         ZCmMXkj63mBiCMlOmt7fIGGSB15U/DYqUpwd/l6QXcVrXGbovYDBsyMoY7z17RSyZ1MJ
         cdkviFH2AP1zKLfAuf4jczsBSiLE/tcWn8wriHyeuTna4JMxWH0AEx+c1X87mYiNF/f9
         BretmNdkC6eguzZR4cRG/65AZQZX3t4ZXEopWOTmJ1fMOW0NE0XMTAgPrf5jW7ezj3dG
         RwXDm8mWOfkC8o8fEXf3grivikFG/4AzRIqAZi+WNCNuSANWkYn8VjkVTPafWqat5WaQ
         /l+w==
X-Forwarded-Encrypted: i=1; AJvYcCVmUC0KRZqVDActxF3sAuLWVY3WTfxG+I8/G++WQ+mw/z+Vm3/WzMzLGHoiY84mBDiY0okjba6Mv9LTwU7MFCriLID+if/IrRLymOdA
X-Gm-Message-State: AOJu0YxBOV7pwT+NyY5GsbJ64TCXkVyOY8HCBLut4bl61zZ5jWVb3rDE
	xXvadvYxD0YdgFfM7GwMP+KDLde6sj57rJGeah59BqqzF6PiGjRsUxdilxS16zY=
X-Google-Smtp-Source: AGHT+IHgsgd/TPVM+18WkZs2+AeqnSk2SRZRbmmdW0ObBeSJuDLzDBQ2FjqSWprz5A6LjcnamvKJ7w==
X-Received: by 2002:a05:6000:bcc:b0:360:7a01:6afd with SMTP id ffacd0b85a97d-3607a74e760mr6960206f8f.10.1718631385486;
        Mon, 17 Jun 2024 06:36:25 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm12011860f8f.0.2024.06.17.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:36:25 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:36:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <ZnA71MTiaESQTUMp@nanopsycho.orion>
References: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>

Mon, Jun 17, 2024 at 11:34:32AM CEST, dan.carpenter@linaro.org wrote:
>On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
>to do the allocation to prevent this.
>
>Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

