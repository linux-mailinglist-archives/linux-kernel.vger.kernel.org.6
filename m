Return-Path: <linux-kernel+bounces-246669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1792C503
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4991F21E03
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11F152E1D;
	Tue,  9 Jul 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QgwSFjIh"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F481B86DD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558352; cv=none; b=WBHIlliUV8fAfhlSuTUk+lQ87VW+E+Xd/joFSWpHrA5eNB7cqOZYeZ/BOIY//YAlR8gr0gQaXxef5KcgDAQ2BC4QP9S/ft6gqd7It46uLyXKQKCywuHFlziIQK5ZXoKQySq02JQlUkBudoVnfxfQiadxPl0VdSM4KCjuKF0RG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558352; c=relaxed/simple;
	bh=0gnHYtuzCWtMCdE91m9238GexTD7erMTG4NEPOG8/oo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QF1HI5acJ8zopQFDWWn7gVoX180S4ef3thDeeGg6gH1vekZuNSoZSZ0VmN78z4ii6daNaLo0nln2Fyf+y5eqhp0ioKSYo4uzH5xNL4Rh1EgPjsWOz+yXsIqubHz8zVoGHcGDlOUwKqLKKJv/0WWC8DpujRl8jtwJUtMgKeUwN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=QgwSFjIh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 469Kpprw3642412
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 9 Jul 2024 13:51:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 469Kpprw3642412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720558313;
	bh=IqtKLK6i3oPJyziXAULF6lk4ZWyILxLkiWbdhFLA8pE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QgwSFjIhdtjRSEZrA9kdTUr3XOJ3x6/KgZ1XyDftosBWatMO7EeBdATFJAIb7Dw0+
	 Qdm4Mo1bpNCWbAT5rnqBCBTUUUYwswlqpJIUxNlXOck01gYa8WTNbFScedtOTGNK/g
	 lso7qTumg/qTDOSSXRnttAXuZ2Oqrd/Uj6I0qJOyuxy72c4p/IkXFulW7QL+S06xY0
	 uYjcFutv/uNDKEArsWc9sPbcX7pghzoMawIm/A/cM9RUX5d9JPeiBjM/oc1HtgwoiJ
	 y9uQnpnlBv9dq76BylNwWnO+Y57LwbUjpA2+3DORKfbjrTyjhr+CgEbDKcCGdy8Ssn
	 ifLDg1riVpUGw==
Date: Tue, 09 Jul 2024 13:51:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
CC: dave.hansen@intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        peterz@infradead.org, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <246c77ec-1911-4f43-9ce6-7e087b3a4562@zytor.com>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com> <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com> <20240703161705.GAZoV5gQIgtORQeHdQ@fat_crate.local> <DE8FD8AA-35C6-4E51-B1E0-CE9586892CB3@zytor.com> <20240705094418.GAZofAcvelmnRzbkoG@fat_crate.local> <cda57e5f-acf5-414c-8faa-d2496c02ced9@citrix.com> <20240705134517.GAZof47bcaL5i2b4ju@fat_crate.local> <246c77ec-1911-4f43-9ce6-7e087b3a4562@zytor.com>
Message-ID: <708BD311-73A7-4843-85DE-3E5B55F96BAE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 9, 2024 6:58:07 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 7/5/2024 6:45 AM, Borislav Petkov wrote:
>> On Fri, Jul 05, 2024 at 11:30:16AM +0100, Andrew Cooper wrote:
>>> You cite perf=2E=C2=A0 Look at the disassembly of the two approaches=
=2E=2E=2E
>>>=20
>>> cpu_feature_enabled() might give you warm fuzzy feelings that you've
>>> eekd out every ounce of performance, but it's an absolute disaster at =
a
>>> code generation level by forcing the compiler to lay out both side and
>>> preventing any kind of CSE=2E=C2=A0 As I've reported before, count the=
 number
>>> of RDPKRU instructions in trivial-looking xsave handling functions for=
 a
>>> glimpse of the practical consequences=2E
>>=20
>> Yes, I do cite perf because what you have above is not saying: "yes, th=
is is
>> a fast path and doing an alternative is warranted=2E" If that is the ca=
se, sure,
>> by all means=2E If not, make the C readable and ignore code generation=
=2E Who
>> cares=2E
>>=20
>>> Anyway, none of this is the complicated aspect=2E=C2=A0 The complicate=
d issue
>>> is the paravirt wrmsr()=2E
>>>=20
>>> TGLX's complaint is that everyone turns on CONFIG_PARAVIRT, and the
>>> paravirt hook for wmsr() is a code generation disaster WRT parameter
>>> handling=2E=C2=A0 I agree that it's not great, although it's got nothi=
ng on the
>>> damage done by cpu_feature_enabled()=2E
>>>=20
>>>=20
>>> But, seeing as I've got everyone's attention, I'll repeat my proposal
>>> for fixing this nicely, in the hope of any feedback on the 3rd posting=
=2E=2E=2E
>>>=20
>>> The underlying problem is that parameter setup for the paravirt wrmsr(=
)
>>> follows a C calling convention, so the index/data are manifested into
>>> %rdi/%rsi=2E=C2=A0 Then, the out-line "native" hook shuffles the index=
/data
>>> back into %ecx/%edx/%eax, and this cost is borne in all kernels=2E
>>=20
>> A handful of reg ops per a WRMSRNS? Meh, same argument as above=2E But=
=2E=2E=2E
>>=20
>>> Instead, the better way would be to have a hook with a non-standard
>>> calling convention which happens to match the WRMSR instruction=2E
>>>=20
>>> That way, the native, and simple paravirt paths inline to a single
>>> instruction with no extraneous parameter shuffling, and the shuffling
>>> cost is borne by PARAVIRT_XXL only, where a reg/reg move is nothing
>>> compared to the hypercall involved=2E
>>>=20
>>> The only complication is the extable #GP hook, but that's fine to plac=
e
>>> at the paravirt site as long as the extable handler confirms the #GP
>>> came from a WRMSR{NS,} and not a branch=2E
>>=20
>> =2E=2E=2E yes, I'd gladly review patches which address that and make th=
e whole deal
>> cleaner=2E I'm still sceptical those handful of regs shuffling ops woul=
d matter
>> in any benchmark but sure, if it can be done in a cleaner way, why not=
=2E=2E=2E
>>=20
>> Unless I'm missing some use case where that overhead really matters=2E =
Then by
>> all means=2E=2E=2E
>>=20
>
>It looks that it no longer makes sense to include this patch in this
>patchset; it is not something that can be done as a small cleanup=2E
>
>Any objection?
>
>Thanks!
>    Xin

I agree, this is desirable but separate=2E

