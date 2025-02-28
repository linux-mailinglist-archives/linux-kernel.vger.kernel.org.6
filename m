Return-Path: <linux-kernel+bounces-537559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD0A48D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34033B110F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663C748F;
	Fri, 28 Feb 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/anx5jJ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FE276D27;
	Fri, 28 Feb 2025 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703189; cv=none; b=nFcL1fIL5Q5SXeavmg2HIjNY/7ETOtaRRN4Bv05UJ+8MbNnDoVoEZGwr+jdwC0MxzzYwg10X00+slI/w8pevKFhuOGNlN214GcCPFfZjms/ji+J+12KWr3wqJSM3i59YPz7N9+QSsvTb7mDH6J2Vpg9p0OL+Bwl7mpFPTy3umR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703189; c=relaxed/simple;
	bh=v2ruyhUklWLE/O5IYzG1DXaxpknq5sYzG4l/avzLBGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpfAdSp+1/c6zSCUxQ+SvQZe1XhGH5y4+Clkr0uSOEaJh+wMS9lcqekqahbNaex02gyOX2N/vROw/PeJ9O5NicXgI5pTip5s8tALFoIxu3qSepY6hi9VHr3ANdRtqJAFQCZDSp4+abmP00ih+MisYLWvEqAsaoJK4mYrbglIKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/anx5jJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dd049b5428so14350506d6.2;
        Thu, 27 Feb 2025 16:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740703186; x=1741307986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NS+/iUnzQt3rNEJ1NDY4uxNPpsgUI17G/QJLjXrYJFg=;
        b=I/anx5jJGm/JqIZcggpY2hpACAzIILxKYGf1YE/Uq5ave+X+ASKkXFQeYS2kk6jbA3
         VAwENjvHfj3k5ZXgisgEZR2WQcww3R70Q93U+8xr6crDlvc2dPos/MyDZ5OafBJFq0P9
         ilBi14glnQxZ22jYIRv4uN2qsfKg5WDB+3z+o5nsLlYak1XjtpN1usqKk7iR1XS2EH5/
         5cwMRir+sjVsRUDIlKicImFVX+WpAoBZpIOYWGDwioHnxiKNPyFRhfh1nmy9WEt0pCso
         v1+kwzJgGqFfBpC7YD6+E96cKMISMhYqhgTYG9GMiTvAkLpo15FMOuXLIOjP3rqsAe6O
         j/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703186; x=1741307986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS+/iUnzQt3rNEJ1NDY4uxNPpsgUI17G/QJLjXrYJFg=;
        b=DpoU/PMNx1YuvjcS0FJurN8n920hptCDWaV1RBJDlHu6SG80VGOjRy6A9Dd5FR0oT2
         buQZV94X8pw19u6tKDmkGbOou3RAnFJIdy9rvHzOKhfGaCZ7HmW++n8SPfk9vfujUZjc
         OmJV3VeSUzxx0Qg6oCFlK+Hf3Xyr1CjSebYRCH88yBd8yY1VkWarrly2md9K11Adq2yb
         P2/xRjmOiqmqSL8aaWRgu7F4zVMf/U6Vq28/YLkZGO9qs9QdgP2P0Uqsb6c72rjanZSK
         Vv2vPT5x5REyGaM8vKcx3SP4LkJRaOK8BArdSa1m1dhPOc3/zOXmaQ0ixGoRQqmg2xdm
         kddA==
X-Forwarded-Encrypted: i=1; AJvYcCU+1TbDh10xZfuv2r9F1sAgthhyc/q/assKuKEAj7+UHvzw2KXveH1rlz2d0OJpTjtMCndlY5vpFNSq@vger.kernel.org, AJvYcCWMm7lcjQLEzzMy5/bxsSnILLROuqEI2NYZ/fDzdM8yBmdr37z3wIdLGaIUeX01DaYP/oj6IuYeKXdKENgE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+MYfq2r3pxrlI9tlLmLbGSToT/4AorffYOMkceZKgTFnp0GUW
	vQ+VvhIuZ++1mOzT2XcHO42hR+Bex/aCfJeLFKa+ZyEfk1uBT9C8
X-Gm-Gg: ASbGncsbCRlg2du6Ksi5mzFg353prItS0O9NCMDuIz2VQPL//S3ktqP2+lMidAmM/XM
	rOSsiG4FMC+kZl7qHqCbp3C08KnGSKERDLLDytSVDDtBJYjoPVl7WjF26HTVbo+/KjUaFLTGrTT
	zuJvQYgDeZxa3kvHcZ3exr2nY31FlILkpwbA5gIgLnBWYNWgX57TYZT5U9tpJAwgScYcyOanIHP
	qIjt2h3SyhYYVKUaHG+XsMnBenDh/UuB+O1c74HZFY6AHB2WWL0NutGVanaX66DR5xxgU3GBf98
	BA==
X-Google-Smtp-Source: AGHT+IGW6OtjFhte78/y7mXicDWR0r1px1BSDbRwNbpZXXNdzJwgIrFoEnObj2orAz8Dtj3dyg6Yrw==
X-Received: by 2002:a05:6214:21e7:b0:6e8:86d3:be78 with SMTP id 6a1803df08f44-6e8a0d94b6cmr23116156d6.37.1740703186527;
        Thu, 27 Feb 2025 16:39:46 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e89766166esm15959336d6.61.2025.02.27.16.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:39:46 -0800 (PST)
Date: Fri, 28 Feb 2025 08:39:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: reset: add generic bit reset
 controller
Message-ID: <57tveujqmthjxdaad67i3qv732zwmjcyymnsluyf65xdpmfvkd@cqrwhuylthmd>
References: <20250226234234.125305-1-inochiama@gmail.com>
 <20250226234234.125305-2-inochiama@gmail.com>
 <20250227133509.GA2021892-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227133509.GA2021892-robh@kernel.org>

On Thu, Feb 27, 2025 at 07:35:09AM -0600, Rob Herring wrote:
> On Thu, Feb 27, 2025 at 07:42:29AM +0800, Inochi Amaoto wrote:
> > Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> > a simple reset controller by toggling bit. It is a hard time
> > for each device to add its own compatible to the driver.
> 
> It's a 1 line change. That isn't hard.
> 

Yeah, it is not hard. But it is annoying and sometimes
I felt it is a waste of time to add a device id to the
reset-simple driver.

> > Since these devices share a common design, it is possible to
> > add a common device to reduce these unnecessary change for
> > the driver.
> > 
> > Add common binding for these kind generic reset controller.
> > Check the binding description for its requirement and
> > suitable scenarios.
> 
> We generally don't want 1 register per node type bindings. That level of 
> detail in DT has proven impossible to get right.
> 
> Rob

It is not 1 register per node, but a contiguous range.
In most SoC satisfy the requirement, only one reset
device is added. This is what the reset-simple handle.
1 register per node is too crazy for everyone....

Regards,
Inochi

