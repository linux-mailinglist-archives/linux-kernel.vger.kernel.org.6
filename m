Return-Path: <linux-kernel+bounces-274144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17C9473E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8527DB20B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC5313D52F;
	Mon,  5 Aug 2024 03:27:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05913D530
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828461; cv=none; b=QLULtGCQaQjtQPAOEsICz0nHVb9zKEtPA5o6Vk9xStnDOk0UtGBsVVE5+UOpi6aGyymuz5vWBBku0b7FbMV7hhNYftKQ4LOlUiVrMmzf4+A5omRWuRAgpZMtjVUTfFRBHyvHeYdDiZabPufTPI1qX3ce8qKNzJfx+x8Yh3qzclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828461; c=relaxed/simple;
	bh=hMHYsXg/nspvbDtmdihyNeNJ8UPV1Kbx4N8e0Mab0FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl5qqxOARTyd6XnGowD4n0bX2rZFLEYiKUcZJ0h8vB1gQgFHiCxOMZ5tCtrQe2DgEEz58ZsHCGQmV0kOZ5HKE8hxraKIWWM8XLByHX/eCNcVZac+XRV7S3DG+cDJ12qyXfsiEWJescaDjrqT7AHZYjhPIkl0BQd8mmnpy6u4bfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14829143D;
	Sun,  4 Aug 2024 20:28:04 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3398C3F5A1;
	Sun,  4 Aug 2024 20:27:35 -0700 (PDT)
Message-ID: <8a25787d-6684-450b-bb1c-f6b5e84fbd4e@arm.com>
Date: Mon, 5 Aug 2024 08:57:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
 <20240801054436.612024-2-anshuman.khandual@arm.com>
 <Zq4QuLbGkXQvhbB0@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zq4QuLbGkXQvhbB0@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/24 16:42, Mark Rutland wrote:
> On Thu, Aug 01, 2024 at 11:14:36AM +0530, Anshuman Khandual wrote:
>> FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
>> defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
>> new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
>> utilizes recently added macro GENMASK_U128() while also adding some helpers
>> such as define_field_128() and parse_bitdef_128().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
> Having Sysreg128 and SysregFields128 sounds reasonable, though I suspect
> we can share more code with Sysreg and SysregFields (e.g. by always
> using GENMASK128() even for regular SYsreg and SysregFIilds).

GENMASK_U128() should deliver same bit masks that could be used instead
of earlier GENMASK_ULL() bit masks. Sounds good.

> 
> Regardless of this patch in particular, I think we want to see some
> end-to-end usage (i.e. some actual bit definitions, along with asm and C
> code that uses these definitions) so that we're confident this is the
> right way to capture these definitions.
> 
> Sending this piecemeal, separate to those elements and sepate to
> GENMASK_U128() makes this very painful to review effectively. Please
> combine those elements into a single series so that reviewers can see
> the entire picture.

Sure, will try and combine the elements as as much possible.

