Return-Path: <linux-kernel+bounces-563103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F4A63705
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C6F16AD6D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2081C84B1;
	Sun, 16 Mar 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v7sA/OEH"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468F4A06
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742150113; cv=none; b=TZ3kUR1NvRzCtHt5y8DLnk3TnBT5j+Ox70rQgjJmSvTbw3sW9EaDRa5fHeZ1zxVXyQApwBsHwUWaSGhC19roq1Eof8EuERHHbgkZhIYBqBchT2pXrX4JYOoM9u8dZdRkKLqTcFDXdctYTL4aaPdgDWDVtXWI7XrEn2wJPO7Sf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742150113; c=relaxed/simple;
	bh=eAi7fRPx4KnW9fG3hxAcyQFYKAlUU7wvRhzfJ/0wrhU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XGkCdYpnvPW4z0Q3pn1YN842CEHQoZQpycpAljsVluZXsnDvSfCe1YIaTveoonp00ILw8sKTKFsMORwxOuEHoFb8PbVFYhURNMJBm8ad8/CVxK+l51muVYpBL7Thl6qbZ31mHRSieYYdCKpCTvWIs/0nISUuB67nxbHiQ8us8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=v7sA/OEH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52GIYeGR191287
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 16 Mar 2025 11:34:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52GIYeGR191287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742150081;
	bh=eAi7fRPx4KnW9fG3hxAcyQFYKAlUU7wvRhzfJ/0wrhU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=v7sA/OEHxlE5AC1PqMXboRdVYSiNq478ZZeJwKnv4xeEUmVr6tqE2PuuhuMlgRGLQ
	 S83DRTVZGQ9rbemanOaAQOdYES82tdY0NeAqy1meeRS88cXGB8VarXf6Q1D0A8iF3f
	 RJQLV+Tqgi25dXti7lWgrLUkaZiQCtZNTnC4TmLXLL8iKspFoD1k7XLFEngJIOznJK
	 b+k5xpUcCWw6+odq0foAdSc+gsSddRKZgH5ZM3XqTr4SDJa+GmYcdxlShWF2AD3bT+
	 c1Ly2+mpbsAOe4abQZeVwEaoUn+iWiC1H65ybUNVEGdKjCLEDGOt2FC49UkP5Tjen6
	 2rff8nJly7GpQ==
Date: Sun, 16 Mar 2025 11:34:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
CC: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/asm: Use alternative_input() in amd_clear_divider()
User-Agent: K-9 Mail for Android
In-Reply-To: <20250315213655.GFZ9Xy986YQZCeK4iX@fat_crate.local>
References: <20250314081453.565859-1-ubizjak@gmail.com> <20250314112018.GAZ9QQ8hPXt2Mk22cG@fat_crate.local> <Z9XxNbdLCZFiK1NG@gmail.com> <20250315213655.GFZ9Xy986YQZCeK4iX@fat_crate.local>
Message-ID: <E2531F1C-94F9-4E65-9375-DD19C16C7DD7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 15, 2025 2:36:55 PM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sat, Mar 15, 2025 at 10:29:25PM +0100, Ingo Molnar wrote:
>> So why does the higher level alternative_input() API exist? If it=20
>> shouldn't exist then we should remove it=2E If it exists, we should use=
=20
>> it consistently instead of open-coding its equivalent=2E
>>=20
>> Cleanups like this, especially if they are clearly part of an effort to=
=20
>> improve x86 code generation in this area, are not 'code churn', why=20
>> would they be?
>
>Because this is not improving anything, IMO=2E It is simply writing it
>differently, perhaps obscuring it more in the process=2E
>
>And I, just like hpa, would need to go look at alternative_input() to fig=
ure
>out what really happens there=2E
>
>Dunno, maybe we should really remove alternative_input() instead=2E=2E=2E
>

My main beef with the "higher level" macros is that they both obscure what=
 is going on and they have a syntax which is very different from the typica=
l asm statement, all of which makes them harder to read=2E Furthermore, the=
y don't cover all the possible ways that one can use the alternatives API =
=E2=80=93 and because cpp doesn't lend itself well to handling the colon-se=
parated groups of asm syntax =E2=80=93 that really can't be fixed easily=2E

