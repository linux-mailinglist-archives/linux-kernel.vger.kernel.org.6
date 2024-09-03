Return-Path: <linux-kernel+bounces-312429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63196967B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F5E1C23539
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E4200133;
	Tue,  3 Sep 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hVzsAq4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nejF0xQE"
Received: from pfout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15811D6786
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350768; cv=none; b=egSRZd+DUQa4XOqDrsB0vjHKX8oziTGLcbfyacFB5AK+ijTcSSFHbn7q48w8O1MRx6260662QpEzeQUgAVYYWOtj4u1dV9NitNHH1v3vBNE4sGIbcfrtDlHeuQTo/L7fvfMhKHmxlADpAAPTG+oJv9R4uFyfXI6JbNhqdYhEccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350768; c=relaxed/simple;
	bh=NzaT/l+YAqfzPE4spNrwhf7vUEN82gxYaV/WAlbSe+8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pGrILgWSzd+io4vx49+icEud0uAQYy8+SmzjIuSuoh4jfXVXJ4scN77mn8RQC8xef/r5P720W527pafB+ujmHSZQF15TcJ1xpIZvwMw/WCTjlh3NxNE4gI217NFJZnBxXCp1dz2vJ9HReJuD8zEsQ5HH38Rmuj1bDn7/t/cRufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hVzsAq4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nejF0xQE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id AE356138040A;
	Tue,  3 Sep 2024 04:06:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-08.internal (MEProxy); Tue, 03 Sep 2024 04:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725350765;
	 x=1725437165; bh=WkoLhRXNIWRoqdosoDQwLwxV9iyFD5EWWWKTgyYYpaA=; b=
	hVzsAq4ZZc23mpmcwZVsMoAPcpmlHkydXw3oyuPyAauQLjY1I9AmYZs/Auu0zd5L
	UbxIHPCNGDgBRrTg78O+iaNwn/bUc5eotPs+00DuvsqoMw78vI26ctIlnvyywPXL
	jR14SRg6W4J6RdTNmeilpICnhLakq++KrhaqJJXbuRwNduGNxm58uV5eeXJ0TJlT
	ohYS9dxGIKVzYZMWFgWEAOXzt1srNY4tSb/lvLv7aHiAECcRvRa2Sk4SMTHaKNX/
	5R4SuigdrFdoOzxCBVWgQOlqE+86byby9jfN/iFhMbSJDKqKBZJ71+P+1PUb7O3A
	HrE39hWQLKIGPyHdefbvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725350765; x=
	1725437165; bh=WkoLhRXNIWRoqdosoDQwLwxV9iyFD5EWWWKTgyYYpaA=; b=n
	ejF0xQE79lfglmZmsg+X5RfpIllpXbv7d5/Y+gyyhkM/TIHKWyT3H40sU/xCuDw0
	MlQZFmdu57tfqXkf5zyw48+FTa9Zdel092VgCX1P3ruO4d8nCbeL3IPD4kBsK5Fm
	ce/vEy5taH33e7S25HsTwWfruyyQw3ShcJD1NlvWg8R+CGoCCls7nEh34a0xQmi6
	b7f6fUpQrElMgH8KsC4IFkPTbMYaTHEW3tDVpBFdC1EYwtoqxOrSEf6j2tfn9ao5
	c5ui63yKWjCTQ1q9WSj0EWbqjdyBp6qW54reqtV5Qr1a73KN2ytVJ6Gzx+ituANQ
	EeUvMeSs8smO/9o3jnZyQ==
X-ME-Sender: <xms:bcPWZjSoDas8MHMX3I0yZuHcq-f9yz1sgpkPOO3Cf212BmXrHCbeew>
    <xme:bcPWZnU2k3RPNG2oLjCM9zV5mMG89b7O5twjchAJctGIx-nlEJhtKcRZL4chRZ_2l
    KEuNqVRcHItTmSkc0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvheetvddtgffhfefhiedvjeehfefhleffgfdt
    hfffffethfefleejffetteevkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhllh
    hvmhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:bcPWZscilRaYjgrvwjkL4Z7IPGOTRVzO2ke0gGgG6_NUdv3Jzaqz8Q>
    <xmx:bcPWZjJOv0kxzRrQTJ4IBBMzUAlAtteBLYAjxle3UeT8r1l2Wfh77A>
    <xmx:bcPWZhxnTTrfTgr8zKKb1iP3RJgRF-UUxZ5b8M2orUSajQCs0lI0Vg>
    <xmx:bcPWZhvFCcU6gKNL-XohuiYH4ojteiX5xIMP7sD1Gr4nIZ5KpVZLEQ>
    <xmx:bcPWZkG5v4Q030vXm9fjfCseyxdb7lSkKcH5Ykjo5yDb9GaSeynyjsSF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5329A2220175; Tue,  3 Sep 2024 03:00:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 06:59:49 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Message-Id: <2582a7d1-11bd-4952-a2e2-ab3f6b816f0c@app.fastmail.com>
In-Reply-To: <20240903012354.GA422360@thelio-3990X>
References: <YmX7z+BirkA3VAfW@zx2c4.com> <ZtCZF_yaHnECJyZ1@zx2c4.com>
 <f7069edc-a152-425f-afb1-8df326d0131c@app.fastmail.com>
 <20240903012354.GA422360@thelio-3990X>
Subject: Re: odd endianness toolchains for crosstool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 3, 2024, at 01:23, Nathan Chancellor wrote:
> On Thu, Aug 29, 2024 at 10:25:32PM +0200, Arnd Bergmann wrote:
>> On Thu, Aug 29, 2024, at 17:51, Jason A. Donenfeld wrote:
>> 
>> I wonder if the ones you list as missing all work with Nathan's clang
>> builds from https://mirrors.edge.kernel.org/pub/tools/llvm/ instead.
>> 
>> As far as I can tell, the main missing bit here is libgcc, which
>> is not always built along with gcc for all possible targets.
>> The llvm replacement for libgcc is https://compiler-rt.llvm.org/,
>> and you may have to build that in addition to musl when you try it.
>> 
>> I don't know if compiler-rt also works with gcc, but if it does,
>> that should fix most of the ones that you report as failing above.
>> The only one that won't work at all is um because the x86 toolchain
>> is already unable to build a kernel for that.
>
> I doubt my toolchains would fix this issue. As far as I am aware, only
> the native compiler runtime is included, not any of the cross ones, as
> the kernel itself does not use them. However, I suspect it would not be
> too difficult to cross build compiler-rt standalone and stitch it into
> my builds separately if desired.

Right, that's what I meant: building compiler-rt for all the
supported targets on clang should not be that hard, it would be
just another step on top of building musl. Doing the same for
gcc may be a different story as libgcc is not usually built as
a standalone library and compiler-rt may require building with
clang rather than gcc.

> FWIW, I have used your toolchains to build UML but maybe that is
> environment dependent?

Did you do that on x86? I only tried on arm64, where it is built
as a nolibc toolchain. Cross-building native x86 toolchains on arm64
is always tricky and I had expected that this would also be
a nolibc version, but it's possible that I accidentally built it
against the x86 glibc as well.

      Arnd

