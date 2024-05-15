Return-Path: <linux-kernel+bounces-180342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969F8C6D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97CB1B232A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054A15B0E3;
	Wed, 15 May 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GHzWuSOl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28C3219F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804973; cv=none; b=SoyfGFUwQdS6ZIFBYMUoZYjUkCJNTIfVYKrHveg90RstT6dBtcOu4MtGTfB9KYfxhGRvQb/CnHrkmumuIYFMU74JzETvqCanfRf1RbhEWGjmliqhU5ShFQMAxr+9069GgaP8wpxb2Wpy/TKUHMtpH+NNVfocfxbTjRrKWP+6WD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804973; c=relaxed/simple;
	bh=JcsUVdV/cLE3Uz80yLif+S+bHleZ4fbqQSw7wPa4nvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7IqAHhZxnaQ56vZmVTu8LyfJZNH0e0iJxprBUi1kSbsrqmHsNuBJ3WnmzxZqguUACVjSibvRPGbYd6E3QUkJGM4cGw13DdUvN/dYCFQEFmuwm4Gca3LguqM1ByAWEHHpbMi/Ov4Mhl2CJ2O4LVbwa8xMLknQK/NWKfNmm8rPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GHzWuSOl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52388d9ca98so2926660e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715804970; x=1716409770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HySmuUBRFJcyBMiUjWtXa9eokDnDTjSCJ7VGY9yEOOE=;
        b=GHzWuSOlNsTbWthId/21pHZVYOY7cepZzd3g8s7aRMMuFZWZ6/oSQKslXO09uohjrt
         tJkIiOW3xqagIFc+YWs/HJXF9MHBjMSx1aJgYhEq7ZAlLL3+IPExCmlmV7+uCaEQaGW9
         807xwXKpBxvrKEVjMnSJ343V7HknrgLZjGbfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804970; x=1716409770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HySmuUBRFJcyBMiUjWtXa9eokDnDTjSCJ7VGY9yEOOE=;
        b=qjeUjuRxDiwklrc75frLbZJvYwWeTjAws4m17jqxjiiqn+Xt8KHAyVHLAFbxqlH6fi
         KzthvUx6IUDrQsaUedBcvC7Vc5X+UvHPWF2HuYpOKLA/HTyo+/zAmXYfiMkoY1rPBvCS
         bnNriRcMhOycBRUxpI0bV5bmjYKkF0D5VA8+bx6J40kdYMFAvFOQwojn0U3g9Nz5cLrX
         121vZSAG5fhX2jjTB7zoTBBpCPRXAhxVtfMpu1jlxLK8yhN9YV4bIlvLnU5CukX5wEta
         bkMqdz2RyHSfzOO5MYvwX/ubO7V4/nWQPs03BrUk1+KygLZbsR2rwRyegKbl/V0CILwc
         8vHw==
X-Forwarded-Encrypted: i=1; AJvYcCVTv14kBHMHEK/ybpNwVr0M8SFeFZbcrZd+H9e6nfALtfawwruIjpFjctNtiilg60o31xGyOYV+eWqNa2j1wl9IJshfPr/R6bJOHDgS
X-Gm-Message-State: AOJu0YwnYVriCG4iGXtZdac40wvomZcNqyZGvhNKn73rVmfbXeVJJYoi
	qF9/oZ5WECsTVUk3WkbHjogLsGA3/bh0U1+BE8xaHPk4qPdBEM+g1dqJmvnw7nlTnizKpBZiBBy
	LDmDrsg==
X-Google-Smtp-Source: AGHT+IHIJD2Z2LmuCsoeVZl1vHCZg54dr3ByuC5eNgdpR7xteIavWDMMWkEKKcpCnuEFpJY7yxrl7w==
X-Received: by 2002:a05:6512:3c9a:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-5221027858amr17430183e87.55.1715804969914;
        Wed, 15 May 2024 13:29:29 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d294sm894981866b.28.2024.05.15.13.29.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 13:29:29 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41f9ce16ed8so72273885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1vMgqdMcvG1MRmptL1S6gkd5AkDiyL2YO35krJJK3XDW5d5bZBcCOck/308Rz9kGiRh3qp6e70PMhdJQ+8n+zF0VZiITU7goOtogu
X-Received: by 2002:a5d:5549:0:b0:351:c68e:48c5 with SMTP id
 ffacd0b85a97d-351c68e4aabmr5614302f8f.29.1715804968926; Wed, 15 May 2024
 13:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com> <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 13:29:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
Message-ID: <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Dave Airlie <airlied@gmail.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 13:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have to revert both
>
>   a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>   e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
>
> to make things build cleanly. Next step: see if it boots and fixes the
> problem for me.

Well, perhaps not surprisingly, the WARN_ON() no longer triggers with
this, and everything looks fine.

Let's see if the machine ends up being stable now. It took several
hours for the "scary messages" state to turn into the "hung machine"
state, so they *could* have been independent issues, but it seems a
bit unlikely.

               Linus

