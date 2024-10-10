Return-Path: <linux-kernel+bounces-358976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5B9985EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B053228371D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0A1C8FAA;
	Thu, 10 Oct 2024 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ToUc1p4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3E1C6F79
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563306; cv=none; b=Uho5ZTUtP86zZCCJ0ucUMLYkUOwMxXXZYkx5RQKJfAPz93w/ysgWH7SDuCJFNByVhhptsdZzvYzZQevKawGAYAnvpEzt9uA1x4eFQnP+HecdS0Ryjq3tkaBnxJt0n2Xyrb5F1EC5jHCpr4PeAyfzphkrhR+IZ2/eywbVnzhAvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563306; c=relaxed/simple;
	bh=MRo6HjQ15aNR0eJ50gt5+sfVcqyhO/6KpFlpqqECZJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HsrVRPlZuxRwjGhlueE0SbeyV3a2D5qCmpmiLRAeOsz/FvGjUuYXDmGAVIt9ClPFzOSu2R6Tq2y+3IA9Sxe2FOUQixCaMqVBEH55MsSyionsE46ZNL+/jPffVgOyMv3J0/cIIJpnry2SeWNI5wlRtjCY7hiif4skO83jVQj9QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ToUc1p4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso1514979276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563304; x=1729168104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuP8Dw+VpWRcprLt/X+HiKdbyXuiqtG6Iu2yHIJSWwU=;
        b=2ToUc1p4Kl3mw31cB49oESpiIxPlVhdJb4mRkw0tanX3vY0/+D9iMHKbYtSP7nEh2i
         qSASo4KWRQE5ld3zA0PAsBy3xRJm7NqVNd1XFUPtjhHGKYhs3yOb2U8Tj2K17IyvLAJ1
         2vNc/5e6n3f9WkzUnUn1MyibmfMQf9Adc1okeTJPqBuH3ioKRnEMyWD2t8GRhJ89FGOY
         4RzDNN3206h1XsB9nsTUH/AdSAP9K77HPBynaXoX6RF2GT5fMDR+ynqo4KpjZShmpPJS
         RVVoXuEzDVaMno0esQBXHhcRHZarB2YWBHQJxJ5xxPXQNNfOx1Y9LbW5LoC2hhFc/ZWR
         DSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563304; x=1729168104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuP8Dw+VpWRcprLt/X+HiKdbyXuiqtG6Iu2yHIJSWwU=;
        b=YzbK/BymC81vFcj4BGtHycL/ehFKp+D1e+Vzh0ytu1AgIIMG8eG/WmsJLdG6Pnw7pT
         VrDTmdCM1ymh83ZBP6SNZbjbrvEPprZzt87uTvViOmWsUJ01gizq32UDU2o313ON+hUY
         4wvG3Fq1V4sXNbrdlAS+/bsUM6JJ9ZspkqWNO91G1KpAIVQ4G5AGVKg6EZQB4xMrGrjr
         Eq6bpAoqhK2yhOE8Vhd3a/qYrr0uw4GZ7gGOLOGI9ovR03dnehWWglC/dw9pelwZM45I
         3KA4e2dMTrdLDVyjx//RczExEgpydydDcbEmXUaqZvfw9bJyvvehUMh6TydCKvUV+R05
         mkVg==
X-Gm-Message-State: AOJu0YzAekNmTdE5+OrkDODfxfCHx+mw34MX1JPb3TAT0nvpJrs5MV1F
	mSfnmrcoJeJHtkbgyM03/9lSd+xW+Gn3KxXVW1Y298WyJxG+Nc4eh9T3s0DBV6JFgvGgL8aKX4x
	+0AqN2UZ5EVMe7gGM3MxzSS1Mj+oaUouyjfxzPXwMiV3Zv4tizuuTLabQgn64gGyd3/QqsfXo8f
	YFr3XbKKtFLqBI5oZzghB205OlSbwBhA==
X-Google-Smtp-Source: AGHT+IHL+aSBpZQ8XgGYGpH0O9CURph9tagSzDdjdDu89XN4DeeMFZXywYndZAwf/GPPkkHqRxOiKyoU
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5b:312:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e28fe33aed1mr4678276.4.1728563303096; Thu, 10 Oct 2024 05:28:23
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:06 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=ardb@kernel.org;
 h=from:subject; bh=NRgY3UMAuDIJTAcx2+Y8d13RXHmPxwHdPW9+1ltPrDw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RMS9+3HyUVxz3N6rFic4/86um9+3/smqyr/zTgncZ
 Zo+yetsRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIqxUM/wPfJZ9NNS48fad3
 z8LWxz+ElmpIu7zdPqu+Zt7CeZ/qNXsYGV4nxAswx5UceSYy9bxb+me/sxyZ5Rs5/+us4FRYvUT 7Ez8A
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-11-ardb+git@google.com>
Subject: [PATCH v2 4/5] crypto: x86/crc32c - Use idiomatic relative jump table
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
2.47.0.rc0.187.ge670bccf7e-goog


