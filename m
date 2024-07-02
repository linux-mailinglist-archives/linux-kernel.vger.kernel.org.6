Return-Path: <linux-kernel+bounces-237967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2792415D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C6284ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D837F1BB6A5;
	Tue,  2 Jul 2024 14:51:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CC1B47AC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931884; cv=none; b=gkZs9scVj9wE7mDIUQjGhhuJDwK0MdeJ97TZf6wB46ROMYOS8ZLI0Ol1Xz2KtMNDEpgw+4nxn0cxYTRtYqRJyRUprOEhfwJXdgE7gp4Rm4g/lOsTkC2hTANa06HIhNnLcDFQYwKBv/K2/LTzK974o1+6YO6lo4M5M1faqFus6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931884; c=relaxed/simple;
	bh=Ms2iicYt9LyTcQRJHFKWfsnMqsPt9a+ETxMYoFcbOjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azcQ/bhF01igcoVyiWoEyUa46I+NaQ8lael7r2RvwDSOrPf2tiaUY/6eO+lINYy5sLodFG7Zur4tpiZD0y/6/rF2kIeAVcCiLSmlKbLqg/fFfVk4Sy404Qy7YM9jKvcbGF3X6i6GFt68Epm6rgFmurYp9SOZggVmWARLp2TcBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57F9D339;
	Tue,  2 Jul 2024 07:51:47 -0700 (PDT)
Received: from [10.1.32.193] (XHFQ2J9959.cambridge.arm.com [10.1.32.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC5643F766;
	Tue,  2 Jul 2024 07:51:20 -0700 (PDT)
Message-ID: <1845bd3d-499d-479a-8c10-14aab8966e37@arm.com>
Date: Tue, 2 Jul 2024 15:51:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jinjiang Tu <tujinjiang@huawei.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com> <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
 <34f2d8c6-50fa-4a8a-82a8-d417eb30ea70@redhat.com>
 <905e1319-7b20-4812-b052-8031a3c4dcf3@arm.com>
 <168f9fd4-527d-4b74-86b0-029ef474f9b6@redhat.com>
 <9a9e0a83-59a8-46ac-ae7a-8f2a65b48e1e@arm.com>
 <7be46fdd-f73b-4edd-9bed-b631e80d305b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7be46fdd-f73b-4edd-9bed-b631e80d305b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> I don't think that really applies in your migration
>> case, because you are definitely going to write all the memory eventually, I
>> think?
> 
> Especially with memory ballooning and things like free-page-reporting we might
> be migrating a whole bunch of zero-memory and only have to make sure that the
> destination is actually zero. We don't want to consume memory.

Ahh you know if the contents of a page being migrated is all zero. In that case,
I get it. Thanks!


