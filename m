Return-Path: <linux-kernel+bounces-287639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A18952A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032E5282E02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F518CBF6;
	Thu, 15 Aug 2024 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RR7/nufK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FEE1EB31;
	Thu, 15 Aug 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708779; cv=none; b=nHitsKBwxQOe/HuThGYe4VJ2GQt1vaNJRshj99Hb19iew0jEFJT91kLLn0BOmsCpVNGerjWUC8Kr5cz8lbE1cBBPnjKsPoX1f0WNqaB2rxNlsPC9opfDEUxViJ6Um42bfdswIK49Ih/tAZx440NOGBTdy9qltu++fzOvyoLbH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708779; c=relaxed/simple;
	bh=7132GJBXAtafD28xtFBjPMMrHtCJ5+HNa0V0cVDn5MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG5ALzJxLpDa9uhUq6ruFe2+F+dP9Y7fGG9G7PeeUSLucFPWMcYQBy/Ngp0wOKRnGj7JNnBlEqI8Pyw9QZ0zZgRxlbQPm2M43X8ZfiaGUqS/7HVppzhIw9rLq5mPBiDZ/a9XTQWFATXm0aB50OelJPZdZ7mqrIz8RlhIhspxNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RR7/nufK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA36EC32786;
	Thu, 15 Aug 2024 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723708778;
	bh=7132GJBXAtafD28xtFBjPMMrHtCJ5+HNa0V0cVDn5MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RR7/nufKlWtJIpqkB0QzCei0gE5u7ma/crBywtrvNMWIKyLe+2pQYHT5ay9hMxND7
	 hEkkdNAPWScSgQUAWkZGMoLuPEYP4ic660wHSUqemG5UulNfAeZ1/I5V2kqlqC+7xE
	 kSEwhDKlmlgUZnVohwh3rwKpPDIXVDeVZiF+/O7I=
Date: Thu, 15 Aug 2024 09:59:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix ERR_PTR dereference in
 uvc_v4l2.c
Message-ID: <2024081518-fracture-thousand-c20e@gregkh>
References: <20240815071416.585559-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815071416.585559-1-abhishektamboli9@gmail.com>

On Thu, Aug 15, 2024 at 12:44:16PM +0530, Abhishek Tamboli wrote:
> Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> and uvc_v4l2_enum_format().
> 
> Fix the following smatch errors:
> 
> drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> error: 'fmtdesc' dereferencing possible ERR_PTR()
> 
> Also, fix similar issue in uvc_v4l2_try_format() for potential
> dereferencing of ERR_PTR().
> 
> Fixes: 588b9e85609b ("usb: gadget: uvc: add v4l2 enumeration api calls")
> Fixes: e219a712bc06 ("usb: gadget: uvc: add v4l2 try_format api call")
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
> Changes in v2:
> - Add check for dereferencing of ERR_PTR() in uvc_v4l2_try_format()

You sent 2 copies of this, which is the correct one?

thanks,

greg k-h

