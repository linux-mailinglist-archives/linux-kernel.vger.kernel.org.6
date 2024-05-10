Return-Path: <linux-kernel+bounces-176081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9D8C29AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB91F22C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7051E525;
	Fri, 10 May 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COn0Xeyp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8781F954
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364129; cv=none; b=jJL3TlVpkls7RGbsMQDcGTdodmZIaX00Y+3Z2mcx/+AbVN8/NG+8LLAvZN+91Ml6jpuek+x+c0hwpaQLCqtjoktjNBeSjReHbkBN9zfTAtv8KXzjRHqle1Jk/VMN4gZzbufNpbu4IuaY3Hv1lFf7y6/6orPzgC98I6HmPRoA4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364129; c=relaxed/simple;
	bh=pX97IRND/hC0ZAHWMTHnJl4QulKVbMD/FL1DM3HCNs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLQGXGw3jcbuAH/XRi8K7hz3fwQE5Ntn7kCd9Fuz56vrjBEWZpL6vl/B9rbVaOHZIF/4Ja5Ilj0CHNz51YKSh0tt+DarTghJZOZ5N44doEmyCG41fw2pcHkuLKPtWeSYwhS63Cycqaxuz7aKEbonyvGZKl+BS/5jcJ3ctSZenSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COn0Xeyp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f174e316eso2790818e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715364126; x=1715968926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ElFboxhq5Mn4V6HoClPLbitGjO20T62uh+wRM77AIu8=;
        b=COn0XeypNm5HaP79nUZX82RjBpKRPvRBmEnThEVFTIcz6q0iCbw6CfxEi9YlvOHr0Q
         D2VVE8Xg/0zUa2O6hakzXiLspLaDHbD+ibAzBxL1C+/sRHNliveLdkmS+hMxu4fu0uNv
         GlE661l4arzKennGUv1Izq4GBs6+kArXjSGcAiuItGr8E+nkgktm8AhBrwHEWMHA+WR1
         yD1THZn16mAT8JLpeSjFPExPQ0vz/4AKXoXWJTcX5rrhmEJegMmW2mzMdidrQnKFEN5b
         7U5Ojtj/2wxhRtSj8sb04p4e2OIVT95/aLzYOT/MRJlugcHFIBg+qQdcxiiwhsw6fPN9
         tqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364126; x=1715968926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFboxhq5Mn4V6HoClPLbitGjO20T62uh+wRM77AIu8=;
        b=mKax9Qba24nV/nCc0mv4a6aF2a0dWLKNUy+ForyaJz2SqHgVhs4vLlPOAv85LtiQnh
         XYZSoy1yrV40KNLXNP//XiACLSa5n2WQdb8onDETCuR3j5h50zbLGh+LDiQUAbEGmo98
         +e2B6ISbmj8nyeTwN9hFZuWuFGzVCZKB4RniAC+HJtHhCAfE5RKxsxcbmAmXoUNVcy8T
         Be//5CZBrWuSZC/N+yg44+QKXOSnoOS6Vun5YOYTit5fX4Dxs/S5sSJk4V9JR3DxP+hq
         LTgT8pGnR1kzNJ5jM+cwzb4rUqY7J2YEXSHeyIZLniOq7glugPXh2pHBa0+PXpRndiY+
         RKmA==
X-Forwarded-Encrypted: i=1; AJvYcCUHyrYQqVI6XL+0wwG1Fp7eC9lsuVasCpaJVor1HyqHJtExV/vFMkWYD0o6gFebWs97aCVroG0uyW/+o9LM0GhTjl9FdbfYfP4xsrWr
X-Gm-Message-State: AOJu0YyUHwMX5DOqr+3xCCIJB3I7G2UukZeMgamzGnSr2tJzicnBAoGF
	FkR+Rrun7/xv1SPli6xKbSgO8+xeTAucsC4nWpzyDlqoNq6wSNE3wMBFYkM4cjg=
X-Google-Smtp-Source: AGHT+IFusX5MOdbRcwF97iEcqtLVbvmUBFmNSuhXU+WbubEJNOeY/GCO+g7Qgmz8sIfmntnCjhbEnw==
X-Received: by 2002:a05:6512:2214:b0:519:33a5:973e with SMTP id 2adb3069b0e04-5220fa71886mr3182690e87.6.1715364126158;
        Fri, 10 May 2024 11:02:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c9asm761699e87.275.2024.05.10.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:02:05 -0700 (PDT)
Date: Fri, 10 May 2024 21:02:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: jdi-fhd-r63452: move DCS off commands to
 disable
Message-ID: <kjlcqkfipct4d54hrtmwdsrifxvuq3qocv5bcmwsufrbxtvvq2@52grw5ijqx4k>
References: <20240509-jdi-use-disable-v1-1-5c175b2ea1ee@gmail.com>
 <rpita5o6za64p7tamasssb2fja6h6ipr5cibh6gs7klkijyk6r@mausrcet2ycx>
 <CAGsSOWWAotJPz+o8HSYTrXtq6H7Vrw9KXZX1jDZLgqfudKsnyg@mail.gmail.com>
 <CAGsSOWX9YcuBpxQZ5kPm6zbMbM6iZqPK3bk=dgKyUZPjq++GXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsSOWX9YcuBpxQZ5kPm6zbMbM6iZqPK3bk=dgKyUZPjq++GXQ@mail.gmail.com>

On Fri, May 10, 2024 at 09:10:34AM +0200, Barnabás Czémán wrote:
> On Fri, May 10, 2024 at 8:46 AM Barnabás Czémán <trabarni@gmail.com> wrote:
> >
> > On Fri, May 10, 2024 at 2:56 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, May 09, 2024 at 08:14:07PM +0200, Barnabás Czémán wrote:
> > > > Move DCS off commands from .unprepare to .disable so that they
> > > > actually reach the DSI host.
> > > >
> > > > Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 12 ++++++++++--
> > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > I don't think this is correct. If the driver sends enable commands in
> > > prepare, it should be able to send commands during unprepare too.
> > >
> > It cannot send commands in unprepare, there are multiple panel drivers
> > what do the same.
> > Every panel drivers which have DCS commands to be sent in unprepare
> > has similar error messages with mdp5/dpu.
> >
> > [   92.322564] panel-td4320-boeplus c994000.dsi.0: sending command
> > 0x28 failed: -22
> > [   92.322635] panel-td4320-boeplus c994000.dsi.0: Failed to
> > un-initialize panel: -22
> >
> >
> Here is the error messages, these are comes from unprepare by every panel off:
> [  121.295290] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed: -22
> [  121.295368] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
> un-initialize panel: -22
> [  184.783019] panel-jdi-fhd-r63452 994000.dsi.0: transmit data failed: -22
> [  184.783066] panel-jdi-fhd-r63452 994000.dsi.0: Failed to
> un-initialize panel: -22
> with this patch these errors no more.
> .prepare works because of this flag ctx->panel.prepare_prev_first = true;

The flag should also invert the order of post_disable chain. It well
might be that the drm/msm/dsi driver shuts down the DSI link too soon.
Please consider fixing the MSM DSI driver instead.

-- 
With best wishes
Dmitry

