Return-Path: <linux-kernel+bounces-273573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBA946AD0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 20:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B42281A8D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 18:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECA1B7FD;
	Sat,  3 Aug 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="NdX7huGw"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F481114;
	Sat,  3 Aug 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709426; cv=none; b=l+7AeYnJxJ0p7QtVUQrHqrurGDhTTtzo5j4wCD9XXt7GLkYNLBPSt+XDdc9HCq1n0/04MC3T6+zpDGYfbAn04T8ebycG0u0fjPl5IrOeX0hcUzxG9ytiIOAWiS0AKhJ/NBUkautwrIdIz0GYn+RuSupKk281cAhvM9Jst7ldXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709426; c=relaxed/simple;
	bh=RyYd/wJv7HAaTKW166ExyyEssX+hg0ntaAQl2+n6gWs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Dp6nQuk8IZlwjE+2UeDKF6t7jsA9RU5NWYN756LLrUpWfOVCRbd6616ZIrcIQwvvsgOuVbk0c0BOfM3W/cvcdfKFoFFTMwSt5/5MTbSlhrRA/s0JVHAev3VXLTgOjoRHzE96xNmdJL+8eCL14dKazBQzGtD6AFXRW4mPn+TW1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=NdX7huGw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1722709421; bh=RyYd/wJv7HAaTKW166ExyyEssX+hg0ntaAQl2+n6gWs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NdX7huGwyEIr/01DW1mpqeP3MrG2ag1WuVurg4KD7OPMVU6sysHBJnvC5SyVklOiy
	 T9eZ0SNlKoY6Q4kPkLjoIH5SD5o/0fBavPqUkV9o5miO5IJsL5WhOIk/mKgkgG6cj3
	 RhYrCnwoaY/3yyvfqfa55YShFNnFasD2xkpOLLYk=
Date: Sat, 3 Aug 2024 20:23:39 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <dc079808-ef49-42b6-9147-b043b97dcc86@t-8ch.de>
In-Reply-To: <20240803100318.GG29127@1wt.eu>
References: <20240728-nolibc-constructor-args-v1-1-36d0bf5cd4c0@weissschuh.net> <20240803100318.GG29127@1wt.eu>
Subject: Re: [PATCH] tools/nolibc: pass argc, argv and envp to constructors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <dc079808-ef49-42b6-9147-b043b97dcc86@t-8ch.de>

Aug 3, 2024 12:03:27 Willy Tarreau <w@1wt.eu>:

> On Sun, Jul 28, 2024 at 10:34:11PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> Mirror glibc behavior for compatibility.
>
> Generally speaking I think you should make a bit longer sentences in
> your commit messages, Thomas. One first reason is to think that during
> reviews the reviewer has to scroll up to find the subject for the context
> this sentence applies to. And doing so quickly encourages to give a littl=
e
> bit more background to justify a change. I have a simple principle that
> works reasonably fine for this, which is that a commit subject should
> normally be unique in a project (modulo rare cases, reverts or accidents)
> and that commit message bodies should really always be unique. Here we
> see that it doesn't work ;-)

Complete Ack :-)
I tend to become lazy when I feel to get away with it.
Thanks for calling me out on it.

> An example could be something like this:
>
> =C2=A0 Glibc has been passing argc/argv/envp to constructors since versio=
n XXX.
> =C2=A0 This is particularly convenient, and missing it can significantly
> =C2=A0 complicate some ports to nolibc. Let's do the same since it's an e=
asy
> =C2=A0 change that comes at no cost.
>
> Anyway I agree with the change, I wasn't aware of this support from glibc=
,
> so thank you for enlighting me on this one ;-)

It's meticulously undocumented,
and a very fringe usecase.

I'll use your proposal,=C2=A0 fill it with more background and apply it.


Thomas

