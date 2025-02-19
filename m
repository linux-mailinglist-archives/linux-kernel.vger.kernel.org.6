Return-Path: <linux-kernel+bounces-521925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC41A3C3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A2F3A906D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362C20D4EA;
	Wed, 19 Feb 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="TQvtLg8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLBxrmDm"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF757200BA8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979598; cv=none; b=QtUagDq4OZ+nzANKwjXVWCPNq0Ku+w3wuQXpNPVbGYRQm2r/UvpKH/q5sS/F5/jy8VjxpObDzGHuVNKMphCsNcW5B3Y5Min+2o5792Hxr0LjNS3ggyavf4Fnb83+jz587khpLPr/UvnM1nNYdormVAnijTRYp9RA6xOgSI3BBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979598; c=relaxed/simple;
	bh=yM8i5FvIFIlmOfv14Kb5YSEjxQ5hZ6nkxPnVmlMU1Wg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R4MHVnEnwJ+0cVATK8q1oQ+ezS5XGZ4wuOqtRDAcz9SDF940DBvISdXAJM6d+BDTUa41HT6y96N8modxVGUEfEPOe8pVBv8xJeubCgGGE2CcD5PTDPGuM/ROWXJV19WdeQ8eLI26iG1NWQA+WTzLNU1pUF9iPVC1BJKg6kjBjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=TQvtLg8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLBxrmDm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id AE183138099A;
	Wed, 19 Feb 2025 10:39:55 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Wed, 19 Feb 2025 10:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739979595; x=1740065995; bh=yM8i5FvIFIlmOfv14Kb5YSEjxQ5hZ6nk
	xPnVmlMU1Wg=; b=TQvtLg8DSzJSEQUXeOqOIDlcnH9qkH0bSZyu7i7UdvzbIlgl
	TL1f1XqGWUSPD2B0OMJczkCLj7yObX5qlym/C1qDOcPaLUaJJdisU6DWyd3qQiCW
	WbyWd0Kwlzzx1LRcktUvztHOKd3kwgDqzZzGLnSEBtmPybEsOyxLuSzheJla1fc6
	P3iG06UelS0uvjlkUSZc+NRqrWN1d4QgzHzxJnzu3xAu+Co3djHoC0JLlvptszAv
	3pccvsVNf0ND4iveqrHnRklhO16/DST+HuGBAkmRHMjCg6AWTU0N5NkOiSd+c+bo
	CvNQOJ583gEJthBuY4+aPk8Ga+OvE0rZIDruiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739979595; x=
	1740065995; bh=yM8i5FvIFIlmOfv14Kb5YSEjxQ5hZ6nkxPnVmlMU1Wg=; b=P
	LBxrmDmWKXdq5Q95t82qxGvq8dPQ3F3xQorIhnQnh9UqPEVwj0sugo8gRNsFvXdl
	WAONl11zXFmuQUXscbMNkplIQ4/EvB3ljbf7A16XzGruCykLkoYqcS6QnYDZCX1V
	w+is2BVlaAhz93L+/0wgtYoKEb8va7xmmFt5TmcvwbhjnnbMG3szJo0lzUL45/yy
	IpziIiSplzjJXdmOVIuFT0hG4JeD1ucpqCGFYJ8+seK0WyOkcTgQnrRTmc3JDfuT
	zPFQ/EoKuZHZIywOu58o7yR5diVXk2Trm625bXwDiX/36mP4JTbBmmmUcqedR3Mr
	3I7X/u+idOjPVKHCNURtw==
X-ME-Sender: <xms:Svu1ZzJLfe0cVjoF9LdBJtgfXAKqp7C2poRQx-1g-TUCJq8U0PhVig>
    <xme:Svu1Z3IM9qVJkCNDiYPD2Kmf7JtRJX2ObB_-yX4mfDmmNFsujTaK1c2PM6bI8FbZP
    xQ0ucokGzKykZmzMKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhroheske
    gshihtvghsrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgt
    ohhmpdhrtghpthhtoheplhhinhgrsegrshgrhhhilhhinhgrrdhnvghtpdhrtghpthhtoh
    epfhhnkhhlrdhkvghrnhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjsehjrghn
    nhgruhdrnhgvthdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    grshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:Svu1Z7sQagXCXImMH_hnqANaHEBR4ZfrQ8jM-MuSFz8jvG0d3O-FKA>
    <xmx:Svu1Z8aNeHRscB1mqVgv9NvRU6e-SbuLDDsnCSbI9hA2Ya7aJkpRhA>
    <xmx:Svu1Z6YFgIm3EL2_H3oH3SuUGc3w7h1aW9ioyyFo-9bX98s6o1Yh_A>
    <xmx:Svu1ZwAohDpAkzRn2IiemR9ieb6u7ER4JTQvIdSeawV6yy5_PijJmQ>
    <xmx:S_u1Zyp5COJntRW17ipM7Ayu_QstX7Z7hBh8yjM7wZAlsRgHUv_hhhHU>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B8C6BA0070; Wed, 19 Feb 2025 10:39:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 16:39:34 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Hector Martin" <marcan@marcan.st>, "Rob Herring" <robh@kernel.org>,
 "Janne Grunau" <j@jannau.net>
Cc: "Joerg Roedel" <jroedel@suse.de>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Asahi Lina" <lina@asahilina.net>
Message-Id: <d6f24197-7f2b-4c12-9014-94e31a9aa6aa@app.fastmail.com>
In-Reply-To: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>
References: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-dart: Only set subpage protection disable for
 DART 1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Feb 19, 2025, at 10:13, Sasha Finkelstein via B4 Relay wrote:
> From: Asahi Lina <lina@asahilina.net>
>
> Subpage protection can't be disabled on t6000-style darts,
> as such the disable flag no longer applies, and probably
> even affects something else.
>
> Fixes: dc09fe1c5edd ("iommu/io-pgtable-dart: Add DART PTE support for t6000")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,


Sven

