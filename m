Return-Path: <linux-kernel+bounces-407046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE5A9C67CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BDC284209
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2FE16D4EF;
	Wed, 13 Nov 2024 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rkvHghNZ"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF021607B2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468581; cv=none; b=bP6MNDhE0q5/s8gFzVTz3gAqeLs7LrgP7kPe1iw48ImCvjvRcf9C0jRwUixJ3+RqBlbEARe/gYwlAaEuaUC3xVAEJdaZaOCZPdM3b8a81zm32FSsyJmaQSaAEZhsXUPH8XwfzfPVadgk7wddse5RQo93OBAb9ptbF/xbznIdbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468581; c=relaxed/simple;
	bh=DDLeTSuk7KTpRFvWkhHgXVM73PqWlPZsPuD3WHhP8mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BIzIXLSD0ZL74ZvPe7aXCYMWSHNbYW/BfcfdvL232G5QRT13bwxLZcUO3+OCpjYcnTU/KZAMznVIHR74vsCeDBemnQP3XNCcAafIk+vUltEpS+6RZ1+0o18JhEASqsBzc1GV2Faq96+WFoaN49d5otbfk+pZAI9UbqZ+ZFGyCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rkvHghNZ; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from graphene.canonical.com (1.general.amurray.uk.vpn [10.172.193.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8838D3F0C6;
	Wed, 13 Nov 2024 03:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731468576;
	bh=beptcnJBOoSzirHuD+8H9ZMCZiHsT9eCpGA4OuptSLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=rkvHghNZCVUf0vRoe6l0o0EDQlBQM3rJmSHPj84lgo8PHEZDXcq7FzPpLVW9ytp+N
	 K/EuQlzWz830lku0DW6go7YI9mpbQi+4CtwEpR3NDKMeSnmW5uc8U+yGz6O4Uwh4v9
	 zzlgjtZWl9xUzV2zH1KFkdpjBjnRe/bwkEO+lBgH6L0erbCmy6r81QsVtOAOnM8eu2
	 zAvgxKPU9p14nTEaoFLT+9ZZuYyFFHy4Y2FHFLCijlmCsZapQv/GvUf1FAqeeCG4MT
	 U4eonw2ljy+pa/MGNea6DYkzkd2f93lSiikUSP9V+eR6AHGUWFk7g23vgsC5EktQK/
	 mojDfkcoTSqCg==
From: Alex Murray <alex.murray@canonical.com>
To: Dave Hansen <dave.hansen@intel.com>, dave.hansen@linux.intel.com
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 x86@kernel.org
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
In-Reply-To: <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
References: <87v7wtvty0.fsf@canonical.com>
 <1c1015f8-1a47-4e5b-b088-f83054d2f613@intel.com>
Date: Wed, 13 Nov 2024 13:59:31 +1030
Message-ID: <87iksrhkv8.fsf@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-11-12 at 07:51:38 -0800, Dave Hansen wrote:

> On 11/11/24 22:37, Alex Murray wrote:
>>> =3D=3D Microcode Revision Discussion =3D=3D
>>>
>>> The microcode versions in the table were generated from the Intel
>>> microcode git repo:
>>>
>>>  	29f82f7429c ("microcode-20241029 Release")
>>=20
>> This upstream microcode release only contained an update for a
>> functional issue[1] - not any fixes for security issues. So it would not
>> really be correct to say a machine running the previous microcode
>> revision is vulnerable.=20
>
> There are literally two things this patch "says".  One is in userspace
> and can be literally read as:
>
> 	/sys/devices/system/cpu/vulnerabilities/old_microcode
>
> "You are vulnerable to old CPU microcode".
>
> The other is in the code: X86_BUG_OLD_MICROCODE.  Which can literally be
> read to say "you have a CPU bug called 'old microcode'. (Oh, and I guess
> this comes out in /proc/cpuinfo too).
>
> If you think this is confusing, we can document our way out of it or
> revise the changelog.  But we kinda get to define what the file and the
> X86_BUG mean in the first place.
>
> I don't really see how it's possible to argue that they're
> "incorrect".

My point is that if a given microcode contains only functional updates,
then if you are *not* using it you do not have a security
vulnerability. If however the specified microcode revision fixes a known
security issue then yes I agree, there is a vulnerability and if you are
not using this microcode revision you are vulnerable to it. It is really
the distinction between a microcode update that is purely for functional
issues compared to one that is for security issues as well.

>
>> As such, should the table of microcode revisions only be generated
>> from the upstream microcode releases that contain fixes for security
>> issues?
>
> No, I don't think so. First, I honestly don't want to have this
> discussion every three months where folks can argue about whether a
> given microcode release is functional or security.  Or, even worse,
> which individual microcode *image* is which.

I don't think there is an argument here - releases at
https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files
clearly say if they contain Security updates or updates for functional
issues - so if a release like the previous 20241029 one only contains an
update for functional issues it should not be treated as a security
issue if a system is not running it.

>
> Second, running kernels with functional issues is *BAD*.  As a kernel
> policy, we don't want users running with old microcode. Security bugs
> only hurt our users but functional bugs hurt the kernel too because
> users blame the kernel when they hit them and kernel developers spend
> time chasing those issues down.
>

But just because something is bad that doesn't mean it is a security
vulnerability. One option could be to taint the kernel in this case
instead.

> So I guess it boils down to: First, should we tell users when their
> microcode is old?  If so, how should we do it?

So I suggest instead if you really want to flag old microcode as an
issue you could taint it as such since the description of tainted is

> The kernel will mark itself as =E2=80=98tainted=E2=80=99 when something o=
ccurs that
> might be relevant later when investigating problems

which feels like exactly the kind of semantics you describe above.

Then if you also want to surface old microcode that also is missing
security fixes you could then use your new proposed mechanism.


