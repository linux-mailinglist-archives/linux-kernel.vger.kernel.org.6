Return-Path: <linux-kernel+bounces-541283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C0BA4BAEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28D618928BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C11F0E48;
	Mon,  3 Mar 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nHXOmRAY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103981DE2DE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994701; cv=none; b=ATnC19FVgnInP3hX7NiAKQhdH6r/Q8uIYnIJ3w+6yz1L43acclVnkoyvKfAfdOZGRBzwKacXA5kWKaJZm34Ca/H6IHwGewjz0X9caIBX3K0/NYZgYygIw1gLLSZ+M7R9DcAss4u4bhT07kNdrs/pp0T8BvDUSf/hHaT3OSRkHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994701; c=relaxed/simple;
	bh=372WipmenTelVADkpfnxjy0MQqzhMECRW46r6vykgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WxfWEMQDdN+y8TPSogm1wL1crH2R1dU/aF85de0KAxvztYkGSwyR9aQu+uRtEauacyhxqZc+b4ku7v0yY7lroJ5VgVDCzBbBVEi6xhAP1+rzgY3vYtJ/AfqS+kXfhhZa9kynoYeK7lJhZVBMjMt3CdoqH0DI61KGZXh4L3Vm+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nHXOmRAY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Npt65TT2ZbEKjv0bjPKHuBVkCN3qo6WltfFotXxv/x8=; b=nHXOmRAY182bkUplsIrtOKyAQ8
	92prz17agEmJVFiSdHup2VguUUmYFAa8vdp4hwgOXadpgPaNMez51mtDXRaZCpS+YcWfro369jZSs
	F9Rl20z4TJu5Fah/IqXSz/xFtKGp+rXUtLbCnLA+E665Syx8Dz0xC0BPjwXcEVsFSPI7udNKShHMu
	BNrXo///xwE0UqLqTfM/VWq5m2tLC3GSRJzGYaIBfJ9XiDXfMecYC+Zw+CnxPeU1ceY7+1wyBN4p4
	ZU+4Y8i8zXWNrmm3sgqG4rnW92WfOtTP2VbEcx16YUvisB4ehrk/3nnuuqM9aA6Fl7cTDxw4Lzgd6
	+8g0001A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp2Fe-0000000BPlm-19uk;
	Mon, 03 Mar 2025 09:38:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78C5A30057E; Mon,  3 Mar 2025 10:38:17 +0100 (CET)
Date: Mon, 3 Mar 2025 10:38:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Subject: lkdtm: Annotate do_nothing()
Message-ID: <20250303093817.GJ5880@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

During my FineIBT testing the other week I stumbled upon the following
complaint:

  vmlinux.o: warning: objtool: execute_location+0x4f: relocation to !ENDBR: .text+0x1032008

I finally got around to looking at it and realized we have means of
annotating that since 93f16a1ab78c ("x86/boot: Mark start_secondary() with __noendbr")
(which might still be in tip only).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 5b861dbff27e..9600af4494d8 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -36,6 +36,7 @@ static noinline void do_nothing(void)
 {
 	return;
 }
+ANNOTATE_NOENDBR_SYM(do_nothing);
 
 /* Must immediately follow do_nothing for size calculuations to work out. */
 static noinline void do_overwritten(void)

