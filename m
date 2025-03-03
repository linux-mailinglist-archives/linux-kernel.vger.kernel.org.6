Return-Path: <linux-kernel+bounces-541351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82408A4BBD9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A6F7A5696
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F521EE017;
	Mon,  3 Mar 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UXAvkE01"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F861DB551
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997036; cv=none; b=CZQjEPrnQoYG2SkqcpKVr43BivRxMp5xkiFJtHpPHGW1J6/XM86Q7ec2TSly0tokQ4kwIX2P3A8FyPqze+SYQ35b1QK8diOmxOnYXOyGyHT4b9XvFSqALit1A2cG60lLDWPoDYabLyKqj4CjqaFuWsIrd/INrCGLmatDMBEXUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997036; c=relaxed/simple;
	bh=IPcmz/Ophfu4H2fHVFRaf/4NO1aPTZiB1jFWbsY4VJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nexe7GrY7DoxIG9N2uk2XPkywFByamX92eYf0ShU7tDUderhLE3OpO+GtJzCDU+3gPg9bJflPH8RUMOxOV9pZ4XalSXCGvwLLxB4kWR0DGJznms2bEKxjiGcSb4I3WgF91dFpA5bo5kHHWDKdeN4u1+kY2Gm0bH8CFk4nGFwpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UXAvkE01; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D28640E0202;
	Mon,  3 Mar 2025 10:17:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bKFAI4kJqnOJ; Mon,  3 Mar 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740997024; bh=/T0jAtQw2ziyIRYjhPBximB345bKPYtbcsbnKNs9H3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXAvkE01IkdKwazAXwV/pp3KJw9vaBpwc+EZbw3VpkFbVdFcOhfIsKbIPbqheUm87
	 BJLVKwKluj+oWUVUNisfoSb/L8UPi2ranJcIWn5FqETo4hoqCvI7+/yEWxeXS2l7Fh
	 c56nm5ovL7PzHgOZSyKoUw2dmH2SHQVZVRosdOWunSziqmBF9krMH7WZLl3uXKSSbV
	 wf2kkHo9s0Rq/u+0x5j8HNMY6Y3daCdoASNNOYCInoOnet4aBzuR1x3eoH1omwB6ke
	 cmhHN32AahpGV0bBd0pX/rITM6zvC+WjMy9tnuuaIsKERDBCtiEv+P3TtC5p3QaHEk
	 p4RlgVQ41Yvq+IQ8/ei7Xz/FSausGb4CxblDsNUwbW5JDgOQxjZ764clOpof9OZLeb
	 aB68XJqRKYXuIstJQhs4+S75C9mPViLQYU/s95/gSkrqH5rFqGebU8HP6WPDB4BnbD
	 JbQawXEd2ewT9aj5JyJBBPDxMFXsoUfgC4ve5p3sv1fohqrdJ095yYcY/ZWQ11UouX
	 9GYldv6T/vQui+sbJ+gKWGgw8Qnq1aztr5QqvyzcXmfdltwqXbj6PbY7PUsq49G2Sr
	 wc9ei7jcN/5D2L8c2nuwt9vomNqVvYDbfn4g1UGJ7xkm153mt8XB9S6Dpc0tne1vnh
	 j6DlnEd0FcKQsZt781YnDr4g=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 489BB40E0214;
	Mon,  3 Mar 2025 10:16:47 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:16:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 09/13] x86/mm: global ASID process exit helpers
Message-ID: <20250303101640.GAZ8WBiPNKG_4wkVDv@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-10-riel@surriel.com>
 <20250302123838.GKZ8RRTgRxvBSry6mk@fat_crate.local>
 <683d34253e2bdef9f74d8c44b2eff7ae9cfea5f9.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <683d34253e2bdef9f74d8c44b2eff7ae9cfea5f9.camel@surriel.com>

On Sun, Mar 02, 2025 at 08:53:10AM -0500, Rik van Riel wrote:
> I've been there. Repeatedly :)

Yap, it is. And despite all the compile-time disabling fun, clang still can't
do proper DCE and complains about the inline asm in __invlpgb() using a u64 on
32-bit builds.

So I did the fix below, ontop and with that randconfig builds all pass fine.

What I have so far is here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-cpu-tlbi

Lemme go through the rest of your patches now.

Thx.

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 5375145eb959..04f2c6f4cee3 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -29,6 +29,7 @@ static inline void invlpg(unsigned long addr)
 }
 
 
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
 /*
  * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
  *
@@ -74,6 +75,14 @@ static inline void __tlbsync(void)
 	/* TLBSYNC: supported in binutils >= 0.36. */
 	asm volatile(".byte 0x0f, 0x01, 0xff" ::: "memory");
 }
+#else
+/* Some compilers simply can't do DCE */
+static inline void __invlpgb(unsigned long asid, unsigned long pcid,
+			     unsigned long addr, u16 nr_pages,
+			     bool pmd_stride, u8 flags) { }
+
+static inline void __tlbsync(void) { }
+#endif
 
 /*
  * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

