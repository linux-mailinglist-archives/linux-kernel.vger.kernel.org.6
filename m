Return-Path: <linux-kernel+bounces-184059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16298CA1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DBE1F219D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C942137C32;
	Mon, 20 May 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ssxcj8ZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB011184;
	Mon, 20 May 2024 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716229322; cv=none; b=nyU+Un/QqhAzVqwXZEMZQCKaE2uzViDTHTM+QJQ9AZEXt0ILnNWiEtzdzMMcBrwAMAU4JLErBWRP1FUWBRPGdRVlgygnUWGFbqaY9HpnJdQxZZdtbiHa5tk/CYMsKc9BOa9U6wcn0xCCr3x5qBRe6epxFdffAZGXXuWCA1H7odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716229322; c=relaxed/simple;
	bh=mHdcg/HakJlaTvMF5es0bXyXzzoZrMTmlZbfpJXrl1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuVJG84gYtuz4725RO6nh/p+sW7qNs84XH3oWKNbo8RC1L2zj/O8O+hC/yN1EhlxQJe5E/PzjTiyrloRFjGojcn0VETZP1wtQr2Kdv21mqEjIyhJFWVNtJ+5qfTBdRSLm/LaITaWoJUuELZFcZENjYmgNwz4wv3Obhbs4kX9ef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ssxcj8ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CC5C2BD10;
	Mon, 20 May 2024 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716229322;
	bh=mHdcg/HakJlaTvMF5es0bXyXzzoZrMTmlZbfpJXrl1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ssxcj8ZUw/mrBecf+PqapmnC+GXbepfhCVSR4QmcvIgFzg1Yr4RPf9gwYQ1d9IrUk
	 uzMCtM7c7HHEjnvv6MQOxVF+nJqlDhdqFFgK0ykBHOGit3nVATOTt0VfKIKrMgwDkb
	 2A4gBrT5EjQn5mBsamVpFPtjz9PqlDVqWO/y6jNs=
Date: Mon, 20 May 2024 20:21:59 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: "nanfengwq@sina.com" <nanfengwq@sina.com>
Cc: balbi <balbi@kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory leakage in ncm_wrap_ntb() in USB ncm mode with kernel 5.15
Message-ID: <2024052006-immunize-doorframe-0616@gregkh>
References: <2024051922230825069112@sina.com>
 <2024051901-gimmick-cosponsor-f2dd@gregkh>
 <202405202232198531894@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405202232198531894@sina.com>

On Mon, May 20, 2024 at 10:32:21PM +0800, nanfengwq@sina.com wrote:
> hello:
>        In embedded devices with relatively small memory, if the transfer speed of ncm is fast and other programs occupy CPU memory, it is likely that the return value ncm ->skd_tx_data of alloc_skb() is NULL, and the code is likely to enter err. If skb2 is not processed in err, it will cause memory leakage.

Please do not send html email, the mailing list rejects it :(

Please read how to properly send kernel patches, the in-kernel
documentation should be very complete, is there anything there that you
do not understand?

thanks,

greg k-h

