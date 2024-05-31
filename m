Return-Path: <linux-kernel+bounces-197415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BD8D6A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91068283EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90717CA09;
	Fri, 31 May 2024 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXSj9Ah3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B879B84
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185520; cv=none; b=nyp+loXDtLNw1zee50LOYghNUR7BFcxmM+KAGmmsrTlx+/QzuFEKg0OB7m8ACzxQlNV4CgTmqWMJ9neY1GhvTh0yLqZJLXjwCkGrVaIQt0HQufHXV4G2VF3srE/HQvaKPVyA+hk82+XqsNiElL+dZAJ9WgyZaD9dNH0bIL/bg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185520; c=relaxed/simple;
	bh=8bHXn3OXNLx5qjnzYVxRFBUrKPOLz9Ymqk62iJc+lAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmwXCD72fX3TO7bxoqFg1YjmyYW4wCl9hnyqpQmgZZxJMoabcdoqBu4oJv5nGdP9shd3MTnGzuqcbWCAgFF41QKeqSWN5Q1ej8WEq1oXUsJicj3Ra4jCd6JZXP8Ww6l66CkM1MyRKLS8jqfKEuTR9XaIFOj/fUzw59TF7qtX7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXSj9Ah3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b90038cf7so202007e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717185517; x=1717790317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zzL15EC2L89F0jcA6FwGlL6a9GXwi72mLESASORZ3U=;
        b=iXSj9Ah3i+jVarZyMCCy+THXkt60zQaI52Y212obGyRuthJtAE+Okypxm44VFtP7Pt
         jbTZjafmgozTGOVJg8uBsQmVq840qRK1GFR9XBWgxVdwY8SvxcziM9k4f/sV7sJL/Vd+
         bMPzGRoIoiP76TxdHUEmYMO4J4tepPCh+jS+AJtKJ/qUh/0SAbZ4uwBupcdb4FNUzEWl
         62xSaigXr2hT6XW5lbkqQWtjNYNuguabNO2mf8z5eRwkty0tEc2zAcG+1YyQOyWO1oyu
         IIRptYhZQd4yWFloejbe6JKS57AsZ8Fvo6Z+w/0qHdO7iJdgw90q/5b9H9Fo9COKzrBW
         hABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717185517; x=1717790317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zzL15EC2L89F0jcA6FwGlL6a9GXwi72mLESASORZ3U=;
        b=TrkjlsPzE8O2K0KsW9/T2/4LyTMKbaq6uK0hAfclx4WvJgo1VfsL/czYUWyuTdz7Cd
         5NmP4nq90/iOoDAd5qfpwa3PqiKR+NssDsxxghL8VDxGxWfGs0k4G9VDvgw4FKYpb8ZY
         BgMpjgEOK62TCsfQBg/qP0d+QAZhqC0CLCo7EiuCVCnrx47d/2AcrX/Z0uA5aOQNph//
         6z/pE8H1Mw2AaUGcKrBA++aC9qP4+hz+TujqOwPf5gwqXXJr/mXJxOut4QvBhypCtEqU
         iD/rIUXJmLKQC8jZgGbGV71aa6IJSKsc2ciLfDxtDgf6b1nRj4EinaqFMLnd+HHgXEwT
         AsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJrnOyo+XPudhp51UoyMaAd/Qz/wMG8eerjecMn4OKDglzIDaUbB+gzmf5FNP6jCjLJjUbZj+9ng16UeKA/nJWG9F0E2qu1Lh6kDg
X-Gm-Message-State: AOJu0YymMDc31UBl3WSnD+xbgfqNCYWXuhRpH52k+6GMWkNq56nKGZr1
	S4ITypxPXXfL5VqrjTw4akROcNfiY4P7qr2QLL+TCiR2K+t9CUSlxG5VMmgKTjQ=
X-Google-Smtp-Source: AGHT+IEwiQ6pk+BKY1MK9bmBUgM955M0mWQUYVZ2U93GbXyqgrUjB4xGztU6OWyYemMzgch8INelqA==
X-Received: by 2002:a19:6a09:0:b0:523:8a14:9149 with SMTP id 2adb3069b0e04-52b8956b5c9mr1678167e87.21.1717185517080;
        Fri, 31 May 2024 12:58:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7f94fsm426524e87.207.2024.05.31.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:58:36 -0700 (PDT)
Date: Fri, 31 May 2024 22:58:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: tjakobi@math.uni-bielefeld.de
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm: panel-orientation-quirks: Add quirk for Aya
 Neo KUN
Message-ID: <geyj3ixnlka232jndzkydfr2n7a4lipqumyihujzkhdgdmp5wg@hthqr3agxvtr>
References: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>

On Sun, Mar 10, 2024 at 11:04:00PM +0100, tjakobi@math.uni-bielefeld.de wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> 
> Similar to the other Aya Neo devices this one features
> again a portrait screen, here with a native resolution
> of 1600x2560.
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

