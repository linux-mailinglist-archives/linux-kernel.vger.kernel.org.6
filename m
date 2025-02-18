Return-Path: <linux-kernel+bounces-519323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A68A39B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5DF7A4A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5524113E;
	Tue, 18 Feb 2025 11:58:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53A2405FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879891; cv=none; b=Pw97HXl/nlCri8c8ctvFp3CtQrXLLsnLvtGd/kb5bUVh4/OBFkvi9luqefcfrO+yeIGOJXgc+pzurcg22RbdDnClh72nEWByWetoeBmbmDTcIQij6yJpi7R2suYUw1XXKe7dd3ub2+oFq6T2ix5ONFZU6qR8y8icJzvnrTl+YUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879891; c=relaxed/simple;
	bh=DLAD/7/4mb5QJazBEEw3Zk7HbJ+iZ3iKsiKOkItCK2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRf0Mi7xbu6ECxh/EJ4Vus2akVYZHuhBcX254OL8c1KiP3eXT1v5Bx0o9H2MG2j0aCRZgOisIJVfPA+Pf3X8g05gofRgyqsV4lQUIvd6ShP5teiT4oePrxmYmIFJarOwRFcmF9qC1mGPKSPupJJb2ftbQIHOLyFUNoaIc2ZRhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA5B152B;
	Tue, 18 Feb 2025 03:58:27 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987F23F59E;
	Tue, 18 Feb 2025 03:58:07 -0800 (PST)
Message-ID: <43192985-584e-4d6a-86b6-5299638d9fb1@arm.com>
Date: Tue, 18 Feb 2025 11:58:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 0/2] arm64: support FEAT_BBM level 2 and large
 block mapping when rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <022c4799-bf0e-44d4-b657-d6af29a9a31d@arm.com>
 <7ca5e8a6-9f01-40c6-a46d-c717ae7ab3b1@arm.com>
 <8e3ad39e-de59-48bf-b776-b27dc784a8ef@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8e3ad39e-de59-48bf-b776-b27dc784a8ef@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 21:27, Yang Shi wrote:

>>> I don't really understand how vmalloc is relevant here? vmalloc can already map
>>> huge pages you use vmalloc_huge() and changing the permissions of vmalloc
>>> mapping will only affect the ptes pertaining to that mapping; I don't see why
>>> that would cause permissions to be changed on the linear map or for huge pages
>>> in the linear map to be split?
> 
> I just uses vmalloc() API to emulate what modules loading does. Allocate memory
> via vmalloc() then change permission to, for example, read-only, by calling
> set_memory_ro(). So I can stress the page split by doing it on the most of
> memory, for example, 80% of memory. It is more efficient than loading real modules.

Ahh I see. I hadn't previously appreciated that we change the linear map
permissions at the same time as changing the vmap permissions. Makes sense.

> 
> It is implemented by a patch against test_vmalloc. I don't include the patch in
> this series, if you think it is useful, I can include it in v3 anyway.

I don't think it's necessary to include in this series. Although perhaps useful
as follow up patch to beef up the vmalloc perf tests.

Thanks,
Ryan

