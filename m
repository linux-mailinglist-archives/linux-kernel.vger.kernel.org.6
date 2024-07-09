Return-Path: <linux-kernel+bounces-246587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8092C3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809691C2233A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05217B04B;
	Tue,  9 Jul 2024 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nch44eC1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPwP3bQn"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3D1B86D5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553606; cv=none; b=SHigzgvXEu1omV7TEEdS8sHlrdJUQhtiNk2dXK6DtSvwfjMCZ83obJIVnpXaIWR+3txWXxrapcwCKXiVeBikLR+duxkPk2K9Jc1wr/urmNU8BW2ImBn7evZ8MmceONFnPYv1C+2lDCp6/nPDFAUxhngz97LhrilVzDucLmgxx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553606; c=relaxed/simple;
	bh=0RZfBgZmupvxOas2m6iFvguY+l7cDh67NRGMRsrcFHs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SO1BCce8jOYuOIudaNoBxNw55xCSCy+6z17sbamG1L1P2/vxsB7+bZk4AC/AanneaOrVaUJHcBoqCbCkoStqTcJqoGKYcuGHkFEbr59ai+r8HIHI0WjloJ52HSMzeVWS/iNJyLhLZDIgQWyhoqx1ozCtkDFlWpAdbMq850gjtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nch44eC1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPwP3bQn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BA6ED1140138;
	Tue,  9 Jul 2024 15:33:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 15:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720553603; x=1720640003; bh=AE0fFzRZO9
	9KbEKs+v9clAHq1pXfvPK0Ierrsu1abhs=; b=nch44eC1+Zbz0IdTfvfecqBNjX
	YpXM7HfjV2RciRb0wXchwubHQzpnH6PsvZHaW2jiMaSutbhGYPkhFgNlggZLphkF
	ka2kBNm81rXrOEukmnBzavFh0WgXb4hW6PxEopZ8YB/+5MG9IwLiKo9Exe8xrHY+
	s7EMJCQEOba+aIs7L1ZhTAtROrenuQTPOfWAef+5Tb5/i8gm8OH5uw0y36kOtgSe
	njIGjb3XJkKkw8JuK8Q6fJsIq8fF0ZlgOdDiIapJ9FDonaSEfhlLc2PtX09g7e+Z
	kPFTnoy2/AN6g4kcb8IiUzGJhNsYNLWEG05LcZ1iFZaSRhmt4aCiKnd66a0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720553603; x=1720640003; bh=AE0fFzRZO99KbEKs+v9clAHq1pXf
	vPK0Ierrsu1abhs=; b=BPwP3bQn0yC3nVNRRRTrZkI7J45R1r79uxSCNIOfwTX/
	Pf/vybLFrBjHGHYBFGFefAIufoSNeY+eOh1iR8OIW2uBmICIykw+b46SFnORVyBf
	DQmqAW8s19+7AP9EaD+uqrQZlYwhZlDJjnT4SUeauxLj3TC/YUM0O9ueWtUPaV9F
	gAWIwDSwpXbbEIpVuzG0uIhiHFmFnUQPnYevbcRuJ8A9MuY8wyYPqnOC5ymgsX6X
	sqgbzu9H2rUkXoxmx7WtGNNJoklgBL3yVZwsrdRMm7HnayPetzYF6PEvITva/c7k
	aylQh60k0iUAJJ3AI6hT9iauRp8VpPwRVoiLC8PArA==
X-ME-Sender: <xms:gpCNZoCXVKxZYgd-tL_p2k9_uAle5NRuWFn4b8oB91ZexvboAwvAow>
    <xme:gpCNZqidF1K-9jUuTpzLvnQflD26Kb9sEmupPhPbyGA9GSp03Apa1q1viLXpquDUZ
    AokqUCeyiJz8LMOVVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gpCNZrlo8ynwoKGV2tVyoVZMt7SWJuifyw3wICL6bMUVIvZwXZo-jA>
    <xmx:gpCNZuw4KcrMuigBpuH5fvIFjqsotTvmBsQtqM4r_KdKiRkHuKaHIQ>
    <xmx:gpCNZtQIhXrJAMWS_snE1w-VQFd1vK5gHYOcGo9BFyaUAxzSgEFSjQ>
    <xmx:gpCNZpbW6SzaKP6FffvTqJOfe6Ku42gxdzjTMmwUfEj0O7Ox92ndQQ>
    <xmx:g5CNZq9s7g6T8sbAgzbFYlPgW05GWwkwxKheEFU6xYuovRAa8A8CY_up>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2F097B6008D; Tue,  9 Jul 2024 15:33:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5bfebbd4-d12e-4735-acab-549a7cf9604a@app.fastmail.com>
In-Reply-To: <0e0150ca-fdfa-40cb-ad7f-6ac695b702e4@quicinc.com>
References: <87y16bbvgb.fsf@kernel.org>
 <917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
 <837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
 <c9b23ee3-6790-404d-80a3-4ca196327546@app.fastmail.com>
 <0e0150ca-fdfa-40cb-ad7f-6ac695b702e4@quicinc.com>
Date: Tue, 09 Jul 2024 21:33:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
 kasan-dev@googlegroups.com, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Dmitry Vyukov" <dvyukov@google.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Content-Type: text/plain

On Tue, Jul 9, 2024, at 17:29, Jeff Johnson wrote:
> On 7/8/2024 10:44 PM, Arnd Bergmann wrote:
>> On Tue, Jul 9, 2024, at 05:55, Jeff Johnson wrote:
>
> I picked my favorite to begin with, enabling KASAN (which in turn enabled a
> few others). The resulting kernel did not boot for me (just saw a black screen
> after the GRUB menu). Diff between working and non-working config is below.

Ok, good to know. I've added the KASAN developers to Cc now, maybe
they have already seen reports of x86 kernels failing with gcc-14?

> I then downloaded and built the config you supplied. With that I have the same
> behavior as my original config, the display is frozen with:
> Loading initial ramdisk ...

Interesting, so the same config that works for me fails on your
machine. I can see three possible reasons for this:

- qemu vs hardware -- Can you try running this kernel in
  qemu-system-x86_64 to see if that still boots

- kernel version -- it's possible that this is a known bug
  that was already fixed in the 6.10-rc7 kernel source I
  tried, or that your source tree has a new bug that I don't.
  Which version did you try?

- cross-compile vs native compile -- It's possible that my
  cross-built native x86_64 compiler has a bug that is not
  in natively built gcc binaries, or in the cross compiler
  I have on ARM. I've mostly ruled this one out by building
  the same kernel using the x86 compilers through qemu-user.

     Arnd

