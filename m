Return-Path: <linux-kernel+bounces-256181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED2F934A57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0865D287B49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722713D296;
	Thu, 18 Jul 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9VmuhPM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5413D28C;
	Thu, 18 Jul 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292352; cv=none; b=MqdW304PdW8vQoR9Bcjh6pKCctMTki+wFu9u0ocW8TNBFeTaxBo/yC+Kq5DJvkPNktgZnILsKjirh2rc1UbmystdmuIYLjOKHZ5xfIvlCYb4qXD3ILcTjWExp2Jv8EK6tWMxcHylRYFjAhAOhH1tR6UyspnVqAAn2TXcW7LDico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292352; c=relaxed/simple;
	bh=TIkhi2pqqg1IeJytFz4NUjzrerffYkCAMyFt65KPyfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFd+zPhgijBRsYci1uGnF1Yyn2zHCHoV1NaulvaNd8YVi+JP+Q9/zxwduqEx6+Zoj0GIYE65NH68EMo+f7069CQlRaIeXk5rKDsFXGTlDa2O8OdZ8+5sDQiOncIVgvvA5e3Nf1uyhx5Vs2g32pkffjSShmOisRuTmlTyzzF/b/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9VmuhPM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I7Srwm010837;
	Thu, 18 Jul 2024 08:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=VquK3ZyPNFnh8
	Sj1WjWWeNCy8O6TUdI3j7i+mDWa8yw=; b=U9VmuhPMso1/3EQMPYkqmv5haGogo
	uf5+2gYw2t7+fqgxzqkCDEod9XDuSWDjUFJMJK/0QVFTevK0g2wi0KodFDFwt5qH
	LtC4AcFpXChKXvHEQSN4Dam59EIIOrhVTpqNVGVuDY9Cj6HlColwvLhtxTVTkLcf
	fdWRzKdZqSbMg0UAtG3mONlWCExn8cmC7eHmaekh7riBqM0aKd9MfJn/4YOQyPPL
	cEu160zAfEok8exkVga4zl9XPnkbcwYf8AdrlKBF5Ey16s8VoBKC4JJJT3uuL1Sy
	X16T8j4jFL40dx4OJwdl+8/SkmVR69OieoMVdnv6SdAjb9kLeysMyCb+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expp05au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:45:40 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I8jds3024995;
	Thu, 18 Jul 2024 08:45:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expp05as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:45:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I58FX1005925;
	Thu, 18 Jul 2024 08:45:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkn8rjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 08:45:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I8jXSr52101436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 08:45:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200F520040;
	Thu, 18 Jul 2024 08:45:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC5F420063;
	Thu, 18 Jul 2024 08:45:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.69.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 08:45:29 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V8 12/15] tools/perf: Make capstone_init non-static so that it can be used during symbol disassemble
Date: Thu, 18 Jul 2024 14:13:55 +0530
Message-Id: <20240718084358.72242-13-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240718084358.72242-1-atrajeev@linux.vnet.ibm.com>
References: <20240718084358.72242-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Td4QakQLW422WsylqXJhcyDYnT0OzMPB
X-Proofpoint-GUID: Dmi7EdTC8r4d_lZzfGVwoYuK5wRFo2zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_04,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=963 spamscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180054

symbol__disassemble_capstone in util/disasm.c calls function
open_capstone_handle to open/init the capstone. We already have a
capstone_init function in "util/print_insn.c". But capstone_init
is defined as a static function in util/print_insn.c. Change this and
also add the function in print_insn.h

The open_capstone_handle checks the disassembler_style option from
annotation_options to decide whether to set CS_OPT_SYNTAX_ATT.
Add that logic in capstone_init also and by default set it to true.

Reviewed-and-tested-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/print_insn.c | 12 +++++++++---
 tools/perf/util/print_insn.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index a950e9157d2d..a76aae81d7a0 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -32,7 +32,7 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
 
-static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
+int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style)
 {
 	cs_arch arch;
 	cs_mode mode;
@@ -62,7 +62,13 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64)
 	}
 
 	if (machine__normalized_is(machine, "x86")) {
-		cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+		/*
+		 * In case of using capstone_init while symbol__disassemble
+		 * setting CS_OPT_SYNTAX_ATT depends if disassembler_style opts
+		 * is set via annotation args
+		 */
+		if (disassembler_style)
+			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
 		/*
 		 * Resolving address operands to symbols is implemented
 		 * on x86 by investigating instruction details.
@@ -122,7 +128,7 @@ ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpum
 	int ret;
 
 	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle, is64bit);
+	ret = capstone_init(machine, &cs_handle, is64bit, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..2c8ee41c4a5d 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -19,4 +19,9 @@ ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpum
 			 bool is64bit, const uint8_t *code, size_t code_size,
 			 uint64_t ip, int *lenp, int print_opts, FILE *fp);
 
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+#include <capstone/capstone.h>
+int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style);
+#endif
+
 #endif /* PERF_PRINT_INSN_H */
-- 
2.43.0


