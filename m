Return-Path: <linux-kernel+bounces-371619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7780F9A3D67
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBFC1F21CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC871D86EC;
	Fri, 18 Oct 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqTiSjYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA751D5CDB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251684; cv=none; b=l6k93+kRcHpAL4FEqmoBZaIlGLVBxLjGSOlzF2No95z4Uz4ATlEncvhmi2RKORLMO8ykARCCi2nVXqaS/zvSCRoBbaJyNDIwqiMUJehi0TNlYJKYu1upZ7QPUVAJDXjxKEPq36N4N7aJOoyVHvkpdJPOdx29qofZAhW4laJT+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251684; c=relaxed/simple;
	bh=F9ooUKybfV9HSFDIz7fIMSWHhrSPId0qkt4oVt5Me9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Knq8MHOtTiVkhDAingFErhC8ZCgkR2PZDF2PYSk267/t/Htoox7mpfvr6IpDeqIIRTfw3VQw682QBop5uaoP3B3KlBalfzjR1KFfKzyVKSCT0a8Vn34JaoUnLfDoNq/KPE5buuYbKwYGpJ1W+JVTz4jqFpUIdre+3Qf7Sfc+3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqTiSjYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65DBC4CEC3;
	Fri, 18 Oct 2024 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729251684;
	bh=F9ooUKybfV9HSFDIz7fIMSWHhrSPId0qkt4oVt5Me9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqTiSjYjgHCDaX9VsXHSlvUWu1xZ+z8OyZE6TpiqS3LZY66zirPb7LGVm8DC3+eqD
	 oZ/irAlO6Fo1oT9Ln3XqxqDCvoUQjsdxMliNTyjqhilX46q914ZIKVss04ZFJ0QMcR
	 VGMw/Bb1ybXTVyP4YyBB3Nq8T20iLaNEE9dxmn4Y=
Date: Fri, 18 Oct 2024 13:41:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] misc: ti-st: st_kim: remove the driver
Message-ID: <2024101806-recycling-attach-dc35@gregkh>
References: <20241016094117.16654-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016094117.16654-1-brgl@bgdev.pl>

On Wed, Oct 16, 2024 at 11:41:17AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This driver has only ever been used by the omap4-panda board file. This
> file has been gone for over 10 years. Let it go.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Nice, deleting code is always good!  I'll go queue this up now.

greg k-h

