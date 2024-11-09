Return-Path: <linux-kernel+bounces-402991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C99C2F53
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CD2B214F9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3819F127;
	Sat,  9 Nov 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhcPH+aj"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56581537C9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180874; cv=none; b=JuB9bVUBMnIc2L/emO0cKVDvegUtagCQsSe4N5XdTWG0uo0N6zf786ky95RDyNuqi4vMUdJxfJ+jdYJv3Ig8E3Mf0Ihruuv03UpgoJ+RXFgZa/ftS+0rF3qod1y/FoZ5YdEK4s7BvUhHBWKODJdx0LT85XiKUc9SAx0SlpAihXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180874; c=relaxed/simple;
	bh=yWANDh8Hwc97XwtU+DZUeWT4ZFuV3uWMV5v0zYZBSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSJd5K6Q7KMRnLpd7FfAZTrBDJlUuwwT7SGoz08g1Myg2PtqgvMF2fsgyaslOxHErmzZGeQqoqnjIc4LRsWLSz9OAoVLvsgtmAbIuTeyaFgcRbeJg75R+BbptgKmOjlXIpRABSKn6rXvo2nL/Y+JmphcXWWiNE5rsJbgqCNcb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhcPH+aj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f4324503d7so1302804a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731180872; x=1731785672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kwQz1awDuZ4sry6hyRfqfqA2inYpXyqlxWLOnZKkCI=;
        b=PhcPH+ajQCd8rTw0u03bPB/zD9etQh2yHfsihl6Ly3naCO6RIpyR7yw4pGQu3XH7DO
         48g9dk61bl+c7HH+xi5fQOCjNEdoP97q+CqKBRJkhIpcUY6PUXTtfZN/6Y0GBaeeO+QG
         Sov9I+4/DPNdZH05FuiFnFyzK/42ICA3+sZE7qqANWWQf3mpkdEA7KzwDdY7T8qFinvk
         cxq76B0c2d/Q+1THaCb4qUmKTpkRvhGTM7hNYKdkb8XRUfZW0quT4Z5Gm/2pshArh6JI
         dV9fMpa3gj0p6WOB6SOW4HtWXt4Ky/PCwpFSy8wLEQgIp99ZcvjEptE58t3MAU95hnmh
         T/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731180872; x=1731785672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kwQz1awDuZ4sry6hyRfqfqA2inYpXyqlxWLOnZKkCI=;
        b=bspSasRTxGQe7NCPKmi6ZFJgQQvJxyTH5v47AiQ+loxHn2DjaENzTWL86ro+4ER81S
         2spuIZY66sa4s8Mr4GFM6312mAVvv2UiUE+k/jm2gObDTmVPd+gXus8hN0mWuciRKWd4
         LZPAo+6TEeRPy+MfJb9AKkYsXJRWIqS0PEU3Hd4XZjsjoiP/g2dTxQIJq+nVzIDTjRZW
         rF4ULOqpmUYr3Bxg26kFqP49olFsefoCHa41RoTBDwBq/d4h2KBRoEgA543nb5ruRZA0
         RiQ2G7ccabMahUUrIbrxhaFNE0OqdN/zF7LIEW74UwQ9+IwEh5C3MAfgYrrH56HkGzNn
         tUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhx5oCa4Zzp0Mnq3Z4DDLlVqa8lpmMiIszszsNwq6PATmnhmXvyFwZcIyCuj78MbDnBeSY+PMP2zWYDhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf5grvLS6URAbFz3YeMqB7QaZa0nNwvDOfeaELVSuZG3YVYTd
	xHmpiEv3u+jbaa36lkHAhgugE9opbdGhDr/7qKrPA3cWMZSrkBBZ
X-Google-Smtp-Source: AGHT+IEhVTJly03VMOW/me1sFuByB/yzuEnEIDx6tz9FXgn6OPkULtd0UG3nf/o9dP015rnIlIaBZw==
X-Received: by 2002:a17:90b:314a:b0:2e2:c406:ec8d with SMTP id 98e67ed59e1d1-2e9b17962a1mr10621012a91.31.1731180871704;
        Sat, 09 Nov 2024 11:34:31 -0800 (PST)
Received: from Emma ([2401:4900:1c94:8072:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b2bc93bcsm4091855a91.13.2024.11.09.11.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:34:30 -0800 (PST)
Date: Sat, 9 Nov 2024 13:33:27 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] drm:sprd: Correct left shift operator evaluating
 constant expression
Message-ID: <gdbbczffcnhhzkka5znerr5usy6qn2iu5grzzr7tifb3wozimw@jeemooscmnrk>
References: <20241108-coverity1511468wrongoperator-v2-1-72bc73d8691f@gmail.com>
 <exeho44dd45ujgha6jmnvt2idbq4twfm3d7lxmhbfgfeujyhmn@tohr2hoytwhl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <exeho44dd45ujgha6jmnvt2idbq4twfm3d7lxmhbfgfeujyhmn@tohr2hoytwhl>

On Sat, Nov 09, 2024 at 09:27:36AM +0200, Dmitry Baryshkov wrote:
> On Fri, Nov 08, 2024 at 05:11:25PM +0000, Karan Sanghavi wrote:
> > The left shift operation followed by a mask with 0xf will
> > always result in 0. To correctly evaluate the expression for
> > the bitwise OR operation, use a right shift instead.
> > 
> > Reported by Coverity Scan CID: 1511468
> > 
> > Fixes: 1c66496b1391 ("drm/sprd: add Unisoc's drm mipi dsi&dphy driver")
> > 
> > Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> 
> Please drop the empty line between tags.
> 
> Also see Documentation/process/stable-kernel-rules.rst
> 
Sure will go through that.
> > ---
> > Coverity Scan Message:
> > CID 1511468: (#1 of 1): Wrong operator used (CONSTANT_EXPRESSION_RESULT)
> > operator_confusion: (pll->kint << 4) & 15 is always 0 regardless of the 
> > values of its operands. This occurs as the bitwise second operand of "|"
> 
> Is there any kind of a public link for the report? Should there be a Closes: tag?
>
https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1511468

This is the link for coverity scan report. 

Should I add this link in the Closes tag? 

> > ---
> > Changes in v2:
> > - Added the fixes tag
> > - Link to v1: https://lore.kernel.org/r/20241105-coverity1511468wrongoperator-v1-1-06c7513c3efc@gmail.com
> > ---
> >  drivers/gpu/drm/sprd/megacores_pll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sprd/megacores_pll.c b/drivers/gpu/drm/sprd/megacores_pll.c
> > index 3091dfdc11e3..43c10a5fc441 100644
> > --- a/drivers/gpu/drm/sprd/megacores_pll.c
> > +++ b/drivers/gpu/drm/sprd/megacores_pll.c
> > @@ -94,7 +94,7 @@ static void dphy_set_pll_reg(struct dphy_pll *pll, struct regmap *regmap)
> >  	reg_val[3] = pll->vco_band | (pll->sdm_en << 1) | (pll->refin << 2);
> >  	reg_val[4] = pll->kint >> 12;
> >  	reg_val[5] = pll->kint >> 4;
> > -	reg_val[6] = pll->out_sel | ((pll->kint << 4) & 0xf);
> > +	reg_val[6] = pll->out_sel | ((pll->kint >> 4) & 0xf);
> >  	reg_val[7] = 1 << 4;
> >  	reg_val[8] = pll->det_delay;
> >  
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241105-coverity1511468wrongoperator-20130bcd4240
> > 
> > Best regards,
> > -- 
> > Karan Sanghavi <karansanghvi98@gmail.com>
> > 
> 
> -- 
> With best wishes
> Dmitry
Thank you,
Karan.

