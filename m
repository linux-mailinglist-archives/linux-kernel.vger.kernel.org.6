Return-Path: <linux-kernel+bounces-169629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488048BCB5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038B3281401
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500214262C;
	Mon,  6 May 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xw5Wosq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fGcTaVQQ"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B94205F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989479; cv=none; b=PnpGRxBeIemCbkQtobj0Q5hA6Z31VlD7Lnhx66Fugv1StRFO/pSarzT4nvbJxUQKIjAon6dJ5iXJ/Nvjji4vThEPtvoMPdh65OdtRMXMGZfAn2Q6cXfR0SRwAQehHFUMFQ0pfJ0/CwmKD3qhKqnJGYC2JxUwyVY7Y912uqej57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989479; c=relaxed/simple;
	bh=RGG/95bqgbV0UxC4j43Z4dKYTNz41JiHRc7ZYvy2ASI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OvuYYP4Qyt/L4HnludL4ST08v+iQiVWkbNsIK2vOO7yUANz84iqoGNPpD/Wbmh4O6b5M5dFsw1FdnHSX47hAjSG0769LjR98Y1QJEMUIsE8S0KFVec9DR+F0BBUryM4YEYrzbZbDbd1yRjU2rkPaf3JQaH1hWvRmNstwOusMIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xw5Wosq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fGcTaVQQ; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id D7F4518000BA;
	Mon,  6 May 2024 05:57:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 06 May 2024 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714989475; x=1715075875; bh=Kxaapcokfg
	FuUbfz89vv5wfELr6zFPpz8003UyV3aWM=; b=Xw5Wosq4086aDVg44LtHOuNw7J
	OHfat0R3Sr/CbDkAfawLrS8DG8B9Yo4bUuNpLKJWbandjeKnf5qK+WVwakNGQG80
	xOwPZ5osFtuigL+vBOIUq/oIUguOnxVZ2Ui19ZapSi0nwqtoVgCuPiPaIA35vVWC
	t23YHcHLs0pOlx4oEUtsEvhLxe7ULoXrnW+/JZdr+bc2sZevHYOTMFVDZ1PYrn4q
	rBM53Gs3H0J5MznsyvJaFEE02pqH/NGjpu8Hv8wPMWQ61X5YUcKlnYyNIcpPAWNo
	LrbbauYZq1+N7BtWZX6ZD1uxNd68WI2nd64/EJyguYmwvzgk97VcbUQASkGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714989475; x=1715075875; bh=KxaapcokfgFuUbfz89vv5wfELr6z
	FPpz8003UyV3aWM=; b=fGcTaVQQmov4GGZQDUAqm4iz6RAss5GQ4St9nIfSWgR8
	4StYSqvY70EN8HG5Q/q1nPOdujdmDrkOW6HI0eDSbabksJeTPl6mkmxgEYZ4+ca0
	cR0hnNyWy/CIzRAhrMGGNFMyt//JPxiwclPldo4lmN4eo6BBvlqniSTQhjNMyQcM
	t+KSP6KhLO99ebtX+Pytb3ObPzY22s1Y3hIkyoB0UAe/hMWlj6eEQ9pm8FjRuS5y
	to0jW/QnOqQaKcEM1Qd7mqeoP37N2A5/rw6EtAAjazlTv1VZ3EjxqlHog3uvNkoo
	sl/bWs45Hl9jeAOoqHkJkAK+eED/Lyd7mCQiAlfvlA==
X-ME-Sender: <xms:o6k4Zk0gDpOfc7Ll56NXnaZYdszyZoUZxcgssgYFLfzgPLL6KdBkJw>
    <xme:o6k4ZvEK-yIqAC0Wf8TpQspVaDqT_LxItpnV4NmIQ83NKGe2ZTdzehcKbMV6TtApg
    HvC_5IPhn58UYBlsN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:o6k4Zs6GRHw4CzsSCECn0Sj3LlLLGv8z-WReekFKBa6LXwKaoUrVug>
    <xmx:o6k4Zt3lFamNNVRm6L9n81UH8gMniuaRAUCkzlZMGEswrur9BJ2mMw>
    <xmx:o6k4ZnEx13Q4GZE-qJFlhhW0c6tKQLKSuDfc8ZT2dE1OYfDIYmWLBQ>
    <xmx:o6k4Zm8vHimKK5LlHKs1aB2mgdg4JNLp8wi2EBoCMRb3s3sg9kwAPg>
    <xmx:o6k4ZsSbksjCS7gQqNjJtl8G6kGNZppUXUtCiUoxCjfGtvysXz7dI4ZN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 19799B6008D; Mon,  6 May 2024 05:57:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-437-gcad818a2a-fm-20240502.001-gcad818a2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d87d0018-3109-444d-aa8d-e141be5b04a5@app.fastmail.com>
In-Reply-To: <ZjiXLm9ZnJwMHiBP@smile.fi.intel.com>
References: <ZjUzt3Rysyk-oGdQ@smile.fi.intel.com>
 <cb22252d-1ea9-4094-9f7a-b94c2142d1f2@app.fastmail.com>
 <ZjiXLm9ZnJwMHiBP@smile.fi.intel.com>
Date: Mon, 06 May 2024 11:57:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: compiler_types.h in UAPI?
Content-Type: text/plain

On Mon, May 6, 2024, at 10:39, Andy Shevchenko wrote:
> On Fri, May 03, 2024 at 09:34:13PM +0200, Arnd Bergmann wrote:
>> On Fri, May 3, 2024, at 20:57, Andy Shevchenko wrote:
>
>> > Today I have stumbled over use of __force and other compiler_types.h related
>> > things in UAPI headers. Can anybody explain to me how do they suppose to work
>> > outside of the kernel? Or did I miss something obvious? Or it was a mistake
>> > during UAPI split to move swab.h and byteorder/ (most of the users of those)
>> > to UAPI in the first place?
>> 
>> These get stripped out by scripts/headers_install.sh during
>> the 'make headers_install' stage:
>> 
>> sed -E -e '
>>         s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
>>         s/__attribute_const__([[:space:]]|$)/\1/g
>>         s@^#include <linux/compiler(|_types).h>@@
>>         s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
>>         s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
>>         s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
>> ' $INFILE > $TMPFILE || exit 1
>
> Thanks, Arnd, TIL!
>
> But do we discourage using these in UAPI in general? I mean do we have
> this somewhere being documented?

I don't think they are discouraged in uapi headers, since the
annotations tend to be required for clean kernel builds with
sparse.

I could not find any documentation about it though, so it might
be good to mention them in Documentation/dev-tools/sparse.rst.

      Arnd

