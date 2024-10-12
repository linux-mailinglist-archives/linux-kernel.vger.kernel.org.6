Return-Path: <linux-kernel+bounces-362195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C199A99B1F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D71F269AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05C613E41A;
	Sat, 12 Oct 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wvyzlfdp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C4137742
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720450; cv=none; b=J6biui/uyoGsMaJxc1riauOCFTxamPvaF+zO+He7Mac2sQkWaxxHuJZV6eRuBKJ+7TFvpILe/v9MYLy4q4f8fOpDNAVwDdL/vXbLMaHXKdGx0yscoGOUeW+opCtTGgMBJARdOPHIycG7V0SWZayH/qMy+lY+YT4WS0OkhLW5hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720450; c=relaxed/simple;
	bh=o7rni39hEpKDVx9/9AJng7nBJrUeVm0W7UCzOPMFcFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKMPqNYBwdpFTK7FzCsrS1ybDPC3o/fUYE5T2AesWWwcsvczKV3GUxxK8fO0wX0vgN6cfrtRK1PTdARNFBmfi5Pt7IjsOqafTasn3KYRXgYnl3XmXdy2Jyu7efQB33EbHycjgJ3EYd9Cdbs7iwE4GL+VDPxPESICtkqB9MgoeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wvyzlfdp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso27424241fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728720447; x=1729325247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxxIMIxHhIuN3Y4k3DLau9HTuUBGd+U2wnXX9xJ8EMM=;
        b=WvyzlfdpPmhANX6OKfQAZ5pAbjz/cI8gIg9jxVhx/ZozWBF7295YTwBxWTMBOCK58m
         ScKZ3Cvm9x4kIYyPZTcSNBNwRW4xAT5QIdwVDhaCqcmihcvXUOPQmV4iGBVPlv68xo34
         iTwnfYswLqtqMoy0Xb94RkXQREUJgB8uMI1P87tHLFbK9fbYHwjLjP3YQfjw+qmqIFE8
         AI5jPNLT7cuJPtKusQ1UFPFllOamKU3868f/Q0jYiAZd8/O9lSTEh/8AvhHJL7x9qf0J
         fjiBRwQ1amkyfD0sirz3ATdJaq1muGjK2bzYlEwex0nnml8J5W+9sPBfDQ0KQN7+gH/g
         R9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720447; x=1729325247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxxIMIxHhIuN3Y4k3DLau9HTuUBGd+U2wnXX9xJ8EMM=;
        b=HbYtjyHeSKtvGY31s8hjuFhjY5se8scUQwvpwUE2RQGEc96JLN+7p3ByS4spkZpCV8
         510WBoWNRIeQ3NLpxkvHCGYcAlgv5YymST1EP/kbTxjIxg5DP3Vzfr/Cv+9s8RRc34f/
         jKIqJ78AZeha/KVGS5gzfDDqMXJGUg8/mfNmdwYgSxAGRjpTewUZZQC+DekH3wIWS2wM
         nUEfXcmUsPqfSrx5FNKDbiwnXdv12NkCwfLJcyAJwbNcyceHV1P2MdUR6kXdFsGSGF05
         WQi8kVHF6Zg1qvvMx5jzZkIGmAF6nhqLC/XOp7mvRgZDNkyiHiMSs1VMTOhGzeBa5QCX
         zfuA==
X-Forwarded-Encrypted: i=1; AJvYcCVBRXQsmcN3ha1mBfTMupnBOgG85KuBKU2djdRjO6fJdtNtyv7S0QyRS3DAsiWiMgWKkT4a5gOdptzszw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvjSsrVTZiNbcVPgy3SiFfUph7bj80H2prLxOP6KCjbILYhf8
	pjcN96bQQ2VuJIYBGmf5qGp+e1VAHhASwVcMg/2zMxpDBOE4x2ZpkwTm7KX3R30=
X-Google-Smtp-Source: AGHT+IFPL2CtCEwCTz92r494aEdLKqkcoe2mNIoQB4/KO8yuI/vw8UKQ8ZaDNAPm0kR4gfHNNuXaaA==
X-Received: by 2002:a2e:be9e:0:b0:2f5:806:5cee with SMTP id 38308e7fff4ca-2fb32727e37mr23391671fa.11.1728720446499;
        Sat, 12 Oct 2024 01:07:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2474d255sm7461541fa.119.2024.10.12.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 01:07:24 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:07:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
	dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Message-ID: <oxij35feivahxndatf5jpkgdfghk5e7gu3pi7zzf36xcjmoz3o@lwhwln5t2wcy>
References: <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com>
 <st6vgd2k6dxo4vd3pmqmqlc5haofhbym2jeb2eeh2pa2n6zcca@tradpzxrzexl>
 <2469374.jE0xQCEvom@steina-w>
 <CAA8EJpraKjBZRLL5U+BVQRf98_EBa5b=nSPxZATU+yvvq9Kfmw@mail.gmail.com>
 <4133a684-61a1-4d18-bb25-212d5fdc5620@siemens.com>
 <5bb0459a-ec3a-487f-a9b5-28ee643a1215@ideasonboard.com>
 <9b0e99f5-554b-428f-856c-cc32f4520c73@siemens.com>
 <lxcxo3y7z6emrpvisibj6ccr6qx5nozchuyy5aizfvkvvlp44m@jecj6k5y6z2t>
 <1ea19ca9-25fd-42c3-b495-5df0ab6c3ea3@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea19ca9-25fd-42c3-b495-5df0ab6c3ea3@ideasonboard.com>

On Fri, Oct 11, 2024 at 03:02:56PM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 23/09/2024 15:25, Dmitry Baryshkov wrote:
> 
> > > As Dmitry asked me during Plumbers to revalidate if our setup still
> > > needs patch 2, I just did that over 6.11.0-next-20240923 (where patch 1
> > > is now included). No surprise, it is still needed for our iot2050 device
> > > series, otherwise the display remains black.
> > 
> > Granted that nobody with the DRM_BRIDGE_ATTACH_NO_CONNECTOR + DSI-DP
> > spoke in the last several months, I think we'd better merge the patch as
> > it is now. If noone objects (last call), I'll do that in one or two
> > days.
> 
> No one has objected, are we ready to merge?

Applied

-- 
With best wishes
Dmitry

