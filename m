Return-Path: <linux-kernel+bounces-336567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C6983C72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F41F22892
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995A49652;
	Tue, 24 Sep 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HewoBtYU"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C310BE65
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156517; cv=none; b=aMhwmJop4NZxkwN2rk1I2058biN4ZBliWwlHlYrKHJhjKUGpCOL6+5Bk/Ms4rwTo/nD8j//GmF4RfPffJcm5Ez7XkdKIpXb6nh9oJAXnmheO6VuLVGGEBqGgqYLDThCzFBQRP4CXgil0jVp9eUacip37oHpfD1UBunV5/N6fE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156517; c=relaxed/simple;
	bh=jH6sv8FNLFl/Kif28e2IwbxyIC15AJwFwxX0qKHVeUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMCdowN58N53k6lFobL0wf7QABFgHIX5kPdjHIBK0PRaXnTo+HhCsOqivygKegXwq879XUPOWsWaCmwAIjTrwqmhR9qgm9LiwOftAk8DBPuPAGHeJL7z9Q0WHN1E3BD8Z7qgXgddomv6I8REGm2NBfqb9oVsvS9IPppA677fM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HewoBtYU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so12317a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727156516; x=1727761316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=HewoBtYUFcwrDJxS/LiYKia4PdxpxNFPuST4Jd7FT8su7mdpEkHebJPWVow345IjLX
         SC19yurgWbb/Vtl6/kNTDclLo826TtFg+THGLxZuNwD1/kPIXKlyi11K1mZEFIe4oIPh
         WxXGuOwc6n5fSErJnkVE+381ZWQYOWA6vsmOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156516; x=1727761316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cge31yltZ3LBqF6Zjp76yFNSwmaUL6JImZQbh8KHv9Q=;
        b=r+fcktB8+8LhHINCoWQgVU3ODmyTNJiSf4FXmgjSaY1uAYyRYJIuC6Uk2vlOFsJkWW
         ESv/Sc3DzVSOPShEGL7DLmMc/bGT1rTeINBfIoJoqt0K58XPi+qj78nHr7DADHafst79
         jcjepYpBFR2r3DWT22Exx0KzUHNzSqqMnZ7bCYnoy2R/HRXD0+YfsZJYfZ1KzyZ35Q1n
         Ij+NCk0qHqYAjbPnDNTfCeg73o0HWXXoVq4xbwgv8VTp5O59ZDnGydzx1Fe4K748QIrZ
         L9FFYwG2e/1Iezs0tbbRh4G8tMZPXT5wQU+2f1IIE82KY0D1p0h+P/jnqKgWNsJ9XlYJ
         KeSg==
X-Forwarded-Encrypted: i=1; AJvYcCU6k/VhgmtZ6LWH/5eNgeJwdcnm3agsOvTHjRQ7CNbfG4TpZ82CVCrYfFEvXnWzNnFEouyjjbJWG1v9uMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pPcnW6t2JMR//WE2BFNDSyPOtk7rOl/yjY1g/3eFnQ3aJehR
	LdCcMhNz7OzabnK6PvsgXhgJX2L795BthnkXUu0PG+OArntHt8WUIW8Gc4taLA==
X-Google-Smtp-Source: AGHT+IG1lZisxJAgOWdpQ4rLYMltGE4fxYOV29zGec732JAMjhEQW5CudTcv6H4bnb03Tqzw7xN0QQ==
X-Received: by 2002:a05:6a21:168e:b0:1ce:e725:1723 with SMTP id adf61e73a8af0-1d30a9d8901mr19524958637.45.1727156515684;
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058ee6110sm590246a91.8.2024.09.23.22.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:41:55 -0700 (PDT)
Date: Tue, 24 Sep 2024 14:41:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924054151.GL38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
 <ZvHurCYlCoi1ZTCX@skv.local>
 <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8294e492-5811-44de-8ee2-5f460a065f54@wanadoo.fr>

On (24/09/24 07:21), Christophe JAILLET wrote:
> > > Hi,
> > > 
> > > maybe kfree_const() to be more future proof and less verbose?
> > 
> > kfree_const() will not work if zram is built as a module. It works
> > only for .rodata for kernel image. [1]
> > 
> > 1. https://elixir.bootlin.com/linux/v6.11/source/include/asm-generic/sections.h#L177
> > 
> 
> If so, then it is likely that it is not correctly used elsewhere.

Oh, apparently there are drivers that use it...

So I suspect it works when you do

	kstrdup_const()
	kfree_const()

// I only looked at drivers/firmware/arm_scmi/bus.c

kstrdup_const() can't tell module's .rodata so it does plain
kstrdup() and then kfree_const() (for the same reason) does
plain kfree().

But calling kfree_const() on something that has not been
kstrdup_const() is unlikely to work as intended for modules.

So I guess kfree_const() works only when paired with kstrdup_const().

