Return-Path: <linux-kernel+bounces-172997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E098BF9DD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7FBB2370A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6397A15D;
	Wed,  8 May 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KxdfiOLU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNbvlddN"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25957E0FF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162082; cv=none; b=JpulgbslFMoPlcM5TBuVWlQ4KQPYPYmEyn4HyupGyfUhOJOkOpDu72E6f8VVP4DtYG5Jzioe6gyZQgq0/hVwedai9aA65z4+h5XemMzHcS53Pmz/nvMU/eIBi6LnTUt4ucgSHGBcc8zWc+8eoKj5IFNFhpxObOLmn7E4tR6R+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162082; c=relaxed/simple;
	bh=haOq/suRGOm3L6UrcZgS8+xZ99laLeivrU9ONOPMMYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdJ+i1QLDDqzXgcKgMkaXLGNo5ZX2v5o97axW7K27dHvkpljfhZitnthWwmMmnpIDwUWi1RzK7BZD7GQjVLT5cfrYJvYkNlcel1z+0KgHDvLlRIwjONTYgO5qmcER4CdeY11r9eUMfC9rY/knE34wgdev8/cwDVbDFuBery/Q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KxdfiOLU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNbvlddN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07EC71380FEA;
	Wed,  8 May 2024 05:54:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 08 May 2024 05:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1715162080; x=
	1715248480; bh=Tj2F6+Vw3OTzzfc8yd2SH2593sFycDAClFvqFzQ0epo=; b=K
	xdfiOLU1OGGCqyA0PaQ94qtdH/422k62p8xS61GjDydkhlFIG1yfSuSqF2lS9wXS
	EfbMU/9cZl5ygxxQj7B+1t89tSWH3gKt8lCQj9QIZs6AsMsCO4OYyTPCjaa8vUSW
	PekLMLIT3C/Qtvg2NxvkUBZJ1X92a4q4Xg1dFR/vefVyGa9MPxACt2fp2kZQeoA7
	gP6RS3KH5u6LXXspxJGP/V589kQEfravvN4YJBxDdkW4d5N65Zy1i0kijKu2y5sS
	EFHFN9kpYiSYWIRYWmC4nKX+adyXJRsQc+2GWj7jHNztguM0BAJRQjZ/gO7LVGl3
	OIPFCpsSrCn1Ka/IdZctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715162080; x=1715248480; bh=Tj2F6+Vw3OTzzfc8yd2SH2593sFy
	cDAClFvqFzQ0epo=; b=UNbvlddN4kstGPMQ1G66+2/3U3FsKEUwZ9zIKErgEubL
	Aiuhp6lfUItE0E/QKhTlqB5tv1pGHHhqD/6Wd2I3yTkCOU9CL2E7zfwrecEzJiRp
	lzPgO2eXamWIid15aH5SEzHUQpL/WcmUfeqoVgCl96rfn9oKTYUY1kejkp+aNLxb
	RufBeziyUS01MZeKQh1jAgD3e9YQWZ8oIJuAHGmUMDpXTBhYuOE7LrGr63FyQkoF
	yMPmHK3Q39jkTCF/iQt74mQrPRXOFA8YewKRuS5VojVUZEl+IDF/ybZhazmR2+dx
	ZrFTMmf15x9IjUk3uyPhWF1RmW6JEMT4VstLzsSSxQ==
X-ME-Sender: <xms:30s7Zmfa2HL00yUPM2AR6fipcfEAXk0bS5xk5Sr38y9jeSGmlr5Ivw>
    <xme:30s7ZgOkd6v-qeUet9JtWb0kWqQnN2xPjHqj2uW4myyH3F9W7DiMa9z9kUYbXKvuH
    bbTJodkoEPW3nUAuK4>
X-ME-Received: <xmr:30s7Znjfb0OstU-3QgX5YrwCMkwOFlzGykqGhKwp6xo8-IxzlSZQ6cAeRRsADwUoDWcjNeIpGkGF8v-p6X1JA-odd9esbvCb6No>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:30s7Zj9i65AiGSy3k3GgOkOG_BWjOe0rAR9wNAUeAC840ngfcLXfpg>
    <xmx:30s7Zisz1Z6HaF7IupUJol3LUbGAI04oSuaddiElpyizgHROU7QtMw>
    <xmx:30s7ZqEHSiOX_lRaMgpc4tDdng_FH7SduT36qUhSmwzDneU7aKLCjQ>
    <xmx:30s7ZhN3aaKGbRUrc2XeXkpIWBweP2T81_fIxa6lVJS51J2Ug45INg>
    <xmx:4Es7Zr5aRbvKa-honvwebJgpGIy4UL6KwuCyfzwyt-C2SdPcHQc7fcyJ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 05:54:38 -0400 (EDT)
Date: Wed, 8 May 2024 18:54:36 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: remove flag and width from u64 formats
 of tracepoints events
Message-ID: <20240508095436.GB433207@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240506082154.396077-1-o-takashi@sakamocchi.jp>
 <20240506082154.396077-2-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506082154.396077-2-o-takashi@sakamocchi.jp>

On Mon, May 06, 2024 at 05:21:54PM +0900, Takashi Sakamoto wrote:
> The pointer to fw_packet structure is passed to ring buffer of tracepoints
> framework as the value of u64 type. '0x%016llx' is used for the print
> format of value, while the flag and width are useless in the case.
> 
> This commit removes them.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/trace/events/firewire.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
> index 4163959be57a..cd6931b134ee 100644
> --- a/include/trace/events/firewire.h
> +++ b/include/trace/events/firewire.h
> @@ -221,7 +221,7 @@ TRACE_EVENT(async_phy_outbound_initiate,
>  		__entry->second_quadlet = second_quadlet
>  	),
>  	TP_printk(
> -		"packet=0x%016llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
> +		"packet=0x%llx generation=%u first_quadlet=0x%08x second_quadlet=0x%08x",
>  		__entry->packet,
>  		__entry->generation,
>  		__entry->first_quadlet,
> @@ -245,7 +245,7 @@ TRACE_EVENT(async_phy_outbound_complete,
>  		__entry->timestamp = timestamp;
>  	),
>  	TP_printk(
> -		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x",
> +		"packet=0x%llx generation=%u status=%u timestamp=0x%04x",
>  		__entry->packet,
>  		__entry->generation,
>  		__entry->status,
> @@ -273,7 +273,7 @@ TRACE_EVENT(async_phy_inbound,
>  		__entry->second_quadlet = second_quadlet
>  	),
>  	TP_printk(
> -		"packet=0x%016llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
> +		"packet=0x%llx generation=%u status=%u timestamp=0x%04x first_quadlet=0x%08x second_quadlet=0x%08x",
>  		__entry->packet,
>  		__entry->generation,
>  		__entry->status,
> -- 
> 2.43.0

Applied to for-next branch.


Regards

Takashi Sakamoto

