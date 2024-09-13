Return-Path: <linux-kernel+bounces-327898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85710977C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484FE282B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A91DA10C;
	Fri, 13 Sep 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="B118NSrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QrPMrTWP"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B91DA0E9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220374; cv=none; b=DFsdxNjXwQf4kH/p3EigiAXA965rvPDTdxS+cVwfwbWoDfGRdFq1JivpvkktEJz5HqrjJ570crKlCOLFMieK4T0Ys9T2wIr7g54p2FQqTCTNg5DMSFfg6t3t4inI3iHBubtOVAyErw9xj5QX7/TcGQf/jti1MSUi9CwGB8UjN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220374; c=relaxed/simple;
	bh=6cb5t+fTSf/q8SRIsj5A1pENiR+ri6cJhAGYrpbOlrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiAlTtBdjmPz4+7gcJ1PDCSyOiQMkly3j/n9ax/TpiRHWwY0xyRpNcBXzcjji1/zVZYSmT2MNfFLtZLNnYpdkOogd72Jg5ZexM7rrq3baxMNBGIZnLV6Wplw1Kq7WipM6dkftlinyT5G6LhyBHT16iyULWoPPL2eL7n2tGfu/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=B118NSrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QrPMrTWP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 26E0E13800D9;
	Fri, 13 Sep 2024 05:39:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 13 Sep 2024 05:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726220371; x=
	1726306771; bh=Hx//Pjz/OP1UcHZsNvfDJfWtoNQ6yEecv9JGrWMIp74=; b=B
	118NSrh9XNEy+aU4nxThFkKOGkhtmSUrMAR2/mBPkyHdgOI2PPqfgumn6Iaru8LN
	Kwlwl0+sCOP96hJkvHIpNsvoYYYTAsyfsWRYVoPA39ak1xnGJGB02LOY1URiri8m
	VST8Lsg5dwySEAke7IQsYOQIWRlUIe1ob199u20PbDzOUlPfuFl3ohGeyHm+XQ17
	SCp/gBQKnYgiQHxaoayJ0rRNCGsXWbOFYX5PBeZW5jdrIrYSZzA5yDJ7TvYzLvYb
	mkGJYykFiZrRRxsf2NfA3Zq1utWzFUPKGGraQ6yXD0zqo9kkJ2cn22d8fpYf9wlO
	r30EZNzmY82wgXRq0U7zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726220371; x=1726306771; bh=Hx//Pjz/OP1UcHZsNvfDJfWtoNQ6
	yEecv9JGrWMIp74=; b=QrPMrTWPwtiJTAkBEVbHLVGcqel7j1UK8B1wLQABUNIS
	AI5G0kjrD6dcXXf1LlxtU++A34lyopt6fvVgDRcNHDPNI+kFW496CHoaY6G7IQ/y
	XC6yhUfqx6Iixg9r40niHrIxLm4tOhw4NF3gnolJbnVAbpyRfWhMT6PhDuyyvyLs
	ywrmxro9c6paOCOR95euEDriD+X/pbZIviorFowRBU+RhV1ueBcreSrwTwOdpCo9
	LRrTAAWnqcW+hlgEO7/GSzBBuE1szcfNV9Dxi4IUwQNZQXQ0RFdOhIKZBWIPtZBx
	7wePl4YXPqH0eb6YCi6t7PAnh+XrleuFGM2nqTt1CQ==
X-ME-Sender: <xms:UgjkZpZzZtkP3eJaw5aRcn5ndu4V6f80dMc3SWTOijMR0yIJRzjDVQ>
    <xme:UgjkZgYXtoYUrD5X7312vH9nk-2Hk2vKmBhVorScvfHK8HPHJ6g4CGisIAu3n-C5n
    h-0CBPuG0MxIrrZxCQ>
X-ME-Received: <xmr:UgjkZr-JH1nVJXwjhjrtEgQXY8R5Dw4vHqKeLspbgliIN7gMZoSw5ztbbBXTD4gM2Bu8IwVvflIQo15xOCrql_WMElXnryll9Ifc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeeileejheejuedvgefh
    teevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhho
    rhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UwjkZnqsJisb_vF0xvZ1SG60j6pUWtDrOfgJiS78SCrCS66jFmzMZg>
    <xmx:UwjkZkrQKCeiYoQQkgjc0F-Z3R7VsGUlkvqbXbrcDkFKCF-hEcXTAw>
    <xmx:UwjkZtTHoQgfcLMTxK1sBsbk8Dw9U71CZ3iN_oBbvPkkhlUj0OA2cA>
    <xmx:UwjkZsoeeIjOC4Nw_GzCjgVxHNGvPgdjvMeTDDPoQD1V8iZ4bY90nA>
    <xmx:UwjkZr3cHTN1CMPxqey25u78hOWkldrAoPOj6b5Y0B76SXF8GizEB0Pw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 05:39:29 -0400 (EDT)
Date: Fri, 13 Sep 2024 18:39:28 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firewire: core: revert changes to keep interface
 compatibility
Message-ID: <20240913093928.GB305057@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912133038.238786-1-o-takashi@sakamocchi.jp>

On Thu, Sep 12, 2024 at 10:30:33PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> It appears that the changes in my previous series[1] bring the behaviour
> change of core function in the view of user space applications. It is
> not preferable at all without any preparation.
> 
> This series of changes includes two reverts commits as well as some
> minor code refactoring.
> 
> [1] https://lore.kernel.org/lkml/20240911151253.GA167609@workstation.local/
> 
> 
> Takashi Sakamoto (5):
>   Revert "firewire: core: use mutex to coordinate concurrent calls to
>     flush completions"
>   Revert "firewire: core: move workqueue handler from 1394 OHCI driver
>     to core function"
>   firewire: core: add helper function to retire descriptors
>   firewire: core: update documentation of kernel APIs for flushing
>     completions
>   firewire: core: rename cause flag of tracepoints event
> 
>  drivers/firewire/core-iso.c     | 40 +++++++++++----------
>  drivers/firewire/core.h         |  5 +++
>  drivers/firewire/ohci.c         | 61 +++++++++++++++++++++++----------
>  include/linux/firewire.h        |  9 ++---
>  include/trace/events/firewire.h |  4 +--
>  5 files changed, 75 insertions(+), 44 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

