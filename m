Return-Path: <linux-kernel+bounces-169642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4128BCBA2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEFC1F231EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9814265A;
	Mon,  6 May 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eJffxJSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFwo2u3F"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73F4205F;
	Mon,  6 May 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990020; cv=none; b=Y8rWf/4khOgVmAWnX9nVylZapLVNCBUbh+uZKVXLZRFDCbnE9EO6jboInlLTOWWyXyz26a3SWYeDcrvAJaoNnMeNzRlpnSf11I+00CuS609pAQyv2f/g4sA9jgKfvO/bAjX/1A+5HAcJ0aN+5xM703Ttyx8MWu1fwn0M7TMASzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990020; c=relaxed/simple;
	bh=paBKvWvbZg049IMoiC8LBBn2Tz7y+24lxrYze19WHAA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EcC/JLE9coa5mwcvqTPu3JpVn5EH9fV5767Vbw5gVSe7RPbcTceMBUFw78hcPg+zH1s0c6z8UgiRIL0hfB8kemJG/uLILFiAK9zzijqmiXYWcVZ3QWGyq/64bsX9LYtUEzDCa1E7OphVBkjsSg/lwcYX+kfbUSKefFQVBG/oktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eJffxJSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFwo2u3F; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 3E0631C000A2;
	Mon,  6 May 2024 06:06:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 06 May 2024 06:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714990016; x=1715076416; bh=CqaP0eVcAT
	gfq833M9wyW0TYYGCo8i6NE+7w7BSwBro=; b=eJffxJSdux1q9ArYzqjsFZ1WLK
	fOph3jm+oxbyyiFAl64ebpo/GrZxTfarMGt5gXrGaMdKoNYoQCIUsImbutbbjnZ7
	eoCpCBa7OgkVqtP0LESx4Plt149zs/eX55ZkeEwjwDUHrfuOm0mkXxQ5xRGfc7DN
	BtzMuBYfeUaTW2+u9LTXORMWfaW8tvbcN3DKlWqcLuq/GDB96QVlL23k5SDjulEc
	TqR0yiLadi/eduUGWi/BeNnC+V1sVjd5jXZ0mgDWYrfkZNqKeRkilfM93OIlhZV3
	o/4VO/Tm0oZZbHhYyVO6AkUzIqIDHlMgIpJWkdSsKxH9umYKBg/pQN3701RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714990016; x=1715076416; bh=CqaP0eVcATgfq833M9wyW0TYYGCo
	8i6NE+7w7BSwBro=; b=cFwo2u3FMB23EwmYL73Cfg5sIA9x7bTtZrGxm3oMKdZy
	mw9ZrViC7udWRe16o+r2AM9J+XFR2qgDBGOUQXPGVFy0VRX2qpsWw8wfzpR4B+BZ
	EIidrvy2jf0k5CzIHlf35/eVfi7spC+LW0B1fzrIv0qP0MrASWg7ooDiNoX9icUz
	2KqIZrd4zNDtG235USGrFkLG6zEIEyYkvMf1rUosWZB4ZlU3T4TqhgK+KpKz1YAD
	4daqE/WbdxK2g+/zFEwK089yFv8cywaDpXjSfFiLAj3MMPzPCa6kmjavL1nEqGwy
	UqoNK2wrV3wKHOa1PAdxszDK1nxxX0C6svBz3VhDLg==
X-ME-Sender: <xms:v6s4ZsGdgSs2eBMBlRkZK3ZEBELsCquFsyOH0-3_qkahZSw3ovkuSw>
    <xme:v6s4ZlWtzQ3fp2zgSjMAZAh9noQp6dVfq89bQrLVHiEwgylzPQ7FxLGgQf14qvgoe
    k9TsaBmyZw1NwWFADk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:v6s4ZmKDCSLW6yb7iizeln0mhaYIdEnMBG64DcRQXEfgZvSZOnqfFg>
    <xmx:v6s4ZuFoUmkHedJkyd9Ykqd26Px_SneJ2yVPG3FPxV24dRs897xB0w>
    <xmx:v6s4ZiWSAOyDRUdA04l8jVkCjuUnYEbydPSfR2QtIX3Xf7-r6BdoeQ>
    <xmx:v6s4ZhMUjlBaUsyi-elhX6ZJ6w5IjyN0mZuLizoyo9qUQZovZ-_siA>
    <xmx:wKs4ZuSDx2XdjLFZsQazzxwbMyhFRwqQjej1o5XtyaMqIRCdONakvmen>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 88251B6008D; Mon,  6 May 2024 06:06:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-437-gcad818a2a-fm-20240502.001-gcad818a2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae56021f-1e85-4dd9-a4ca-5a8773d51ea1@app.fastmail.com>
In-Reply-To: <31f1bbfb-733c-4027-834c-98f155562941@linaro.org>
References: <20240503081125.67990-1-arnd@kernel.org>
 <20240503081125.67990-15-arnd@kernel.org>
 <31f1bbfb-733c-4027-834c-98f155562941@linaro.org>
Date: Mon, 06 May 2024 12:06:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-alpha@vger.kernel.org
Cc: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Marc Zyngier" <maz@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] alpha: drop pre-EV56 support
Content-Type: text/plain

On Sat, May 4, 2024, at 17:00, Richard Henderson wrote:
> On 5/3/24 01:11, Arnd Bergmann wrote:
>>   
>> -/* Flush just one page in the current TLB set.  We need to be very
>> -   careful about the icache here, there is no way to invalidate a
>> -   specific icache page.  */
>> -
>> -__EXTERN_INLINE void
>> -ev4_flush_tlb_current_page(struct mm_struct * mm,
>> -			   struct vm_area_struct *vma,
>> -			   unsigned long addr)
>> -{
>> -	int tbi_flag = 2;
>> -	if (vma->vm_flags & VM_EXEC) {
>> -		__load_new_mm_context(mm);
>> -		tbi_flag = 3;
>> -	}
>> -	tbi(tbi_flag, addr);
>> -}
>> -
>>   __EXTERN_INLINE void
>>   ev5_flush_tlb_current_page(struct mm_struct * mm,
>>   			   struct vm_area_struct *vma,
>
> The comment being removed applied to both functions and still applies to 
> ev5_flush_tlb_current_page.  (Thus __load_new_mm_context instead of a tbi.)

Fixed now, thanks for taking a look!

     Arnd

