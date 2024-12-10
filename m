Return-Path: <linux-kernel+bounces-439178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD389EABF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C771E1626DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07BD234962;
	Tue, 10 Dec 2024 09:27:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDFA22CBE5;
	Tue, 10 Dec 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822867; cv=none; b=O3whwSxFcvjwVPpKPLY2zColA3Xp3blcy+yfkMeQ72ImyNUwHx4EHBZrMCZvoP6yRRWDLSXvCZm0i1Bm+0AQr7FPUH5nQvMN9XScUnFlZk29A37Lgp2nP9Ke0oTAlM1MA1yIXMsv1+kQ1/iLyeKRvg4ZfK7uSvuryD0CRqZ1evw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822867; c=relaxed/simple;
	bh=6lCxHXRPw+uas6hTPKOniJ1wOd7+YLr7KZwvXvajpbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upS0cWZlvqIo2n/MheNyvF3XWfyTI2YquINEZwz2kFSYHjJjma+qrcTg07tah0r1ZHQ1bRDSPwD3eZ56LxKOam0Uhj4IFUMobIB/cVa+Zvhfo4WpJFlG3v8nqhAqvsfktzLZVjJIomGlfRnkw2oauHyFMLNyPaQIqxXWfpRu+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091D1113E;
	Tue, 10 Dec 2024 01:28:12 -0800 (PST)
Received: from [10.57.69.139] (unknown [10.57.69.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB86D3F58B;
	Tue, 10 Dec 2024 01:27:38 -0800 (PST)
Message-ID: <accd59bd-27ff-4a22-b3a5-c2705a0db075@arm.com>
Date: Tue, 10 Dec 2024 10:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/16] mm: Introduce kernel_pgtables_set_pkey()
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, jannh@google.com, jeffxu@chromium.org,
 joey.gouly@arm.com, kees@kernel.org, maz@kernel.org,
 pierre.langlois@arm.com, qperret@google.com, ryan.roberts@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-9-kevin.brodsky@arm.com>
 <20241209100335.GH21636@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20241209100335.GH21636@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 11:03, Peter Zijlstra wrote:
> On Fri, Dec 06, 2024 at 10:11:02AM +0000, Kevin Brodsky wrote:
>> kernel_pgtables_set_pkey() allows setting the pkey of all page table
>> pages in swapper_pg_dir, recursively. This will be needed by
>> kpkeys_hardened_pgtables, as it relies on all PTPs being mapped with
>> a non-default pkey. Those initial kernel page tables cannot
>> practically be assigned a non-default pkey right when they are
>> allocated, so mutating them during (early) boot is required.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>
>> It feels that some sort of locking is called for in
>> kernel_pgtables_set_pkey(), but I couldn't figure out what would be
>> appropriate.
> init_mm.page_table_lock is typically the one used to serialize kernel
> page tables IIRC.

That does seem to be the case, thanks! Hopefully holding that spinlock
for the entire duration of the loop in kernel_pgtables_set_pkey() won't
be an issue.

- Kevin

