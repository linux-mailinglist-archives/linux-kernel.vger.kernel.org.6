Return-Path: <linux-kernel+bounces-408483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E49C7F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760CA1F22972
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E6B667;
	Thu, 14 Nov 2024 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fJGPx+qA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaXfLiIa"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087C2905
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544075; cv=none; b=Xtc7zMHc9gO4MSFG38VBirIG46Xef9gpGxkMj+JsjrZzHIUBy2TcZV5ohk77KOR0KjGxRcBDYPSt277X0BRwvQ90PGRR8uJQTVNbFv2mb8nFo71+aIJ5WwqLMOyGeTXVYJ8tBZJbTxcIOttOoRcbaGvq4dg0SfxK9G7ZdCmHqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544075; c=relaxed/simple;
	bh=waSTe1S1Ang+bMXoVelj/bR8zSwr2A+eMyiFrNhKzps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2aJv48KZYaBxaMpngN5OWwwm22UQUuYhXOK4rFKM6uEwuV8svHGCfc8Xjlnjsz3gmuM2xkxVsxe26p761v961xnCC55U4xDsMIi/sXvmhooui20O81jP2avkmcBwVt/slMUrsX/t31WZAMVy6O+s7m6DDUwgzqjZUS3zRBWvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fJGPx+qA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oaXfLiIa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 37B0A138020B;
	Wed, 13 Nov 2024 19:27:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 19:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731544071; x=
	1731630471; bh=qurnviOz4iZ//bLPRY+g/wbA0w66JcS3XG3CD6yYHqk=; b=f
	JGPx+qAuvDJnWuUQTj+JqMhDfiO+nebiJEA/rZWL/AR8czFO1NUIrc+TXdo1icUV
	p+6drA28tb3VGde5fxow8VI0Razpv3dnjIbKnBg+aieBU+I1IfZYENgbniiu9ZM/
	6UigsGz1v54QaJzuMz1xJGvC3A2aLQXQfs69KBqv+CiL0KIVTqLXh1SLo4HUQq50
	UAtdJngS9CTx/AaQg5lhuhdomIRe2XlNhXk7GkOY0FBbk/UVnj/PULVXMebJU7yD
	vahV7M0YfkLG4P1bulrzKQIEoDyLQDAQZWR52K9m+Lg3nHOkmBXUyXb11UXoD636
	K6uhTDjJxwb9giSiHAulQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731544071; x=1731630471; bh=qurnviOz4iZ//bLPRY+g/wbA0w66JcS3XG3
	CD6yYHqk=; b=oaXfLiIaCUj2RRYiCWAvjColpFwlwz1lUWBjhzaIQMgWBdF6eh0
	WDwvvuDLrw1MOUCATpIQtgOHRvHs+rHmNolA/6e5BVI6IFGyWP1H9rB8fT3O0NU5
	O01NeA8MH5g0p3Hn2PoN/Nrul4PCyWQ61ylwQ9ns9PmjHIB8ECckSV7ldiLLs3bw
	54bQnY1JSR8wKQ4h0sYAnymlHocLMvX34PoylrtpeLcNEmvuEzZllYpt3NW+sirp
	G7ghsRGrctDuzj37EkdH9P6x/oKANhCs0wNqeGi6MXGCbukx4drz2SbeUGj8mfmO
	ux6vLtR3ri7g3az9XOhPB7oZSKv2TO7lWHA==
X-ME-Sender: <xms:BkQ1Z6d4urNQ3UqXqJi0v3ratbVBxYLJCcMzHYHfDAp8Ys0vcHs4oA>
    <xme:BkQ1Z0OFtWKuIkOOg35lF-26EcORrKQTkVP_bC_Nhgv9si2Mhp8_gp15xBOKpx_wt
    aQ0ARcH5FhXyX0BpLo>
X-ME-Received: <xmr:BkQ1Z7hHKAivgQDh_wYOC4elvJj2-3PdLyclxOqCCH0leXXZ7_1UiPkdQrQ_wiSYQLIKb_OY4a0hn7qQpy4Cr7_l7VAioCOngA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueff
    veevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgt
    tghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehluhhohihifhgrnhestghmshhsrdgthhhinhgrmhhosghilhgvrdgtohhmpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BkQ1Z39FGZz0ifwxUG1HnLM5UNhQg4-DpTegcJTv7qFm8nLJcYhCbQ>
    <xmx:BkQ1Z2t1ippgK2GmX4VrdgvzyoJwFwOlrv0oy9YTGu2-89vKcLg3JQ>
    <xmx:BkQ1Z-G8_Lu-PU08tj-lqhaLCeClURKTvW0HkAtX4a71MbCssI4chw>
    <xmx:BkQ1Z1MjWMzwPbDolSOfJWXNSVSRD2H_R51cNJ8CEIqWLNWoyR902g>
    <xmx:B0Q1Z6J9ESanJSh5eIN_R5ER2Biz3GmFkHtftSP0JCCD2vML_Hi-SNvy>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:27:48 -0500 (EST)
Date: Thu, 14 Nov 2024 09:27:44 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/firewire: Fix several incorrect format specifiers
Message-ID: <20241114002744.GA22321@workstation.local>
Mail-Followup-To: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20241113023137.291661-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113023137.291661-1-luoyifan@cmss.chinamobile.com>

On Wed, Nov 13, 2024 at 10:31:37AM +0800, Luo Yifan wrote:
> Make a minor change to eliminate static checker warnings. Fix several
> incorrect format specifiers that misused signed and unsigned versions.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/firewire/decode-fcp.c | 2 +-
>  tools/firewire/nosy-dump.c  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied to for-next branch.

Thanks


Takashi Sakamoto

