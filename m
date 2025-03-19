Return-Path: <linux-kernel+bounces-568834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313EEA69AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7814616D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331B214A8D;
	Wed, 19 Mar 2025 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="C3S+6Vmg"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626FA213232
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420276; cv=none; b=h05IJZ9wPHO4EVMszCnsJdDrn/T2LtWEtn3Tqshbg7/Za0zklh3O5UkR9Zw5eyCR0fSVJ2XdByVdIAhm94syGfuMY/x6Krj2QjkKNvFnv08Aj5MFuUBF8kQHHwnTNZcpBCCotI5wkrweWNLMk6InS5Mt9vqr1izBtuPVCHdZCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420276; c=relaxed/simple;
	bh=igXvRtvCkoJEAtcvR466ksYl5KrIfTTEO33JIxuBk8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd0mi5OzzHimrEVezpZlUv8J6LGtMpwuK8Lfby2oP2d/hPlRaGpn1NK+Lx/hrj2Y8r//1t/yJMaCRVAfxiDpua620h3r1E76RniQHF8TalNTSzFlb9DvIbj+n5MXKqMgXxKyAroq+Tyuw/23gAHJKqtFzeRwbkWwml6HAGtez1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=C3S+6Vmg; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <4d45df0c-d44e-4bb6-8daa-0dba1b834bc4@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742420262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDJL+avqyQivSc/tZpy/FsXCVGYKqm0FhSqiAlMXSfk=;
	b=C3S+6VmgvccqvPi6WWbIAzLwx40URVVAjPIg7cGnBwezs6jYObL58WESqdFHc6noSZbSvw
	T8BeUvDq02cwuDDqht1BshGN2tEqjqjUJk4/j7iUm2/puMeQI18QpatopxEuYwoLwKfQH9
	zlWoGkf4sAsp2jUcdW+6W8EdX3MbYggQwNbJCGMQeOsaKKoQqMNeH1TybmawyFP2kQmOxd
	b5dvD+WZT/iyWKgg2uK5ZxD4R8Rl1UHn5qvG/6d9gC+MupWPQ4MJY7v63dnm9BYH8ezMoY
	ryBbwnEgygNU1+VkpyLrSQHK7RtWILpr8Y9p1PMAGFfj6ffADLDxOYcI9WBR+g==
Date: Wed, 19 Mar 2025 22:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] include/uapi/linux/swab.h: move default
 implementation for swab macros into asm-generic
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-1-d53b6d6ab915@iencinas.com>
 <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <2afab9dc-e39c-4399-ac5a-87ade4da5ab0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 19/3/25 22:12, Arnd Bergmann wrote:
> On Wed, Mar 19, 2025, at 22:09, Ignacio Encinas wrote:
>> Move the default byteswap implementation into asm-generic so that it can
>> be included from arch code.
>>
>> This is required by RISC-V in order to have a fallback implementation
>> without duplicating it.
>>
>> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
>> ---
>>  include/uapi/asm-generic/swab.h | 32 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/swab.h       | 33 +--------------------------------
>>  2 files changed, 33 insertions(+), 32 deletions(-)
>>
> 
> I think we should just remove these entirely in favor of the
> compiler-povided built-ins.

Got it. I assumed they existed to explicitly avoid relying on
__builtin_bswap as they might not exist. However, I did a quick grep and
found that there are some uses in the wild.

I couldn't find compiler builtins for ___constant_swahb32 nor 
___constant_swahw32, so I guess I'll leave them as they are.

Thank you!

