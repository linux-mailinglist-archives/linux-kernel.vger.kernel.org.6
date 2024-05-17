Return-Path: <linux-kernel+bounces-182489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5F8C8BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506781C210B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A313DDD4;
	Fri, 17 May 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GFgwwms4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A10213DDB6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968030; cv=none; b=o69r5fBcaRE9bMPwa0H20HCmhn6pNqjKmXOpcs4GZ85FGLzalCRTlDLhwbniawkPipfyGUyA0C4eAY6GhyceisVTh1RYJk/fYjGxe1T0esWCJ6yRfaYXhec3jP6yMjzJjIq8ovJE+6jlNmi/xuq9EouuutwpYwvandkil87TpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968030; c=relaxed/simple;
	bh=s953sk5n/NeAVDdd0aV9BvqgcCqXLRcDa7PuZ5KTB2Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aYIHJ94r3J5U9Q7gs/TnGv/gHyp8uLvLwlNXFFmzl4G9CRfqyMmqhi6MfGsbnZXyxIVE0bNw6qUSrrV2wzDRldyHCUnueWdRpNUqHTTr1rntaAMwhGNo8dlv3m45DCWc4J3cwEcD2ld9jUoqw6GUszhbob37BIi9Id7GfTx104c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GFgwwms4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 44HHkXfw2564600
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 17 May 2024 10:46:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 44HHkXfw2564600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024051501; t=1715967994;
	bh=szLPbiQdc8E9uUoOZsNWX0bh8PnKr+5DS2+bIeNO6nI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GFgwwms4oINnKXr9a1/WH2hk+eP/pBzaMX5lPQ6flzW7Cy7jq4tPYL1i6vbwlGv8X
	 kj0gUpJhasAfTqxccA70htdQZxbjQpUZ6Q3cEx7nreeMjp7d7/P5KSWArDSGGeQqJM
	 hIAkDvZ0jED5Me86FZs4Sw2eZoNLFOfpyKX7lZRed3NGJZKr3i2qJHdDscIU8l+MNA
	 Mc0kJlhU9iSfoxxE2pnP7jXmUxVzVrt5vdi/eqXFXsgPdd9KNpOJZBiJUyUQ/iFB0j
	 mqdgnAS3GnsjKcmek0rMEUNFZvQGiHS5LDY7w6LIGruFG0McAUwUnPq/hfyfKw8Fyg
	 h5aa/mWoTFMFQ==
Date: Fri, 17 May 2024 10:46:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mateusz Guzik <mjguzik@gmail.com>,
        Thomas Renninger <trenn@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_x86/cpu=3A_Fix_x86=5Fmatch?=
 =?US-ASCII?Q?=5Fcpu=28=29_to_match_just_X86=5FVENDOR=5FINTEL?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517173811.GFZkeWAzKjYtEMwe1e@fat_crate.local>
References: <20240517172134.7255-1-tony.luck@intel.com> <20240517173811.GFZkeWAzKjYtEMwe1e@fat_crate.local>
Message-ID: <EEEDDDD9-3514-4246-B506-6A1DBD5CF794@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 17, 2024 10:38:11 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Fri, May 17, 2024 at 10:21:34AM -0700, Tony Luck wrote:
>> diff --git a/arch/x86/kernel/cpu/match=2Ec b/arch/x86/kernel/cpu/match=
=2Ec
>> index 8651643bddae=2E=2E996f96cfce68 100644
>> --- a/arch/x86/kernel/cpu/match=2Ec
>> +++ b/arch/x86/kernel/cpu/match=2Ec
>> @@ -39,7 +39,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x=
86_cpu_id *match)
>>  	struct cpuinfo_x86 *c =3D &boot_cpu_data;
>> =20
>>  	for (m =3D match;
>> -	     m->vendor | m->family | m->model | m->steppings | m->feature;
>> +	     m->vendor | m->family | m->model | m->steppings | m->feature | m=
->flags;
>
>I think this should not do anything implicit even if it is correct but
>should explicitly check
>
>	if (!(m->flags & X86_CPU_ID_FLAG_VENDOR_VALID))
>		continue;
>
>I don't have a clear idea how exactly yet - I need to play with it=2E
>
>Maybe this stupid flow in the loop should be finally fixed into
>something more readable and sensible=2E=2E=2E
>
>Thx=2E
>

Thought: why don't we add VENDOR and CPUID as synthetic CPU feature flags =
as well? Not saying it necessarily solves this specific problem but it migh=
t make some other code more uniform=2E=20

Obviously on x86-64 CPUID is baseline; VENDOR might not be known, however=
=2E

