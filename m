Return-Path: <linux-kernel+bounces-409469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65149C8D24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14F6B27A79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1A45C18;
	Thu, 14 Nov 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CaW4KMyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qhnb5ZCW"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E752EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595348; cv=none; b=jSgORHgDXelNNwMFwl4cgFZ0I3LSAX8cOEPjTaiuVDIzzMlLdojOOVe8qCBkZFfkqq0+bjfLWEgS/JNVgK9C8A0WonNyycZzZQgyHaISSVkuTuN90rt7kTanOeKhuY7596d3i3nfVvpKdUBQ8zbVN6qJtLIAKdZT0lxdE0myM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595348; c=relaxed/simple;
	bh=d+Ikno+ZFVKYWdZ3jjxaqVwVRHUcpIv7yzpK/oJR0I4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ufigCu5oDRrUilJcPQqbxWMUeK8A2JyvGobIfYRvrLggiqE/8MIg9xF6z7ZFjRY7cpKJerM8ag5xSp0evX2KzlsqaRFm1hSstx0FwCgdt92iQxvg3SdNpz0jrc3b/rAozbnqIjgH+8038YoYVwUE8eHxXW0DV9CHMiRCPsauoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CaW4KMyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qhnb5ZCW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5136413801F8;
	Thu, 14 Nov 2024 09:42:24 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 09:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731595344;
	 x=1731681744; bh=d+Ikno+ZFVKYWdZ3jjxaqVwVRHUcpIv7yzpK/oJR0I4=; b=
	CaW4KMyAOGexXYhGpffvrReReIhm0wvgihJCAkrScp94Z9LDpcGs1h06PiCw7zeo
	dtP3HDsZT3TBI82JdTSd4hHeEqTliaPNA03MLBZcPWt+b1IWxwWu1fR9AN06hlhs
	p2BKSpdrZzOeh2Xz1HJdj14bPz4ec2bt1W6bkga7h2tTb8flmr65vN0pLYZzTNO1
	OdvmBeUgqrDhFwTgJWew7a9rFUpxHXjW6M30JFaaLT1Oqj8YtROCGQaaobhfoprI
	m8s5F1sJXpXUQiGMcz1GVGAom1Y6yHOytZaeRuyCzWxC2moN8TMZps0zFzMAMcPI
	Nw9cS48zdpEo36SyHgLGHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731595344; x=
	1731681744; bh=d+Ikno+ZFVKYWdZ3jjxaqVwVRHUcpIv7yzpK/oJR0I4=; b=Q
	hnb5ZCWyhF2Oc0DW3sC1a7LGVY/Z+P4E6sTsCsgP8tWavkdi+nGixvVYGSvHsfQ5
	ktGD8ydDdIuJCxC93OtapQuBsrWYxYBZrQdr43h0dyYzfNGWigYe+2B4u1DXgzDo
	ZyXJvkxj8JcX0y32DAtZim4m9gyFAeM0vmDk9R9n+VeUMMNwV9N3eTDmpnBgeBBW
	C6zwTMAFPkrAJOQ7K9grxGTBHBLP1fyQyNaJQvdCMFTb8oX1KaqnLV5R/nCep1cV
	rB7NhV9DagU4CewTn/8gaQyqeM7jcV6P90US1rYgA3NBFoHvXQZ9EgPLYYoNm/2X
	0zR6yOFZljbdBfHJ5Lz2w==
X-ME-Sender: <xms:Tww2Z3HFksmytPVQJoRMCgtMLEb4S2nr7HY847_983uOWrtwaviUvw>
    <xme:Tww2Z0WzA_uJ9-isnsrQuJ3yfVurZNqOnGT9Cg4kmw1eBuSOVTav9yECUU1rJ90oj
    EQeY8XTfTQgkqARW-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgvghofhhfsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtph
    htthhopehjkhesohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UAw2Z5Kqn0SHidYWTQdmc2h_b-e2b3eocJUNG9k8tN2KTFuKJlhK4Q>
    <xmx:UAw2Z1E4tspN3hJyR8iwVnDdo2Mb1qJ6FbM5QjXDPhLZDFweRqtH7A>
    <xmx:UAw2Z9WEHmurer65EKYEDKwam8VHM6Cas6II_RsqUZgYz4NvksBnCA>
    <xmx:UAw2ZwOJmLKNNIFZ4m21fI2i1lQCYpjMNhaG87gGsz4eirpesJhmsg>
    <xmx:UAw2Zzy1GPXJrNeBKWk5TenjwbQKlM2fxqRLgzJrmDN9gnc6aFvHm-tC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDAC2222006F; Thu, 14 Nov 2024 09:42:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 15:41:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, "Jeremy Kerr" <jk@ozlabs.org>,
 "Geoff Levand" <geoff@infradead.org>
Message-Id: <e16f8cd7-aa46-4f43-926d-21f2b77eb213@app.fastmail.com>
In-Reply-To: <20241114125111.599093-10-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
 <20241114125111.599093-10-mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 10/20] powerpc/io: Remove PPC_INDIRECT_MMIO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2024, at 13:50, Michael Ellerman wrote:
> The Cell blade support was the last user of PPC_INDIRECT_MMIO, so it can
> now be removed.
>
> PPC_INDIRECT_PIO is still used by Power8 powernv, so it needs to remain.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I think the powernv side only uses parts of PPC_INDIRECT_PIO,
so there is a good chance of simplifying that code further if
we want to.

This bit looks great so far.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

