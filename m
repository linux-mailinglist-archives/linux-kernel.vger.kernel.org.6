Return-Path: <linux-kernel+bounces-426191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE189DF010
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B79B21DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D050160799;
	Sat, 30 Nov 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+nPKOdJ"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BE13C695;
	Sat, 30 Nov 2024 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732965338; cv=none; b=JGfCYw/PBqWTO4qHAf8BaFUyQQYzxjm0rLtXm6jLm1ecbJpLSxS11tvnQk8c7z8QBWidRdBeiupIG8odWLmoZ5qqOtwkSvPY74h6hUUyllLGGfYJvGQLPHRRvwjC9AqPilOGRCtrk5BzNQfU/BYuvRw8pr3zJTDwpRyk93FpCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732965338; c=relaxed/simple;
	bh=GRZDGSNeLTryaBCunqqgAa4OiK5cnsXdEP5G1X0nc1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANYxGgr5LpmbGB9pXCCKmF4f9SR+r4skKN1XwkfLzww4NWDT0e1nJ2DNL2fF4nSH/S3HaKKOnHA5e6IirVFuWSItm+X40Kei8m3YIIUEX84dhdDAP6SPDmarS88UFnvXTc1Ce575B6LOkaMPBeIcofN+7XC6IxC26VGla632T2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+nPKOdJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e398273d6ffso1656116276.0;
        Sat, 30 Nov 2024 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732965336; x=1733570136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=My+Y64elRWi2729TcRQADy3OD/AZrL+55nSA2jzZWWQ=;
        b=E+nPKOdJvttNvyCC0iNFpv3Zli29oXAhpYx/AR4IeuUc1x9mewOkYpaDm2lP2qb9FV
         Vm/aVGy3J5XMQkyaZEOA2kC1jMyYZCw5MNZzg1sO/seTM9YVJAzU9tlldj26Jpy9Gcwx
         oTUxZVU7Wc+25cEl8shGiULzOX+y5XMWI8KTZ8YApHcsPr0c5H8z7UbVzHJwgUxeOZn+
         exlZH/OX4TVGuWNsWTMua9pyxnZaUu/gyoC0hlzApJKvmZlHmZDqvAK1908dQNGAhkLX
         WOl+hbMwK3V+FX81UsMyUQEc8JT4sEinfnMgsnR2orVatOS9/gftWrvZ2hXHe5E1XSp4
         Aflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732965336; x=1733570136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My+Y64elRWi2729TcRQADy3OD/AZrL+55nSA2jzZWWQ=;
        b=Wb8xwFw22Z0rD9sIom/atvjYU66tfF2dtIv6bNGJsN8SuplA3S7h0Zr+tREEr2uEvK
         vA381wWqmDd2im/jAqGDM8z+7fubYqLsiMW3GJeaQkJ1R54iqaR1VCoRhgGqWfXzyYhE
         I6gNpLit9i4mz16gcUBhiO5WCLJ/2WrmlpS8x1vS3HOhxxQEETztd2o4t24nA3NK/Xb2
         iwPoynJKQ4kfmYk68WHu1ckgpK2H2jjxsbXWC4srMlbp8BoPB7CexVZ0KNTi64J2cke5
         TUBVR2U6OcyKCHTpECkytWaY6c96aUOqR4lySyIPl1csTsswcbdPVwtKWOWZSUv7suw9
         IGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUR5I9Gf5Fcph+uSuTynMCwTc0OmVqs/aEcJ7sZeCV0xfGYvRf8Lqhx5DT90U2JkwQ4Ese0cQ0F71C78OY1@vger.kernel.org, AJvYcCX2ScyXGOejWKFO9SVLuRajzEj74yck3nGlalf61REbKEO9NuWUC/BnAjn9jAN840D3KpcA51/yhjC3@vger.kernel.org
X-Gm-Message-State: AOJu0YyIh3yEGmksmTTUI6zHH/rhccIjNJGeKUiE/dQMMqDzeNcsOTTp
	pXYKH5nVNC6upuWQ8aJKcuuaFxiepldsz9GhMlyI2p5WKGJQhe4s+m670uKBJz9B6YGX3yGOryh
	t9I/3l0B8rXT6xXu27rjwz9+GVOk=
X-Gm-Gg: ASbGncvLma/7xqPTSVoOAUPHYFCtZSWHAweIRKxLh+E6Kr5ariWaBFRl04W6VQZAl4k
	BPH8wODRtGMdwn2GlpQq9kJHzQMmHYfAu
X-Google-Smtp-Source: AGHT+IHnjY+2Sxuoh7d1Wcmkvzc3kysfXGBiGIRQr78j9FBJPnq2iZmfGEF20LZhC0dhpWjwOiR2FaJ4YhczzVfR9XY=
X-Received: by 2002:a05:6902:154a:b0:e29:1099:9047 with SMTP id
 3f1490d57ef6-e395b869ac6mr13767408276.11.1732965336132; Sat, 30 Nov 2024
 03:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-adpdrm-v2-0-c90485336c09@gmail.com> <20241126-adpdrm-v2-3-c90485336c09@gmail.com>
 <pokf4zrrm7utx4dlq7sfob3pb4m2dh47eyw2g345tvh75x3s2s@ylajym3brih3>
In-Reply-To: <pokf4zrrm7utx4dlq7sfob3pb4m2dh47eyw2g345tvh75x3s2s@ylajym3brih3>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Sat, 30 Nov 2024 12:15:25 +0100
Message-ID: <CAMT+MTTGtmMvbPy7HvTQ+AdF_X4dTcfXV5n=krm414MnXYqxjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm: panel: Add a panel driver for the Summit display
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 10:29, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
> > +
> > +static int summit_resume(struct device *dev)
> > +{
> > +     return summit_set_brightness(dev);
>
> Doesn't the generic code already handle that for you?

Apparently not, I have commented out the pm ops, entered sleep
and the display stayed on.

