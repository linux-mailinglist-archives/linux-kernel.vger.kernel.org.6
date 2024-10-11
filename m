Return-Path: <linux-kernel+bounces-361545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4099A98A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0E9B24FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3321CF7BE;
	Fri, 11 Oct 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzfnNnwH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2011CF29E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666561; cv=none; b=Hl3mnrof1jOEJ/Cw3T8pHf7scFqFgfgLNP1bMJxWf4mIYN9dzfL3lu3PYKhZBDtXc3jbjLdwc6lnYEqdNg/dNHoHuEQJUGRfaLpcYF7EQPlpGG/VKTDlXLC1qrGZuDaO6zackpb4WQozQQssZrVpw5SfLjKX9nc2/n1mV1uGQNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666561; c=relaxed/simple;
	bh=Je70niWxlsrHVgag6J/kzDZ6SflRUbpCOeNQjbweCs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjVIizUDLafDbJKMfG+gLOqDTWTLfW5X1QI58bq1frzfrOcnTfIilulHAxjJw0RruQgf6fEj9H4C9KSw1Mp4Kv7ipIi5AUlACEewnQMeOaHARbJvJIkUHDZK6meufzcRoHuIPlDABdnPi8uMTLKKqSnOr4C6K2tuqFgnDovf0wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzfnNnwH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so2681155276.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666559; x=1729271359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2msbXnFeBvXSlHbQOfDHqTuvhI8e8tpl7Wq7z97LNd0=;
        b=mzfnNnwHaxDnfkX5ZxIdisNTJyi+NDR1XopfwMtbs7Sxj09jCi1azBj7e4fVEI0xTQ
         T7yg+RvgHotT4CQDCP2Y8bQa8MnSf7TCtJV9iD4lC1U+oINAe8W+kYSpxAp605A+eE41
         2MX38vZHArTVuKAK/kieNb6mcgKyS+greqrmEjoOYx9sFB698WkyOT94gswjZG0fd1JU
         f6wMkMmxotCyAj0bXm/edYVl85J6w/klRXt0RMxeKGnPu+LGNnzNMOD2V+hg1Ot8zS9p
         gAfFetdvaO4hKBFneRJU/iZYtexL6SL+JVGHIKWPn5H+GOH+pJZ91AZmAkJIO7CKQpoI
         v+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666559; x=1729271359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2msbXnFeBvXSlHbQOfDHqTuvhI8e8tpl7Wq7z97LNd0=;
        b=YXkeedfrWDTiZtIGkoI/nNTl5u9DncUEEdNcTfGQsOBHcQHQIWsJejNctXkzVTiTZn
         LWD94CI517OzjV7QQUaTE+NSsKdsoRzZ2itacGPhmlEeIqykLYr0khMeUntsG//niPkh
         b8GRnPCk9aFuJCdP8ee65SojmATt8C/pq2tCBGH6huSrXDADCaCvWWGTld4fkg3XdB61
         rxKKeqKytQIKeWzWKge1ECQmSJw/z9HYRuDgPkBhvMdm4FckAcGAommjQHrELpIZ1X7i
         6JW2eqIHXFhBD3C4GbcQl9vQxHMtMpYT2sYqD2N9EdfhkOuTBLkZamZxK/rcnLNzbN2J
         nK9w==
X-Gm-Message-State: AOJu0YxHyLB4ku+D7v2vOwvWn7+DCccJf7dZ0skvH9/yko/6KmNd/Xyv
	4Sm1sHYvwrmXDFjNIXlcPeDU0ByL1JbD+ePOX8MJ58nD4RC3tLgH9mvMnX53iWzyL9lPEmdTHrD
	IarPSA5YsCuaBV5P4CyvR1JMMavjVeoyih15DvFMdt0O4jLbP/9/Yjzwqm/P1Edy8x4wlVzG61n
	Cbgl/sYCydjKwPypV8ifBq8fLsx1WKLA==
X-Google-Smtp-Source: AGHT+IENvAkwhnL9xlh8jftp93Hwt0IxXAkKRHhznXl4M3FYlzwM5kPXAaj0d7TOhJKUCzOqrr+HUbBx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:8050:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e2919d82cf4mr6763276.2.1728666558271; Fri, 11 Oct 2024 10:09:18
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:54 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=ardb@kernel.org;
 h=from:subject; bh=gpTsTI/SBCSlqxjQQW/Apkngf1lwQqJWx5rnk4mqsKs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zesVLQ/4ILm0m3gzzi8t+H5uyXLmzrXVBp+fyFyIi2
 5hyBSs6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETOZDIydBzYErU8dkXsl0N1
 UzvNQll2yxz6sciz7Knz2Rmny7UkqhkZpi2fGtp7k5eFx1K/hIlvhupTrt8fQjr+SSl//VjDsM2 dBwA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-16-ardb+git@google.com>
Subject: [PATCH v3 6/8] crypto: x86/crc32c - Use idiomatic relative jump table
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The original crc32c code used a place-relative jump table but with a
slightly awkward use of two separate symbols. To help objtool, this was
replaced with a bog-standard position dependent jump table call, which
was subsequently tweaked to use a RIP-relative reference to the table,
but still populate it with absolute 64-bit references.

Given that objtool will need to be taught about the jump table idiom
that compilers use when running with -fpie enabled, let's update the
jump table in the crc32c code once again to use this standard idiom,
where the jump table carries 32-bit references relative to the start of
the table, and the destination address can be obtained by adding the
two.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index bbcff1fb78cb..45b005935194 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -53,7 +53,7 @@
 .endm
 
 .macro JMPTBL_ENTRY i
-.quad .Lcrc_\i
+.long .Lcrc_\i - jump_table
 .endm
 
 .macro JNC_LESS_THAN j
@@ -169,7 +169,8 @@ SYM_FUNC_START(crc_pcl)
 
 	## branch into array
 	leaq	jump_table(%rip), %bufp
-	mov	(%bufp,%rax,8), %bufp
+	movslq	(%bufp,%rax,4), len
+	addq	len, %bufp
 	JMP_NOSPEC bufp
 
 	################################################################
-- 
2.47.0.rc1.288.g06298d1525-goog


