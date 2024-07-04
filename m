Return-Path: <linux-kernel+bounces-240693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C1927110
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837F91C220AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B551A38E8;
	Thu,  4 Jul 2024 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZdFL+0i1"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38668174EC0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079980; cv=none; b=qXI2U90qlgylk+gleBXY3Lvpyyu8sMd1InsLc9Dl3APVaER88j7fVSQXzxGRgOUyS4hlQJhxckNTsL8/AgGMqOksg107Nm3V3sRvpxtZykcebrtaXU66oTu6TdjCeYzEKBBweRGQXORUtk2nFPxw2h0yCbn5S5hFH6+Qo/PEkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079980; c=relaxed/simple;
	bh=uCHLNn9xW6DSGJxm2VvdezS3o/2wBq8N3JtHJLSItQ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aRIOdJVakUtEffCC2GYxEb+FB/SgiSn2rRtdOBz9H4vV58toYnAiWagW0m1MRPnihwgmk+Rbtu7usgXtpo8OERb+iEHGTuZfUDQNrvIA4iIghTdajXkaMr804czMa0+odHDDiS9yPssLIAlbq9KAqoKx6cQHgDXrwVn7jxcWpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZdFL+0i1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4647wvQp1325117
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jul 2024 00:58:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4647wvQp1325117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1720079939;
	bh=TEQkEq5fwuA0kITHZp4giwTncsUgvpmrSlBYawflwQk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZdFL+0i18i6PPQaxlfiU4r04LCx+59xPAg3LyoMUMaKq7NRDhHSr6GguEvbUEXO7i
	 jhEnIUwxRobrrEJYv6+vAaFTicRCPGnLYW1WojtMKyJhnLG66C7j7IfZ6DPOx7GvDr
	 oYe7dDxhOi3jeYoGRac3I5Gi9ZvWqh0md+CPRqtnjuQ+/nLMfPlhB9IrCbtI8IXNQ5
	 0t4yPtGrLWKKhD8SYkMgpf9DF10lc+YrfZaYUVo8FmCdlJRHTBmpuTYi9wtxNjAbTZ
	 +CYIaM7lB8l8S2RAKcHDL1ir/nNpEiz/MZMbD9eqPo9MhkcP8tkWpTntg2p7XSuSG+
	 Osj4+UeVyZ8Qw==
Date: Thu, 04 Jul 2024 00:58:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@intel.com
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        nik.borisov@suse.com, houwenlong.hwl@antgroup.com
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
User-Agent: K-9 Mail for Android
In-Reply-To: <ada20b3c-2935-4d4f-8daf-ba7b9a533877@zytor.com>
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com> <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base> <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com> <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com> <56909a1e-b360-4090-945e-cf6ec623cccc@citrix.com> <ada20b3c-2935-4d4f-8daf-ba7b9a533877@zytor.com>
Message-ID: <AC8AACE5-7A77-479A-B776-AE65BFA241FF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2024 10:57:29 PM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 7/3/2024 9:18 AM, Andrew Cooper wrote:
>> On 03/07/2024 5:06 pm, H=2E Peter Anvin wrote:
>>> I believe tglx declared53  to use them unconditionally since FRED depe=
nds on WRMSRNS (and the kernel enforces that=2E)
>>=20
>> I know that Linux has chosen to have this as a software-enforced
>> requirement=2E
>>=20
>> The dependency does not exist architecturally, and just because it
>> happens to be true on Intel processors doesn't mean it's true of other
>> implementations=2E
>
>Won't it be way better if we could have all x86 vendors agree on it?
>
>

It was tglx' explicit request to keep it simple unless someone objects=2E =
All it would take is for someone to come up with a countercase=2E

