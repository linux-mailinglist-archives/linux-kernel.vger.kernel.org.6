Return-Path: <linux-kernel+bounces-185863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF5F8CBC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16691C2101B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED47C09E;
	Wed, 22 May 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxgOc/Tx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DE37153;
	Wed, 22 May 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363293; cv=none; b=S+KiFsK3EIJ4voyT0hIe76PkcOIXoa1W7B5cmdfYQZzsUmW2F0w7YDDZgkdy+VWlVod9WOyiAer2EXa6JrWMgUp5X6460PN62mvAJzf3W0sESLe6feTJPWFk+k+d14sosLkYdisPJ1AEbgIQu2H0ghMsxgNKtOQyzsPeGwaiWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363293; c=relaxed/simple;
	bh=LtjISD2lbLxp70hQc5Z5mwe0ZOQisKZWMR0MnHX+DdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGdSwNGaHLNyS5rQU7xLyCXOxTRzgi/gHWmxKyy8+kXo7FIFh/ZWfhY2z1BogD9bkPXXouAgsZl5mBNx65vhE41FX8CBViZOs56XW5INM0lpIDTNdl0lAkhGI+MUn5vL6z7Y2tii9bMErv3PDbLjPDLQT0CnB/PLXSn0mmRue4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BxgOc/Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB2C32789;
	Wed, 22 May 2024 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716363293;
	bh=LtjISD2lbLxp70hQc5Z5mwe0ZOQisKZWMR0MnHX+DdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxgOc/TxWHWxC1u6UuRvtFj8/x7TDPLrM/vfrnpL8WcPDoQPNyH1BbNoMT2GSPGKy
	 2vhHB0knam2E8y/dDNXVJ3CsuSZhQTYmX4UC+hSAEqJ5dHYvUql9JGBl/dLzdD6h5l
	 FGT7Yudg0JXPKFjPGf3sWi8mE/JemTDMKlgAlxDQ=
Date: Wed, 22 May 2024 09:34:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shichao Lai <phyhac@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: divide error in alauda_transport
Message-ID: <2024052224-motion-perish-82cd@gregkh>
References: <CAEk6kZszgHVYN8r-AsPw9YtGGf459j0uDMYLdOoTixhE3YJCKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEk6kZszgHVYN8r-AsPw9YtGGf459j0uDMYLdOoTixhE3YJCKw@mail.gmail.com>

On Wed, May 22, 2024 at 03:28:01PM +0800, Shichao Lai wrote:
> Hello Dear maintainer!
> A new bug was found by our modified syzkaller.

Nice, do you have a proposed fix for this issue so that we can give you
the credit for resolving the issue?

thanks,

greg k-h

