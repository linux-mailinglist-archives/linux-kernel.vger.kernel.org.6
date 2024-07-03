Return-Path: <linux-kernel+bounces-240318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84122926BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389901F22B38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DC191F6D;
	Wed,  3 Jul 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R1UffsgG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518A1946C7;
	Wed,  3 Jul 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047039; cv=none; b=NF3TYmToWelkSqhQSekrqgXc9GpKC0guoqQnBzih148X4Kz6k859ApAoaeRWXWtY2Kf5NM1vDFg1uZCdYN7EAwJmNGHL/kQq4AII8ABpO1UAy7gK7vQB2ryoogdz05qfY/ftEzXPXNyrFRrqnL94zLaEEbdWyWE++30W4/pyGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047039; c=relaxed/simple;
	bh=EvYdRrFVg1//eZC7KCKe5oJsASQ0BCoemy/FJO7iKlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7RGK6JvHjBUs4WvFXfB5mtMZh52IUlNqjoDxWgmEtu1AF71Q4rR28dPbjMvpedqV5TELDrK1Lww3oBzAj/6+N+6QNyR44mqgEvkstajObjN9EMKKD6LX637+NSVfShpJiDAwhdhcyWd36zfbURYpzW61rUk39XtiZA1wDd9ds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R1UffsgG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 570014189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720047037; bh=5R1/haKfPEig3HbS8GZsbghodeZoirzEQp5YzFFc1cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R1UffsgGE2HTunP2///JEfqA6clBj+jPsbSFss1GFxwPCXXK2MzzAnUagTfki+/Hl
	 n1zspl2dy6oQ0erIB90AZ+UP3k8ZwyQBOtDMbxRY9RfsToUrBZl2g1nV1bgy2Jl/FC
	 AHmTllTbnkEzkpOkGRDs6Xch0offNNi6aH8CR0VQrHGhnNCR07QWxXB/XMQ6ep3oz4
	 +H0WlHzyKv3sQcD96gzXO6pxt2CDMKUt2qNeMvA6rkSddlyFFsR4i6rhBxQS8AF6n3
	 6l1rdzYUtn00w9mpvEoilmnRH7Qf8JdMrJi1Tz8PKKqMztMOG0REJguup3a2T6K/bo
	 ff0T/9Hu6h9eA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 570014189E;
	Wed,  3 Jul 2024 22:50:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-doc@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH] Documentation: exception-tables.rst: Fix the wrong
 steps referenced
In-Reply-To: <874j9rgph4.fsf@trenco.lwn.net>
References: <20240614010028.48262-1-lizhijian@fujitsu.com>
 <874j9rgph4.fsf@trenco.lwn.net>
Date: Wed, 03 Jul 2024 16:50:36 -0600
Message-ID: <871q4at7ib.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Li Zhijian <lizhijian@fujitsu.com> writes:
>
>> When it was in text format, it correctly hardcoded steps 8a to 8c.
>> However, after it was converted to RST, the sequence numbers were
>> auto-generated during rendering and became incorrect after some
>> steps were inserted.
>>
>> Change it to refer to steps a to c in a relative way.
>>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>  Documentation/arch/x86/exception-tables.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/exception-tables.rst b/Documentation/arch/x86/exception-tables.rst
>> index efde1fef4fbd..562d1bc6d448 100644
>> --- a/Documentation/arch/x86/exception-tables.rst
>> +++ b/Documentation/arch/x86/exception-tables.rst
>> @@ -297,7 +297,7 @@ vma occurs?
>>     c) execution continues at local label 2 (address of the
>>        instruction immediately after the faulting user access).
>>  
>> -The steps 8a to 8c in a certain way emulate the faulting instruction.
>> +The steps a to c above in a certain way emulate the faulting instruction.
>>  
>
> Those steps render as 1, 2, and 3 ... where did "a to c" come from?

Ah, I see where my confusion came from.

The fix is obvious: indent the line that was changed so that it is a
part of the bulleted item it's talking about.  I've applied your patch
with that change.

Thanks,

jon

