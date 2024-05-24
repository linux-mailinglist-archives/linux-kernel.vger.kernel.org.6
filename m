Return-Path: <linux-kernel+bounces-189059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B528CEA70
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ABC1C20F50
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD0405D8;
	Fri, 24 May 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDmL8cjM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D851BF3F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579977; cv=none; b=rN/RkbVITjzGVaDVajEG/MFuHdto1mPzEVtfi1929lst9tsO3ckuuNcc1iuiXL6t0QmSC0guZy89VUCOrC0ymgUV7W7rbEzofn/gaReDq2Z44sob7N9V2rFKcdvbetfmfNMw/9tECXK84rNWVXpLyyBWmhaYBJn5sQrUazRS+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579977; c=relaxed/simple;
	bh=v57WsHIXuyTLImPDj4QD2uCiQ9W6+aOrQYAEun7dCrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG+xomM7acJLORQolgwaQyiEyTu0wB9lasiRJPSzXtTz7tfCEwuUA8zyt8hBC9Ra2b397cgrYquA8tkZo/NqZLnlo52jj2rUTr6LUrWj1t4T4wC6FUOTZdF6Qp5KBp6Mzupg8ZXQKJG1naXQBF2mmqAX/X7BvX/ZLdbkDxKM4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDmL8cjM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8e838cfbfso23315b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716579975; x=1717184775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zfFKfQRl66NaHOBeukuApZN3TjnqGpMUm67PVQU9uwY=;
        b=kDmL8cjMYij08fya6tMdhuzA7TlrHcATM1QyByM/tXSprGVLrw+7R9AZj61403f69M
         nq4MkBRin4u7LlGB8ckCT0mKn0oOGbYuM1T+sp21skgLGTHuiCT5QSE0SOQmCNfkcekz
         cQIFJz29bfIYrO6Cv84bTgmPBdzuEIU9djqobIFx3b0X4Pz9WHD9dbjL7zrKWTB0ZE26
         a+VQwqSYw7bpenVVC6u6L9zTJyFIaVq8FrQHphu6qL+UTyQ5Qi6VpyPtP36HWpUR2wfT
         45I8YbPSDp7uTnKjP3A91CDwdo2Ps++ghVeCTL1YK77g2+ReStAS8DqDYoViHPRG1jLG
         WKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579975; x=1717184775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfFKfQRl66NaHOBeukuApZN3TjnqGpMUm67PVQU9uwY=;
        b=UM4igYaek3xa7e/D0T52J922ndRsgEX+WGzqeVZ/itKeCxXvLEIKBZo4UjcUbAlNwc
         xMnSyGZSMHjvwx5dOGBnW9ktfueSVHdEdtEZKD6q/iKjM3eUXWWiCXQpKz84hhkFydBe
         AWyjR/7FP4iQI8k814tnOr4vV8c9g+KNIwwkGHKmcdblOOrKbUJzrv5xCUt1zwyr0T5u
         305P2OhNemO/io1VSUtHzbnrANQJzTEa12SJNd+auvaKLM1g82rXCnPK2wlZpa+8v+Uc
         4fgZOAZmW+uKBCGYdhyCM+NbDTw3yT0LfLaypXhrwMJ5/M3N7C0+LfwcyuBRNFfJevWr
         MKlw==
X-Forwarded-Encrypted: i=1; AJvYcCWbY1rnxyxXkxTIReVljxi1wTwiEW0h/2aAW8rqUmpdnjLTmUbr0amftZKxrA0r5OxlbCkx6z3dye/Fi/wKOK8Naaxp6sJhL9x9mrTC
X-Gm-Message-State: AOJu0YwWmZAKWawuIuyZLn0cZV3zuOLfry3+zgVSVrZOatkFU4hcJCBj
	tsAtLeMvbWdXmRxen/n6IxEGaYG/GQZKCYJYqg0xHE6N95WfxljrbZnpew==
X-Google-Smtp-Source: AGHT+IGkLeO6KWtdoA7p36j/aj2kkZ1oedQz4pFmlvueja7yNSq8jTCvi8T2YMPnywkzlODkzOHwLQ==
X-Received: by 2002:a05:6a00:11d3:b0:6f4:c946:5584 with SMTP id d2e1a72fcca58-6f8f3a231afmr3361088b3a.2.1716579975152;
        Fri, 24 May 2024 12:46:15 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc15b169sm1455694b3a.75.2024.05.24.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:46:14 -0700 (PDT)
Date: Sat, 25 May 2024 03:46:12 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/lib/slab: Fix potential NULL pointer dereference
 in kmalloc()
Message-ID: <ZlDuhAPHNw5ZCfjH@visitorckw-System-Product-Name>
References: <20240524191459.949731-1-visitorckw@gmail.com>
 <20240524122350.a22ca8dfe07a21f3eb862159@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524122350.a22ca8dfe07a21f3eb862159@linux-foundation.org>

On Fri, May 24, 2024 at 12:23:50PM -0700, Andrew Morton wrote:
> On Sat, 25 May 2024 03:14:59 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > In kmalloc(), add a check to ensure that the pointer 'ret' is not NULL
> > before attempting to memset it when the __GFP_ZERO flag is set. This
> > prevents a potential NULL pointer dereference.
> > 
> > ...
> >
> > --- a/tools/lib/slab.c
> > +++ b/tools/lib/slab.c
> > @@ -22,7 +22,7 @@ void *kmalloc(size_t size, gfp_t gfp)
> >  	uatomic_inc(&kmalloc_nr_allocated);
> >  	if (kmalloc_verbose)
> >  		printf("Allocating %p from malloc\n", ret);
> > -	if (gfp & __GFP_ZERO)
> > +	if (gfp & __GFP_ZERO && ret)
> >  		memset(ret, 0, size);
> >  	return ret;
> >  }
> 
> I suspect we have a lot of unchecked mallocs in our userspace code.  If
> there's an argument for fixing them all(?) then it would be best to do
> this in a wholesale fashion rather than patch-at-a-time piecemeal.
>
It seems likely that I'm not the first to notice the unchecked mallocs
in our userspace code if they're indeed widespread. Are there specific
reasons or guidelines indicating when malloc checks are necessary, and
when they can be omitted?

Regards,
Kuan-Wei


