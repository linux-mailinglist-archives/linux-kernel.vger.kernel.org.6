Return-Path: <linux-kernel+bounces-178291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B977E8C4B75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484231F22974
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4BB665;
	Tue, 14 May 2024 03:25:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E4617C2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715657141; cv=none; b=jPr0it6+eMa6LnYMR/44KUugOyPtEFHZGBDqzSK2Lb/9n3A23t0AgPWbj1T/WS+diRjhBfkkq+pMYkNiorrskNw7grk0NgTG2uUq5frI8MRqxK1Yrp5CZl37brCs+jJSH44eJt1GuK/a/jKFKCnWCAtoO61qnD0r/bT+5xS5KBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715657141; c=relaxed/simple;
	bh=jk63Rm7ks9AdRCHsNPN6oDJWZW1fBSt+HTwGGngaXvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlZCu78bVl2+Vwhg9Mz/HwESWw+4EhwMKOwtyFCPpD2WRY6SM55DbzLiEq9c+9ioQDithw3s/cVnq/PbtdM2Fsytyv5k1imYB0hMSe69WkRNpfP1xtvkmgERnUEh3ycJOnQ4oiqFu/hKY8dht2bvGp9qyz2eDf3vH4d/VDmSoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 788891007;
	Mon, 13 May 2024 20:26:01 -0700 (PDT)
Received: from [10.163.35.194] (unknown [10.163.35.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA3373F762;
	Mon, 13 May 2024 20:25:33 -0700 (PDT)
Message-ID: <3ade5078-0105-4d10-86d2-02806d48fbd0@arm.com>
Date: Tue, 14 May 2024 08:55:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: optimize folio_move_anon_rmap()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Chen Taotao <chentt10@chinatelecom.cn>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240512123555.8358-1-chentt10@chinatelecom.cn>
 <7a4d4992-4c8a-43b9-8c41-a938bc3cec67@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7a4d4992-4c8a-43b9-8c41-a938bc3cec67@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/24 21:07, David Hildenbrand wrote:
> On 12.05.24 14:35, Chen Taotao wrote:
>> When a folio belongs exclusively to one process after a COW event,
>> folio_move_anon_rmap() always moves the folio into the anon_vma
>> belongs only to this process.
>>
>> However, if the folio already belongs to the anon_vma of the this
>> process, we don't need to move it again. In this case, we first
>> check if the folio already belongs to the anna_vma of the this
>> process, and only move it if it does not.
>>
>> The above changes may improve the performance of vm faults in some
>> scenarios, because the performance loss caused by WRITE_ONCE() is
>> much more than the performance loss caused by add a judgment.
> 
> Please proof that by real numbers. I don't think it will make a real difference, and we likely don't want that change.

Agreed, only scenarios when pre-condition check makes any sense is
if subsequent actions are expensive such as writing into registers
etc. But in this case both 'if' and 'WRITE_ONCE' statements are of
comparable cost, hence adding additional conditional check is only
going to increase the cost on average i.e when both gets executed.

