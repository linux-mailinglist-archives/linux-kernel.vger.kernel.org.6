Return-Path: <linux-kernel+bounces-235589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C538D91D717
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F4E1F228F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E843156;
	Mon,  1 Jul 2024 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p0gIe65p"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112B8528F;
	Mon,  1 Jul 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808538; cv=none; b=plFACKkRzWSP1G+y7QW2b3g3apsoGB4B2kMYTRylKp5ri3eRCBteUh49K6hr84I8xoiEI91AYE/ImA1NdbPvH2hkwwUioGuDV29oGBV9jM2xnl8PT/GeryRntu1SEK3JnD5UmN3bhhbnV0iWrbDmf9JQJMLgbqXOWeiE1zDRy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808538; c=relaxed/simple;
	bh=A7kXMZomO+PakCSLiaVmys+ikdayVPeBpXMxOOOffsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5MVv30PFKg+JT7PA/TSGV2sZIChx+YXMEuEj7ggyAE7h6Ci3tzKEV0bYvEiyg5NNNMcDJiCukBAHLp5LXZoSqeqH6OwN/JngUGh8xi2VdROtS1WCAF8jD8+VZjcR1VUzmKmhgGEeCr5ZqrQarhKdfLRMKK0lVnur4H/zJFO/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p0gIe65p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4613SU13026058;
	Mon, 1 Jul 2024 04:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=U2IL2919KkrFU
	aGA79tDike/H5UpnOCpNlhh3wu8VjI=; b=p0gIe65psukMZAHrOWYVu0BzDLaH6
	DSy05MY7K8U/PV2luLE7t5vdfMEUh3ha9upcIqQZ9aEOOxJuj2Tc6964GIO2vYFM
	Gnl7JQ3dk39GuZjH84ylOrNj7sByoweOsHIv0fG89iV24R/uOx3AtcNUEGUHPRrA
	PFmcne6ZQLLoeNL2U3Rvz4eZX9yWlLWcPwWJeyHzCbZd2/24TtOsboutLKQaxOvn
	HA50JIVISGDyuAEVwQtnZ7WzV13Fdf3Iq6eDe06sHp4ZSRw38tNWOAZTm7wuonFN
	Oa24rAthGC9sesxLbVLzUXQbPGof/Ves6JJ6iA1HRuFYfuJrppp/ZmbXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403mk1g50x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:27 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4614ZRB9030543;
	Mon, 1 Jul 2024 04:35:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403mk1g50v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46115CEX009515;
	Mon, 1 Jul 2024 04:35:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtmd42w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:35:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4614ZLUN45285794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 04:35:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45AD2004B;
	Mon,  1 Jul 2024 04:35:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2964320040;
	Mon,  1 Jul 2024 04:35:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.21.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 04:35:17 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V5 14/17] tools/perf: Add support to use libcapstone in powerpc
Date: Mon,  1 Jul 2024 10:04:27 +0530
Message-Id: <20240701043430.66666-15-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
References: <20240701043430.66666-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 487ZShsDnzLj_uxFiuen6_YwHuW-G3jN
X-Proofpoint-ORIG-GUID: nYSA9pwOtWdsBQU57i47WC-OcPEDjjgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_03,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=881 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010030

Now perf uses the capstone library to disassemble the instructions in
x86. capstone is used (if available) for perf annotate to speed up.
Currently it only supports x86 architecture. Patch includes changes to
enable this in powerpc. For now, only for data type sort keys, this
method is used and only binary code (raw instruction) is read. This is
because powerpc approach to understand instructions and reg fields uses
raw instruction. The "cs_disasm" is currently not enabled. While
attempting to do cs_disasm, observation is that some of the instructions
were not identified (ex: extswsli, maddld) and it had to fallback to use
objdump. Hence enabling "cs_disasm" is added in comment section as a
TODO for powerpc.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/disasm.c | 143 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index d5d3554b9bd6..8eb7c86befd6 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1596,6 +1596,144 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 	}
 }
 
+static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
+					struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	u64 len = end - start;
+	u64 offset;
+	int i, fd, count;
+	bool is_64bit = false;
+	bool needs_cs_close = false;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+	csh handle;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+	u32 *line;
+	bool disassembler_style = false;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return -1;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    &is_64bit) == 0)
+		goto err;
+
+	if (!args->options->disassembler_style ||
+			!strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	line = (u32 *)buf;
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms.sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	/*
+	 * TODO: enable disassm for powerpc
+	 * count = cs_disasm(handle, buf, len, start, len, &insn);
+	 *
+	 * For now, only binary code is saved in disassembled line
+	 * to be used in "type" and "typeoff" sort keys. Each raw code
+	 * is 32 bit instruction. So use "len/4" to get the number of
+	 * entries.
+	 */
+	count = len/4;
+
+	for (i = 0, offset = 0; i < count; i++) {
+		args->offset = offset;
+		sprintf(args->line, "%x", line[i]);
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		offset += 4;
+	}
+
+	/* It failed in the middle */
+	if (offset != len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
+out:
+	if (needs_cs_close)
+		cs_close(&handle);
+	free(buf);
+	return count < 0 ? count : 0;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	if (needs_cs_close) {
+		struct disasm_line *tmp;
+
+		/*
+		 * It probably failed in the middle of the above loop.
+		 * Release any resources it might add.
+		 */
+		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
+			list_del(&dl->al.node);
+			free(dl);
+		}
+	}
+	count = -1;
+	goto out;
+}
+
 static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
@@ -1953,6 +2091,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 			err = symbol__disassemble_dso(symfs_filename, sym, args);
 			if (err == 0)
 				goto out_remove_tmp;
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+			err = symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
+			if (err == 0)
+				goto out_remove_tmp;
+#endif
 		}
 	}
 
-- 
2.43.0


