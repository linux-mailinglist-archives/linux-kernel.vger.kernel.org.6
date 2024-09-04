Return-Path: <linux-kernel+bounces-315840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F496C78A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791481C21FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3A1E6DE0;
	Wed,  4 Sep 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lTqY2YMR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Js8iIcxo"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F11E7648
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478098; cv=none; b=EmIwBFaVjjWnxqpo1cTEzSkBqeKGnzw6MKSl2mfUAWBBHRVIF/J6gFtG9UUk1xYtE2b9QTOJPTU9YP+q4z4011/n8n1jIfw+QTte9okgErfo9Cwu+IgqgonDAxXAQWUcxgibnYz7Y9anayVVjVb5Uk+FAtC/onRcFL0rs4hD9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478098; c=relaxed/simple;
	bh=j9JtzA7oZrhdfz4BhQ6rr1o20qdXbxicbEEGWEgUOwk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OSzxJiAB887cisfX1RQ8G6wRZo4wD3mgJFWFXIcYixM0PcJLmYDrlxkkQ0yvykqq8OtFIR2u08HPAXYukIguqK1iZx/D9IUruHECqaKIkzGttBNeRYCIurvRp2s9NcsZIoKCN8CFJWD+5EV5vhWmti5eKLJ1ExGWOiqV5wdkF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lTqY2YMR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Js8iIcxo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A791313801C6;
	Wed,  4 Sep 2024 15:28:14 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 15:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725478094;
	 x=1725564494; bh=j9JtzA7oZrhdfz4BhQ6rr1o20qdXbxicbEEGWEgUOwk=; b=
	lTqY2YMRLHW6kolQpGZrpD6FkJiIave/lqpkCqtATDw6reefHCmgNW+oGPbTasmt
	zKk9Dw0MTt/wjPZFvuDzbxophzIs4Vibqz2LNyZVS8MiHgQ6RTGHGyqFYJUqwzGX
	FqVWQ+mNmYy9M+oJD9HchFnsgWqyIyv538F/TfLYL/GI8TpiUYgDE9R4VlQRhjWv
	aVn9u2LMz21/h4vdGPQZuE/BRcNuUaBkiI+egbGbsvFImU6FSm0fH1LG2RejyO6q
	fZFZnbjWwcQNnVlyBrezbj9IO/WrgWIL98syh1ZYoCFO2GFko2cWSEEqWvANgTfE
	JjZCCkVg1zRZM2mHHgBrLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725478094; x=
	1725564494; bh=j9JtzA7oZrhdfz4BhQ6rr1o20qdXbxicbEEGWEgUOwk=; b=J
	s8iIcxoivQ9o4636Ov3c5rg9jvNjTo6t9U8G4xF7jCaVbIjMBlB92N4EbisL6f4L
	7IWR9ydIJKPRpoW2FyZNiFH49p2eg1oYvd2C8KPjdbPC85q7o8LiuZIw6bjN9YLb
	2rJLrkdG7SuXODH6VwqoqSxwOGqRiMyHWUsu2EBk10t5BvXEuPF7MkmboXczpDax
	RnD/9CL7QR2iBVUbVdLH0PeGbWMz1/PN7YrYa+Ml1w5hCTuCkmg+/IWJARlWO7ig
	VlUYflUtGi3OHGWeE8LQaSokLUQ46clH5vbaic70tvhhhrbPRjtDcESieZ1npf2l
	JxMEl5SWBhfcAftpRwy7g==
X-ME-Sender: <xms:zrTYZoXbbelOaaVkRT9lRueNA3MmuPAnMEIdEN8bv1_sM9Y4tPSBDQ>
    <xme:zrTYZskRkhM-WJS943Jv92dbTu7VP__kpSJMB6-uohMD_rcQUUpORSRhOr1eCHyca
    CHBfzv0wo6xF8lerW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhgrd
    horhhgrdgruhdprhgtphhtthhopegtghiiohhnvghssehgohhoghhlvghmrghilhdrtgho
    mhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zrTYZsaA2DuIevPeUKtPDxjQJXUd1uYhwFeSIAiXz1p0yRxWM40hpQ>
    <xmx:zrTYZnUkTK561GsxzoVNYRFmQyA2pNC8VVPxvG8JYGREx4LkGIsMmg>
    <xmx:zrTYZiloTO3TpfrGNfE5Ccwnnz5vcb5X6614jtBBpe76zV95NBi2QQ>
    <xmx:zrTYZsfLz8MBB9Xm5VO1v-iQ-DFQhyimqGa-CI2knzC3Q1VY2-bO1w>
    <xmx:zrTYZkhDxT9Ck_40G1fK-sf3rlndx9MI3NQs8m5Cqi2anmi_hIftNmun>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3686E2220083; Wed,  4 Sep 2024 15:28:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 19:27:53 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Message-Id: <c607a122-ebd7-4da1-96a6-be153258f0f4@app.fastmail.com>
In-Reply-To: 
 <20240904-xattr_standard_functions-v1-1-60ccfa9d41e0@rivosinc.com>
References: 
 <20240904-xattr_standard_functions-v1-1-60ccfa9d41e0@rivosinc.com>
Subject: Re: [PATCH] fs/xattr: add *at family syscalls to common syscall.tbl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 4, 2024, at 19:03, Charlie Jenkins wrote:
> Commit 6a7fb6ebe371 ("fs/xattr: add *at family syscalls") didn't add the
> syscalls to the common scripts/syscall.tbl that was also recently
> introduced in commit 4fe53bf2ba0a ("syscalls: add generic
> scripts/syscall.tbl") which a handful of architectures use.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

