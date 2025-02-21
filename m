Return-Path: <linux-kernel+bounces-525312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDEA3EE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51AA1890C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE661FFC5B;
	Fri, 21 Feb 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Bqy4R9kR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9DD1F9406
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125583; cv=none; b=hMSfeQRnTqvySkN3Ckmuou9ilw621oD3LwmfGais5XqkZumdAyFK0LvAx6wiTySY04MoAs5ZBHJ7jJFmT9RMpwby0v2EXyWIZUfFuHd60rfJ16qT8IZaotVGnT+Dbc4/YLW69JdpuDbbAytWqqSg8qHz31mM07saYQsyfqsG/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125583; c=relaxed/simple;
	bh=2A9LVAI/zUW2kWoYjRXarbyUvw1S+bDtLHAm+GA8gRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvGRvk6yWwktivqR/bCd1RjJS5WAFi+5p+V4AT+GXvcLzdR/VZ3adw9C5N4JNDvkzNmCnMncotct4I0xQk/ebMCbXlKdXG7RXlvU1BPcsrUCk+A+9kkEKf8YHOwfd3Hz91D8G6qpsuIx4hqUlvnLPW5g6qnY6vsjl5l4BgKGaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Bqy4R9kR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so286796166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1740125579; x=1740730379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlKk4Du+Rzr/cFu16R/zw4oEfN6mefn4wJkCUpov8HQ=;
        b=Bqy4R9kRe2EzoZNeon/0uPA5dv15XZbJGfeO8oMy/GxojE4k3i14tGXAtb6b1awxCG
         0I7zGuzWUGb8K5DYhsY0rOp1t37DtsA7ykARzJoE+1RNEb8yzNr4zhgLFteUjzo04Mox
         JP4b/Y3jQFbI8nCdZeBQSCZqbw1tBgMUkr1dwVvbqfUZUtzGjsc3EJ1m+qdc5n8+8RWl
         liL3q53+FwPMJpJIh1NBy2awxqLnYuJB95566S8jUlRM2ttbt6qJ7UgHGTpCrY7elgDl
         Q7r2J5MJWGBeK2t47r4OrekEVp3JPUdQ6xLE/EamRegzqmIcNsRyKRzEUjnIUo0+gZ5B
         yzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125579; x=1740730379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlKk4Du+Rzr/cFu16R/zw4oEfN6mefn4wJkCUpov8HQ=;
        b=E+Brubnj4YCKO/qzNYI70H6LZKwzAdADJCY/bb8qEuuAfYjbB+Ll91BkiGfyxsBvv7
         EEJNihuJ4vcVzkc7JWyhI0sQAm89eJdslyBOH04VEZa6DaUwE0DNlmcBGBoKx3PhaImZ
         Da0oU7nKbLzPKUf8lxZlDKRfE+6wcf7u4uDOjlyZDxyEDiU27vddPegbMpS8dg21oXzO
         8LjU5AGJ06PpdOn2so+0rKRx4HvsRsuTE9eHgf8rSsUfYj3oMg1t4NGnGYpWTkh3C6OP
         5c600FbpK6iliijmfq0eN5RCZw7k18brsT4iWQLH70dlptF6egycL2ojBracs3KI8DAW
         eTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVExe6qckyryGYCWRYhVlCkUUC8dxK4OUd8BIsIC8is0eD4rWFhn+NmVL/6qaoLdFaj+t9bTzW8iupdM9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGJVlEGHwwq+Vlt7a0nKVp4a5v0sL4252yFpJNBRzw1TBOgY/
	1KLei8acBJ35BGwGI2Pd84LC+/au6VjGpdEHZ3EML86nGA3lbEMtKsg2REWZ2BY=
X-Gm-Gg: ASbGncv6UK+lwtvRFVq0UK5WiBUYECSr66EjL0fCFTdYYV6Jx/TiVSVixauveQP8i1K
	wWcq9Bn2HVlC/HWbmpAMGOmAf0QFmg6hcvbtK8f39qJCMhsBzpz8qbuG/rfIYWrmd3KAepnen+F
	QeIZ/JSF0cQwxL/Vtuzpt/rd+9nUNIxH74JXqKxOh3X92Zoaw8ssfsKRCp9835eIaxPvoZgSzRc
	OQqDv3/KhnjQ5fdTXTLiYBLw0O8YgAythJrHbrGgKvipFh8FX58OpJjB25IJuwAs+xsxUm1Q0yd
	VlUEmQd5Et+bYeSJdXpiH+Pa2l5FHiE+9UXkwiWC1vOcDEraIVpg3Q4nO5F98h/Fy9QHFDbA7Vs
	Zj8THoPNwNjG+pBiWfGySzu95
X-Google-Smtp-Source: AGHT+IFXKYEVbsxt3ej9tqksuoiTwcM4lgX1CYwy9RrcuJ8sznNOB+o19FApSAtfdbdRT6eDQE9CyA==
X-Received: by 2002:a17:907:9494:b0:ab7:d5e3:cbac with SMTP id a640c23a62f3a-abc0de4f19emr196940766b.54.1740125579032;
        Fri, 21 Feb 2025 00:12:59 -0800 (PST)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb6f13b11esm1234299266b.71.2025.02.21.00.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 00:12:58 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/firmware/efi: Fix cper_ia_proc_ctx alignment
Date: Fri, 21 Feb 2025 09:12:42 +0100
Message-ID: <20250221081242.1411553-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the UEFI Common Platform Error Record appendix, the
IA32/X64 Processor Context Information Structure is a variable length
structure, but "is padded with zeros if the size is not a multiple
of 16 bytes".

Currently this isn't honoured, causing all but the first structure to
be garbage when printed. Thus align the size to be a multiple of 16.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/efi/cper-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 438ed9eff6d0..3949d7b5e808 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -325,7 +325,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
 	ctx_info = (struct cper_ia_proc_ctx *)err_info;
 	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
-		int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
+		int size = ALIGN(sizeof(*ctx_info) + ctx_info->reg_arr_size, 16);
 		int groupsize = 4;
 
 		printk("%sContext Information Structure %d:\n", pfx, i);
-- 
2.48.1


