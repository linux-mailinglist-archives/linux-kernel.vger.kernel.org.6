Return-Path: <linux-kernel+bounces-270648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA1D9442C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310661F22A05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9EA14EC66;
	Thu,  1 Aug 2024 05:44:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D214C58E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722491090; cv=none; b=dygYFkFDxJbOYG+IivU8IYhZPP3EYL0Xd48CToBIs69ePMXPwp7V7RxV8GpEaCmS4hwX6yEu01LY5e62cKIjVUCxB96AFQbspnT/doVxzeBEO4GbFywpepPc19zYXUDAKqwvBNRK+hpRuPP7w/cZsh3UKNe8YjBXYhTa5MPmhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722491090; c=relaxed/simple;
	bh=0lZftV0DbhSmGhAjLNzyFgVYbeGgP5GK8F7XjXp8ch4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNJE3CXXk3geQvCMk7C4NqGshUekQnnI7UnSVX6s30S0nwA6EKBQA7Ql+7AVFRpsYLW4Y2/y4lBmO1EmxcWFboHg5LVw/hQTg/hRPnX6Q/L02O3xi1TpHlgUIWDwO0fjx/IvPWSnsJRBAqzJPkbM1ZMqzztPjAyIse2J7PQuFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C08351063;
	Wed, 31 Jul 2024 22:45:12 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE2443F5A1;
	Wed, 31 Jul 2024 22:44:44 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64/tools/sysreg: Add Sysreg128/SysregFields128
Date: Thu,  1 Aug 2024 11:14:36 +0530
Message-Id: <20240801054436.612024-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801054436.612024-1-anshuman.khandual@arm.com>
References: <20240801054436.612024-1-anshuman.khandual@arm.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/gen-sysreg.awk | 231 ++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/arch/arm64/tools/gen-sysreg.awk b/arch/arm64/tools/gen-sysreg.awk
index d1254a056114..a1571881d1c3 100755
--- a/arch/arm64/tools/gen-sysreg.awk
+++ b/arch/arm64/tools/gen-sysreg.awk
@@ -56,6 +56,13 @@ function define_field(reg, field, msb, lsb) {
 	define(reg "_" field "_WIDTH", msb - lsb + 1)
 }
 
+function define_field_128(reg, field, msb, lsb) {
+	define(reg "_" field, "GENMASK_U128(" msb ", " lsb ")")
+	define(reg "_" field "_MASK", "GENMASK_U128(" msb ", " lsb ")")
+	define(reg "_" field "_SHIFT", lsb)
+	define(reg "_" field "_WIDTH", msb - lsb + 1)
+}
+
 # Print a field _SIGNED definition for a field
 function define_field_sign(reg, field, sign) {
 	define(reg "_" field "_SIGNED", sign)
@@ -89,6 +96,33 @@ function parse_bitdef(reg, field, bitdef, _bits)
 	next_bit = lsb - 1
 }
 
+function parse_bitdef_128(reg, field, bitdef, _bits)
+{
+	if (bitdef ~ /^[0-9]+$/) {
+		msb = bitdef
+		lsb = bitdef
+	} else if (split(bitdef, _bits, ":") == 2) {
+		msb = _bits[1]
+		lsb = _bits[2]
+	} else {
+		fatal("invalid bit-range definition '" bitdef "'")
+	}
+
+
+	if (msb != next_bit)
+		fatal(reg "." field " starts at " msb " not " next_bit)
+	if (127 < msb || msb < 0)
+		fatal(reg "." field " invalid high bit in '" bitdef "'")
+	if (127 < lsb || lsb < 0)
+		fatal(reg "." field " invalid low bit in '" bitdef "'")
+	if (msb < lsb)
+		fatal(reg "." field " invalid bit-range '" bitdef "'")
+	if (low > high)
+		fatal(reg "." field " has invalid range " high "-" low)
+
+	next_bit = lsb - 1
+}
+
 BEGIN {
 	print "#ifndef __ASM_SYSREG_DEFS_H"
 	print "#define __ASM_SYSREG_DEFS_H"
@@ -111,6 +145,99 @@ END {
 /^$/ { next }
 /^[\t ]*#/ { next }
 
+/^SysregFields128/ && block_current() == "Root" {
+	block_push("SysregFields128")
+
+	expect_fields(2)
+
+	reg = $2
+
+	res0 = "UL(0)"
+	res1 = "UL(0)"
+	unkn = "UL(0)"
+
+	next_bit = 127
+
+	next
+}
+
+/^EndSysregFields128/ && block_current() == "SysregFields128" {
+	if (next_bit > 0)
+		fatal("Unspecified bits in " reg)
+
+	define(reg "_RES0", "(" res0 ")")
+	define(reg "_RES1", "(" res1 ")")
+	define(reg "_UNKN", "(" unkn ")")
+	print ""
+
+	reg = null
+	res0 = null
+	res1 = null
+	unkn = null
+
+	block_pop()
+	next
+}
+
+/^Sysreg128/ && block_current() == "Root" {
+	block_push("Sysreg128")
+
+	expect_fields(7)
+
+	reg = $2
+	op0 = $3
+	op1 = $4
+	crn = $5
+	crm = $6
+	op2 = $7
+
+	res0 = "UL(0)"
+	res1 = "UL(0)"
+	unkn = "UL(0)"
+
+	define("REG_" reg, "S" op0 "_" op1 "_C" crn "_C" crm "_" op2)
+	define("SYS_" reg, "sys_reg(" op0 ", " op1 ", " crn ", " crm ", " op2 ")")
+
+	define("SYS_" reg "_Op0", op0)
+	define("SYS_" reg "_Op1", op1)
+	define("SYS_" reg "_CRn", crn)
+	define("SYS_" reg "_CRm", crm)
+	define("SYS_" reg "_Op2", op2)
+
+	print ""
+
+	next_bit = 127
+
+	next
+}
+
+/^EndSysreg128/ && block_current() == "Sysreg128" {
+	if (next_bit > 0)
+		fatal("Unspecified bits in " reg)
+
+	if (res0 != null)
+		define(reg "_RES0", "(" res0 ")")
+	if (res1 != null)
+		define(reg "_RES1", "(" res1 ")")
+	if (unkn != null)
+		define(reg "_UNKN", "(" unkn ")")
+	if (res0 != null || res1 != null || unkn != null)
+		print ""
+
+	reg = null
+	op0 = null
+	op1 = null
+	crn = null
+	crm = null
+	op2 = null
+	res0 = null
+	res1 = null
+	unkn = null
+
+	block_pop()
+	next
+}
+
 /^SysregFields/ && block_current() == "Root" {
 	block_push("SysregFields")
 
@@ -223,6 +350,22 @@ END {
 	next
 }
 
+/^Fields/ && block_current() == "Sysreg128" {
+	expect_fields(2)
+
+	if (next_bit != 127)
+		fatal("Some fields already defined for " reg)
+
+	print "/* For " reg " fields see " $2 " */"
+	print ""
+
+        next_bit = 0
+	res0 = null
+	res1 = null
+	unkn = null
+
+	next
+}
 
 /^Res0/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
@@ -234,6 +377,16 @@ END {
 	next
 }
 
+/^Res0/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	expect_fields(2)
+	parse_bitdef_128(reg, "RES0", $2)
+	field = "RES0_" msb "_" lsb
+
+	res0 = res0 " | GENMASK_U128(" msb ", " lsb ")"
+
+	next
+}
+
 /^Res1/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, "RES1", $2)
@@ -244,6 +397,16 @@ END {
 	next
 }
 
+/^Res1/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	expect_fields(2)
+	parse_bitdef_128(reg, "RES1", $2)
+	field = "RES1_" msb "_" lsb
+
+	res1 = res1 " | GENMASK_U128(" msb ", " lsb ")"
+
+	next
+}
+
 /^Unkn/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, "UNKN", $2)
@@ -254,6 +417,16 @@ END {
 	next
 }
 
+/^Unkn/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	expect_fields(2)
+	parse_bitdef_128(reg, "UNKN", $2)
+	field = "UNKN_" msb "_" lsb
+
+	unkn = unkn " | GENMASK_U128(" msb ", " lsb ")"
+
+	next
+}
+
 /^Field/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(3)
 	field = $3
@@ -265,6 +438,17 @@ END {
 	next
 }
 
+/^Field/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	expect_fields(3)
+	field = $3
+	parse_bitdef_128(reg, field, $2)
+
+	define_field_128(reg, field, msb, lsb)
+	print ""
+
+	next
+}
+
 /^Raz/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	expect_fields(2)
 	parse_bitdef(reg, field, $2)
@@ -272,6 +456,14 @@ END {
 	next
 }
 
+/^Raz/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	expect_fields(2)
+	parse_bitdef_128(reg, field, $2)
+
+	next
+}
+
+
 /^SignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	block_push("Enum")
 
@@ -285,6 +477,19 @@ END {
 	next
 }
 
+/^SignedEnum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	block_push("Enum")
+
+	expect_fields(3)
+	field = $3
+	parse_bitdef_128(reg, field, $2)
+
+	define_field_128(reg, field, msb, lsb)
+	define_field_sign(reg, field, "true")
+
+	next
+}
+
 /^UnsignedEnum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	block_push("Enum")
 
@@ -298,6 +503,20 @@ END {
 	next
 }
 
+/^UnsignedEnum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	block_push("Enum")
+
+	expect_fields(3)
+	field = $3
+	parse_bitdef_128(reg, field, $2)
+
+	define_field_128(reg, field, msb, lsb)
+	define_field_sign(reg, field, "false")
+
+	next
+}
+
+
 /^Enum/ && (block_current() == "Sysreg" || block_current() == "SysregFields") {
 	block_push("Enum")
 
@@ -310,6 +529,18 @@ END {
 	next
 }
 
+/^Enum/ && (block_current() == "Sysreg128" || block_current() == "SysregFields128") {
+	block_push("Enum")
+
+	expect_fields(3)
+	field = $3
+	parse_bitdef_128(reg, field, $2)
+
+	define_field_128(reg, field, msb, lsb)
+
+	next
+}
+
 /^EndEnum/ && block_current() == "Enum" {
 
 	field = null
-- 
2.30.2


