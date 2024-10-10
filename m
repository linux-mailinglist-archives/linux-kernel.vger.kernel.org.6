Return-Path: <linux-kernel+bounces-358424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB58997F29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945B91F22398
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8978B1CDA01;
	Thu, 10 Oct 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ptHPNc+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6F1C1AC9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544333; cv=none; b=VnlQHWQDajGVvBHzNHcpbh4f3DkA3lbVCq8dDMShra/gKhXljomxJATyEwGiDbG/i97BAep+5v2oZvS3hoDuf6XytGgD8SyTQ38SJfDk29kdwWeRfEvMrjI7DpMQBjJDUa8jJ3xf5JPI++mOw2oT+vrnuU4h2APFs4rEoA7x9LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544333; c=relaxed/simple;
	bh=yOq42I9RGfTGaGi9V4LRgC+YE3kzvgDiv5Y/Cj0zN3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIPasmVnvqkeBFi2PbwzqcQK966yU/29WFq9gRxG4dT2p+8TVmw2DRviOgvFkLHJRlk0GZ9T7aI+737906/wqTm51xamgZJ77KSyPd6V6ZAg5BPCV9HhFcZYwK3NMJdaWqbeHTgC3PGICvCE/QsczKrNGHIhRxLXauWWqVK0gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ptHPNc+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F10C4CEC5;
	Thu, 10 Oct 2024 07:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728544332;
	bh=yOq42I9RGfTGaGi9V4LRgC+YE3kzvgDiv5Y/Cj0zN3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptHPNc+/b1wzzvsa/YGUQvlG9DWiVn6muxuvhhkriHUWztJDSBM9eLEIqixvl2BR9
	 rsepWSUfnt8tjlDPTq6liHx+yEeb3oaPfJSMWWS9OGXGGJaQUkZzd/bFFJI/kfqZH+
	 LLqzDs9xz31PY7AgrfUwRldEydkjecqG86dZAekQ=
Date: Thu, 10 Oct 2024 09:12:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de,
	Gerhard Engleder <eg@keba.com>
Subject: Re: [PATCH 1/6] misc: keba: Add SPI controller device
Message-ID: <2024101026-scoured-conductor-c92e@gregkh>
References: <20241009202949.20164-1-gerhard@engleder-embedded.com>
 <20241009202949.20164-2-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009202949.20164-2-gerhard@engleder-embedded.com>

On Wed, Oct 09, 2024 at 10:29:44PM +0200, Gerhard Engleder wrote:
>  static void cp500_register_auxiliary_devs(struct cp500 *cp500)
>  {
>  	struct device *dev = &cp500->pci_dev->dev;
>  
>  	if (cp500_register_i2c(cp500))
> -		dev_warn(dev, "Failed to register i2c!\n");
> +		dev_warn(dev, "Failed to register I2C!\n");

Nit, this doesn't have anything to do with the original commit message,
please be more careful when splitting patches up into a series.

thanks,

greg k-h

