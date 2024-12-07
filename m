Return-Path: <linux-kernel+bounces-436098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ED49E811F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC3E281C8E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFA14A09C;
	Sat,  7 Dec 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcr+dO47"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACC1BC3F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591150; cv=none; b=h5gqWqvvJ2WrF53Tjl2i1r2qNhzMvxGIW1n34V7jCi5Q0LiwRTeZqoQ2XbK3xpFCP1PDvU8cM0QSe4tjjw2NvdZW2QVN+H7Y+c5dwXVaVNcmA/T16+R7zCvmM42SM0E4VpfN40ZzzZIvldY+PcECtt5ivU8OnInXu+BUKNKl8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591150; c=relaxed/simple;
	bh=5Ltu9nIauUB0tWOUssK/hP/8hcg18CelCLFC1SSLQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmy3kyCGB/2/QQkM8+FI1cnox1jHTYc+mtMCL7RFjmTeH9h/kKXCqYEhbRP/ji6fvzfWkk7La2NkyA2H0vMpWxHnspaFiiJMwnImvW+3Blxc2fnNOYHg0bArQ6KN0nx9bBqwiT9bH8LfeXdSzjQET8O5HZ4bWKyhGKoJaI9TOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bcr+dO47; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434e398d28cso6652685e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733591147; x=1734195947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pk4dOE8x4+OW5hLEkb16n/k4Vd2DfXIi8+SR8qfyj+w=;
        b=bcr+dO47vMOaSD5a+6sJxsU1oXgRm+0gLLgqcuMD3UaLGGQnP6VcLS395tjNePGNKC
         mFGc67UOD2UoR3ihYCA+N3veFSKX0smWBbEH4PCJxMBiMdkhv8D2dk8o/wJhc6CDYRkm
         yfPgzdgb+G9brsl1OVgPDeCPtj5bok3yHeMaMfn4LgrFN+SCCpAzLi6ayYGLdV6ryr0k
         NS9+1jG+tXcT9E38iyTzMfLijM0Iq12obKERnF6zO1ncllUAot7MXI19GFWLdbvNjaaT
         pVBlAjaycgnmpRbr3mip3BDTxoDuEVjCAObSdMTQbFs4Ai/+EoRqScSs3Zy2yReD3B7M
         I1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733591147; x=1734195947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pk4dOE8x4+OW5hLEkb16n/k4Vd2DfXIi8+SR8qfyj+w=;
        b=czrGklaikw83wL+yFEKFXs99L0PBXckWNoskOtN2uwoZe60zm05AuM1wBDfQj1QkHH
         5l10ELQp5iQsRXwdUm4RebuQmAr9UQGF/RWRYg4B2u72V/wfvgnzmKSKeJt/9fxV8K5u
         rtcuUQHPYYnW1XRcNz3mh7DKVTwr7+33VLyEwmcTzArt+cszYy29xeXUvrfDmsFP6NmM
         JI0Ua4BM1yS6EvMvL9zV+HyeLWMhTVzeZAVabkCCjnP0tPplSeK7m6tAXm376/6kx7gZ
         SaNVTSngNijKj3lNYVuomu4/Tor3yNCtdwzpzN/3lM+mjaK9QAN5r9QQa7AZAy3VI1Y7
         Abkw==
X-Forwarded-Encrypted: i=1; AJvYcCWhxMIOnWjiDwXVGTxAYXII0eM2qTwpaRZJrHgolaKQ2Oaahm7k3tqFyGw4TziwNMAabUx5r6IJmd5O7yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSseuQqa0Z2QsaGk9V0WiOAF/FykNTUsJBy94ihKB1ZT/D6aI
	YiLWcjnSCpenWzUwZJ3htw+HYlXU3KLlg6esj+cWN+ch+5nfKa5RhT3gEPj+RyI=
X-Gm-Gg: ASbGncskeZGSlLPlAVP+YzUMu1LYmy8MJEXmDpp8AcnIVNgBbOMbsLygrakrwqYQE/2
	0yTAdZzkfZPZ4DNUEXhLi4DNvFnPxhUHmTDhC/jny6KC4LcKq8wZhdhGylrP1MJ3qYYYmOiAIrm
	lekPL9OIQQKkMh/yuPPjxtjQXg9y2L7qVGdF0Fa/mv3IGhTk0kAeT0XYSe9OPoKmHPJaVO8u9d5
	BXiZhCzLuDdJi4aCK11NFwGqCi1ekgpHf3dfUnRohHddHwSY1ChIV8=
X-Google-Smtp-Source: AGHT+IGg5h+0E5Jyx7sVuRubySPLaxRCj0fP8G8xiSLkhV7eNH7cjkBRQQuiu07DAS3WYMNZao+pPg==
X-Received: by 2002:a05:6000:784:b0:385:f7ef:a57f with SMTP id ffacd0b85a97d-3862b368e64mr4977264f8f.27.1733591147326;
        Sat, 07 Dec 2024 09:05:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59ceb6sm7779925f8f.42.2024.12.07.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:05:46 -0800 (PST)
Date: Sat, 7 Dec 2024 20:05:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtdchar: fix integer overflow in read/write ioctls
Message-ID: <6b4f7a14-297f-4fc7-bc4b-a9e7d822fb23@stanley.mountain>
References: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
 <e3da1bba-9740-6b6f-385a-1bdf25f056a9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3da1bba-9740-6b6f-385a-1bdf25f056a9@huawei.com>

On Sat, Dec 07, 2024 at 12:17:33PM +0800, Zhihao Cheng wrote:
> 在 2024/12/7 4:26, Dan Carpenter 写道:
> > The "req.start" and "req.len" variables are u64 values that come from the
> > user at the start of the function.  We mask away the high 32 bits of
> > "req.len" so that's capped at U32_MAX but the "req.start" variable can go
> > up to U64_MAX.
> > 
> > Use check_add_overflow() to fix this bug.
> > 
> > Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
> 
> Hi, Dan. Why this fix tag? I think the adding result('req.start' and
> 'req.len') could be overflow too before this commit.
> 

I've looked at this again, and I still don't see the bug before the
commit.  Secondly, commit a1eda864c04c ("mtdchar: prevent integer
overflow in a safety check") is missing a Fixes tag but the message says
that it's this commit which introduced the bug.

Which commit should get the fixes tag?

I should have added a CC to the stable tree though.  I did that correctly
in an earlier draft of this patch but I messed up in this version. :/

regards,
dan carpenter


