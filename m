Return-Path: <linux-kernel+bounces-539552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE43A4A5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BFF3B900E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFE1DE4DE;
	Fri, 28 Feb 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jxtBK+Wz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39361ABED9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781265; cv=none; b=if3dUF9M/fTmVmNBc0njISa8pWMwWkw9N0xG7IpWABjTNQctmZ8bUVMxBTzl4Ac96LUsmRdzXsoA5HYkkqWr4EKR7EnORtsCUQsKxlWypnd5H7nhpUt6FC9SvoBMyl83wAE8g4cRLnMzcLdmIAEH3YfKF0CwlmYAlo70SD8tQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781265; c=relaxed/simple;
	bh=j1VnY5JlHOaAeNiX9DK4TtYZG830XjFoBmkyG3Xva/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R00CwSdZlCMCWMU/DTUgfB/8Ci3andZNeRKHtCPJM8enmpIVgVtu6iWBdnpnWYgTV1W3bMpregLZ+3UFnPJw7PlJxx0juwnh7dQwRCKoEW9SQkPPNz9qhZarI4O1fP3pSvBFsaL4HdDNgUuquj3sJ3AsEzXTIocGk0rIKCqWJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jxtBK+Wz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 581FF40E015E;
	Fri, 28 Feb 2025 22:20:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iuAzjFlbE2Pw; Fri, 28 Feb 2025 22:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740781254; bh=5/+eZ8tc2g0nlcFt/aAYA8NlZPwIBAqq3po6qJUjO54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxtBK+WzeX8MJ51p8u3Omy0c39Ad+zgo4oQVFdZEZ+327HP4+U+H5KNG1XgcHL/nO
	 vLStCZz1d275xPxHZMeFHbogMfnepbgn754xywcm5RgOJPNkPBdpq3ouhIVm7+hWS3
	 p7Njt/G6rKNCMEos7mGH2FYKhLWYlPHGsOMU2EELp+4+FSw7tLdtdDv/t8cXkcGCSI
	 JBG/ciAgHw4AIGoaynSQ+FimM8IwOT1A5D0QBaOhzjJQghf8odSLKoCufYs9QrGONJ
	 QIC8Xrs6+bFa+w4jS7HrCMeikxB2cTGRgJ1N8fETZxw/A9Ttek8fYIkDbaPHiLegLZ
	 Hs8fbcCLpwy+kxilEvrFjV+3Sph14T5eNGTWGU6XsJOlb8XDe163dsCt08DoVdF04O
	 lMa0JgjnxhAqP6WcSZBbmWnR2hs8vF1i/IId1Z12DMXfElg25uoRCMdQWKoLkIDArp
	 rS+R3uAeAjjhm//9IUcXICcL0w3hsEYM1fkMi/FXfWq2DPBTJl2SrFsp702nwozZPU
	 uzeADin0KOZK6maG84ApVH/pqqFZBVsAENQ93a1b3TJlyQafODhUOYZYgr2NTIls3d
	 LCOxq2zZFUKGt4lKgGuoQzkaICsJYmavkEP6fk/o8HirhwvxgdWrh0a9p1A6oxCZ0S
	 tiOcBqZsNOuHOcgZsYnVGFUY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9289A40E0028;
	Fri, 28 Feb 2025 22:20:37 +0000 (UTC)
Date: Fri, 28 Feb 2025 23:20:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 05/13] x86/mm: use INVLPGB in flush_tlb_all
Message-ID: <20250228222032.GHZ8I2sNGMZGTjNPxI@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-6-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-6-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:40PM -0500, Rik van Riel wrote:
> The flush_tlb_all() function is not used a whole lot, but we might
> as well use broadcast TLB flushing there, too.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/mm/tlb.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Edits ontop:

--- /tmp/current.patch	2025-02-28 23:18:51.670490799 +0100
+++ /tmp/0001-x86-mm-Use-INVLPGB-in-flush_tlb_all.patch	2025-02-28 23:17:48.590844991 +0100
@@ -1,22 +1,23 @@
+From 5bdf59c0589b71328bd340ea48a00917def62dc0 Mon Sep 17 00:00:00 2001
 From: Rik van Riel <riel@surriel.com>
 Date: Tue, 25 Feb 2025 22:00:40 -0500
-Subject: x86/mm: Use INVLPGB in flush_tlb_all
+Subject: [PATCH] x86/mm: Use INVLPGB in flush_tlb_all()
 
-The flush_tlb_all() function is not used a whole lot, but we might
-as well use broadcast TLB flushing there, too.
+The flush_tlb_all() function is not used a whole lot, but it might as
+well use broadcast TLB flushing there, too.
+
+  [ bp: Massage, restore balanced if-else branches in the function,
+    comment some. ]
 
 Signed-off-by: Rik van Riel <riel@surriel.com>
 Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
-Tested-by: Manali Shukla <Manali.Shukla@amd.com>
-Tested-by: Brendan Jackman <jackmanb@google.com>
-Tested-by: Michael Kelley <mhklinux@outlook.com>
 Link: https://lore.kernel.org/r/20250226030129.530345-6-riel@surriel.com
 ---
- arch/x86/mm/tlb.c | 10 +++++++++-
- 1 file changed, 9 insertions(+), 1 deletion(-)
+ arch/x86/mm/tlb.c | 17 +++++++++++++++--
+ 1 file changed, 15 insertions(+), 2 deletions(-)
 
 diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
-index f44a03bca41c..a6cd61d5f423 100644
+index 5c44b94ad5af..f49627e02311 100644
 --- a/arch/x86/mm/tlb.c
 +++ b/arch/x86/mm/tlb.c
 @@ -1064,7 +1064,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -27,22 +28,29 @@ index f44a03bca41c..a6cd61d5f423 100644
  static void do_flush_tlb_all(void *info)
  {
  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-@@ -1074,6 +1073,15 @@ static void do_flush_tlb_all(void *info)
+@@ -1074,7 +1073,21 @@ static void do_flush_tlb_all(void *info)
  void flush_tlb_all(void)
  {
  	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
+-	on_each_cpu(do_flush_tlb_all, NULL, 1);
 +
 +	/* First try (faster) hardware-assisted TLB invalidation. */
 +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
++		/*
++		 * TLBSYNC at the end needs to make sure all flushes done
++		 * on the current CPU have been executed system-wide.
++		 * Therefore, make sure nothing gets migrated
++		 * in-between but disable preemption as it is cheaper.
++		 */
 +		guard(preempt)();
 +		invlpgb_flush_all();
-+		return;
++	} else {
++		/* Fall back to the IPI-based invalidation. */
++		on_each_cpu(do_flush_tlb_all, NULL, 1);
 +	}
-+
-+	/* Fall back to the IPI-based invalidation. */
- 	on_each_cpu(do_flush_tlb_all, NULL, 1);
  }
  
+ /* Flush an arbitrarily large range of memory with INVLPGB. */
 -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

