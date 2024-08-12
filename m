Return-Path: <linux-kernel+bounces-282674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243394E73D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145F1280CED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD115381C;
	Mon, 12 Aug 2024 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5qB7oU8"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1E1509BF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445689; cv=none; b=WbXCsFf14rATRQSYe/7LJIlqGwwvQFiy+M5wWTZczYB79Kpa+rUxqHgYIj3pBQ57MAFm+Q+UBO0NvMOt+5I6dc+26ppZQZzeG2RLJGCa57qtWTJrbr0oM5AdsNffSFY5rvW393N5eZRbdn5fPmp3GHRC2LpbqB23PCQJibcWi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445689; c=relaxed/simple;
	bh=NEQn/jklUKMpYiGlzYQqyXfeUdJDYoPjcB5z+lJTciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho+gqa3r9cjV78T5GK/Bgi6+gmDHwQaX/lQ7GQApvSfwhZBj+Qox0SHGY9QtZn32+vJ3OLCaZEvAmWW0n3HgXLb+I0Wq38YXDoZq1s986QcYtIyYZt3OnGi3qAGvE6Q3MFcpn/4d/72vBnqp9ArXy4ib0wRwA+7sk3fUJ6ED68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5qB7oU8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so4758972a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723445686; x=1724050486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0fQcBx/yhtEJalnoutc2Qp0GWGGUElulCgKYdofD76A=;
        b=u5qB7oU87ldICzdHds6+R4lchb02w7PSjsxqnaYrkglv3YH8VANoczuTsXBAoHrEA0
         XClOvSObYXuD+xbmsy2dx7IRxlHkYRvoedldQHLjW4pzyTIBOo6W6xKDVKC/+zeUGXGX
         GPcUHTwj7FedtrsXB8kkjNEo0XBBW5h/fQVRrQKJDmTMcyGwOgpQuK3p9VTya0YG/TiW
         aODRUjzQ1pI/Xfv6KdtgBQiP1wHGu+ixPEGS5WHleCob91/wgcGCZ7cWjkJE9+MDMEql
         Ra88HnL8+MC1c0s7s5yNLyqlB68bW2TkYaPy5VU6S+tjD8t2knAt6iA8LRSoUQ6Vmnjb
         5ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445686; x=1724050486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fQcBx/yhtEJalnoutc2Qp0GWGGUElulCgKYdofD76A=;
        b=JPohOjDsm/v6oS0yc9gaMcfSxk4o4p8CYgrf0ZHM+MmTpm3n/7mVhcCGHHZJOClx5R
         NJ4g/uHnKu+3sFgoZuZfY2sRNFAIzi9cLMPGjBh7s0W2d9toFxYLIHeaMjl5qPGUSbC1
         yUQzTR0o89Ga42MVZRE40zCv3DiGSVUjvQNOYz3AxFHMdhVcMkiJ3IX6NBaUECkqpSjB
         2K1rdpNKOCygibxjSH1cI8QvZXC3Vq5ElEyWXWZUrpwWAWXxHrt0rrj/s74t8mudMQ3B
         ZiamCSnUucVGhWCy2dYUR3Ic1BDTn+vFJJgseyIX4IIdwI48pAp/MW4jSVpf76uGRxrv
         CHag==
X-Forwarded-Encrypted: i=1; AJvYcCVCqAxjWrdNlsPRKy3z34ej2eXQLrvHBnHRkT3VkVVm9t4vE6yVUgPIff8q/FMdQ46sZvfgS33aqphnRGZr7CqmvLt1EUXBxn5ARbXr
X-Gm-Message-State: AOJu0YyAqH/oGm4DF5I3PLWfGAb4pdxTOZduaref+KbjTBktGcU5N99w
	Kvc8hmYC9FsD5MP+1m6Y+ClozJgToa5c6OCp2J2J0wIzAVQhKGy8mgLFSWiXDGU=
X-Google-Smtp-Source: AGHT+IHqItAaYkq1CnYLYCG46rQAAVYiJweMtHCZU5ynOtcYUTt5FmVrj2hFnIpnEigVtDeRa1vwUg==
X-Received: by 2002:a17:907:72d0:b0:a7a:9226:6511 with SMTP id a640c23a62f3a-a80aa5d9ae5mr688705066b.31.1723445685533;
        Sun, 11 Aug 2024 23:54:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0904f5sm207822166b.18.2024.08.11.23.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:54:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:54:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] drm/ast: astdp: fix loop timeout check
Message-ID: <10624c71-d134-441f-a7e6-d757b60f54f8@stanley.mountain>
References: <9dbd4d2c-0757-4d5f-aa11-7d9e665e7633@stanley.mountain>
 <8c1ad0a1-bbc5-4274-bdf5-fcf2e043a869@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c1ad0a1-bbc5-4274-bdf5-fcf2e043a869@suse.de>

On Mon, Aug 12, 2024 at 08:48:16AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.08.24 um 08:42 schrieb Dan Carpenter:
> > This code has an issue because it loops until "i" is set to UINT_MAX but
> > the test for failure assumes that "i" is set to zero.  The result is that
> > it will only print an error message if we succeed on the very last try.
> > Reformat the loop to count forwards instead of backwards.
> > 
> > Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: In version one, I introduced a bug where it would msleep(100) after failure
> >      and that is a pointless thing to do.  Also change the loop to a for loop.
> > ---
> >   drivers/gpu/drm/ast/ast_dp.c | 12 +++++-------
> >   1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> > index 5d07678b502c..9bc21dd6a54d 100644
> > --- a/drivers/gpu/drm/ast/ast_dp.c
> > +++ b/drivers/gpu/drm/ast/ast_dp.c
> > @@ -146,18 +146,16 @@ void ast_dp_power_on_off(struct drm_device *dev, bool on)
> >   void ast_dp_link_training(struct ast_device *ast)
> >   {
> >   	struct drm_device *dev = &ast->base;
> > -	unsigned int i = 10;
> > +	int i;
> > -	while (i--) {
> > +	for (i = 0; i < 10; i++) {
> >   		u8 vgacrdc = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdc);
> >   		if (vgacrdc & AST_IO_VGACRDC_LINK_SUCCESS)
> > -			break;
> > -		if (i)
> > -			msleep(100);
> > +			return;
> > +		msleep(100);
> 
> But we don't want to wait during the final iteration of this loop. If you
> want to use the for loop, it should be something like
> 
> for (i= 0; i < 10; ++i) {
> 
>     if (i)
>       msleep(100)
> 
>     // now test vgacrdc
> }
> 
> Best regards
> Thomas

I feel like if we really hit this failure path then we won't care about the
tenth msleep().  I can resend if you want, but I'd prefer to just leave it.

regards,
dan carpenter


