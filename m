Return-Path: <linux-kernel+bounces-228041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D09159EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05242283EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39911A01BD;
	Mon, 24 Jun 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cnbjUSLi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7hn6uLS"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDD45C1C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268511; cv=none; b=DvHXkwdrGKP4PB0iRGhLyYgeiTX5uWuivesGYhnYpe9/kJUIlIGyU91qQW1dnbHvb+4hRGlH3AzMqM0+jyKRdT7kZVzg/wl8o8YFiDhDGEwr1jz3jYfhL+ROL/yqWxJwbCXLTWZDbXWsywgwgwOkelb3ngqllZxrDh39+RR99iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268511; c=relaxed/simple;
	bh=g9CCplZUsUmLr/C1GpaJfts48R+o+I/ETKnQ+2KmeK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfDM7fsJzKCJAqaiAMvie0CUEOrh7Neejn9UcF8yoLRfhkGMHA2ULV4JORPbW8lHJoS0mwkRZnfjKMQsd6DXwiElkWc3WqVYH4aTJ/7opanSd6+jIqHDKgtbqnqa/dGb98wy0EaW9sIXzG1tVVqC3L5u6i1UU5Ccwi6KXZmgfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cnbjUSLi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7hn6uLS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 905891140098;
	Mon, 24 Jun 2024 18:35:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 24 Jun 2024 18:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719268507; x=
	1719354907; bh=vLjiFJxOdYepXvTDQroB0EYKMbWZPsdolq8sznSWlMs=; b=c
	nbjUSLi0y3fVTXvUsjB8bo884WeQyaoKdUCMDa0QdsMgxxOlJjKf0W6mRIN3Up8n
	uSFlBhajk6RcLbBE+/n7XHV0BhuDXrVit+DS5eMYXpPEumqr0stY7U9UkiRTbmMW
	aMCnQFMlgbFClCPqBHBsw3puHJyCALLZtZ9iw7Tj5dseva+ciLi2xu8/rtVZnRnT
	pNoFFCEEQ+WFG/YT8bW3J6EDFQDjZzRNlbBkjv4Ts/+8ha+dQYDxnkRQchJ5N1Md
	xKpSAlz93jqKMarHENcz3kC7eYkKok824/PgyyQL7HLJ6OzH8m8U+CkWsFZaXQ1A
	L8WBwFeGb3grKCqQXpHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719268507; x=1719354907; bh=vLjiFJxOdYepXvTDQroB0EYKMbWZ
	Psdolq8sznSWlMs=; b=J7hn6uLSuIOVQ/XD+0lXN4rsCJbwtAsoysgcgZNW0M4J
	X+nLMb/By3zbWuG1joYuX7/kL2a38zYucSu4HPI6AIrUChPv2ohtKJt81XwjxZ7T
	iK8LmjcS4AuqlLFATdp0N6HUfvZVYVfU18kL7rAHOYohVMeSLieBjn2jVP1NihqE
	5O+kbQHqqadKSw7JfyKA8bY80b9AUSq4nMKOBOkT1pvp0VVu4KbOtl3ftBJJtn9s
	Nsdotrb96SwJXE7HzCJBy8h2TW+OvYvuGbzfqW5967lhNjWIGs+VF6e6kjIpugCQ
	JhmM6xyhdwt1AfokboiWEoc9t3y3Zb+yNAMAOXgQsg==
X-ME-Sender: <xms:m_R5Zv28NqJAFCZlmfjkjF-zf1JWEhe2tzCkHK7dxfW4LdJkrH_MlA>
    <xme:m_R5ZuHhSyb7RBAZCLpJJ1KPu906dtHqS-oY8pmXxqoxHZJvbbBgib9hU0KzJb8jP
    Rb_R8fvf-IeICfcirQ>
X-ME-Received: <xmr:m_R5Zv6qC8z1ZcCinHUIwkS1jBLd4K9MK5_nC-SEGMva9HyDXJQ7fN6EtZcn5aa1GMaauPbE9oQF0LoRAHvZI9dG5PqhWKpuqJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:m_R5Zk1uo4eK0ILrWeOyfAjtmbMFxRK8GeSawl-ACEByCraCaMDaQQ>
    <xmx:m_R5ZiHp7kZq8R9dJzUO4uo9I6f6TTb4HxfWBO6cfYzoUDIluliLBg>
    <xmx:m_R5Zl-Ff-KWkyrMjNy5hIEtHx9iFDhub3qI4YUwU95zemp-otYNVA>
    <xmx:m_R5Zvm0UMrnE5GpchvJUjLq4WyjrgPN0jvCIe8fpnIjpGP5yZiyYQ>
    <xmx:m_R5ZnSZJ3VMZ_nBF2TzWZa8bVCkI1eIczIkgCZVDCMCxPr0J5s0znxj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 18:35:06 -0400 (EDT)
Date: Tue, 25 Jun 2024 07:35:03 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] firewire: core: add tracepoints events for
 isochronous context
Message-ID: <20240624223503.GA914180@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623220859.851685-1-o-takashi@sakamocchi.jp>

On Mon, Jun 24, 2024 at 07:08:51AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> It is helpful to trace any operation for isochronous context for
> debugging purposes. This series of changes is the last part to add
> tracepoints events into core function.
> 
> Takashi Sakamoto (7):
>   firewire: core: add tracepoints events for allocation/deallocation of
>     isochronous context
>   firewire: core: add tracepoints events for setting channels of
>     multichannel context
>   firewire: core: add tracepoints events for starting/stopping of
>     isochronous context
>   firewire: core: add tracepoints events for flushing of isochronous
>     context
>   firewire: core: add tracepoints events for flushing completions of
>     isochronous context
>   firewire: core: add tracepoints events for queueing packets of
>     isochronous context
>   firewire: core: add tracepoints events for completions of packets in
>     isochronous context
> 
>  drivers/firewire/core-iso.c     |  32 +++
>  drivers/firewire/core-trace.c   |   4 +
>  drivers/firewire/ohci.c         |  25 +-
>  include/trace/events/firewire.h | 463 ++++++++++++++++++++++++++++++++
>  4 files changed, 518 insertions(+), 6 deletions(-)

Applied to for-next branch.

Regards

Takashi Sakamoto

