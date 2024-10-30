Return-Path: <linux-kernel+bounces-388037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4379B5995
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78281283F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F513212B;
	Wed, 30 Oct 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEFizGtK"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83C3398E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252963; cv=none; b=lclUVuC1ZnCbKE/GlMTs+rYaw18oID5HoaNEEV6yuCzd5B0+23dV0ajBVlNkFLtxEUpWYauXS/KFq2ZlBSmJOmqNTMciuJaVRo+GeoKr2YoTiEMNIh6ajk2MTvfQkTbRpQN9T7vSSQ8WTG849o47Ki2ulB2CNdh9454DrEaXOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252963; c=relaxed/simple;
	bh=x0ed5fyvDn11llPZvaG/AmyPvXdzuyLMLtZ8rEnJtaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fynEGDTorRX5OFOEc3o9g0s05RONhnMyBUKkxJ/vrVsikPQXk2SqH/O6wrA58BIp2/e2Wp2WqPv4X2JGKR1gctOJoppbbO7TRxWMFWmqo7Osjc60xVQUjsUKVyKorrRp2078w9lRe6KVcHiE94I15aaZQZUPifg+LqbUnhkFygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEFizGtK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e5cec98cceso51064067b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730252960; x=1730857760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQfV3QO9KjfChtLzJsZNfhkclfq5Ha2/eewFg3kibJg=;
        b=mEFizGtKQkP70OwPzuBUgc70dKzbhxn+D262/glgrkBrBA2l5n7pXPlSyQA0HZXdLk
         8BCrjed9cC8Rr5t5X3ihWmhp1EUyRAqS7ShSF959BTMxujis3gphIPc4tLeLPVJevOa8
         AX51BTANIMHtrKUcch9CFH1KY2Emj2ljn0LSZzB4YLb8Pwza7fEXopmc2+RGjrueU+BS
         YECBvhO040wBgpapHlbhSTL5ZYnSREOVhdAz8LYlGihTNFBjLhD2ay4wOPPPvu4wuqsv
         cKJSf01vIJjHHwAuLwgWtVo5QjJmScU926hQQ8JWJ5q+RhdK3zfDUygj9ZDLNCa9knr7
         1X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252960; x=1730857760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQfV3QO9KjfChtLzJsZNfhkclfq5Ha2/eewFg3kibJg=;
        b=UbBOqHOCPg7ffqDIhl8JCsL9DJitJQriDahJTOOEK4wPLY1IHAwZv4BL3ITT7qFxBr
         UhAWwGFitFoVEPJyFDO5cyTUIYWS9tYJHciYjky4liztg5t0j8+/xDxHuXc2RzQWyNDp
         c4pCfCs22vw9tjXZeg0cB0xDRuK3OMISyg+sA07BXVSCSUPyrmpkOu8YFdW2ZaQCTfdD
         VIFS/GAqGN34gWNG8UiSTD1846iFamNVb2tsVVNBM9+1OU7xuAgvf6cDwS6+IHq+AiM1
         kI61Re5bi3TGrRvpertDmq0MAPKtggG5aPKiYk6CO3gA4B/a3t5DMWIH4dMPrKyLw+ZG
         vkDA==
X-Forwarded-Encrypted: i=1; AJvYcCXtK3UksArhJGekxh8olgINqkT4qJsrMuTGRBfEyOOfJr8/hnyswJ0mEWTc5x13s1BjE0/aYqV7B/up+mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqFrLcLAVZW137Jwi9waDy5EDSKjy5b58Wmjjz9kwAkwB1jSq
	mw8C3veb6ZFJcoJCOC3ySB+Br99m9E7nyHYdKxnROfqsISiZbFMSUeSQ+9zXtuqY3JLKlZXNYgF
	5Ob198JHhW7RZebaJYAmd6/FVXrmksBXLKGXKCQ==
X-Google-Smtp-Source: AGHT+IFAd9OlkY1/IfgnYCIVx3fRmdHwRO/F3PUZW4uFE6vgj8FUomr2ncttaV4zBKegVHV0ggfRqOb9u7zb2JD2Bls=
X-Received: by 2002:a05:690c:87:b0:6db:b5b2:53c with SMTP id
 00721157ae682-6e9d8ab3cbcmr150957977b3.32.1730252960419; Tue, 29 Oct 2024
 18:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022124148.1952761-1-shiyongbang@huawei.com>
 <20241022124148.1952761-2-shiyongbang@huawei.com> <wu2kwdqce7jovidzxhublmpgdhzq4uby65quo7ks44tfjhtgd2@qtfogva3exyg>
 <c418e93a-7305-4ca6-85c1-42bd458f4e7b@huawei.com>
In-Reply-To: <c418e93a-7305-4ca6-85c1-42bd458f4e7b@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 30 Oct 2024 03:49:11 +0200
Message-ID: <CAA8EJppvnAcj5ESHe3t2QBvTGZTpiUUS3K+tJ+4_3Pkuijga0g@mail.gmail.com>
Subject: Re: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 16:15, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> > On Tue, Oct 22, 2024 at 08:41:45PM +0800, Yongbang Shi wrote:
> >> From: baihan li <libaihan@huawei.com>

> >> +}
> >> +
> >> +enum dpcd_revision {
> >> +    DPCD_REVISION_10 = 0x10,
> >> +    DPCD_REVISION_11,
> >> +    DPCD_REVISION_12,
> >> +    DPCD_REVISION_13,
> >> +    DPCD_REVISION_14,
> > Any reason for ignoring defines in drm_dp.h?
>
> Hi Dmitry,
> I tried it but still can't find it, if you know, can you tell me which macro I can use?

# define DP_DPCD_REV_10                     0x10
# define DP_DPCD_REV_11                     0x11
etc

> Thanks,
> Baihan


-- 
With best wishes
Dmitry

