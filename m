Return-Path: <linux-kernel+bounces-522969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB0DA3D0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697E41893B96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD51DEFF7;
	Thu, 20 Feb 2025 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFm6lQYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95E19007D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028501; cv=none; b=X3qaDue7f3C5xN2+5RFHJFfQrTKyeYVndTcTzk0Otf4PmkhD9s3Cq6D79QQtJhNY9uJWs595GrNM17IEBeAFjQjAwCrsBFCp3cf8gfGg8AJhJi9QriIRSGOJlE7onL0G3UfVU3cuDn1isJ12nneAQJ+zJo95TNyhtq6mVkraIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028501; c=relaxed/simple;
	bh=UumaCo8i0FSzgb5fLE4+wm5+biVMrQIHmOtzpTnIiEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssqx3ktuAjEOgDxbBsWzCnjtR+NyST179caSOlA35GVlygsjVhwBJmcvx960a0cXwA7dni0YSwXtE2VBJSgPbU9BnG1b4VbaqEjeIWOnYVCIEwSlB5xrj53CDv5ooEkty1jVl7TTkWGLUQexT2vGO7bvN20PiUJOeFcxH+T/RdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFm6lQYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0A7C4CED1;
	Thu, 20 Feb 2025 05:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740028500;
	bh=UumaCo8i0FSzgb5fLE4+wm5+biVMrQIHmOtzpTnIiEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFm6lQYE2dc/QY/NVinrLgbdWdo5708WHvg2BUdSHkfmADqBkgN33686axlm198eE
	 RhAebjnGIGkeQI6mjpYQja3QqGxlRJ1ioW2c47Dj48jkQPjL7I1HI42t5Sn4xNqOmY
	 bgOJnpjWDnSLDhefnhtFNmOXXHr7mT6Hy2lzAVFs=
Date: Thu, 20 Feb 2025 06:14:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH] gpio: gpiolib: Remove FIXME by safely handling const in
 gpiod_get_raw_value_commit
Message-ID: <2025022038-grandly-shortlist-2919@gregkh>
References: <20250219192426.164654-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192426.164654-1-surajpatil522@gmail.com>

On Wed, Feb 19, 2025 at 07:24:24PM +0000, Suraj Patil wrote:
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ff64d84492f4..59437c8f31d7 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/// SPDX-License-Identifier: GPL-2.0

This change does not match the subject line at all :(

And it's wrong.

confused,

greg k-h

