Return-Path: <linux-kernel+bounces-196768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818248D61A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF821C23D88
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB3F1586C5;
	Fri, 31 May 2024 12:24:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF015821A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158286; cv=none; b=SRyux+U2snM+ZIvlc6bFvhIhgxzqYIJd30pP37BItIy20mLM9jvdc9GuESdIR/I4SgiZQCwqLA8uy9S097mDKCke2bEpBmOVQaPVycQ+PUwpIK0UAGOyoY2pE/bycI/lWi5MH+FkqTYXr22mxkAW6yhh4Lw1YklrMtQnHeqQ57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158286; c=relaxed/simple;
	bh=gycZeptDOO8BSOy2lJr6Kdr4HIqhN8k26v9SLWIIhJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfTfKsKwRr6APxy6pPUYH/0sGRotSTgoLZzXe7jABhAcgUOFhZpCOcgfQZt79Z1w3ftAJ7JbO2zO1DGo8FVGMfEXKMSV13MywoDoEqABGCG9QCXyEFwhTm+O89/rcQkk/B3R+qNzduGLfcCoFeFSh5NmeGFaJI3TO1oWOiHPN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9561424;
	Fri, 31 May 2024 05:25:07 -0700 (PDT)
Received: from [10.162.41.15] (e116581.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759503F792;
	Fri, 31 May 2024 05:24:41 -0700 (PDT)
Message-ID: <f02792b7-ddf4-48c4-954d-aba20bebee61@arm.com>
Date: Fri, 31 May 2024 17:54:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] mm: Redundant const parameter?
To: Matthew Wilcox <willy@infradead.org>
Cc: zhouchengming@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
 <Zlm_vlhYa91fA1wu@casper.infradead.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <Zlm_vlhYa91fA1wu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I was just about to hit git send-email for a patch-series of 2, I 
noticed your reply :)


On 5/31/24 17:47, Matthew Wilcox wrote:
> On Fri, May 31, 2024 at 04:42:59PM +0530, Dev Jain wrote:
>> Hi Chengming,
>>
>> In mm/slub.c, you had defined slab_test_node_partial() to take a const
>> parameter.
>>
>> Is there any point of taking in a const, when you are anyways typecasting it
>> to
>>
>> a (struct folio *) from (const struct folio *) ? In fact, at the place where
>> you call
>>
>> slab_test_node_partial(), the struct slab *slab is not const.
> I have a patch to fix this; hang on a second ...

