Return-Path: <linux-kernel+bounces-285662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F59510EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C85828460D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC1639;
	Wed, 14 Aug 2024 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GejHiIYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl3IIcxB"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4214A01
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723594334; cv=none; b=GCgw/7Cx3sZmjvtBH5uB1EHejsIOS6R5qCmJmhp4Byd+jjLZmEUv56rfd6/IyvSOokTb1FLYQnsAfC7NxbPP6RjIRKIoZH5FJhLjZUJGxfKhjTX8BuYeP3jislucoEB6zx3wZibV8QwJ9mA1BVJK+cZNaaSautzYqCx7fzNRXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723594334; c=relaxed/simple;
	bh=f+xaiUOx3B4RKDja9ijGLbXgpt+K6pYSTB9hbukH6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwiravYHdVk3XPBrf4i89xelXyTdihytJtKQuul9oJlkQQDDbCxbbTTTp5fqf9GzqGtrdBB5yQuosSBmoOjg4P0sakpKjkvuP6PStqbYfYcVDjvTjWBLq+1W47zlspDC5ea5DXs7vuZWf/btiTJ8OKErz/HjWztGXlrISWHh/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GejHiIYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl3IIcxB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8D16E115173F;
	Tue, 13 Aug 2024 20:12:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 20:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723594329; x=
	1723680729; bh=vTad3Bux405nKXI7e7I5fHtMjhpOQ9G4arPaeEasSgk=; b=G
	ejHiIYojv+K7mwQQJmHe5L2k574z61wDW0gxqa894NaTNxPcB4dJJhx0YcFt8ZSq
	uIoWAwqDZ1dmkVqPxR+0xDhMiqwHU1dwQ4TxtZIh3MmPmhw582KqTRjyN8QFquqd
	jQrC8sNOYXcyFdmbtXwFLsea9LaSmzcvSHCpTF/KgR8oty/Fij8ZHPCnnZJWRFT7
	ksh2yxXQ8wWpxvnbazt790KhRzDpPhLnH2X8axIEUToQRwszJGn76SMYO4JDCVPL
	lMTWMxOHlY/ADkcgm8G9tL8hcKYXo1LXQUNbObwJvx0jFmSeKQGwp/Bgt8qlpZGU
	keTK6lCdXkNnrcTit/8MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723594329; x=1723680729; bh=vTad3Bux405nKXI7e7I5fHtMjhpO
	Q9G4arPaeEasSgk=; b=cl3IIcxBbjUKFaFRcrIckr7guCV5PqT5D73Iw7yV44om
	FNHjlGJHFK3T9xyWfJpwBDOWRXImRsNKLEtJLqbpJmN5Hk8KIevkOEaClyPJMVAe
	xy1xoYBcBei6NlQCLNK+tyIWvDof+YPshRYvw7hNa8U1kLyttLY856OutpFSGIXh
	xQd6nqG4eEt9c4l2amyUeawqjXqIpiia7rxU3dnrU4DE6WLR0hbxQph8otoy786g
	FFf2qmoodDpl5cBQ7f3kUu8yzIOeazv1+RC19a+/r2UE9EwPLp6H8RIUQ3T6shdQ
	B2n+QdkoPb4k1+999GXkk81/cG3rcXJTJ5CWFmQo0A==
X-ME-Sender: <xms:Wfa7Zk_cJJf5LEMRL3Ot0krGBHauR4s8J3MYpgT2EtKb5sCFFx_X1Q>
    <xme:Wfa7ZsvjaluqdHnhVELH-U7HUwWTk2NvA-SwAwG5E1u4sitlkRQGCV4zi_Ca1O9Xc
    YtUgtoIKBdFbSqQPD8>
X-ME-Received: <xmr:Wfa7ZqC3r_VYidOlFZ3HOgUeHcw02KT6QCDO8pB2Eg2KjkkOaCV_5gnwBrypmaCGlA0I73dqipm3go-efekPr54BZxurY-uBzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Wfa7ZkdbLsf5p03_WFl9VvWDEnfZ4wsTmSPk4xH74qlLrrPAkFta7Q>
    <xmx:Wfa7ZpNrdmg_Jvl2UfdTT9NsFEDbXH-NtaUV50dX5uBuGOxim-lYRA>
    <xmx:Wfa7Zul7fAXz-bc27JkRyNtNaQuK5DSd9bsdiD60lTFxFSGPAlGTCA>
    <xmx:Wfa7ZrupvegeklREBVsMcDmlAF4aDdzFdU2KQu24Ib1qZDYJePe4hA>
    <xmx:Wfa7ZiY4HprCNqDD_zVvj5GPQXsR7wUbPuaYKaNLgkJAE53p8tHjH0s_>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 20:12:08 -0400 (EDT)
Date: Wed, 14 Aug 2024 09:12:05 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]  firewire: core: use XArray to maintain client
 resources
Message-ID: <20240814001205.GA12644@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812235210.28458-1-o-takashi@sakamocchi.jp>

On Tue, Aug 13, 2024 at 08:52:05AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In core function, the instances of several types of client resources
> are maintained by IDR, and the index value of each resource is passed to
> user space application as handle. As of kernel v6.0, IDR has been
> superseded by XArray and deprecated.
> 
> This series of changes is to obsolete the usage of IDR with XArray.
> 
> Takashi Sakamoto (5):
>   firewire: core: minor code refactoring to release client resource
>   firewire: core: add helper functions to convert to parent resource
>     structure
>   firewire: core: add helper function to detect data of iso resource
>     structure
>   firewire: core: code refactoring to use idr_for_each_entry() macro
>     instead of idr_for_each() function
>   firewire: core: use xarray instead of idr to maintain client resource
> 
>  drivers/firewire/core-cdev.c | 170 +++++++++++++++++++----------------
>  drivers/firewire/core.h      |   1 -
>  2 files changed, 94 insertions(+), 77 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

