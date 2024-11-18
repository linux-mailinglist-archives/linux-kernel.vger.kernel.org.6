Return-Path: <linux-kernel+bounces-412586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019759D0B03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AE6282169
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B110155389;
	Mon, 18 Nov 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vWEw68TX"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C841C71
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918956; cv=none; b=LQBN6cSizMtVKZi515NTNsREXvvDSojNjFqCaP6mv018UTIfs/z6QlbL+5fcqnEp87s3sxa6FRxmEx0xmW09ITK+jyJ1bfPZHv5X4/39giqw+zFYFqNJ/h4xH4LLewch6oJzBbQkkhTQvgEu4pUNjkWBvpxqaKlyphVcXAykFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918956; c=relaxed/simple;
	bh=JIcoWFlbZOkqRmXq4oMrLnogzoIBJmoIamDPFloRlUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwED6wQPJxsX5yML2gP/np5piK0Xl+Yr2DQBH4uxbkGw+B4zkq4W+LUd9mmMpsFkxiKvgqCuwYn4qBS4iOOEo6gxHssC8kkSbMJD1rn2ZuRxlRGyibUcysPnXWk7+upd40BRoHMQqiUIKCGiVZe0gEATEnmTrBwtVaIebZoI+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vWEw68TX; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from graphene.canonical.com (1.general.amurray.uk.vpn [10.172.193.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3863A40911;
	Mon, 18 Nov 2024 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731918945;
	bh=hFLtNZC8vP+NEJtmisEsyjGNuVTssiQ5ORg9s4G8Os8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=vWEw68TXoKg2l8Is9qDytQqwcwQDzAKHc0YuVKAqM4tTSmpY4U7P8a3mMnEaJHxeP
	 VF+WgSoE2tlyXVfXUrTPLqKXtxCRu9tB1aFKRMchbmyz5Zo/IbbUISs08hbaqfqqd5
	 ivtCIVvXBI6dK89G8VfxPaxWRQb3PQicA4lWe62mH+0/JljWiNmYXy/CIAGibiENsP
	 dip31+WxOrFBHWvju2VRRmTfAd54hgNNhPi3cVYMV/Y3YxLJshb3bzvD9Herk41uYo
	 pkDliTHVPXZxDutCxYpGMSWE5R2TP0PYijg2QaVWk9K8JcmlZcHli7ZKAzEnv4UgzZ
	 85KruhzDowM1g==
From: Alex Murray <alex.murray@canonical.com>
To: Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
In-Reply-To: <844f58da-638f-4a91-88e7-f66f7fcefe51@intel.com>
References: <87v7wtvty0.fsf@canonical.com>
 <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
 <87iksrhkv8.fsf@canonical.com>
 <7fc07eff-b4a1-4f8d-a9de-dba057d5c9c6@intel.com>
 <87h68avg81.fsf@canonical.com>
 <844f58da-638f-4a91-88e7-f66f7fcefe51@intel.com>
Date: Mon, 18 Nov 2024 19:05:36 +1030
Message-ID: <87serpgcrr.fsf@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 2024-11-13 at 16:37:31 -0800, Dave Hansen wrote:
> On 11/13/24 15:58, Alex Murray wrote:
> ...
>> The only other data point then to mention is that all the major distros
>> (Debian[1], Ubuntu[2] and Fedora[3]) are still only shipping the previous
>> security update release (20240910) in their stable releases - *not* the
>> more recent release with the functional updates in 20241029 - in which
>> case anyone running a current stable release would then show as being
>> "vulnerable". I can't speak for the other distros, but for Ubuntu we
>> generally only ship things which are called out as specific security
>> fixes in our security updates *and* we generally prioritise security
>> updates over bug fixes (which these 'functional' updates appear be
>> rather than fixing actual exploitable security issues).
>
> That's a very important data point. Thanks for that.
>
> Like I said in the original changelog, I'm open to relaxing things to
> define old to allow folks to be a release or two behind. But I'd want to
> hear a lot more about _why_ the distros lag. I'd probably also have some
> chats to see what other folks at Intel think about it.

Again, I can't speak for other distros but for Ubuntu see my comment
above re prioritising security vs functional updates.

>
> So what would you propose the rules be?  Are you suggesting that we go
> through the microcode changelogs for each CPU for each release and only
> update the "old" revisions for security issues?  If there were only
> functional issues fixed for, say, 2 years, on a CPU would the "old"
> version get updated?

For calling out old microcode as a vulnerability, yes I would prefer
that only releases which your colleagues state as fixing security issues
get included. However, for the tainted case, anything older than the
current release would make sense. In which case you would have to
maintain two different revision IDs per MCU - one which is the latest,
and the other which is the latest with a security fix for a given
platform. From my experience though it is a more rare occasion that a
new upstream microcode release does not contain some security fixes. So
perhaps this distinction will be mostly irrelevant in practice assuming
most all MCU releases contain a fix for some security issue.

>
>>> So I'm leaning toward setting:
>>>
>>> 	TAINT_CPU_OUT_OF_SPEC
>>> plus
>>> 	X86_BUG_OLD_MICROCODE
>>>
>>> and calling it a day.
>> 
>> Does this mean you are thinking of dropping the userspace entry in the
>> cpu vulnerablities sysfs tree? 
>
> No, I plan to keep X86_BUG_OLD_MICROCODE and the corresponding sysfs entry.
>
>> If so then I am not so concerned, since my primary concern is having
>> something which looks scary to users/sysadmins ("your CPU has an
>> unpatched vulnerablity") which they can't do anything about since
>> their distribution has a different definition of what counts as a
>> security update compared to the upstream kernel maintainers. If the
>> sysfs entry is dropped then this is not so visible to end-users and
>> hence there is less panic.
>
> Right, we don't want to unnecessarily scare anyone.
>
> But if a distro is being too slow in getting microcode out, then it
> would be good to inform users about known functional or security gaps
> they're exposed to.
>
> That's the thing we need to focus on.  Not: "Can users do anything about
> it?" Rather: "What's best for the users?"

Yep I agree, end-users should always be the primary concern especially
for new user visible things like new entries in the vulnerabilities
sysfs tree. Also I am not averse to calling out the situation of running
an out-of-date microcode *which has known security issues* as a
vulnerability, I think providing more data to users to help them make
the best assessment of any given risk is always a good thing, but we
just need to be mindful to do it in a way that is hopefully actionable
as well.

