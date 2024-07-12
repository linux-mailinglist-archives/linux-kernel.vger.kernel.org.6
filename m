Return-Path: <linux-kernel+bounces-250841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1A92FD72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C204286DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD617333A;
	Fri, 12 Jul 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0XlprMU"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7317107F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797862; cv=none; b=Wu4FgPBw6ossnXLYVZnefhdlsZ4/UIBLTO0C8V5UZn5O5ltHO21rnddlCaASQUV4/bDrSW0zM1Mmdgn8fTHRpIGQrZf/oQCL5Wi2Awpb9XsafbRI3vQe6aQKfZi4Re7B8QenMkWA6NwPz3xJIG2fxZZE9xtBP3HwgVRKPd8C1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797862; c=relaxed/simple;
	bh=JUIYKvNGMO1SkEFWn1mAumut1m0hlrfblgDfUKPWoG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkm50Fm1jUO9Q/B5cT9OA26mXamB5Oku388bi1hLmFmbyw3Gq2v5afAQkwm/07pcDw5R1e5HbR4sGfCB2AgS5ADMwfXYJsCAL51WnZLDgQ/VisVHfjR/J+75R384LkqUe4R7IfAdrOuec9PWcGONb0JsSnCMouSbt4dVEDCWGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0XlprMU; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7044c085338so1168967a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720797859; x=1721402659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOA2L08mCuyMKs7XPaxLTpydVxQBasV234XE4bUYJ3U=;
        b=y0XlprMUS+oy9DU4sUy/0ZudT8j65KKPEav1FaBilR+l/I044auW3Adab7UZV52jTG
         lvSCPETWoTYcMi/2TXwCHOMIv5cXpeICfh3DrF9jR7MBvJKkJ2a9e+O7o4qlxlkW3a6a
         S5unt9jLYCyjKt4eSF2QEFFnES8tUh/rLjBsFvP9mDqKrn2IGJJr0EXmN+R8w31596tm
         sHvZ0QnuyfSppdoTAIirMFQyrWtGsomSWxhwGextvgeOZec/afCLui3NyM1zj06oA078
         DG68vJU9+iHZaSNxaEZIa9g4SDBgpGN+tb5sDwFkwstWhiE+FKLdjj3CDIYLE/nIUCjx
         oURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797859; x=1721402659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOA2L08mCuyMKs7XPaxLTpydVxQBasV234XE4bUYJ3U=;
        b=ugwU7GG1FuVYHBAkLbRB36u7FNTzUp66ggYyDeVdejQMSKlx9YZ7mTI/vsLbASJIm0
         w/ej2cqgFVwoeAeH683AQ5A2fNyOT/oXNVSkHTgTHoT5KCH63720Elb2drjyCeQfvT4V
         Ca8BzEumEbWKYhsBc4SalImfju6PposseSa/BWt2rsh7+/3fSI0Bru7ZuBI1K2n3/vFv
         sKKvRLmXEZC5xHnk4yCQxcoJAejbK2XNYCKdve3e/+Zq1IDshV6c3TnTQaFVfT9ESzhk
         5cRZMan+gMQkJ+/Pfux1yQVgq/yR7cgmvy6utNVesSBcEp3SAwstcu7b72yQxWsg7dsa
         Lq2g==
X-Forwarded-Encrypted: i=1; AJvYcCXCXnQG1FNACrE2QgyY94AoUI+nFSTVB15H9PSeIDYbm9TKq3L36sqD7YTKoEyUychYYGOIneyY6JEi+U1rr46bDx4aWNqMGOcBXeE/
X-Gm-Message-State: AOJu0YxuElzpQkKsuvznpYObTB26tPToy64gzT03+bU6GgDeR4qpwZ7j
	giHV3pRvLkwOwLbndqtLqp8PwzTBS5iw7ZclQk7YelezJ8JyKRFSvhe1wfU8Jac=
X-Google-Smtp-Source: AGHT+IHwCLkJMA2vjY+7LA6BuyvexxnE9zT0HUloLMcdEh0siZLGbZEjCyL4Rw3Md6ahmoeYYiMy5w==
X-Received: by 2002:a05:6830:3b8e:b0:703:5db8:80a with SMTP id 46e09a7af769-703759fae28mr14499427a34.8.1720797859143;
        Fri, 12 Jul 2024 08:24:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d92sm1608796a34.19.2024.07.12.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:24:18 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:24:11 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] power: sequencing: fix NULL-pointer dereference in error
 path
Message-ID: <bf3f5a67-f6cf-44ed-a2d8-5722dcae9869@suswa.mountain>
References: <20240712144546.222119-1-brgl@bgdev.pl>
 <7d7dcc46-2042-439b-a744-49ae4b507839@suswa.mountain>
 <CAMRc=MdqZZLJLrAb10amgZSz40k1qAVMohVeUvHqobEHR5qaZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdqZZLJLrAb10amgZSz40k1qAVMohVeUvHqobEHR5qaZw@mail.gmail.com>

On Fri, Jul 12, 2024 at 05:02:25PM +0200, Bartosz Golaszewski wrote:
> On Fri, Jul 12, 2024 at 4:59 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Fri, Jul 12, 2024 at 04:45:46PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > We may call pwrseq_target_free() on a target without the final unit
> > > assigned yet. In this case pwrseq_unit_put() will dereference
> > > a NULL-pointer. Add a check to the latter function.
> > >
> > > Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/power/sequencing/core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
> > > index 9c32b07a55e7..fe07100e4b33 100644
> > > --- a/drivers/power/sequencing/core.c
> > > +++ b/drivers/power/sequencing/core.c
> > > @@ -119,7 +119,8 @@ static void pwrseq_unit_release(struct kref *ref);
> > >
> > >  static void pwrseq_unit_put(struct pwrseq_unit *unit)
> > >  {
> > > -     kref_put(&unit->ref, pwrseq_unit_release);
> > > +     if (unit)
> >
> > I was wondering where you would put the check.  But it needs to be:
> >
> >         if (!IS_ERR_OR_NULL(unit))
> >
> > regards,
> > dan carpenter
> >
> 
> Am I missing something? pwrseq_unit_new() can only return NULL on error.
> 

It's not pwrseq_unit_new() but pwrseq_unit_setup() that's the issue.
The target->unit = pwrseq_unit_setup() assignment in
pwrseq_do_setup_targets().

regards,
dan carpenter


