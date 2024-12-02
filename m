Return-Path: <linux-kernel+bounces-427898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B834F9E0798
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9492AB455A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B75620966D;
	Mon,  2 Dec 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED0belKg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA720899D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153712; cv=none; b=QmvxvRC86KwZhzHpkCTXIN4jhjGJhlPe3q8CPOzc9QS+MqwaZBN9B0XkveiXvnRMK1GinyWxvxPuknbju2tFJkC1IROuyvwiAYP16ZQp4AXL6GxswOIhR22tHBZXSrPE2gBp/tzNGVhYqEANNd7jvI+mcB5JtYBZ9+jVHEFTcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153712; c=relaxed/simple;
	bh=Gh0oZs8+YzMS7aG0V1l/FJUBvC8sDDhkH8XK9OIML+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY4U7bjHrkLcH9/QKvjMIcFPpRF92UajllU64Yv0Es8juSQLP2g3wnJ3Acj9rjGCX/+Yu2/t4eetNhCXd2oHF/BOEr+TfIU1ApnnC6fGUspMEBqbpSijhTi0hmjUehZwzmIlJadHkyx70H2rxG7K/pl3HKzGEmZLGKdg1CoR56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED0belKg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so37536055e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733153709; x=1733758509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwQoSlg/CRXta7tinu4nzK9A8fmWpb1sD/ndqJQH9ZI=;
        b=ED0belKgtJQW7PyhRcReH1aS72/fZgr52qn4dRWo0n30owcwEoAW/R0a5UnSNUbkFi
         FsttFpXhwDDuZfAccFZW3GAdJ4LSTfsnpuimroHDyInFUZ3QHCvlcVajCuZGGoDuOHY5
         GbBa/bOzgO1UsRJlliK/6TuknbbWOaY+80GX3kTS8BP/aojSCiqvPnhzEu+MkA9Nac+9
         B8dDbCRSot3wLDBuSjsiFwiGIijsj9Q8EW0xrXkQUQHQq+2L1xNjxXJs6HopaYhreXiE
         ocpeBwYVJzj0cZlZkYAWZYATfMV7ae7a4RrmF2sXHW37RvPaTWslkz7V7rc07dmYkQHt
         LMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153709; x=1733758509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwQoSlg/CRXta7tinu4nzK9A8fmWpb1sD/ndqJQH9ZI=;
        b=Kwhi1oHhDSvkQpr5alsQbeuMKE7uJUJD3xcS1VmLyBdLKJptT7Fw/ZFJ2qrF/4H1sL
         utdiUlBaxDBd7g7xY4uj8ZSFlGrp5PjnUfYO8RbfbvwnG3ecTn8WTxNmoOWGKXqEFARz
         8MyNeBAPKXOSb8bHhctxY4jh+UgXezd/IGPpq5UrhTOiyNO3cbKMf9k8O8rLuVOfQ96i
         PyRGHpCWxHUhDE2/R/NgdbN5Fgn3BxyEvFbFjmQbneRZC+pANFE5UYaPy3AxB1iiVvLM
         ZlaEXvXjwVxCHcbqg1c4pZh+5GPpKYN///OFASmDK4GhY6RLNLisHEVQtG2Cpm489exC
         eX7w==
X-Forwarded-Encrypted: i=1; AJvYcCWppxj1TlLF+76UAIg9SgAv8WeB6pDTLtDaufbPE4CbfAqFoDuvLHNCPe6W+rnD1wpgkvudz/4qNawxM4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnczry5MObipBpmruzbUDw8Vn/4Of7Y106LNR+jbITclf/+AyP
	oekJZS0Ba2i3IdgXSzg2r2cJni5qDxC1HXA4ZI7B+ROxL56Tw5uADnDajQLF
X-Gm-Gg: ASbGncsV2PMvtgXaOO1wPxqXJRADh3iRwj2HPjLaghtwfgf+Nv3Zxu8eIshC/ZgJGYC
	T7y2SgQg9RqJ7TFE03kqhLQNCp7GKJ70sljopbyZKyTBamlMQ/RLOh5HJt7kwPLucuyyHbjgIST
	jUgD+UUKpYcZVK4G6sMJcZUoaUFdvMDesgfr77MDcILmD4wKZEK1M51sllaCnKfZ9oZaIlf10FY
	sL8OqWZlXtXISxI2Gc/Bcw4sLkP20aZd4yVtAq9dny6ENSG3Nl+KxGWujjO4/6N9w==
X-Google-Smtp-Source: AGHT+IGBTrglvrKp5qU2mZgN2kGd2HuOxElLlSuOyMKA1D6iXB7TZwlqKAUTda4yKuSfgAlf2BaINg==
X-Received: by 2002:a05:600c:3585:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-434a9d328f1mr229926915e9.0.1733153708961;
        Mon, 02 Dec 2024 07:35:08 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm190838035e9.44.2024.12.02.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:35:08 -0800 (PST)
Date: Mon, 2 Dec 2024 16:35:05 +0100
From: Dave Penkler <dpenkler@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <Z03TqThAOa29MEjD@egonzo>
References: <Z0lCyXBV06VyH96s@kroah.com>
 <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
 <2024113025-sly-footer-3462@gregkh>
 <7d7e65af-b818-45de-a92c-ee59a864dbdb@roeck-us.net>
 <Z02Cz6GbdtGNPywE@egonzo>
 <f4ded99e-35c7-4651-8c73-376390ceb130@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ded99e-35c7-4651-8c73-376390ceb130@roeck-us.net>

On Mon, Dec 02, 2024 at 06:52:28AM -0800, Guenter Roeck wrote:
> On Mon, Dec 02, 2024 at 10:50:07AM +0100, Dave Penkler wrote:
> [ ... ]
> > That is weird: the type of resource.start is resource_size_t which resolves to u32 via phys_addr_t on i386 which should be the same size as void *
> > For compile check purposes simply changing iobase type to phys_addr_t the following error message appears:
> > 
> > drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
> > drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >   783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
> >       |                            ^
> > drivers/staging/gpib/ines/ines_gpib.c:783:26: error: assignment to 'phys_addr_t' {aka 'long long unsigned int'} from 'void *' makes integer from pointer without a cast [-Wint-conversion]
> >   783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
> >       |                          ^
> > 
> > It would seem that for some reason phys_addr_t resolves to long long unsigned int
> 
> Check out CONFIG_X86_PAE, which adds 64-bit physical address support to
> 32-bit x86 images. Pointers are still 32 bit in that mode, though.
> 
> Guenter
OK thanks. I will submit a patch to use ioremap.
-Dave

