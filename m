Return-Path: <linux-kernel+bounces-193442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908E8D2C67
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24546284B56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993715B98B;
	Wed, 29 May 2024 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DFTg6xH+"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57415B973;
	Wed, 29 May 2024 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960349; cv=none; b=gWXqx5HAXtsARhT5xQcwd6RZ5ogvCltEjKu761ClJql4E4U3UT9GkAE/2C+J967g23jodA6YD+PnUPqoMinvxcBV42fXt81ub8iUmTmuktTsSawMz5xGCwiXBfktJSutnMRTofskYIyjDW3uFIWi2w5GRHNNNERtJLV15rBkUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960349; c=relaxed/simple;
	bh=jsJYoS8DGX3hxwNHUmLC8qhImn1gQTaiM69u9xGndq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDfPDrGZ9kkwsw+nburBOkzrkleobSKs+YEv8O4IIO+tHwbRROjpPmYB4v+z6sFVrAjy3J7+Q1sDKsBhOeKxFvru1lCuvghwAhjjssvq0QRwgPfHeMsz3Wj9qqhvmyMwAC5kY3RZZ4oGebKb6FyZtR4h9HON+jE4d8tOY6UDmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DFTg6xH+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1zB7ADAhH3/m5KqcaWZDCOZlheLc2nTW1kK2ky7Tvzk=; b=DFTg6xH+KwerscLYQ/ecbT7OjZ
	xIcyXAkK4cu9/LjkVNF7sj2BwblJIz/7ZQw4diJF370I8VSiDyz28pz+h9vdOXVyvCQ+S/3BkVmz6
	W4GQ7F/Nqz/6s7j+6xs8lBofRLDvWOhkGjOFGQ9TO/+2ZOB+XtRlRmkJu/zB75g27nR8PsqTvhccb
	LZlmmn9CxmzjFMBbWGCqcMq6FDKHCXjPkVkou3VYmZs2+M37SwjM7b8YzUa9yjELCl/Zc8ChRqVLf
	tN/hEC9nup3OaJcxiJBjIzBRQfHkIk3LqNLpkUVpXTLCAUpH2bgLezy0XTjrK13fR9r4ycD0aQerB
	okSBHI1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCBol-002AJa-1q;
	Wed, 29 May 2024 05:25:43 +0000
Date: Wed, 29 May 2024 06:25:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Message-ID: <20240529052543.GL2118490@ZenIV>
References: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 12:45:56AM -0400, Nick Bowler quoted:

>        All other headers use _IOC() macros to describe ioctls for a long time
>        now. This header is stuck in the last century.
>    
>        Simply use the _IO() macro. No other changes.

.. are needed, since _IO() is arch-dependent; this is quite enough to fuck
alpha and sparc over.  _IO(x,y) is (1<<29) + 256*x + y there; both ports
got started with compat userland support, so _IO...() family there is
modelled after OSF/1 and Solaris resp.

kbd ioctls predate all of that.

Please, revert 8c467f330059 - commit in question breaks userland on alpha
and on sparc for no reason whatsoever.  Might be worth adding a comment
to those definitions at some point, but that can go on top of revert.

Folks, 0xXYZW is *not* an uncool way to spell _IO(0xXY,0xZW) - if there's
any chance that those definitions are seen on all architectures, they
should be left alone.

