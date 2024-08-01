Return-Path: <linux-kernel+bounces-270800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7994456F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42931C22552
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB371684A8;
	Thu,  1 Aug 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="e3CvIrvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SrjWNvEx"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB9157493
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497285; cv=none; b=nOoCGLh+8BTkNCnBUbj6PFYGmLMNiz68B4fLFhmMLL0BHbNLhdbenWSFHpi0+YWwAgxEFsXY04Y5lltMfJcqFRl5fGoaqigmAuEE6lGhnqM3caBhHwqld0yNY7HOK3TugJisZmT8XwfWk2fKpu8vXG5dSMLfzkHX9QT02EnSU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497285; c=relaxed/simple;
	bh=Mh2k4SdY3Mv/FgcySAynMkT/V1GngDOj3bWziFA/Aaw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c9z0srpqpmjGfZgDWQnwwHgphbq0aMqTJgRcjfC5atZQstQexwv8eLXpPozQUR4nDhAz55WYXsGwTj4jkShFg1X0iZsbNWAZC/r1UVtPnutdhRsaQpgIHTi/u/mhU9xDr7CWgLNTYcVNJDBUFAgJcv5XGpSAP3RPWxT4gtcdYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=e3CvIrvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SrjWNvEx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 26EC31387435;
	Thu,  1 Aug 2024 03:28:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Thu, 01 Aug 2024 03:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722497282;
	 x=1722583682; bh=6eGDxPGKy0jxPOc2U0NH7nKJUDsaTJFbI7niaMd1iII=; b=
	e3CvIrvUmEdEAWjuBd40xfB+Y2DeM65jOxwTHmLYaUHV2igarBOAQH1kQNAUAcYc
	jL4e45BcsgmuoT3oH6dSvihb6r/7G51L6qn6SSaT84gm5xbpdbp3ER3lNQslSzrt
	+RDAr5bG5VNXh7TzIkTJJ3Fu/Cu8XHW1LlnlV9iOe8XdtxMB7qvBhvHmska9PCHL
	tzzn4QeC287d3nz8uJjdD5ww7p2JuJwfuLwebPlCu/hvnvR6kjzZI/f/ZXR44J5q
	d5SyFbVU9Ww4i3LYypfFYsJvP1zLEjlfeOcTgzwjRfHem1j+6AZ8Ror4mX0a0K8l
	4Ok6UBKGcmX0GEwEcQCb4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722497282; x=
	1722583682; bh=6eGDxPGKy0jxPOc2U0NH7nKJUDsaTJFbI7niaMd1iII=; b=S
	rjWNvExiT8RWcVgLKmz/ly2xGsoSIl9NsEmzc2+9jRPGoqKcdCS4i7Ep80ElYwfa
	hWUa5CnQJYvyQ2KKdL5O0zgxYSzkAt9ii0lJbEt4h+4v+ojwsaLkYm+qcrhUvrk2
	54wHlJgXNBhJwUUMMIT9hfIwrdj0tzXw6nAocgNleIOmJ8gS6mMJE7ryTeOWedbo
	4dBjRYqbUR1BkJ0amZ4AYuG3A6oW5WCwVJxze0LWrAlzIh6ZtF6DLs1pRYOhMsmC
	3gvoh5WJKDip3dhQHUY5VHZXcfI5bS/SYojPlY5KvBB3dJmG//su4mBJqYcHz4k8
	5/BYgGvCx+B1ECe2Fe4eQ==
X-ME-Sender: <xms:ATmrZv7Lbd2UXcXofYRLWsI1Sepq9Zq4qWIPLStYx9-0JfagekbtvA>
    <xme:ATmrZk4rJIfKzhxP_Kcp9Fpd1Ufp7Gc0XkqU9HBrB70ExgMGsGWKRC_tcqUBRD8cU
    rqKjNFjLfVHJOv5x_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefh
    vdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ATmrZmfclpDa2rrKchD5zrIJG83by9U5UYUkRmdrcA9aY4lFtLTsig>
    <xmx:ATmrZgLOF-B5GV_csKrznAPgpl8Ooe3Wop4KBr6gbQHuZvqkKpGIyg>
    <xmx:ATmrZjJHVK-tph80UuOtF8q2EKPopSsgVkG2c1AZddmAD-7J-x7BUQ>
    <xmx:ATmrZpzY1917yQFoo3TnU5HR-d5ln89tmwdgp2AIsnv3-zhka9mbLg>
    <xmx:AjmrZgolR2qW58J5reoZthOCXGvdSNxtcb8AB85Xt-_lYFpCsk16hdJ5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D182EB6008D; Thu,  1 Aug 2024 03:28:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Aug 2024 09:27:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.Li@nxp.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Kent Overstreet" <kent.overstreet@linux.dev>,
 "open list" <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Message-Id: <969fb014-682e-4984-ad1b-7ab4f068ed85@app.fastmail.com>
In-Reply-To: <20240731233145.2485874-1-Frank.Li@nxp.com>
References: <20240731233145.2485874-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] linux/io.h: Add cleanup defination for iounmap() and
 memunmap()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 1, 2024, at 01:31, Frank Li wrote:
> Add DEFINE_FREE for iounmap() and memunmap() to support scope based
> cleanup.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/linux/io.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 59ec5eea696c4..7695d7973c8ff 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -163,6 +163,9 @@ enum {
>  void *memremap(resource_size_t offset, size_t size, unsigned long flags);
>  void memunmap(void *addr);
> 
> +DEFINE_FREE(iounmap, void __iomem *, if (!IS_ERR_OR_NULL(_T)) iounmap(_T))
> +DEFINE_FREE(memunmap, void *, if (!IS_ERR_OR_NULL(_T)) memunmap(_T))

I don't like the use of IS_ERR_OR_NULL(), which tends
to indicate a problem in the interface design.

In which cases do you expect to need scope based cleanup
on an error pointer here? The only interfaces I see that
returns an __iomem error pointer are the devm_* ones, but
those have their own cleanup method.

    Arnd

