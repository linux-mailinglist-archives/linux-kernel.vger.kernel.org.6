Return-Path: <linux-kernel+bounces-416373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE789D43EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405211F2267F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38A18A6B2;
	Wed, 20 Nov 2024 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY0rmZ0q"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD37188717;
	Wed, 20 Nov 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142005; cv=none; b=iCeMgZOA3lMPxpiBUl9QFDHdzb+VnNf41gzJQtdkbPgDPwLRdFPdZUSyFViuDemKz+KZOQruv5t5LZzjUiAwSmtRfEBYXlFs1S2mX/Rxkgoyr+bPEUyctQmAudKzPozSL6IWcY8L1ose8QMhtIcTbZV7rJi+Xl/9ePnwGNghKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142005; c=relaxed/simple;
	bh=Ro0CtiL3ZzjiFTFmwz2565AcUxxRdDotQMfOjOxI8eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Em0WWLJZU84oCRDa/7ZbtlO0Bfpg/JVldZF0HkhWoGMIfXyjCxKcEQjCJDNXqlr51kzJLrK489hXcF8FJmXPe3K468OfhBxOxGshuuVUbgBVcigUJhaFzCWuxwyo4isKjGCFf9liBJEc3FHJKpxy9VMXBzkzWUYqAIjwqj6Q9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY0rmZ0q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-211fcadd960so1458645ad.2;
        Wed, 20 Nov 2024 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732142003; x=1732746803; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91aDxN0XTQNGQGQT8Q/szbDxtIhhxYQG+hsB7O1S3Ug=;
        b=CY0rmZ0q+hyPD+6V+i3Jj5FkSF37W15YEK1HKMyT5Z32fCyIvgkq0T/rCeUB05FsTR
         OHRVxTi4qfrxgfiuss3Hq1HDuq5Xx5qaHA7uEjCIhsaqTjjoxUGUXMKG8AuaLeXJGRkN
         bKussoTl6JmBY/QL15LDtkOA/1tUbSTDeb3ZXlWN1+8fqp1cbNroRaSPqR2BsXBvrnC+
         nTkCUvOfOLAu46w/5j2TV/HT+vzxDXBuvHJymU0inm1FvDamyi//onafHSjeHCJ0NjjO
         qEw8/IXZz+UkEnLBGjnPoQO3otgAflilzYebz0dsk7EbLDglVvkVM/rpPxSCW38r8wRp
         1HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732142003; x=1732746803;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91aDxN0XTQNGQGQT8Q/szbDxtIhhxYQG+hsB7O1S3Ug=;
        b=Le5b4FqFkQClQKpYNM1JB7ydTVg1w4ow0djrrwsLBUkiiemBzZasSsWbCdM0l/cx9O
         Qd84fWr2cgD9ip1aVZ8zLU8f8+bGVg829JX/aoP8uA7zXGssDJJZmbJ4zH3YYC2DMoA1
         HlgUiLJ3l2pT6PLU7isLDKyRfRlAiNgZEakFwWNzK4haEJ6IAZIsTlpHSMQNJvNwCToT
         XjOd+z8PM2snV2GTdUV9HlnFOmdSe3+asf4SBPxRc9MSfylB5yBG2pZ+PPyS+8S9VDTy
         +TRQrawkvtuUJl/Y0SI0z2c4uUS8tiXtDxPoQnisJ3b0h3iRlWTmNEWsy60/qmwKLxts
         BzTg==
X-Forwarded-Encrypted: i=1; AJvYcCWrr49Cu8XB6BAqrVCsAuEGLhFciNgNlvoFD3D3PXpGt3bxZ38d1HwVYWaafpTEC9/iRlceCryDzEV0azBZPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5BYtZmcX4BCRsdxT71ISCa6qzbs1lzeT2+Zg1weczU9PyzD+
	pfSdPyZdmSI/UWy14JHcj//ob/DVfem1KmauDq6qVl70BICdFh7T
X-Google-Smtp-Source: AGHT+IGeGe8bOec4hMM4YUcVvnZkB7kV+LtA46t9+5yn7tVFugX6lX6a6g5kEWj8M788pNCgZn8mqQ==
X-Received: by 2002:a17:903:41c6:b0:212:37e:3fcd with SMTP id d9443c01a7336-2126c97a053mr47913995ad.56.1732142003132;
        Wed, 20 Nov 2024 14:33:23 -0800 (PST)
Received: from mitchelllevy. ([131.107.1.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883f6a00sm563535ad.250.2024.11.20.14.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:33:22 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 20 Nov 2024 14:32:29 -0800
Subject: [PATCH] x86/tools: Use a longer buffer for insn_decoder_test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-insn-decoder-test-len-fix-v1-1-44b075deda05@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHxjPmcC/x2MwQqDMBAFf0X27EISpKb+iniQ5KkLZZWsSEH89
 4YeZ2DmJkMRGA3NTQWXmOxawbcNpW3WFSy5MgUXOu99ZFFTzkh7RuETdvIHyot82c0xvUJA/84
 d1f4oqPr/Hqfn+QH0rWbWawAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732142002; l=1637;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=Ro0CtiL3ZzjiFTFmwz2565AcUxxRdDotQMfOjOxI8eM=;
 b=EqW00ynzOD0MCouqTvm3wjRQhPD3zprb5xBOIhTnQNMo7hhRZEpWfibLS3+BG8sJsbPpgkwSS
 u93732XD9ChDnx41X4TGi3WnZU58cxIHLiX3rX06pW03bM4pOqAeeKQ
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Use a 1024 byte buffer for parsing objdump output lines to accommodate
long symbols created by rust doctests.

The number 1024 is based on giving a healthy margin above KSYM_NAME_LEN
to accommodate angle brackets, addresses, and whitespace.

---
Rust doctests can result in very long symbol names, which results in
very long lines in objdump output, such as:
<__pfx__RINvNtCshBBT4i9RzFA_4core3ptr13drop_in_placeINtNtNtCskPkSD4WGMmy_6kernel4sync3arc3ArcINtNtNtNtBN_5block2mq7tag_set6TagSetNtNvNvNvCs8MySzWyGC07_25doctests_kernel_generated33rust_doctest_kernel_block_mq_rs_04main42__doctest_main_rust_kernel_block_mq_rs_58_011MyBlkDeviceEEEB23_>:ffffffff818bb250

Currently, fgets will truncate on the first read of this line (but this
is fine since we see it starts with '<' and continue the loop), but on
the second we get "rs_58_011MyBlkDeviceEEEB23_>:ffffffff818bb250", which
is treated as malformed. 

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 arch/x86/tools/insn_decoder_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..18601b3c5037 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -106,7 +106,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE 1024
 
 int main(int argc, char **argv)
 {

---
base-commit: 37c5695cb37a20403947062be8cb7e00f6bed353
change-id: 20241118-insn-decoder-test-len-fix-0a8c622e79d4

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


