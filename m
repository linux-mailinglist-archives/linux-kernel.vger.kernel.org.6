Return-Path: <linux-kernel+bounces-288889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BCD954013
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5551F23871
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F76A8C1;
	Fri, 16 Aug 2024 03:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOWsM6jQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6EC3EA64
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779470; cv=none; b=q3YWX/Qj/rsU8DYjnBCLDGI8RKCZYJKuQW7ilbSD4B+y12f6q1Wv4yn+AM1CpbxZDELHxoCTUBQJoF2WhPw3+fxk+SKjQBSLNgvJuWGgTv6wjtsvw4WpInq+Poe0tqvaFeNG6MSMHAW81lLy6iZbcGPnJ7RIaYyY52UzlLEttZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779470; c=relaxed/simple;
	bh=a219PwHol45G0lJlCATQiIBvrD5f4J7PpQXIhmEIhTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TpKQYtr8ARoiCBF4yCNxOCMDAhT/YZr5EZtw7V53pkTNSr3+MfySJu0n5RvymRMQxnthsAh5OShrc0cX9+9D2KVRo+KiXAUEhLB+oqGhHbPHdX96HqLcEF50FioWJXBCYKXpSeExcwZYkGP9VarNYWYV9yAdLvr3Wl7xvkmp1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOWsM6jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8B4C32782;
	Fri, 16 Aug 2024 03:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723779469;
	bh=a219PwHol45G0lJlCATQiIBvrD5f4J7PpQXIhmEIhTY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XOWsM6jQ2S1zBao3InAo9g5dcnmkL2au6PPKYdLR1C8YuyeILkIoMMYh36KtIVJNF
	 TS2/XTXEJ5aAZyb5Oh6q0m44CbozDaTL7pDU+h7lttzO7rQIa7jh04GWD+yVUdbdTA
	 onRc67hZ05Wp0C5CnN5on9D5xWL4vu1efC0lyA/744iPzqOR9+afPIlvNJCasBaCfb
	 fW48n456YeyZBd/mbx8CF9TS4v9xD3tKCJ1adTB/ZexVF/SclwbcxelDrN1tizvK27
	 pMJqTYkWnY6XesBw5P7Z+U2tauNo9CnoCyTJRahI7gLGAforo4rlS9fj2jtkSu/NiB
	 IS7EaCyf+GEXQ==
Date: Thu, 15 Aug 2024 20:36:49 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Ivan Orlov <ivan.orlov0322@gmail.com>
CC: davidgow@google.com, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 erhard_f@mailbox.org
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
User-Agent: K-9 Mail for Android
In-Reply-To: <20240815160148.be83228a7804c6389393429a@linux-foundation.org>
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com> <20240815160148.be83228a7804c6389393429a@linux-foundation.org>
Message-ID: <32F8F341-56C1-4E2A-9227-9909980A153C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 15, 2024 4:01:48 PM PDT, Andrew Morton <akpm@linux-foundation=2E=
org> wrote:
>On Thu, 15 Aug 2024 01:04:31 +0100 Ivan Orlov <ivan=2Eorlov0322@gmail=2Ec=
om> wrote:
>
>> The 'device_name' array doesn't exist out of the
>> 'overflow_allocation_test' function scope=2E However, it is being used =
as
>> a driver name when calling 'kunit_driver_create' from
>> 'kunit_device_register'=2E It produces the kernel panic with KASAN
>> enabled=2E
>>=20
>> Since this variable is used in one place only, remove it and pass the
>> device name into kunit_device_register directly as an ascii string=2E
>
>Fixes: ca90800a91ba ("test_overflow: Add memory allocation overflow tests=
")
>Cc: <stable@vger=2Ekernel=2Eorg>
>
>yes?
>
>
>I'll grab it now, but perhaps Kees will handle this=2E

I already grabbed it:
https://lore=2Ekernel=2Eorg/lkml/172373928009=2E559695=2E85287674272664080=
69=2Eb4-ty@kernel=2Eorg/

But I'll update the tags=2E Thanks!

--=20
Kees Cook

