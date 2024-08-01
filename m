Return-Path: <linux-kernel+bounces-270647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5279442C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C72283F60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B314E2CF;
	Thu,  1 Aug 2024 05:44:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47934140366
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491088; cv=none; b=ihQx3hoDs6Ux/PqDNjERLRIwKbpAwDTYOOSpDVJi3feoweqyHJmbePs9w45SpxBF9iSmhtTcKwT67SQ57EMv/sJrQVmjOtKocQIGbDKteV6ezvLo1DLYoDiVg6bQmgQrtuupFd5YJv2MgMkvrOsmd+Nl2Hr0sfsT8O0RMkOA0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491088; c=relaxed/simple;
	bh=MyHFRI61GLx/8ItkO4Jc8s2ZQ9D9Xg6+3ZvMjS1wtNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TODX7e62iWOBxbD/VDgm635xK6uAyRd92UB3OdHBjYDK3WPcUm6xAVYNHRhpsUc2PRnODkxjsjLyseYtadGxdUlKUx1VEWrIdrOYl2Cfs4sFDqhsjpjgllDuAIUQAYKbM+TKQzZ5ze0m92PROJMsBzhO7C2GDcDE1ZuDbD7HdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D311007;
	Wed, 31 Jul 2024 22:45:09 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD3053F5A1;
	Wed, 31 Jul 2024 22:44:41 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
Date: Thu,  1 Aug 2024 11:14:35 +0530
Message-Id: <20240801054436.612024-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_SYSREG128 enables 128 bit wide system registers which also need to be
defined in (arch/arm64/toos/sysreg) for auto mask generation. This adds two
new field types i.e Sysreg128 and SysregFields128 for that same purpose. It
utilizes recently added macro GENMASK_U128() while also adding some helpers
such as define_field_128() and parse_bitdef_128().

This patch applies after the following series which adds GENMASK_U128()

https://lore.kernel.org/all/20240725054808.286708-1-anshuman.khandual@arm.com/

A. Example for SysregFields128

------------------------------
SysregFields128 TTBRx_D128_EL1
Res0   127:88
Field  87:80   BADDR_HIGH
Res0   79:64
Field  63:48   ASID
Field  47:5    BADDR_LOW
Res0   4:3
Field  2:1     SKL
Field  0       CnP
EndSysregFields128
------------------------------

The above input generates the following macros

#define TTBRx_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
#define TTBRx_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
#define TTBRx_D128_EL1_BADDR_HIGH_SHIFT                 80
#define TTBRx_D128_EL1_BADDR_HIGH_WIDTH                 8

#define TTBRx_D128_EL1_ASID                             GENMASK_U128(63, 48)
#define TTBRx_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
#define TTBRx_D128_EL1_ASID_SHIFT                       48
#define TTBRx_D128_EL1_ASID_WIDTH                       16

#define TTBRx_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
#define TTBRx_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
#define TTBRx_D128_EL1_BADDR_LOW_SHIFT                  5
#define TTBRx_D128_EL1_BADDR_LOW_WIDTH                  43

#define TTBRx_D128_EL1_SKL                              GENMASK_U128(2, 1)
#define TTBRx_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
#define TTBRx_D128_EL1_SKL_SHIFT                        1
#define TTBRx_D128_EL1_SKL_WIDTH                        2

#define TTBRx_D128_EL1_CnP                              GENMASK_U128(0, 0)
#define TTBRx_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
#define TTBRx_D128_EL1_CnP_SHIFT                        0
#define TTBRx_D128_EL1_CnP_WIDTH                        1

#define TTBRx_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
#define TTBRx_D128_EL1_RES1                             (UL(0))
#define TTBRx_D128_EL1_UNKN                             (UL(0))

B. Example Sysreg128

------------------------------
Sysreg128      TTBR1_D128_EL1  3       0       2       0       1
Res0   127:88
Field  87:80   BADDR_HIGH
Res0   79:64
Field  63:48   ASID
Field  47:5    BADDR_LOW
Res0   4:3
Field  2:1     SKL
Field  0       CnP
EndSysreg128
------------------------------

The above input generates the following macros

#define REG_TTBR1_D128_EL1                              S3_0_C2_C0_1
#define SYS_TTBR1_D128_EL1                              sys_reg(3, 0, 2, 0, 1)
#define SYS_TTBR1_D128_EL1_Op0                          3
#define SYS_TTBR1_D128_EL1_Op1                          0
#define SYS_TTBR1_D128_EL1_CRn                          2
#define SYS_TTBR1_D128_EL1_CRm                          0
#define SYS_TTBR1_D128_EL1_Op2                          1

#define TTBR1_D128_EL1_BADDR_HIGH                       GENMASK_U128(87, 80)
#define TTBR1_D128_EL1_BADDR_HIGH_MASK                  GENMASK_U128(87, 80)
#define TTBR1_D128_EL1_BADDR_HIGH_SHIFT                 80
#define TTBR1_D128_EL1_BADDR_HIGH_WIDTH                 8

#define TTBR1_D128_EL1_ASID                             GENMASK_U128(63, 48)
#define TTBR1_D128_EL1_ASID_MASK                        GENMASK_U128(63, 48)
#define TTBR1_D128_EL1_ASID_SHIFT                       48
#define TTBR1_D128_EL1_ASID_WIDTH                       16

#define TTBR1_D128_EL1_BADDR_LOW                        GENMASK_U128(47, 5)
#define TTBR1_D128_EL1_BADDR_LOW_MASK                   GENMASK_U128(47, 5)
#define TTBR1_D128_EL1_BADDR_LOW_SHIFT                  5
#define TTBR1_D128_EL1_BADDR_LOW_WIDTH                  43

#define TTBR1_D128_EL1_SKL                              GENMASK_U128(2, 1)
#define TTBR1_D128_EL1_SKL_MASK                         GENMASK_U128(2, 1)
#define TTBR1_D128_EL1_SKL_SHIFT                        1
#define TTBR1_D128_EL1_SKL_WIDTH                        2

#define TTBR1_D128_EL1_CnP                              GENMASK_U128(0, 0)
#define TTBR1_D128_EL1_CnP_MASK                         GENMASK_U128(0, 0)
#define TTBR1_D128_EL1_CnP_SHIFT                        0
#define TTBR1_D128_EL1_CnP_WIDTH                        1

#define TTBR1_D128_EL1_RES0                             (UL(0) | GENMASK_U128(127, 88) | GENMASK_U128(79, 64) | GENMASK_U128(4, 3))
#define TTBR1_D128_EL1_RES1                             (UL(0))
#define TTBR1_D128_EL1_UNKN                             (UL(0))

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (1):
  arm64/tools/sysreg: Add Sysreg128/SysregFields128

 arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

-- 
2.30.2


