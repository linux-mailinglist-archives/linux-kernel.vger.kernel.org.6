Return-Path: <linux-kernel+bounces-273255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30149946682
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 02:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96BE1F21E01
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE844A1D;
	Sat,  3 Aug 2024 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="DhJVtwtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCoq+ZA5"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33C196
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645338; cv=none; b=e/PE/GHvuGvDzRns9AYtgMCS6KS80ElGiYgEmjptLXXDj+0TnNIPtXjRgy7yrGPaBEib83Hve2KqK9WgRQzJOkCsCw2REkFKpDrWjuGZK1V/y/4Qojh3q8hVv9OU7fQIUaIrv67BiL9mKb9LLRPGWpLPMGCESVQwCtlfcHBRYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645338; c=relaxed/simple;
	bh=U6g6lgTInOMRJhalqER6ED2x9Gc28jzFoMs1J6nnqq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt0Lfa6C+pq36s+p/+q3NslSYwDK2yUqdowSNutfAv2LqTGSKGeWkhx5HF6+IDgcNZXvhoImNF0DWKeTNw1JFaDAoN83SD4mgtmGHCsLZ9jt6i1PkvzXfgP3pErlbYit+tIxm2xzJu79K3N5WH0JTXjTdlW7190tTIcJHyetqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=DhJVtwtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCoq+ZA5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2069D11501AE;
	Fri,  2 Aug 2024 20:35:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Aug 2024 20:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722645335; x=
	1722731735; bh=nWXzA00oAvCJNJTkqfyglpkPEK7WyOzwaaBXgacFBv0=; b=D
	hJVtwtmx3tkoDpxuFIOxijoIc/9h3ppd9o46+JXY3HEKtJV5h7jrE5346rlsWwj3
	bdlylYbQ01aDythB9uRihpF8D+jAhW2EXcEFYOmqjbHa7X8uHOlKhiwOAMftjQZ3
	8OoskkgL/Xl5iY8bEnwnVygBXcbz3Z0AYmzfRe7tEir7gN5pdcAo7FQQCF3hs8ek
	ahuI9HudiY6+OUFcwXZ2oyhVN9JI8W7SsJm8ZSDQ6qV3cmZgQvp84k4AVf2NBTP6
	UGt4veLLX+lL3JgCYIquqfO9NkDvWdzidK7DcytL9azI8N4F13/pp5oQ1cPeuq6Q
	QP6eX/zH//uhGNGe4tTlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722645335; x=1722731735; bh=nWXzA00oAvCJNJTkqfyglpkPEK7W
	yOzwaaBXgacFBv0=; b=gCoq+ZA5zwpYNvpgTb0LdIp+78HCzEF7hAkLdXoNYSna
	9PETZ095c569M7m5euVeF2iYQiauvqqB/NtOGAHIwn7ykWhADMCaXTIRCmynpVPH
	z1odRZFZe+eMbn5NnASnKtUKntNZwZ+IxeefD913B/bWIsP80HrupNtpfFAtDSQ7
	yqSsJIxWS/zNXORtufJ6SycosnRo7rO/sjlkl7QrN5a0Ia7elpwIQivd7/iguGIw
	xEOgzNkI2GzUszPP+iT+DOasz0ZssjckjADgtmLIGC5dH3IcapjLRXxYt0zMy7Wz
	H9Ay4nSWfckze3dhNYIeexrn0JfBepTG7Yjhy7MNMQ==
X-ME-Sender: <xms:V3utZiTCX3C8g0hMiMO4vNZSGS_Btrm0lTqW_yPJqKukVvdZpITkMQ>
    <xme:V3utZnwdWFodEEM6pzfJDBzmIxwXmNsHHyjgchAqIY6yMSfbHB2VVVXtJufV_ci_d
    zB4UH8hwXCyEn6o0Gc>
X-ME-Received: <xmr:V3utZv1Nsk8T2AiX2yaCcHYaZ8VxJMGVXWJk6O8NeWuOmk2jE2z9e4TdkAvRAoz3xDsl3kp3EoFMbsH6PtUoQ4CezhSGqXr7VzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:V3utZuDuG7GbZhLksuMX5mIr0Ry_bdaiUUQtHJUew2v9FaECNBS7AA>
    <xmx:V3utZri5RTThLjIm_lTkt2Uu6UItVGuYPwoKiRcIHYMQeEQuXyGajQ>
    <xmx:V3utZqr_ES2DxMUCbG34uGh91up52-erWMfjE3DSrd0YnjQ2DjgP-A>
    <xmx:V3utZugosusEiky7CTg6hsDWKtqLH4MPJDLqzC-K-zzvozQKc98qVQ>
    <xmx:V3utZutFuecgDF3LIYxStRFI_aCy4LpKmVAupIGQ06DE0_aGnAvC8QsG>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 20:35:33 -0400 (EDT)
Date: Sat, 3 Aug 2024 09:35:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firewire: ohci: add helper functions for data format
 specific to 1394 OHCI AT/IT DMA
Message-ID: <20240803003531.GA126786@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240802003606.109402-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802003606.109402-1-o-takashi@sakamocchi.jp>

On Fri, Aug 02, 2024 at 09:36:02AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In 1394 OHCI specification, the data formats of AT/IT DMA are specific
> and different from packert format of IEEE 1394 specification. Current
> implementation includes some ad-hoc lines to construct the data, while
> it is not so easy to read and understand.
> 
> This patchset includes some helper functions to serialize and
> deserialize the data. These helper functions are tested by KUnit, and
> replace the ad-hoc implementations.
> 
> Takashi Sakamoto (4):
>   firewire: ohci: add static inline functions to serialize/deserialize
>     data of AT DMA
>   firewire: ohci: use static inline functions to serialize data of AT
>     DMA
>   firewire: ohci: add static inline functions to serialize/deserialize
>     data of IT DMA
>   firewire: ohci: use static inline functions to serialize data of IT
>     DMA
> 
>  drivers/firewire/ohci-serdes-test.c |  66 +++++++++
>  drivers/firewire/ohci.c             |  66 ++++-----
>  drivers/firewire/ohci.h             | 199 ++++++++++++++++++++++++++++
>  3 files changed, 299 insertions(+), 32 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

