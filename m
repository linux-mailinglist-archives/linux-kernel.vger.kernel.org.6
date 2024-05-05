Return-Path: <linux-kernel+bounces-168900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD918BBF7E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 08:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19B3281DB5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5155227;
	Sun,  5 May 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMRqOa3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898B23B0
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890931; cv=none; b=Vvm5CdMUbKN9ibwLQv+t+Ka9w19F7obJKljHdNuFHAsAYJFRZXPJdgXUw40qkd/w50022WHABQDHo7ES6tUGlLhlUipn8jFsDRbMmTrluarjqAZCABu6uq1cxC7iZuo6JnAydBlCeqkk5Ab7kimRGe8hhVprP2lANVmDEGYzl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890931; c=relaxed/simple;
	bh=gFaeI539orZAgT5wkU5JG5wAxxnsGcBtRPmEi/gqe8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ06NrPh71u8Vxh0Sy5F1aBDIObj2VXyt9lXYfTAflAUAT9VcystVvSE9C7gCJF2xSDl7gpE0o9ky+j/73FwhhfATYSnZ0OYu2HpWgqjEQYDIw9efIU4GI0+yV6mxMyaqche71+tIFYb4ScbFDAgnoFIKqAo3mEQLYURq0iTsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KMRqOa3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523FC113CC;
	Sun,  5 May 2024 06:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714890931;
	bh=gFaeI539orZAgT5wkU5JG5wAxxnsGcBtRPmEi/gqe8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMRqOa3p6TIsm+2Y6ifM9UewlChvcUvUs9L8ItnyTEvHxjpjesfV5Ib+p0i+cPMWW
	 HQN1zR9TWJJT37UAl934x/ZoTxO8mR9aXwHdGjQ2dJYUo+exLSd0ppjvg2mqX5RXWe
	 Pgdl1TtDdWtV3oSsKbAqRBBfrXjWEtWAyWZduObk=
Date: Sun, 5 May 2024 08:35:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Haoyang Liu <tttturtleruss@hust.edu.cn>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	hust-os-kernel-patches@googlegroups.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: Replace simple_strtol() with kstrtoint()
Message-ID: <2024050505-clapping-preview-ebcc@gregkh>
References: <20240426202532.27848-1-tttturtleruss@hust.edu.cn>
 <ZjZ80FAYcYtaeD8M@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjZ80FAYcYtaeD8M@surfacebook.localdomain>

On Sat, May 04, 2024 at 09:22:08PM +0300, Andy Shevchenko wrote:
> Sat, Apr 27, 2024 at 04:25:32AM +0800, Haoyang Liu kirjoitti:
> > simple_strtol() is obsolete, use kstrtoint() instead.
> 
> It's not, but kstrtox() is preferred.
> 
> ...
> 
> 
> While I'm in support of this move, this might break userspace by making
> stricter requirement on the input.

Good point, I've dropped this so that others can test it better first.

thanks,

greg k-h

