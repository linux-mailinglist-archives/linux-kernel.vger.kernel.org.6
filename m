Return-Path: <linux-kernel+bounces-226982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615169146AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1927A286F14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502FA132131;
	Mon, 24 Jun 2024 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrD7WuTN"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632D5380F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222550; cv=none; b=Kazx4FRXuW2IiZsq9fP6EDf89tjDdU6N7hr3XXd2BdEKbKAKHjGcmejFAkyAKnbCkbO3naB153t5zhZmJ+g+3wIUKorg2q2rjNOVE7GbO9hM10jo+2frsU3JvQrbzkeSszF/9U0hFDNwH8dLhB3xGvcRSZIbFdeLe6S/t3oBa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222550; c=relaxed/simple;
	bh=cBC9r5FiU07ZwTmGQi7v+3wcd5+NjF4lo+IUTbrfuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYhG8cRf+PEM/kDqoMKLXYrvJ0q24aty0OGIu6QXpw0Q7gOZzQk+jPVQVXwDk/D07SFxd9KT3iEU6hJUTc/V7DtzZqvEIDAazT48c39zMCZzgmwPQTUuiHk20/8pPVm9cI2kJhobqeqg2Gubf4XEr1Fs3Cq7ynJItRgL/gCJnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrD7WuTN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so50796641fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719222547; x=1719827347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8m390afH3EHC94T9TLjGH5rkccIMRXz02pwQnKceOW4=;
        b=xrD7WuTNW+datTjyoZKZxOQNn8XARXD2qx3m0NgMK2BPO/yM8RvWgFUxYpyLOhc1FM
         kv3aeOAmmfLuBB9fqAJAVgiICQaCCULAzvj7LFZc/KYQsTDoesYWbsN29HKykLg/KoLo
         QnwCNujQ/Muar1/o+SwOykj7bPhXu0oDQwhr6E04LItsM1cgeLLINljTMkdtDXi2bA9Q
         ou0VEgnk2T8USI14soO6krJ9v90/25g9HzDqusSjrQzoWT5QZxG81vZGjQXSa+gr0+MS
         PkpYt/G6eEd+kQQB6Gxo0zC+yYibYEpx9Bc4Lj39Qk+jjqL0RSRIxdaOjMdQSO8QT1Dg
         IVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719222547; x=1719827347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m390afH3EHC94T9TLjGH5rkccIMRXz02pwQnKceOW4=;
        b=ABQwYmJoAeui1kkpGHJBhgRPHt6IEXLzSBDxQd3sW++cCrGop6oyAPH5gPPBsGJEsE
         PpcwrzpPLrzBT76+1K/+3yXqhwlBykKTveQTrzILGtVeqj7MqEl7pTBwLIGs+uU0LTJb
         HDTmf4Zi+5t+jf0zP1kH51U2HutmA6mIoPY9JrK4WSYHdYxOLrN3g3o0OiCsw5lbEPR2
         rqY2TXBbhzb2uYByKFynG3X6PnfA4wXxQJ4R4lG6s3NrkL8s9R156NGca/8Skzwu96xK
         smd4oRjVv3wr+dRfo5DqvVB1lSlKXmgkQsh0kFlteFW3uqZjtORw14hGJ9yYwUqWDtf9
         CjuA==
X-Forwarded-Encrypted: i=1; AJvYcCUWGi6OCFTxKbFcSRscw+ki5PsKiMfX5M6AhT05guz9+dPioBb5l9ueOr6bNd4b9ZzianbcAHwJ4a1yrTPzj+Jcrz29EXqaX/7EBnVf
X-Gm-Message-State: AOJu0YwjFTyYCltzp8stP5riGFOTzWVhNwc2Us/aaH6vcq/ulwPOPWcy
	lbtH0Nqw7eWQDZ41fBTI5Q7edav++wetuHdZs2+n3c+cr29e3qlWlzWr09ATeWg=
X-Google-Smtp-Source: AGHT+IEdXV9FcgPiWFVGfg2bBJoCKqvS4QWdUnkhT4ii7J+rnercJlEkzH8zVTvYWjDnzWYF+vW+Ig==
X-Received: by 2002:a05:651c:154b:b0:2ec:61b5:2162 with SMTP id 38308e7fff4ca-2ec61b521d6mr14914311fa.25.1719222546838;
        Mon, 24 Jun 2024 02:49:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d601733sm9272031fa.22.2024.06.24.02.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:49:06 -0700 (PDT)
Date: Mon, 24 Jun 2024 12:49:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut <marex@denx.de>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Message-ID: <st6vgd2k6dxo4vd3pmqmqlc5haofhbym2jeb2eeh2pa2n6zcca@tradpzxrzexl>
References: <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
 <3277848.aeNJFYEL58@steina-w>
 <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
 <bc96c6b5-a7f8-4ef3-a89b-bf577943f11c@denx.de>
 <36ef53b6-57a3-42e4-95ef-a10eef4ca1c9@siemens.com>
 <o4bwopeuyxm6344oqqm3e7p3xcx76aw2trsiuhhfyhel2e7po7@sz2jaj6i7kqd>
 <71e809fa-b471-4bb3-8f7d-e497397c0de4@ti.com>
 <bebvl4vycvpkdqjlz3xi33t7qtb4oj7mriywxmahfemyee3uxk@m3nbraynomg2>
 <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b221c978-2ce0-4d31-8146-ab43a9f86a1f@ti.com>

On Mon, Jun 24, 2024 at 03:07:10PM GMT, Aradhya Bhatia wrote:
> 
> 
> On 22/06/24 17:49, Dmitry Baryshkov wrote:
> > On Sat, Jun 22, 2024 at 05:16:58PM GMT, Aradhya Bhatia wrote:
> >>
> >>
> >> On 17-Jun-24 13:41, Dmitry Baryshkov wrote:
> >>> On Mon, Jun 17, 2024 at 07:40:32AM GMT, Jan Kiszka wrote:
> >>>> On 16.02.24 15:57, Marek Vasut wrote:
> >>>>> On 2/16/24 10:10, Tomi Valkeinen wrote:
> >>>>>> Ok. Does anyone have a worry that these patches make the situation
> >>>>>> worse for the DSI case than it was before? Afaics, if the DSI lanes
> >>>>>> are not set up early enough by the DSI host, the driver would break
> >>>>>> with and without these patches.
> >>>>>>
> >>>>>> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so
> >>>>>> I'd like to merge these unless these cause a regression with the DSI
> >>>>>> case.
> >>>>>
> >>>>> 1/2 looks good to me, go ahead and apply .
> >>
> >> Isn't there any way for the second patch to move forward as well though?
> >> The bridge device (under DPI to (e)DP mode) cannot really work without
> >> it, and the patches have been pending idle for a long time. =)
> >>
> >>>>
> >>>> My local patches still apply on top of 6.10-rc4, so I don't think this
> >>>> ever happened. What's still holding up this long-pending fix (at least
> >>>> for our devices)?
> >>>
> >>> Neither of the patches contains Fixes tags. If the first patch fixes an
> >>> issue in previous kernels, please consider following the stable process.
> >>>
> >>> If we are unsure about the second patch, please send the first patch
> >>> separately, adding proper tags.
> >>>
> >>
> >> Thanks Dmitry! I can send the patches again with the required fixes
> >> tags (or just patch-1 if we cannot do anything about patch-2).
> > 
> > The problem with the second patch is that it get mixed reviews. I can
> > ack the first patch, but for the second one I'd need a confirmation from
> > somebody else. I'll go on and apply the first patch later today.
> > 
> 
> Thanks Dmitry!
> 
> However, would it be okay if I instead add another patch that makes 2
> versions of the "tc_edp_bridge_funcs", say "tc_dpi_edp_bridge_funcs" and
> "tc_dsi_edp_bridge_funcs", that have all the same function hooks except
> for the .edid_read()?
> 
> The dsi edid_read() will remain the same, and Tomi's patch - patch 2/2 -
> will only fix the dpi version of the edid_read()?
> 
> The bridge already has the capability to distinguish a DSI input from a
> DPI input. This can be leveraged to decide which set of functions need
> to be used without any major changes.

I'd prefer if somebody with the DSI setup can ack / test the second
patch.

-- 
With best wishes
Dmitry

