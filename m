Return-Path: <linux-kernel+bounces-170829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A228BDC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB5285D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28513C3EE;
	Tue,  7 May 2024 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QDkzOJii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4Y9uW4X"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7B13BC39;
	Tue,  7 May 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067883; cv=none; b=QOy4JrPfy/INbnQApTqvIWZQYvbal97cB48grh+ut4AKxdI4fZ4PY/+7NgZZ5jm3jZE+wdm6rya+ntbDxKGVFQXjdtoG2K95MLiqhWrfJl4dg2zj8pAphQRIL02rpVaLhmjq45oS4NjsVKY4xzc+cN3eljPZ2K/LHC8nZ1xCO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067883; c=relaxed/simple;
	bh=FxFVcw8ukYXxUTXisrNn1ic9eE23d22fWdXux/WRnj8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=hoq5XLshhPIvf1f8KOSOnC1uCKMG6QFBgpu7TL0AGpd3RhUSxqIBzUCsiy1bsaX3LX/COXsYXeIW1Uxccctto0GA7BTt0rmNX7kEZkYsBl1RjfwwSw/a3GtqqkT1TyrKxSTdQYzSqgAi1v0IlOvAOVNgOA0PHGdtbPlr1KQlEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QDkzOJii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4Y9uW4X; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 01EFE1C001AF;
	Tue,  7 May 2024 03:44:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 07 May 2024 03:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715067877; x=1715154277; bh=Sn9XL4Uu44
	Dn3ZaYtH4htpKwAIHtoteq3RGGcTihveM=; b=QDkzOJiisAYagILUGVNk+w5zLM
	IJrER54/Cns9qCHevVfo1AsqbNzmthhqEZkiTFT//0Y95pZzFHaBrwfI4xalMX5H
	99T6yHztxqEuxIXCkJcUwEjQwkdDWmkVSYkaO973fBWKp9ZHez0sjcLAzjyull7w
	djLnQ/7uYfUBu6XSdzHBdLBLwPOxYb7Z5c+67ptrSC9Jjoo0MJ6NKomCdwZQ+Be8
	bob61935DSF6lvM0WZ8/A7uIkl1pV/IFmCkGXZBcokKrcP+onNzr9xzpWmxVbRYE
	IHashS5/SxczMsAEVARezu/6UAmwW/uvyYxQZRJMt8UoJODkS3gzUUkSoIBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715067877; x=1715154277; bh=Sn9XL4Uu44Dn3ZaYtH4htpKwAIHt
	oteq3RGGcTihveM=; b=c4Y9uW4XKL8Z1AH0yPY/0A/pNyMDyATajaZc8ZSY9cmz
	LzEe0kJ5CaK2Qkj749gh+0UQjaU7He0enHm9mRUJ+TY1reoHdb9GNLqWgKzzmNOB
	6SjQaQfzDMeA+Q7eudddPt/iXujwph3x5FulZ5r1vjddhpDj9d6WPGR8Z94QgnVT
	qXuBAm69THRD6tMcBotxOciL23L+M6FnIWMl5ND8+Iisr187VyZfgvhwUHS7YVlm
	5J9uYZw3ezxwIvqugYL8Y5OIy+KYyvQPd2vQkx9mfo7VFBjhzTG/Ro4fUY2EbDs8
	h3Vov0Qb2ZOq4symdZM3wZs2Vbygi9JT8OeHGsmHWQ==
X-ME-Sender: <xms:5ds5Zl8cVEtE_j-PwEK5wMgaKhIzw0tOzGlAuAhtRd7CsHXhzrw_3A>
    <xme:5ds5ZpuK13XpB-SVfDPVC0hNaP8K2XvywkUNCUXFXUSerp52zBHzHOQ2LIpHAAYbP
    7fKUy90NFIPzTgQ5yE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefhtdelhfettdetvdetvdeuueegvdeuleeuudevhfeuhfeugfdvtdevvedv
    fffhudenucffohhmrghinheplhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5ds5ZjCekfvYLDaqbddzerCKKFKqtQGAmRkNV9nSj9oggofgyNJvQw>
    <xmx:5ds5ZpfmQqp7GoeOdTQTLKAskwhRQbuevJrksiMtsSSYjgugnnM2fQ>
    <xmx:5ds5ZqOcH1tUIpoEwuoK7UDJ_kleayqiI9152H7wz5a-HBHBvxw8VQ>
    <xmx:5ds5Zrm_WnQMqvEHn0BHOB0r-nMvbskDdHhiANnZnODkRvhK7QJ-mA>
    <xmx:5ds5ZrhypOh7Ovz7aLXR36zL6t7xlNxt1oLVkE1oiQVjyCMJGH_1_l9R>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 59EA0B6008D; Tue,  7 May 2024 03:44:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
References: 
 <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
Date: Tue, 07 May 2024 09:44:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Content-Type: text/plain

On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> The WinLink E850-96 board boot failed with Linux next-20240506 but there
> is no kernel crash log on the serial [1].
>
> Anders bisection results pointing to this commit,
> # first bad commit:
>   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
>   clkdev: report over-sized strings when creating clkdev entrie
>
> After reverting the above patch the boot test passed [2].
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Links:
> [1] - https://lkft.validation.linaro.org/scheduler/job/7546260
> [2] - https://lkft.validation.linaro.org/scheduler/job/7548064

I assume this is an actual overflow that was previously ignored
and is now causing vclkdev_alloc() to fail. Unfortunately this
happens before the console is up, so there is no output. Can
you run the broken version again with 'earlycon' added to the
boot arguments?

      Arnd

