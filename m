Return-Path: <linux-kernel+bounces-296842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BA95AFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6951F23C14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2491531D2;
	Thu, 22 Aug 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oipw9fCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265716B75C;
	Thu, 22 Aug 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313222; cv=none; b=Vz+Kp8AitxRcHmF8oIFUw0/BqY6kqwpsRqdErEpDDW0rDhlrJSnqaGBYdpmjJDSYLoqJeJCx+5kYdRy7rq5DzGBPIczBIlMuVowvxuyOZ7i60thhUmvt0LYdkFzaGJ8nMPh5h8jOArfj+3uAY9e1D/2DRs+HiTQNnxBpi9oyVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313222; c=relaxed/simple;
	bh=/f3AIjt0onoBiYDKjxy9FIz5j3AuSqydza07ABAWslU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeIKThVsF5thBlCQlVj69lcRdlbuKX2Fg5WrlmO9m+W/N8LFwbomHHLk0NmB3t2B1IL6Y++e/4hHLsKyI5K//BvCTS3d4fxAYfuDJ7jAkpXKeBmcXppHkDZESb9rJXoXN/vVliqMGwjz4eXVu9DaKoIRozc1L0ZRqMvgDtDwfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oipw9fCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7ADC4AF0C;
	Thu, 22 Aug 2024 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313222;
	bh=/f3AIjt0onoBiYDKjxy9FIz5j3AuSqydza07ABAWslU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oipw9fCKeeV9SShVYb9kQAokG17/RuWwB2QqYmPWUkan+4VRety+vm4jPZCoGebh0
	 m2ZojHHoX9pSIoNP0CnkGNOjo01Qp7gEY+5lI3Ulzi8BsBs7S7iGGxdCGqaYrxWaqh
	 xbQuYpv09w/zNZZhR5K54GXUqr++LEzo5ydC1+7E=
Date: Thu, 22 Aug 2024 15:53:39 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ana Carolina Hernandes <anachan.01h@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] Staging: rtl8192e: Fix arguments alignment
Message-ID: <2024082207-enunciate-whacky-e1c4@gregkh>
References: <20240822003043.10865-1-anachan.01h@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822003043.10865-1-anachan.01h@gmail.com>

On Wed, Aug 21, 2024 at 09:30:43PM -0300, Ana Carolina Hernandes wrote:
> Fix the alignment of arguments in function _rtl92e_query_rxphystatus in
> order to silence the following checkpatch warning:
> 
> CHECK: Lines should not end with a '('
> 
> Signed-off-by: Ana Carolina Hernandes <anachan.01h@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index b3d4b3394284..bca6e4f57bf2 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -1145,16 +1145,15 @@ static long _rtl92e_signal_scale_mapping(struct r8192_priv *priv, long currsig)
>  			_pdrvinfo->RxRate == DESC90_RATE11M) &&\
>  			!_pdrvinfo->RxHT)
>  
> -static void _rtl92e_query_rxphystatus(
> -	struct r8192_priv *priv,
> -	struct rtllib_rx_stats *pstats,
> -	struct rx_desc  *pdesc,
> -	struct rx_fwinfo   *pdrvinfo,
> -	struct rtllib_rx_stats *precord_stats,
> -	bool bpacket_match_bssid,
> -	bool bpacket_toself,
> -	bool bPacketBeacon,
> -	bool bToSelfBA
> +static void _rtl92e_query_rxphystatus(struct r8192_priv *priv,
> +				      struct rtllib_rx_stats *pstats,
> +				      struct rx_desc  *pdesc,
> +				      struct rx_fwinfo   *pdrvinfo,
> +				      struct rtllib_rx_stats *precord_stats,
> +				      bool bpacket_match_bssid,
> +				      bool bpacket_toself,
> +				      bool bPacketBeacon,
> +				      bool bToSelfBA
>  	)

So close, why leave the ")" on the line all by itself there?  It needs
to go up one line, didn't checkpatch tell you that when you ran it on
this change?

thanks,

greg k-h

