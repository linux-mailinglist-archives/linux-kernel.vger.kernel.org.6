Return-Path: <linux-kernel+bounces-259778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E97939D04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604031F22B65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579A14C5A7;
	Tue, 23 Jul 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AggePin9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4SAfn9/"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85484DDDC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724959; cv=none; b=lfsARX3ylflktSw/QfoYpiR8lDp3ixuuhR4hsWZn004K5Sg69z4gGxyAhv3pFKVGIkkUxvFyFT2M8/hPxWfE1+gIckE61Zbw0WTmW+hd8XbZP5wXT+5k0UXabBBR95Fh6jIIepj37d93CBTjk2Pof6MosaJynA3GZ6Q5TG9116E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724959; c=relaxed/simple;
	bh=iT2o+3iGgzCh9nHcu5sC7KrN+lp4tflywhi0biic3QY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DPRqqjLO/SSH47zkaJQ98gIXVkFKwfXQCSh5eZ9iiEc1lRu49IkNMXuVY4WO/PA1eAoaAM3NBK/gxSl/OXhW9icpEw68+4/h9sZyRYpecT71+Yam4twt+o8SwQrrEHvZyhBzfgKTQQT9Cf+hKwUHPn6PawnOa6l7paObEc5HTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AggePin9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4SAfn9/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8344611403CB;
	Tue, 23 Jul 2024 04:55:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 04:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721724956; x=1721811356; bh=FyL5MTIimQ
	AM4wyC/Yjwd3fu3EluAHXlPeNmcE64ZIE=; b=AggePin9Hlu8yv9Z7NIlhR1VmN
	6qnKWWM8LvoMFUWOFQEkAQeTyczNLhvSrKxt95Li8xN0BFnHrai916Mm34YQmqmT
	QhS2g69VcbJtTq9EiY1YBL02GOIB+tSmrzlQegWJSMeH3WWA+ZKGhcVP/pXUMu9q
	x9BrfdvwxBZTempMMjQjrmoP3Cy8WIfT43C7irabPl1nCAX8KaoBN7Rf/XxgWKLS
	L8VovqqWGn2ggTfv/zeowjN0xP6SS12EXiIJe03q9lNswp9glJYA9H+GjDHZJLNM
	pYL4KZrnhPxGaeFUgzGF051S9aTnQNVplk8HG8tq66NYM8SaDSKzJe8Qy01w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721724956; x=1721811356; bh=FyL5MTIimQAM4wyC/Yjwd3fu3Elu
	AHXlPeNmcE64ZIE=; b=Y4SAfn9/2FoWLrGZL0eZcHGUcOF/6yNzflrE3zytKwHD
	YHhN8PreNpt/4ezxNrvOogR/E1/dpxWi0II/fU8l/JLOy3suzs7+zl8iTmzOyMbC
	YToJp9IzJkP/mZwdEQouZxxMGEi+vsY8cq1FGYYXp2UxP5YFSUZRKtaTRv/i35ps
	RG4NXcQkctbhACX63azUF8M2lsTQkrRXYfwOBdCguEibZmt8fZuNgmMD8sjK9g+p
	H1y4ju0OquL4vFc9Kg73Xue3m2qVR36ecEDuj9jyeEdWX6IcDqJtmmGMPeX2w/Kq
	u2Fmc0xMFpDzgwBMI3rin/ivyRzY9vEimwWofoqwLw==
X-ME-Sender: <xms:HHCfZkODXvRENkJeTOD069Zz0q7ufoOvdiZzy5Jm-fn2yLMayfxHhA>
    <xme:HHCfZq8x5lmA2LG0J6VvfbCjz_nKRaGLYp0bsdnLPyBVTq2erHV0EzBg4hQ5YKS0S
    2dK34Zv-ON4z1RKMH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:HHCfZrS5Wp6Lz2UoQBFXLPT-sld6cSNQeordywGjt83DJJ1KLdBkqg>
    <xmx:HHCfZss1TH7BXWuqFK7sYZX9EHHRawcVr4oPKTi3Ohoq4E6zid3AJA>
    <xmx:HHCfZscNLxxc6TFntmHn2UiRCjLNAcC8psINKrNlC-UT-4phEdXzBg>
    <xmx:HHCfZg1ExAwHg37FdjvDgfjYKVbhxaSbmkoMJxTau4AaewK3YUzxjA>
    <xmx:HHCfZg1017p9-8nHu4nDgpyVWJu6QhA-ijsq2Sx9EGI737y0EE7L2mRH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22206B6008D; Tue, 23 Jul 2024 04:55:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <50aed87d-a844-46f8-8adc-e0661e42a1a9@app.fastmail.com>
In-Reply-To: <20240722094226.21602-32-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-32-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 08:55:34 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Ashley Lesdalons" <alesdalons@kalrayinc.com>,
 "Benjamin Mugnier" <mugnier.benjamin@gmail.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Jules Maselbas" <jmaselbas@zdiv.net>, "Samuel Jones" <sjones@kalrayinc.com>,
 "Thomas Costis" <thcostis@gmail.com>,
 "Vincent Chardon" <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH v3 31/37] kvx: Add kvx default config file
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
>
> Add a default config file for kvx based Coolidge SoC.

I found only two very minor things I would change:

> @@ -0,0 +1,130 @@
> +CONFIG_DEFAULT_HOSTNAME="KVXlinux"

Not needed

> +CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
> +CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
> +CONFIG_PANIC_TIMEOUT=-1
> +CONFIG_BLK_DEV_INITRD=y

Should use initramfs instead of initrd

      Arnd

