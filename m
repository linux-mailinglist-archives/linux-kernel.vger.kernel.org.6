Return-Path: <linux-kernel+bounces-170105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56998BD1EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68A11C21ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9215573B;
	Mon,  6 May 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ww++e+vg"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6F4D58E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010959; cv=none; b=fq46YAwI7dDUuKfuFNIhJHLVE523jFKc0hEOVbom19ASsJt63yw7+nPiBZCmNFKts0vLccUx5415k4J6ucA+kTLGtC3ZK+lPiOiEDu9+B7l8gpyuEGqpcQ71AjNgFqN9kuZ+k9/dCzlrxOCZUwDKfD/q7WRb2dk/1FcbbQN8aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010959; c=relaxed/simple;
	bh=GGxtgdueDnkD++VTZpy2fAe4IiDXfria7dwMnH/Xvds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yfjh3GiIpCpA0HL6GYGMgQ9k6iKlQWq9AE5QzzjkEOsHdAzBdCVK2aObyxtlGdarOLXeXgtd/REVUiL05L4/87POkkmNNNiEAzyqzZa5wcayHf/OypEujefwhqAXYuA3HFKHUFe1v5frt7pLGBm6cFtJ+APGqSwiEsAVNS/cApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ww++e+vg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so1469149b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715010956; x=1715615756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDRDF8JT98zd81UBJ0k3A5WdQ6sY0FvfJJ+osF1311Q=;
        b=Ww++e+vgZtK0UbvZ/1H3oWkf38o/l1kFFdaIqygCJqAJPMf3Qyc4X1iN2/k6txm7LA
         noSjnSYCZV0/q1iu0RNmAirqy7FNc8Rg1579jNGsOTOoqyp2AFOoinznOwxx3mhf9mpY
         DMQFVYuqfZDE2s4Ltp3weiWnKejbrypespMf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010956; x=1715615756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDRDF8JT98zd81UBJ0k3A5WdQ6sY0FvfJJ+osF1311Q=;
        b=MtaHYn+xQhLNLy5vJzpg+PySW5XE77waAjoNaSLmI34wp0PusOWFN9cuahxisuOa0b
         8ATEkoCZSbKJH1JfYX7bk0qMHM2VbrL5bB/elX+jqttXS4LcFGh+2pd142Rc2EGDdEKg
         tZruYD0isYrzPURdjAV1lmLLKchY8tOL6f4QwfL8n2RkSoKdHoGXwxvqqqMEl9iOxbjo
         5U0BktDxTeabYjvYJ5I3iZZ+y4QB6u8bL0gyibWwe28E2U1CvSLvIiz3/OK1FPfxlTDY
         3oo3QwEfVTWLlFoYHT0IS76CbZIjjXA9Ry/qgWBF+86y9RxyCnSVyV6jW/A4OYquPu8w
         JHFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvk0SOavg6wVBPhapah3I02A14XjKgQChwssXLe99KXAowtp2rKX0R4YaQP3OswUWltXtGe3QPw2ZPTurXyKGCOu72pohbFNjqa61d
X-Gm-Message-State: AOJu0Yxv7w5pVSMeFc+il5yNaqcc7zd49HHc7BXJZ3CPkYj9Zuhj1spG
	3peWm8ov3+Y5XdCNlAhmOLtEJS0Xx9FwTB5GWyBI9U4n/XFSUw7LQst3MF02Xw==
X-Google-Smtp-Source: AGHT+IF8seK1eV0WOFQ9oIJEm6z+Hw9NQTFIySMgMWTXXYqt4+1a9w/894yC/hdv+9bzowoZqhikHg==
X-Received: by 2002:a05:6a21:2787:b0:1af:baf9:fef6 with SMTP id rn7-20020a056a21278700b001afbaf9fef6mr875194pzb.16.1715010956221;
        Mon, 06 May 2024 08:55:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b006f46e3b1d03sm3052566pfu.88.2024.05.06.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:55:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] objtool: Report section name in elf_init_reloc_text_sym() warning
Date: Mon,  6 May 2024 08:55:54 -0700
Message-Id: <20240506155537.it.760-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GGxtgdueDnkD++VTZpy2fAe4IiDXfria7dwMnH/Xvds=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmOP2Kj5waKn0Rom7MjuZCKgUTYCB/8plgHDYgu
 39RuxQNIGKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjj9igAKCRCJcvTf3G3A
 JsdsD/9XOz3kYzfScqtBwJzrTbArfUb/4ag/iIi+uY/twr+UWJYIZJ6X0E57SAbZqdtFx3lvAmu
 7eDimxhxNAx47XzNTrjG9eospdV5PUPkKpl76Y6MyU1zLpxqmDiQf1u33AXex2std12cG4Zy4zI
 YHjEOxeWXboPe88GFCOCu35n/dBnseQEPefB7w5IZk8BRi8XEU+QmR+pVdJIcOwTy5XbLgj5JeP
 QYTDlhn5RVcrvux2Ik7EwEWQrIauFadGZRVolS6uvRG+9cmQhVe5PIFK3tmIGKQi7UwJLzyXaGt
 hnbh0ueDHEs0rCnNVPtgAYkGvWGKhc8VDYm/C+Xz7NLXNERqpHjAHOf9QBTh9RZqPWmM6DYfjh1
 ghap7NR9buzGq0wvb5UcdxjnpFKvVVGLv9YMHJUqzXQfdovnpB8tq7qMY0Z/s5aB1P8O73Uol6g
 LuVVOSSFImtTHK+BMw/fZtHa/r+fhaKSkaHvw9GwyIdfTnQw73AP/k5fuz+NWE0YfYrv1VBbT4o
 f1A+kpfdCVYbE9YMtDncBjvl0nJrHPlUao/c18QiX0pParCsbiGrDPzGNx2JblXQ+N2munjBigt
 BvBz/Xd3CWo2DIOKQWss01le5WPbogV3HqcHX6mLC/1qSK+kYbI6b2iaUqyCybTiJiwyLXn4QVF
 ASAbC8i zzoA1F0w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While tracking down issues with LKDTM's .rodata "function", I found
the warning from elf_init_reloc_text_sym() to be unhelpful because it
wasn't clear which calling path it was coming from. Report the sec->name
and rephrase the warning a bit. Additionally check for NULL sym->name,
which may happen.

Before:

vmlinux.o: warning: objtool: bad call to elf_init_reloc_text_sym() for data symbol .rodata

After:

vmlinux.o: warning: objtool: .cfi_sites: unexpected reference to non-executable symbol '.rodata'

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
 v1: https://lore.kernel.org/lkml/20240430235106.work.680-kees@kernel.org/
---
 tools/objtool/elf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..b38cedd4fd55 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -891,8 +891,8 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 	int addend = insn_off;
 
 	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
-		WARN("bad call to %s() for data symbol %s",
-		     __func__, sym->name);
+		WARN("%s: unexpected reference to non-executable symbol '%s'",
+		     sec->name, sym->name ?: "<unknown>");
 		return NULL;
 	}
 
-- 
2.34.1


