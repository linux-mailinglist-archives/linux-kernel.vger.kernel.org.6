Return-Path: <linux-kernel+bounces-211431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF0905186
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B4B227DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D092E16C84F;
	Wed, 12 Jun 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="zmYIGgMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKbLgGX2"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5508155CA3;
	Wed, 12 Jun 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192633; cv=none; b=WhBAACLMUw8tTmsvzOmav9qcpVtCVYCPCbA6SbEImI+q1MReKaDMybNXtEiE8X+8Gjd7w1805NTFjfZ2lknJP2KpxtcjnQz4ds61r2XuSOmaq8gvgjf7kWV0qW3W+iInqgDfwI7YJgNEHwTyC58gyo+drTFl2reTj2mlNSckCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192633; c=relaxed/simple;
	bh=nCtIDla2vBKbLEZMvPSe0QMcswsg3yHehdUB5TE1HEM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Keu5kh4Svq6KCKldgIsthdyr/7I8s65WKh6vr216y3UtOOCSRhD7uQ5NiF4qv6Uko1HuMMj34eouJShnzQErMHnYFh0EmpPzf2JQ4yRjfrVp6J80S7kiYlkwR1mT58j6SlNqDsa7uTi3SJH+ALJFVPsX7pUsAkG+I27WxhwwRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zmYIGgMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKbLgGX2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D5B34114019A;
	Wed, 12 Jun 2024 07:43:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 07:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718192630; x=1718279030; bh=krNZLEp7cq
	ZwIns8e5yE6jzZ1M457FUiTW7BASFmO3A=; b=zmYIGgMvOgqwjLBi7vzLqfem23
	QuI6uTd3xZ7SBm0skCPzlxtvHJHQFRbj2FPwXzwpB213o+Z1WNj2PiLMMXgNu+VG
	f1R8rofWNgD6awtR3Z8udKFLk0uJ5d4q1sePqK31a8hpp/KZUxzUYICaC5gs8SOU
	Pk8at5ckLsxlw6INuSWxit04YKXiDbhrLBoOXOHKBVKABXpAz4dmk3ZmDA/zM8pt
	nXQlz16BycUFVg0JDfy38ST7/7KMHEJC9MGhmxjpaGkuXYFj3wX7oDP1PQYTlm81
	mpls5R7JT27kq78OgKDOiCEquFfwZFRW6jF9EuFIa48oVNS1cUjXeGZfFSkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718192630; x=1718279030; bh=krNZLEp7cqZwIns8e5yE6jzZ1M45
	7FUiTW7BASFmO3A=; b=YKbLgGX2FcFi0csgvHUoy7fKMn4dDaee9NiyijHYLCIA
	ZAHoST+l+ZUzsm1wGAfOpUWud2gPQaiiTuieYWG07phHJBODhqhwoV6jnv5VSgDX
	crxvVyKL0tB0NXyeqcDLVxr2Tc4oB0XnTUHEr5TliayfBs5947b7y2VscbNDD6H2
	hKbkiELuGPDw7t8tisiPDtmCBUB+Ya1VlS1QrWC6reBpAqmzDDkFgFu3humfPqLa
	9uKey3ImS4+VJ/z224MGQQGWhanHnZrUd4HSAs3GtXLBPF1WtmGjNEDmoA0arbwM
	JhRuWdK80G3ev9c+FhFVfQ6fqU3rFs+vNQW01idaMw==
X-ME-Sender: <xms:9olpZhfziGgjqzQ__-aIzTkHDK4uIKAF_rcpvKczSp9SAFMO1WCr3w>
    <xme:9olpZvNG4N_4n3XK9hVbgN8EfHjHzHTDie0PhtJXIIxeeWcvpWthI5GyLdvG_K3MP
    jP62K38pFQXAw2KvBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9olpZqjfoOt2B-mIRnJ9SeS_TFWCdvtqWTnTMlrDoTwABrh2Qjv6-Q>
    <xmx:9olpZq-WMwCmIav8X8NE0yWCqQkpyDi83D__KKH4DkuMT6TiP7WZ6Q>
    <xmx:9olpZtsm8FaueHpRI7mldedcOxrJdr6jvHTWbF5S71QQNox4iKXvRw>
    <xmx:9olpZpHp8wO9jMh0Nf3W6QuElkAl03dliWyLAOrmsLir-i7a13OuOg>
    <xmx:9olpZjACZ6VNYk3M3vrWAkCp3F-5kZJGxddWhxzlBQExVqr9sr0pMO5d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 252B5B6008D; Wed, 12 Jun 2024 07:43:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1f14e92-4491-45f5-90ca-cc3d5ceea81f@app.fastmail.com>
In-Reply-To: <20240612111623.102868-1-krzysztof.kozlowski@linaro.org>
References: <20240612111623.102868-1-krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 13:43:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, arm <arm@kernel.org>, soc@kernel.org,
 "Olof Johansson" <olof@lixom.net>
Cc: "Alexey Charkov" <alchark@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ARM: vt8500: add Krzysztof Kozlowski as maintainer
Content-Type: text/plain

On Wed, Jun 12, 2024, at 13:16, Krzysztof Kozlowski wrote:
> The ARM VIA/WonderMedia VT8500 platform became orphaned in
> commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
> and clearly it is on the way out of the kernel.  However few folks send
> patches to it and it is nice to actually take them, till the platform is
> in the kernel.
>
> I do not plan to actively support/maintain ARM VT8500 but I can take odd
> fixes now and then.
>
> Extend the maintainer entry to cover also VT8500 DTS.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Cc: Alexey Charkov

Thanks for stepping up. A few years ago, Alexey also had
some interest in this platform and knew some other remaining
users.

Do you have any hardware to test on for the platform?
I still have an old vt8505 (I think) TV box but never
did anything with it.

     Arnd

