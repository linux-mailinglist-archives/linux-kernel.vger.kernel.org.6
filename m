Return-Path: <linux-kernel+bounces-409573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B89C8EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4F281693
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873115C144;
	Thu, 14 Nov 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YQETem0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjaPlz4Z"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258813B288
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598959; cv=none; b=uTda8+dX6jgvrxAAmgPFfWjNLrFpIF6vhL89qkd0bB8AGpJ6+7hVW0rGoV5OPKtd3qS7GJgo/yt3c7Rx4aPQNo7XyB5xsP2yDXLjgGbq+BbUHc0dRpMkld/ZKbH41cazbts6Zd7A0AgIll1a6/fAQCqodrozpzRSc6/OAhdMqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598959; c=relaxed/simple;
	bh=DIOlaexXWBpXt5ZOxzCBof5ZqDcQG3H+YoruoWb52YA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aklopP4vojFZqU6Rc9TjkiH9NyLsXktPtyOd/UeGpUrRvo5lJG1C+HO4IsMjcgKV2xbzGyCL/JYJtyiXXsIsYddmTOX5Z+2iYgnpGJEFaqGRm7HCXmURg/5edGfiYf460MJhRbG60ITf2okEtqfMVdXwCiN6h/y4rI0vNcxJ6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YQETem0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjaPlz4Z; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D9E2138026B;
	Thu, 14 Nov 2024 10:42:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 10:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731598956;
	 x=1731685356; bh=AbcZDy48H7U/Pt6qnMvR1gC8GiMBry3sfz5Sp6m/oeY=; b=
	YQETem0KYVVXgGMNpr9rjjv4q+HpRSneAByExeTrKrhrJa9/8QPGkZCVwaDeXqWr
	7LL2u7rIt9S+u7juI1aXq25sU3dgiyXb43mf4sQ3mwgRM5tFtbCGtsh8Nam/nK/1
	dHD4Pd2v3csSTI316imswRaP0aoxzr4clrP15GaiAAFH476gDMYaDCpm5MofrSW4
	6S54UBA+N10WGBy/HcFI6tcyHM1yroPtbh4pRn9SZO3HIhsDSNsg2s+OnfZtA9fC
	9aDk3qz5KdiKljLCDTHSABdXyBsHb0RSY9O2RNLOdnxBsdFmmNTETWP/LsDHA+RQ
	afAAX9uFZqLr63FiU/xlFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731598956; x=
	1731685356; bh=AbcZDy48H7U/Pt6qnMvR1gC8GiMBry3sfz5Sp6m/oeY=; b=G
	jaPlz4ZY5d2ywyPSduy+xZR9YbzSYQp5wJlKAVpp+ph/nEylVZI9lNm1RzG2CRMy
	S2Ie1qqz6sxRrf8esjHaPfeb7UQlfJSZQcey0Hhd7gwFtA7rOUz3oj64s3rOiV4B
	sFn6KyAHxvBCP+JXUeCEH4AOkDi1VMw2lk1Ij+Kl/TvLmjTj5XUnvGrbfiAjQb76
	ARZPHXt/05Q7Y8GzpSMIffW4HebT+8z0bnFiLbWrmQoHNSllpcOefV81bGL3RLpX
	1JyLb5Bjav0trKl+ECVqgvrIpytdD4BcaI/EmcPYCDPNoW21izsH/wz8++ffC7ls
	gy+PclURJ5TdmJMCWIMtg==
X-ME-Sender: <xms:axo2Z0DRIqKtIAPOyOs8U-TUbCrYzH2-doyA-d_9wuy3sU9lCNhRyA>
    <xme:axo2Z2i0yP-gJP-IC-euBFn-yyQGk3VnmWh8UF69SVxoo7zDDP9z5x249ELC4S4_U
    enX4y-HHjHo2m0ZbV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpeeiffetvedutdeufeetkedtieffhffftdfgkeetudet
    teetvdfgfeefjeehffduueenucffohhmrghinhephihouhhtuhgsvgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehgvggvrhht
    sehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvh
    eslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:axo2Z3mYyrFdkTit_pHCoxS9H0leduW8mQj944RXPaD4zORmHd5SQg>
    <xmx:axo2Z6wNr3qxy8KnoPCD5XubldZzLdnZqoCTZ_Xb4DiAnDbhhPeBOg>
    <xmx:axo2Z5QepYFmFcfZGEAWgfrZ13KZmShfNLtt5fX62-1xpCKDIF8oFQ>
    <xmx:axo2Z1aZHZZvk0Fv36neu1STufAamh9q5lwZ_tdhngRaHrhS7xVTxg>
    <xmx:bBo2Z7eTIzXILtaHEBCIZNLtPsbhF-o4P3arZu_GspVv2bAqOHH1mjsA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 784512220071; Thu, 14 Nov 2024 10:42:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 16:42:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <ecb9d449-85dd-4ca5-a58b-43244b7c0765@app.fastmail.com>
In-Reply-To: <20241114131114.602234-8-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-8-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 08/10] macintosh: Remove ADB_MACIO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2024, at 14:11, Michael Ellerman wrote:
> 
> -config ADB_MACIO
> -	bool "Include MacIO (CHRP) ADB driver"
> -	depends on ADB && PPC_CHRP && !PPC_PMAC64

The dependency looked weird to me, so I had to look up
what that thing is. Apparently this originally had a PPC_PMAC
dependency instead of PPC_CHRP, which explains the !PPC_PMAC64
part.

I also found the promotional video from 1996 at
https://www.youtube.com/watch?v=NrvrIEPeSNA .

     Arnd

