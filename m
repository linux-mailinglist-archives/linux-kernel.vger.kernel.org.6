Return-Path: <linux-kernel+bounces-267806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738719415A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82E91F2526F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705281B5833;
	Tue, 30 Jul 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ljNScr6Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CcUxM9RC"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2C1A00FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354478; cv=none; b=fmTofc8J3Rrv73QzQBiHyQKI9t52UzoVDrK8n0FZbLuwECepsNN/6BnwjaRBdWoJFA3gx8oXGwcB7NYCKOZjJ0F5elZ+0i6pEOaQoyoOebo9NeQzhg2Pal8r2qlW3BLV7xePaJ8XamyRrJZsET1aIhjm9yQ/hqH6SMM+IMPwsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354478; c=relaxed/simple;
	bh=UtPguVCXKpLQ68hHUMSnPIij4jG+bhJWeWW3Sqr+aes=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VgxexXsMvTa0X2MyGz3p7/bf7J5KYkZPkce5FvUYvx5eyL8nBARNBfQw3qnqHAr3NNYer86DH3vvnYID6q/5cApkhT77EWiKi1nLhtVpZusUkI4rb97sFFD3bvLfzaUapeHgGKOeoB5cVuIiQ3vziVg8sX5yoojs/6MRVdD6E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ljNScr6Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CcUxM9RC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3FB0D13800E2;
	Tue, 30 Jul 2024 11:47:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 11:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722354475;
	 x=1722440875; bh=ytveEWMzvX7PpE7N+qjiZalxla3XxeYUpMUvtIh/G18=; b=
	ljNScr6Yv8dh2VMXr8lG/OENALlszVvsAbORbdwyRjBvnd47gfL8FiKV8t5Fh5Cp
	oT5bepCDyybPVEfVkNO4mOv8Iq1P9NJlnWkrH9xEfkM9LVjzk+4r7LoDJRgZRyE8
	CUbYsT50SDJgbiMolZEv+Auxy1nmk171wa13c6coqILY2u1Ij3KEHkizqnlpmOVF
	Evx/OhKAXixuLZMeZW1sJkWjce8DQvtvhPbHXP/JRzXd8pVmpTBh15fYx5AKOX+g
	4zM7Oc5WjKoOmH0Nq7bSHxNdFE4laalQRl8MEUu4yRjTjMTEorAyPKxxgGY2xmiP
	qqwsqNSI70qDIHeJGYUY6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722354475; x=
	1722440875; bh=ytveEWMzvX7PpE7N+qjiZalxla3XxeYUpMUvtIh/G18=; b=C
	cUxM9RCdpAiuO/nOexJjNpXqXWf2NpW2uKGN8YcSbPabLp+Ty0A+G519ajb00tDa
	kUgCmSzREPphc1u4DVHjPHFDgFygiOJWCK0vMMltxTERB5d2TbZkAtv0EL7kIrKs
	RV1XlG7p03FQ7cL90I5lo6XZtymhybgEINyje4VE+vqH6oxbAH8A3oRphzZ4zPqs
	/hpjWIx0MvEH9XV44kqkL4E/CP5BG9jD0O+ye2k4VREqH3IB7J8qj0xdg6r+q3FU
	IhmQSk8E9XxTevgAb4Q5ap6YqladGiuSF2hvsJRnWSJOhJKqfdvhmMUB0JZkVWD3
	6Z0nnLJq2GLvZ+ZblH9Xw==
X-ME-Sender: <xms:KgupZlOS7-UKG1fmlLT3TarQjVwsMAJ9KVDO5qRAvbxO0AVGgHNgXQ>
    <xme:KgupZn_78Uq_yB1hHWUMf9E2IdrAErzptjj0KSP7o2NwtqRKnz6-sqq04u9F3XEgB
    cY6LD0g3R-n3_as-Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfei
    hfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtoheptd
X-ME-Proxy: <xmx:KgupZkSHcEMgtMATEL05Z5GUGKj5I3o4yDE9qd7AgjXPWyDSQsFtIA>
    <xmx:KgupZhscBMAjvnRskIx1eqyQHz59Pnw3JLczQECfJWQ_DkyoSaswuQ>
    <xmx:KgupZtf9JwKZPeYY3uBiXVUPauTnimI3JAhLv1VVJrbLv-Cc8lY_Gw>
    <xmx:KgupZt3aMM6xXgtPSYZ-lIg5Xc55MyGemr-rAF4dupm7ywPOEg3Ixg>
    <xmx:KwupZlQyAlq34OHAbgDEMTH0I3HBLAjdflDqObdYvX652URoHNhAIWJl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B10BEB6008D; Tue, 30 Jul 2024 11:47:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 17:47:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Message-Id: <c7d7a2b6-d635-49d7-817b-51b30fd97f13@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wg5ebLqtgR84OpkWCxUfVMA2OLtMfdW7G3kzkzeex1uEQ@mail.gmail.com>
References: 
 <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
 <CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com>
 <eb1f2ec4-2bdb-4695-8e69-867ff25aa405@app.fastmail.com>
 <CAHk-=wg5ebLqtgR84OpkWCxUfVMA2OLtMfdW7G3kzkzeex1uEQ@mail.gmail.com>
Subject: Re: Linux 6.11-rc1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 30, 2024, at 01:47, Linus Torvalds wrote:
> On Mon, 29 Jul 2024 at 14:35, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> I suspect we can fix the alpha issue with the trivial
>> change below (haven't tested yet), but the way we are
>> inconsistent about these will likely keep biting us
>> unless we come up with a better way to handle them
>> across architectures.
>
> Well, looking around, the other functions (ie things like
> iowrite64be_lo_hi() etc) do end up being handled by lib/iomap.c, and
> parisc does seem to implement its own versions.
>
> So this may in fact be the only such case.
>
> Knock wood.
>
> Your suggested patch looks ObviouslyCorrect(tm) to me. I assume I'll
> get it through the normal channels after testing?

Yes, I've sent it with a proper description to the alpha
maintainers for feedback now and queued it up in the
asm-generic tree:

https://lore.kernel.org/lkml/20240730152744.2813600-1-arnd@kernel.org/T/#u

I also sent a fix for the uretprobe syscall number mess, will
send both once we have agreed on how to do that.

      Arnd

