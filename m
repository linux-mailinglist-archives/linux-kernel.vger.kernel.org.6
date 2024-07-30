Return-Path: <linux-kernel+bounces-267134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1BD940D33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E755EB24573
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D2194128;
	Tue, 30 Jul 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fIEh3emR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D3190053
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330674; cv=none; b=PLU6bGPIg9tP0XAyTwLIpBjS0qDDnygSQLzmc/nzfqzuiAT51gFhYr7ONzR+bQhtpjaX3OfWqDJlKfOdnhB7TQnqGhO3gqQXIg/XJkXXAR+fQURglzfgF33+xbs4OdkrxKE7ca/ljonpxzm4SPOhOvA9qz8/dIuRwHAOBe0TOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330674; c=relaxed/simple;
	bh=P4r0hpSVC0IGRRQnWdZiZIMkucKEXf/5vvMZv2w81x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVnYUcWRlVtVBpCPxk0zeavv7SZgzmvoChUJMmKjCreUVcyrTaKaSsyXK97+euwHp04SdCGYfeUPrHSkEgqmbwil8u9ZkIw4k3zs2EJPq0b6Nr0Ra8o/XFl/tumjcI2Ka3WCrhACvphyt0BzFZ8x0QpXgir8+QCHamkfAh/OTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fIEh3emR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C840C32782;
	Tue, 30 Jul 2024 09:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330673;
	bh=P4r0hpSVC0IGRRQnWdZiZIMkucKEXf/5vvMZv2w81x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIEh3emRSjsB4V31ZQQo5z6EqMQZJjW5IZzSlGkBtkClz0QyFqxRwhrB2HlGabH1Q
	 wyTxw32kNYt6R2e9bI4mSbO8p0mRRa2ofH8FmYCgFS3qMPEBkNR9fBrUwYDUv2nT4J
	 Dl8TPEmxSzZ3d7DW4BG1olX4mxOh3Vt6/DNgJGKY=
Date: Tue, 30 Jul 2024 11:11:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH v2] char: misc: add missing #ifdef CONFIG_PROC_FS
Message-ID: <2024073029-zippy-bats-ca30@gregkh>
References: <2024073042-observer-overflow-cd04@gregkh>
 <20240730083158.3583-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730083158.3583-1-zhangjiao2@cmss.chinamobile.com>

On Tue, Jul 30, 2024 at 04:31:58PM +0800, zhangjiao2 wrote:
> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Since misc_seq_ops is defined under CONFIG_PROC_FS in this file,
> it also need under CONFIG_PROC_FS when use. 
> 
> >Again, why is a #ifdef ok in this .c file?  What changed to suddenly
> >require this?
> There is another #ifdef in this file, in there "misc_seq_ops" is defined.
> If CONFIG_PROC_FS is not defined, proc_create_seq is using an 
> undefined variable "misc_seq_ops", this may cause compile error.
> 

Why is this in the changelog text?

And what changed to suddenly require this proposed patch?  What commit
id does it fix?

confused,

greg k-h

