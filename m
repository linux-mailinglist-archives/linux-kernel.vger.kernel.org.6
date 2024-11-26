Return-Path: <linux-kernel+bounces-421873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B009D9144
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A02E16A524
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4672E3FBA7;
	Tue, 26 Nov 2024 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSE55lmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C37E9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597801; cv=none; b=dAlvD/SbNPxPuDOmCb3whMWxBKUpzFyzI/GE4ub09FmZ4B3p0CoDRUl3xY7Y25WMSAjJs5QNWTv0nKubMfqsh1aNRGkMXBE3x6mKj+rcu756BtwX3Zf161qk1DfH8zmdaqg3ZRm+Rne68FWA2eAmklP2l4dLDxPrwcQj+3VNijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597801; c=relaxed/simple;
	bh=/5BnmZT731b5jrEW0r7GCrYc3NQgyT1hrlePeQWwRrc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WyfdXpY1UoD0tHfs6sK2zSSw64atu5RkXJcpQ/qcNrDOXCTi64pWgBveQfG0jdtDOmpT1R4P/MXlxUI91IZJx7NFg++t7XMGI56oyec/j9Tg49yzL6jnrwyrnkUh+hFAtO2kHjPbJ4bBt63c74GDnkaNPQd+wiDTDDs3eyP3VnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSE55lmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B66C4CECF;
	Tue, 26 Nov 2024 05:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732597801;
	bh=/5BnmZT731b5jrEW0r7GCrYc3NQgyT1hrlePeQWwRrc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PSE55lmZAgO4Zi1QsS690y79Qcaek0aSul9l5iTYCRSA20CB4+RYQJWNTB47IEgUg
	 vSXhjo5Ox9iQH1v8RN+yuz9zYyAphKXXZkN9wgNHEIpzzOLIXSGA465YHT/PEX2sz+
	 l8m2Xc8cZcXosuJiSVDbg5PUSloTOPyXP0NZ/TTcCn6YOQV9ATybqt+8IvNgsTqbdC
	 7j+mLfumcy6qi4DpdHnjasrPwX1w9jBUZzFpP2RZeVa9ARKT4ou2u0ETii1b4ikEjZ
	 XsE7lAilIZFi7kjMHN2OdSa8O9ij4GOmoEH7CLBvtopnmT9cjvMDr8qr5loV5YG4KE
	 9WKJOA4p/ODnA==
Date: Tue, 26 Nov 2024 15:09:55 +1000
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>,
 Tycho Andersen <tandersen@netflix.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
Message-ID: <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 26, 2024 9:40:22 AM GMT+10:00, Linus Torvalds <torvalds@linux-=
foundation=2Eorg> wrote:
>On Thu, 21 Nov 2024 at 06:53, Kees Cook <kees@kernel=2Eorg> wrote:
>>
>> Please pull these execve updates for v6=2E13-rc1 (take 2)=2E I've dropp=
ed
>> the argv[0] vs "comm" setting patches=2E We'll work on the better solut=
ion
>> for the next merge window=2E
>
>Yeah, I was pulling this, and then noted that the selftest is now
>documented to be that garbage=2E
>
>So I unpulled again=2E

Okay=2E I'd left it because I figured we'd be tweaking it for the new impl=
ementation, but yeah I can just rework it all then=2E

For the new implementation, do you want to wait a full dev cycle for it to=
 bake in -next or should I send what I proposed based on your and Al's sugg=
estions for this merge window?

-Kees

--=20
Kees Cook
--=20
Kees Cook

