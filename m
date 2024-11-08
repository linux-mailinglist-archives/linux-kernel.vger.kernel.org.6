Return-Path: <linux-kernel+bounces-402207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBFC9C2508
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1471A1C20F31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6971A9B46;
	Fri,  8 Nov 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OyK/A/n1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B6233D62
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091584; cv=none; b=dhWr+p8zudId2AittylmdkeW4OZuMQZbd477BdablPr8uAZBUXLOtUxiEIvujmJZK5dzTYSeAVPgSwJGWk7PJU7b00A3tVRz+gprjbXXSfLlqZNrNy7635vMI57In7l+208HOGaKSKiAL/6ufPV01B/R+5kES+WC27Tc88OJi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091584; c=relaxed/simple;
	bh=nZQmf+UWAh9LkwZFvYnAPdVlsxb+xmR6xdDXcDiniFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ClUtAELtW/zpccb5B0tcoA449y+9g4bfVZJufF0caJAt0MHmzgoIxv/scbnL8WK1J6TLxe+yezTtmfwkenKN/rqGFpgEWkkcCNUyQe2YPFfR/zR0TYYPnVgCAQnm65xYUDJ4AIxNHKtk5hR/MmTYIw4GHUA2UOj5RsV6nYNwYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OyK/A/n1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3xVWIV8QD/TFPVUu2NvkskTG98QpHditQM6KKRd99hE=; b=OyK/A/n1D31MtyrUmayq7+fjOK
	VJrnDXcHIGBlwcwqOWdMSOgpsy28fOdSNsTMLEVJtPYo5h3TjazLOgGRvVocD/xk52//TCTVN+ukd
	Y4E2FMsWnrQ711e+uRImItVd3I4yuS3rs4q8Jfb6YlI4JXxx+iLKxokXuZYcwDsizIrmDfDPv+9aq
	XejSSiLtRbGFqesGHlhVesRh5F192ONyt9Ri+EZvZtIk2kaZwSLgrBzar9paYB6NdqNeXRCoJVNgE
	Eb9aYTFlu95bobVv3k01URcg9bfy8h14cVoF92yXxDGPqyc1NArOyKujFpp/9F+9A4P/0SlaRyxfx
	Eg+N0Ztw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Tzv-0000000CMNO-0hlp;
	Fri, 08 Nov 2024 18:46:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46C7E30049D; Fri,  8 Nov 2024 19:46:18 +0100 (CET)
Date: Fri, 8 Nov 2024 19:46:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: nathan@kernel.org
Subject: objtool: Exclude __tracepoints data from ENDBR checks
Message-ID: <20241108184618.GG38786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


For some, as of yet unexplained reason, Clang-19, but not GCC,
generates and endless stream of:

drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_send_chunk+0x20: data relocation to !ENDBR: __SCT__tp_func_send_chunk+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_cmd_retry+0x20: data relocation to !ENDBR: __SCT__tp_func_cmd_retry+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_write_reg+0x20: data relocation to !ENDBR: __SCT__tp_func_write_reg+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_read_reg+0x20: data relocation to !ENDBR: __SCT__tp_func_read_reg+0x0
drivers/iio/imu/bno055/bno055_ser.o: warning: objtool: __tracepoint_recv+0x20: data relocation to !ENDBR: __SCT__tp_func_recv+0x0

Which is entirely correct, but harmless. Add the __tracepoints section
to the exclusion list.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4573,6 +4573,7 @@ static int validate_ibt(struct objtool_f
 		    !strcmp(sec->name, "__jump_table")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".kcfi_traps")			||
+		    !strcmp(sec->name, "__tracepoints")			||
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 

