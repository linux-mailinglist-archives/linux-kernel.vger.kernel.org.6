Return-Path: <linux-kernel+bounces-215351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADD90917A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E891C258D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05F1AC429;
	Fri, 14 Jun 2024 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZTSJ+tzO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F151AC242;
	Fri, 14 Jun 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386059; cv=none; b=ieGzhoim+D5MigoF143PjsMdRATriZveYdse3MUXC5QcZYvcOHu8uw22RjkZyYEwzJK1ZLCmDDcsBBHOf/sVXG2dPCEWX6i8dc/x8EUGq9iCcmcIf7ZDCf2kbCaIcdUsf6YH0XxHo44P6e60zTvkDQ/xN19GpC4r8rmmwAcXc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386059; c=relaxed/simple;
	bh=HgKQBt95aP9zwiJig9LisrJazeB5KftPrnTPUe6Is98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcLpxpt5g810/MTy9MxC1rJ/wnaXwBUm1y4rJ5GhyXHFnL1oaDkFJjQi2jS/8zQFhbBMCKAlzA3zAiNjdJBAq5jk70m99j/R8cgy0Zqe0QXUI0MM+s+Aq36kSjQuTpKQwdy+0iNz5iD/O5CY9S/u/JrRe51XyNENQzRcmQU2hsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZTSJ+tzO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EHLv2w028861;
	Fri, 14 Jun 2024 17:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=/UR0haK0ddFvY
	g9w/Rlk0YlrLw7jSCdzjzNeVHlniVU=; b=ZTSJ+tzOuTRWjQQZ/+vz81cFXqGuc
	DT0n5ZX+i2lFPcBf1YgJd54zfaOvMDA6YzxmIq7ARYb6qbgwaWm4rL1em6o1hmya
	+sYdojv0tS81MXszG94lrBhkLS1cGfoILygVBYZpNyLPz4qMBMI/CaoT8DQOh/kx
	j848aftMy7QltTlhptZed3S0a2x7Fgtq0LOonp1FrnZDeWKTNFa2NJKd7Jc2iTRN
	7k1SlUji+UQh9gFsXP8AzksGjn9MGEDCetZXTGS3KJ391RpqZIOTnljcAj46LZwO
	QDKxVT/a2ilhzNL8noRLT0slymO9BUJDbhe8hFty52g1cWnGDVFndCDKA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrq7erje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHRSPL004436;
	Fri, 14 Jun 2024 17:27:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrq7erje4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EH02sq003878;
	Fri, 14 Jun 2024 17:27:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqkf1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHRLW655902714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:27:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D59712004B;
	Fri, 14 Jun 2024 17:27:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1417620043;
	Fri, 14 Jun 2024 17:27:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:27:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [V4 13/16] tools/perf: Add support to use libcapstone in powerpc
Date: Fri, 14 Jun 2024 22:56:28 +0530
Message-Id: <20240614172631.56803-14-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
References: <20240614172631.56803-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sz_EeyeE8YnGZuw2IAUAVei9oTP0x7yC
X-Proofpoint-GUID: Jwyte-sPYtz0N8iyEj504rYIFI30YUUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=810 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140119

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
index 43743ca4bdc9..987bff9f71c3 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1592,6 +1592,144 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
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
@@ -1949,6 +2087,11 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
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


