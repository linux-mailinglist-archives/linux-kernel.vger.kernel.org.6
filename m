Return-Path: <linux-kernel+bounces-374380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47E9A6954
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1B1C22192
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A681E7C34;
	Mon, 21 Oct 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOuO+jG0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD11D1F7A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515547; cv=none; b=NIf7dGRA/FT0vT63IdUp4+Dmeq2ao4PHqHfYq1O7RpjXmNDvg93mGua/ByqcUSftiAOf6elhwJmbbqyxW4NX+CO59xrfSoJXfneXK+10b4jyvMbf7kts9gyyhNokPPvjFVcBF2zdFJv9c9x7EhkWlHeXlO2dy+FHULCEtRk6csM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515547; c=relaxed/simple;
	bh=Ful+eYGSLEJiuKl15RuxYnSWt8hA3Fq+MazMe/0ofsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WTEjrPNxra4Wqv7Ir8Grmkj+UcRKRok73eKFec9GwNUwrYsYbaBYLMiNshL37WwifN2Fssa2iuo0tUgzsCl/F5zNQ0KZPB5J5K2LZ3CiVgnXAJpOrEP2e9POeKsL3vLgcO7HX+iE0SFsTzkRXi9ub+aGEwVqtKTM1Zij7V0OAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOuO+jG0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315abed18aso41010875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515544; x=1730120344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd7/pLYdEIk02a5YA0EypwGvSVgaUSYxbjpovDPFTI8=;
        b=gOuO+jG0BSFqvaYmXPWi7HB9Ni4OqCyGw+VtBlt7M7O6keNaCMdaPqQjfJI6uSDkV7
         yENg8VX4yDm7xWoXojDiwe8MKYcakxRXqIL0Xq79mYlEvj0KKLmjQo2FDOGZ5pbuTsRg
         PW3gZWSWKTF7iGbREFp8bnXixsFkM2whtPjmlPJ0/1/vU/jm70O2UtSBlF8XgG/3CO+e
         ybMtuI7f03InL76T5i53nbQLcY5lzhUEpwpz1vcfMjQZij1cyOco7SZ3nHmwnAejvzVh
         ZSSF8MSLTL/wwlL0w79b4tOQgQWDm67YHU3/5iKs73QGJhQ9yYDpaXDNfEcfbk4W1GZc
         5q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515544; x=1730120344;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd7/pLYdEIk02a5YA0EypwGvSVgaUSYxbjpovDPFTI8=;
        b=xC8/FZJ8jxw8u3CHFHlX2p4MJON5z5R+7rbOlW7ll2VtIQwjGwzM7gfuC+ft6Ma439
         cId+N0nturNMsBaENzZjuM/vyvAeDaCH94dZph6l//Y+gxLgcuwdbAc23t5092lSkMMo
         pwJOPzxV5IED+rZHUeifdBTrLG022VCTRNb98TcmkW7SrmaLNy/wq34hJOq8plvDBLkO
         nTkQfWONJ9lwo3/tzVfXym7wwB0ckFYdyrbmztmXvaanGvCd/2hDDw696f7l+oKaKnEE
         J3Anrs4NW/b1sgS1IeCYere+6YAF/ixLD54VaiGgVPsQXWLE7ozHyewf4lLD4mELYNBJ
         +VhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoF3CuXt8SAa4JP34DrsMgVObh1WkbJSw4KfHgLqvGbShV6gSH+CKNZFrQIjmiR2yPY2OQp/J8/7Wf9Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1L17pxFr3ORza2fGXnXIU3KoBm/W3PcJxWyZUQQvQNiAlzQjq
	zOUhgG9FLPLuH76aNA+BFRN9UL+d454Jn7lysXXQrExxWDVjawyPG/1l4wPM9rw=
X-Google-Smtp-Source: AGHT+IF/OA0ZsLmf5IvgnydhzYx42zQz0S9kryQZSwGJzTd/oVTKmRf3DpJkNqtQaRd1P6fFtU6Sgw==
X-Received: by 2002:a05:600c:3849:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-431615b9cb1mr89143965e9.0.1729515543677;
        Mon, 21 Oct 2024 05:59:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm57452995e9.45.2024.10.21.05.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:59:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Liao Chen <liaochen4@huawei.com>
Cc: andrzej.hajda@intel.com, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
 linus.walleij@linaro.org, thierry.reding@gmail.com, mperttunen@nvidia.com, 
 jonathanh@nvidia.com, Simona Vetter <simona.vetter@ffwll.ch>
In-Reply-To: <20240902113320.903147-1-liaochen4@huawei.com>
References: <20240902113320.903147-1-liaochen4@huawei.com>
Subject: Re: (subset) [PATCH -next 0/3] drm: Enable module autoloading
Message-Id: <172951554268.1240386.11009989976782146121.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 14:59:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Mon, 02 Sep 2024 11:33:17 +0000, Liao Chen wrote:
> This patch enables the autoloading feature of drm module. By registering
> MDT, the kernel is allowed to automatically bind modules to devices that
> match the specified compatible strings.
> 
> 
> Liao Chen (3):
>   drm/bridge: it6505: Enable module autoloading
>   drm/tegra: Enable module autoloading
>   drm/mcde: Enable module autoloading
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] drm/bridge: it6505: Enable module autoloading
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d9c12481f980bdad9cf6fdb742e49c5b50622795

-- 
Neil


