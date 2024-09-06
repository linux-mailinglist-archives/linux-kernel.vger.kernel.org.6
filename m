Return-Path: <linux-kernel+bounces-318828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8FE96F3E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A341E1F22EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDD1CBEB5;
	Fri,  6 Sep 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9b1Nctt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87B1C9EA2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623970; cv=none; b=TCaSQvOSXJam5oSAJpP4GSLVCgTor441w91vudOKCc6x0vM/8ECX9nJrkycAdEUYDyX0PlGY8elUGgcn2V81HUPrWRRv2x0UvPNVzBgACaMfSXpnOfOOhfE6MN32i1PGYxIZmw8uIxvR/ekqHHRYjUvnYcVs2Yz1idzmHgjhB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623970; c=relaxed/simple;
	bh=RKisea1lTKf5hHJPw+zIrhHuk5bkM6LHhsGUuH9ZCKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1BYinznGWQwNkhm0IesIt8jGqpYVSMrIszVLzsIs+wMOzS2hGLdJ9Nii0okuN85jA/YsdRhJzcyv6F9d0OAkVcJcHkZbRm4XFiHDx3WrfSlVi9VnvfUZtS/BrPNOmTfH/QUc8sZMyPBEbTvvzEm/E0m+1sYdfqjueZ2E5Hr69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9b1Nctt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E1C4CEC4;
	Fri,  6 Sep 2024 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725623969;
	bh=RKisea1lTKf5hHJPw+zIrhHuk5bkM6LHhsGUuH9ZCKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9b1NcttfE/HpDYpXwCgGPUpGJ6DXHn4Ln2uOXZIta63cDEA2UsaFybPW3wG6ct8S
	 /yUv7DF4YyOMxP5yKodv5Ama/0AVuBSmzOZpmWRmLcDJAE5xsLjw8HkddA3MOOBAQC
	 3/geSewUarB0t0c71M19vHs1pIsgvPtow46ndmvI=
Date: Fri, 6 Sep 2024 13:59:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ni_routing: Check when the file could not be opened
Message-ID: <2024090629-exploit-striving-d2c3@gregkh>
References: <20240906115402.30894-1-RuffaloLavoisier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906115402.30894-1-RuffaloLavoisier@gmail.com>

On Fri, Sep 06, 2024 at 08:54:02PM +0900, Ruffalo Lavoisier wrote:
> Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>

For obvious reasons, we can't take patches without a changelog :(

> ---
>  drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> index d55521b5bdcb..d0321a7565c5 100644
> --- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> +++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
> @@ -139,6 +139,10 @@ void device_write(const struct ni_device_routes *dR, FILE *fp)
>  int main(void)
>  {
>  	FILE *fp = fopen("ni_values.py", "w");
> +	if (fp == NULL) {
> +		fprintf(stderr, "Could not open file!");
> +		return -1;
> +	}

Did you run this through checkpatch.pl?  I think you need a blank line
before your check.

And is this fixing a real-world issue, or just something you noticed?

thanks,

greg k-h

