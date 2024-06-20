Return-Path: <linux-kernel+bounces-222867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08AD9108DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FCFB22173
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD031AE08B;
	Thu, 20 Jun 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQ89sfEU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95A19B3E1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894884; cv=none; b=dN7itlWrKf5ZBC63GG8VIImnCzNUYgexrnIst7kx+Dsfpe3W+8G+OUHcJ3J0bjwZR3f++8CTuLXLRpiKAm7ySntof2cwKbHTnvhMxwEP213x/Jt63HQHzgp68BvFoUnoAUswW39xT7n8/rLjlqyAIL7RquvG/w/pS86b7+B6zHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894884; c=relaxed/simple;
	bh=/zf8QngZ3hyImBN4WDegCVS0Lx4ZiaoGVJ7Pg5Z+G4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhmTwlAdhvrzp1xETp4Xn9GEf7QUuc7eW2zrigAKbWOc8VEvneOMpDhBh4NgRpRD4keEziTEHU79UGtpecGQasAfVe/5xgnbzEjblZGMe1qUfgPsx1Ac/jlOWcy1TfYdi7bXbaDRH6jA+sN8/bvbDP+Y8y0k8pbBpSEOfXHznCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JQ89sfEU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KEHvYx002253;
	Thu, 20 Jun 2024 14:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=Ve4J55T171tf8H
	tnHWyHJ1FgHOgS8+lZXPB68rADmJo=; b=JQ89sfEU3wFWWHzboUzLenlxC39Gbe
	Ba4CrJsgI2X21n7uoqYHT9kKwzNiiM71F2TV1JBPNBndDjhSyw6IOHfJszai45Rj
	y1/Iwq3paNpGvB+nkpggDJdvosvjimBEuPFMDO/eBOlx/pkFVbeISueFikc50xbZ
	z8pcsIy1Rx2Vqr2ATkKO+0fDJnTQXSfBOUYs22Y+A6K/OiQ5PsSHkONCRnYsjbmR
	7G+d3OI1Bgz6hWztODyrhWc0gwOBrKVNVVomGUJO+RG5+IbvstG5WTpb26OP6t+O
	AKzRoWxiPKaioYOeF4fiBIKiA21dfywhErQdWu4YaAVKSyvV3c2Uv6Sw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja0kdkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:47:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KDgQcO029466;
	Thu, 20 Jun 2024 14:47:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1day6gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 14:47:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45KEj5iT009206;
	Thu, 20 Jun 2024 14:47:49 GMT
Received: from laptop-dell-latitude7430.nl.oracle.com (dhcp-10-175-53-155.vpn.oracle.com [10.175.53.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1day6fh-1;
	Thu, 20 Jun 2024 14:47:49 +0000
From: Alexandre Chartre <alexandre.chartre@oracle.com>
To: linux-kernel@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org
Cc: alexandre.chartre@oracle.com
Subject: [PATCH V2 RESEND] objtool/x86: objtool can confuse memory and stack access
Date: Thu, 20 Jun 2024 16:47:47 +0200
Message-Id: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=881 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200105
X-Proofpoint-ORIG-GUID: sLEr4ST4lUEtUvM5CX2CgP5oUiOUMiud
X-Proofpoint-GUID: sLEr4ST4lUEtUvM5CX2CgP5oUiOUMiud

The encoding of an x86 instruction can include a ModR/M and a SIB
(Scale-Index-Base) byte to describe the addressing mode of the
instruction.

objtool processes all addressing mode with a SIB base of 5 as having
%rbp as the base register. However, a SIB base of 5 means that the
effective address has either no base (if ModR/M mod is zero) or %rbp
as the base (if ModR/M mod is 1 or 2). This can cause objtool to confuse
an absolute address access with a stack operation.

For example, objtool will see the following instruction:

 4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12

as a stack operation (i.e. similar to: mov -0x20(%rbp), %r12).

[Note that this kind of weird absolute address access is added by the
 compiler when using KASAN.]

If this perceived stack operation happens to reference the location
where %r12 was pushed on the stack then the objtool validation will
think that %r12 is being restored and this can cause a stack state
mismatch.

This kind behavior was seen on xfs code, after a minor change (convert
kmem_alloc() to kmalloc()):

>> fs/xfs/xfs.o: warning: objtool: xfs_da_grow_inode_int+0x6c1: stack state mismatch: reg1[12]=-2-48 reg2[12]=-1+0

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402220435.MGN0EV6l-lkp@intel.com/
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3a1d80a7878d3..5872818b8930c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -125,8 +125,14 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 #define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
 #define have_SIB() ((modrm_rm & 7) == CFI_SP && mod_is_mem())
 
+/*
+ * Check the ModRM register. If there is a SIB byte then check with
+ * the SIB base register. But if the SIB base is 5 (i.e. CFI_BP) and
+ * ModRM mod is 0 then there is no base register.
+ */
 #define rm_is(reg) (have_SIB() ? \
-		    sib_base == (reg) && sib_index == CFI_SP : \
+		    sib_base == (reg) && sib_index == CFI_SP && \
+		    (sib_base != CFI_BP || modrm_mod != 0):	\
 		    modrm_rm == (reg))
 
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
-- 
2.39.3


