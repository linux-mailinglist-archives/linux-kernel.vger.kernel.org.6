Return-Path: <linux-kernel+bounces-545250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BAA4EACE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B8A19C24EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2627BF88;
	Tue,  4 Mar 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nHXOmRAY"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26961F4161
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110415; cv=pass; b=ICCwe4J8IkvSM4iHsagSJsskmHpYGnl6yAfgA3Fv6U9mFTLNZcY50VIbqjw1DzvYGJ14GcCK+3naoUIthjlXx1kfKFhmGYWvzIRugdDt9ArR5BWF84PTo7D0zAAw8Hgeq+tNj3N4bvPB1DokKclG2xxPmxbnRppIJ5T2AbRQJv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110415; c=relaxed/simple;
	bh=372WipmenTelVADkpfnxjy0MQqzhMECRW46r6vykgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBW8DWHcbb9wQojrVYUFGAllScZzQPSv44FroqWwmcRmRajb+3vZWKw6J3zQT4tGFBcAx49dgQv22XqBA+yNgFVtQWvXAsLnmDQRQwyG42GHvATkeVyE8f9cRtr83s1loPH/VKhFoPNZ2ZMWE8W4f1cTRHixsCsHbVTfujOD4Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nHXOmRAY; arc=none smtp.client-ip=90.155.50.34; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 50B7140D204D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:46:52 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nHXOmRAY
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fVX6BVszG06Y
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:19:32 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 32B8342720; Tue,  4 Mar 2025 18:19:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nHXOmRAY
X-Envelope-From: <linux-kernel+bounces-541283-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nHXOmRAY
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 66CE64378E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:38:34 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 03A493064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:38:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7ABE3B25AE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E71F131A;
	Mon,  3 Mar 2025 09:38:24 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fVX6BVszG06Y
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715095.39362@VV7xtdncli/QYAJVdE0diA
X-ITU-MailScanner-SpamCheck: not spam

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


