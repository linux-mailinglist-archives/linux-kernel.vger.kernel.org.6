Return-Path: <linux-kernel+bounces-394230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34879BAC2B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109121C20C69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632318CC1B;
	Mon,  4 Nov 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGCu94lS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4B18C932;
	Mon,  4 Nov 2024 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699203; cv=none; b=oDUB/7VKUTyxsv6/F1xaRJa0MNdenL9DsRpqWcaAPLPYXI8jxum1bCLU2p1g5WNXTiF3AoqMlggCJRvS5L9fUeAFv9we8qdOIDapFxkL6oyDnBhrCJ3Z3Uh87wTRY18baQZHRti71UNzwadPe0K625fqEZ+Ff2hjLmyMhVFR8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699203; c=relaxed/simple;
	bh=vdUrGKV2tdNOxlCYb34IIX5K3OuOPcbCuNVOgS5E4vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzM9tW6xJjXWXe42TrNFbqq7Mb9oBCTA4h7K7r7stHDHwBJhRq9b161OyGyCD6zaPuf/V1OXc3p2LZ37GnYKz91bnD0CHMkzhVCWzCIBmQB8eq3XrRP9GQn/jDOGqi7dWIS43Q+N2SUFEpwgOaU4VxVtj7gzvrj0H8fya4j/WX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGCu94lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BDBC4CECE;
	Mon,  4 Nov 2024 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730699202;
	bh=vdUrGKV2tdNOxlCYb34IIX5K3OuOPcbCuNVOgS5E4vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGCu94lScktKNcMk/xgpMWH1owD+lRbdYDZV+gkNUqWjgX/DlkpB9xAK2ELvWvrKf
	 rzwbkxDWaU1lIDqSIlfafk+b3pg/bfuF+l4hwegr2uu9DxC9Oc2EU8uViwti785BnU
	 xgHG3gAVVeWRSkyDloh5kgrOd0/Uha6HLHzLh0Gw=
Date: Mon, 4 Nov 2024 00:11:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix hardware lockup on first Rx endpoint
 request
Message-ID: <2024110415-zippy-litigate-f37d@gregkh>
References: <e905e5d9c3e76786f154a87d54690fe1a90d755a.camel@gmail.com>
 <2024101625-fetal-oboe-1b9a@gregkh>
 <50361c479af3067031320b19fe650a32bec6d1ba.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50361c479af3067031320b19fe650a32bec6d1ba.camel@gmail.com>

On Fri, Oct 18, 2024 at 07:51:54AM +0200, Hubert Wiśniewski wrote:
> On Wed, 2024-10-16 at 10:27 +0200, Greg Kroah-Hartman wrote:
> > What commit id does this fix?
> 
> This does not fix any commit in particular. Bisecting reveals baebdf48c360
> ("net: dev: Makes sure netif_rx() can be invoked in any context."), but it
> did not create the problem, it just exposed it by changing the behaviour of
> netif_rx(). Callback could be called from usb_ep_queue() since the very
> beginning of the MUSB driver introduced by 550a7375fe72 ("USB: Add MUSB and
> TUSB support").
> 

Great, can you resubmit this with a proper "Fixes:" tag on it so we can
backport it to the needed stable kernel(s)?

thanks,

greg k-h

