Return-Path: <linux-kernel+bounces-274113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014E947384
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632A31C20AD1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B85FEE4;
	Mon,  5 Aug 2024 03:00:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B91FA1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826857; cv=none; b=T2Zk+XviTpMDgGFN0eng6YOCNCvbjs66UalaeQOLGFzLtcE4nnITA4T7Ctluw8DJLaTDzIl6HPxfGCHU6vaExnLvdVaRpCa6rIDb1jchzq10dGL4UxEVPTncSbaOusmc/NqPR0y+f0NXaJOL4ahRhAWlh3I29NRdsV502d+XROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826857; c=relaxed/simple;
	bh=dO4yTn7VmxueQ1e7vwiQliwdGTf2Ud2jnXWbX/53A5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRAeJ91zc1GhtEaTC0sQ4iqIgLulEBrFR3OZdE0spvWiLCefnbmvf+502i9ATAKDrL1fVSGh7TcJIzZX2ToABcDxaTwfB+fBivTtzL3AaESsp3Io6RvLYSFwRDIaL1D2588zNbM5LzGy/SgMVT1c/doL8Ldzq/PlbzPG71sZsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D40143D;
	Sun,  4 Aug 2024 20:01:19 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88EC3F5A1;
	Sun,  4 Aug 2024 20:00:51 -0700 (PDT)
Message-ID: <88e4f6eb-9ce5-4f52-9f4c-4511fe054b94@arm.com>
Date: Mon, 5 Aug 2024 08:30:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
 <Zq4Pg9_BIajyXmSI@J2N7QTR9R3>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zq4Pg9_BIajyXmSI@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/3/24 16:37, Mark Rutland wrote:
> On Thu, Aug 01, 2024 at 11:14:35AM +0530, Anshuman Khandual wrote:
>> FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
>> defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
>> new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
>> utilizes recently added macro GENMASK_U128() while also adding some helpers
>> such as define_field_128() and parse_bitdef_128().
>>
>> This patch applies after the following series which adds GENMASK_U128()
>>
>> https://lore.kernel.org/all/20240725054808.286708-1-anshuman.khandual@arm.com/
> 
> Is that patch merged or not? It wouod make a lot more sense to send them
> together as one series.

The latest series [1] here has been reviewed and merged in bitmap-for-next
tree for testing purpose. Also there has been an additional patch [2] just
to keep the GENMASK_U128() helpers inside !__ASSEMBLY__ guard.

[1] https://lore.kernel.org/all/20240801071646.682731-1-anshuman.khandual@arm.com/
[2] https://lore.kernel.org/all/20240803133753.1598137-1-yury.norov@gmail.com/

GENMASK_U128() series could have been part of this series, although 128 bit
mask creation seems generic enough to stand on its own.

> 
>>
>> A. Example for SysregFields128
>>
>> ------------------------------
>> SysregFields128 TTBRx_D128_EL1
>> Res0   127:88
>> Field  87:80   BADDR_HIGH
>> Res0   79:64
>> Field  63:48   ASID
>> Field  47:5    BADDR_LOW
>> Res0   4:3
>> Field  2:1     SKL
>> Field  0       CnP
>> EndSysregFields128
>> ------------------------------
> 
> Ok, so we get the definitions, but do we have all the other helpers we'd
> need to make that useable, i.e.

The first objective was to get the definitions right, so that they could
be stored in the new gcc __unit128 data type.

> 
> * read_sysreg() and write_sysreg() variants that can use MRRS/MSRR
> 
> * Macros for assembly to use these?
> 
> * Other bitfield manipulation helpers that can operate on U128, e.g.
>   FIELD_GET() and FIELD_PREP() ?

These are still work in progress, but will share when available.

> 
> Without end-to-end usage this is a bit academic. If the U128 definitions
> are oainful to use from asm we might want separate hi64/lo64
> definitions.

Right, U128 definitions are difficult to use in asm code because they way
gcc compiler deals with 128 bit data types. Should the separate hi64/lo64
definitions be generic or platform specific without adding them to kernel
bitops ?

> 
> Mark.
> 
>> The above input generates the following macros
>>
>> #define TTBRx_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
>> #define TTBRx_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
>> #define TTBRx_D128_EL1_BADDR_HIGH_SHIFT                 80
>> #define TTBRx_D128_EL1_BADDR_HIGH_WIDTH                 8
>>
>> #define TTBRx_D128_EL1_ASID                             GENMASK_U128(63, 48)
>> #define TTBRx_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
>> #define TTBRx_D128_EL1_ASID_SHIFT                       48
>> #define TTBRx_D128_EL1_ASID_WIDTH                       16
>>
>> #define TTBRx_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
>> #define TTBRx_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
>> #define TTBRx_D128_EL1_BADDR_LOW_SHIFT                  5
>> #define TTBRx_D128_EL1_BADDR_LOW_WIDTH                  43
>>
>> #define TTBRx_D128_EL1_SKL                              GENMASK_U128(2, 1)
>> #define TTBRx_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
>> #define TTBRx_D128_EL1_SKL_SHIFT                        1
>> #define TTBRx_D128_EL1_SKL_WIDTH                        2
>>
>> #define TTBRx_D128_EL1_CnP                              GENMASK_U128(0, 0)
>> #define TTBRx_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
>> #define TTBRx_D128_EL1_CnP_SHIFT                        0
>> #define TTBRx_D128_EL1_CnP_WIDTH                        1
>>
>> #define TTBRx_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
>> #define TTBRx_D128_EL1_RES1                             (UL(0))
>> #define TTBRx_D128_EL1_UNKN                             (UL(0))
>>
>> B. Example Sysreg128
>>
>> ------------------------------
>> Sysreg128      TTBR1_D128_EL1  3       0       2       0       1
>> Res0   127:88
>> Field  87:80   BADDR_HIGH
>> Res0   79:64
>> Field  63:48   ASID
>> Field  47:5    BADDR_LOW
>> Res0   4:3
>> Field  2:1     SKL
>> Field  0       CnP
>> EndSysreg128
>> ------------------------------
>>
>> The above input generates the following macros
>>
>> #define REG_TTBR1_D128_EL1                              S3_0_C2_C0_1
>> #define SYS_TTBR1_D128_EL1                              sys_reg(3, 0, 2, 0, 1)
>> #define SYS_TTBR1_D128_EL1_Op0                          3
>> #define SYS_TTBR1_D128_EL1_Op1                          0
>> #define SYS_TTBR1_D128_EL1_CRn                          2
>> #define SYS_TTBR1_D128_EL1_CRm                          0
>> #define SYS_TTBR1_D128_EL1_Op2                          1
>>
>> #define TTBR1_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
>> #define TTBR1_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
>> #define TTBR1_D128_EL1_BADDR_HIGH_SHIFT                 80
>> #define TTBR1_D128_EL1_BADDR_HIGH_WIDTH                 8
>>
>> #define TTBR1_D128_EL1_ASID                             GENMASK_U128(63, 48)
>> #define TTBR1_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
>> #define TTBR1_D128_EL1_ASID_SHIFT                       48
>> #define TTBR1_D128_EL1_ASID_WIDTH                       16
>>
>> #define TTBR1_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
>> #define TTBR1_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
>> #define TTBR1_D128_EL1_BADDR_LOW_SHIFT                  5
>> #define TTBR1_D128_EL1_BADDR_LOW_WIDTH                  43
>>
>> #define TTBR1_D128_EL1_SKL                              GENMASK_U128(2, 1)
>> #define TTBR1_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
>> #define TTBR1_D128_EL1_SKL_SHIFT                        1
>> #define TTBR1_D128_EL1_SKL_WIDTH                        2
>>
>> #define TTBR1_D128_EL1_CnP                              GENMASK_U128(0, 0)
>> #define TTBR1_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
>> #define TTBR1_D128_EL1_CnP_SHIFT                        0
>> #define TTBR1_D128_EL1_CnP_WIDTH                        1
>>
>> #define TTBR1_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
>> #define TTBR1_D128_EL1_RES1                             (UL(0))
>> #define TTBR1_D128_EL1_UNKN                             (UL(0))
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Anshuman Khandual (1):
>>   arm64/tools/sysreg: Add Sysreg128/SysregFields128
>>
>>  arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
>>  1 file changed, 231 insertions(+)
>>
>> -- 
>> 2.30.2
>>
>>

