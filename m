Return-Path: <linux-kernel+bounces-259832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C73939DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AC41F230DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5D14D711;
	Tue, 23 Jul 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VovkG4H0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3vG1Prl"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001814BF9B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726842; cv=none; b=eaGQnxk5bODPsDxy+Toc/LseuK1u+V4lmIXIeVCs0Ok9YXKCFyxYQbdJsa6QP2ufqhirIQmVUcHeiSSfymtjQg1aFWGzVJWLZiwOFg6O/4RELeS6AObtc1yxky6Mhziu745TdElZME6woIz614A8/7hc6juJKksxA5y/NQXIGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726842; c=relaxed/simple;
	bh=riCLUbPzyNcBu93l9AcKU/3CcImfKQMC7/oeCas8d+c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BaW3WT5dii5q1UqaO23sKvVMdHC/UwhrYW+KBMQTMhltYgfNvQxyVgO8PzlQUphUuXjh3SNKbkAz8uipvDS7hVFTGpexVCRrl9BRCf6KzMLan6UoAoSlZ2XC5eUKDucgLrTHttse+ogn8vpBgis5iSdMEJ1MgChkIN80gGzVPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VovkG4H0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3vG1Prl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2D901380671;
	Tue, 23 Jul 2024 05:27:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 05:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721726839; x=1721813239; bh=49qqSlXeZD
	kbFR3oQ93HNsOd31PpS/iHvGCGt2fqHPs=; b=VovkG4H0U7OKHX0rBD/GBXh+Pi
	uwnOG43/LEcxjBZGnOE/DsWalPl6xpdUlghKkL3Od1YJxfrP9MglP7/bn+WOKdYj
	R86xr+YDZLR9s1Cg8+MikkSv3yDFFk+LKbAsGrLjmY+j//zs+bA8q7aGLNvO/Sxq
	NTNdV9VRoUcDu827Q/IVOfWQ1pN3MzLSRkSf+IIeFGb966Y0ERWC2wLwvmQKnRUC
	onSwvWolYZBEbH6BW9Nk9VqprsCYuVcNRG39PQSzCu6JIb0lAC8IL8HDAeO80r9a
	/oF8Y+F5asKdRbYv2/KTnkdrcK8HATjfazUC6aWrmhyMzYvKE3oXxmP+QgzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721726839; x=1721813239; bh=49qqSlXeZDkbFR3oQ93HNsOd31Pp
	S/iHvGCGt2fqHPs=; b=L3vG1PrlD2UAVslSAVhnRU1qXwCiW+z30qLPOKbjT8M7
	0HaXGjQaelpisW8DhAZCX4RZAeK0kolse5oD7xUenLulRzuGj8Iiljql/gBlWbuk
	VBRZLjwG+AIuKIcARPl60ZWqX7gLgzkeQbPfTD8jDifObaI1PGEMOUA+anau0H3s
	d/XyvYzaQtO24OKm7dh+6QyI7CS+QkC5XJGk9GqF1HiKakIF1ZCnwxj+gPkgKGYS
	3F4bQKtVT4qIfcTiWqqYWCuqOq9zs9Idxfzm2N6lRiR5q8cWRU4W4e3WshZR27w7
	fViVaBrdvo9+2zWdf0rvtq6m70z4CiS+FVqKh30O1g==
X-ME-Sender: <xms:d3efZsDrXP0p8QXVxdaLb9e4f13ckw4MIZ5r1WJlP4P96oJwqETDhQ>
    <xme:d3efZuj8VHmuET1x7zVRyuL8KTAJ1Da43izY7c6K4hHO4D8cJIDLihQI5zxuRqv5E
    VWIcVOUjKjwIfGlmaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:d3efZvl2qFEWAfU8QRLxnPyKRqt97TmKb5dckEaCpc8DCDgZR3tVBQ>
    <xmx:d3efZizKDQBSmYlXnWgrGLa_vSHNyo51GQOZcQTjHUidnuEesLb-TA>
    <xmx:d3efZhRhVi6f1l8Uloy6v1tJXFSR47C9_eCP9Qht23sFiVW_FxRQ-Q>
    <xmx:d3efZtbpVa1uvdlP-KfOaUIbihJ21snoZY9QOb40del6EJiKdN--2g>
    <xmx:d3efZgHB3IzppcTMTm4Xg6dpzRxmWOvBoxygUJVUhA5wP0p98jdZ0gvc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 652A7B6008D; Tue, 23 Jul 2024 05:27:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73e4e259-f933-461e-86df-08a08c150138@app.fastmail.com>
In-Reply-To: <20240722094226.21602-30-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-30-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 09:26:59 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Jules Maselbas" <jmaselbas@zdiv.net>,
 "Marius Gligor" <mgligor@kalrayinc.com>
Subject: Re: [RFC PATCH v3 29/37] kvx: Add some library functions
Content-Type: text/plain

> +static inline uint64x4_t uint64x2_divmod(uint64x2_t a, uint64x2_t b)
> +{
> +	float64x2_t double1 = 1.0 - (float64x2_t){};
> +	int64x2_t bbig = (int64x2_t)b < 0;
> +	int64x2_t bin01 = (uint64x2_t)b <= 1;
> +	int64x2_t special = bbig | bin01;
> +	// uint64x2_t q = bbig ? a >= b : a;
> +	uint64x2_t q = __builtin_kvx_selectdp(-(a >= b), a, bbig, ".nez");
> +	// uint64x2_t r = bbig ? a - (b&-q) : 0;
> +	uint64x2_t r = __builtin_kvx_selectdp(a - (b & -q), 0 - 
> (uint64x2_t){}, bbig, ".nez");
> +	float64x2_t doublea = __builtin_kvx_floatudp(a, 0, ".rn.s");
> +	float64x2_t doubleb = __builtin_kvx_floatudp(b, 0, ".rn.s");

How does this work with the use of floating point registers?
On most architectures, this is not allowed in the kernel in
order to avoid having to save/restore them on each context
switch. Does kvx use the same registers for integer and float
operations, or do you always save them?

      Arnd

