Return-Path: <linux-kernel+bounces-268249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D943E942231
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6242851EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB961AA3FF;
	Tue, 30 Jul 2024 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="orImmod+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GraOL9S2"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292918E034
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374945; cv=none; b=HnefejZd0/fneQoOuor97dXhFNxJMQsnSpIa0M8ZJboC7hNJPSGu89aET5n2GtMd7BASeePkVylM82odWPL8hS1Qx3R++OXn6Hs0WfdhJvuiM3ZIL3VrCb+yW8J6KJIkKyFQSTz5IVrKLmeyl87vaAiX/dOLdwBS4zWciEnYSnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374945; c=relaxed/simple;
	bh=knetGNY6C2cwa8GAt8v6/ka8CsMwLOtRrOoMRfOt+Tc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bm+Avj1nS67cV/o3MOXGWJomIP49aJKaPtrAiE+xYpR82FAf4T1gnDQmTGy90e1qk/G/CooBpD/qPqAJ0UAUtgWzrhxPmgwYXQ45DFFILDW1asKXnIrmifNv88BkXkRa2m3JI+7geOw01147kZVoXz5byQ6g8+iHLhnt276aqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=orImmod+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GraOL9S2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C96091140153;
	Tue, 30 Jul 2024 17:29:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 17:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722374942;
	 x=1722461342; bh=pj+zRGkBP4jzT0UyToQqkBSXMgwDnGHAUOJTMSKIYWg=; b=
	orImmod+ozNn1vWgAK1BsUAAX0FX6nW1ghgZ8yqxCXgDX3u2zHgS3OFVkPanlw95
	2JVCkwnlmBE+3IyPaSDfBxj9u7PXp6I2YeY4VhK2oTH2UEAt2iuN8iQCzMHNRczE
	1gV5pO9tb6gyvbK60DNr6Gsy+VpPOZlhzPHJNU6BurhxCX+FdYflMYRUhytw1WFs
	HPk0aSCc7/IePXpA0hMCrsEJSDmJoMYHiHzBoQcY8y+EIuTrDTWOp/ig653Ze5fG
	/u48xoCDNAtyRN2umYAt8TWH1VHli1NLCDdyCLLCMhnMa9mIY8xY172au2WXhV7g
	rI7zKgsKxopcKPi/2oYCvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722374942; x=
	1722461342; bh=pj+zRGkBP4jzT0UyToQqkBSXMgwDnGHAUOJTMSKIYWg=; b=G
	raOL9S2uNtcvplA8lOc/BCdjbQLFBkFvoKgBnXxzhALZmvd2L+QpsAU6UWY35Esb
	6pWyP85HsP0WAyHMPz2oqrUVOGB+Cs0Tr3JFkxfStAVaBwN59Sum+SS3+cCtJ1hR
	sCb3r+aM0gwFlsYqe6Za/VGvzpp/cEn2ppKgF/R5VBq6C4F3oSrvWrhqWUTZWCgB
	g1uFAICMMhv0oJWOyFUlGCIjsmv4u/NYYiYljNSAcwcLp9+DjlffE4tn3myMBMfD
	Znwts43WzukS0Q036yLbFBe9zFr19HvrntQHGRm/aZ4gsdb95D1Kxe4DlgWYOJJM
	d334mgp0PWcXbX+aWWVZw==
X-ME-Sender: <xms:HVupZiiyl1n_vGsbHYjxGq3E7Pb_28t4DBbidHVKWYkaptOl7lT7pg>
    <xme:HVupZjDnfKSQBK70GLSDoeLV2X8FFNqPKUn5BhdhhhikeLm6ZEhGaNDEA93eZS1CH
    6AK_r3xClg1yY1CC8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:HlupZqHng_jNweIr1krthia7_o2cCvrMjatNyYsRSZjYf17jUmKjyQ>
    <xmx:HlupZrSxk72pQ9B6i0lyr00tlmmmjuhvoMDozwrZDELxNjLWsXOCXw>
    <xmx:HlupZvwlvo9b86J0v6MNH3XOA0OXBAm5VJg1O2LMPj1Iayhr1Ttj8w>
    <xmx:HlupZp4wTRdSQhCUqhZCb88zZhhJBykuQFcGql188NL_3dCgwkcT5Q>
    <xmx:HlupZkI9RG2-oQBSINCfcLwcffjE5eKiB8D2V6GaclzIey-muZ9PR814>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D0B2DB6008D; Tue, 30 Jul 2024 17:29:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 23:28:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stefan Wahren" <wahrenst@gmx.net>,
 "Umang Jain" <umang.jain@ideasonboard.com>, linux-staging@lists.linux.dev
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Ray Jui" <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Kieran Bingham" <kieran.bingham@ideasonboard.com>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
 "Yang Li" <yang.lee@linux.alibaba.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <3d3b7368-93b2-4c0d-845e-4099c2de9dc1@app.fastmail.com>
In-Reply-To: <e0692316-f8c5-4ddc-ab39-ba70cbfbdf28@gmx.net>
References: <20240730170840.1603752-1-umang.jain@ideasonboard.com>
 <e0692316-f8c5-4ddc-ab39-ba70cbfbdf28@gmx.net>
Subject: Re: [PATCH] staging: vchiq: Avoid mixing bulk_userdata kernel and userspace
 pointer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 20:05, Stefan Wahren wrote:
> Hi Umang,
>
> Am 30.07.24 um 19:08 schrieb Umang Jain:
>> In vchiq_dev.c, there are two places where the __user bulk_userdata
>> pointer to set to a kernel-space pointer which then gives relevant
>> Sparse warnings as below:
>>
>> vchiq_dev.c:328:26: warning: incorrect type in assignment (different address spaces)
>> vchiq_dev.c:328:26:    expected void *[assigned] userdata
>> vchiq_dev.c:328:26:    got void [noderef] __user *userdata
>> vchiq_dev.c:543:47: warning: incorrect type in assignment (different address spaces)
>> vchiq_dev.c:543:47:    expected void [noderef] __user *[addressable] [assigned] bulk_userdata
>> vchiq_dev.c:543:47:    got void *bulk_userdata
>>
>> This is solved by adding additional functional argument to track the
>> userspace bulk_userdata separately and passing it accordingly to
>> completion handlers.
> IMO this patch fixes the issue for spare, but don't address the
> confusing member naming for humans. It's not clear that "userdata" is a
> kernel pointer and "uuserdata" is a pointer to userspace. It would be
> nice to avoid the word "user" for kernel pointer in this case.

Right, also you need to provide a much better explanation about
how the code is meant to work, and what this opaque pointer
is meant to do.

Ideally this should be cleaned up in a way that completely
avoids passing both user and kernel data at the same time.

A small step would be to separate out the "struct bulk_waiter
*bulk_waiter" argument and make that typesafe.

You can also wrap vchiq_bulk_transfer() in order to have
four separate functions based on the different 'mode'
values and have them only take the arguments they actually
need.

    Arnd

