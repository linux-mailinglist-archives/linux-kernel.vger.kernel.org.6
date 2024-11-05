Return-Path: <linux-kernel+bounces-397229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0B9BD810
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED682835EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7BD216208;
	Tue,  5 Nov 2024 22:04:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B91F667B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844288; cv=none; b=iiPzteD+y84ck0aBOIOvi+33NwCOZbnPlFG7rTlZMtOyiIdqXQ3jVxwqbL4t/Q6ub5uc3mWuuFkyl61EpQvw0RpNLJIWZxiPSyP4xbZYvFTaOlwRk5FxbksqZQBM9bqbs1nJR1hLMaGTbg+bS7ax7wusLr60uRX87Z9sPeaMP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844288; c=relaxed/simple;
	bh=HrrOJ1WXEnxZCWPt0G7AtZPZHKTNdlqZy0JiF25Ri44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPw2xpnOc0FrDJfpOJn3GI8r7bGnBcBu6s1geyPiAApMCvL9AqWtX/550s068AL3W7FzRVVeRirR/jMmts3V+Gq3KaKMV1Wz9yUVX3BXrn1Kg4vuRPkBioFqWZUlONDDqJGROy8TxA7zuL3Vk1sGel9JTHeViCheXeQjOZqxOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D98DC4CECF;
	Tue,  5 Nov 2024 22:04:47 +0000 (UTC)
Message-ID: <1dd8be4b-d5c3-4074-a91e-3ce998ce3050@linux-m68k.org>
Date: Wed, 6 Nov 2024 08:04:44 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: use kernel's generic muldi3 libgcc function
To: Geert Uytterhoeven <geert@linux-m68k.org>, arnd@arndb.de
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20231113133209.1367286-1-gerg@linux-m68k.org>
 <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdVZh6-64hfx1jgOijBEG6cTftinqf+4fZvqjJtV1hO95g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Geert,

On 5/11/24 21:46, Geert Uytterhoeven wrote:
> Hi Greg, Arnd,
> 
> On Mon, Nov 13, 2023 at 2:32 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> Use the kernels own generic lib/muldi3.c implementation of muldi3 for
>> 68K machines. Some 68K CPUs support 64bit multiplies so move the arch
>> specific umul_ppmm() macro into a header file that is included by
>> lib/muldi3.c. That way it can take advantage of the single instruction
>> when available.
>>
>> There does not appear to be any existing mechanism for the generic
>> lib/muldi3.c code to pick up an external arch definition of umul_ppmm().
>> Create an arch specific libgcc.h that can optionally be included by
>> the system include/linux/libgcc.h to allow for this.
>>
>> Somewhat oddly there is also a similar definition of umul_ppmm() in
>> the non-architecture code in lib/crypto/mpi/longlong.h for a wide range
>> or machines. Its presence ends up complicating the include setup and
>> means not being able to use something like compiler.h instead. Actually
>> there is a few other defines of umul_ppmm() macros spread around in
>> various architectures, but not directly usable for the m68k case.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>   arch/Kconfig                   |  8 +++
>>   arch/m68k/Kconfig              |  2 +
>>   arch/m68k/include/asm/libgcc.h | 20 +++++++
>>   arch/m68k/lib/Makefile         |  2 +-
>>   arch/m68k/lib/muldi3.c         | 97 ----------------------------------
>>   include/linux/libgcc.h         |  4 ++
>>   6 files changed, 35 insertions(+), 98 deletions(-)
>>   create mode 100644 arch/m68k/include/asm/libgcc.h
>>   delete mode 100644 arch/m68k/lib/muldi3.c
> 
> I had this in my local tree for about a year.
> Is it fine to queue this in the m68k tree, or does this need a broader
> coverage?

I am still in favor of it :-)
Would be good to get some feedback on the common code changes, like the change
to libgcc.h.

Regards
Greg


