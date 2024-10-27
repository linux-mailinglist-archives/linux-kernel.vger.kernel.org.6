Return-Path: <linux-kernel+bounces-383553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39979B1D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693631F217BF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70313B2B8;
	Sun, 27 Oct 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JAgpitAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRkJV+Ac"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2A2AF05
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730024832; cv=none; b=WdhXejU+d0WhP7Ld1m7lcGh3zNrhQ3s/0scWPVRa5kd6gInuDVxWUelxFrq/UwCBs1WgZ4Xaz13+wArCTjm+Qz6J1kw61y5MQ/iKzT6R1pFJ9b/XyVFUIC+hG2a64IJySuwo6U3uRH58bS34LLibipvmo8PfoE+mkYKZ2+rGBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730024832; c=relaxed/simple;
	bh=+YfQfX+biIkC3dIRAKhcKjMUABjJ+wIqbr4D07JHvN8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EMelV7oXhwbrHVTPgvcEVIHatS8BEDm9HYkLSyMHAuwOlZAnanfQRpqwe99VGthdOuJQP6pbK8Ie2m/z+dsz8jPBggWnHtNXarPuPLizT31oORWmuUyLT4U19d+Cr9dvg0PUtFRUridsZtWjWQW6VK+f5fuIXlN/kYuKFxGCu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=JAgpitAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRkJV+Ac; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9745C1380141;
	Sun, 27 Oct 2024 06:27:08 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sun, 27 Oct 2024 06:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730024828;
	 x=1730111228; bh=zHaHewfVA2Xo4e4QWj1jWr+akaA3IqLCR8I8pry/yFg=; b=
	JAgpitAEQ0kyVyNJVDxyVKpR1ILW9UajvrhoObNHHMBHJzgGxUUERfjI8YofEhUm
	Ohr/5c4abcGHml+jAQPL6/KhnbB9yAn4bI0Q0neFAzFd4wNQvMu/LPzb42VteKMM
	O0tLcjGN03n+vj7SkHqiCyCozhg7b2NNat/qZOmkcxxuEcxK/RDZBtN/++niywYW
	aehmDQ3z380Y+vZ8htQRtfNRGJkhBfz4aZgbaEbd9lRHUPOUzwWhJbTl/3PUhGU3
	4qDz3NI3Z/mPBkAUMeOej/FyX1gzNprvOnl9/MNf22KESYv2frcoUOWwzenj1Re8
	CS177aDQiTCyvGB4P3mfcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730024828; x=
	1730111228; bh=zHaHewfVA2Xo4e4QWj1jWr+akaA3IqLCR8I8pry/yFg=; b=P
	RkJV+AcxCfcJBrTMC9lwXLt8tOytiymObMLUU2B1qMxIbu21GARmw9qJ7W/RoTl+
	fkboyxQsZaQ/yi5WmTfur/jsMS47ee5+os3fnVejZ4vuneF/Zl/zq8GC0SZeu37Y
	47N/OLHZMe5JJqpZwqNtcKOCBVbXgd9NtuDuC6ahGLTJGH0YhRgDSZvKwsadp/yN
	0DEUhF2BCPyGtkCfY8CzXaU4wAO+SGhCUrWdyyCraR2AiYYAMnb07vxvw+t0LjTt
	I+bDPQjf/tEn/2ShVAvkau0MNlyV6br/ChTI8BXiIQzGz/L+FOllUr/epqEaisJV
	+vuWkEeN/Az5qH+DHrgYg==
X-ME-Sender: <xms:fBUeZ1jPJcvTFT6xlOLZLRXuOZO0mibEJMswzaoOa1kAQPc5plRk_A>
    <xme:fBUeZ6B0eDRgD83PYFaUmY4QVCUM_j_IwpCMXw83T54yTGyBCOXZ84gIovRHTSpk9
    zS3XZkJ_SxbETb4yP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepiedthefgfeevgfeljeejgffg
    hfetffefteeghfevleffieehgfffveegueduieevnecuffhomhgrihhnpehthhgvrhgvgh
    hishhtvghrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtg
    hpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkh
    hhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghorhgsvght
    sehlfihnrdhnvghtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fBUeZ1HA8coaXA44Ta-HUeP4qvmI3WWaevAa5PycdCugtmZNOTlrcw>
    <xmx:fBUeZ6QUR2lz9BfbPGtKWtgfCkJXZApIA2A3O6CifL1BaesB_T80tQ>
    <xmx:fBUeZyzmQisK7X_5Kv-Gy1hxHBXnOJcOZlEv1Uv9lEQ0_Z8opdfWgw>
    <xmx:fBUeZw4lvl_JujTHci-V9ukIuZhVGZjhx3hTpWyTyzHn8CGTo_JCew>
    <xmx:fBUeZ9xmaA7kwvo-6dDDFh4OAheHpiGRhzWy1SrvxiGf27vDrukLjIFD>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 310C31C20066; Sun, 27 Oct 2024 06:27:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 10:26:47 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, "Jonathan Corbet" <corbet@lwn.net>
Message-Id: <480c8a05-d73b-4cd8-8470-2ac7b4574cec@app.fastmail.com>
In-Reply-To: <20241027011422.GA3842351@mit.edu>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
 <20241026145640.GA4029861@mit.edu>
 <522bd817-339a-45b0-84c2-2b1a4a87980a@app.fastmail.com>
 <20241027011422.GA3842351@mit.edu>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8827=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8A=
=E5=8D=881:14=EF=BC=8CTheodore Ts'o=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Oct 26, 2024 at 05:33:16PM +0100, Jiaxun Yang wrote:
>> That being said, I'll try to improve the documentation on these things
>> based on my observations. My background perhaps makes me particularly
>> sensitive to some ambiguous language, especially where "constructive
>> ambiguity" might be involved. Recent events make me started to look
>> into those aspects in border community.
>
> Well, make no mistake, there *is* a lot of ambiguity, because we don't
> really have a centralized governance structure other than Linus has
> the benvelent dictator.  The general philosophy is to have just as
> much structure as necessary, but no more.  We do need to have a legal
> organization to sign contracts with hotels, caterers, etc., for the
> purposes of organizing conferences.  That is one of the roles of the
> Linux Foundation.  But just because the Linux Foundation organizes
> conferences, and accepts corporate donations, and pays Linus's salary,
> *doesn't* mean that they get to dictate to Linus what he does, or
> anything about what code does or doesn't get accepted into the Linux
> kernel.  As Jim Zemlin, the Executive Director of the Linux Foundation
> has been known to have said, he works for Linus, and not the other way
> around.

Thanks Theodore for making all those comments.

I perfectly understand why we don't have any "binding rules". However, I
see the problem from a different perspective.

As someone who's a bit of a Linux advocate in real life, the recent even=
ts
have led to quite a few questions coming my way from outsiders: things l=
ike,
"What happens if someone uses inappropriate language in the Linux commun=
ity?"
"How do you make sure no one slips in a backdoor in the same manner?" and
"How do you prevent security issues from being swept under the rug?"

I tried to answer by referencing kernel documents, but honestly, I found=
 a lot
of ambiguity, some of it even felt like it was left vague on purpose.

So my answer was always "Oh I trust Linus and other folks out there, the=
y are
all decent people." and point them to some stories like Linus vs NSA [1].
While I believe this is the real answer to those questions, I found this
is not really convincing to outsiders. It's easy for people to judge our
leadership based on one-hot behaviour because they didn't experience the
process where our mutual trust was built.

That got me wondering, "What if we wrote down some of these unspoken stu=
ff?",
but found myself not really qualified to make those documentations chang=
es.
I reached some kernel maintainer personal friends and found we are at a =
similar
position, thus the post.

Maybe I should rephrase my original post to sound less forceful. My inte=
nsion was
never "changing the system" but to improve the transparency so people (o=
utsiders
and maybe some community members) can gain more confidence to Linux.

Perhaps we are far beyond the stage that attracting users based on ideol=
ogy
is necessary to spend people's bandwidth .... I don't know... I'm very l=
ost
recent days...

>
> This is not the only way to organize an open source project, of
> course.  For example, the Rust community has a lot more structure
> process.  I will note that this has not reduced the amount of
> organizational drama and contrversy.  In fact, some might argue that
> their governance structures may have caused some of the more recent
> drama that lead to some people stepping down from official leadership
> roles....
>
> Or you can take a look at some of the BSD projects, which early on had
> a lot of drama and some of the BSD forks based on who was officiallty
> part of the core team, and who wasn't (or who was thrown off of the
> core team).  It's perhaps because of that drama in the early 90's that
> some of us who were around during that era rather consciously rejected
> the formation of anything like the BSD formal core team model, because
> we saw the dysfunction that could result from it.
>
> There are limits to the informal model, of course.  One of the ways
> that we have tried to make it scale is that there is great value in
> making sure that the kernel developers have face time with each other.
> It's one of the reasons why I organized the Linux Kernel Summit, which
> later morphed into the Maintainer's Summit.  It's why there are many
> people who spend a huge amount of time organizing the Linux Plumbers
> Conference and other workshops, whether it's the Linux Security
> Symposium, or the Linux Storage, File Systems, and MM workshop, or
> Netconf.  The ability for us to see each other face to face, and break
> bread together, makes the human relationships real in a way that
> avoids e-mail conversations alone can turning into flame wars.
>
> More recently, some subsystem teams have started regular video chats.
> They aren't a substitute for in-person meetings, but they still are
> valuable in terms of having that higher bandwidth conversation where
> the non-verbal cues can humanize the personal connection.
>

I'm a bit too young to know the old BSD stories first-hand, but I've seen
plenty of drama in other projects and have read The Cathedral and the Ba=
zaar
more times than I can count. Maybe it's not my place to comment, but I h=
ave
to say, our current model seems to be working well for its purpose.

From my experience at a few Kernel events, I've also found that a bit of=
 beer
often serves as the perfect development lubricant :-)

> Of course, like all things, there are tradeoff and limitations.
> Attendance at in-person meetings can be hampered by real-world
> considerations such as the cost of travel, or the need to get travel
> visas, or for people for whom English is not their primary language,
> they might be able to use Google Translate for e-mail, but that
> doesn't work that well for in-person meetings or video conferences.
> Some of these can be mitigated; the Linux Foundation has a travel
> scholarship fund for people who can't get corporate sponsorship for
> their travel, and many conferences now have a hybrid option for people
> who can't attend in person for whatever reason.  But the language
> barrier can still be an issue for some.  Maybe someday we will have
> something like Star Trek's universal translator...

As a non-native speaker living in an English-speaking country, I want to
say that the kernel community is one of the most inclusive spaces I've
encountered. People here are remarkably patient with non-native speakers,
far more so than average people I met in my life. When misunderstandings
arise due to language or cultural differences, everyone makes a genuine
effort to reach a mutual understanding. I truly appreciate everyone's
open-mindedness here.

I really hope recent events don't signal a turning point for this inclus=
ive
culture, though I'm starting to notice some worrying signs.

>
> The bottom line, though, that any organization is made up of *people*,
> and so there is no substitute for personal relationships and trust.
> If you don't have that, I doubt any amount of organizational structure
> can save you, and in fact, to the extent that some people might try to
> game the formal rules/structure, it might actually make things worse.

Well said, I believe none of us is looking for bureaucratic here. Even
if there are formal rules being setted, it's still people doing judgemen=
ts.
That's why I believe it's always important to know the people behind thi=
ngs.

People Makes /* Glasgow */ Linux!

>
> Cheers,
>
> 					- Ted

Thanks

[1]: https://www.theregister.com/2013/09/19/linux_backdoor_intrigue/
--=20
- Jiaxun

