Return-Path: <linux-kernel+bounces-206952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F490106E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F171C21158
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49063176AC4;
	Sat,  8 Jun 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Fac97a/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTE3M6ar"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D5C8D7
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836146; cv=none; b=fUdgoL0i/75GPXoIB6wjeyEGuB2LFL33UIlBFdEYTPeLRvCsQGjkdWGXxJf8rMuhy9D+s9tjy0A/dAhrJLCGlwx8PBT2Ac0M90SvWF04fSIvQE6SpcdPLJbz9M9E3HAcZ73zIlst3z70anrQkDP3LkcNS9MG4JhrhqV9Rf0shhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836146; c=relaxed/simple;
	bh=6kZFc5DiSeTnkUI62FQf0ML1rwBre/2oxEZulVNBqc4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UQDWp/twbMPxR+zPU16JWnah/EE4pmNz2ZcXzsExze/UUotlgMJQVU3gVkCZzJl14ffTdh3kW3ME7uUQ+dKjuXW20PGI+hy1/wjnM+8JQ7+yu/QbrBwzZWa1zIRqZMZRrbX47FT4TTX/QAtRkf8lqrpQnluV/AQC1tp/sLon5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Fac97a/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTE3M6ar; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F333611400CB;
	Sat,  8 Jun 2024 04:42:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 08 Jun 2024 04:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717836142; x=1717922542; bh=KrRV0K7qM/
	/zF7k7nBxFvGaC0VMKx5ZDxDv+YkPdsAQ=; b=Fac97a/DCp9qnD8GpA6lRjIAyG
	sKokYOKhHDMjZWerOvb0xSqTvbhPCtTzkyPrTEtsnZU6yA0HShcOSTUAgfSDcOS/
	NZlYXgVfJOxECQSyV+W3Ztkagulbz5CT2K3nSsFTHlpcY7/56BSdMRtwMpHyTjDW
	kWM7gwokp3fwTloQRqdL1QVQwt+obzVA8NATH7jWKZTyes9IMA9WZLBgL6wGUjus
	JE99tpWkXtYXZHMsLPchYO3EOCkO1ojVQrPPRVHSE2kNj1zU4rI/R7ZEUkTDdH0i
	6QixIliC1CCV/OLyNJl12gFvznjuTB1PWW5Fpg5j0sk/zuFx4f0/8GMHtsBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717836142; x=1717922542; bh=KrRV0K7qM//zF7k7nBxFvGaC0VMK
	x5ZDxDv+YkPdsAQ=; b=qTE3M6arSnyC2UTtWrovZI84D+ODsA48q2tTN1gF4Iqz
	g+KCs/O71+/92klOTCKniSsuekzVzZK/NoQqSqsZXMSfP9NMehLR61nHhQQUhC8G
	ZCAfwT/ZHwMl7xdEg5SBMKZsBC5qxjSMg3xXg3N4YBE2P1LDul9U7FnZF6hs16kX
	l6PR9V+w6nas5Z6nzdGCVNDqqSc6E/XswOrd23wNkyN8b8HnAVGZFzOVF0+NqkXI
	sWUGQyseKjeSqT1kbSNINiqxK7eyUG1iL4uZYJpoovrXT4XJvva/ZHUW03Bxva2j
	+cdyHSnCTyyivQkkr+0ZHVu63a8J+xYxL9qgpjRKtA==
X-ME-Sender: <xms:bhlkZk3JoiySAqh6tuHMepIwTKxYtAhaEgOIBmb67C1o2VZ3h_1lfA>
    <xme:bhlkZvH_HOPRm69TGyKH9sHhPeJTMlfmy5PzPzqHAbNFSKACoyA4IYN-z7tVpDN0N
    oquNHkWoQ0PjZcUzgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bhlkZs7X16i5h5_p2MCzE9aEfmb3uaXtrhhuGdUwfdwKf8Hvi4xjjw>
    <xmx:bhlkZt1ilarYAru6ECDTvNRjJtm4rRTvtr7zQL6AZZH7M-ol2OzNJw>
    <xmx:bhlkZnFqbd5WeNXVMrKIR6vG9lGs2ZXw9yuA8J1piFyvoXfN3wayBw>
    <xmx:bhlkZm90SqFHKARicqkXB1jRdGRJGxlqIEUldNwCpbDEUpvTvaXEkw>
    <xmx:bhlkZrgdus0xjbFz6DqEDnEbZpvGqjkx1_CKrDdUre1WFEA0LUCH30sn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A665CB6008D; Sat,  8 Jun 2024 04:42:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a4b1675-3244-4032-ae64-82ca8872288f@app.fastmail.com>
In-Reply-To: 
 <MW4PR18MB524422223AC92181942C75E2A6FA2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <MW4PR18MB524422223AC92181942C75E2A6FA2@MW4PR18MB5244.namprd18.prod.outlook.com>
Date: Sat, 08 Jun 2024 10:42:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Srujana Challa" <schalla@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Content-Type: text/plain

On Thu, Jun 6, 2024, at 18:42, Vamsi Krishna Attunuru wrote:
>> -----Original Message-----
>> > -----Original Message-----

>> > The ifdef is cute, but not correct, sorry.  Please use bit shifts to
>> > handle this properly without any #ifdef needed at all.
>> >
>> Ack, will fix it next version. Thanks for the suggestion.
>> 
>
> Hi Greg, the ARM64 cores on the Octeon CN10K hardware platform always 
> run in LE mode and this CN10K DPI PF driver is only supported on Octeon 
> CN10K platforms as the DPI PF device is an onboard PCIe device. Can I 
> remove the BE format and only define the LE format for the 
> dpi_mbox_message structure?, other HW device drivers of Octeon CN10K 
> platform also only support LE format.

Isn't this a regular Neoverse-N2 core? That means the hardware does
support big-endian in principle, though it's usually only used
in VM guests, not on bare bare metal and the driver is fairly
safe.

In general, I would always suggest writing portable code, as
you never know who is going to copy from your driver into
something else. Writing this portably is not that hard or
less readable than using bit fields.

      Arnd

