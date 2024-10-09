Return-Path: <linux-kernel+bounces-356747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD6996619
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008291C24A72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFC1917D7;
	Wed,  9 Oct 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmgV7pnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE618E35B;
	Wed,  9 Oct 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467635; cv=none; b=eAHSaUrZwXNQSpfDAPQ6vAR9F7ECIMgITTcKO4l2ORHb9eAs5RvPbMY7EVH/RYnC3hqo3Q1oQ46TP2PM8YRX1UAClDTPzFU82LtpGDt2AO43krhVSMF1XHJ+xPA3z7SpugSMwEsxNnKvo5ntApBKJvJVCfOiVo0qwN6Kiydks7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467635; c=relaxed/simple;
	bh=wWY/kBHBtGx7dSflkfMGklu+KpxJfc4bWMZJCrBuCoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icDFU+Umq0JgDGiMxWiHThtIhfMuEXdiumNOnX+nlEfVL1iyCxQD5Fu8saR0F8nZLz+ZOFh2ytU42Dk9kRTn5PsO7mbVdQjQ4qSaTnBez2vH41/fqC29BKNRbXvtsk40T/tsFZMuWgqgCKBNhgLC/rF2tX9PW4UPKTjshTvdaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmgV7pnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81152C4CED1;
	Wed,  9 Oct 2024 09:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728467635;
	bh=wWY/kBHBtGx7dSflkfMGklu+KpxJfc4bWMZJCrBuCoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmgV7pnJWU5qlvVnGLrGm14zAet+kbdyrsyQqwxJ9Wun9WrSdPD2sn7JACNDU6nIg
	 Pf6b1EPfErURXQUiYXno0Pc691Nbo7SHqwD+goC1vhapahN5LpIo/nLxNb4gVAZiFI
	 tB0bjcr19wClwPm76U1LmgVUtkpLZgrItnLwWbMc=
Date: Wed, 9 Oct 2024 11:53:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	tdavies@darkphysics.net, dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8192e: Use MSR_LINK_* macros
Message-ID: <2024100944-baton-manger-3768@gregkh>
References: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
 <9bb46e16-eb37-4d76-a917-e0f1e738fd04@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bb46e16-eb37-4d76-a917-e0f1e738fd04@gmail.com>

On Sun, Sep 22, 2024 at 09:01:09PM +0200, Philipp Hortmann wrote:
> On 9/21/24 2:22 PM, Dominik Karol Piątkowski wrote:
> > There were two seemingly not used macros defined in r8192E_hw.h:
> > MSR_LINK_ADHOC and MSR_LINK_MASTER.
> > 
> > There is one function explicitly updating MSR (Media Status Register):
> > _rtl92e_update_msr - only MSR_LINK_MASK and MSR_LINK_MANAGED are used
> > there. However, in rtl92e_set_reg, inside HW_VAR_MEDIA_STATUS section,
> > MSR is also updated - covering more than MSR_LINK_MANAGED case.
> > 
> > This series makes use of appropriate MSR_LINK_* macros in rtl92e_set_reg
> > and removes duplicated MSR_* macros. While at it, fix camel case variable
> > in rtl92e_set_reg function.
> > 
> > Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> > 
> > Dominik Karol Piątkowski (2):
> >    staging: rtl8192e: Use MSR_LINK_* macros
> >    staging: rtl8192e: r8192E_dev.c: Rename btMsr variable
> > 
> >   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
> >   drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h  |  6 +-----
> >   2 files changed, 8 insertions(+), 12 deletions(-)
> > 
> 
> Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> 

This driver is now deleted from the tree, sorry.

greg k-h

