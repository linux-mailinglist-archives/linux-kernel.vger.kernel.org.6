Return-Path: <linux-kernel+bounces-367525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D79A036E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895212810C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97F1AF0AE;
	Wed, 16 Oct 2024 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yHRkzFjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC10165F1A;
	Wed, 16 Oct 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065626; cv=none; b=uYpEXJvobHXIH7vZcLuv5SXD1YcjmUbGpIyMM/N3AOQVQ4rMMpaHGHgBtR8oIusnYTiA76ZM6yNQ1s7+CqnyYHd7DVq4iFsNQY4oWD3otj8dfZUGfZdoSjZ/tB/AVDcAJur6ZpO1NdhqLMckxEg/N/S9nZokyCwM90Sa2taLyDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065626; c=relaxed/simple;
	bh=+zWcV0Csss2iSqIzflJwBTZ3Csh643N3Xb+LobJZqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th4vzUPSYbx8IAsJH4GGzdkFGP9xskTUP81d62UJi8GsgyL9yWt3CLgzUvR6dj6yoHGAj+K8Y2QUHikIP4YL5zkXyV0i+oFncxoiP0AeF0YEamdlt8sjHFOtuNPjv43IRIi1otpvOvz+GK9pvuT/W1OhuVLdLB+yAvLpEff0rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yHRkzFjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F6C4CEC5;
	Wed, 16 Oct 2024 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729065626;
	bh=+zWcV0Csss2iSqIzflJwBTZ3Csh643N3Xb+LobJZqm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yHRkzFjS8AhAmEPuG3FgkltCz18azFiIchAhUaWNDBJtMNy/2M1S34a4d5sj3dAri
	 YQs8SNQsr3BYs0HBhmtVHKahgaCI9mgrtFcEhhufKWJBr06qt3T/VgyctALvluj9gb
	 chUFTSb7pGMdpscT/wgdHwPNItNSgvxPLvBv4aL0=
Date: Wed, 16 Oct 2024 10:00:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH 1/2] staging: rtl8723bs: change remaining printk to
 proper api
Message-ID: <2024101608-daycare-exterior-31fd@gregkh>
References: <d20087fc-586e-4a52-99e6-6a09b33ed00e@stanley.mountain>
 <20241015213822.8070-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015213822.8070-1-rodrigo.gobbi.7@gmail.com>

On Tue, Oct 15, 2024 at 06:38:22PM -0300, Rodrigo Gobbi wrote:
> > No, this isn't right.  You'd need to use a mix of dev_dbg() and pr_cont().
> > Basically in drivers it should always be dev_ printks except for pr_cont().
> 
> Tks, Dan, for the answer and suggestion. In this case, rather the dev_xxx(),
> do you think we can go with netdev_dbg() since this is a network driver and around
> the rtw_mlme_ext.c is already being used? (actually, I don't see a direct reference for struct device).
> If yes, I would mix the netdev_dbg() and pr_cont().

Please use netdev_dbg() for a networking driver.

thanks,

greg k-h

