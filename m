Return-Path: <linux-kernel+bounces-365189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3299DECC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B86B230DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA518A956;
	Tue, 15 Oct 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHqVTHaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF9172BCE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975301; cv=none; b=C9jP/Qy0SxFijHuGRcWBhDQxJAN+LGhG8wT3MzK7q5iK9t1hwWApsBmIGE1JwSxsczETomLnlwYR3sZke2YCXPWFKcI0kJ54Etb8eAmIrtYCvu+d/tywuRm86D4/zvea5CbvR1ViFH0R0Pc6oZtHNaZcAVg142sGPQS0eWBHjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975301; c=relaxed/simple;
	bh=QBfRr33XPaqKkgF7ME2PD+/ZxPGLqwI2g+WHuNvDTMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGgL5LgvoaIAinCuzogNvW/P0rsyR8JHSFokQfTiU9vVNkTLmD15SbyDnBup5j+u0+6oH6riBdaw9HNjWKN5SsUokOp1rUpZC8rv49ZsgIKLoa8EHO1IT9iwil4+W85Waj44sy5PSpT7xxkLLYL7qETNO16rRa1qomwPEwEqYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHqVTHaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26CDC4CECE;
	Tue, 15 Oct 2024 06:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728975300;
	bh=QBfRr33XPaqKkgF7ME2PD+/ZxPGLqwI2g+WHuNvDTMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHqVTHajwpQjvTLtehNGRsmEHBLtLw3wkYhcIj3CNxeJbci+CcEgthqkZ5WmsPqGH
	 jHOSQWzPhQV2usAyb5Rl2mhOOWnTYSWQJ1xeJM2+NJfIQZeAM2f0fKQ8+1n7yDGTaD
	 md2w07n7k28TfmFh/KWj5qRZsJ3IyJQ3G+yt030w=
Date: Tue, 15 Oct 2024 08:54:54 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Ryder Wang <rydercoding@hotmail.com>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"richard@nod.at" <richard@nod.at>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	Zijie Zhao <zzjas98@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
Message-ID: <2024101539-ravage-talon-d70c@gregkh>
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
 <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com>
 <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
 <7138a98c-1562-3059-07b6-4d918bec9d1a@huawei.com>
 <CALGdzuokUpWhUk7uvWcDT2tXRRMk07dmKGS-rFANOE6ZwZZW8w@mail.gmail.com>
 <0171b6cc-95ee-3538-913b-65a391a446b3@huawei.com>
 <CALGdzuoWvy5WvpttC1pab309kZ9cUyfT5O7JB8VjsqwU2HD0Xg@mail.gmail.com>
 <MEYP282MB31641A7FD666B1EA23C1C22FBF452@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB31641A7FD666B1EA23C1C22FBF452@MEYP282MB3164.AUSP282.PROD.OUTLOOK.COM>

On Tue, Oct 15, 2024 at 03:41:24AM +0000, Ryder Wang wrote:
> By walking through all the related code, it looks to be a bug in slub.c rather than kobject or ubifs.
> 
> sysfs_slab_add() calls kobject_init_and_add():
>   - If kobject_init_and_add fails, sysfs_slab_add()  will go to *out*. But unluckily, *out* code block will never release s->kobj, but it is expected to do so.
> 
> Below is the function comment of kobject_init_and_add():
> * If this function returns an error, kobject_put() must be called to properly clean up the memory associated with the object. *
> ==> It means sysfs_slab_add() shall release the related kobject.

Yup, that's a bug, please send a patch to fix this!

thanks,

greg k-h

