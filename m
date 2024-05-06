Return-Path: <linux-kernel+bounces-169646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A88BCBB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E1DB218EE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E78142652;
	Mon,  6 May 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kvYRae4s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuh6Np1A"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209D140366;
	Mon,  6 May 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990294; cv=none; b=kFIburJrWpe+3/CGOXJWZN0YI+zXyuCbvaK3w6MSWntrXRlAT90fYw6azatXSrFxJs3mhKJe0iroQHXEeAtT9IGunniZP1B745OnkUCZnCg7KcRxL26S9ZLM+yq6jvMBL/zno0889yRJidjvAzllF/jc2vsqKz0aZ3f3sbIV6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990294; c=relaxed/simple;
	bh=f5Cv44/3AGGbCxZDcYogan0gqp+nPZa9mRSVy/zh26o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UFPlWake5vgKiqh2nt/E290mEYPKaKajX8hddL8cqwEs3wLWoSio2owQN3H4swGGF1/2O1GN3ZTD+ZqfgZm+bBUqhzBvyjnOJbq0pvf0bFOdDYLBwGpWTjBFAdFXokzwtslBRxO5RFOs08j+iMhgl6haso7CpEF9YMTcGvbE+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kvYRae4s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuh6Np1A; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5429D1C00143;
	Mon,  6 May 2024 06:11:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 06 May 2024 06:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714990290;
	 x=1715076690; bh=5sLzUkKc+UKzUKMy1Lp+sOpGVEF5QsoSKivd+RWMiRI=; b=
	kvYRae4s2eHBdTdrxzwywAY0GL/MaDl2Get5cfeUq3T+U3fcR6q79UubUM0fAW9u
	+I/CDDZFGrJSf9jzq8zYhNmoIyR+lrI+mWQZGeslVdlwAj9Oq+myLFqHf/cd7jKo
	oNvFS1LXdDGwkJtl9R8Gu/j2WzyCj8pEvyWNsij0FXvrMwN7SNgPXzEo7TskCCQi
	EfdbBw08RRqkd+04cEL+kMwK4X54x7uVboTkxetSj9uNhsWZJEduEkB5eIvmTy3G
	vXP/PnkOixZAONBWJwxFNCF4utCHHRpTzyM7fuHafxefOtO2D9rpgIr/gd3T0I+X
	z8WpXRAJwGIuCH+8tnHwuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714990290; x=
	1715076690; bh=5sLzUkKc+UKzUKMy1Lp+sOpGVEF5QsoSKivd+RWMiRI=; b=c
	uh6Np1AwzMtBUszkARvJ0h/Zl9RzgnvAAQqercW3KRBNzDkyjTBCMNHiV/Ze1e14
	okbAqdy7xeuzVYqJUOIICjxL75va06AXEbGcAPh6BhgxR3fR+LfVZNFIu5rJAjvq
	bgxdnatW2MehNqi3WeVB46GvaLemGaiu1zWDHLVEj7i4s/pZBMIbVD6sdgai4aBf
	7PzmySiUYPPkab/cbaGjr1PEjN7h51fIgRDZn25QjkzMPuKc33i1q8sGm/xIE2ui
	Pug1ZEt26y1+mP3NVv82pV1V+vjAwu9WrwAVrH6p/RfzLkQZMuoZBw3qrX80H1lM
	iMV0sqXMJcCVMCeIclp+w==
X-ME-Sender: <xms:0qw4ZgzLEdqWDvx5Yu1Qu6GLbh6qKxVZw6tfZvx6UhVJ0XY8wAv_8Q>
    <xme:0qw4ZkRYBrU6O0Hh248oNvGa0wlbt56eu5ST8viGr2WmGN6YtHuD4rvEwGJCc-HHF
    dKU6tPcwebDXavsNcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0qw4ZiUFERXTptYzyLR62REmVndJjV_tWH1cE0rVISMgGPxqeIRRUQ>
    <xmx:0qw4Zuja3Vtk4U-hxmiebOYjXdIOLSp_q39IhdXzdx99SSFFsE4qCw>
    <xmx:0qw4ZiBpRqoBccSVbef_zPT4R6nZ_ye8o9JKE71OgSWQ1BGcm_kpOQ>
    <xmx:0qw4ZvIe1Ox_Y5cPrNRkPA1VR2tj9v6QppPjQtWqcZRNcqYfgRCzCg>
    <xmx:0qw4Zm6DmftBwXA7wqgQD0g0fgQVhMrBFTFLM4Jf0ouQ4FXcC0uNB1he>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 58C75B6008D; Mon,  6 May 2024 06:11:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-437-gcad818a2a-fm-20240502.001-gcad818a2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e8612e21-4ea4-4e6f-8c73-9fbee11bf289@app.fastmail.com>
In-Reply-To: <Zjif0B9RKNO6hKsL@creeky>
References: <20240503081125.67990-1-arnd@kernel.org>
 <CAEdQ38GNU_vCFgi-uuFCW_QVBObTdD8VwoyQ71Cm5dNfZ4+=JQ@mail.gmail.com>
 <b72c2b7a-a929-4c7c-9bef-b230630df882@app.fastmail.com>
 <Zjif0B9RKNO6hKsL@creeky>
Date: Mon, 06 May 2024 12:11:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Cree" <mcree@orcon.net.nz>
Cc: "Matt Turner" <mattst88@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Marc Zyngier" <maz@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024, at 11:16, Michael Cree wrote:
> On Fri, May 03, 2024 at 10:15:10PM +0200, Arnd Bergmann wrote:
>> On Fri, May 3, 2024, at 18:06, Matt Turner wrote:
>> > On Fri, May 3, 2024 at 4:12=E2=80=AFAM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
>> >>
>> >> Al Viro did another series for alpha to address all the known build
>> >> issues. I rebased his patches without any further changes and incl=
uded
>> >> it as a baseline for my work here to avoid conflicts.
>>=20
>> I've pushed out the series with the additional Acks to
>> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/=
log/?h=3Dalpha-cleanup-6.9
>> and merged it into the main asm-generic branch for 6.10.
>>=20
>> Can you give this a quick test on one of your machines to make
>> sure I didn't introduce a stupid regression somewhere?
>
> I built a dp264 specific kernel and its working fine on an XP1000
> (EV67 arch).  Just built a generic kernel (as that's probably a more
> important test) and that is also working fine on the XP1000.

Thanks a lot for testing!

> I also built a titan specific kernel to test on an ES45 (SMP EV68
> arch) but that OOPSes early in the boot process with a kernel null
> pointer access.  I suspect that has nothing to do with your patches
> as I have a recollection that I have seen that OOPS before.

Ok

> So I tried the same generic kernel that I have running on the XP1000
> but that fails to unpack at the initial boot stage (!) with:

Just to be sure: this is not a regression from my patches either,
right? I would expect that any EV6 (or later) target specific
kernel didn't change much at all from my patches, while the
generic kernel changing from -march=3Dev4 to -march=3Dev56 is
certainly meant to be different (in a good way, with smaller
size and faster execution).

     Arnd

