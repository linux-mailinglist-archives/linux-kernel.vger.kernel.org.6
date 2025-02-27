Return-Path: <linux-kernel+bounces-537204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A9A48920
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CA43B0E19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E226E96A;
	Thu, 27 Feb 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlvXgr6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D2270054;
	Thu, 27 Feb 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685054; cv=none; b=cwh25bVny7EcoxofixkS+dFOa0+TBWtxDHHV5lWGg84POPvjC5VKxxOFOMExGoBsauB3/9dvVVfze2+b0f9c9RRwXsHVSMqsFQ/yFfH0KDWgJG/yafnSNsgSvQXnUxbDq57sSXs0EkElmhK5MGFbbSLipCD3rHxiQ5t23Few0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685054; c=relaxed/simple;
	bh=HDLtpU1TPbI5yoMup4GgYTXLrpRHTG6ySjQZ0s9QRyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9BUtKgR2X83aembtmq5SRx8Y2Vm/93JHdp2lqTJ6RrNksYeQWe83Pz7IM/LaRSTwFA5ZNUt7TXoahokwH9va/dVrJIH3Be5e7O4YxuwqltKf0PP57r08bqBoDHk9VT4d29WGlxD8Bex19fLajZLW8HfO9qwPFP/7R2CesuFF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlvXgr6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2352BC4CEE7;
	Thu, 27 Feb 2025 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740685054;
	bh=HDLtpU1TPbI5yoMup4GgYTXLrpRHTG6ySjQZ0s9QRyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlvXgr6m3ApOMAHK4JL0V4buvdr8IIxOllI+867tbjBdHC8Zjxu5pVZfh1i8XW6kI
	 jnY28xT2yA2Wg+XJexamYe8tN4VyiSjJcBYG6QAjkoURvqBTmt2dn2nhGE+4kD9M16
	 IuSybqqFFyuHjJ9CXHXm6h7t3oydK3cqGmEDs4pI=
Date: Thu, 27 Feb 2025 11:36:24 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] xhci: Fix bcdUSB initialization
Message-ID: <2025022757-extrude-carpenter-5bec@gregkh>
References: <20250227193400.109593-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227193400.109593-1-abhishektamboli9@gmail.com>

On Fri, Feb 28, 2025 at 01:04:00AM +0530, Abhishek Tamboli wrote:
> Initialize bcdUSB to 0 to prevent undefined behaviour
> if accessed without being explicitly set.

Is it actually accessed without being set?  If so, please explain it and
also how the compiler is somehow missing this already?

thanks,

greg k-h

