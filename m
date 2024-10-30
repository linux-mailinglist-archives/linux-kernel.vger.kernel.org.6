Return-Path: <linux-kernel+bounces-388879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0269B658D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7511C24094
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817311EE038;
	Wed, 30 Oct 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RIGNjWky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XekJ+6hL"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED1286A8;
	Wed, 30 Oct 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297984; cv=none; b=eznBVpKCxGqLTVMMO91K+YqP/v4/ksDT5I9pcTdWazp1w+n5mx7aQ3dAhnfoV6prw3wQGELS4FvEMXLfRYRDSGqiiX48pb7Dd9IRjxKwiiglfe11LgEfcjOsEuBO88wJ12Ua0kMHNs/y+N1YA1UTSLS89Q8sWjfUldHfPp+uYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297984; c=relaxed/simple;
	bh=C8BVcFvJfPEHk3/ciUv0Px/WqMeMwzNeh8oeM7dwY1E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WcDRWWEl7SjPpQPF6rOZ26V4S525SxBmhmRD1ZlwK7m/2QW9K7M4pJGVjUmHkc84tHSRIZPdOfoRVVYWSliZ7l5Or7XSiW3iwkgvBgN7VgumPUNSn2AzEo0gPBT8sEpFcpsRxpCER+Q7v7n/YP0AfzCAPZTK/3iR7wLmsplZKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RIGNjWky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XekJ+6hL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 69B2F1380217;
	Wed, 30 Oct 2024 10:19:40 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 10:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730297980;
	 x=1730384380; bh=9aFMkFyHc1g8801Ui3tLOJ96EI+25C3rfkWPa4gaTHw=; b=
	RIGNjWkys/Ju8X2WwxwQFzpnJocvElvkJ3y9GqtCMRut9t7JnQfNTYQtxnwg2b24
	21xkgJ+gqlntn2kdLsYlNTM78f6XTiu7oXA0TJs+berVYUqqOh2KzBsiz7slFhzy
	u7rBPHH+XXUkHZxYWnt1qtwv8NyclVwSwMKDUDoIK3mXaJYy831thDxBjd46vi+w
	tOoCaf91dS2HHu1NGLc0opDtmyLCSPXLseHCgno//KkR+AYgRv2CHqGaD/UKod46
	z4MYBPaiLp+woEvnqHrlz1SzUkxhsK9697uMaBOpEe3VmZN2UnC+SNM/I2ZmEV0P
	ylD6Ba6MD91zS645EVBZ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730297980; x=
	1730384380; bh=9aFMkFyHc1g8801Ui3tLOJ96EI+25C3rfkWPa4gaTHw=; b=X
	ekJ+6hL+TYqRLyZ5jxmEAOifhmP0wFZLcUsD4jQTSdDMe7iqKVo/huwGjQuJb2EF
	4MUncINt7ZizF5veVXGvUjYk5THg26LV/L8tgHCJiJkOIwlObeQoL+taq8Ft9MKy
	PzSTq/RGLzYmzAUuFncS8bkApbx0MD4cSSBeWHtkMQqaxUoLDGjv2OOpjSFWy/TO
	wv9dG96ww2j0h2VRQ7BePY6GXGr8uqkd/AzbgQgLhqHSkPsxKJJce2Lx9m7wS6Iz
	yl0r3oZyYiAkQsL/6Tlxrq5DIRSaJVzwUel3o/bFWtzKO4IiOx5zb2vKlRqIXd2e
	ZWqaJbXmQGPmJmNHsIz4w==
X-ME-Sender: <xms:e0AiZzAnBGAy-gdmshuezrYSK9_CqLBnlMqyAeSoRBOrcusPStpMuQ>
    <xme:e0AiZ5jrL6U7Z-5_LT7uri16FtqtSo-NFjfvZKqP_ZUq-J6uLtujzcepkyutIoUuc
    Xw7t0tsc0V_fsBtZCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepkedvuefhiedtueeijeevtdeiieejfeelvefffeel
    keeiteejffdvkefgteeuhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhgrvhgvvghnkhhrihhs
    hhhnrgdrtghhrghtrhgrughhihesrghmugdrtghomhdprhgtphhtthhopehsuhhmrgdrhh
    gvghguvgesrghmugdrtghomhdprhgtphhtthhopegtrghrlhhoshdrsghilhgsrghordho
    shguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdgu
    vg
X-ME-Proxy: <xmx:e0AiZ-k3klqoJ8z1-7jWR5SF69aZLAoCBlt5uVpuvzlpcZFrUUxO8A>
    <xmx:e0AiZ1yQLMzffWyXmFiWpqIWU02X4pEWbR4THj38Rvze_5eckkDW3A>
    <xmx:e0AiZ4TjvxHaWwskLkw-hTsU39evJz5mMISaAEqRNAYGEecT76zBzw>
    <xmx:e0AiZ4YTs6u4fWO55R019DxgwzNM_D6w2LL_XICbQvLEePzcIuNfSQ>
    <xmx:fEAiZ1i-F2M7fzvqY_q9PBodDvabRHURdBsCwgipbjRhIMhznbsM6vny>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A5B622220071; Wed, 30 Oct 2024 10:19:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 14:19:18 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Suma Hegde" <suma.hegde@amd.com>
Cc: "Naveen Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Carlos Bilbao" <carlos.bilbao.osdev@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <a3b3aa23-3238-4117-b931-7194fc1ccc34@app.fastmail.com>
In-Reply-To: <5bee1158-537f-4fb2-bde3-e86b5dce3fee@redhat.com>
References: <20241028163553.2452486-1-arnd@kernel.org>
 <8aa437c2-43be-4ecf-88c4-f733b1e7f243@linux.intel.com>
 <5bee1158-537f-4fb2-bde3-e86b5dce3fee@redhat.com>
Subject: Re: [PATCH] platform/x86/amd/hsmp: mark hsmp_msg_desc_table[] as maybe_unused
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024, at 14:16, Hans de Goede wrote:
> On 29-Oct-24 1:55 PM, Ilpo J=C3=A4rvinen wrote:
>> On Mon, 28 Oct 2024, Arnd Bergmann wrote:
>>=20
>> It seems that the main goal why it was put into UAPI was "to give the=
 user=20
>> some reference about proper num_args and response_size for each messa=
ge":
>>=20
>> https://lore.kernel.org/all/CAPhsuW5V0BJT+YSwv1U=3DhRG0k9zBWXeRd=3DE1=
n4U5hvcnwEV3mQ@mail.gmail.com/
>>=20
>> Are we actually expecting userspace to benefit from this in C form?
>> Suma? Hans?
>
> I can see how having this available in the uapi header as documentation
> of sorts is somewhat useful.
>
> OTOH I do agree that this array should probably not be used by userspa=
ce.
>
> And there is only 1 way to find out if it is actually used (which I do=
 not
> expect) and that is to just drop it and find out (and to be willing to
> revert the change if it breaks things).
>
> So we can either move the array in its entirety to the c-code consumin=
g it,
> which I think would be best; or we can go with Arnd's patch + add
>
> #ifdef __KERNEL__=20
>
> around the array so that it is there for people reading the header, but
> it is no longer exposed as uapi.
>

I don't think that would work, because the 'make headers_install'
step just removes the contents of #ifdef __KERNEL__, in this case
you just end up with a uapi header that doesn't have the array.

      Arnd

