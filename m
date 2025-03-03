Return-Path: <linux-kernel+bounces-544966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD92AA4E88A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17243881C8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A8D296176;
	Tue,  4 Mar 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otGi7m45"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21377285401
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105808; cv=fail; b=r2JvCzYA8HRmm5V0eplySNNN9xoKioXn9DjsZKHZynStbziGbRL32zqoaqXvXNz6lzRuHxgvdooEc+fwZRUEvAAzyN6UNrgsOlGbIjy/gK46GJ03C5QAf1gv0G1Ra/sulYwOJmQpe0DlIiJKk34TuqfccN0+1zjCOeMF3yBatoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105808; c=relaxed/simple;
	bh=+aWd3NrvV3ubV1kXbgcpVzDvfJySegeddNL9Z/5L+QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pitYCLFSx2NVqHIpv97BXClZ+EVTRGJC8bWiiT7lw+B9ZMGrrp2pawqHqcdwpUoH6pxv+0RgE5TQ3GP0SN9g2cvgGJHLRYZM2GvYnx1N2PfDpbXGrNIh2EndBfsgLZL+zmMotFiP8mKfh1uA6O5QysO0G+XXSgsJD2plvWNxu5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGi7m45 reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 4B88140D1F41
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:30:05 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=otGi7m45
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h2964NnzG2jG
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:28:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id E90B642736; Tue,  4 Mar 2025 19:28:21 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGi7m45
X-Envelope-From: <linux-kernel+bounces-541218-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGi7m45
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id D58DF42D9B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:02:48 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 701873064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:02:48 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812E53ADC2B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDDD1F03E8;
	Mon,  3 Mar 2025 09:02:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F01DE3A4;
	Mon,  3 Mar 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992553; cv=none; b=Rp6B0D+hFisarjMKzcoOfObkkCEq05fMDm0XKegZWUHvyKmzlmBHfR/RptlzgDFfmCAJ6AK3J69gss4PkHX/wJ36fWVzy9NWQu9A1fROnKxBcTyxSzdQRI3POcZwW5/6X+aD/2I6U30KPg43uiQUgAMQuT7IR55SmGHyaUfoClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992553; c=relaxed/simple;
	bh=UZAYbtb3BpEfZIxe1rXdNagKd6DUuOCETOtib79EdIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkqz69MPaL7yvIa8Ai9COzsiW030LhAUHAlD8xrKBTfK7PcfA5I9O2z6fN3YAEOBs74MUioQobgVA8QVie2h5IUs/MAJrXOsdwd+DD5zO+DFz8j2Kwa3o9yGTu8oB6pw4uL0kbQ9saq4ZQGUQtDvKRrZsk7vVspNQA+SNxNL2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGi7m45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD6C4CED6;
	Mon,  3 Mar 2025 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740992553;
	bh=UZAYbtb3BpEfZIxe1rXdNagKd6DUuOCETOtib79EdIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=otGi7m45B3/3ZMXej2fl5F3AaeEKlExdM9c3LdYZFiiBWIUjkYKsV0yhjfknilrXO
	 ri5RTiaNSYFfUfHywsk2PFpQNitOAwJJ1H1gG5MyJw1vXgVebimFJd2x3sPybk522q
	 5YGk25itOFPYF2MKONDn/i0GvugDIjtOU1ar9tC0z5zXyJHBbhB9IujF120l2WvXeU
	 ZEkJkkQC5C99/KSZquXO5D0VUu6a/Z+DYc2RO1WOu88byqmBetQPOcYvRIPrM9bTKG
	 SUxY4MFijfyUuRmlZlBq+Y6BD7WgJcsUn7Z0YQJct29a4ct1tGNQaHi95oVgf4OiM8
	 G7ypgRlw0IYEw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probe-events: Cleanup entry-arg storing code
Date: Mon,  3 Mar 2025 18:02:29 +0900
Message-ID: <174099254917.619976.17555764627143910556.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h2964NnzG2jG
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710521.23177@JiOfK1Mdlj7pE1oV/LhkYA
X-ITU-MailScanner-SpamCheck: not spam

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cleanup __store_entry_arg() so that it is easier to understand.
The main complexity may come from combining the loops for finding
stored-entry-arg and max-offset and appending new entry.

This split those different loops into 3 parts, lookup the same
entry-arg, find the max offset and append new entry.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   85 +++++++++++++++++++++++---------------=
------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95ee..b2261cab4b94 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,26 @@ static int check_prepare_btf_string_fetch(char *type=
name,
=20
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
=20
+static void store_entry_arg_at(struct fetch_insn *code, int argnum, int =
offset)
+{
+	code[0].op =3D FETCH_OP_ARG;
+	code[0].param =3D argnum;
+	code[1].op =3D FETCH_OP_ST_EDATA;
+	code[1].offset =3D offset;
+}
+
+static int get_entry_arg_max_offset(struct probe_entry_arg *earg)
+{
+	int i, max_offset =3D 0;
+
+	for (i =3D 0; i < earg->size - 1 && earg->code[i].op !=3D FETCH_OP_END;=
 i++) {
+		if (earg->code[i].op =3D=3D FETCH_OP_ST_EDATA)
+			if (earg->code[i].offset > max_offset)
+				max_offset =3D earg->code[i].offset;
+	}
+	return max_offset;
+}
+
 /*
  * Add the entry code to store the 'argnum'th parameter and return the o=
ffset
  * in the entry data buffer where the data will be stored.
@@ -777,7 +797,6 @@ static int check_prepare_btf_string_fetch(char *typen=
ame,
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg =3D tp->entry_arg;
-	bool match =3D false;
 	int i, offset;
=20
 	if (!earg) {
@@ -795,6 +814,8 @@ static int __store_entry_arg(struct trace_probe *tp, =
int argnum)
 		for (i =3D 0; i < earg->size; i++)
 			earg->code[i].op =3D FETCH_OP_END;
 		tp->entry_arg =3D earg;
+		store_entry_arg_at(earg->code, argnum, 0);
+		return 0;
 	}
=20
 	/*
@@ -806,40 +827,34 @@ static int __store_entry_arg(struct trace_probe *tp=
, int argnum)
 	 * code array to find the FETCH_OP_ARG which already fetches the 'argnu=
m'
 	 * parameter. If it doesn't match, update 'offset' to find the last
 	 * offset.
-	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
-	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
-	 * return data offset so that caller can find the data offset in the en=
try
-	 * data buffer.
+	 * If we hit the FETCH_OP_END without matching FETCH_OP_ARG entry,
+	 * append the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
+	 * return data offset so that caller can find the data offset in the
+	 * entry data buffer.
 	 */
-	offset =3D 0;
-	for (i =3D 0; i < earg->size - 1; i++) {
-		switch (earg->code[i].op) {
-		case FETCH_OP_END:
-			earg->code[i].op =3D FETCH_OP_ARG;
-			earg->code[i].param =3D argnum;
-			earg->code[i + 1].op =3D FETCH_OP_ST_EDATA;
-			earg->code[i + 1].offset =3D offset;
-			return offset;
-		case FETCH_OP_ARG:
-			match =3D (earg->code[i].param =3D=3D argnum);
-			break;
-		case FETCH_OP_ST_EDATA:
-			offset =3D earg->code[i].offset;
-			if (match)
-				return offset;
-			offset +=3D sizeof(unsigned long);
-			break;
-		default:
-			break;
-		}
+
+	/* Search the offset for the sprcified argnum. */
+	for (i =3D 0; i < earg->size - 1 && earg->code[i].op !=3D FETCH_OP_END;=
 i++) {
+		if (earg->code[i].op !=3D FETCH_OP_ARG || earg->code[i].param !=3D arg=
num)
+			continue;
+
+		if (WARN_ON_ONCE(earg->code[i + 1].op !=3D FETCH_OP_ST_EDATA))
+			continue;
+
+		return earg->code[i + 1].offset;
 	}
-	return -ENOSPC;
+	if (i >=3D earg->size - 1)
+		return -ENOSPC;
+
+	/* Not found, append new entry if possible. */
+	offset =3D get_entry_arg_max_offset(earg) + sizeof(unsigned long);
+	store_entry_arg_at(&earg->code[i], argnum, offset);
+	return offset;
 }
=20
 int traceprobe_get_entry_data_size(struct trace_probe *tp)
 {
 	struct probe_entry_arg *earg =3D tp->entry_arg;
-	int i, size =3D 0;
=20
 	if (!earg)
 		return 0;
@@ -854,19 +869,7 @@ int traceprobe_get_entry_data_size(struct trace_prob=
e *tp)
 	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
 	 * code array.
 	 */
-	for (i =3D 0; i < earg->size; i++) {
-		switch (earg->code[i].op) {
-		case FETCH_OP_END:
-			goto out;
-		case FETCH_OP_ST_EDATA:
-			size =3D earg->code[i].offset + sizeof(unsigned long);
-			break;
-		default:
-			break;
-		}
-	}
-out:
-	return size;
+	return get_entry_arg_max_offset(earg) + sizeof(unsigned long);
 }
=20
 void store_trace_entry_data(void *edata, struct trace_probe *tp, struct =
pt_regs *regs)



