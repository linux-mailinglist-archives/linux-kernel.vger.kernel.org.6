Return-Path: <linux-kernel+bounces-260744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF093ADA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A612E2865E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB813A265;
	Wed, 24 Jul 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Hb0pcGoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ht7Ruf36"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFED1292CE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807999; cv=none; b=I02rCOPzecMwEhYauwLj0IiC3CBWs+mfOOS8MLsUPkGL0j2b96Z0NIQAVgEBU/zJqTgVw1wboSLUDfdsvOBMTVcGS/sx7CaBhTFe91w9jIg3R0lie4aX9Fl6v983nbM++gwCTdqpooKbLoyMTtVB/6vD+cjq0OoZf00X55djR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807999; c=relaxed/simple;
	bh=1eMibO36GjgtytG7QLswZwubelSbwgYZla33aXFIcL4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mm66a+b0Yal82uz2udhFtRvXjUI/B6pEHOVB/qDKHWIRUkOgHFHLu0nEcjvHIUWkJ5+jNOlgm3nTj8DFtlL7tcrtM1Q3DWQWyG0YmvGQchwbteB9PcQGYDHdBEWWdgKKauNQ0iisYSPSBpBOyOG/2k81LTm2rOrh9wUTJNSuh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Hb0pcGoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ht7Ruf36; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 98DD21140255;
	Wed, 24 Jul 2024 03:59:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 03:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721807995; x=1721894395; bh=lNXT5QONvI
	LDsvsALnW0bpLQbQcTmv2TfQREWMKZ7sM=; b=Hb0pcGohjFCTtDNPLDCLAbV8FN
	zBAYHO54W7r068vtddocXu3j4n5+Ry2jRGFu+AO+17Q1uGlbPoPbeg35P6oW3aNM
	J+AopyEYWx9mX0/rBOdGHl9ZC3fs3BkWYyHH1jrrlU/Yc/D2haElCSjvJjzWR36W
	/+Ff2nyZG111Hrp+Es347weHmyZzR3AxT1T2WeTp7lOStbQ+FSJauNkKLtVvasND
	CPXjnF2fQJst6ATQPBctJM/u2RNUaeELCnQlu+wpXHVmsP27FeHVBr+cQS8OBDax
	NIxUe2U6r/0N7OUBLsg7Z1FEnwgQVggi6j8NeRThMg9bgV6S2Oog/El+CIYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721807995; x=1721894395; bh=lNXT5QONvILDsvsALnW0bpLQbQcT
	mv2TfQREWMKZ7sM=; b=ht7Ruf36QnbzM+ZU1kHy6MHWw2GGAVkVziie6/+Y6Jq5
	uLA+y6qXK6YJCGWVq8lE4UIqr+ptey/Q1vzqMrC72xlESzLWd/6/zi14uj/sJ+Jo
	MB5hAmsBjFZ164qSy+dZY/sZt66SYEfGimpEtX9ywQDTwQ+HP7xF/sk3BLsVEqR9
	SlD/ognVU14WmUo93mV29j5BOygn1MWqUiW0tFx07wu1SWnKehCuYY1Qx3sj3P9v
	VHl+0Jfcf9AfcDS4ZqX5dpvwEE7fT5xJNRMifQXzHP9TVWQsIGBE2bGUjvCjYs0c
	GItdHH54lpGP5gFMYK1MOwyW7UixltmNppyiJXZhUA==
X-ME-Sender: <xms:e7SgZoWWVHd0mG3pcroBwpbvxwfSCFvBWoxG_VAZK3DCX-EorO5SFg>
    <xme:e7SgZsmw0S50xAMwqOtJ999atV0MsZ2-oHL9dPKTD5eMMAZhGSLpMsVCxEEmumOBb
    yvr12jam6wcm0zcCSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:e7SgZsYzyZJUYs3Z1UppbmbwiuBSdEP47HO32bSt4gsfpuxk0NbROQ>
    <xmx:e7SgZnVbmve4VMnp8M03XTPWk6sqey0SyxH9rGzuZvta-_Xcu7m_eg>
    <xmx:e7SgZinTAx3XNy6NMb3CFYz4dES8XveQiNkz6EEmdjmpLP1O2EyXBA>
    <xmx:e7SgZsdaCoMl8pISAv1MP4wClsYQblhptD-h49SIJKUD5va5V_7oqA>
    <xmx:e7SgZkiyIvBLpylWoApb8IUXdZ7N28vJXZoeL2E1AilcxebpommI-UDr>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6E0EDB6008D; Wed, 24 Jul 2024 03:59:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de10b443-b6b8-4829-94bd-e5648d9955d7@app.fastmail.com>
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Date: Wed, 24 Jul 2024 09:59:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>
Subject: Re: [RFC PATCH v3 00/37] Upstream kvx Linux port
Content-Type: text/plain

On Mon, Jul 22, 2024, at 11:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
>
> This patch series adds support for the kv3-1 CPU architecture of the kvx family
> found in the Coolidge (aka MPPA3-80) SoC of Kalray.

Thanks for posting it again. I tried to read through it
and point out a few things I noticed. It's been a while
since v2, so I may have forgotten things we already discussed.

I did not see any major issues here, the main things that
take work to implement (better atomics, vmemmap, also vmap_stack
which I did not mention) are just there to make your code
better, but are not required to get it merged.

> This is an RFC, since kvx support is not yet upstreamed into gcc,
> therefore this patch series cannot be merged into Linux for now.

Do you have a timeline for upstream compiler support?  I see that
your github trees contain both llvm and gcc forks on an older
baseline (gcc-12.2 and llvm-15, respectively), but I don't know
how much you have already submitting for inclusion in a newer
release.

     Arnd

