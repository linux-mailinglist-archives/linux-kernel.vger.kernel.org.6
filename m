Return-Path: <linux-kernel+bounces-560698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E8A60865
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EE63B769C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2114900B;
	Fri, 14 Mar 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXRSvBpY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7E13D26B;
	Fri, 14 Mar 2025 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931097; cv=none; b=hdEJQwNlBK8VxgxoSM48Gi1dkC7hSWLXzKmMW75AaHwEpA/8I2X3P3wd8LYRtqkBWKSs+CSJ2RJSomqisBXH2GjwtB6MiV4lunw9uLM8aW/4/iO/95yqjUDxdPKf36fZyaVToR3PqyD9V7RLCrcBYFVl3FrrG8Mk21HlA6WzKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931097; c=relaxed/simple;
	bh=ynZmVmnnH3wDdQhCAfoEwSbQtHLV4LlYau1xMCJnN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwthFgdHqsRLBUdI5Q7Y9/QwAYn9SrgAZ9skXIXTWETQykBInKUUaU/Fpwr/iifS5cxZ2ci+gqyXcLA3hsaT9/uFPjGt6zsodBvCd5jzsK8d7x5IyKLNL78WhgCePRDpL2EuKiG6QPXFnPrJsYz2++yYmuwel6Lf3dk3qRhiD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXRSvBpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90197C4CEE3;
	Fri, 14 Mar 2025 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741931096;
	bh=ynZmVmnnH3wDdQhCAfoEwSbQtHLV4LlYau1xMCJnN7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXRSvBpYTK5iFkmzzii2qimWyfKpsxlb+mVEO0glrbMWpfyDKf5fNuyc2XUfQnrjv
	 5LLypG3/LqfvYR/W4jXO4oUC+YlzcCmg5CeVOI2Bve02fWhX7ixWFXRhZ0kIfnoMmv
	 gCQqsUqY2W3kRo6nEeaNj7e/qmB5geq0uV1oeXtI=
Date: Fri, 14 Mar 2025 06:44:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	matthew dharm <mdharm-usb@one-eyed-alien.net>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: Re:[PATCH] usb: storage: Fix `us->iobuf` size for BOT
 transmission to prevent memory overflow
Message-ID: <2025031402-fastness-humming-e87c@gregkh>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>

On Fri, Mar 14, 2025 at 10:28:41AM +0800, daixin_tkzc wrote:
> How us->iobuf overflow could occur?
> 
> For 1), the USB device does not know that a Babble Error has occurred at this time (DWC_otg knows what happened), It actually continuously returns 512 bytes data through DMA write to CSW address (As can be seen in the waveform in the appendix document before). The DWC_otg controller driver cannot control how much data the device returns(13 or 512 bytes). However, the USB storage driver pre-allocates a default buffer size of 64 bytes for CBW/CSW.

If this really is true, it is a bug in the dwc driver.  Please fix it
there, otherwise you will have to modify every single USB driver in
Linux to have a larger buffer size, not just the storage one.

thanks,

greg k-h

