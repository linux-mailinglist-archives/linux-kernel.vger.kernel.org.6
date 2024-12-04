Return-Path: <linux-kernel+bounces-431131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D604C9E397C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A45B2A2E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FF1B395F;
	Wed,  4 Dec 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoNpC49i"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B01ADFE3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313231; cv=none; b=gzHg3zz/ki+3gCpopNQgEbSKGGc9oth7FJ8NgQ5ehjDG0XFTXnYbyj2sAi1zw+R+4Ar6955Yl/6iXYOnR9k105YbfQLtAVYjIVkUAoAfRQdpveLoS7BUUjWnIatWU4yIuVBBMjjECOKrr9hSv97/Sn9O833o9F9JMcJEAV8rI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313231; c=relaxed/simple;
	bh=luDqbcuOQVMj4DwFN6l1Fqfcu47I6KAT3+S2xLDmE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF0vffy8Oj26J1O11UjyWHBU2E1rxN3GphcBzj+B3GPy5Btb393KsW5EqMUMlzOmzIcCiT3CSx1ckhFui9VZxrzObbaM7e7msvTLfRfKwvjsyCPO3AL/XIHLHFGSZvbuZ3mMwSqrPcO9aIPDG4ErEijiikeunC+JJXEav0sZojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EoNpC49i; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53de035ea13so6719372e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733313227; x=1733918027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZi0lek4MKOQiatQagp7Ze6cVrkfo3z9JDWmy9BvIl4=;
        b=EoNpC49iqnSXxy3g+/iJc5sXKcNUj8nRt65VVncMNqVOq6Z8LGi0UzVL4bMot0l4s1
         Gg1pehfMd0zBFaEbbHM9NlYAJ5pY4pumIzJ8OSwdxKrLJp9ONWbZzLq0i0cEsoChIenL
         LV/0Q884SC6XlLmoVXKnJhDrPtXbaiHnN8QpeJUZBkgGqCEdBOq/luxQhh7B4cy669N9
         jtXq+vKMW5to27Uunpsw5hW8Mor3A4D7d6FnPJxFYGbBnjJoRXoCYBi7+gnhf2eeTHc+
         7hDgTKNiTOgcj+jpcOYFW4p/hCkAFwGyQ9PZr92h/UHnSuQmep47WJ/IW5+0YfA7uzeT
         BhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733313227; x=1733918027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZi0lek4MKOQiatQagp7Ze6cVrkfo3z9JDWmy9BvIl4=;
        b=raFL3qoNsiJ626kgRSkvenCYDGlDW0JdPv+3bmPtg/u4jO9cMNE4VxUoE34MjOnAKe
         3MlaMqLiqH+F1+ccLArnCJFcd3+zQVA4XLiC662O7CTbXg46AglYSw1euWxFStzFHEcO
         z0sEtaN8gvzhOHr02Kewh7zduia+FzoeChmKe9L3vD1fJF08NtBKawNSlbb/RxBEiqBA
         +odGLj6Ld7CbwV0ca2yBNnEyV4wGjrumFxgLCwP+lQ7KJ0IjaLkqdqBKclAlZL3229F8
         csXykAMpE0s/CByGXxJyVkVWaYHS6+nV3TPmK3NmyyBBZHtEA+r7yqV61RKSP6yvgIwZ
         j6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRMOh9IQHWFhYMjXyewB6wurO1U5TdzBMIK2qPamgsE2rnY5mFM+SgledZbUWm9E38vHE3TXd6KptyhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXBYpCOe51w+5iU5t4t2473a4liICslyKTpUMfmCwZzy8mjse
	Bqi8EPwkLZZpuTdZMBMFmgfKKzu6IgxZxzmPsryeczmF4BqfaUtGZeoiYeD/tHc=
X-Gm-Gg: ASbGncuw37yDlQcxHzM4CFfKaJT0RXnrwhizOVzBzv3/BPO1bRVEnp9p+YxlchHllWn
	esBgsrZTLN7hlTa/nTSnDzLBOUSbON/V33f6jqQ9arS2MHwd7BRjfTBOf4oL82hZzFKZwgBUFuR
	yutLFS8+Z5C+HpmVkAUM9dYjqdfnXd4Px3C9zyCFPva7W1zBXUZXW7370lNBiqSRkGGiOXW5egE
	gF45j0whbiQhcy5TB77OWyDkxN09uhI+8bt+RdqTlWttABWV3ZxDBhMnJRNUkgm0TZ+DToViwok
	DSnmDIASjx73SPgfay+8jbVBwT/Z0A==
X-Google-Smtp-Source: AGHT+IFnxylvsEOR+9iXG9XQGFOsLGLuTUnH2Iuu/xJxK8JDRP9Lh4DwH23FiU4cCFdLCw17KMc73g==
X-Received: by 2002:a05:6512:b85:b0:53d:ee75:1581 with SMTP id 2adb3069b0e04-53e12a35260mr2697093e87.50.1733313227235;
        Wed, 04 Dec 2024 03:53:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1356906esm554232e87.15.2024.12.04.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:53:46 -0800 (PST)
Date: Wed, 4 Dec 2024 13:53:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: Liu Ying <victor.liu@nxp.com>, linux-renesas-soc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, biju.das.jz@bp.renesas.com, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it6263: Support VESA input format
Message-ID: <cnauwpk7myky6zbfcqg5335dqif4vmggzxlq554ye2bykb5iwh@ng4oxd2c5md3>
References: <20241203172129.778123-1-tommaso.merciai.xr@bp.renesas.com>
 <834a2690-ca06-4a8b-9a81-c4981074f95c@nxp.com>
 <Z1Aw0WafGmYDrr8K@tom-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Aw0WafGmYDrr8K@tom-desktop>

On Wed, Dec 04, 2024 at 11:37:05AM +0100, Tommaso Merciai wrote:
> Hi Liu Ying,
> Thanks for your review.
> 
> On Wed, Dec 04, 2024 at 11:34:23AM +0800, Liu Ying wrote:
> > On 12/04/2024, tomm.merciai@gmail.com wrote:
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > 
> > > Introduce it6263_is_input_bus_fmt_valid() and refactor the
> > > it6263_bridge_atomic_get_input_bus_fmts() function to support VESA
> > > format by selecting the LVDS input format based on the LVDS data mapping
> > > and thereby support both JEIDA and VESA input formats.
> > 
> > ite,it6263.yaml says IT6263 supports vesa-24 and vesa-30, while
> > this patch actually only adds vesa-24 support.  So, to be more
> > specific, the patch subject and commit message should reflect
> > this rather than claim "Support VESA input format".
> 
> Fully agree, thanks.
> I will fix that in v2 specifying vesa-24 like you suggest.
> 
> > 
> > > 
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > 
> > Can you please send this patch with your Renesas email address
> > instead of Gmail email address?
> > Otherwise, add a Signed-off-by tag with your Gmail email address.
> 
> Thanks, for the point.
> What about adding Acked-by: from my renesas email address?

Acked-by has a different meaning. I'd say that generally it's okay to
have this light mismatch, see [1] or any of the emails that B4 generates
for web-based submission.

[1] https://lore.kernel.org/dri-devel/20241121164858.457921-1-robdclark@gmail.com/

> 

-- 
With best wishes
Dmitry

