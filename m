Return-Path: <linux-kernel+bounces-197199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24618D6773
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C881F26A71
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2A16D304;
	Fri, 31 May 2024 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTW0caGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17067158869;
	Fri, 31 May 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174517; cv=none; b=rRpB6sEfAij3lI088nMdf2g19KXwW1KqRJb772YeUv8kXH3Ibktsa5InZB2mrSjJOfYwJHLTldUGnbPJU5WQtrfp5elcCf28VaMPL6fntJJcaZq82P4L1TjhvUGLPNXzftDFGaD4NiUjHTs1di020RczdZqhK/eohWfOt3JVGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174517; c=relaxed/simple;
	bh=7QPWM2N9EG2WUmorU7S5Ra1EE96HYP9JbFWUpJBFO2c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KOK3/EhVPNnuKwaRbni713mZfmgxmXXVmk/Z3nOoXVHU7zwvTYjUyGrYN8ccMkqa6ADMwEIo06mhAdd8UVjh0sMBJIHYugyRsAqcPS2dVMVOJgMI6GHMBfGxsa99UHnqqEooay8HK9SSpKHLqOqah/QCLwYpSVZS5w62CQlf/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTW0caGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EDDC32786;
	Fri, 31 May 2024 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174516;
	bh=7QPWM2N9EG2WUmorU7S5Ra1EE96HYP9JbFWUpJBFO2c=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=YTW0caGNY5ZehpMMh5y6oEmuOdXIEkaVMWA7aiNzdycLl+tW361CxiKrgMVtZoJA9
	 1/MMH6kPmJ4Kpu4jZrhvIX1fKiPtkJt4aCaitXP2F/uJONVdH0MhzRqgi/uotGeSVA
	 byVf/e4VoZhJgT8qooWq52TStMUFZWxw4DRArKtenTktJJhxy0QTFShfmHKB5GujuO
	 WbTSPquUOO0Slpogg1864L8nU1Wnd4l+SOjuhI6q1xIzUnfGaJe1pXOezsEXxcMUpR
	 WQTea0SeluhNSLDVZl5+T8VtXEfLKjj16y10J6WswieVQh7G1yY0i3ShwHx7ZzokCf
	 ZlOqVPIDTRlhA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1AD2C1200068;
	Fri, 31 May 2024 12:55:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 31 May 2024 12:55:15 -0400
X-ME-Sender: <xms:8gBaZmFWQkoI70IWkyzvIBJAodZGPpe02eiXJi-0NEAT-7PVyktylw>
    <xme:8gBaZnUJPD83bdJJkUPSuODFFXj89OGFFMVXh4EhAp8GTDdY3prwFWM02gs9lcU__
    3GYjn8eXsPzw0FLZ7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeelvefgudeiheefledttedthfffgfekudegkeelffdtiedvgfevieet
    teekheffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8gBaZgJ9SwLFx2oe8R4XfFLIdg50A7WLt8KPfXti2GofFHfw49NLJg>
    <xmx:8gBaZgFyLwvt81qJ5t6Xf1E5uzIULL6rXXQzNcZC-I85AW7pJc1BcA>
    <xmx:8gBaZsU00JZicsOkcQb72WpIFmQ4EYubqSFWZeEFvVtFrGh5Mz02Lw>
    <xmx:8gBaZjMSkkL0u_dudy0KFcEA7IqtwmcdA04Zj7YJO3jhGEx2AZVEfA>
    <xmx:8wBaZj0jLQhJwRZkJWDpTF6B_kW0nQ7Dx4GbhyohjBVtsyK0U0x-cFWY>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C8D83B60092; Fri, 31 May 2024 12:55:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d926855-ef1f-4cdc-bccf-2286b012c2eb@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
 <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
 <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com>
Date: Fri, 31 May 2024 18:54:54 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Arnd Bergmann" <arnd@arndb.de>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-alpha@vger.kernel.org,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Marc Zyngier" <maz@kernel.org>,
 linux-kernel@vger.kernel.org, "Michael Cree" <mcree@orcon.net.nz>,
 "Frank Scheiner" <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Content-Type: text/plain

On Fri, May 31, 2024, at 18:32, Linus Torvalds wrote:
> On Fri, 31 May 2024 at 08:48, Arnd Bergmann <arnd@arndb.de> wrote:
>
> and the solution would be to make a __WRITE_ONCE() that then uses
> "sizeof()" to decide at compile-time whether it can just do it as a
> regular write, or whether it needs to do it as a LL/SC loop.

Just to clarify: I did not mean to suggest we actually
apply the patch from my email or anything close to it, this was
meant as a demonstration for instances that are likely broken but
each one would need to be individually documented if we were to
try to fix them, as Maciej asked about what it would take.

My "alpha: drop pre-EV56 support" actually removed two workarounds
for non-BWX alphas, and neither of them even uses WRITE_ONCE,
so these would also have gone unnoticed by any changes we do
to WRITE_ONCE.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/?id=a4184174be36369c3af8d937e165f28a43ef1e02

    Arnd

