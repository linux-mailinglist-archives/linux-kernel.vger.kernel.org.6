Return-Path: <linux-kernel+bounces-200024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E28FA964
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2AA1C234CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678E136E11;
	Tue,  4 Jun 2024 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf1KuaOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BD17741
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476322; cv=none; b=tYKFMZ93QkIdCoHOk8QnXt3+hi7+G9laIPqFCewIsbNfbLR7yff7YPBlxTLgw7x9Y2JLmsxzuzHtylTw5+e9qhnL799LiYaEYleWcvMS1mpgLOcnS1z7p4S3bdjiyMQ93kax/UmcqrPhZ7sXX6dQsU0jyEcYaeZq/I9yBYz1oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476322; c=relaxed/simple;
	bh=hP3VvfQFYbMkVhP8eJ2mVSBrx0yg/awQRzuoxPwEdII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTEieNUrPlIer8Mx2znaF2lhuhaB748OHspEp2uw4XU4HVVvDCCRlhrSSxeRsLnrsmf2vi+fYlmdm4afJpzU1CiGnL1pmS5r6y+WFklKh7vp/P7nxOBl42kmvr8mukg5tTO+kl5fW6+6SoD3TW4lrhxxaaIHnacXlZNbfODd1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf1KuaOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7578C2BBFC;
	Tue,  4 Jun 2024 04:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717476321;
	bh=hP3VvfQFYbMkVhP8eJ2mVSBrx0yg/awQRzuoxPwEdII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yf1KuaOqa6n9ZAmgMKarAab13HsqMUWgate1UmXUinMtyb7OIgCizJlR0aqrjrKaw
	 WF6JVukD0MYsvor7IEwlY0FSA20nW5lSXeaeUTumCwZSYemh6PC0KwSiaEeT2gckQ1
	 NrMAhfj3asTksNTX31PYQuuIIgJwFTA0s1c+M/pQ=
Date: Tue, 4 Jun 2024 06:45:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: me: release irq in mei_me_pci_resume error
 path
Message-ID: <2024060419-stoneware-staff-b840@gregkh>
References: <20240603132928.977787-1-tomas.winkler@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603132928.977787-1-tomas.winkler@intel.com>

On Mon, Jun 03, 2024 at 04:29:28PM +0300, Tomas Winkler wrote:
> The mei_me_pci_resume doesn't release irq on the error path,
> in case mei_start() fails.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/pci-me.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

What commit does this fix?

thanks,

greg k-h

