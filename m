Return-Path: <linux-kernel+bounces-524694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA83A3E5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9E1890CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF22641F5;
	Thu, 20 Feb 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="H9yy1T1p"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6AC1E9B29;
	Thu, 20 Feb 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083661; cv=none; b=cnepvhh19akt1E9SRkI+ieapIcZ5n4oYJX1l/QKozCmMa/PuhjeI1ZCIw9WnmGwik4f17zNuP1zkYf/N/xtWDN5RAysAosKLO4GeySad/jRAtEQ0NkYS3R1gzcUmhEJogTMw/oDekzLTdmKep7dAvvPkyZXKyvatatjZDYYZHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083661; c=relaxed/simple;
	bh=PJCMa8esoX4W/csdW3slZ1rUS3bEqx3KRq3GD9X0zt8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qkOQfBcENdt/TMACmF8HKkkGeGXHoz2yv0fA4GXwnwDvxS+kXkGip5NZWUoaxbuWRIVH3j5hCapFc/Z6BnHXUcqFwdihFs7JQG+nhzuEWBOX2LQB3+oxpwUuQu8sDqOLEOsUsr9fTFRRxVrjUXHACmDDEVV9d/xRyiNy50s3m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=H9yy1T1p; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51KKY6gT2365356
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Feb 2025 12:34:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51KKY6gT2365356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740083647;
	bh=A7JEGdkOq24itmNx5uIDCiMePe/00fDHMbG1zsvPgk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H9yy1T1pR8WT5CqSVYBTSeNQ9Rpk3W4Bf66RIIQeZNqLAXjqHFCymfgB2tayLVP7F
	 sx62fzfZC2YPCMyvtOeQSaVDrjLTiYxE+dRfo9P9d9WzdMvP1i2BAx3FtPkF3WK8ID
	 9WlpJsgi8iz/7UTNkqZOXXjsiwHiya8/1luv7zHj30VZhgnOTFDe5eIgmLU+1eA3Dm
	 d9QFitxI1W+8fhqYqHR5FNNcU2NHAqZJ65SOPRhfKkeyAEEGuIeTWE/FmM9pFmVGVC
	 AjAFHtCgAe82a9Rk1gytpMNRVoBBrC5Aojjs11PHFfHop+tAVOYGtDuaT5ONka0naT
	 rBmPL1D0r+fJw==
Date: Thu, 20 Feb 2025 12:34:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jan Engelhardt <ej@inai.de>
CC: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr> <2025022052-ferment-vice-a30b@gregkh> <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com> <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
Message-ID: <F7E6DA3E-9B5C-4FDF-B7E7-0F1F02C5E74D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 20, 2025 7:17:07 AM PST, Jan Engelhardt <ej@inai=2Ede> wrote:
>
>On Thursday 2025-02-20 14:23, H=2E Peter Anvin wrote:
>>
>>People writing C seem to have a real aversion for using structures
>>as values (arguments, return values or assignments) even though that
>>has been valid since at least C90 and can genuinely produce better
>>code in some cases=2E
>
>The aversion stems from compilers producing "worse" ASM to this
>date, as in this case for example:
>
>```c
>#include <sys/stat=2Eh>
>extern struct stat fff();
>struct stat __attribute__((noinline)) fff()
>{
>        struct stat sb =3D {};
>        stat("=2E", &sb);
>        return sb;
>}
>```
>
>Build as C++ and C and compare=2E
>
>$ g++-15 -std=3Dc++23 -O2 -x c++ -c x=2Ec && objdump -Mintel -d x=2Eo
>$ gcc-15 -std=3Dc23 -O2 -c x=2Ec && objdump -Mintel -d x=2Eo
>
>Returning aggregates in C++ is often implemented with a secret extra
>pointer argument passed to the function=2E The C backend does not
>perform that kind of transformation automatically=2E I surmise ABI reason=
s=2E

The ABI is exactly the same for C and C++ in that case (hidden pointer), s=
o that would be a code quality bug=2E=20

But I expect that that is a classic case of "no one is using it, so no one=
 is optimizing it, so no one is using it=2E" =2E=2E=2E and so it has been s=
tuck for 35 years=2E=20

But as Linus pointed out, even the C backend does quite well if the aggreg=
ate fits in two registers; pretty much every ABI I have seen pass two-machi=
ne-word return values in registers (even the ones that pass arguments on th=
e stack=2E)

