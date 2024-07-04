Return-Path: <linux-kernel+bounces-240873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406839273F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5B4DB21408
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DC1AB913;
	Thu,  4 Jul 2024 10:25:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C21BC4E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088741; cv=none; b=uK7bjCrkEqXAIm6VYD2myfgQVw9giNWOWkKr1ORClsL8WNf7bbcgBJ0A6BjjUr9f1KZNPPjmdHTxFOi0a4dWKk5r+VacjLiXFxwIsrpnddyS/yXZbc48taIjr5MNnlFSvtIhC5RhBxgnNvMeJvsWLdHWP9xDAxk5VsvIv6SiSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088741; c=relaxed/simple;
	bh=aQ+PKLIFfhMR7MaunXCicxgEiTL68vDduOxl2Txsx1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1loF9UB30RdYSNsqBU1CKKkJg5lU6tKcK1JyJgD4kB/UthJyEEE0xF5Qheeeym96ggUgrk1FaaMWcEVLBIhTZDUx/JpHBMeb9v73RS/r0VGaAFj02ofymj6hjjK4j1gH2fmhwJXsMjbMAb019yOUq1XKNyQOWwticrtzlEBko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C75F367;
	Thu,  4 Jul 2024 03:26:03 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8BE43F762;
	Thu,  4 Jul 2024 03:25:36 -0700 (PDT)
Message-ID: <60829312-5011-4fa8-9a56-40c6e2382e2f@arm.com>
Date: Thu, 4 Jul 2024 11:25:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
Content-Language: en-GB
To: Bang Li <libang.li@antgroup.com>, ughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ioworker0@gmail.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240702023401.41553-1-libang.li@antgroup.com>
 <507da6d0-77c5-46ca-8351-53b405ecb131@arm.com>
 <8c018e06-74f1-46e9-bc32-b3870342cdc1@antgroup.com>
 <8d9e501a-0645-4b78-809a-7c9f49f2106d@arm.com>
 <c1e38d54-400c-4647-9ffb-1bf70f92c0c2@antgroup.com>
 <ccd5a1b8-3b01-4f5a-b9fb-6a5068b08a4a@arm.com>
 <941458a6-9e74-444a-9dfd-726d0a7cf158@antgroup.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <941458a6-9e74-444a-9dfd-726d0a7cf158@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>
>> See [1] for an expanded list of concerns I have about the current state of the
>> interface and implementation.
> 
> OK, could you please send me the corresponding link ;)？

Oops!

https://lore.kernel.org/linux-mm/65c37315-2741-481f-b433-cec35ef1af35@arm.com/


