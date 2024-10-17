Return-Path: <linux-kernel+bounces-370628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26A9A2FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DBC1C22FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732E61D5CF1;
	Thu, 17 Oct 2024 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0MBmsDo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDC21D5CC9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200751; cv=none; b=jUuecn88ySs6BKJ53X+jJoNJWjwVgmpRec4lJBmraA5/Dv7ZqdtNWdVBifRSJDBHG+jnTo7lboVsyMn6CT/I9K6VDKA4WuPhsa1V6PLEp4hXgICKEAj0/sygnaSIFJnwbQzicY0HbGI5gN2xJfTVEsMcyzFC6xJZa/J4asI2z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200751; c=relaxed/simple;
	bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeURCckBUT9eBXwQRHrF25qXXWTMCNb/uqdKKlNEZXXi9jTGtXvH06dJ3knZs56QrsYv+WCTQTehiuyKwTM8XLiqvf/n/HJYSXR2ip739iyNOGzSMENddLDDnFJImXmODbixDr/FqpG/OKY8Mh+le051dhvxftAXrTSQJ3sz+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0MBmsDo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso63745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729200750; x=1729805550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=;
        b=h0MBmsDoNXdR3uMW06MuGt+3Kk34e5X9v88Y8+mwvs7cmILJhcnXHHZuy3T2AJZsLI
         PtqFujfdtL7/L/ofWQ6YNX73vIbJFmkXJqjq+EWDG1TPWS92jaX5srBRdDVVRGErsWWL
         NQ0ieGhYEKWyTOtR9K6XmCXS7cLI5PD8sePLdUN2rWX01H8z61j4XT//Rmm+9dzWmQEM
         pWglNnKtqfwsVajVNn45kDd6b8EbQaji+nFsbvCPMwiq3W/OslR5gYBrtXPjhwjnj044
         zyUpU5P2/udduhC9X3V2kTvay3lEvcOHbdlZkxcfMNcmc6bxZSQGyQRhTF+2Nl935XCF
         /KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200750; x=1729805550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2+wb2LgzRJhRj6yefyqXu/CkuSPpP66P9LaMg8ISWo=;
        b=IGolyxaemRptUeiLjtlosvQhlk6/02ZBfqNpJoXeEZ6QM+E9eYajbpJ+ZMirigHOJ0
         ri82rietAJZpoUJZ3hM5m+xVIxpAW6aQc4QWfzLm6h+jh2t8nq8IiNDzEbNjkaBMhydU
         2BxU7VJezFVM/VYzFp/6PfKt2sc3xcem7Eu8hBCnmSodk0f0lufTagP8Jrck9O+fHZ4E
         f2sBxYZnC8aZo7O49dZ6/tKmt9T3KTSa5zAVb7WcjByMnfk9Ez7PX4vxFjuSKYSjTLps
         5q2Pq9XdFQlWaQfWLFV9BE1bEBdlcPkquFsdmSRCeeh155AUEcFnUAbMwR9ZXFJU89XD
         329w==
X-Forwarded-Encrypted: i=1; AJvYcCXN1k+w+AR84KoaGT4R+AWxp/NNEUZDDLUSsmO7yxUXquiQiDgfbEEwFUBgAuiydcxImFzYPyujRhDi3QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoGu2Q1H5VV8kOWpxxHrB0HsMNKNGIqpCc9X75TvVaeNmErPH
	3yoGKjBGE5NkBqK5uaKvOvbF/2NAqKz+H0wzZ18Dw5VNZ0SLJNTo+rjNBsrnvIBel3Bngg0M+mQ
	AmZs2/MDzukCJd7SszUbLoV1+onlICDgjDDVv
X-Google-Smtp-Source: AGHT+IE4ntQMyyyTm5zlYwq2ofxDyZx5MXuYcNqBg/PzTdgdJREmYHhcZb5mzIIg2QyNRoAPQcx7cbMrES36X5k1Tng=
X-Received: by 2002:a17:903:2342:b0:20b:bf5a:c8 with SMTP id
 d9443c01a7336-20e579af565mr890875ad.10.1729200749514; Thu, 17 Oct 2024
 14:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
From: Abhishek Bapat <abhishekbapat@google.com>
Date: Thu, 17 Oct 2024 14:32:18 -0700
Message-ID: <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Prashant Malani <pmalani@google.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:40=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS =3D 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
>
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.
>
> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too.

Are you suggesting that all the files from the queue subdirectory should
be included in the char dev (/sys/class/nvme/nvmeX/queue/)? Or that
just the max_hw_sectors_kb value should be shared within the queue
subdirectory? And if not the nvme driver, where else can this be done
from?

