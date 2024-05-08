Return-Path: <linux-kernel+bounces-172995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C98BF9D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64830286171
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAA7440B;
	Wed,  8 May 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EOzF3R/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJwH4v8v"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83054679
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162067; cv=none; b=MCoOneztLKytYGJkvyy2GrCjlParezPwuw0WRdeEaZQiEbIOkyxJIdinXzvIEwHYmBO6gb6AWHGVtjNlur+pqYOLN3R9PMciTRDPpiw9j0RKNMRqexVv57id6jwBTAVbZnCVL/H2pER4X9QrgvKoeEgTjI76RUKliYqigwKk1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162067; c=relaxed/simple;
	bh=UmEryDPKqCzmLaa7zf8PbJnXXv0HOPRm8AWkF9fYbgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ6FBQbzGucZ3JpHh6X224uEvFn8YkXzadfu1V3YvW66y+6cpyrge6OAAEQ+BZpCb5lwOCxkLGNZXhggOq1bzszHVvbP6MRQgklVw4evtKda+JjVVaQSLipOtazNYoEcP8jPnmo3i7Dtz1NZ8vlXAO4DeRcSxJlccwQl0zcfRIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EOzF3R/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJwH4v8v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 128D91380FEC;
	Wed,  8 May 2024 05:54:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 May 2024 05:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1715162064; x=
	1715248464; bh=h2YNeouZG7QNm2DhbCVNKqFB+E2lilrvJm0btMHZ2I0=; b=E
	OzF3R/6jG1MR/oLES9tVrSzHl+ypqLU9jDCGweC6ywIsUKlz6u3Phda8J9ueXlF2
	En/NFenspOZv6DCzEOESyZy4D2Anlf/6e/d4Xc/TVFNoqRto1wk7OMvSbUZ8cpJi
	ki/+w/9ZFeXyn2CbmOkVx9aIAzsy/tAr4ykX/4v6jEub5nhlD2VDsVb5xviNV6/S
	st+FodVGYgdowhjGe/IXSts7/XiIrKZt/Dnh2xjo08I+XlD5k/pK+O1O9Woxmw5c
	wJ4u+v7nZ6Y9GqNB2K6kW4m2EGTiN62iIYg6k9PUIWi8EYTMRkoeA+REU0QlsmGj
	F2YpE4wWjknHISGWIcWdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715162064; x=1715248464; bh=h2YNeouZG7QNm2DhbCVNKqFB+E2l
	ilrvJm0btMHZ2I0=; b=ZJwH4v8vAuHiIiGRN8hB/brgPp/5gmqApA3O9yqqhrF5
	tAT3U3r6e81taaRxYSNSmZArnySyxnDmG1JYLsbJMRDtD8RG55bV2OEZ+1orWDw2
	uANOPDJrx0MEwPZyQFLWWEturpJxnN5PyzLX1VLvMvdORnDForxs0dWrTmKk6K9g
	P42aueKLiIq1CeUylCMWF1WdqsqzO+i6S1vd6/O8Alt5hg8yomfgKCmFnHF0PLy8
	s5hBVSh0qeAfUzCilbFHoVARXoSozV935M4ovbZgLj+4J1JpW+jPSIroVBvUktm9
	7JnOhXwYQ7SaqQxH+kToNjliOL1HJJDKLt/W6JZlrQ==
X-ME-Sender: <xms:z0s7ZgLNIUHOekJkbE_U7gT8hTXineLm4kGgAoTnxFvqHqnGN6Xo4w>
    <xme:z0s7ZgIyYht92PR0cIwcfxh5ZTkfepXW2ZA1RaSTKfTxz01cACzrziRD47zf0djf8
    AsFbfVZibk-A0kdMCM>
X-ME-Received: <xmr:z0s7Zgtv9a5PYuYNsUJ92lhI9WzOpgrawxTS1T0aJL0HqJSMtb1ZF1zyKp5ifkfxXWA3nKBBGKUWhSLoFoKDXYP7leWoSnisvRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:z0s7ZtaVSy3gwRvUu4yHbasR0-Ua5GhNL75gSmnN457aJ3KHqP4z6Q>
    <xmx:z0s7ZnbUWCNvwbjV63qXyl7RE5HrrPF7md487K4cB-x4xtqieP53Qw>
    <xmx:z0s7ZpAWY40rZL2UrRs8WUZaD4IwB_mjjo23aBAR2b-FzugXiSVCdw>
    <xmx:z0s7ZtaM01iqAZ1NvnxSogf2gObfzjuLOaUT4HgBAkAyYyMSKNpg5w>
    <xmx:0Es7Zmm6QXat8w3_x8aWsGyW6P-DEdPPpYX3_Cz_JJ4NBVd1abmOzeeH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 05:54:22 -0400 (EDT)
Date: Wed, 8 May 2024 18:54:19 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix type of timestamp for
 async_inbound_template tracepoints events
Message-ID: <20240508095419.GA433207@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240506082154.396077-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506082154.396077-1-o-takashi@sakamocchi.jp>

On Mon, May 06, 2024 at 05:21:53PM +0900, Takashi Sakamoto wrote:
> The type of time stamp should be u16, instead of u8.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/trace/events/firewire.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
> index cd6931b134ee..d695a560673f 100644
> --- a/include/trace/events/firewire.h
> +++ b/include/trace/events/firewire.h
> @@ -106,7 +106,7 @@ DECLARE_EVENT_CLASS(async_inbound_template,
>  		__field(u8, generation)
>  		__field(u8, scode)
>  		__field(u8, status)
> -		__field(u8, timestamp)
> +		__field(u16, timestamp)
>  		__array(u32, header, ASYNC_HEADER_QUADLET_COUNT)
>  		__dynamic_array(u32, data, data_count)
>  	),
> -- 
> 2.43.0

Applied to for-next branch.


Regards

Takashi Sakamoto

