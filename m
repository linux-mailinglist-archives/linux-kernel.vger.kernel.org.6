Return-Path: <linux-kernel+bounces-197965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E5B8D714D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58096B22023
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0B154BE0;
	Sat,  1 Jun 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdYeBajI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B754650
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261944; cv=none; b=YnE3/3+wEPVBy/ylleAUmHGDFGKYN9+XW4YsT9pfb/2Mg6EwfhFVR4iZdIE7WQutVurt1gwRdS88Vf+/q7NTjJ5Y6RPwVwoTV1wehNsN7oV8L9v8ifVmYXveeVX1cxm1P+w+Yyl33uGM+zgbx8W9OjWD2EK9s/0PhjSZnU15kYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261944; c=relaxed/simple;
	bh=T5zYUtBae4kUQ0fRfQ2/c7KaEFk98FqdP5UHlTNucFU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oF8vJhFVl5TsRWpr0x+5asX3aJZsoPAyoPAiZbovf8I1IoZ7c+4FNSGmjH2l3icKYM9Nz3l5ZlFlrklySljtdM5ffAbndnDAZOJTAK9J5iHADE+0u0ynICOcia2c83JUmJVggkX9AYAtzjgBrWhVv22OddeKcBD2+5EuREYynCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdYeBajI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC341C116B1;
	Sat,  1 Jun 2024 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717261943;
	bh=T5zYUtBae4kUQ0fRfQ2/c7KaEFk98FqdP5UHlTNucFU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EdYeBajIJQeISjqU/cYLbQvwoLoC/HOWpAxynSUOVlSdfDq8B47DOWMiGsykIumvN
	 NqO4ONKbB/+FdnOEp3IHGN9vYQxnLYPe2JmrOo0rIP1KlTweQsW/ollI4HLyBjkjPY
	 /RR5mrk+Kb2xn8knsYwZDPDdjH7rKHaQJVVsHFurO9Z7CIOe55F0Omc3plv5WRwWAO
	 2mTVTZyeZQ8EmZtVqXUeGsq0tGpsbxPhuXIPUJvEpzEfJVdpXms7k34dG7WMh7GO2Q
	 d5bIBD2KwLCqYC6berfsmikHNaHamePJzNel4v7U++PSewwQOOJJGiLt43yfJSEsav
	 771Kdg5Yc/utw==
Date: Sat, 01 Jun 2024 10:12:22 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
 Marco Patalano <mpatalan@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc2
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wi8Y+T8d8fdyo6KDGfy3Z-Egd=NBfOjzwLuQjo_6yarYw@mail.gmail.com>
References: <202405311350.388C0A398@keescook> <CAHk-=wi8Y+T8d8fdyo6KDGfy3Z-Egd=NBfOjzwLuQjo_6yarYw@mail.gmail.com>
Message-ID: <913416F8-CBC5-4643-B244-898A4445EA79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 1, 2024 8:51:43 AM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Fri, 31 May 2024 at 13:51, Kees Cook <kees@kernel=2Eorg> wrote:
>>
>>   ssh://git@gitolite=2Ekernel=2Eorg/pub/scm/linux/kernel/git/kees/linux=
=2Egit tags/hardening-v6=2E10-rc2
>
>Wait, what?
>
>This is not the key you usually use, and it isn't the one that is in
>the k=2Eorg pgp key repository=2E
>
>The patches look fine, but no, I'm not pulling hardening patches
>without proper signing=2E=2E=2E

Arg=2E Looks like my workflow picked my old key when I switched email addr=
esses=2E I will fix=2E

--=20
Kees Cook

