Return-Path: <linux-kernel+bounces-239807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881192658F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A641C21808
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4771822E5;
	Wed,  3 Jul 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b53hMXqi"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD21822CB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022867; cv=none; b=WADqfAR4LKtBBTBIOIOyv31rS0Cyo39R1nGSRXBkwlHmfq302BgbfAhpQbzyw0V+Asy+y/aMZgn3uqhi3RzM9MPf9lvU/7a3JczVGq8s5NkLDCTuGQDCfsOi8LA0XeDh03FaA6awsrJUsSuBE6ebZXOeTti0/BxFhZIKqz2fLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022867; c=relaxed/simple;
	bh=xyy3dbID03q/9EYcYheP6rsF2EPw8y64itUnYDWAxlQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qWA3yexGzh7P+L1fGXyq1yzfeMdGwiOX0H+aA8kR7YTJSJq7GH1p01QXf6jEf70EZmbc/SKHvUi3XdQ2lxlaWDY0N5zTzyqONRZK72gWvWMHKPe8FMXjJkk43XMJKxHkSAbxfKotGey9JI9U6HnNEQMb8mXI6TO2X1nr4QK1Ln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=b53hMXqi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 463G6wF2622823
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Jul 2024 09:06:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 463G6wF2622823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720022819;
	bh=um2HzzkI847L0P7OyLEltYCC22I4Yg2dUYD9njoVQOQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=b53hMXqiOK8RUBvYtBjYs/Gb1wQ3NXH2DJmhR6OidClASPSNyCGe2maIdSaAv17cQ
	 Vn93rtHzRqdBrFK4Uu/sKcIzfCnZFInbiq1YpCz/tonV4ar+3P8YRVMryVizZcVAT8
	 8Tv79LseoSenVMZMtxfS64wnSAXAFF/0LuBujSEKS05bm5hWBL+DRze9pPSqHCGwt/
	 BxC8hFSC2HyKAmaqNOKDvQeRfyjomTUixaLYktbJ+50l9yHdCY3QfGjR4f5q6wAlmW
	 Win6E8i5qpdvdUXc4DGgLwcCk18+MDSCaHNvANkbwf+JHLMM4uEtVNLVwsyd5HK/tz
	 cZm9umbtqEFSA==
Date: Wed, 03 Jul 2024 09:06:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@intel.com
CC: xin@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        peterz@infradead.org, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
Message-ID: <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2024 9:00:53 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Eco=
m> wrote:
>On 03/07/2024 4:54 pm, Borislav Petkov wrote:
>> Dave Hansen <dave=2Ehansen@intel=2Ecom> wrote:
>>> On 7/3/24 01:54, Xin Li (Intel) wrote:
>>> &gt; Do FRED MSR writes with wrmsrns() rather than wrmsrl()=2E
>>>
>>> A longer changelog would be appreciated here=2E  The wrmsrns() is
>>> presumably to avoid the WRMSR serialization overhead and the CR4 write
>>> provides all of the serialization that we need=2E
>> Also, all those wrmsrns() writes better be behind a CPUID check=2E
>
>They're not, in Linux=2E
>
>For the $N'th time, here is the primitive that Linux wants to stea^w
>borrow for this to be sane=2E
>
>/* Non-serialising WRMSR, when available=2E=C2=A0 Falls back to a seriali=
sing
>WRMSR=2E */
>static inline void wrmsrns(uint32_t msr, uint32_t lo, uint32_t hi)
>{
>=C2=A0=C2=A0=C2=A0 /*
>=C2=A0=C2=A0=C2=A0=C2=A0 * WRMSR is 2 bytes=2E=C2=A0 WRMSRNS is 3 bytes=
=2E=C2=A0 Pad WRMSR with a redundant CS
>=C2=A0=C2=A0=C2=A0=C2=A0 * prefix to avoid a trailing NOP=2E
>=C2=A0=C2=A0=C2=A0=C2=A0 */
>=C2=A0=C2=A0=C2=A0 alternative_input("=2Ebyte 0x2e; wrmsr",
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=2Ebyte 0x0f,0x01,0=
xc6", X86_FEATURE_WRMSRNS,
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "c" (msr), "a" (lo),=
 "d" (hi));
>}
>
>~Andrew

I believe tglx declared to use them unconditionally since FRED depends on =
WRMSRNS (and the kernel enforces that=2E)

Using an alternative would make wrmsrns() a more useful construct in gener=
al, though=2E

