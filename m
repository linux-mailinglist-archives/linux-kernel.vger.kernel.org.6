Return-Path: <linux-kernel+bounces-296275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774F95A877
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6AD5283876
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393417D8BB;
	Wed, 21 Aug 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZJKTYfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F851607A0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283954; cv=none; b=nrV1Xkc46bA5h5nbXYV88oJlZWkIMZNmSvSP02mR+im//gnmXY2+YzsiUL3NaHpW16nCXBoEIfL7CI4GH0tPhN4gfSnXYa14dQ83DIh6jLnvxmWWa3Svhoqe3xLaK02p6cNXjqBd6QgIunWr6XL9EJVY7nuGLxpLV6h3jBYti4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283954; c=relaxed/simple;
	bh=7i7uEyHLWu9H4hgQknqlLVW4y0L/aqV01P6LS3wsePU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf8HzU3M39ChPZCBXJVONxMaTa1jUsiEaNX+RyytqrMd4XfLOLK4aPGq+3aKmjaUc+deNOxSWihCvMnWErCwbHjHoEkKx43Tv9NQaRgtE16/hN3aoRnnFnwHZ5UiEIRcXXiuIKoNuy1ZwmsOVDA7IyhYdv89xLJqpWlxC6xgrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZJKTYfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0649C32781;
	Wed, 21 Aug 2024 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724283954;
	bh=7i7uEyHLWu9H4hgQknqlLVW4y0L/aqV01P6LS3wsePU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZJKTYfGW5wPXtsJzy9ficbpaQnJO2xV3o5FyzuQXA9Y17Q0vI/m3kkeeemaR5vXh
	 537VIgspPJhPnwBBVzdCDo32NCAFQV0pjbSIqLEJmzCZcSxLAGOUJkBMFhsRROLH0/
	 diccYBy61pMYbDrofyEi7fBfoVOfkWrGb1ITffaE=
Date: Thu, 22 Aug 2024 07:45:51 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
	mripard@kernel.org, security@kernel.org,
	linux-kernel@vger.kernel.org, liuyanming@ieisystem.com
Subject: Re: [PATCH] drm/panel/hx83102: fix null pointer dereference in
 hx83102_get_modes
Message-ID: <2024082229-unretired-dallying-775d@gregkh>
References: <20240821095039.15282-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821095039.15282-1-hanchunchao@inspur.com>

On Wed, Aug 21, 2024 at 05:50:39PM +0800, Charles Han wrote:
> From: hanchunchao <hanchunchao@inspur.com>

Nit, this should be your name, not your email alias here, like you have
it on your "From" line.

> In hx83102_get_modes(), the return value of drm_mode_duplicate() is
> assigned to mode, which will lead to a possible NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
> 
> Signed-off-by: hanchunchao <hanchunchao@inspur.com>

Same here.

What commit id does this fix?  Shouldn't you also cc: stable to get it
backported?

And there's no need to cc: security@kernel.org, as this is a public
issue and you have a patch for it.

thanks,

greg k-h

