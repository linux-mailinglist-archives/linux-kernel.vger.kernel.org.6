Return-Path: <linux-kernel+bounces-240725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3A9271B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E85BB217A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C21A4F2A;
	Thu,  4 Jul 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Sj8g5Bfn"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871491822E2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081718; cv=none; b=LYiTKuaptMaezzVPFh8TyWLbd4+dTbqnHH/VwANFygB6w5HnRS0iRxNi/IYkbP1UXB2EW0Fx13sJs//BmKm2ZLyUK+hrUsgIagwHLsSB+6ashwuLHMS9L269sZW3KsqNMB5wSB3nDAEWgYJ3N82zRfV2gcWaOippiuMZKSKAdu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081718; c=relaxed/simple;
	bh=0W3TbFtOxB1Ei4t8o9l0G5JIqoAbVkUTyOOYDSzVqxw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q+FjHTN6DwgRWHLwkWxJPcYe/AXlp/neh56g4OcqozXb4adjeK8wQZIk5Fot0yKsrl+hU01HrVRBjVVPmveLqhS5K/ubKnz5Cn6r7GION09o2VC3G6zzozdc6+LshaijCZGDRERj46rAv7VhuaPIcwYE3Q3KupGKWara5o4LKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Sj8g5Bfn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4648S2sl1336152
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jul 2024 01:28:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4648S2sl1336152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720081684;
	bh=0W3TbFtOxB1Ei4t8o9l0G5JIqoAbVkUTyOOYDSzVqxw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Sj8g5BfnEP+v/fY4O15kU1ZAstCMjTL20MKGBtoebNJXM4pNuHgxS69l2xvl8GK9S
	 vPTyw1oqdvyI8y+9h95LiLSPfIJUXK2ALQbpqNjaKqnXfIxeYf/6ier9vd/Ej1hwgj
	 x43Ex7zJtmAnkKR7ZJZBY2jcGlEfx00hZ+3ywlhy5B1bEyl3bFmNEsgKEWYWsuCGmL
	 WYHZAyMcVDRVy6w4URQ0uDz16GPti0c1r430YEbfeHls87xo5rxX9xtDD/YGtlVjV1
	 79kCOjvKBT9FaztrtqaA9WKBrx9/ksaGQBqFl3t0Oq36308KroKOy43QYsP4Xy5S6d
	 sfex8L6a2Dqeg==
Date: Thu, 04 Jul 2024 01:28:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        nik.borisov@suse.com, houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <20240704082343.GAZoZcD-yGxjYajcJT@fat_crate.local>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com> <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com> <56909a1e-b360-4090-945e-cf6ec623cccc@citrix.com> <ada20b3c-2935-4d4f-8daf-ba7b9a533877@zytor.com> <20240704082343.GAZoZcD-yGxjYajcJT@fat_crate.local>
Message-ID: <848595B3-9AAC-405E-B132-4B5169045631@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 4, 2024 1:23:43 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Wed, Jul 03, 2024 at 10:57:29PM -0700, Xin Li wrote:
>> Won't it be way better if we could have all x86 vendors agree on it?
>
>It would be way better if you simply do it as I suggested and stop debati=
ng=2E
>One fine day you'll know why I'm adamant about it=2E
>
>Thx=2E
>

I think that counts as an objection, so let's do it=2E

