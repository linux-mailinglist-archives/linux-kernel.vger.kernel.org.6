Return-Path: <linux-kernel+bounces-354692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8A994114
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28291F29A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF121DF27D;
	Tue,  8 Oct 2024 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F5bT4Kzh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gF1ijFNp"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB591DF27F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373312; cv=none; b=f0c1Rrgj2AQKvsCyhonN2Wu8bGcUOyI8I+HFxWg5XUbKTBs5Cdv+WlhdHWpySz/wW6RX1upp/2sn5VGRjUPm+LwWizCvxAfQfC5woppkNc09HyjHWJzMnq9i5dmp1Zc1u1XC3qH22Bt3oP9Re1JhiRtAs+G/Bnc+92oZvcjM40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373312; c=relaxed/simple;
	bh=Se/O57LxWJf+msfsGQc8v+vw5iibLMggno9a818bibU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V9XKuW/SodTAbX45bhRr3cUwx7JSqBfhq3qmrWuw+JAcyJdn1ARv09zWFRmB5IJ5MrDu93xjvY/OdfsRUQkA1QZ3eIPMb+AO9Km1FldwyhgdUlpqPjyDhJvjXxDPkjs/23RJ9x9LYUTC8aUVXT/kKQRbwYCS4faQ3J+2Vd3bt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F5bT4Kzh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gF1ijFNp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 54B621380137;
	Tue,  8 Oct 2024 03:41:48 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 03:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728373308;
	 x=1728459708; bh=AtHgPq1YVuB8Y1ttGcq91HsezXfKAVcjI1KRrCI8WM4=; b=
	F5bT4Kzhl8kkJMkSjFXjhM8/8qUuykNsPQp5iM1PW8JpAJCtEfdiSscpHI+Ymebs
	3FWnsvLwIN9sNICfc8CiSPgnW54haHEqrf9uZ6bwdxTVM0hDTSCg6q0wG/t4zGGj
	szKpDqnDQccE6gcehYrLPEAuca+s+zyb6pI9tYqz4cSWUtL7QfCEP0sveIaQ8gCf
	3zEHRMvg6b2S0bLeiBkG76oMKQS++K9E5eU71dnhDIUcioa5W7D7Loumi0SA+/s3
	Ndlu2ae8ttnJH+GskIHoXgDd4pmNlLIwigPf4bnAVe0XXN9sduX39NDA+0zcpYlN
	Kqkt2hFgbsZ1UF4el6WCug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728373308; x=
	1728459708; bh=AtHgPq1YVuB8Y1ttGcq91HsezXfKAVcjI1KRrCI8WM4=; b=g
	F1ijFNpMwsdFOdAb7l08C6iB5U0gg5Wmg/kkbmrMK4bwa9FGgY1ZRMf5+dIVqSz+
	iwOCKCJe0qkx7EiW/t3AmVwwOr5O3KpIWK9RfdHeIEM1cSwp8Zlut2VMhwKWDXmh
	IopNRVBW9zsyLdKqs6sne6GETOdrqSuSW+L/3oAOaZeCTNyPbCEe1HiPgZf+tCK5
	ruatCmhjFzaAEiMmm+VrOxnxGAFjT5Tdw/g5boHZ74FtGmAVW/w+edVX0o4EyHAk
	qLlbT/CuE5Ln7GD1AXxBMO0WAKZhiEWuatDcrGYXvbMG1/o9obYFAj8rBLzhbp1/
	AXSdWKOlLPzdE9T9tCFKw==
X-ME-Sender: <xms:POIEZ93cQg7Ahvad7BXRN4OmWt8mnLm7Dv5Pq8BXEq4pVu_-roSv0g>
    <xme:POIEZ0G0mK7md81wqQQsi2QiqNco1IjPSL1kYEQn8F7gfr1hYTK_aYserBustX1PX
    _3RqWxfP-Trwao2n0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeftddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhhujhhunhdvsegtmhhsshdrtg
    hhihhnrghmohgsihhlvgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:POIEZ959Qwoh6awVUGUm9eg-BSgB1Pv-3xRWSlJL8Imy8kMcFZtG-A>
    <xmx:POIEZ613XdO_WB6KFBp4A1pD6B2_fNAJbm_UhS64w87AlAzWDl8YNQ>
    <xmx:POIEZwEnEY42gQXB4HfHVhfto1o-lOPD_GsjiYNxoUpots3AQvv8QA>
    <xmx:POIEZ78dKzqY7Qivs3e8Ypcl7mVKRYnY_ff_uct_tINc_3JoB2awKQ>
    <xmx:POIEZ1SzX_YvlIi3d3zCVmGDIJx8CYGb-vT9KDDF79lGyF6MQQMbZSLi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04D682220071; Tue,  8 Oct 2024 03:41:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 07:41:26 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Message-Id: <af62c108-0f76-4df2-a56d-0b08d26853e9@app.fastmail.com>
In-Reply-To: <20241008072825.12937-1-zhujun2@cmss.chinamobile.com>
References: <20241008072825.12937-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] drivers/applicom:Removed the unused variable byte_reset_it
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 8, 2024, at 07:28, Zhu Jun wrote:
> Remove unused variable and redundant readb in ac_register_board
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

This is probably intentional, as the readb() can both have side-effects
on the device and serialize the device against a previous instructions.

It would have been nice to have a comment in there, but since that
is 30 year old code, I doubt we get more information on it now.

Just don't remove those.

      Arnd

