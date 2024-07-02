Return-Path: <linux-kernel+bounces-237590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBC923B33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3D283C97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5D157A5A;
	Tue,  2 Jul 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi/9xOCg"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C3156F3A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915453; cv=none; b=lE5ZLpmfdCR2ho1pWUiSxdfL0dGwwdFWGThEOZLQWMaM2edx8lc0AVxivhi14d0kqLAtabGEy0Y6HH1l7Us+HvyVs1SEGemsLyLue9WFM/TwELGZC7Lsu/p5FUVkJEY77d+U5mFLfeOt7oPLmdllYSPqxJ6RgEIXLBQuN75RITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915453; c=relaxed/simple;
	bh=siQZBD9sunBwr34OkX0W48YJK07Ln8v4+0iG1uCeLGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv+hWy7ocq7QL7o8sSyarAvilopfk3XlthCdT0MyDQXGts7Gtuis1L764YgALDN5uJ0h4SpjRbNUxGhgXQ+cgyCOO3GLkqn1XgDChbHSY/Wbx+qKKVknTvLXJ5M3WezfDJZIrFkWb+gBEhY7ikUz/lya3eWRx71YTvzv+/RH6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oi/9xOCg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fab03d2eecso30710305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719915450; x=1720520250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pKTTPmrnQobxgE7l8dU8flNulXP3EKlbQMbrPlJki0=;
        b=oi/9xOCg2XvwABheFw6zU/5Mcy6ehXLaKDDdDw9pzqDcPqSNnxDXV0vNZbwwWqsq5A
         /KvU6aOpHyO9DCgbhzO2pjU57Du9SaPT9wKQzJZBIsvGnBLI3gFSMePgH8l8I/jlRT+o
         Mchie0vHqyD1aONoUty6CjET260c0mT/131g/lbkfzns1UvDeMF6HG9uiczUuolQoob+
         R6qqSsx4ek8YRe2JaEvwyaXVXc4BXBW4aq3HWqTwTf5iQnn8rd/n2IU6e33NnrdGQwes
         OVLOr7o/It82AVr2Be2OsTvYb4ay2QV3uhHTIl3NfY0fnkFtz4xKhyVc6uVlUBt16CWF
         sQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719915450; x=1720520250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pKTTPmrnQobxgE7l8dU8flNulXP3EKlbQMbrPlJki0=;
        b=QJRB33mMW3697LHzmZnSIMByqBouaoIujU1swltuEQKp79MOINidxB1OCQxfdhb7wx
         eDD7So6YHt9VnP6mIeC/fLYQKjijZtg5YZ1LCo/Al1WT8wCx9PxS9ICeEQLiwoWDyFIz
         5Ag0kA9TdZZPCrNj3I2R6H240mVv40WFweiuqpgIWv/1dpZrg+99R1kGbpOO9TX+mEgC
         5N0ep3cW2lUS/aVhjarv/I8h7gixrZkhpdKgCOE68sllVEn4FDrroQXinYnVcrNpfxo+
         RhsNRNOvoSQPe6OGZrAXiBdAVw7BVth7x6JTsMVOM9/scrjyascAuHtTfjGv7tN/7XGn
         WsIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhaj0xre19HvxHpJirYdy7WytvcbbNmj9t65TG1SifLPvbni81FYYLIJHQct/gBoJB93RXM7r3p7dpAWBBHvtFfqVyFAUwHqueAkAe
X-Gm-Message-State: AOJu0Yy7SGvmL95doR10ogE5M/nEluji9Cx31yHHRoQ9Uf3BgtQrwrZR
	P9Ej5DuXyVvukN7yRePhJQFWQYM0Tq+u7+rG+zFP2O3k7bNIp1UqY1kd/fiW7rk=
X-Google-Smtp-Source: AGHT+IHMrBbMSgnyrBXJhkELUhdwwa1R4OK+0ew1rSLs2lXmY8A6OkIB5/dasHrqflqjUaIo8Xz5rw==
X-Received: by 2002:a17:902:c40c:b0:1f9:b1a4:d43e with SMTP id d9443c01a7336-1fadbc96accmr80929285ad.20.1719915450474;
        Tue, 02 Jul 2024 03:17:30 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1549e59sm82771525ad.179.2024.07.02.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:17:29 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:47:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xen: privcmd: Switch from mutex to spinlock for
 irqfds
Message-ID: <20240702101727.nytmrgdzcebtinbt@vireshk-i7>
References: <a66d7a7a9001424d432f52a9fc3931a1f345464f.1718703669.git.viresh.kumar@linaro.org>
 <17aa46c3-89e9-40aa-bb15-817230712f07@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17aa46c3-89e9-40aa-bb15-817230712f07@suse.com>

On 02-07-24, 12:12, Juergen Gross wrote:
> On 18.06.24 11:42, Viresh Kumar wrote:
> > irqfd_wakeup() gets EPOLLHUP, when it is called by
> > eventfd_release() by way of wake_up_poll(&ctx->wqh, EPOLLHUP), which
> > gets called under spin_lock_irqsave(). We can't use a mutex here as it
> > will lead to a deadlock.
> > 
> > Fix it by switching over to a spin lock.
> > 
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/xen/privcmd.c | 26 +++++++++++++++-----------
> >   1 file changed, 15 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index 67dfa4778864..5ceb6c56cf3e 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -13,7 +13,6 @@
> >   #include <linux/file.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> > -#include <linux/mutex.h>
> 
> I don't think you can drop that. There is still the ioreq_lock mutex.

You are right. The header got included from somewhere else I believe
since the build didn't fail for me.

> I can fix that up while committing, with that:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks.

-- 
viresh

