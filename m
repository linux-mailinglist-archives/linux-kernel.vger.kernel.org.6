Return-Path: <linux-kernel+bounces-176809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738118C3549
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089B41F2153E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6369F10A1A;
	Sun, 12 May 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGNoYfnY"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AFE56C
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498308; cv=none; b=mPWWaV8H8fnk17YC2P8h1u1GN+m5XxfTzLJ3fUtgzNqQN2cjh5CzQblQPmvdnIc9YwjuD1xd6xoeBbmQ06mjppImlOg2WPzvJBWte7mNwVKfue+GMxysVXeJOQZi7fk3p4huBdoPqjPpsA1SK0gjf+wqXnfgHPw9dHZ9qPgp0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498308; c=relaxed/simple;
	bh=4tAha4vWh2sCmCdHIolv3tvIgyQgrDGI0NlsqXFoCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu+CGfOI5HbthlqO/9LtbdTStY0Db+NPX6Q7g+U9fCEUpJm7BtjJXPprKxk7aUYOICOwFSJHnSOUMYVG06aY2RTfuR4oXhomVfGUskCJqaTt6aNLxHlqGKxd458Wua98KLyVKXzjCcRhSd72jZ1x7A2xMn2jg97PsRH5zRRXTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cGNoYfnY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso60024841fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 00:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715498304; x=1716103104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ho2M1HiQIdWbeZZb6QjJWcaSs+2rhcKJwgaqpenjTE=;
        b=cGNoYfnYAOgNC11tr/culpQTyU+ABZNgvCvxq4YGCsZIWjrOh5GYq12DPqLdRogVXb
         QdYgc4MG8A+wdjKs9KbRL14YVaHPVGobzWdPelTws1+xqah7sRZ/LZY56iFEZSROr457
         dfTXNAryxgeW+6zRy97xZcl32YWSLUHF4yQ6/y+EjKOE1XNYGIiqvngZr/l9puMkIuxN
         JUawD+0OLyTEsk0fA2u39VEKYUQNuBzZrhi1iYqvI5+XkNNdnhEBtOpACBOFLVePaTlV
         NTGvlRG4ZOQNfgqdMqVPbouiqcZs9NLZD8/z4+uzzWbVig8tRFp5EXw35CxFPa57GbPD
         5E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715498304; x=1716103104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ho2M1HiQIdWbeZZb6QjJWcaSs+2rhcKJwgaqpenjTE=;
        b=DIyMl+Jvkg27nUjjmSYW3DH8hvz1+uEE8zAskYsU2rpS9ZlFVoyvoMGfy8EA3qn6z3
         dW5++l+kn+baEqTMyegItLvkmHoAFr75iFqW3R/Z+HKHErTC9QvBbVCOqSW/xEmjOLxI
         prWOIF37HTjcFzQEpBifq1WDcwQ0N7N7+Rk2cpc6RTaXNfomGMmND6ei+s/v6g5d/Mkx
         kZ06+tmRp+0r8cR3AO+WduL7j1mCYC/BggmoPQN7fHKWiI0UcilYin4fUi9nl4ptkR3a
         584GJsPxpKKo6RFModowwkd5db+cBjeHyXzoMuWEOM+Az+glGxMR3KxI+Wsrp2yG9gWw
         tVVA==
X-Forwarded-Encrypted: i=1; AJvYcCXMtuxmCIC0C3vteJu3J0+sKkCTJW+EEgsWV9QFaN2cthmxJLeJkl6YukSN6+7Pi0+diF9wklsDHHF+tBuIMIZ7xwkrZQYHIh6YXZaZ
X-Gm-Message-State: AOJu0YxWLNkbB9ynFs0uu5GexYkTIsIx6O+hGf56L20od8xoxGltuYFi
	LpBcHlArO/KgV+c2pCmwxcXf7kueGE+k4I+DAleIV36s/kdSaqBlBwk4C3HN6Io=
X-Google-Smtp-Source: AGHT+IHFq0ufNNWxWGNJhbjtEqg492vkkSDjHXTgvyYhd5RDqv8PEWr4+4kRdkTRVvckVFOTc9ZeNg==
X-Received: by 2002:a2e:3c0c:0:b0:2dc:14d5:4621 with SMTP id 38308e7fff4ca-2e52028a8femr59741201fa.34.1715498303593;
        Sun, 12 May 2024 00:18:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d151569bsm10126371fa.87.2024.05.12.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 00:18:23 -0700 (PDT)
Date: Sun, 12 May 2024 10:18:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/msm/a6xx: request memory region
Message-ID: <vwxnwf6um4vmazqfomx46w5hc7swf4boiaaqtta3tmytwbbazo@g3ey2d4jxknm>
References: <20240512-msm-adreno-memory-region-v3-0-0a728ad45010@gmail.com>
 <20240512-msm-adreno-memory-region-v3-2-0a728ad45010@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512-msm-adreno-memory-region-v3-2-0a728ad45010@gmail.com>

On Sun, May 12, 2024 at 01:49:39AM -0400, Kiarash Hajian wrote:
> The devm_iounmap function is being used unnecessarily,
> managed resource mechanisms (devres) are handling resource cleanup automatically
> 
> This commit removes the calls to devm_iounmap and relies on devres
> 
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 18 ------------------
>  1 file changed, 18 deletions(-)

In my opinion, this patch is better be squashed into the first patch.
Though I'd leave a final word here to Rob and Konrad.

BTW: for some reason your patches don't appear on freedreno's patchwork,
although they definitely hit the list and appear on lore.kernel.org.

-- 
With best wishes
Dmitry

