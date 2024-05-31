Return-Path: <linux-kernel+bounces-196736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA58D60BB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1367BB239C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91F15749D;
	Fri, 31 May 2024 11:31:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62335155C87
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155117; cv=none; b=LYgtjLlccAMJRn1cJvhc/XsEj6ULFPEqkU4xDQDdE+p9rqatmBJSISfTucfrHWCBHKgfkItHyKxnarYK6QXV/z7X1YvN0ntwEcodiXxtPHNSIs6fJWrFTz7zcB/jeUmmL9yqw8MBW+dJ9+YLGP8plnW9sQVPKAGkh+o3ZEpZdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155117; c=relaxed/simple;
	bh=TmxQYiPP3ecRhKCM8rJ2qnA6Vdk3jTsL+nCFM7q9bVw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oc3+HUTNilmASmxFnLcq5EVwyk6WZorrE5vT9aFKhhBY4dGlifeCTf4T/PXRsNYx8R3o73p0Kz0US2A00Ga0hgvDcrtXbOQLTYQW59j6GT8RXU+sUopQ2O3DraInIR+KcSsyXXoDIITDEAJ2mmoOxsX4IA4b59Z1FMu5NLUftS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F089E1424;
	Fri, 31 May 2024 04:32:18 -0700 (PDT)
Received: from [10.162.41.15] (e116581.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EAE43F792;
	Fri, 31 May 2024 04:31:52 -0700 (PDT)
Message-ID: <e6b7858b-39cd-432d-9206-4ccbd153baa2@arm.com>
Date: Fri, 31 May 2024 17:01:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mm: Redundant const parameter?
From: Dev Jain <dev.jain@arm.com>
To: zhouchengming@bytedance.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
Content-Language: en-US
In-Reply-To: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I guess it would be better if I send this as a patch and wait for comments.

On 5/31/24 16:42, Dev Jain wrote:
> Hi Chengming,
>
> In mm/slub.c, you had defined slab_test_node_partial() to take a const 
> parameter.
>
> Is there any point of taking in a const, when you are anyways 
> typecasting it to
>
> a (struct folio *) from (const struct folio *) ? In fact, at the place 
> where you call
>
> slab_test_node_partial(), the struct slab *slab is not const.
>
> Please comment.
>
>
> Thanks
>
> DJ
>
>
>
>

