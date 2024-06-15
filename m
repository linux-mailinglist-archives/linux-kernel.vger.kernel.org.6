Return-Path: <linux-kernel+bounces-215718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9A90963D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FF72853CA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE917579;
	Sat, 15 Jun 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KMWA1yog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDVoPb1C"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF31754B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718431343; cv=none; b=JHMQe7sSzuSwnUYVdwHvS0cl3LP+OHidH6uzcbroDOfOvXDXaP96iHeEY/iu6SmRxLypNRm2hO8ufTcD9bF/YsNS8ctObXmzOBZL3qFp47NbTMsp78ZNGffC5bBJ4Jb9I0sRIxIvfHW+Q/Z0w2OWexlhaqJE4trW4JhsY5XktVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718431343; c=relaxed/simple;
	bh=2nowq4ENPym5E2QjapQIoidzw6/8u5c7K8t6AB4vMug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKsFs/GpwByG0sp65TH25jbyyXyKbN446oNRgTHK8Ihiirrya3ntv1Algne8XdJKLmGgB317dkVOgDSiThVMFLs9D16bZ/Bgd/WPUmAaTonicTghK/dAM/eAWrlbJAHnecOJLt0gnVGGIpHnyVC0Bn85AfIZNn7GLiTdQ4Kd6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=KMWA1yog; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDVoPb1C; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EB213138030F;
	Sat, 15 Jun 2024 02:02:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 15 Jun 2024 02:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718431340; x=
	1718517740; bh=r7u+yphojA5kQs7Ft+k2Ma46p5tLGD9X4713KwZnndE=; b=K
	MWA1yogYJgubr4q0sND52lywEbAwM8G4CnzXMOTSpfDofQ/zzYiQNAKZZrIP16lJ
	ddHnsNaFOC+7nZPzIL9GcpSsWWxQ2xWRhejQCvaydI79wFQoxlu3E1niuo0lSZvG
	aOnZd8k55QeTSsp5/MOQ5P1FafhqvPWKCa8753kQ7cRr3b3WYG4jcim+f/1YqReR
	1I+q9OTX5FcZV9Dn6PXqpUxF910wdTXsRURsQ8gucGvqBfnRspt+n2shdywdrgc0
	R1Su6K2zfN77KLywoyCEV1yyarCGXqG34/vIU+Zrzx3aLILPbw9CXZRfLIkrYsB9
	07SV2EWws5jKhNEJjmnPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718431340; x=1718517740; bh=r7u+yphojA5kQs7Ft+k2Ma46p5tL
	GD9X4713KwZnndE=; b=QDVoPb1CDVO8Xzqwi+OJn/2ca2k+6zBlvgV2jDCeaRs+
	tyYY4op9BlTX4WauS55A/1k0seS23sHoLCtXSv5QNPpzkPH7TCwl6XwsKDnBzfPw
	NUxwepqHy8zADQXAu1NlPVr9B5JjccznBC5Ad2L4e2yVV89fTQHjwXk7V3zz880J
	76H5J8T7K+Yu+eNYlsljSUBFh2OXlL9xViChj1ws2sh+C6nwySuNl35em3MMKwZd
	fvZhPoE5/NEflYh8qK1gp7GuoI0SvT2BGiqFzZnvI5ahqYe7FLLSE1ZdX1cPv9KN
	4Wdl09/QegUP+3p3VftUjHU7fZNY91hAm+b3IM17QA==
X-ME-Sender: <xms:bC5tZhvqbPm-y-_0mkGAGVvksuU8DWC5mYkDEiuiIstePdt7hXau0Q>
    <xme:bC5tZqcLjpBuDd3yV3Q3lPCRYsoSUSj2388WKgC68DwHozDpJYJUtV4wNAyV967y9
    IaklAcsWoLkTnP60ps>
X-ME-Received: <xmr:bC5tZkxYR7IW7Ny16i4iBMMhhiGPHK12PCZRq8EURYEeM1A2ojBPp0P7vh5zD1tsjeOhTu-PDBO8ua32K1vhnIswoa1kN8lSe82c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgr
    khgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeile
    fhudekffehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:bC5tZoNMqJQvvIDlgu_qjsKm3NSaX2KJ3h6BERdWygC128T8M7ztfQ>
    <xmx:bC5tZh8Kbt-NSuoXNApxAbzBM0hdwjD4qD6W1VCMcVPjVh4C772Txg>
    <xmx:bC5tZoXFbLbBLCQmG0RJC6NOO7DbvRlyhrSNs_d30WC0MF6JbtD6eA>
    <xmx:bC5tZicp_0Rg0qZjp-rosKFhQT-chMQwt0ne8BG8WAdpCeT1378k-w>
    <xmx:bC5tZjKcvpmufdQxRafDlVPrk2G9_MvBz4uFQIbowOhbw_0AI7EPFMjT>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 02:02:19 -0400 (EDT)
Date: Sat, 15 Jun 2024 15:02:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: fix website URL in Kconfig
Message-ID: <20240615060217.GC497879@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240613090343.416198-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613090343.416198-1-o-takashi@sakamocchi.jp>

On Thu, Jun 13, 2024 at 06:03:43PM +0900, Takashi Sakamoto wrote:
> The wiki in kernel.org is no longer updated. This commit replaces the
> website URL with the latest one.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-linus branch.


Thanks

Takashi Sakamoto

