Return-Path: <linux-kernel+bounces-242438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0126928807
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17F11C21578
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6757149C50;
	Fri,  5 Jul 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X/kPI/uT"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455051482F3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179274; cv=none; b=Xz65+hT0KCdEb//0ZMWk3Nlo5yM1Lbk2aoFlj+1V6/eFs9bncEAATLLgtMZuQeUHHDOkfUVGjYckrD05SZ2XpVriqbtMjn/RqjPNjTqr7UCtXtSib/5vbzSdbm3z84XagG9bdi6IYsgSJ0pbtqPFDQJ1ugqSlDYFdx4xLlVDges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179274; c=relaxed/simple;
	bh=lhrm2MbbpVMIVTtJ3vPKAgoCAUidNLDiXziAT9NgCjo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AntnG2bIU8In2EezfyAquqXOHtcCQkxWXOTZaXJhwR1IDLkE0hf5Xg69sPhk/syLar+A6KEjuDgFdyqMe5VwpSebHeNq0iUCKZRNWXpwgdtDp4TGv/DMcY9JQFn+mFYyUHlGSfN84kvkXPHB3lhNUk+OYzPBBnwniDp8+SGu0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=X/kPI/uT; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 465BXrGR1831654
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 5 Jul 2024 04:33:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 465BXrGR1831654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720179234;
	bh=lhrm2MbbpVMIVTtJ3vPKAgoCAUidNLDiXziAT9NgCjo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=X/kPI/uTWdH/24zjjjuKr/lDPalYxpr+wKgPJTWhOh0m6mIOEqg6niEHbKtz5ZXl+
	 Si/5hSqcJCjYDR0b17+nP3oHXsg9e5LVRbtxQCSamR/cNPmQxUICrytjTdWpz+yKk6
	 ybBzKBQNGLpeyUCQtIWdFARkujPxvzHG9KH1HNucx5yi8UjEaxFH+YkizoOhM6GH0r
	 ZHiJrOuV7adJd59btrYOG8cYHSi8OUY2QjWYPf+6aN4ntursPiDfJg1DynBOs7d0ha
	 mM3XyPpnNU2U58dVEIefERRGhXmnRNjLJGqnMIg8fKmL0yh9QnXowJGIYECz4heUfx
	 2B97dFSBJTEdQ==
Date: Fri, 05 Jul 2024 04:33:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
CC: Borislav Petkov <bp@alien8.de>, dave.hansen@intel.com, xin@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, nik.borisov@suse.com,
        houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <20240705092805.GC11386@noisy.programming.kicks-ass.net>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com> <20240705092805.GC11386@noisy.programming.kicks-ass.net>
Message-ID: <2EEA5074-7A1A-4C12-9FC4-36FB5110FF93@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 5, 2024 2:28:05 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wro=
te:
>On Wed, Jul 03, 2024 at 05:00:53PM +0100, Andrew Cooper wrote:
>
>> /* Non-serialising WRMSR, when available=2E=C2=A0 Falls back to a seria=
lising WRMSR=2E */
>> static inline void wrmsrns(uint32_t msr, uint32_t lo, uint32_t hi)
>> {
>> =C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0 * WRMSR is 2 bytes=2E=C2=A0 WRMSRNS is 3 bytes=
=2E=C2=A0 Pad WRMSR with a redundant CS
>> =C2=A0=C2=A0=C2=A0=C2=A0 * prefix to avoid a trailing NOP=2E
>> =C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 alternative_input("=2Ebyte 0x2e; wrmsr",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=2Ebyte 0x0f,0x0=
1,0xc6", X86_FEATURE_WRMSRNS,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "c" (msr), "a" (l=
o), "d" (hi));
>> }
>
>FWIW, I favour this variant=2E

We normally use DS as the padding prefix=2E

