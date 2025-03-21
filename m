Return-Path: <linux-kernel+bounces-571081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889AA6B8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D85919C5DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141F21B9E3;
	Fri, 21 Mar 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QqJ5IXTz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7EB78F5B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553347; cv=none; b=enlND1yO7xmahOnPoaTzg5HZYQCFmGbMZUPDzF8oGPrLeTU9lYCJSY+doTFs7HLCqO6V4Pi+Zu3dDStFj/G/p+6/XxQibCtggpyDnQd6IQw9ETbJVAdRGbaZIHni8J2y0EtWkZYp4PIiO/wEF8Zfh66+ls2bFd71S13juFrQ+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553347; c=relaxed/simple;
	bh=UFU0KTT+0ZXUZfo4jTJqt/1srLaMuyKRdeW9iHScmXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA0vhZV+fYHZ6hiDYPORGEILyEp5CuHPAFR6gh9A4Ge31nWgoFVJ11pfgiUTyhBt6j47TO5sHEtyTUTzZAaFKZXjsXKuVTxcEL0JfOzKvue5O9EbWj11gFEsI2OoY7Ka9ruuzF2uNLIGdCXKWVlGT2aLiP6sC03ZEyb3wj2MHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=QqJ5IXTz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf848528aso15068875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1742553344; x=1743158144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Kfp6sALNxTTtUe+bIHaZwZakvZcPmpmO3uXVTBrCw=;
        b=QqJ5IXTzwMmdv1+3WjARdrwOOi1wYxIc5Ya8McNBP+MX83XutWB3x0j6FFaG20ML8A
         5uv3o2zIIGBSzbl9dTLGgD1E6HJ1i94TgyULMkx18y0IAH8fW0EI7Tetfi3aJ8Yckj7r
         Gw7/PCtDSqPgCnjaYFD41Hd2pJDanGhaeVsX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742553344; x=1743158144;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3Kfp6sALNxTTtUe+bIHaZwZakvZcPmpmO3uXVTBrCw=;
        b=aG5few2pPSsCwW9EeFPJIV9prVEnAhEK5GfyekK+d48tX3zkeMqvJ3LJQXKSSDesHk
         zCP3rF4GVWTE3fzRgC6jW+jI8wBQFQEptf7Lt6oB/Dfdbx7y0l8NhaP7qK2UxCBHCj4M
         mamRp4bSs3ip0NS4gwFEMwa2VVWynbYvHCzk7+5hmQphA7mPIsEODoqUVvt4OOsn1IA3
         wCittn3jgZ+baNimGwpJMF6Rut+LxE8WBNl+W78QFhPfNR9nfj7maHeGuqkNEKK79YGB
         xMAe+0S4X26DiSXENqdXI0xFoJ+nFzLWaw0ZowSKdZelBpCOO6ntQFjPI87n6uZwbP1y
         pr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtl1Kd6o6F3QXYtVy1Qso/eiOE5Z2YIOwE3yWUyVsDf8AwpZsYcj6uJKQrpkFbwNPA6uPwpFwAtvyZBpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTGmgM+hNMnTxzD7QUR4Djcbdpceipox+x8+wSJQ7defF/Suz
	+zlTtLEI7DOwx+OWz6hVHWWSalW6zwl7V0t4X6MFROwwBLR14xeDBwjIxYYsgsE=
X-Gm-Gg: ASbGnctZWx/yfmU3fvu9u5dNHwfeq4jK6KET1LGc2i2Y3GCr/9wD9mqsyAvyhpXWgHw
	CBaPsk8Agjw+wrjh3oDDTRjWdaaJ/5vqStnYAJesp8GvNyKZtuyxgKN5h4is+rb+E7/w6avuCdk
	1Fh4JxOJc4FfofkUYaLTxB8dgyqKb84wWnwz96cZZhzP34DTGl1A3Nwf38Fte5rmTDl4Xs5whBu
	FveN6TMj085DDWgts3IzgxXPH8ygTy3nPDAcgl2KeEVd2cgYRgH9zqRLnDPBPvlq1ocUG1veZMB
	E5a+JcD18pv8+f2FE7xbh1AHbk1jlYftkco+0Vp2DOlKu4xXm0twpjYN
X-Google-Smtp-Source: AGHT+IGdgqrnktS88HQx0VeXm5vsHxDPIPUGT/Sqr6rq09y+ynhAfmQF/0b/+MUc3ZwiGzOBD/Pjgw==
X-Received: by 2002:a05:600c:3c9b:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-43d50a361f8mr15516775e9.27.1742553343656;
        Fri, 21 Mar 2025 03:35:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eff79sm2000820f8f.95.2025.03.21.03.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:35:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:35:40 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z91A_Dz-nY2iFqYb@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
References: <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
 <Z8rv-DQuGdxye28N@phenom.ffwll.local>
 <20250307145557.GO354511@nvidia.com>
 <Z9LsbhzjI-P3-edQ@phenom.ffwll.local>
 <20250319172132.GL9311@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319172132.GL9311@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Mar 19, 2025 at 02:21:32PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 03:32:14PM +0100, Simona Vetter wrote:
> 
> > So I think you can still achieve that building on top of revocable and a
> > few more abstractions that are internally unsafe. Or are you thinking of
> > different runtime checks?
> 
> I'm thinking on the access side of the revocable you don't have a
> failure path. Instead you get the access or runtime violation if the
> driver is buggy. This eliminates all the objectionable failure paths
> and costs on the performance paths of the driver.
> 
> And perhaps also on the remove path you have runtime checking if
> "driver lifetime bound" objects have all been cleaned up.
> 
> The point is to try to behave more like the standard fence pattern and
> get some level of checking that can make r4l comfortable without
> inventing new kernel lifecycle models.
> 
> > Yeah maybe we're not that far really. But I'm still not clear how to do
> > an entirely revoke-less world.
> 
> Not entirely, you end up revoking big things. Like RDMA revokes the
> driver ops callbacks using SRCU. It doesn't revoke individual
> resources or DMA maps.
> 
> I have the same feeling about this micro-revoke direction, I don't
> know how to implement this. The DMA API is very challenging,
> especially the performance use of DMA API.

Ah I think we're in agreement, I think once we get to big subsystems we
really want subsystem-level revokes like you describe here. And rust
already has this concept of a "having one thing guarantess you access to
another". For example an overall lock to a big datastructure gives you
access to all the invidiual nodes, see LockedBy. So I think we're covered
here.

For me the basic Revocable really is more for all the odd-ball
random pieces that aren't covered by subsystem constructs already. And
maybe drm needs to rethink a bunch of things in this area in general, not
just for rust. So maybe we should extend the rustdoc to explain that bare
Revocable isn't how entire subsystems rust abstractions should be built?

Cheers, Aima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

