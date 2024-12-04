Return-Path: <linux-kernel+bounces-431555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34C79E3EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27EA169627
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F49D20CCD2;
	Wed,  4 Dec 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwsZfyCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978614A28;
	Wed,  4 Dec 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327820; cv=none; b=GWcE/dFCx2mP8X3OOGimiRbFzEOCXKNrfKRkLYfS4rjYZT0zFoc6BXdbS2/4iu2ry2cmKIuYe2+xkfwjEg8G92mZKgxaF07Vae6cXgPbfLTquoTaBLYkEu9LvrLVe36XroIIBfB8+O2VcuADjEUiqXi9uTtjEcVWbewVI7vT8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327820; c=relaxed/simple;
	bh=7MuzFaF7/PzJgw3wMYY7sgx8oUD2VziZD1Y2qehSPBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcGa4Cikclg+R4KyuOQVhKcMzvxLcJtZ612zHnKUZOJ+hT8/kxVH+VPY/KIu1B4HfOIcoGI6I8oa+UU+ifXfQrr6kBvmuCK9b5lUG+f9Ces/KsAyd8DIwRueD5k1a7XXySd57dCjFAGLXUbgYSyUaCQwfT8OXqFZqeSujHUwIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwsZfyCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B69C4CECD;
	Wed,  4 Dec 2024 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733327820;
	bh=7MuzFaF7/PzJgw3wMYY7sgx8oUD2VziZD1Y2qehSPBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwsZfyCg63dksC7ETuAK+qJ2wnEPyEDcoUyWU+CBvBBu/jP8nDhW0k847ttEp6TjL
	 ynan2WSImgegH4d1AtXfNib6aldWq/Rm6dXu4si6tJzUx+n1CHYmTb2pORmAL8P/8x
	 rRzOa80LAlCj4NG4oEeUM7PO1JSI6ZMK5JPLBRkY=
Date: Wed, 4 Dec 2024 16:56:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] staging: gpib: Fix i386 build issue
Message-ID: <2024120444-apron-levers-d701@gregkh>
References: <20241204153612.22867-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204153612.22867-1-dpenkler@gmail.com>

On Wed, Dec 04, 2024 at 04:36:12PM +0100, Dave Penkler wrote:
> These drivers cast resource_type_t to void * causing the build to fail.
> 
> With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
> which cannot be cast to a 32 bit pointer.
> 
> Disable these drivers if X68_PAE is enabled
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
> Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
> Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
> Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
> ---
> v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
> v2 -> v3 add changes for cb7210 and tnt4882 drivers
> v3 -> v4 disable build of drivers when X86_PAE is enabled

You forgot to sign off on this change :(

v5?

thanks,

greg k-h

