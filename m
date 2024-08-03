Return-Path: <linux-kernel+bounces-273445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275594695E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55251B20E75
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6813E04C;
	Sat,  3 Aug 2024 11:07:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F713699B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683274; cv=none; b=Mm830HeVitxCS/WDnZOZyTENWwL4AzsaxIkVIB3M63c4M5P2Vz/HlNmtcJvY/tkoPuZX2YxtfHtOVpWdIC1xAwzNPyajnjxY6YlbWb6CXrNKc4HpvyrHItEO85qwaUxICgq6lDEdVuylef7oWoCtui/mVg7HFMskJz/c9Wtfgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683274; c=relaxed/simple;
	bh=6viOHLtcWkhGEXnflPd2aer6oD7UW0DYgceSC7jjRPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3M5P0yw39RJrT8zJkJO7f6ewxUe2+kP5E9Jj+LVMjq3GGRJjznrpWhb+6Oyl+TpVSy6tdSuKlOjPNTcF3vj3I0yxGIKTT3ldiYYPDg4tnXbw160eyHhv6LE/UksqIVB0bhc8WiYQ4XZDx2zLuEojYnMGyW8oC0hYGks34z7cuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D1FDA7;
	Sat,  3 Aug 2024 04:08:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8997E3F64C;
	Sat,  3 Aug 2024 04:07:50 -0700 (PDT)
Date: Sat, 3 Aug 2024 12:07:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
Message-ID: <Zq4Pg9_BIajyXmSI@J2N7QTR9R3>
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801054436.612024-1-anshuman.khandual@arm.com>

On Thu, Aug 01, 2024 at 11:14:35AM +0530, Anshuman Khandual wrote:
> FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
> defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
> new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
> utilizes recently added macro GENMASK_U128() while also adding some helpers
> such as define_field_128() and parse_bitdef_128().
> 
> This patch applies after the following series which adds GENMASK_U128()
> 
> https://lore.kernel.org/all/20240725054808.286708-1-anshuman.khandual@arm.com/

Is that patch merged or not? It wouod make a lot more sense to send them
together as one series.

> 
> A. Example for SysregFields128
> 
> ------------------------------
> SysregFields128 TTBRx_D128_EL1
> Res0   127:88
> Field  87:80   BADDR_HIGH
> Res0   79:64
> Field  63:48   ASID
> Field  47:5    BADDR_LOW
> Res0   4:3
> Field  2:1     SKL
> Field  0       CnP
> EndSysregFields128
> ------------------------------

Ok, so we get the definitions, but do we have all the other helpers we'd
need to make that useable, i.e.

* read_sysreg() and write_sysreg() variants that can use MRRS/MSRR

* Macros for assembly to use these?

* Other bitfield manipulation helpers that can operate on U128, e.g.
  FIELD_GET() and FIELD_PREP() ?

Without end-to-end usage this is a bit academic. If the U128 definitions
are oainful to use from asm we might want separate hi64/lo64
definitions.

Mark.

> The above input generates the following macros
> 
> #define TTBRx_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
> #define TTBRx_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
> #define TTBRx_D128_EL1_BADDR_HIGH_SHIFT                 80
> #define TTBRx_D128_EL1_BADDR_HIGH_WIDTH                 8
> 
> #define TTBRx_D128_EL1_ASID                             GENMASK_U128(63, 48)
> #define TTBRx_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
> #define TTBRx_D128_EL1_ASID_SHIFT                       48
> #define TTBRx_D128_EL1_ASID_WIDTH                       16
> 
> #define TTBRx_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
> #define TTBRx_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
> #define TTBRx_D128_EL1_BADDR_LOW_SHIFT                  5
> #define TTBRx_D128_EL1_BADDR_LOW_WIDTH                  43
> 
> #define TTBRx_D128_EL1_SKL                              GENMASK_U128(2, 1)
> #define TTBRx_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
> #define TTBRx_D128_EL1_SKL_SHIFT                        1
> #define TTBRx_D128_EL1_SKL_WIDTH                        2
> 
> #define TTBRx_D128_EL1_CnP                              GENMASK_U128(0, 0)
> #define TTBRx_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
> #define TTBRx_D128_EL1_CnP_SHIFT                        0
> #define TTBRx_D128_EL1_CnP_WIDTH                        1
> 
> #define TTBRx_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
> #define TTBRx_D128_EL1_RES1                             (UL(0))
> #define TTBRx_D128_EL1_UNKN                             (UL(0))
> 
> B. Example Sysreg128
> 
> ------------------------------
> Sysreg128      TTBR1_D128_EL1  3       0       2       0       1
> Res0   127:88
> Field  87:80   BADDR_HIGH
> Res0   79:64
> Field  63:48   ASID
> Field  47:5    BADDR_LOW
> Res0   4:3
> Field  2:1     SKL
> Field  0       CnP
> EndSysreg128
> ------------------------------
> 
> The above input generates the following macros
> 
> #define REG_TTBR1_D128_EL1                              S3_0_C2_C0_1
> #define SYS_TTBR1_D128_EL1                              sys_reg(3, 0, 2, 0, 1)
> #define SYS_TTBR1_D128_EL1_Op0                          3
> #define SYS_TTBR1_D128_EL1_Op1                          0
> #define SYS_TTBR1_D128_EL1_CRn                          2
> #define SYS_TTBR1_D128_EL1_CRm                          0
> #define SYS_TTBR1_D128_EL1_Op2                          1
> 
> #define TTBR1_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
> #define TTBR1_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
> #define TTBR1_D128_EL1_BADDR_HIGH_SHIFT                 80
> #define TTBR1_D128_EL1_BADDR_HIGH_WIDTH                 8
> 
> #define TTBR1_D128_EL1_ASID                             GENMASK_U128(63, 48)
> #define TTBR1_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
> #define TTBR1_D128_EL1_ASID_SHIFT                       48
> #define TTBR1_D128_EL1_ASID_WIDTH                       16
> 
> #define TTBR1_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
> #define TTBR1_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
> #define TTBR1_D128_EL1_BADDR_LOW_SHIFT                  5
> #define TTBR1_D128_EL1_BADDR_LOW_WIDTH                  43
> 
> #define TTBR1_D128_EL1_SKL                              GENMASK_U128(2, 1)
> #define TTBR1_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
> #define TTBR1_D128_EL1_SKL_SHIFT                        1
> #define TTBR1_D128_EL1_SKL_WIDTH                        2
> 
> #define TTBR1_D128_EL1_CnP                              GENMASK_U128(0, 0)
> #define TTBR1_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
> #define TTBR1_D128_EL1_CnP_SHIFT                        0
> #define TTBR1_D128_EL1_CnP_WIDTH                        1
> 
> #define TTBR1_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
> #define TTBR1_D128_EL1_RES1                             (UL(0))
> #define TTBR1_D128_EL1_UNKN                             (UL(0))
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (1):
>   arm64/tools/sysreg: Add Sysreg128/SysregFields128
> 
>  arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
> 
> -- 
> 2.30.2
> 
> 

