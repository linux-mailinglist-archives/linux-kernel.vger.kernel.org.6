Return-Path: <linux-kernel+bounces-439102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA429EAAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54934283ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD92309A1;
	Tue, 10 Dec 2024 08:38:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAB1B6CE5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819911; cv=none; b=QNp/vgAXja083HgH6IDXO4Y1+1i2MKjo+ZcrxuMgAXUQDsIK0xvcUohrE9MsZP4Jm/y3x0vS7P/aPReeLALzlh/sDkhleyD3fGokmQnU4OEf66g/WU2Vgd/chcpU7zsrTQqhwSFtirCykKvKJLwkEn6tWox7C29Q7kPdJOdY71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819911; c=relaxed/simple;
	bh=cAGIuD2YlET0cy0jpLsSeRHL+mXLnXuqvkoYlbkbngE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYYJYKvQ2Vj72pXI1+sshtDpjL6f+E30MvUpnMT/5xZ/k4NY28vsHK9A4ghzNrx0JyNXjTVrxqh8g115hyjef6TXjDRV+5WnIOBKK6DBKNeDO6TKs43RdNn6mF4+0WPLzygp3Db6c/MdxOpQGMlI9b5hOc084eTtz+jbDB5W0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7230B113E;
	Tue, 10 Dec 2024 00:38:55 -0800 (PST)
Received: from [10.163.48.173] (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 426E93F720;
	Tue, 10 Dec 2024 00:38:22 -0800 (PST)
Message-ID: <0224b253-5eae-4921-a066-308033396a73@arm.com>
Date: Tue, 10 Dec 2024 14:08:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: refactor the rodata=xxx
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, corbet@lwn.net, patches@amperecomputing.com, cl@linux.com,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, inux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
 <20241209072020.4743-2-shijie@os.amperecomputing.com>
 <d13f1879-7fbc-458d-8fd3-4340b51165fd@arm.com>
 <CAMj1kXFJhFfhy=Gwm=QrdN6XPUd=7SKNKFBF_Z4eQ30r509BCg@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMj1kXFJhFfhy=Gwm=QrdN6XPUd=7SKNKFBF_Z4eQ30r509BCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/10/24 12:51, Ard Biesheuvel wrote:
> On Tue, 10 Dec 2024 at 08:17, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
> ...
>>
>> Reformatted and cleaned up the above comment a bit but feel free to
>> improve it further.
>>
>> /*
>>  * rodata=on (default)
>>  *
>>  *    This applies read-only attributes to VM areas and to the linear
>>  *    alias of the backing pages as well. This prevents code or read-
>>  *    only data from being modified (inadvertently or intentionally),
>>  *    via another mapping for the same memory page.
>>  *
>>  *    But this might cause linear map region to be mapped down to base
>>  *    pages, which may adversely affect performance in some cases.
>>  *
>>  * rodata=off
>>  *
>>  *    This provides more block mappings and contiguous hints for linear
>>  *    map region which would minimize TLB footprint. This also leaves
>>  *    read-only kernel memory writable for debugging.
>>  *
>>  * rodata=noalias
>>  *
>>  *    This provides more block mappings and contiguous hints for linear
>>  *    map region which would minimize TLB footprint. Linear aliases of
>>  *    pages belonging to read-only mappings in vmalloc region are also
>>  *    marked as read-only.
>>
> 
> If linear aliases are marked as read-only, how does 'noalias' differ from 'on'?

Right, the last sentence can be can dropped.

