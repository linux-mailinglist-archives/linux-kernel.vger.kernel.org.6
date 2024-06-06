Return-Path: <linux-kernel+bounces-205133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69D8FF7E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114001F255F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D513DDBF;
	Thu,  6 Jun 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="QOsGYsop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIxlo2X5"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959B535C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714570; cv=none; b=Q1m4hvrRbEyt7dIl7E92umnjWYtHIOOXUTV6Y2sMUhXGF97CebESrr7H66rm46nOfDAA0qzO6tQMHPxwiaZs4TBAeMvNsh469y8M9hELSQ6rZ9IsLH246cRCrVwMKSfpruUAeou1y5S9j1/ffIUBz6/EIAJ6i2xCntBsoFQEbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714570; c=relaxed/simple;
	bh=4ZBdmYhhrkmCKJiHWE8eFIB+J5DTLwXslt2DQRWJaF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA+p0qKeNTVxX6cscZDR5RU2R8xDijKuMCjM/o9tNOvzHkuVh5Nivf4F/IugcwGvXjV0Q+5ZS9c2prihRD8nyTu7BtvoFPgNQqBpIJ4u9uczMsG8VHDA25HSvtYJQ/axJTyKS8gzsu5BazVMiQZNP8rLPnwAaIn+t3jrlsrBrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=QOsGYsop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIxlo2X5; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 7431B1C0010F;
	Thu,  6 Jun 2024 18:56:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 18:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717714563; x=
	1717800963; bh=uWKKo+Z8UTJJDqqZjBiSEu6T/aRvEGy74QcpJ0XTx8U=; b=Q
	OsGYsoppG7dFB8jiHpKxVcxe6gRsKERnijgQ/xZOBha5oXB5+6tdWgFpdkA5GBWx
	hn6RxEreTSG8UwdCTPaVn31gTeWOUyd8GwJJDq0wSIpwUeKgSm66WrQj3DDt9bKX
	7QU/20XPiUfWl0qN40udqn0L1BQsYnb6OU0Oq4E5V8/UVU1ziCuMRQKUPhkUbnmq
	gKIKExyS3p7/A3qsPz1mX67CgNJ7yhKMSqEnLoMNblIQ34NyZ+EDlSpdmfmrkW3Q
	R5o9z4w8cNgCCSOKuiS4BUw507eFl0jtmfNznSL7wtk/su/yvScdon7ApjrmzkMX
	mbVySl0qBJsb86hcr/D+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717714563; x=1717800963; bh=uWKKo+Z8UTJJDqqZjBiSEu6T/aRv
	EGy74QcpJ0XTx8U=; b=ZIxlo2X5hw0KFX5P+wnncHigxcha3u+cD7Npo+sGSwtI
	Nm+aYT7rH6YQFsLF6v95o+dwLHI3UV957XsT4HYwnuyJMZLdiprZgSB8uoTjep0v
	XtSaIYTOhy403jGw1YDw23macw6RseGVemYZAqq8ZUUYXD94bFGRD7mMDDJjuyVF
	2zlY37mrBIUNW27cPXceb42s09odVHrefPthbA7pJ1d46gF4ULfGgJr5EN0M/kZW
	3cnZy/w8hQFTXT1J0OiiXVbdsEKd9tUIM2G27FxoWEo5oMdPyNg2OmWWV1KjfLYD
	coYQtd87ASFVo5x7y6v4wTs/gFypQn/nXj1ZjNWCig==
X-ME-Sender: <xms:gj5iZtHH3SzNFE6pXiB77fd9uz0MVNwcvXeBBb3Tw4KgB1W9XWmXPw>
    <xme:gj5iZiX2lRY9gYZ5RI4AJ5987UqmcNMttsnpZo-yl0RoUZoHP1PWY4zLcqAQE9Due
    v03iZMZ8fZ3kya59G0>
X-ME-Received: <xmr:gj5iZvJje1DyQI2y_SMUQRuzNBul5V239c4St7A3wWBBe6H7xUhi7FZUrHnBxpsP55vbDe7bsy2Nex5s5JdcOMFizj43q6dV3NI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:gj5iZjFmUGQP7iWnhe5oJVPqUw9rF4WZ76GoLzx6lp6tMB-LYmsRwg>
    <xmx:gj5iZjVNe-GjKOIRne3QltgnFBEuVH3HksvKd5dt0E19taMEMk8-yg>
    <xmx:gj5iZuMZoGz0ifLv54qHgT1emz8GMMGC0zjDMuGbpI6etdCFBlWx_Q>
    <xmx:gj5iZi2JTkFx0-BNKPaENCmg-OmlrwNMopdc6DnnfYk584pm6gFuqg>
    <xmx:gz5iZgjsTHY7VdEZRRKhXdPAhSK_YG6Ok8-wUhkUlq6Ssz2gCVio2wBJ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 18:56:01 -0400 (EDT)
Date: Fri, 7 Jun 2024 07:55:59 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] firewire: add tracepoints events for self ID
 sequence
Message-ID: <20240606225559.GA179534@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605235155.116468-1-o-takashi@sakamocchi.jp>

On Thu, Jun 06, 2024 at 08:51:44AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In core function, the enumeration of self ID sequences is the first step
> to build bus topology for the current generation. Currently, 1394 OHCI
> driver has a module option to dump the content of self ID sequence, while
> it is implemented by printk. My recent work is going to replace such
> logging with tracepoints events, and this series of changes is for the
> self ID sequence.
> 
> The content of self ID sequence is delivered by a kind of phy packet,
> and its serialization and deserialization codes exist in both core function
> and 1394 OHCI driver. They include some redundancies, and the series of
> changes includes some inline helper functions to replace them.
> 
> In the series of changes, some KUnit tests are added to check behaviour
> of the enumeration and the helper functions.
> 
> Takashi Sakamoto (11):
>   firewire: core: add enumerator of self ID sequences and its KUnit test
>   firewire: core: add helper function to handle port status from self ID
>     sequence and its KUnit test
>   firewire: core: minor code refactoring for topology builder
>   firewire: ohci: minor code refactoring for self ID logging
>   firewire: core: use helper functions for self ID sequence
>   firewire: ohci: use helper functions for self ID sequence
>   firewire: core: add common inline functions to serialize/deserialize
>     self ID packet
>   firewire: core: use helper inline functions to deserialize self ID
>     packet
>   firewire: ohci: use helper inline functions to serialize/deserialize
>     self ID packet
>   firewire: core: arrangement header inclusion for tracepoints events
>   firewire: core: add tracepoints event for self_id_sequence
> 
>  drivers/firewire/.kunitconfig                 |   1 +
>  drivers/firewire/Kconfig                      |  15 ++
>  drivers/firewire/Makefile                     |   1 +
>  drivers/firewire/core-topology.c              | 219 ++++++---------
>  drivers/firewire/core-trace.c                 |  18 ++
>  drivers/firewire/core-transaction.c           |   2 +-
>  drivers/firewire/ohci.c                       | 148 ++++++----
>  drivers/firewire/packet-header-definitions.h  |   2 +
>  drivers/firewire/packet-serdes-test.c         | 255 ++++++++++++++++++
>  drivers/firewire/phy-packet-definitions.h     | 247 +++++++++++++++++
>  .../firewire/self-id-sequence-helper-test.c   | 152 +++++++++++
>  include/trace/events/firewire.h               |  61 ++++-
>  12 files changed, 935 insertions(+), 186 deletions(-)
>  create mode 100644 drivers/firewire/phy-packet-definitions.h
>  create mode 100644 drivers/firewire/self-id-sequence-helper-test.c

Applied to for-next branch.


Regards

Takashi Sakamoto

